#Get Client IP Address for NSG

data "http" "clientip" {
  url = "https://ipv4.icanhazip.com/"
}