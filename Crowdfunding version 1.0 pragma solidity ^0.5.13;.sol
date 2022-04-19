pragma solidity ^0.5.13;
contract Crowdfunding{
string public nombreapellido;
uint public objetivo;
uint public pago;
uint public recaudadototal = 0 ether;
uint public comision;
address  payable public recaudador = 0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7;
address payable public banco = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
function getInversor() public view returns(string memory){
    return nombreapellido;
}
function setObjetivo (uint _objetivo) public{
    objetivo = _objetivo;
}
function getObjetivo() public view returns(uint) {return objetivo;}
function setInversor(string memory _nombreapellido) public payable{
    nombreapellido=_nombreapellido;
    require(msg.value>=0.1 ether);
    recaudadototal=recaudadototal+msg.value;
    if(recaudadototal>=objetivo){
        if(recaudadototal>objetivo + 0.5 ether ){
            comision = 0.5 ether;
            recaudadototal = recaudadototal - comision;
            pago = recaudadototal;
            payout();
            recaudadototal = 0 wei;
            comision = 0 wei;


        }
        else{
            comision = 0 wei;
            pago = recaudadototal; 
            payout();
            recaudadototal = 0 ether;
            }
       
            

    }
    
}

function payout() private {
    recaudador.transfer(pago);
    banco.transfer(comision);

}

}