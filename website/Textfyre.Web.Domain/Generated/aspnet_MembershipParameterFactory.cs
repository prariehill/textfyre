/*
 *  DO NOT EDIT THIS CLASS.
 * 
 *  This class is generated by a tool and should not be edited. If you need to change the functionality of 
 *  this class, you should discuss your changes with the team and they should be implemented in the
 *  appropriate template.
 *  
 */
using System;
using System.Data;
using System.Data.SqlClient;

namespace Textfyre.TextfyreWeb.DataLayer { 
    /// <summary>
    /// Factory class that auto-builds SqlParameters.
    /// </summary>
    [Serializable()]
    public class aspnet_MembershipParameterFactory {
        /// <summary>
        /// GetParameter method returns a SqlParameter.
        /// </summary>
        public SqlParameter GetParameter(Textfyre.TextfyreWeb.DataLayer.aspnet_MembershipFields FieldIdentity, object FieldValue) { 
            SqlParameter param = null;
            switch (FieldIdentity) {
				case aspnet_MembershipFields.ApplicationId:
					param = new SqlParameter("@ApplicationId", SqlDbType.UniqueIdentifier);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "ApplicationId";
					break;
				case aspnet_MembershipFields.UserId:
					param = new SqlParameter("@UserId", SqlDbType.UniqueIdentifier);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "UserId";
					break;
				case aspnet_MembershipFields.Password:
					param = new SqlParameter("@Password", SqlDbType.NVarChar, 128);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "Password";
					break;
				case aspnet_MembershipFields.PasswordFormat:
					param = new SqlParameter("@PasswordFormat", SqlDbType.Int);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "PasswordFormat";
					break;
				case aspnet_MembershipFields.PasswordSalt:
					param = new SqlParameter("@PasswordSalt", SqlDbType.NVarChar, 128);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "PasswordSalt";
					break;
				case aspnet_MembershipFields.MobilePIN:
					param = new SqlParameter("@MobilePIN", SqlDbType.NVarChar, 16);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = true;
					param.SourceColumn = "MobilePIN";
					break;
				case aspnet_MembershipFields.Email:
					param = new SqlParameter("@Email", SqlDbType.NVarChar, 256);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = true;
					param.SourceColumn = "Email";
					break;
				case aspnet_MembershipFields.LoweredEmail:
					param = new SqlParameter("@LoweredEmail", SqlDbType.NVarChar, 256);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = true;
					param.SourceColumn = "LoweredEmail";
					break;
				case aspnet_MembershipFields.PasswordQuestion:
					param = new SqlParameter("@PasswordQuestion", SqlDbType.NVarChar, 256);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = true;
					param.SourceColumn = "PasswordQuestion";
					break;
				case aspnet_MembershipFields.PasswordAnswer:
					param = new SqlParameter("@PasswordAnswer", SqlDbType.NVarChar, 128);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = true;
					param.SourceColumn = "PasswordAnswer";
					break;
				case aspnet_MembershipFields.IsApproved:
					param = new SqlParameter("@IsApproved", SqlDbType.Bit);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "IsApproved";
					break;
				case aspnet_MembershipFields.IsLockedOut:
					param = new SqlParameter("@IsLockedOut", SqlDbType.Bit);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "IsLockedOut";
					break;
				case aspnet_MembershipFields.CreateDate:
					param = new SqlParameter("@CreateDate", SqlDbType.DateTime);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "CreateDate";
					break;
				case aspnet_MembershipFields.LastLoginDate:
					param = new SqlParameter("@LastLoginDate", SqlDbType.DateTime);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "LastLoginDate";
					break;
				case aspnet_MembershipFields.LastPasswordChangedDate:
					param = new SqlParameter("@LastPasswordChangedDate", SqlDbType.DateTime);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "LastPasswordChangedDate";
					break;
				case aspnet_MembershipFields.LastLockoutDate:
					param = new SqlParameter("@LastLockoutDate", SqlDbType.DateTime);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "LastLockoutDate";
					break;
				case aspnet_MembershipFields.FailedPasswordAttemptCount:
					param = new SqlParameter("@FailedPasswordAttemptCount", SqlDbType.Int);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "FailedPasswordAttemptCount";
					break;
				case aspnet_MembershipFields.FailedPasswordAttemptWindowStart:
					param = new SqlParameter("@FailedPasswordAttemptWindowStart", SqlDbType.DateTime);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "FailedPasswordAttemptWindowStart";
					break;
				case aspnet_MembershipFields.FailedPasswordAnswerAttemptCount:
					param = new SqlParameter("@FailedPasswordAnswerAttemptCount", SqlDbType.Int);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "FailedPasswordAnswerAttemptCount";
					break;
				case aspnet_MembershipFields.FailedPasswordAnswerAttemptWindowStart:
					param = new SqlParameter("@FailedPasswordAnswerAttemptWindowStart", SqlDbType.DateTime);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = false;
					param.SourceColumn = "FailedPasswordAnswerAttemptWindowStart";
					break;
				case aspnet_MembershipFields.Comment:
					param = new SqlParameter("@Comment", SqlDbType.NText, 1073741823);
					param.Value = FieldValue;
					param.Direction = ParameterDirection.Input;
					param.IsNullable = true;
					param.SourceColumn = "Comment";
					break;
            }

            if(param == null)
                throw new Exception("Unknown parameter identifier.");

            return param;
        }
    }
}