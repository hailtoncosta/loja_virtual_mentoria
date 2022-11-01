package jdev.mentoria.lojavirtual.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import jdev.mentoria.lojavirtual.model.Acesso;
import jdev.mentoria.lojavirtual.repository.AcessoRepository;
import jdev.mentoria.lojavirtual.service.AcessoService;

@Controller
@RestController /*Recebe JSON e retorna*/
public class AcessoController {
	
	@Autowired
	private AcessoService acessoService;
	
	@Autowired
	private AcessoRepository acessoRepository;
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "/salvarAcesso") /*Mapeando a URL para receber um JSON*/
	public ResponseEntity<Acesso> salvarAcesso(@RequestBody Acesso acesso) { /*Recebe JSON e converter para objeto*/
		Acesso acessoSalvo = acessoService.save(acesso);
		return new ResponseEntity<Acesso>(acessoSalvo, HttpStatus.OK);
	}
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "/deletarAcesso") /*Mapeando a URL para receber um JSON*/
	public ResponseEntity<?> deletarAcesso(@RequestBody Acesso acesso) {
		acessoRepository.deleteById(acesso.getId());
		return new ResponseEntity("Acesso removido com sucesso!", HttpStatus.OK);
	}
	
	@ResponseBody /*Poder dar um retorno da API*/
	@DeleteMapping(value = "/deletarAcessoPorId/{id}") /*Mapeando a URL para receber um JSON*/
	public ResponseEntity<?> deletarAcessoPorId(@PathVariable("id") Long id) {
		acessoRepository.deleteById(id);
		return new ResponseEntity("Acesso removido com sucesso!", HttpStatus.OK);
	}
	
	@ResponseBody /*Poder dar um retorno da API*/
	@GetMapping(value = "/obterAcesso/{id}") /*Mapeando a URL para receber um JSON*/
	public ResponseEntity<Acesso> obterAcesso(@PathVariable("id") Long id) {
		Acesso acesso = acessoRepository.findById(id).get();
		return new ResponseEntity<Acesso>(acesso, HttpStatus.OK);
	}
	
	@ResponseBody /*Poder dar um retorno da API*/
	@GetMapping(value = "/buscarPorDesc/{desc}") /*Mapeando a URL para receber um JSON*/
	public ResponseEntity<List<Acesso>> buscarPorDesc(@PathVariable("desc") String desc) {
		List<Acesso> acesso = acessoRepository.buscarAcessoDesc(desc);
		return new ResponseEntity<List<Acesso>>(acesso, HttpStatus.OK);
	}
	
}
