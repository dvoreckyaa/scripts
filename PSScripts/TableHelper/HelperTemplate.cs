using $ModelNamespace$;

using Epicor;

using Erp.Tablesets;

using Ice;
using Ice.Extensions;

using System;

namespace $Namespace$
{
    internal class PTInvcTaxHelper
    {
        public static string SchemaName = "$SchemaName$";
        public static string TableName = "$TableName$";
        public static string FullTableName = SchemaName + "_" + TableName;
    }

    internal class $TableClassName$
    {
        public readonly ExtensionTable ExtensionTable;

        public static $TableClassName$ CreateTable(IceTableset tableset)
        {
            $TableClassName$ result = null;
            if (tableset != null)
            {
                ExtensionTable exTable = tableset.ExtensionTables[PTInvcTaxHelper.FullTableName];
                if (exTable != null)
                {
                    result = new $TableClassName$(exTable);
                }
            }
            
            return result;
        }

        private $TableClassName$(ExtensionTable extensionTable)
        {
            ParamGuard.NotNull(extensionTable, nameof(extensionTable));

            if (!extensionTable.SchemaName.Equals(PTInvcTaxHelper.SchemaName, StringComparison.OrdinalIgnoreCase)
                || !extensionTable.TableName.Equals(PTInvcTaxHelper.TableName, StringComparison.OrdinalIgnoreCase))
            {
                throw new ArgumentException($"Extension table must be {PTInvcTaxHelper.SchemaName}.{PTInvcTaxHelper.TableName} table");
            }

            this.ExtensionTable = extensionTable;
        }

        public static implicit operator ExtensionTable($TableClassName$ table)
        {
            return table.ExtensionTable;
        }

        public $RowClassName$ Find$RowClassName$($BaseRow$ tableRow)
        {
            $RowClassName$ result = null;
            if (tableRow != null)
            {
                ExtensionRow exRow = tableRow.FindPeerExtensionRow(this.ExtensionTable);
                if (exRow != null)
                {
                    result = new $RowClassName$(exRow);
                }
            }

            return result;
        }
    }

    internal class $RowClassName$
    {
        public readonly ExtensionRow ExtensionRow;

        public $RowClassName$(ExtensionRow extensionRow)
        {
            ParamGuard.NotNull(extensionRow, nameof(extensionRow));

            if (!extensionRow.Table.Columns.Contains(PTInvcTax.ColumnNames.ExemptionReasonCode))
            {
                throw new ArgumentException($"Extension row must be {PTInvcTaxHelper.SchemaName}.{PTInvcTaxHelper.TableName} row");
            }

            this.ExtensionRow = extensionRow;            
        }

        public static implicit operator ExtensionRow($RowClassName$ $RowClassName$)
        {
            return $RowClassName$.ExtensionRow;
        }

        #region Public properties

        $ExtensionColumns$

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        public string RowMod
        {
            get { return this.ExtensionRow.RowMod; }
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        public Guid SysRowID
        {
            get { return this.ExtensionRow.SysRowID; }
        }

        #endregion

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        public bool Added()
        {
            return this.ExtensionRow.Added();
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        public bool Deleted()
        {
            return this.ExtensionRow.Deleted();
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        public bool Unchanged()
        {
            return this.ExtensionRow.Unchanged();
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        public bool Updated()
        {
            return this.ExtensionRow.Updated();
        }
    }
}
