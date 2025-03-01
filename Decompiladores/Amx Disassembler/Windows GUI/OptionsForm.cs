using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace GUI
{
	using System.Text;
	using System.Collections;

	using Amx.Core;
	using Amx.Ops;
	using Amx.Logic.Jumps;
	using Amx.Logic.Labels;

	using View;

	using Amx.Cod;

	using GUI;


	public class OptionsForm : System.Windows.Forms.Form
	{
		private System.Windows.Forms.RichTextBox richTextBox1;
		private System.ComponentModel.Container components = null;
		private new System.Windows.Forms.Button CancelButton;
		private System.Windows.Forms.Button OkButton;

		private StringOptionsControl commentOptionsControl;
		private StringOptionsControl stringParamsOptionsControl;
		private StringOptionsControl spacerOptionsControl;
		private StringOptionsControl opcodeOptionsControl;
		private NumberOptionsControl offsetOptionsControl;
		private NumberOptionsControl numberParamsOptionsControl;
		
		private Options options;
		private Ops ops;
		private Amx.Logic.Labels.Label label;
		private Amx.Logic.Jumps.Jump jump;
		private ArrayList lines;
		private FormatOptions format;
		private StringOptionsControl indentOptionsControl;
		private System.Windows.Forms.Button resetButton;
		private IDisassemblyView view;

		

		public OptionsForm(IDisassemblyView view, FormatOptions original, Ops ops)
		{
			this.options=new Options();
			this.format = original.Clone() as FormatOptions;
			options.format=this.Format;
			this.ops=ops;
			this.view = view;
			InitializeComponent();
		}

		protected override void Dispose( bool disposing )
		{
			if (view!=null)
			{
				view=null;
			}
			if (lines!=null)
			{
				lines.Clear();
				lines=null;
			}
			if (label!=null)
			{
				label=null;
			}
			if (jump!=null)
			{
				jump=null;
			}
			if (ops!=null)
			{
				ops=null;
			}
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code

		private void InitializeComponent()
		{
			this.offsetOptionsControl = new GUI.NumberOptionsControl();
			this.commentOptionsControl = new GUI.StringOptionsControl();
			this.richTextBox1 = new System.Windows.Forms.RichTextBox();
			this.CancelButton = new System.Windows.Forms.Button();
			this.OkButton = new System.Windows.Forms.Button();
			this.stringParamsOptionsControl = new GUI.StringOptionsControl();
			this.spacerOptionsControl = new GUI.StringOptionsControl();
			this.opcodeOptionsControl = new GUI.StringOptionsControl();
			this.numberParamsOptionsControl = new GUI.NumberOptionsControl();
			this.indentOptionsControl = new GUI.StringOptionsControl();
			this.resetButton = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// offsetOptionsControl
			// 
			this.offsetOptionsControl.Location = new System.Drawing.Point(145, 125);
			this.offsetOptionsControl.Name = "offsetOptionsControl";
			this.offsetOptionsControl.Size = new System.Drawing.Size(140, 165);
			this.offsetOptionsControl.TabIndex = 13;
			this.offsetOptionsControl.Title = "Offset Options";
			this.offsetOptionsControl.OptionChange += new GUI.NumberOptionsChangeHandler(this.offsetOptionsControl_OptionChange);
			// 
			// commentOptionsControl
			// 
			this.commentOptionsControl.Location = new System.Drawing.Point(210, 295);
			this.commentOptionsControl.Name = "commentOptionsControl";
			this.commentOptionsControl.Size = new System.Drawing.Size(140, 145);
			this.commentOptionsControl.TabIndex = 9;
			this.commentOptionsControl.Title = "Comment Options";
			this.commentOptionsControl.OptionChange += new GUI.StringOptionsChangeHandler(this.commentOptionsControl_OptionChange);
			// 
			// richTextBox1
			// 
			this.richTextBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.richTextBox1.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(0)));
			this.richTextBox1.Location = new System.Drawing.Point(0, 0);
			this.richTextBox1.Name = "richTextBox1";
			this.richTextBox1.Size = new System.Drawing.Size(567, 120);
			this.richTextBox1.TabIndex = 0;
			this.richTextBox1.Text = "";
			// 
			// CancelButton
			// 
			this.CancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.CancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.CancelButton.Location = new System.Drawing.Point(487, 445);
			this.CancelButton.Name = "CancelButton";
			this.CancelButton.TabIndex = 4;
			this.CancelButton.Text = "Cancel";
			this.CancelButton.Click += new System.EventHandler(this.CancelButton_Click);
			// 
			// OkButton
			// 
			this.OkButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.OkButton.Location = new System.Drawing.Point(407, 445);
			this.OkButton.Name = "OkButton";
			this.OkButton.TabIndex = 5;
			this.OkButton.Text = "Ok";
			this.OkButton.Click += new System.EventHandler(this.OkButton_Click);
			// 
			// stringParamsOptionsControl
			// 
			this.stringParamsOptionsControl.Location = new System.Drawing.Point(425, 295);
			this.stringParamsOptionsControl.Name = "stringParamsOptionsControl";
			this.stringParamsOptionsControl.Size = new System.Drawing.Size(140, 145);
			this.stringParamsOptionsControl.TabIndex = 10;
			this.stringParamsOptionsControl.Title = "String Param Options";
			this.stringParamsOptionsControl.OptionChange += new GUI.StringOptionsChangeHandler(this.stringParamsOptionsControl_OptionChange);
			// 
			// spacerOptionsControl
			// 
			this.spacerOptionsControl.Location = new System.Drawing.Point(65, 295);
			this.spacerOptionsControl.Name = "spacerOptionsControl";
			this.spacerOptionsControl.Size = new System.Drawing.Size(140, 145);
			this.spacerOptionsControl.TabIndex = 11;
			this.spacerOptionsControl.Title = "Spacer Options";
			this.spacerOptionsControl.OptionChange += new GUI.StringOptionsChangeHandler(this.spacerOptionsControl_OptionChange);
			// 
			// opcodeOptionsControl
			// 
			this.opcodeOptionsControl.Location = new System.Drawing.Point(285, 125);
			this.opcodeOptionsControl.Name = "opcodeOptionsControl";
			this.opcodeOptionsControl.Size = new System.Drawing.Size(140, 145);
			this.opcodeOptionsControl.TabIndex = 12;
			this.opcodeOptionsControl.Title = "Opcode Options";
			this.opcodeOptionsControl.OptionChange += new GUI.StringOptionsChangeHandler(this.opcodeOptionsControl_OptionChange);
			// 
			// numberParamsOptionsControl
			// 
			this.numberParamsOptionsControl.Location = new System.Drawing.Point(425, 125);
			this.numberParamsOptionsControl.Name = "numberParamsOptionsControl";
			this.numberParamsOptionsControl.Size = new System.Drawing.Size(140, 165);
			this.numberParamsOptionsControl.TabIndex = 14;
			this.numberParamsOptionsControl.Title = "Number Param Options";
			this.numberParamsOptionsControl.OptionChange += new GUI.NumberOptionsChangeHandler(this.numberOptionsControl_OptionChange);
			// 
			// indentOptionsControl
			// 
			this.indentOptionsControl.Location = new System.Drawing.Point(5, 125);
			this.indentOptionsControl.Name = "indentOptionsControl";
			this.indentOptionsControl.Size = new System.Drawing.Size(140, 145);
			this.indentOptionsControl.TabIndex = 15;
			this.indentOptionsControl.Title = "Indent Options";
			this.indentOptionsControl.OptionChange += new GUI.StringOptionsChangeHandler(this.indentOptionsControl_OptionChange);
			// 
			// resetButton
			// 
			this.resetButton.Location = new System.Drawing.Point(325, 445);
			this.resetButton.Name = "resetButton";
			this.resetButton.TabIndex = 16;
			this.resetButton.Text = "Reset";
			this.resetButton.Click += new System.EventHandler(this.resetButton_Click);
			// 
			// OptionsForm
			// 
			this.AcceptButton = this.OkButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(569, 475);
			this.ControlBox = false;
			this.Controls.Add(this.resetButton);
			this.Controls.Add(this.indentOptionsControl);
			this.Controls.Add(this.numberParamsOptionsControl);
			this.Controls.Add(this.opcodeOptionsControl);
			this.Controls.Add(this.spacerOptionsControl);
			this.Controls.Add(this.stringParamsOptionsControl);
			this.Controls.Add(this.commentOptionsControl);
			this.Controls.Add(this.offsetOptionsControl);
			this.Controls.Add(this.OkButton);
			this.Controls.Add(this.CancelButton);
			this.Controls.Add(this.richTextBox1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "OptionsForm";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "Format Options";
			this.ResumeLayout(false);

		}
		#endregion

		protected override void OnLoad(EventArgs e)
		{
			base.OnLoad (e);

			commentOptionsControl.SetTrackedOptions(format.Comment);
			commentOptionsControl.Enabled=true;

			stringParamsOptionsControl.SetTrackedOptions(format.StringParams);
			stringParamsOptionsControl.Enabled=true;

			spacerOptionsControl.SetTrackedOptions(format.Spacer);
			spacerOptionsControl.Enabled=true;

			opcodeOptionsControl.SetTrackedOptions(format.Opcode);
			opcodeOptionsControl.Enabled=true;

			offsetOptionsControl.SetTrackedOptions(format.Offset);
			offsetOptionsControl.Enabled=true;

			numberParamsOptionsControl.SetTrackedOptions(format.NumberParams);
			numberParamsOptionsControl.Enabled=true;

			indentOptionsControl.SetTrackedOptions(format.Indent );
			indentOptionsControl.Enabled=true;

			
			jump = new Jump(252,256,1);
			label = new Amx.Logic.Labels.Label("label_00",256);
			jump.Label=label;

			lines = new ArrayList(5);

			Instruction line = new Instruction();
			line.Op=ops[39];
			line.Offset=240;
			line.SetParam(0,32);

			lines.Add(line);

			line = new Instruction();
			line.Op=ops[24];
			line.Offset=244;
			line.SetParam(30);
			lines.Add(line);

			line = new Instruction();
			line.Op=ops[125];
			line.Offset=248;
			line.SetParam(0,-1);
			line.SetParam(1,0);
			lines.Add(line);

			line = new Instruction();
			line.Op=ops[51];
			line.Offset=252;
			line.SetParam(0,256);
			lines.Add(line);




			UpdateLines();		

		}

		private void UpdateLines()
		{
			if (lines!=null)
			{
				richTextBox1.SuspendLayout();
				richTextBox1.Clear();
				StringBuilder str = new StringBuilder();
				foreach (Instruction inst in lines)
				{
					view.WriteStandardInstruction(str,inst,options,jump);
					if (inst.Offset==jump.Target)
					{
						/*
						if (view is WindowsFormsDisassemblyView)
						{
							WindowsFormsDisassemblyView v = view as WindowsFormsDisassemblyView;
							bool written=false;
							v.WriteCommentSeparator(str,options,ref written);
							str.Append("->");
							str.Append(label.Name);

						}
						*/
						//view.WriteCommentSeparator(str,inst,options);
					}
					str.Append(options.format.NewLine);
				}
				richTextBox1.AppendText(str.ToString());
				richTextBox1.ResumeLayout(true);
			}
		}




		private void commentOptionsControl_OptionChange(object sender, StringOptionsChangeEventArgs e)
		{
			this.format.Comment=e.Options;
			UpdateLines();
		}

		private void stringParamsOptionsControl_OptionChange(object sender, StringOptionsChangeEventArgs e)
		{
			this.format.StringParams=e.Options;
			UpdateLines();
		}

		private void spacerOptionsControl_OptionChange(object sender, StringOptionsChangeEventArgs e)
		{
			this.format.Spacer=e.Options;
			UpdateLines();
		}

		private void opcodeOptionsControl_OptionChange(object sender, StringOptionsChangeEventArgs e)
		{
			this.format.Opcode=e.Options;
			UpdateLines();
		}

		private void offsetOptionsControl_OptionChange(object sender, NumberOptionsChangeEventArgs e)
		{
			this.format.Offset=e.Options;
			UpdateLines();
		}

		private void numberOptionsControl_OptionChange(object sender, NumberOptionsChangeEventArgs e)
		{
			this.format.NumberParams=e.Options;
			UpdateLines();
		}
		private void indentOptionsControl_OptionChange(object sender, StringOptionsChangeEventArgs e)
		{
			this.format.Indent=e.Options;
			UpdateLines();
		}


		private void CancelButton_Click(object sender, System.EventArgs e)
		{
			this.DialogResult=DialogResult.Cancel;
			this.Close();
		}

		private void OkButton_Click(object sender, System.EventArgs e)
		{
			this.DialogResult=DialogResult.OK;
			this.Close();
		
		}

		private void resetButton_Click(object sender, System.EventArgs e)
		{
			view.ResetFormat();
			this.format=view.Format;
			options.format=this.format;
			commentOptionsControl.SetTrackedOptions(format.Comment);
			stringParamsOptionsControl.SetTrackedOptions(format.StringParams);
			spacerOptionsControl.SetTrackedOptions(format.Spacer);
			opcodeOptionsControl.SetTrackedOptions(format.Opcode);
			offsetOptionsControl.SetTrackedOptions(format.Offset);
			numberParamsOptionsControl.SetTrackedOptions(format.NumberParams);
			indentOptionsControl.SetTrackedOptions(format.Indent );
			UpdateLines();
		}


		public FormatOptions Format
		{
			get
			{
				return format;
			}
		}

	}
}
