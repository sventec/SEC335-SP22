# dns-resolver.ps1
# USAGE: .\dns-resolver.ps1 <PREFIX> <DNS Server> <optional: lowerbound> <opt: upperbound>
# OR:    .\dns-resolver.ps1 -prefix <PREFIX> -server <DNS Server> [-lowerbound <lb>] [-upperbound <ub>]
# E.G. .\dns-resolver.ps1 192.168.3 192.168.4.5
# E.G. .\dns-resolver.ps1 192.168.3 192.168.4.5 -lowerbound 1 -upperbound 254

param (
    $prefix,
    $server,
    [Parameter(Mandatory=$false)]
    $lowerbound = 1,
    [Parameter(Mandatory=$false)]
    $upperbound = 254
)

for ($i = $lowerbound; $i -le $upperbound; $i++) {
    $ip = ($prefix + "." + $i)
    $hostname = (Resolve-DnsName -DnsOnly $ip -Server $server -ErrorAction Ignore)
    if ($hostname -ne $null) {
        Write-Host $ip $hostname.NameHost
    }
}
