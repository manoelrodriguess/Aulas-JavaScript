##1##
select emp.nome "Nome", 
	emp.cpf "CPF", 
	date_format(emp.dataAdm, "%d/%m/%Y")  "Admição",
	concat("R$ ", format(emp.salario, 2, 'de_DE')) "Salário",  
	depar.nome "Departamento", cel.numero "Celular"
from empregado emp
		inner join departamento dep on dep.idDepartamento = emp.Departamento_idDepartamento
        left join telefone tele on tele.Empregado_cpf = emp.cpf
			where dataAdm between '2019-01-01' and  '2022-03-31'
				order by dataAdm desc;

##2##
select emp.nome "Nome", 
	emp.cpf "CPF", 
	date_format(emp.dataAdm, "%d/%m/%Y")  "Admição",
	concat("R$ ", format(emp.salario, 2, 'de_DE')) "Salário",  
	dep.nome "Departamento", cel.numero "celular"
from empregado emp
		inner join departamento dep on dep.idDepartamento = emp.Departamento_idDepartamento
        left join celular tele on cel.Empregado_cpf = emp.cpf
			where salario < (select avg(salario) from empregado)
				order by emp.nome;
                
##3##                
select dep.nome "Departamento",
	concat('R$ ', format(avg(salario),2,'de_DE')) "Média Salário",
    concat('R$ ', format(avg(comissao), 2, 'de_DE')) "Média da Comissão",
    count(emp.cpf) "Empregado por Departamento"
from departamento dep
		inner join empregado emp on emp.Departamento_idDepartamento = dep.idDepartamento			
				group by dep.idDepartamento
					order by dep.nome;

##4##				
select emp.nome "Nome", 
	emp.cpf "CPF", 
	emp.sexo "Sexo",
	concat("R$ ", format(emp.salario, 2, 'de_DE')) "Salário",  
    concat("R$ ", format(sum(venda.idVenda -  coalesce(vender.desconto, 0)), 2, "de_DE")) "Valor Vendido",
	count(venda.idVenda) "Quantidade de Vendas",
    concat("R$ ", format(sum(venda.comissao), 2, "de_DE")) "Total de Comissão"
from empregado emp	
    left join venda on venda.Empregado_cpf = emp.cpf
		group by emp.cpf
			order by count(venda.idVenda) desc;

##5##
select emp.nome "Nome", 
	emp.cpf "CPF", 
	emp.sexo "Sexo",
	concat("R$ ", format(emp.salario, 2, 'de_DE')) "Salário",  
	concat("R$ ", format(sum(serv.valorVenda -  coalesce(isv.desconto, 0)), 2, "de_DE")) "Valor de venda com Serviço",
	count(serv.idServico) "Quantidade de Vendas com Serviços",
    concat("R$ ", format(sum(vnd.comissao), 2, "de_DE")) "Total da Comissão"
from empregado emp
	left join itemservico isv on isv.Empregado_cpf = emp.cpf
    inner join servico serv on serv.idServico = isv.Servico_idServico
    inner join vendas vnd on vnd.idVenda = isv.Venda_idVenda
		group by emp.cpf
			order by count(serv.idServico) desc;

##6##        
select pet.nome "Nome Pet",
	date_format(vnd.data , "%d/%m/%Y") "Data do Serviço",
    serv.nome "Nome Serviço",
    isv.quantidade "Quantidade",
    concat('R$ ', format(isv.valor, 2, 'de_DE')) "Valor do Serviço",
    emp.nome "Empregado Responsável"
	from pet
		inner join itemservico isv on isv.pet_idPet = pet.idPet
		inner join venda vnd on isv.venda_idVenda = vnd.idVenda
		inner join empregado emp on emp.cpf = isv.empregado_cpf
        inner join servico serv on isv.servico_idServico = serv.idServico
			group by serv.idServico
				order by vnd.data desc;
 
##7##

select date_format(vend.data , "%d/%m/%Y") "Data da Venda", 
concat("R$ ", format(vend.valor, 2, 'de_DE')) "Valor da venda", 
concat("R$ ", format(vend.desconto, 2, 'de_DE')) "Desconto da venda", 
concat("R$ ", format(sum(vend.valor -  coalesce(vend.desconto, 0)), 2, "de_DE")) "Valor da venda",
emp.nome "Empregado que vendeu"
	from venda vend
		inner join empregado emp on emp.cpf = vend.empregado_cpf
			group by vend.idVenda
			order by date_format(vend.data , "%d/%m/%Y") desc;
            
##8##

select serv.nome "Nome do Serviço", 
count(isv.quantidade) "Quantidade de vendas", 
concat("R$ ", format(sum(serv.valorVenda), 2, "de_DE")) "Valor total Vendido"
	from servico serv
		inner join itemservico isv on isv.servico_idServico = serv.idServico        
			group by serv.idServico
				order by sum(serv.valorVenda)
					limit 10;

##9##

select
    fpv.tipo "forma de Pagamento",
    count(fpv.Venda_idVenda) "Quantidade_Vendas",
    concat("R$ ", replace(format(sum(vend.valor), 2), '.', ',')) "valor vendido"
	from formapgvenda fpv
		inner join venda vend on fpv.venda_idVenda = vend.idVenda
			group by fpv.tipo
				order by count(fpv.Venda_idVenda)  desc;

##10##

select date_format(vend.data , "%d/%m/%Y") "Data da Venda",
count(vend.idVenda) "Quantidade de vendas",
concat("R$ ", format(sum(vend.valor), 2, "de_DE")) "Valor Total Venda"
	from venda vend
		group by date_format(vend.data , "%d/%m/%Y")
			order by date_format(vend.data , "%d/%m/%Y")
		



        




			
