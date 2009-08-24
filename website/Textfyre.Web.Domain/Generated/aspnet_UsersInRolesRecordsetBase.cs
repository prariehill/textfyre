/*
 *  DO NOT EDIT THIS CLASS.
 * 
 *  This class is generated by a tool and should not be edited. If you need to change the functionality of 
 *  this class, you should discuss your changes with the team and they should be implemented in the
 *  appropriate template.
 *  
 */
using System;

namespace Textfyre.TextfyreWeb.BusinessLayer {   
    /// <summary>
    /// aspnet_UsersInRolesRecordsetBase class.
    /// </summary>
    [Serializable()]
    public abstract class aspnet_UsersInRolesRecordsetBase { 
      #region Members

			/// <summary>
			/// UserId field.
			/// </summary>
			private Guid _UserId = Guid.Empty;
			/// <summary>
			/// RoleId field.
			/// </summary>
			private Guid _RoleId = Guid.Empty;
      /// <summary>
      /// _isDirty field.
      /// </summary>
      private bool _isDirty = false;
      /// <summary>
      /// _isDeleted field.
      /// </summary>
      private bool _isDeleted = false;
      /// <summary>
      /// _isInserted field.
      /// </summary>
      private bool _isInserted = false;
      #endregion 

      #region Properties
        

		public Guid UserId {
			get { return _UserId; }
			set {
				if(_UserId != value) {
					_isDirty = true;
					_UserId = value;
				}
			}
		}

		public Guid RoleId {
			get { return _RoleId; }
			set {
				if(_RoleId != value) {
					_isDirty = true;
					_RoleId = value;
				}
			}
		}

        
      /// <summary>
      /// Flag for when recordset data has changed.
      /// </summary>
      public bool IsDirty { 
          get { return _isDirty; } 
          set { _isDirty = value; } 
      } 
        
      /// <summary>
      /// Delete flag.
      /// </summary>
      public bool IsDeleted { 
          get { return _isDeleted; } 
          set { _isDeleted = value; } 
      }

      /// <summary>
      /// Insert flag for composite keys only.
      /// </summary>
      public bool IsInserted {
          get { return _isInserted; }
          set { _isInserted = value; }
      }
        
      #endregion 
        
      /// <summary>
      /// Empty constructor.
      /// </summary>
      public aspnet_UsersInRolesRecordsetBase() {
      } 

      /// <summary>
      /// Returns a new instance of the current recordset.
      /// </summary>
      /// <returns></returns>
      public virtual aspnet_UsersInRolesRecordset Clone() {
          aspnet_UsersInRolesRecordset newaspnet_UsersInRolesRS = new aspnet_UsersInRolesRecordset(); 
          newaspnet_UsersInRolesRS.UserId = _UserId;
					newaspnet_UsersInRolesRS.RoleId = _RoleId;
					
          newaspnet_UsersInRolesRS.IsDirty = _isDirty;
          newaspnet_UsersInRolesRS.IsDeleted = _isDeleted;
          return newaspnet_UsersInRolesRS; 
      }

      /// <summary>
      /// Sets the identity column.
      /// </summary>
      /// <param name="IdentityValue"></param>
		public void SetIdentity(Guid UserId, Guid RoleId) {
			_UserId = UserId;
			_RoleId = RoleId;

		}

    } 
} 