using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Windows.Forms;

namespace GUI
{
	using Amx.Core;

	public class NumberOptionsControl : System.Windows.Forms.UserControl
	{
		private System.Windows.Forms.GroupBox numberOptionsGroupBox;
		private System.Windows.Forms.Label alignmentLabel;
		private System.Windows.Forms.Label minWidthLabel;
		private System.Windows.Forms.Label maxWidthLabel;
		private System.Windows.Forms.NumericUpDown minWidthUpDown;
		private System.Windows.Forms.ComboBox alignmentComboBox;
		private System.Windows.Forms.NumericUpDown maxWidthUpDown;
		private System.ComponentModel.Container components = null;

		private bool optionsset;
		private bool inload;
		private System.Windows.Forms.Label formatLabel;
		private System.Windows.Forms.ComboBox formatComboBox;
		private System.Windows.Forms.Label characterLabel;
		private System.Windows.Forms.ComboBox characterComboBox;
		private System.Windows.Forms.Label numberWidthLabel;
		private System.Windows.Forms.NumericUpDown numberWidthUpDown;
		private NumberOptions options;
		public event NumberOptionsChangeHandler OptionChange;

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


		public NumberOptionsControl()
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
			this.numberOptionsGroupBox = new System.Windows.Forms.GroupBox();
			this.numberWidthLabel = new System.Windows.Forms.Label();
			this.numberWidthUpDown = new System.Windows.Forms.NumericUpDown();
			this.characterLabel = new System.Windows.Forms.Label();
			this.characterComboBox = new System.Windows.Forms.ComboBox();
			this.formatLabel = new System.Windows.Forms.Label();
			this.alignmentLabel = new System.Windows.Forms.Label();
			this.minWidthLabel = new System.Windows.Forms.Label();
			this.maxWidthLabel = new System.Windows.Forms.Label();
			this.formatComboBox = new System.Windows.Forms.ComboBox();
			this.minWidthUpDown = new System.Windows.Forms.NumericUpDown();
			this.alignmentComboBox = new System.Windows.Forms.ComboBox();
			this.maxWidthUpDown = new System.Windows.Forms.NumericUpDown();
			this.numberOptionsGroupBox.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.numberWidthUpDown)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.minWidthUpDown)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.maxWidthUpDown)).BeginInit();
			this.SuspendLayout();
			// 
			// numberOptionsGroupBox
			// 
			this.numberOptionsGroupBox.Controls.Add(this.numberWidthLabel);
			this.numberOptionsGroupBox.Controls.Add(this.numberWidthUpDown);
			this.numberOptionsGroupBox.Controls.Add(this.characterLabel);
			this.numberOptionsGroupBox.Controls.Add(this.characterComboBox);
			this.numberOptionsGroupBox.Controls.Add(this.formatLabel);
			this.numberOptionsGroupBox.Controls.Add(this.alignmentLabel);
			this.numberOptionsGroupBox.Controls.Add(this.minWidthLabel);
			this.numberOptionsGroupBox.Controls.Add(this.maxWidthLabel);
			this.numberOptionsGroupBox.Controls.Add(this.formatComboBox);
			this.numberOptionsGroupBox.Controls.Add(this.minWidthUpDown);
			this.numberOptionsGroupBox.Controls.Add(this.alignmentComboBox);
			this.numberOptionsGroupBox.Controls.Add(this.maxWidthUpDown);
			this.numberOptionsGroupBox.Location = new System.Drawing.Point(0, 0);
			this.numberOptionsGroupBox.Name = "numberOptionsGroupBox";
			this.numberOptionsGroupBox.Size = new System.Drawing.Size(135, 165);
			this.numberOptionsGroupBox.TabIndex = 0;
			this.numberOptionsGroupBox.TabStop = false;
			// 
			// numberWidthLabel
			// 
			this.numberWidthLabel.Location = new System.Drawing.Point(5, 65);
			this.numberWidthLabel.Name = "numberWidthLabel";
			this.numberWidthLabel.Size = new System.Drawing.Size(80, 20);
			this.numberWidthLabel.TabIndex = 11;
			this.numberWidthLabel.Text = "Number Width";
			this.numberWidthLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// numberWidthUpDown
			// 
			this.numberWidthUpDown.Location = new System.Drawing.Point(90, 65);
			this.numberWidthUpDown.Maximum = new System.Decimal(new int[] {
																			  20,
																			  0,
																			  0,
																			  0});
			this.numberWidthUpDown.Name = "numberWidthUpDown";
			this.numberWidthUpDown.Size = new System.Drawing.Size(40, 20);
			this.numberWidthUpDown.TabIndex = 10;
			this.numberWidthUpDown.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
			this.numberWidthUpDown.ValueChanged += new System.EventHandler(this.numberWidthUpDown_ValueChanged);
			// 
			// characterLabel
			// 
			this.characterLabel.Location = new System.Drawing.Point(5, 90);
			this.characterLabel.Name = "characterLabel";
			this.characterLabel.Size = new System.Drawing.Size(60, 20);
			this.characterLabel.TabIndex = 9;
			this.characterLabel.Text = "Character";
			this.characterLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// characterComboBox
			// 
			this.characterComboBox.Location = new System.Drawing.Point(90, 90);
			this.characterComboBox.MaxLength = 1;
			this.characterComboBox.Name = "characterComboBox";
			this.characterComboBox.Size = new System.Drawing.Size(40, 21);
			this.characterComboBox.TabIndex = 8;
			this.characterComboBox.TextChanged += new System.EventHandler(this.characterComboBox_TextChanged);
			this.characterComboBox.SelectedIndexChanged += new System.EventHandler(this.characterComboBox_SelectedIndexChanged);
			// 
			// formatLabel
			// 
			this.formatLabel.Location = new System.Drawing.Point(5, 140);
			this.formatLabel.Name = "formatLabel";
			this.formatLabel.Size = new System.Drawing.Size(40, 20);
			this.formatLabel.TabIndex = 7;
			this.formatLabel.Text = "Format";
			this.formatLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
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
			this.maxWidthLabel.Text = "MaximumWidth";
			this.maxWidthLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// formatComboBox
			// 
			this.formatComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.formatComboBox.Location = new System.Drawing.Point(55, 140);
			this.formatComboBox.MaxLength = 1;
			this.formatComboBox.Name = "formatComboBox";
			this.formatComboBox.Size = new System.Drawing.Size(75, 21);
			this.formatComboBox.TabIndex = 3;
			this.formatComboBox.SelectedIndexChanged += new System.EventHandler(this.formatComboBox_SelectedIndexChanged);
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
			// NumberOptionsControl
			// 
			this.Controls.Add(this.numberOptionsGroupBox);
			this.Name = "NumberOptionsControl";
			this.Size = new System.Drawing.Size(140, 170);
			this.Load += new System.EventHandler(this.NumberOptionsControl_Load);
			this.numberOptionsGroupBox.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.numberWidthUpDown)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.minWidthUpDown)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.maxWidthUpDown)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion

		private void NumberOptionsControl_Load(object sender, System.EventArgs e)
		{
			commentlist = new ArrayList();
			commentlist.AddRange(comments);
			formatComboBox.Items.AddRange( Enum.GetNames(typeof(NumberFormat)));
			alignmentComboBox.Items.AddRange( Enum.GetNames(typeof(Align)));
			characterComboBox.Items.AddRange((object[])commentlist.ToArray(typeof(object)));
			this.numberOptionsGroupBox.Enabled=false;
		}


		public void SetTrackedOptions(NumberOptions options)
		{
			inload=true;
			this.options=options;
			this.alignmentComboBox.SelectedItem=options.Alignment.ToString();
			this.formatComboBox.SelectedItem=options.Format.ToString();
			this.maxWidthUpDown.Value=options.MaxWidth;
			this.minWidthUpDown.Value=options.MinWidth;
			this.numberWidthUpDown.Value=options.NumWidth;
			this.characterComboBox.SelectedItem=this.characterComboBox.Items[this.characterComboBox.Items.IndexOf(options.PadChar.ToString())];			
			optionsset=true;
			inload=false;
		}


		public string Title
		{
			get
			{
				return this.numberOptionsGroupBox.Text;
			}
			set
			{
				this.numberOptionsGroupBox.Text=value;
			}
		}

		new public bool Enabled
		{
			get
			{
				return numberOptionsGroupBox.Enabled;
			}
			set
			{
				if (optionsset)
				{
					numberOptionsGroupBox.Enabled=value;
				}
			}
		}


		protected virtual void OnOptionChange()
		{
			if (!inload && OptionChange!=null)
			{
				OptionChange(this,new NumberOptionsChangeEventArgs(options));
			}
		}


		private void formatComboBox_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			options.Format=(NumberFormat)Enum.Parse(typeof(NumberFormat),((string)formatComboBox.SelectedItem),true);
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
			OnOptionChange();
		}


		private void numberWidthUpDown_ValueChanged(object sender, System.EventArgs e)
		{
			options.NumWidth=(int)numberWidthUpDown.Value;
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





	}

	public delegate void NumberOptionsChangeHandler(object sender,NumberOptionsChangeEventArgs e);
	public class NumberOptionsChangeEventArgs : EventArgs
	{
		private NumberOptions opts;

		public NumberOptionsChangeEventArgs(NumberOptions newopts)
		{
			this.opts=newopts;
		}

		public NumberOptions Options
		{
			get
			{
				return this.opts;
			}
		}
	}
}
