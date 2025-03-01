using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Windows.Forms;

namespace GUI
{
	using Amx.Core;

	public class StringOptionsControl : System.Windows.Forms.UserControl
	{
		private System.Windows.Forms.GroupBox stringOptionsGroupBox;
		private System.Windows.Forms.Label characterLabel;
		private System.Windows.Forms.Label alignmentLabel;
		private System.Windows.Forms.Label minWidthLabel;
		private System.Windows.Forms.Label maxWidthLabel;
		private System.Windows.Forms.ComboBox characterComboBox;
		private System.Windows.Forms.NumericUpDown minWidthUpDown;
		private System.Windows.Forms.ComboBox alignmentComboBox;
		private System.Windows.Forms.NumericUpDown maxWidthUpDown;
		private System.Windows.Forms.CheckBox truncateCheckBox;
		private System.Windows.Forms.Label truncateLabel;
		private System.ComponentModel.Container components = null;

		private bool optionsset;
		private bool inload;
		private StringOptions options;
		public event StringOptionsChangeHandler OptionChange;

		private ArrayList commentlist;
		private string[] comments = { 
									  " ",
									  ";",
									  ".",
									  ",",
									  "_",
									  "-",
									  "~",
									  "=",
									  "+",
									  "?",
									  "!",
									  "/",
									 @"\"
								  };

		public StringOptionsControl()
		{
			InitializeComponent();
		}

		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Component Designer generated code
		private void InitializeComponent()
		{
			this.stringOptionsGroupBox = new System.Windows.Forms.GroupBox();
			this.truncateCheckBox = new System.Windows.Forms.CheckBox();
			this.truncateLabel = new System.Windows.Forms.Label();
			this.characterLabel = new System.Windows.Forms.Label();
			this.alignmentLabel = new System.Windows.Forms.Label();
			this.minWidthLabel = new System.Windows.Forms.Label();
			this.maxWidthLabel = new System.Windows.Forms.Label();
			this.characterComboBox = new System.Windows.Forms.ComboBox();
			this.minWidthUpDown = new System.Windows.Forms.NumericUpDown();
			this.alignmentComboBox = new System.Windows.Forms.ComboBox();
			this.maxWidthUpDown = new System.Windows.Forms.NumericUpDown();
			this.stringOptionsGroupBox.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.minWidthUpDown)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.maxWidthUpDown)).BeginInit();
			this.SuspendLayout();
			// 
			// stringOptionsGroupBox
			// 
			this.stringOptionsGroupBox.Controls.Add(this.truncateCheckBox);
			this.stringOptionsGroupBox.Controls.Add(this.truncateLabel);
			this.stringOptionsGroupBox.Controls.Add(this.characterLabel);
			this.stringOptionsGroupBox.Controls.Add(this.alignmentLabel);
			this.stringOptionsGroupBox.Controls.Add(this.minWidthLabel);
			this.stringOptionsGroupBox.Controls.Add(this.maxWidthLabel);
			this.stringOptionsGroupBox.Controls.Add(this.characterComboBox);
			this.stringOptionsGroupBox.Controls.Add(this.minWidthUpDown);
			this.stringOptionsGroupBox.Controls.Add(this.alignmentComboBox);
			this.stringOptionsGroupBox.Controls.Add(this.maxWidthUpDown);
			this.stringOptionsGroupBox.Location = new System.Drawing.Point(0, 0);
			this.stringOptionsGroupBox.Name = "stringOptionsGroupBox";
			this.stringOptionsGroupBox.Size = new System.Drawing.Size(135, 140);
			this.stringOptionsGroupBox.TabIndex = 9;
			this.stringOptionsGroupBox.TabStop = false;
			// 
			// truncateCheckBox
			// 
			this.truncateCheckBox.Location = new System.Drawing.Point(95, 65);
			this.truncateCheckBox.Name = "truncateCheckBox";
			this.truncateCheckBox.Size = new System.Drawing.Size(15, 20);
			this.truncateCheckBox.TabIndex = 11;
			this.truncateCheckBox.CheckedChanged += new System.EventHandler(this.truncateCheckBox_CheckedChanged);
			// 
			// truncateLabel
			// 
			this.truncateLabel.Location = new System.Drawing.Point(5, 65);
			this.truncateLabel.Name = "truncateLabel";
			this.truncateLabel.Size = new System.Drawing.Size(60, 20);
			this.truncateLabel.TabIndex = 10;
			this.truncateLabel.Text = "Truncate";
			this.truncateLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// characterLabel
			// 
			this.characterLabel.Location = new System.Drawing.Point(5, 90);
			this.characterLabel.Name = "characterLabel";
			this.characterLabel.Size = new System.Drawing.Size(60, 20);
			this.characterLabel.TabIndex = 7;
			this.characterLabel.Text = "Character";
			this.characterLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// alignmentLabel
			// 
			this.alignmentLabel.Location = new System.Drawing.Point(5, 115);
			this.alignmentLabel.Name = "alignmentLabel";
			this.alignmentLabel.Size = new System.Drawing.Size(60, 20);
			this.alignmentLabel.TabIndex = 6;
			this.alignmentLabel.Text = "Alignment";
			this.alignmentLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// minWidthLabel
			// 
			this.minWidthLabel.Location = new System.Drawing.Point(5, 40);
			this.minWidthLabel.Name = "minWidthLabel";
			this.minWidthLabel.Size = new System.Drawing.Size(85, 20);
			this.minWidthLabel.TabIndex = 5;
			this.minWidthLabel.Text = "Minimum Width";
			this.minWidthLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// maxWidthLabel
			// 
			this.maxWidthLabel.Location = new System.Drawing.Point(5, 15);
			this.maxWidthLabel.Name = "maxWidthLabel";
			this.maxWidthLabel.Size = new System.Drawing.Size(85, 20);
			this.maxWidthLabel.TabIndex = 4;
			this.maxWidthLabel.Text = "Maximum Width";
			this.maxWidthLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// characterComboBox
			// 
			this.characterComboBox.Location = new System.Drawing.Point(90, 90);
			this.characterComboBox.MaxLength = 1;
			this.characterComboBox.Name = "characterComboBox";
			this.characterComboBox.Size = new System.Drawing.Size(40, 21);
			this.characterComboBox.TabIndex = 3;
			this.characterComboBox.TextChanged += new System.EventHandler(this.characterComboBox_TextChanged);
			this.characterComboBox.SelectedIndexChanged += new System.EventHandler(this.characterComboBox_SelectedIndexChanged);
			// 
			// minWidthUpDown
			// 
			this.minWidthUpDown.Location = new System.Drawing.Point(90, 40);
			this.minWidthUpDown.Maximum = new System.Decimal(new int[] {
																		   20,
																		   0,
																		   0,
																		   0});
			this.minWidthUpDown.Name = "minWidthUpDown";
			this.minWidthUpDown.Size = new System.Drawing.Size(40, 20);
			this.minWidthUpDown.TabIndex = 2;
			this.minWidthUpDown.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
			this.minWidthUpDown.ValueChanged += new System.EventHandler(this.minWidthUpDown_ValueChanged);
			// 
			// alignmentComboBox
			// 
			this.alignmentComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.alignmentComboBox.Location = new System.Drawing.Point(65, 115);
			this.alignmentComboBox.Name = "alignmentComboBox";
			this.alignmentComboBox.Size = new System.Drawing.Size(65, 21);
			this.alignmentComboBox.TabIndex = 1;
			this.alignmentComboBox.SelectedIndexChanged += new System.EventHandler(this.alignmentComboBox_SelectedIndexChanged);
			// 
			// maxWidthUpDown
			// 
			this.maxWidthUpDown.Location = new System.Drawing.Point(90, 15);
			this.maxWidthUpDown.Maximum = new System.Decimal(new int[] {
																		   20,
																		   0,
																		   0,
																		   0});
			this.maxWidthUpDown.Name = "maxWidthUpDown";
			this.maxWidthUpDown.Size = new System.Drawing.Size(40, 20);
			this.maxWidthUpDown.TabIndex = 0;
			this.maxWidthUpDown.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
			this.maxWidthUpDown.ValueChanged += new System.EventHandler(this.maxWidthUpDown_ValueChanged);
			// 
			// StringOptionsControl
			// 
			this.Controls.Add(this.stringOptionsGroupBox);
			this.Name = "StringOptionsControl";
			this.Size = new System.Drawing.Size(140, 145);
			this.Load += new System.EventHandler(this.StringOptionsControl_Load);
			this.stringOptionsGroupBox.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.minWidthUpDown)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.maxWidthUpDown)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion


		public void SetTrackedOptions(StringOptions options)
		{
			inload=true;
			this.options=options;
			this.alignmentComboBox.SelectedItem=options.Alignment.ToString();
			this.characterComboBox.SelectedItem=this.characterComboBox.Items[this.characterComboBox.Items.IndexOf(options.PadChar.ToString())];
			this.maxWidthUpDown.Value=options.MaxWidth;
			this.minWidthUpDown.Value=options.MinWidth;
			this.truncateCheckBox.Checked=options.Truncate;
			optionsset=true;
			inload=false;
			OnOptionChange();
		}


		public string Title
		{
			get
			{
				return this.stringOptionsGroupBox.Text;
			}
			set
			{
				this.stringOptionsGroupBox.Text=value;
			}
		}

		new public bool Enabled
		{
			get
			{
				return stringOptionsGroupBox.Enabled;
			}
			set
			{
				if (optionsset)
				{
					stringOptionsGroupBox.Enabled=value;
				}
			}
		}


		protected virtual void OnOptionChange()
		{
			if (!inload && OptionChange!=null)
			{
				OptionChange(this,new StringOptionsChangeEventArgs(options));
			}
		}


		private void characterComboBox_TextChanged(object sender, System.EventArgs e)
		{
			string text = characterComboBox.Text as string;
			if (text!=null)
			{
				char chr = text[0];
				if (!commentlist.Contains(chr))
				{
					commentlist.Add(chr);
				}
				options.PadChar=chr;
			}
			OnOptionChange();	
		}

		private void characterComboBox_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			string text = characterComboBox.SelectedItem.ToString();
			if (text!=null)
			{
				char chr = text[0];
				if (!commentlist.Contains(chr))
				{
					commentlist.Add(chr);
				}
				options.PadChar=chr;
			}
			OnOptionChange();
		}

		private void alignmentComboBox_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			options.Alignment=(Align)Enum.Parse(typeof(Align),((string)alignmentComboBox.SelectedItem),true);
			OnOptionChange();
		}

		private void maxWidthUpDown_ValueChanged(object sender, System.EventArgs e)
		{
			options.MaxWidth=(int)maxWidthUpDown.Value;
			OnOptionChange();
		}

		private void minWidthUpDown_ValueChanged(object sender, System.EventArgs e)
		{
			options.MinWidth=(int)minWidthUpDown.Value;
			maxWidthUpDown.Minimum=minWidthUpDown.Value;
			if (maxWidthUpDown.Value<minWidthUpDown.Value)
			{
				maxWidthUpDown.Value=minWidthUpDown.Value;
			}
			options.MinWidth=(int)minWidthUpDown.Value;
			OnOptionChange();
		}


		private void StringOptionsControl_Load(object sender, System.EventArgs e)
		{
			commentlist = new ArrayList();
			commentlist.AddRange(comments);
			characterComboBox.Items.AddRange((object[])commentlist.ToArray(typeof(object)));
			alignmentComboBox.Items.AddRange( Enum.GetNames(typeof(Align)));
			this.stringOptionsGroupBox.Enabled=false;
		}

		private void truncateCheckBox_CheckedChanged(object sender, System.EventArgs e)
		{
			options.Truncate=truncateCheckBox.Checked;
		}

		
	}

	public delegate void StringOptionsChangeHandler(object sender,StringOptionsChangeEventArgs e);
	public class StringOptionsChangeEventArgs : EventArgs
	{
		private StringOptions opts;

		public StringOptionsChangeEventArgs(StringOptions newopts)
		{
			this.opts=newopts;
		}

		public StringOptions Options
		{
			get
			{
				return this.opts;
			}
		}
	}
}
