using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace GUI
{
	using Amx.Core;
	using Files;

	public class AmxxChoice : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Button okButton;
		private System.Windows.Forms.Button cancelButton;
		private System.Windows.Forms.RadioButton choice16RadioButton;
		private System.Windows.Forms.RadioButton choice32RadioButton;
		private System.Windows.Forms.RadioButton choice64RadioButton;

		private IAmxDescription retval;
		private bool allowresult;

		private System.ComponentModel.Container components = null;

		public AmxxChoice(IAmxContainer container)
		{
			InitializeComponent();
		
			choice32RadioButton.Text="32 bit, " + container.Name;
			choice16RadioButton.Text="16 bit, " + container.Name;
			choice64RadioButton.Text="64 bit, " + container.Name;
			foreach (IAmxDescription desc in container)
			{
				switch (desc.Bits)
				{
					case Bits._16:
						choice16RadioButton.Enabled=true;
						choice16RadioButton.Tag=desc;
						break;
					case Bits._32:
						choice32RadioButton.Enabled=true;
						choice32RadioButton.Tag=desc;
						break;
					case Bits._64:
						choice64RadioButton.Enabled=true;
						choice64RadioButton.Tag=desc;
						
						break;
				}
			}

			retval = null;
		}

		~AmxxChoice()
		{
			this.Dispose();
		}

		protected override void Dispose( bool disposing )
		{
			retval = null;
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
			this.okButton = new System.Windows.Forms.Button();
			this.cancelButton = new System.Windows.Forms.Button();
			this.choice16RadioButton = new System.Windows.Forms.RadioButton();
			this.choice32RadioButton = new System.Windows.Forms.RadioButton();
			this.choice64RadioButton = new System.Windows.Forms.RadioButton();
			this.SuspendLayout();
			// 
			// okButton
			// 
			this.okButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.okButton.Location = new System.Drawing.Point(45, 82);
			this.okButton.Name = "okButton";
			this.okButton.Size = new System.Drawing.Size(70, 23);
			this.okButton.TabIndex = 0;
			this.okButton.Text = "Accept";
			this.okButton.Click += new System.EventHandler(this.okButton_Click);
			// 
			// cancelButton
			// 
			this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.cancelButton.Location = new System.Drawing.Point(120, 82);
			this.cancelButton.Name = "cancelButton";
			this.cancelButton.Size = new System.Drawing.Size(70, 23);
			this.cancelButton.TabIndex = 1;
			this.cancelButton.Text = "Cancel";
			this.cancelButton.Click += new System.EventHandler(this.cancelButton_Click);
			// 
			// choice16RadioButton
			// 
			this.choice16RadioButton.Enabled = false;
			this.choice16RadioButton.Location = new System.Drawing.Point(10, 5);
			this.choice16RadioButton.Name = "choice16RadioButton";
			this.choice16RadioButton.Size = new System.Drawing.Size(170, 20);
			this.choice16RadioButton.TabIndex = 2;
			this.choice16RadioButton.CheckedChanged += new System.EventHandler(this.choiceRadioButton_CheckedChanged);
			// 
			// choice32RadioButton
			// 
			this.choice32RadioButton.Enabled = false;
			this.choice32RadioButton.Location = new System.Drawing.Point(10, 30);
			this.choice32RadioButton.Name = "choice32RadioButton";
			this.choice32RadioButton.Size = new System.Drawing.Size(170, 20);
			this.choice32RadioButton.TabIndex = 3;
			this.choice32RadioButton.CheckedChanged += new System.EventHandler(this.choiceRadioButton_CheckedChanged);
			// 
			// choice64RadioButton
			// 
			this.choice64RadioButton.Enabled = false;
			this.choice64RadioButton.Location = new System.Drawing.Point(10, 55);
			this.choice64RadioButton.Name = "choice64RadioButton";
			this.choice64RadioButton.Size = new System.Drawing.Size(165, 20);
			this.choice64RadioButton.TabIndex = 4;
			this.choice64RadioButton.CheckedChanged += new System.EventHandler(this.choiceRadioButton_CheckedChanged);
			// 
			// AmxxChoice
			// 
			this.AcceptButton = this.okButton;
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.cancelButton;
			this.ClientSize = new System.Drawing.Size(194, 110);
			this.ControlBox = false;
			this.Controls.Add(this.choice64RadioButton);
			this.Controls.Add(this.choice32RadioButton);
			this.Controls.Add(this.choice16RadioButton);
			this.Controls.Add(this.cancelButton);
			this.Controls.Add(this.okButton);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.Name = "AmxxChoice";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "Amx File Choice";
			this.ResumeLayout(false);

		}
		#endregion

		
		new public IAmxDescription ShowDialog(IWin32Window owner)
		{
			base.ShowDialog(owner);
			if(allowresult)
			{
				return retval;
			}
			else
			{
				return null;
			}
		}

		private void choiceRadioButton_CheckedChanged(object sender, System.EventArgs e)
		{
			RadioButton button = sender as RadioButton;
			if (button!=null)
			{
				retval = button.Tag as IAmxDescription;
			}
			else
			{
				retval=null;
			}
		
		}

		private void okButton_Click(object sender, System.EventArgs e)
		{
			allowresult=true;
			this.Close();
		}

		private void cancelButton_Click(object sender, System.EventArgs e)
		{
			allowresult=false;
			this.Close();
		}


		public IAmxDescription Choice
		{
			get
			{
				if (allowresult)
				{
					return retval;
				}
				else
				{
					return null;
				}
			}
		}
	}
}
