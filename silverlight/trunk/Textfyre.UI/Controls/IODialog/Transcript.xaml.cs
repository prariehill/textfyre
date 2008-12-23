﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Text.RegularExpressions;
using System.Windows.Browser;

namespace Textfyre.UI.Controls.IODialog
{
    public partial class Transcript : UserControl
    {
        public Transcript()
        {
            InitializeComponent();
            Current.Font.ApplyFont(Textfyre.UI.Current.Font.FontType.Header, DialogTitle);
            DialogTitle.FontSize = 24d;
        }

        public void Show()
        {
            this.Visibility = Visibility.Visible;
        }

        public void Hide()
        {
            this.Visibility = Visibility.Collapsed;
        }

        public void AddText(string text)
        {
            string transcript = text.Replace("<Paragraph>", System.Environment.NewLine + "<Paragraph>").Replace("</Paragraph>", "</Paragraph>" + System.Environment.NewLine);

            TranscriptText.Text += RemoveTags(transcript);
        }

        private string RemoveTags(string text)
        {
            return Regex.Replace(text, @"<(.|\n)*?>", string.Empty);
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            Hide();
        }

        private void BtnCopySelection_Click(object sender, RoutedEventArgs e)
        {
            DisplayPopup(this.TranscriptText.SelectedText);
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            DisplayPopup(this.TranscriptText.Text);
        }

        private void DisplayPopup(string transcript)
        {
            System.Windows.Browser.HtmlPopupWindowOptions opt = new System.Windows.Browser.HtmlPopupWindowOptions();
            opt.Directories = false;
            opt.Location = false;
            opt.Menubar = false;
            opt.Status = false;
            opt.Toolbar = false;

            Textfyre.UI.Transcript.Lib.IO.Set(transcript);

            string org = System.Windows.Browser.HtmlPage.Document.DocumentUri.OriginalString;
            Uri uri = new Uri(org.Replace("Default.htm", "Transcript.htm"), UriKind.Absolute);
            System.Windows.Browser.HtmlWindow winTranscript = System.Windows.Browser.HtmlPage.PopupWindow(uri, "Transcript", opt);

        }
    }
}
