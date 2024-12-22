package com.barracano.seriea;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/seriea")
public class TeamController {
	
	@Autowired TeamDAO teamDAO;
	
	
	@GetMapping("/teams/{teamname}/players")
    public ResponseEntity<List<Player>> getPlayersByTeamname(@PathVariable String teamname) {
		List<Player> players = teamDAO.getPlayersByTeamname(teamname);
		if(players.isEmpty()) {
			throw new TeamNotFoundException(teamname + " non trovata");
		}
        return ResponseEntity.ok(players);
    }
	
	
		@GetMapping("/teams")
		public List<Team> getAllTeams(){
			return teamDAO.getAllTeams();
		}
	
		@GetMapping("/teams/{id}")
		public ResponseEntity<Team> getTeam(@PathVariable Integer id){
			Optional<Team> team = teamDAO.getTeam(id);
			return team.map(ResponseEntity::ok)
					.orElseGet(() -> ResponseEntity.notFound().build());
		}
		
		@DeleteMapping("/teams/{id}")
		public void deleteTeam(@PathVariable int id) {
			teamDAO.delTeam(id);
		}
	
		
		@PostMapping("/teams")
		public void addTeam(@RequestBody Team team) {
			teamDAO.addTeam(team);
		}
	
		
		@GetMapping("/players")
		public List<Player> getAllPlayers(){
			return teamDAO.getAllPlayers();
		}
		
		
		@GetMapping("/players/{id}")
		public ResponseEntity<Player> getPlayer(@PathVariable Integer id){
			Optional<Player> player = teamDAO.getPlayer(id);
			return player.map(ResponseEntity::ok)
					.orElseGet(() -> ResponseEntity.notFound().build());
		}

		
		@DeleteMapping("/players/{id}")
		public void deletePlayer(@PathVariable int id) {
			teamDAO.delPlayer(id);
		}
		
		@PostMapping("/players")
		public void addPlayer(@RequestBody Player player){
			if(teamDAO.existsTeam(player.getTeamname())) {
				teamDAO.addPlayer(player);
			} else {
				throw new TeamNotFoundException(player.getTeamname() + " non trovata! Inserisci un team presente nel database");
				
			}
			
			//teamDAO.addPlayer(player);
		}
		
}
