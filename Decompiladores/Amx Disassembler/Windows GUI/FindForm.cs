using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace GUI
{
	public class FindForm : System.Windows.Forms.Form
	{
		private RichTextBox textbox;
		private RichTextBoxFinds finds;

		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Button CloseButton;
		private System.Windows.Forms.CheckBox matchCaseCheckBox;
		private System.Windows.Forms.CheckBox matchWordCheckBox;
		private System.Windows.Forms.CheckBox searchUpCheckBox;
		private System.Windows.Forms.Button findNextButton;
		private System.Windows.Forms.ComboBox findTextBox;

		private System.ComponentModel.Container components = null;

		public FindForm(RichTextBox textbox)
		{
			if (textbox==null)
			{
				throw new ArgumentNullException();
			}
			this.textbox = textbox;
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

		#region Windows Form Designer generated code
		private void InitializeComponent()
		{
			this.findTextBox = new System.Windows.Forms.ComboBox();
			this.findNextButton = new System.Windows.Forms.Button();
			this.button2 = new System.Windows.Forms.Button();
			this.CloseButton = new System.Windows.Forms.Button();
			this.matchCaseCheckBox = new System.Windows.Forms.CheckBox();
			this.matchWordCheckBox = new System.Windows.Forms.CheckBox();
			this.searchUpCheckBox = new System.Windows.Forms.CheckBox();
			this.SuspendLayout();
			// 
			// findTextBox
			// 
			this.findTextBox.Location = new System.Drawing.Point(5, 5);
			this.findTextBox.Name = "findTextBox";
			this.findTextBox.Size = new System.Drawing.Size(240, 21);
			this.findTextBox.TabIndex = 1;
			this.findTextBox.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.findTextBox_KeyPress);
			// 
			// findNextButton
			// 
			this.findNextButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.findNextButton.Location = new System.Drawing.Point(250, 5);
			this.findNextButton.Name = "findNextButton";
			this.findNextButton.Size = new System.Drawing.Size(85, 23);
			this.findNextButton.TabIndex = 2;
			this.findNextButton.Text = "Find Next";
			this.findNextButton.Click += new System.EventHandler(this.findNextButton_Click);
			// 
			// button2
			// 
			this.button2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.button2.Enabled = false;
			this.button2.Location = new System.Drawing.Point(250, 35);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(85, 23);
			this.button2.TabIndex = 3;
			this.button2.Text = "button";
			// 
			// CloseButton
			// 
			this.CloseButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.CloseButton.Location = new System.Drawing.Point(250, 65);
			this.CloseButton.Name = "CloseButton";
			this.CloseButton.Size = new System.Drawing.Size(85, 23);
			this.CloseButton.TabIndex = 4;
			this.CloseButton.Text = "Close";
			this.CloseButton.Click += new System.EventHandler(this.CloseButton_Click);
			// 
			// matchCaseCheckBox
			// 
			this.matchCaseCheckBox.Location = new System.Drawing.Point(5, 30);
			this.matchCaseCheckBox.Name = "matchCaseCheckBox";
			this.matchCaseCheckBox.Size = new System.Drawing.Size(130, 20);
			this.matchCaseCheckBox.TabIndex = 6;
			this.matchCaseCheckBox.Text = "Match &case";
			this.matchCaseCheckBox.CheckedChanged += new System.EventHandler(this.matchCaseCheckBox_CheckedChanged);
			// 
			// matchWordCheckBox
			// 
			this.matchWordCheckBox.Location = new System.Drawing.Point(5, 50);
			this.matchWordCheckBox.Name = "matchWordCheckBox";
			this.matchWordCheckBox.Size = new System.Drawing.Size(130, 20);
			this.matchWordCheckBox.TabIndex = 7;
			this.matchWordCheckBox.Text = "Match &whole word";
			this.matchWordCheckBox.CheckedChanged += new System.EventHandler(this.matchWordCheckBox_CheckedChanged);
			// 
			// searchUpCheckBox
			// 
			this.searchUpCheckBox.Location = new System.Drawing.Point(5, 70);
			this.searchUpCheckBox.Name = "searchUpCheckBox";
			this.searchUpCheckBox.Size = new System.Drawing.Size(130, 20);
			this.searchUpCheckBox.TabIndex = 8;
			this.searchUpCheckBox.Text = "Search &up";
			this.searchUpCheckBox.CheckedChanged += new System.EventHandler(this.searchUpCheckBox_CheckedChanged);
			// 
			// FindForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(342, 93);
			this.Controls.Add(this.searchUpCheckBox);
			this.Controls.Add(this.matchWordCheckBox);
			this.Controls.Add(this.matchCaseCheckBox);
			this.Controls.Add(this.CloseButton);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.findNextButton);
			this.Controls.Add(this.findTextBox);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "FindForm";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "Find";
			this.ResumeLayout(false);

		}
		#endregion

		private void matchCaseCheckBox_CheckedChanged(object sender, System.EventArgs e)
		{
			finds^=RichTextBoxFinds.MatchCase;		
		}

		private void matchWordCheckBox_CheckedChanged(object sender, System.EventArgs e)
		{
			finds^=RichTextBoxFinds.WholeWord;	
		}

		private void searchUpCheckBox_CheckedChanged(object sender, System.EventArgs e)
		{
			finds^=RichTextBoxFinds.Reverse;	
		}


		private void findNextButton_Click(object sender, System.EventArgs e)
		{
			if ( (finds & RichTextBoxFinds.Reverse) == RichTextBoxFinds.Reverse)
			{
				textbox.Find(findTextBox.Text,0,textbox.SelectionStart,finds);
			}
			else 
			{
				textbox.Find(findTextBox.Text,textbox.SelectionStart+textbox.SelectionLength,textbox.TextLength,finds);
			}
			
			textbox.Focus();
			textbox.SendToBack();
		}

		private void CloseButton_Click(object sender, System.EventArgs e)
		{
			this.Close();
		}

		private void findTextBox_KeyPress(object sender, System.Windows.Forms.KeyPressEventArgs e)
		{
			//if (e.KeyChar==Keys.Enter)
			//{
			//}
		}
	}
}
