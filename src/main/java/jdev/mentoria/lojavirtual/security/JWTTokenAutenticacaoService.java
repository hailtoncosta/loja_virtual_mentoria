package jdev.mentoria.lojavirtual.security;

import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

/*Criar autenticação e retornar a autenticação JWT*/
@Service
@Component
public class JWTTokenAutenticacaoService {
	
	/*Toquem de validade de 11 dias*/
	private static final Long EXPIRATION_TIME = (long) 959990000;
	
	/*Chave de senha pra juntar o JWT*/
	private static final String SECRET = "";
	
	private static final String TOKEN_PREFIX = "bearer";
	
	private static final String HEADER_STRING = "Autorization";
	
	/*Gerar o token e dar a resposta pro cliete*/
	public void addAuthentication(HttpServletResponse response, String username) throws Exception {
		
		/*Montagem do Token*/
		String JWT = Jwts.builder(). /*Chama o gerador de token*/
				setSubject(username) /*Adiciona o USER*/
				.setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME)) /*Tempo de expiração*/
				.signWith(SignatureAlgorithm.HS512, SECRET).compact();
		
		String token = TOKEN_PREFIX + " " + JWT;
		
		response.addHeader(HEADER_STRING, token);
		
		
		
	}
}
