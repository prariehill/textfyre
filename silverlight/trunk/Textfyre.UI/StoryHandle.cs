﻿using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

namespace Textfyre.UI
{
    public class StoryHandle
    {
        public class ParseInputArgs
        {
            public string Input;
            public string TranscriptText;
            public bool ContinueWithInput;

        }

        public virtual ParseInputArgs ParseInput(ParseInputArgs args)
        {
            return args;
        }

        public void ShowManual()
        {
            Current.Game.TextfyreBook.Manual.Show();
        }

        public void HideManual()
        {
            Current.Game.TextfyreBook.Manual.Hide();
        }

        #region :: Toc Select ::
        public class TocArgs
        {
            public Textfyre.UI.Controls.TableOfContent.Action TocItem;
            public Textfyre.UI.Controls.TextfyreBookPage LeftPage;
            public Textfyre.UI.Controls.TextfyreBookPage RightPage;
            public bool GoToItem;
            public bool GoDirectly;
            public bool IsItemHandled;

            public object LeftPageContent
            {
                set
                {
                    LeftPage.PageScrollViewer.Content = value;
                }
            }

            public object RightPageContent
            {
                set
                {
                    RightPage.PageScrollViewer.Content = value;
                }
            }
        }

        /// <summary>
        /// Return true if handled.
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        public virtual bool TocSelect(TocArgs args)
        {
            if (args.GoToItem && args.GoDirectly)
            {
                Current.Game.TextfyreBook.GoTo("MiscPageLeft");
            }
            else if (args.GoToItem && args.GoDirectly == false)
            {
                Current.Game.TextfyreBook.FlipTo("MiscPageLeft");
            }

            return args.IsItemHandled;
        }
        #endregion
    }
}
