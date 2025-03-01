#define WINDOWS
namespace GUI
{
	using System;
	using System.Reflection;
	using System.IO;

	using Amx.Core;

	using Files;
	using Files.Amx;

	//using Plugins;

	using System.Windows.Forms;
	using GUI;

	

	public sealed class Start
	{
		[STAThread]
		public static void Main(string[] args)
		{
			bool apprun = true;
			bool apprunoverride = false;

			//Console.WriteLine("test");

			for (int i=0;i<args.Length;i++)
			{
				if (args[i]!=null && args[i].Length >0)
				{
					if (string.Compare(args[i],"-e",true)==0 || string.Compare(args[i],"/e",true)==0 )
					{
						i+=1;
						int eaten = Export(args, i);
						if (eaten>0)
						{
							i+=eaten;
							if (!apprunoverride)
							{
								apprun=false;
								continue;
							}
						}
					}

					if (string.Compare(args[i],"/run")==0 || string.Compare(args[i],"-run")==0)
					{
						apprunoverride=true;
						apprun=true;
					}

					if (string.Compare(args[i],"/?")==0 || string.Compare(args[i],"/h") ==0 )
					{
						Help();
						if (!apprunoverride)
						{
							apprun=false;
							continue;
						}
						continue;
					}
				}
			}

			if (apprun)
			{
				Application.Run(new MainForm());
			}
		}


		public static int Export(string[]args, int index)
		{
			int eaten = 0;
			string path = null;
			string output = null;
			bool pathvalid=false;
			string bitsstr = null;
			bool bitsdefaulted=true;
			Bits bits = Bits._32;
			string apppath = Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);

			for (int i=index; i<args.Length ;i++)
			{
				if (path==null)
				{
					string name = args[i];
					if (name.LastIndexOfAny (Path.InvalidPathChars)==-1)
					{
						path = Path.Combine(apppath,name);
						if (File.Exists(path))
						{
							eaten+=1;
							pathvalid=true;
							continue;
						}
						else
						{
							pathvalid=false;
							path=null;
							break;
						}
					}
				} 
				if (bitsstr==null)
				{
					bitsstr = args[i];
					switch (bitsstr)
					{
						case "64":
						case "64bit":
							eaten+=1;
							bits=Bits._64;
							bitsdefaulted=false;
							break;
						case "32":
						case "32bit":
							eaten+=1;
							bits=Bits._32;
							bitsdefaulted=false;
							break;
						default:
							bits= Bits._32;
							bitsdefaulted=true;
							break;
					}
					break;
				}
			}

			if (!pathvalid)
			{
				string insert = "";
				if (path!=null)
				{
					insert = "\""+ path.ToString() + "\" ";
				}
				MessageBox.Show("input path " + insert + "is not valid",
					"Export error, invalid path",
					MessageBoxButtons.OK,
					MessageBoxIcon.Error);
				goto end;
			}

			output = Path.GetDirectoryName(path) + Path.DirectorySeparatorChar + Path.GetFileNameWithoutExtension(path) + bits.ToString() + ".ramx";

			if (File.Exists(output))
			{
				File.Delete(output);
			}

			string selectedext = Path.GetExtension(path).ToLower();
			IFiletype provider = null;
			IFiletype[] types = Helpers.LoadFiletypes("filetypes");

			if (types!=null)
			{
				foreach (IFiletype type in types)
				{
					if (string.Compare(type.Extension,selectedext,true)==0)
					{
						provider = type;
						break;
					}
				}
			}

			if (provider==null)
			{
				MessageBox.Show("No filetype provider could be located for the extension "+selectedext+Environment.NewLine +"The file could not be exported.","Export failure",MessageBoxButtons.OK,MessageBoxIcon.Error);
				goto end;
			}

			IAmxInstance file = null;
			IAmxContainer container = provider.GetContainer(path);

			if (container==null)
			{
				MessageBox.Show("The file selected is not valid");
				goto end;
			}

			switch (container.Count)
			{
				case 0:
					file = null;
					break;
				case 1:
							
					if (container is IAmxInstance)
					{
						file = (IAmxInstance)container;
					}
					break;
				default:
					if (bitsdefaulted && container.Count>1)
					{
						Console.WriteLine("file contains multiple amx files, a valid bitlength must be specified");
					}
					else
					{
						foreach(IAmxDescription d in container)
						{
							if (d.Bits==bits)
							{
								file = container.GetFile(d);
							}
						}
					}
					break;
			}
			

			if (file!=null)
			{
				AmxHelpers.ExportFile(file,output);
			}
			else
			{
				MessageBox.Show("The selected description coudl not be located in the file specified");
				goto end;
			}
			
end:
			return eaten;
		}
	


		#region oldcode

				/*
				if (!File.Exists(output))
				{
					IAmxInstance file=null;
					IAmxContainer container=null;
					switch (Path.GetExtension(path).ToLower())
					{
						/*case ".amx":
							file = new AmxFile(path,bits);
							break;
						case ".amxx":
							container = new AmxxFile(path);
							if (bitsdefaulted && container.Count>1)
							{
								Console.WriteLine("file contains multiple amx files, a valid bitlength must be specified");
							}
							else
							{
								foreach(IAmxDescription d in container)
								{
									if (d.Bits==bits)
									{
										file = container.GetFile(d);
									}
								}
							}
							break;
							
						default:
							Console.WriteLine("unknown amx container format extension");
							break;
					}
					container=null;
					if (file!=null && file.Valid)
					{
						BinaryWriter writer=null;
						AmxStream reader=null;
						try 
						{
							writer = new BinaryWriter(File.OpenWrite(output));
							reader = file.GetStream();

							writer.Write(reader.ReadBytes(file.Length));
						}
						catch (Exception e)
						{
							Console.WriteLine("an exception occured: ");
							Console.WriteLine(e.Message);
							Console.WriteLine(e.StackTrace);
						}
						finally
						{
							if (writer!=null)
							{
								writer.Flush();
								writer.Close();
								writer=null;
							}
							if (reader!=null)
							{
								reader.Close();
								reader=null;
							}
						}
						file=null;				
					}
					else
					{
						Console.WriteLine("the input file is not a valid amx container format");
					}

				}
				else
				{
					Console.WriteLine("output file name for export already exists");
				}				
			}
			else
			{
				Console.WriteLine("input file name for export does not exist");
			}
			

			return eaten;
		}
		*/
		#endregion


		public static void Help()
		{
			string message = 
@"
/run  
  Will force the windows forms UI to be run even if other arguments
  are specified which normally preclude the user interface being shown

/e <file> [64bit|32bit]
  Will export the amx file contained in the <file> argument to the file 
  <file>_<bits>.ramx in the same location as the input file. The output
  is a raw uncompressed amx file, this means that the headers may not be
  correct for loading as a valid virtual machine.

/? /h
  Displays this help dialogue
";
			Console.WriteLine(message);
			//MessageBox.Show(message,"AmxReader commandline arguments",MessageBoxButtons.OK,MessageBoxIcon.Information);
		}
	}
}