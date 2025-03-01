namespace Plugins
{
	using System;
	using System.IO;
	using System.Reflection;
	using System.Collections;
	using System.Runtime.Serialization;
	
	/// <summary>
	/// This class is created inside the new appdomain and is used to locate the 
	/// types available for loading within the assembly. It is required to inherit
	/// MarshByRefObject to be marshallable across AppDomains allowing the plugin 
	/// Assembly to be fully remotely loaded.
	/// </summary>
	public class AssemblySnooper : MarshalByRefObject
	{
		/* this structures is fully seriazable because it will be passed between
		 * appdomains, it details the path (FullyQualifiedName) of the module that
		 * contains the type and the full type name (TypeFullName) of the implementing
		 * type inside that assembly.
		 */
		[Serializable]
		public struct LoadableType
		{
			public string FullyqualifiedName;
			public string TypeFullName;

			public LoadableType(string fqn, string name)
			{
				this.FullyqualifiedName = fqn;
				this.TypeFullName = name;
			}
		}

		// a public constructor is required for remote instantiation
		public AssemblySnooper(){}


		/* This method is an instance method because it is designed to be
		 * run in a separate appdomain. It loads the assembly and then attempts
		 * to find publicly visible instantiable types which implement the 'find'
		 * interface. Each one located is stored in a LoadableType struct for returning
		 * to the calling appdomain
		 */
		public LoadableType[] LocatePlugins(string assemblypath,Type find)
		{
			LoadableType[] retval = null;
			ArrayList types = new ArrayList();
			if (File.Exists(assemblypath))
			{
				Assembly file = Assembly.LoadFrom(assemblypath);
				foreach(Type type in file.GetTypes())
				{
					bool implements = false;
					foreach(Type inter in type.GetInterfaces() )
					{
						if (inter == find)
						{
							implements = true;
							break;
						}
					}
					if (
						implements &&
						type.IsPublic &&			// publicly visible
						!type.IsAbstract 			// is instantiable
						)
					{
						types.Add(new LoadableType(type.Module.FullyQualifiedName,type.FullName));
					}
				}
				if (types.Count>0)
				{
					retval = (LoadableType[])types.ToArray(typeof(LoadableType));
				}
			}
			types=null;
			return retval;
		}

		
		public static ArrayList LoadContainingAssembliesFromDirectory(string dirname,Type type)
		{
			string exepath = System.Reflection.Assembly.GetEntryAssembly().Location;
			string apppath = Path.GetDirectoryName(exepath);
			string pluginpath = Path.Combine(apppath,dirname);
			string pluginname  =null;
			ArrayList retval = null;
			
			if (
				dirname!=null &&
				dirname.IndexOfAny(Path.InvalidPathChars)==-1 &&
				Directory.Exists(pluginpath)
				)
			{
				ArrayList list = new ArrayList();
				LoadableType[] loadable;
				pluginname = System.IO.Path.GetFileNameWithoutExtension(exepath);

				AppDomainSetup setup = new AppDomainSetup();
				setup.ApplicationBase = apppath;
				setup.PrivateBinPath = pluginpath;
				setup.ApplicationName = pluginname;

				AppDomain domain = null;
				try 
				{
					domain = AppDomain.CreateDomain(pluginname, null, setup);

					foreach (string name in Directory.GetFiles(pluginpath,"*.dll"))
					{
						loadable = null;

						AssemblySnooper remote = (AssemblySnooper)domain.CreateInstanceFromAndUnwrap(
							typeof(AssemblySnooper).Module.Name ,
							typeof(AssemblySnooper).FullName
							);

						try
						{
							loadable = remote.LocatePlugins(Path.Combine(pluginpath,name),type);
						}
						catch (SerializationException)
						{
							continue;
						}

						if (loadable!=null)
						{
							foreach(LoadableType lt in loadable)
							{
								list.Add(lt);
							}
						}
					}
				}
				finally
				{
					if (domain!=null)
					{
						AppDomain.Unload(domain);
					}
					domain=null;
				}

			
				if (list.Count>0)
				{
					retval = new ArrayList();
					ArrayList assemblies = new ArrayList(list.Count);
					foreach (Assembly asm in AppDomain.CurrentDomain.GetAssemblies())
					{
						foreach (Module mod in asm.GetModules())
						{
							if (!assemblies.Contains(mod.FullyQualifiedName))
							{
								assemblies.Add(mod.FullyQualifiedName);
							}
						}
					}
					
					foreach (LoadableType load in list)
					{
						if (!assemblies.Contains(load.FullyqualifiedName))
						{
							Assembly.LoadFile(load.FullyqualifiedName);
						}
						object newtype = (object)AppDomain.CurrentDomain.CreateInstanceFromAndUnwrap(
							load.FullyqualifiedName,
							load.TypeFullName 
							);
						retval.Add(newtype);
					}

					assemblies.Clear();
				}
			}

			return retval;

		}

	}
}
