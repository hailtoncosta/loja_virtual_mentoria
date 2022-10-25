package jdev.mentoria.lojavirtual.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.ConstraintMode;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import jdev.mentoria.lojavirtual.enums.StatusContaReceber;

@Entity
@Table(name = "contapagar")
@SequenceGenerator(name = "seq_contapagar", sequenceName = "seq_contapagar", initialValue = 1, allocationSize = 1)
public class ContaPagar implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_contapagar")
	private Long id;
	
	@Column(nullable = false)
	private String descricao;
	
	@Column(nullable = false)
	private BigDecimal valorTotal;
	
	private BigDecimal valorDesconto;
	
	@Temporal(TemporalType.DATE)
	private Date dtPagamento;
	
	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date dtVencimento;
	
	@Column(nullable = false)
	@Enumerated(EnumType.STRING)
	private StatusContaReceber statusContaPagar;
	
	@ManyToOne(targetEntity = Pessoa.class)
	@JoinColumn(name = "pessoa_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
	private Pessoa pessoa;
	
	@ManyToOne(targetEntity = Pessoa.class)
	@JoinColumn(name = "pessoa_fornecedor_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fornecedor_fk"))
	private Pessoa pessoa_fornecedor_fornecedor;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Date getDtPagamento() {
		return dtPagamento;
	}

	public void setDtPagamento(Date dtPagamento) {
		this.dtPagamento = dtPagamento;
	}

	public BigDecimal getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(BigDecimal valorTotal) {
		this.valorTotal = valorTotal;
	}

	public BigDecimal getValorDesconto() {
		return valorDesconto;
	}

	public void setValorDesconto(BigDecimal valorDesconto) {
		this.valorDesconto = valorDesconto;
	}

	public Pessoa getPessoa() {
		return pessoa;
	}

	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}

	public Date getDtVencimento() {
		return dtVencimento;
	}

	public void setDtVencimento(Date dtVencimento) {
		this.dtVencimento = dtVencimento;
	}

	public StatusContaReceber getStatusContaPagar() {
		return statusContaPagar;
	}

	public void setStatusContaPagar(StatusContaReceber statusContaPagar) {
		this.statusContaPagar = statusContaPagar;
	}

	public Pessoa getPessoa_fornecedor_fornecedor() {
		return pessoa_fornecedor_fornecedor;
	}

	public void setPessoa_fornecedor_fornecedor(Pessoa pessoa_fornecedor_fornecedor) {
		this.pessoa_fornecedor_fornecedor = pessoa_fornecedor_fornecedor;
	}
	
}
