using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.IO;
using System.Text;
using System.Reflection;

using Amx.Ops;
using Amx.Core;
using Amx.Cod;
using Amx.Dat;

using Files;
using View;
using Plugins;

using Files.Amx;

namespace GUI
{
	public class MainForm : System.Windows.Forms.Form
	{
		private const string TitlePrefix = "AMX Disassembler ";
		private Ops ops;
		private Options options;
		private Disassembly disassembly;
		private IAmxInstance file;
		private IAmxContainer container;
		private IDisassemblyView view;
		private IDisassemblyView[] views;
		private IFiletype[] types;
		private FindForm find;

		#region form variables

		private System.Windows.Forms.MenuItem FileMenu_Root;
		private System.Windows.Forms.MenuItem FileMenu_Open;
		private System.Windows.Forms.MenuItem FileMenu_Close;
		private System.Windows.Forms.MenuItem HelpMenu_Root;
		private System.Windows.Forms.MenuItem HelpMenu_About;
		private System.Windows.Forms.Splitter baseSplitter;
		private System.Windows.Forms.Splitter instructionRightSplitter;
		private System.Windows.Forms.Splitter infoResourceSplitter;
		private System.Windows.Forms.MenuItem EditMenu_Root;
		private System.Windows.Forms.MenuItem EditMenu_Find;
		private System.Windows.Forms.MenuItem EditMenu_Goto;
		private System.Windows.Forms.MenuItem OptionsMenu_Root;
		private System.Windows.Forms.MenuItem OptionsMenu_FormatOptions;
		private System.Windows.Forms.MenuItem OptionsMenu_Debug_Root;
		private System.Windows.Forms.MenuItem OptionsMenu_DebugOps_ShowAll;
		private System.Windows.Forms.MenuItem OptionsMenu_DebugOps_Separator;
		private System.Windows.Forms.MenuItem OptionsMenu_DebugOps_ShowLINE;
		private System.Windows.Forms.MenuItem OptionsMenu_DebugOps_ShowFILE;
		private System.Windows.Forms.MenuItem OptionsMenu_DebugOps_ShowSYMBOL;
		private System.Windows.Forms.MenuItem OptionsMenu_DebugOps_ShowSRANGE;
		private System.Windows.Forms.MenuItem OptionsMenu_DebugOps_ShowSYMTAG;
		private System.Windows.Forms.MenuItem OptionsMenu_DebugOps_ShowBOUNDS;
		private System.Windows.Forms.MenuItem OptionsMenu_ShowSource;
		private System.Windows.Forms.MenuItem OptionsMenu_ShowComments;
		private System.Windows.Forms.StatusBar statusBar;
		private System.Windows.Forms.OpenFileDialog openFileDialog;
		private System.Windows.Forms.MainMenu mainMenu;
		private System.Windows.Forms.RichTextBox instructionRichTextBox;
		private System.Windows.Forms.TreeView resourceTreeView;
		private System.Windows.Forms.RichTextBox infoRichTextBox;
		private System.Windows.Forms.StatusBarPanel statusPanel;
		private System.Windows.Forms.StatusBarPanel statusBarPanel1;
		private System.Windows.Forms.Timer statusTimer;
		private System.Windows.Forms.MenuItem OptionsMenu_ViewType_Root;
		private System.Windows.Forms.MenuItem EditMenu_Copy;
		private System.Windows.Forms.MenuItem EditMenu_selectAll;
		private System.Windows.Forms.MenuItem EditMenu_Separator1;
		private System.Windows.Forms.MenuItem EditMenu_Cut;
		private System.Windows.Forms.MenuItem EditMenu_Paste;
		private System.Windows.Forms.MenuItem FileMenu_Separator1;
		private System.Windows.Forms.MenuItem FileMenu_Exit;
		private System.Windows.Forms.MenuItem OptionsMenu_Separator1;
		private System.Windows.Forms.MenuItem OptionsMenu_WriteToFile;
		private System.Windows.Forms.MenuItem OptionsMenu_ExportToFile;
		private System.Windows.Forms.MenuItem OptionsMenu_Separator2;
		private System.ComponentModel.IContainer components;
		#endregion

		public MainForm()
		{
			InitializeComponent();
			options = new Options();
		}


		protected override void OnResize(EventArgs e)
		{
			base.OnResize (e);
		}

		protected override void OnLoad(EventArgs e)
		{
			base.OnLoad (e);
			string apppath = null;
			apppath = System.Reflection.Assembly.GetEntryAssembly().Location;
			apppath = apppath.Substring(0,apppath.LastIndexOf(@"\")+1);
			openFileDialog.InitialDirectory=apppath;
			ops = new Ops(apppath +"\\opcodes.txt");
			options.debugops.ShowSymtagOps=true;
			options.debugops.ShowSymbolOps=true;
			options.debugops.ShowSrangeOps=true;
			options.debugops.ShowLineOps=true;
			options.debugops.ShowFileOps=true;
			options.debugops.ShowCodeLines=true;
			options.debugops.ShowBoundsOps=true;
			Update_OptionsMenu_DebugOps();
			find=null;

			if (!ops.Valid)
			{
				UpdateStatus("opcode loading failed",-1);
				FileMenu_Open.Enabled=false;
			}

			types = Helpers.LoadFiletypes("filetypes");

			if (types!=null)
			{
				StringBuilder filter = new StringBuilder();
				foreach (IFiletype type in types)
				{

					if (filter.Length>0)
					{
						filter.Append('|');
					}
					filter.Append( type.FilterText );
					filter.Append('|');
					filter.Append(type.FilterMask);		

				}
				openFileDialog.Filter =filter.ToString();	
				filter=null;
			}

			views = Helpers.LoadViews("viewtypes");

			if (views!=null)
			{
				foreach (IDisassemblyView v in views)
				{
					MenuItem item = new MenuItem(v.Name,new EventHandler(OptionsMenu_ViewType_Item_Click));
					OptionsMenu_ViewType_Root.MenuItems.Add(item);
					if (OptionsMenu_ViewType_Root.MenuItems.Count==1)
					{
						item.PerformClick();
					}
				}
			}
			else
			{
				OptionsMenu_ViewType_Root.Enabled=false;
				OptionsMenu_FormatOptions.Enabled=false;
			}
			
			infoResourceSplitter.Tag = (double)((double)3/(double)5);
			instructionRightSplitter.Tag=(double)((double)4/(double)6);

			MainForm_Resize(null,EventArgs.Empty);
		}

		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}


		#region Windows Form Designer generated code

		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
			this.mainMenu = new System.Windows.Forms.MainMenu();
			this.FileMenu_Root = new System.Windows.Forms.MenuItem();
			this.FileMenu_Open = new System.Windows.Forms.MenuItem();
			this.FileMenu_Close = new System.Windows.Forms.MenuItem();
			this.FileMenu_Separator1 = new System.Windows.Forms.MenuItem();
			this.FileMenu_Exit = new System.Windows.Forms.MenuItem();
			this.EditMenu_Root = new System.Windows.Forms.MenuItem();
			this.EditMenu_Cut = new System.Windows.Forms.MenuItem();
			this.EditMenu_Copy = new System.Windows.Forms.MenuItem();
			this.EditMenu_Paste = new System.Windows.Forms.MenuItem();
			this.EditMenu_selectAll = new System.Windows.Forms.MenuItem();
			this.EditMenu_Separator1 = new System.Windows.Forms.MenuItem();
			this.EditMenu_Find = new System.Windows.Forms.MenuItem();
			this.EditMenu_Goto = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_Root = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_FormatOptions = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_Separator1 = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_ViewType_Root = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_ShowSource = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_Debug_Root = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_DebugOps_ShowAll = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_DebugOps_Separator = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_DebugOps_ShowLINE = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_DebugOps_ShowFILE = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_DebugOps_ShowSYMBOL = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_DebugOps_ShowSRANGE = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_DebugOps_ShowSYMTAG = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_DebugOps_ShowBOUNDS = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_ShowComments = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_Separator2 = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_WriteToFile = new System.Windows.Forms.MenuItem();
			this.OptionsMenu_ExportToFile = new System.Windows.Forms.MenuItem();
			this.HelpMenu_Root = new System.Windows.Forms.MenuItem();
			this.HelpMenu_About = new System.Windows.Forms.MenuItem();
			this.statusBar = new System.Windows.Forms.StatusBar();
			this.statusPanel = new System.Windows.Forms.StatusBarPanel();
			this.statusBarPanel1 = new System.Windows.Forms.StatusBarPanel();
			this.baseSplitter = new System.Windows.Forms.Splitter();
			this.instructionRichTextBox = new System.Windows.Forms.RichTextBox();
			this.instructionRightSplitter = new System.Windows.Forms.Splitter();
			this.resourceTreeView = new System.Windows.Forms.TreeView();
			this.infoResourceSplitter = new System.Windows.Forms.Splitter();
			this.infoRichTextBox = new System.Windows.Forms.RichTextBox();
			this.statusTimer = new System.Windows.Forms.Timer(this.components);
			((System.ComponentModel.ISupportInitialize)(this.statusPanel)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.statusBarPanel1)).BeginInit();
			this.SuspendLayout();
			// 
			// mainMenu
			// 
			this.mainMenu.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					 this.FileMenu_Root,
																					 this.EditMenu_Root,
																					 this.OptionsMenu_Root,
																					 this.HelpMenu_Root});
			// 
			// FileMenu_Root
			// 
			this.FileMenu_Root.Index = 0;
			this.FileMenu_Root.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																						  this.FileMenu_Open,
																						  this.FileMenu_Close,
																						  this.FileMenu_Separator1,
																						  this.FileMenu_Exit});
			this.FileMenu_Root.Text = "&File";
			// 
			// FileMenu_Open
			// 
			this.FileMenu_Open.Index = 0;
			this.FileMenu_Open.Text = "&Open";
			this.FileMenu_Open.Click += new System.EventHandler(this.FileMenu_Open_Click);
			// 
			// FileMenu_Close
			// 
			this.FileMenu_Close.Enabled = false;
			this.FileMenu_Close.Index = 1;
			this.FileMenu_Close.Text = "&Close";
			this.FileMenu_Close.Click += new System.EventHandler(this.FileMenu_Close_Click);
			// 
			// FileMenu_Separator1
			// 
			this.FileMenu_Separator1.Index = 2;
			this.FileMenu_Separator1.Text = "-";
			// 
			// FileMenu_Exit
			// 
			this.FileMenu_Exit.Index = 3;
			this.FileMenu_Exit.Text = "E&xit";
			this.FileMenu_Exit.Click += new System.EventHandler(this.FileMenu_Exit_Click);
			// 
			// EditMenu_Root
			// 
			this.EditMenu_Root.Index = 1;
			this.EditMenu_Root.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																						  this.EditMenu_Cut,
																						  this.EditMenu_Copy,
																						  this.EditMenu_Paste,
																						  this.EditMenu_selectAll,
																						  this.EditMenu_Separator1,
																						  this.EditMenu_Find,
																						  this.EditMenu_Goto});
			this.EditMenu_Root.Text = "&Edit";
			// 
			// EditMenu_Cut
			// 
			this.EditMenu_Cut.Index = 0;
			this.EditMenu_Cut.Text = "Cu&t";
			this.EditMenu_Cut.Click += new System.EventHandler(this.EditMenu_Cut_Click);
			// 
			// EditMenu_Copy
			// 
			this.EditMenu_Copy.Index = 1;
			this.EditMenu_Copy.Text = "&Copy";
			this.EditMenu_Copy.Click += new System.EventHandler(this.EditMenu_Copy_Click);
			// 
			// EditMenu_Paste
			// 
			this.EditMenu_Paste.Index = 2;
			this.EditMenu_Paste.Text = "&Paste";
			this.EditMenu_Paste.Click += new System.EventHandler(this.EditMenu_Paste_Click);
			// 
			// EditMenu_selectAll
			// 
			this.EditMenu_selectAll.Index = 3;
			this.EditMenu_selectAll.Text = "Select &All";
			this.EditMenu_selectAll.Click += new System.EventHandler(this.EditMenu_selectAll_Click);
			// 
			// EditMenu_Separator1
			// 
			this.EditMenu_Separator1.Index = 4;
			this.EditMenu_Separator1.Text = "-";
			// 
			// EditMenu_Find
			// 
			this.EditMenu_Find.Index = 5;
			this.EditMenu_Find.Text = "&Find";
			this.EditMenu_Find.Click += new System.EventHandler(this.EditMenu_Find_Click);
			// 
			// EditMenu_Goto
			// 
			this.EditMenu_Goto.Index = 6;
			this.EditMenu_Goto.Text = "&Goto";
			// 
			// OptionsMenu_Root
			// 
			this.OptionsMenu_Root.Index = 2;
			this.OptionsMenu_Root.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																							 this.OptionsMenu_FormatOptions,
																							 this.OptionsMenu_Separator1,
																							 this.OptionsMenu_ViewType_Root,
																							 this.OptionsMenu_ShowSource,
																							 this.OptionsMenu_Debug_Root,
																							 this.OptionsMenu_ShowComments,
																							 this.OptionsMenu_Separator2,
																							 this.OptionsMenu_WriteToFile,
																							 this.OptionsMenu_ExportToFile});
			this.OptionsMenu_Root.Text = "&Options";
			// 
			// OptionsMenu_FormatOptions
			// 
			this.OptionsMenu_FormatOptions.Index = 0;
			this.OptionsMenu_FormatOptions.Text = "Formatting Options";
			this.OptionsMenu_FormatOptions.Click += new System.EventHandler(this.OptionsMenu_FormatOptions_Click);
			// 
			// OptionsMenu_Separator1
			// 
			this.OptionsMenu_Separator1.Index = 1;
			this.OptionsMenu_Separator1.Text = "-";
			// 
			// OptionsMenu_ViewType_Root
			// 
			this.OptionsMenu_ViewType_Root.Index = 2;
			this.OptionsMenu_ViewType_Root.Text = "View Type";
			// 
			// OptionsMenu_ShowSource
			// 
			this.OptionsMenu_ShowSource.Index = 3;
			this.OptionsMenu_ShowSource.Text = "Show Source";
			this.OptionsMenu_ShowSource.Click += new System.EventHandler(this.OptionsMenu_ShowSource_Click);
			// 
			// OptionsMenu_Debug_Root
			// 
			this.OptionsMenu_Debug_Root.Index = 4;
			this.OptionsMenu_Debug_Root.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																								   this.OptionsMenu_DebugOps_ShowAll,
																								   this.OptionsMenu_DebugOps_Separator,
																								   this.OptionsMenu_DebugOps_ShowLINE,
																								   this.OptionsMenu_DebugOps_ShowFILE,
																								   this.OptionsMenu_DebugOps_ShowSYMBOL,
																								   this.OptionsMenu_DebugOps_ShowSRANGE,
																								   this.OptionsMenu_DebugOps_ShowSYMTAG,
																								   this.OptionsMenu_DebugOps_ShowBOUNDS});
			this.OptionsMenu_Debug_Root.Text = "Debug Ops";
			// 
			// OptionsMenu_DebugOps_ShowAll
			// 
			this.OptionsMenu_DebugOps_ShowAll.Index = 0;
			this.OptionsMenu_DebugOps_ShowAll.Text = "Show All Debug Ops";
			this.OptionsMenu_DebugOps_ShowAll.Click += new System.EventHandler(this.OptionsMenu_DebugOps_ShowAll_Click);
			// 
			// OptionsMenu_DebugOps_Separator
			// 
			this.OptionsMenu_DebugOps_Separator.Index = 1;
			this.OptionsMenu_DebugOps_Separator.Text = "-";
			// 
			// OptionsMenu_DebugOps_ShowLINE
			// 
			this.OptionsMenu_DebugOps_ShowLINE.Index = 2;
			this.OptionsMenu_DebugOps_ShowLINE.Text = "Show LINE Ops";
			this.OptionsMenu_DebugOps_ShowLINE.Click += new System.EventHandler(this.OptionsMenu_DebugOps_ShowLINE_Click);
			// 
			// OptionsMenu_DebugOps_ShowFILE
			// 
			this.OptionsMenu_DebugOps_ShowFILE.Index = 3;
			this.OptionsMenu_DebugOps_ShowFILE.Text = "Show FILE Ops";
			this.OptionsMenu_DebugOps_ShowFILE.Click += new System.EventHandler(this.OptionsMenu_DebugOps_ShowFILE_Click);
			// 
			// OptionsMenu_DebugOps_ShowSYMBOL
			// 
			this.OptionsMenu_DebugOps_ShowSYMBOL.Index = 4;
			this.OptionsMenu_DebugOps_ShowSYMBOL.Text = "Show SYMBOL Ops";
			this.OptionsMenu_DebugOps_ShowSYMBOL.Click += new System.EventHandler(this.OptionsMenu_DebugOps_ShowSYMBOL_Click);
			// 
			// OptionsMenu_DebugOps_ShowSRANGE
			// 
			this.OptionsMenu_DebugOps_ShowSRANGE.Index = 5;
			this.OptionsMenu_DebugOps_ShowSRANGE.Text = "Show SRANGE Ops";
			this.OptionsMenu_DebugOps_ShowSRANGE.Click += new System.EventHandler(this.OptionsMenu_DebugOps_ShowSRANGE_Click);
			// 
			// OptionsMenu_DebugOps_ShowSYMTAG
			// 
			this.OptionsMenu_DebugOps_ShowSYMTAG.Index = 6;
			this.OptionsMenu_DebugOps_ShowSYMTAG.Text = "Show SYMTAG Ops";
			this.OptionsMenu_DebugOps_ShowSYMTAG.Click += new System.EventHandler(this.OptionsMenu_DebugOps_ShowSYMTAG_Click);
			// 
			// OptionsMenu_DebugOps_ShowBOUNDS
			// 
			this.OptionsMenu_DebugOps_ShowBOUNDS.Index = 7;
			this.OptionsMenu_DebugOps_ShowBOUNDS.Text = "Show BOUNDS Ops";
			this.OptionsMenu_DebugOps_ShowBOUNDS.Click += new System.EventHandler(this.OptionsMenu_DebugOps_ShowBOUNDS_Click);
			// 
			// OptionsMenu_ShowComments
			// 
			this.OptionsMenu_ShowComments.Index = 5;
			this.OptionsMenu_ShowComments.Text = "Show Comments";
			this.OptionsMenu_ShowComments.Visible = false;
			this.OptionsMenu_ShowComments.Click += new System.EventHandler(this.OptionsMenu_ShowComments_Click);
			// 
			// OptionsMenu_Separator2
			// 
			this.OptionsMenu_Separator2.Index = 6;
			this.OptionsMenu_Separator2.Text = "-";
			// 
			// OptionsMenu_WriteToFile
			// 
			this.OptionsMenu_WriteToFile.Enabled = false;
			this.OptionsMenu_WriteToFile.Index = 7;
			this.OptionsMenu_WriteToFile.Text = "Write To File";
			this.OptionsMenu_WriteToFile.Click += new System.EventHandler(this.EditMenu_WriteToFile_Click);
			// 
			// OptionsMenu_ExportToFile
			// 
			this.OptionsMenu_ExportToFile.Enabled = false;
			this.OptionsMenu_ExportToFile.Index = 8;
			this.OptionsMenu_ExportToFile.Text = "Export To Raw Amx";
			// 
			// HelpMenu_Root
			// 
			this.HelpMenu_Root.Index = 3;
			this.HelpMenu_Root.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																						  this.HelpMenu_About});
			this.HelpMenu_Root.Text = "&Help";
			// 
			// HelpMenu_About
			// 
			this.HelpMenu_About.Index = 0;
			this.HelpMenu_About.Text = "&About";
			this.HelpMenu_About.Click += new System.EventHandler(this.HelpMenu_About_Click);
			// 
			// statusBar
			// 
			this.statusBar.Location = new System.Drawing.Point(0, 405);
			this.statusBar.Name = "statusBar";
			this.statusBar.Panels.AddRange(new System.Windows.Forms.StatusBarPanel[] {
																						 this.statusPanel,
																						 this.statusBarPanel1});
			this.statusBar.ShowPanels = true;
			this.statusBar.Size = new System.Drawing.Size(607, 18);
			this.statusBar.TabIndex = 8;
			// 
			// statusPanel
			// 
			this.statusPanel.AutoSize = System.Windows.Forms.StatusBarPanelAutoSize.Spring;
			this.statusPanel.Width = 491;
			// 
			// statusBarPanel1
			// 
			this.statusBarPanel1.Alignment = System.Windows.Forms.HorizontalAlignment.Right;
			// 
			// baseSplitter
			// 
			this.baseSplitter.Dock = System.Windows.Forms.DockStyle.Bottom;
			this.baseSplitter.Enabled = false;
			this.baseSplitter.Location = new System.Drawing.Point(0, 404);
			this.baseSplitter.Name = "baseSplitter";
			this.baseSplitter.Size = new System.Drawing.Size(607, 1);
			this.baseSplitter.TabIndex = 1;
			this.baseSplitter.TabStop = false;
			this.baseSplitter.Visible = false;
			// 
			// instructionRichTextBox
			// 
			this.instructionRichTextBox.Dock = System.Windows.Forms.DockStyle.Left;
			this.instructionRichTextBox.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.instructionRichTextBox.Location = new System.Drawing.Point(0, 0);
			this.instructionRichTextBox.Name = "instructionRichTextBox";
			this.instructionRichTextBox.Size = new System.Drawing.Size(415, 404);
			this.instructionRichTextBox.TabIndex = 3;
			this.instructionRichTextBox.Text = "";
			this.instructionRichTextBox.WordWrap = false;
			this.instructionRichTextBox.SelectionChanged += new System.EventHandler(this.instructionRichTextBox_SelectionChanged);
			// 
			// instructionRightSplitter
			// 
			this.instructionRightSplitter.Location = new System.Drawing.Point(415, 0);
			this.instructionRightSplitter.MinExtra = 150;
			this.instructionRightSplitter.MinSize = 150;
			this.instructionRightSplitter.Name = "instructionRightSplitter";
			this.instructionRightSplitter.Size = new System.Drawing.Size(3, 404);
			this.instructionRightSplitter.TabIndex = 4;
			this.instructionRightSplitter.TabStop = false;
			this.instructionRightSplitter.SplitterMoved += new System.Windows.Forms.SplitterEventHandler(this.instructionRightSplitter_SplitterMoved);
			// 
			// resourceTreeView
			// 
			this.resourceTreeView.Dock = System.Windows.Forms.DockStyle.Top;
			this.resourceTreeView.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.resourceTreeView.HideSelection = false;
			this.resourceTreeView.ImageIndex = -1;
			this.resourceTreeView.Location = new System.Drawing.Point(418, 0);
			this.resourceTreeView.Name = "resourceTreeView";
			this.resourceTreeView.SelectedImageIndex = -1;
			this.resourceTreeView.Size = new System.Drawing.Size(189, 220);
			this.resourceTreeView.TabIndex = 5;
			// 
			// infoResourceSplitter
			// 
			this.infoResourceSplitter.Dock = System.Windows.Forms.DockStyle.Top;
			this.infoResourceSplitter.Location = new System.Drawing.Point(418, 220);
			this.infoResourceSplitter.Name = "infoResourceSplitter";
			this.infoResourceSplitter.Size = new System.Drawing.Size(189, 3);
			this.infoResourceSplitter.TabIndex = 6;
			this.infoResourceSplitter.TabStop = false;
			this.infoResourceSplitter.SplitterMoved += new System.Windows.Forms.SplitterEventHandler(this.infoResourceSplitter_SplitterMoved);
			// 
			// infoRichTextBox
			// 
			this.infoRichTextBox.Dock = System.Windows.Forms.DockStyle.Fill;
			this.infoRichTextBox.Font = new System.Drawing.Font("Courier New", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.infoRichTextBox.Location = new System.Drawing.Point(418, 223);
			this.infoRichTextBox.Name = "infoRichTextBox";
			this.infoRichTextBox.Size = new System.Drawing.Size(189, 181);
			this.infoRichTextBox.TabIndex = 7;
			this.infoRichTextBox.Text = "";
			// 
			// statusTimer
			// 
			this.statusTimer.Tick += new System.EventHandler(this.statusTimer_Tick);
			// 
			// MainForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(607, 423);
			this.Controls.Add(this.infoRichTextBox);
			this.Controls.Add(this.infoResourceSplitter);
			this.Controls.Add(this.resourceTreeView);
			this.Controls.Add(this.instructionRightSplitter);
			this.Controls.Add(this.instructionRichTextBox);
			this.Controls.Add(this.baseSplitter);
			this.Controls.Add(this.statusBar);
			this.Menu = this.mainMenu;
			this.MinimumSize = new System.Drawing.Size(400, 300);
			this.Name = "MainForm";
			this.Text = "AMX Disassembler";
			this.Resize += new System.EventHandler(this.MainForm_Resize);
			((System.ComponentModel.ISupportInitialize)(this.statusPanel)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.statusBarPanel1)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion

		private void MainForm_Resize(object sender, System.EventArgs e)
		{
			if (
				statusBar!=null &&
				instructionRightSplitter.Tag!=null &&
				infoResourceSplitter.Tag!=null
				)
			{
				if(infoResourceSplitter.Enabled || instructionRightSplitter.Enabled)
				{
					double relativewidth = (double)instructionRightSplitter.Tag;//((double)3/(double)5);
					double relativeheight= (double)infoResourceSplitter.Tag;//((double)1/(double)2);
					int newwidth =(int)(relativewidth*(double)this.Width);
					if (newwidth<150)
					{
						newwidth=150;
					}
					instructionRichTextBox.Width=newwidth;
					int newheight=(int)(relativeheight*(double)this.Height);
					if (newheight>statusBar.Top)
					{
						newheight = statusBar.Top-50;
					}
					resourceTreeView.Height=newheight;
				}
				else
				{
					instructionRichTextBox.Width=this.ClientRectangle.Width;
				}
			}
		}

		
		private void FileMenu_Open_Click(object sender, System.EventArgs e)
		{
			if (openFileDialog.ShowDialog(this) == System.Windows.Forms.DialogResult.OK)
			{
				if (File.Exists(openFileDialog.FileName))
				{
					if (container!=null || file!=null || disassembly!=null)
					{
						CloseOpenFiles();
					}

					OpenFile(openFileDialog.FileName);

					if (container!=null || disassembly!=null)
					{
						FileMenu_Close.Enabled=true;
					}
				}
			}

		}

		private void FileMenu_Close_Click(object sender, System.EventArgs e)
		{
			CloseOpenFiles();
		}

		private void FileMenu_Exit_Click(object sender, System.EventArgs e)
		{
			CloseOpenFiles();
			this.Close();
		}


		private void HelpMenu_About_Click(object sender, System.EventArgs e)
		{
			System.Windows.Forms.MessageBox.Show("A primative dissasembler for the Small C AMX binary format\n\nWritten by Wraith who should have realised how hard it was to do properly and never bothered.","AMX Disassembler",MessageBoxButtons.OK,MessageBoxIcon.Information);
		}


		private void EditMenu_Find_Click(object sender, System.EventArgs e)
		{
			if (find==null)
			{
				find = new FindForm(instructionRichTextBox);
				find.Show();
			}
		}

		private void EditMenu_Cut_Click(object sender, System.EventArgs e)
		{
			instructionRichTextBox.Cut();
		}

		private void EditMenu_Paste_Click(object sender, System.EventArgs e)
		{
			instructionRichTextBox.Paste();
		}

		private void EditMenu_Copy_Click(object sender, System.EventArgs e)
		{
			instructionRichTextBox.Copy(); 		
		}

		private void EditMenu_selectAll_Click(object sender, System.EventArgs e)
		{
			instructionRichTextBox.SelectAll();
		}
		private void EditMenu_WriteToFile_Click(object sender, System.EventArgs e)
		{
			if (disassembly!=null && view!=null &&  view.CanWriteToFile)
			{
				string outfile = Path.GetDirectoryName(disassembly.Amx.Path) + Path.DirectorySeparatorChar + Path.GetFileNameWithoutExtension(disassembly.Amx.Path) + disassembly.Amx.Bits.ToString() + ".asm";
				view.WriteToFile(outfile,disassembly,options);
				UpdateStatus("written to file: " + Path.GetFileName(outfile),4);
			}
		}


		private void OptionsMenu_FormatOptions_Click(object sender, System.EventArgs e)
		{
			if (view!=null && ops!=null)
			{
				OptionsForm optionsform = new OptionsForm(view,options.format,ops);
				DialogResult answer = optionsform.ShowDialog(this);
				if (answer == DialogResult.OK)
				{
					options.format = optionsform.Format;
					view.Format=options.format;
					UpdateView();
				}
				optionsform.Dispose();
				optionsform=null;
			}
		}

		private void OptionsMenu_ShowSource_Click(object sender, System.EventArgs e)
		{
			options.ShowSource=!options.ShowSource;
			OptionsMenu_ShowSource.Checked=options.ShowSource;
			UpdateView();
		}

		private void OptionsMenu_ShowComments_Click(object sender, System.EventArgs e)
		{
			//options.showcomments=!options.showcomments;
			//if (disassembly!=null)
			//{
			//if (options.showcomments)
			//	curfile.CommentCod();
			//else
			//	curfile.UnCommentCod();
			//if (options.viewcod) 
			//	curfile.LayoutCod(richTextBox1,options);
			//}
		}

		private void OptionsMenu_DebugOps_ShowLINE_Click(object sender, System.EventArgs e)
		{
			options.debugops.ShowLineOps=!options.debugops.ShowLineOps;
			Update_OptionsMenu_DebugOps();
		}

		private void OptionsMenu_DebugOps_ShowFILE_Click(object sender, System.EventArgs e)
		{
			options.debugops.ShowFileOps=!options.debugops.ShowFileOps;
			Update_OptionsMenu_DebugOps();
		}

		private void OptionsMenu_DebugOps_ShowSYMBOL_Click(object sender, System.EventArgs e)
		{
			options.debugops.ShowSymbolOps=!options.debugops.ShowSymbolOps;		
			Update_OptionsMenu_DebugOps();
		}

		private void OptionsMenu_DebugOps_ShowSRANGE_Click(object sender, System.EventArgs e)
		{
			options.debugops.ShowSrangeOps =!options.debugops.ShowSrangeOps;
			Update_OptionsMenu_DebugOps();		
		}

		private void OptionsMenu_DebugOps_ShowSYMTAG_Click(object sender, System.EventArgs e)
		{
			options.debugops.ShowSymtagOps=!options.debugops.ShowSymtagOps;
			Update_OptionsMenu_DebugOps();		
		}

		private void OptionsMenu_DebugOps_ShowBOUNDS_Click(object sender, System.EventArgs e)
		{
			options.debugops.ShowBoundsOps=!options.debugops.ShowBoundsOps;
			Update_OptionsMenu_DebugOps();		
		}

		private void OptionsMenu_DebugOps_ShowAll_Click(object sender, System.EventArgs e)
		{
			OptionsMenu_DebugOps_ShowAll.Checked=!OptionsMenu_DebugOps_ShowAll.Checked;

			options.debugops.ShowLineOps=OptionsMenu_DebugOps_ShowAll.Checked;
			options.debugops.ShowFileOps=OptionsMenu_DebugOps_ShowAll.Checked;
			options.debugops.ShowSymbolOps=OptionsMenu_DebugOps_ShowAll.Checked;		
			options.debugops.ShowSrangeOps =OptionsMenu_DebugOps_ShowAll.Checked;
			options.debugops.ShowSymtagOps=OptionsMenu_DebugOps_ShowAll.Checked;
			options.debugops.ShowBoundsOps=OptionsMenu_DebugOps_ShowAll.Checked;
			
			Update_OptionsMenu_DebugOps();
		}

		private void OptionsMenu_ViewType_Item_Click(object sender, EventArgs e)
		{
			MenuItem item = sender as MenuItem;
			bool uiupdate =false;
			if (item!=null)
			{
				if (view!=null)
				{
					view.Format=options.format;
				}
				item.Checked=true;
				foreach (MenuItem sibling in item.Parent.MenuItems)
				{
					if (sibling!=item)
					{
						sibling.Checked=false;
					}
				}
				if (views!=null)
				{
					foreach (IDisassemblyView v in views)
					{
						if (v.Name==item.Text)
						{
							if (v!=view)
							{
								uiupdate=true;
							}
							view = v;
							options.format=view.Format;
							break;
						}
					}
				}
				else
				{
				}
			}
			if (uiupdate)
			{
				UpdateInterface();
				UpdateView();
			}


		}


		private void instructionRightSplitter_SplitterMoved(object sender, System.Windows.Forms.SplitterEventArgs e)
		{
			if (instructionRightSplitter.Enabled)
			{
				instructionRightSplitter.Tag = ((double)instructionRichTextBox.Width/(double)this.Width);
			}
		}

		private void infoResourceSplitter_SplitterMoved(object sender, System.Windows.Forms.SplitterEventArgs e)
		{
			if (infoResourceSplitter.Enabled)
			{
				infoResourceSplitter.Tag = ((double)resourceTreeView.Height/(double)(this.Height));
			}
		}


		private void instructionRichTextBox_SelectionChanged(object sender, System.EventArgs e)
		{
			if (
				disassembly!=null &&
				view!=null &&
				view.ShowInfoTextBox &&
				view.CanGetLineInfo &&
				instructionRichTextBox.Lines.Length>0 &&
				instructionRichTextBox.SelectionLength==0
				)
			{
				int lineno = instructionRichTextBox.GetLineFromCharIndex(instructionRichTextBox.SelectionStart);
				LineParts info = view.GetLineInfo(instructionRichTextBox.Lines[lineno]);
				Instruction current = null;
				if (info.Offset!=null)
				{
					int offset;
					if (info.Offset.StartsWith("0x"))
					{
						offset = int.Parse(info.Offset.Substring(2),System.Globalization.NumberStyles.AllowHexSpecifier);
					}
					else
					{
						offset = int.Parse(info.Offset);						
					}
					current = disassembly.Instructions[offset];
					FormatOpInfo(infoRichTextBox,current.Op,current);
				}
				else if (info.Op!=null)
				{
					Op op = ops[info.Op];
					if (op!=null)
					{
						FormatOpInfo(infoRichTextBox,op,null);
					}
					else
					{
						infoRichTextBox.Clear();
					}
				}
				else
				{
					infoRichTextBox.Clear();
				}

				if (current!=null && view.ShowResourceTree)
				{
					object val = disassembly.ResourceReferences[current.Offset];
					if (val!=null && val is ValInt)
					{
						ValInt vi = (ValInt)val;
						resourceTreeView.SelectedNode = FindDatNode(vi,resourceTreeView);
						if (resourceTreeView.SelectedNode!=null)
						{
							resourceTreeView.SelectedNode.EnsureVisible();
						}
					}
				}

				/*
				if (lineno<instructionRichTextBox.Lines.Length && instructionRichTextBox.Text!="")
				{
					string line = instructionRichTextBox.Lines[lineno];
					if (line.TrimStart().StartsWith("0x"))
					{
						string temp = line.TrimStart().Substring(2);
						temp = temp.Substring(0,temp.IndexOf(" ",0));
						int offset = int.Parse(temp,System.Globalization.NumberStyles.AllowHexSpecifier);
						infoRichTextBox.Text=offset.ToString("x");
						Instruction foundline =null;
						//foundline=curfile.GetLineFromOffset(offset);
						//foreach (DisassemblyLine dline in curfile.CodLines)
						//{
						//	if (offset==dline.Offset)
						//	{
						//		foundline=dline;
						//		break;
						//	}
						//}
						if (foundline!=null)
						{
							FormatOpInfo(infoRichTextBox,foundline.Op,foundline);
							if (foundline.IsdatReference)
							{
								//TreeNode refered=null;
								//if (foundline.Special)
								//{
								//	// symbol opcode
								//	refered = FindDatNode(foundline.GetParam(1),resourceTreeView.Nodes);
								//}
								//else
								//{
								//	// normal opcode
								//	refered = FindDatNode(foundline.Param,resourceTreeView.Nodes);
								//}
								//if (refered!=null)
								//{
								//	refered.EnsureVisible();
								//	resourceTreeView.SelectedNode=refered;
								//}
							}
						}
					}
				}
				*/
			}
			else
			{
				infoRichTextBox.Clear();
			}
		}	

		
		private void statusTimer_Tick(object sender, System.EventArgs e)
		{
			statusTimer.Enabled=false;
			statusPanel.Text="";		
		}


		private void disassembly_InstructionUpdate(object sender, DisassemblyInstructionUpdateEventArgs e)
		{
			if (e.Finished)
			{
				UpdateStatus("read " + e.Count.ToString("D") + " instructions in total",3);
			}
			else
			{
				UpdateStatus("read " + e.Count.ToString("D") + " instructions so far",-1);
			}
		}

		private void disassembly_ResourceUpdate(object sender, DisassemblyResourceUpdateEventArgs e)
		{
			if (e.Finished)
			{
				UpdateStatus("completed parsing resources in " + e.LoopCount.ToString("D") + " passes (of " + e.Loops.ToString("D") +")",3);
			}
			else
			{
				UpdateStatus("parsing resources, pass " + e.LoopCount.ToString("D") + " of " + e.Loops.ToString("D"),-1);
			}
		}

		private void disassembly_StatusUpdate(object sender, DisassemblyStatusMessageEventArgs e)
		{
			UpdateStatus(e.Message,-1);
		}
		


		private void OpenFile(string path)
		{
			string selectedext = Path.GetExtension(path).ToLower();
			IFiletype provider = null;
			foreach (IFiletype type in types)
			{
				if (string.Compare(type.Extension,selectedext,true)==0)
				{
					provider = type;
					break;
				}
			}
			if (provider!=null)
			{
				IAmxContainer container = provider.GetContainer(path);
				if(container!=null)
				{
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
							using (AmxxChoice choose = new AmxxChoice(container))
							{
								IAmxDescription choice = choose.ShowDialog(this);
								if (choice!=null)
								{
									switch (choice.Bits)
									{
										case Bits._32:
										case Bits._64 :
											file = container.GetFile(choice);
											break;
									}
								}
								else
								{
									file = null;
								}
							}
							break;
					}
				}

				if (file!=null)
				{
					disassembly = new Disassembly(file,ops);
				}
			}

			/*
			switch (Path.GetExtension(path).ToLower())
			{
				case ".ramx":
					file = new RamxFile(path,Bits._32);
					if (file.Valid)
					{
						container = (IAmxContainer)file;
						disassembly = new Disassembly(file,ops);
					}
					break;
				case ".amx":
					file = new AmxFile(path,Bits._32);
					if (file.Valid)
					{
						container = (IAmxContainer)file;
						disassembly = new Disassembly(file,ops);
					}
					break;
				case ".amxx":
					container = new AmxxFile(path);
					{
						//AmxxChoice choose = new AmxxChoice(container);
						using (AmxxChoice choose = new AmxxChoice(container))
						{
							IAmxDescription choice = choose.ShowDialog(this);
							if (choice!=null)
							{
								switch (choice.Bits)
								{
									case Bits._32:
									case Bits._64 :
										file = container.GetFile(choice);
										if (file.Valid)
										{
											disassembly = new Disassembly(file,ops);
										}
										break;
								}
							}
							else
							{
								MessageBox.Show("chose to cancel");
							}
						}
						//choose.Dispose();
						//choose=null;
					}
					break;
				default:
					break;
			}
			*/
			if (disassembly!=null)
			{
				DisassembleFile(disassembly);
			}

		}
		private void CloseOpenFiles()
		{
			if (file!=null)
			{
				file=null;
			}
			if (container!=null)
			{
				container=null;
			}
			if (disassembly!=null)
			{
				disassembly.InstructionUpdate-=new DisassemblyInstructionUpdateHandler(disassembly_InstructionUpdate);
				disassembly.ResourceUpdate-=new DisassemblyResourceUpdateHandler(disassembly_ResourceUpdate);
				disassembly.StatusUpdate-=new DisassemblyStatusMessageHandler(disassembly_StatusUpdate);
				disassembly.Dispose();
				disassembly=null;
			}
			instructionRichTextBox.Clear();
			resourceTreeView.Nodes.Clear();
			FileMenu_Close.Enabled=false;
			instructionRichTextBox_SelectionChanged(null, EventArgs.Empty);
			this.Text=TitlePrefix;
		}

		private void DisassembleFile(Disassembly dis)
		{
			if (dis!=null && dis.Amx.Valid)
			{
				DateTime start = DateTime.Now;
				dis.InstructionUpdate+=new DisassemblyInstructionUpdateHandler(disassembly_InstructionUpdate);
				dis.ResourceUpdate+=new DisassemblyResourceUpdateHandler(disassembly_ResourceUpdate);
				dis.StatusUpdate+=new DisassemblyStatusMessageHandler(disassembly_StatusUpdate);
				dis.Disassemble();
				dis.LoadSource();
				TimeSpan took = DateTime.Now - start;
				UpdateStatus("loaded file in " + took.Minutes+":"+took.Seconds,2);

				UpdateView();
			}
			else
			{
				if (dis!=null)
				{
					dis.Dispose();
				}
				dis=null;
			}	
				
		}

		private void ViewFile(Disassembly dis, IDisassemblyView view)
		{
			this.Text=TitlePrefix+": "+file.InfoString;
			if (dis!=null && view!=null)
			{
				options.format=view.Format;

				StringWriter str = new StringWriter();

				if (view.CanWriteResourceToText)
				{
					view.WriteResources(str,dis,options);
				}
				else if (view.CanWriteResourceToTree)
				{
					view.WriteResources(resourceTreeView,dis,options);
				}
				
				if (view.CanWriteInstructionToText)
				{
					view.WriteInstructions(str,dis,options);
				}

				instructionRichTextBox.Text=str.ToString();
				str.Close();
				str=null;
			}
		}


		private void FormatOpInfo(RichTextBox box, Op op, Instruction line)
		{
			StringBuilder str = new StringBuilder();
			//System.Drawing.Font boldfont;
			//System.Drawing.Font monofont;
			//System.Drawing.Font normalfont;

			//normalfont = box.SelectionFont;
			//boldfont =  new System.Drawing.Font(normalfont.Name, normalfont.Size,System.Drawing.FontStyle.Bold);
			//monofont =  new System.Drawing.Font("Courier New", 9.75f ,System.Drawing.FontStyle.Bold);

			box.Clear();

			str.Append("value : 0x");
			str.Append(op.Code.ToString("x"));
			str.Append(Environment.NewLine);

			str.Append("name  : ");
			str.Append(op.Name+Environment.NewLine);

			str.Append("args  : ");
			str.Append(Environment.NewLine);

			for (int i=0;i<op.ParamCount;i++)
			{
				str.Append("   ");
				if (op.VariableLength && op.Params[i].IndexOf("...")!=-1)
				{
					str.Append(op.Params[i].Replace("...",""));
					if (line!=null)
					{
						str.Append(" ( = 0x");
						if (line.Extra  is byte[])
						{
							byte[] bytes = (byte[])line.Extra; 
							str.Append(bytes.Length.ToString("x"));
						}
						str.Append(" long )");
					}
				}
				else
				{
					str.Append(op.Params[i]);
					if (line!=null)
					{
						str.Append(" ( = 0x");
						str.Append(line.GetParam(i).ToString("X"));
						str.Append(" )");
					}
				}
				str.Append(Environment.NewLine);
			}

			str.Append("effect:");
			str.Append(Environment.NewLine);
			str.Append(op.Description);

			box.Text=str.ToString();

		}

		private TreeNode FindDatNode(ValInt param,TreeView tree)
		{
			TreeNode retval = null;

			if (tree.Tag is Hashtable)
			{
				Hashtable index = tree.Tag as Hashtable;
				retval = index[ param ] as TreeNode;
			}
			else
			{
				foreach (TreeNode node in tree.Nodes)
				{
					if (node.Tag!=null && (ValInt)node.Tag == param)
					{
						retval = node;
					}
				}
			}
			/*int tag=0;

			foreach (TreeNode node in root)
			{
				tag=0;
				if (node.Tag !=null)
				{
					// seriously messy but you can't use 'as' on valuetypes
					try
					{
						tag = (int)node.Tag;
					}
					catch (Exception)
					{
						tag=0;
					}
				
					if (tag!=0)
					{
						if (tag==param)
						{
							retval=node;
							break;
						}
					}
					retval = FindDatNode(param,node.Nodes);
					if (retval!=null) 
					{
						break;
					}
				}
				
			}
*/
			return retval;
		}


		private void Update_OptionsMenu_DebugOps()
		{
			OptionsMenu_DebugOps_ShowBOUNDS.Checked=options.debugops.ShowBoundsOps;
			OptionsMenu_DebugOps_ShowSYMTAG.Checked=options.debugops.ShowSymtagOps;
			OptionsMenu_DebugOps_ShowSRANGE.Checked=options.debugops.ShowSrangeOps;
			OptionsMenu_DebugOps_ShowSYMBOL.Checked=options.debugops.ShowSymbolOps;
			OptionsMenu_DebugOps_ShowFILE.Checked=options.debugops.ShowFileOps;
			OptionsMenu_DebugOps_ShowLINE.Checked=options.debugops.ShowLineOps;

			OptionsMenu_DebugOps_ShowAll.Checked = (
				options.debugops.ShowBoundsOps &&
				options.debugops.ShowSymtagOps &&
				options.debugops.ShowSrangeOps &&
				options.debugops.ShowSymbolOps &&
				options.debugops.ShowFileOps &&
				options.debugops.ShowLineOps
				);

			UpdateView();
		}


		private void UpdateView()
		{
			int lineno = instructionRichTextBox.GetLineFromCharIndex(instructionRichTextBox.SelectionStart);
			instructionRichTextBox.Clear();
			infoRichTextBox.Clear();
			resourceTreeView.Nodes.Clear();
			if (disassembly!=null)
			{
				ViewFile(disassembly,view);
			}
			instructionRichTextBox.SelectionStart=lineno;
			instructionRichTextBox.ScrollToCaret();
		}
		private void UpdateInterface()
		{
			instructionRichTextBox.Visible=view.ShowInstructionTextBox;
			resourceTreeView.Visible=view.ShowResourceTree;
			infoRichTextBox.Visible=view.ShowInfoTextBox;

			infoResourceSplitter.Visible=( view.ShowInfoTextBox | view.ShowResourceTree );
			infoResourceSplitter.Enabled=infoResourceSplitter.Visible;
			instructionRightSplitter.Enabled=( view.ShowInfoTextBox & view.ShowResourceTree );
			instructionRightSplitter.Visible=instructionRightSplitter.Enabled;

			OptionsMenu_WriteToFile.Enabled=view.CanWriteToFile;

			this.MainForm_Resize(this,EventArgs.Empty);

		}

		private void UpdateStatus(string message,int seconds)
		{
			statusPanel.Text=message;
			if (statusTimer.Enabled)
			{
				statusTimer.Stop();
			}
			if (seconds!=-1)
			{
				statusTimer.Interval = (int)((TimeSpan.FromSeconds(seconds)).TotalMilliseconds);
				statusTimer.Start();
			}
		}

	}

	public sealed class Helpers
	{
		public static IDisassemblyView[] LoadViews(string directory)
		{
			IDisassemblyView[] retval = null;
			ArrayList list = 
				AssemblySnooper.LoadContainingAssembliesFromDirectory(
					directory,
					typeof(IDisassemblyView)
				);
			if (list!=null && list.Count>0)
			{
				retval = (IDisassemblyView[])list.ToArray(typeof(IDisassemblyView));
			}
			
			return retval;
		}

		public static IFiletype[] LoadFiletypes(string directory)
		{
			IFiletype[] retval = null;
			ArrayList list =
				AssemblySnooper.LoadContainingAssembliesFromDirectory(
					directory,
					typeof(IFiletype)
				);
			if (list==null)
			{
				list= new ArrayList();
			}
			list.Insert(0,new AmxFiletype());
			if (list!=null & list.Count>0)
			{
				retval = (IFiletype[])list.ToArray(typeof(IFiletype));
			}
			return retval;
		}
		
	}
}
