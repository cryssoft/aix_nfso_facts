#
#  FACT(S):     aix_nfso
#
#  PURPOSE:     This custom fact returns a hash of "nfso -a" output with
#		name->value.
#
#  RETURNS:     (hash)
#
#  AUTHOR:      Chris Petersen, Crystallized Software
#
#  DATE:        March 16, 2021
#
#  NOTES:       Myriad names and acronyms are trademarked or copyrighted by IBM
#               including but not limited to IBM, PowerHA, AIX, RSCT (Reliable,
#               Scalable Cluster Technology), and CAA (Cluster-Aware AIX).  All
#               rights to such names and acronyms belong with their owner.
#
#		NEVER FORGET!  "\n" and '\n' are not the same in Ruby!
#
#-------------------------------------------------------------------------------
#
#  LAST MOD:    (never)
#
#  MODIFICATION HISTORY:
#
#       (none)
#
#-------------------------------------------------------------------------------
#
Facter.add(:aix_nfso) do
    #  This only applies to the AIX operating system
    confine :osfamily => 'AIX'

    #  Define an empty hash to return
    l_aixNfso = {}

    #  Do the work
    setcode do
        #  Run the command to look at NFS settings
        l_lines = Facter::Util::Resolution.exec('/usr/sbin/nfso -a 2>/dev/null')

        #  Loop over the lines that were returned
        l_lines && l_lines.split("\n").each do |l_oneLine|
            #  Strip leading and trailing whitespace and split on any whitespace
            l_list = l_oneLine.strip().split()

            #  Stash the data in the hash as name -> value
            l_aixNfso[l_list[0]] = l_list[2]
        end

        #  Implicitly return the contents of the variable
        l_aixNfso
    end
end
