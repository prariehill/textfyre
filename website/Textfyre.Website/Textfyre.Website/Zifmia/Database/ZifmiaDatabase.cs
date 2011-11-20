﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Diagnostics;

using Zifmia.Model;

using Eloquera.Client;

namespace Zifmia.Service.Database
{
    public class ZifmiaDatabase : IDisposable
    {
        public const Int64 BASE_KEY = 178956969;
        public const Int64 BASE_ID = 0;

        public static Int64 GetMaxDiskUsage
        {
            get
            {
                return Convert.ToInt64(ConfigurationManager.AppSettings["maxDiskUsage"]);
            }
        }

        public ZifmiaRegistrationStatus CheckPlayerIsUnqiue(ZifmiaPlayer player)
        {
            ZifmiaRegistrationStatus status = ZifmiaRegistrationStatus.Succeeded;

            using (DB db = EQ.GetInstance.DB)
            {

                int count = (from ZifmiaPlayer p in db where p.Username == player.Username select p).Count<ZifmiaPlayer>();

                if (count > 0)
                {
                    status = ZifmiaRegistrationStatus.UsernameExists;
                }
                else
                {
                    count = (from ZifmiaPlayer p in db where p.NickName == player.NickName select p).Count<ZifmiaPlayer>();

                    if (count > 0)
                    {
                        status = ZifmiaRegistrationStatus.NickNameExists;
                    }
                    else
                    {
                        count = (from ZifmiaPlayer p in db where p.EmailAddress == player.EmailAddress select p).Count<ZifmiaPlayer>();

                        if (count > 0)
                        {
                            status = ZifmiaRegistrationStatus.EmailAddressExists;
                        }
                    }
                }

                db.Close();
            }

            return status;
        }

        public ZifmiaPlayer GetPlayerByValidationId(string validtionId)
        {
            ZifmiaPlayer player = null;

            using (DB db = EQ.GetInstance.DB)
            {
                player = (from ZifmiaPlayer p in db where p.ValidationId == validtionId select p).FirstOrDefault<ZifmiaPlayer>();
                if (player != null)
                    player.UID = db.GetUid(player);
                db.Close();
            }

            return player;
        }

        public ZifmiaPlayer GetPlayerByAuthKey(string authKey)
        {
            ZifmiaPlayer player = null;

            using (DB db = EQ.GetInstance.DB)
            {
                player = (from ZifmiaPlayer p in db where p.AuthKey == authKey select p).FirstOrDefault<ZifmiaPlayer>();
                if (player != null)
                    player.UID = db.GetUid(player);
                db.Close();
            }

            return player;
        }

        public ZifmiaPlayer GetPlayerByUsername(string username)
        {
            ZifmiaPlayer player = null;

            using (DB db = EQ.GetInstance.DB)
            {
                player = (from ZifmiaPlayer p in db where p.Username == username select p).FirstOrDefault<ZifmiaPlayer>();
                if (player != null)
                    player.UID = db.GetUid(player);
                db.Close();
            }

            return player;
        }

        public ZifmiaPlayer GetPlayerByUsernamePassword(string username, string password)
        {
            ZifmiaPlayer player = null;

            using (DB db = EQ.GetInstance.DB)
            {
                player = (from ZifmiaPlayer p in db where p.Username == username && p.Password == password select p).FirstOrDefault<ZifmiaPlayer>();
                if (player != null)
                    player.UID = db.GetUid(player);
                db.Close();
            }

            return player;
        }

        public ZifmiaStatus DeletePlayer(string username)
        {
            using (DB db = EQ.GetInstance.DB)
            {
                ZifmiaPlayer player = (from ZifmiaPlayer zp in db where zp.Username == username select zp).FirstOrDefault<ZifmiaPlayer>();

                if (player != null)
                    db.Delete(player);
                db.Close();
            }

            return ZifmiaStatus.Success;
        }

        public ZifmiaSessions GetSessionsByPlayer(string playerKey)
        {
            ZifmiaSessions sessions = new ZifmiaSessions();

            using (DB db = EQ.GetInstance.DB)
            {
                Int64 playerId = Int64.Parse(playerKey, NumberStyles.AllowHexSpecifier);
                sessions = new ZifmiaSessions((from ZifmiaSession s in db where s.Owner.UID == playerId select s).ToList<ZifmiaSession>());
                foreach (ZifmiaSession session in sessions.Sessions)
                {
                    session.UID = db.GetUid(session);
                }
                db.Close();
            }

            return sessions;
        }

        public ZifmiaSession GetSessionByKey(string sessionKey)
        {
            ZifmiaSession session = null;

            using (DB db = EQ.GetInstance.DB)
            {
                Int64 sessionId = Int64.Parse(sessionKey, NumberStyles.AllowHexSpecifier);
                session = (from ZifmiaSession s in db where s.UID == sessionId select s).FirstOrDefault<ZifmiaSession>();
                session.UID = db.GetUid(session);
                db.Close();
            }

            return session;
        }

        public Int64 GetDiskUsageByPlayer(string playerKey)
        {
            Int64 diskUsage = 0;
            List<ZifmiaSession> sessions = null;

            using (DB db = EQ.GetInstance.DB)
            {
                sessions = (from ZifmiaSession s in db select s).ToList<ZifmiaSession>();
                db.Close();
            }

            foreach (ZifmiaSession session in sessions)
            {
                diskUsage = diskUsage + session.DiskUsage;
            }

            return diskUsage;
        }

        public ZifmiaGame GetGame(string gameKey)
        {
            ZifmiaGame game = null;
            Int64 gameId = Int64.Parse(gameKey, NumberStyles.AllowHexSpecifier);

            using (DB db = EQ.GetInstance.DB)
            {
                game = (from ZifmiaGame g in db where g.UID == gameId select g).First<ZifmiaGame>();
                game.UID = db.GetUid(game);
                db.Close();
            }

            return game;
        }

        public List<ZifmiaGame> GetInstalledGames()
        {
            List<ZifmiaGame> games = new List<ZifmiaGame>();

            using (DB db = EQ.GetInstance.DB)
            {
                games = (from ZifmiaGame game in db select game).ToList<ZifmiaGame>();
                db.Close();
            }

            return games;
        }

        public ZifmiaPlayer GetPlayer(string playerKey)
        {
            ZifmiaPlayer player = null;
            Int64 playerId = Int64.Parse(playerKey, NumberStyles.AllowHexSpecifier);

            using (DB db = EQ.GetInstance.DB)
            {
                player = (from ZifmiaPlayer p in db where p.UID == playerId select p).First<ZifmiaPlayer>();
                player.UID = db.GetUid(player);
                db.Close();
            }

            return player;
        }

        public static bool IsNetworkAvailable
        {
            get
            {
                if (ConfigurationManager.AppSettings["networkAvailable"] == "true")
                    return true;
                else
                    return false;
            }
        }

        public static bool UnitTesting
        {
            get
            {
                if (ConfigurationManager.AppSettings["unitTesting"] == "true")
                    return true;
                else
                    return false;
            }
        }

        public static bool TraceMessages
        {
            get
            {
                if (Convert.ToString(ConfigurationManager.AppSettings["trace"]) == "true")
                    return true;
                else
                    return false;
            }
        }

        public static void WriteTrace(string message)
        {
            if (ZifmiaDatabase.TraceMessages)
            {
                Debug.WriteLine(String.Format("{0}: {1}", System.DateTime.Now.ToString("hh:MM:ss.fff"), message));
            }
        }

        public void Save(ZifmiaGame game)
        {
            using (DB db = EQ.GetInstance.DB)
            {
                db.Store(game.UID, game);
                db.Close();
            }
        }

        public void Save(ZifmiaPlayer player)
        {
            using (DB db = EQ.GetInstance.DB)
            {
                db.Store(player.UID, player);
                db.Close();
            }
        }

        public void Save(ZifmiaSession session)
        {
            Int64 diskUsage = 0;
            foreach (ZifmiaBranch branch in session.Branches)
            {
                foreach (ZifmiaNode node in branch.Nodes)
                {
                    diskUsage = diskUsage + node.EngineLength;
                }
            }
            session.DiskUsage = diskUsage;

            using (DB db = EQ.GetInstance.DB)
            {
                db.Store(session.UID, session);
                db.Close();
            }
        }

        public void Dispose()
        {
            using (DB db = EQ.GetInstance.DB)
            {
                db.Dispose();
            }
        }
    }
}