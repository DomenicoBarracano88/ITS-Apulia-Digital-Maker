package com.barracano.seriea;


import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class TeamDAO  {
	
	@Autowired
	private TeamRepository teamRepository;
	
	@Autowired
	private PlayerRepository playerRepository;
	
		// Method to return the teams list
		public List<Team> getAllTeams() {
			return teamRepository.findAll();
		}

		// Method to add an team to the teams list
		public void addTeam(Team team) {
			teamRepository.save(team);

		}

		// Method to get team id
		public Optional <Team> getTeam(int id) {
			return teamRepository.findById(id);
		}

		// Method to remove team
		public void delTeam(int id) {
			teamRepository.deleteById(id);
		}
		
			
		// Method to return the players list
		public List<Player> getAllPlayers() {
			return playerRepository.findAll();
		}
	
		
		// Method to add an player to the players list
		public void addPlayer(Player player) {
			playerRepository.save(player);

		}
		
		
		// Method to get player id
		public Optional <Player> getPlayer(int id) {
			return playerRepository.findById(id);
		}
		
		//Metodo per cercare players con il teamname
		public List<Player> getPlayersByTeamname(String teamname) {
			return playerRepository.findByTeamname(teamname);         
	    }
				
		// Method to remove player
		public void delPlayer(int id) {
			playerRepository.deleteById(id);
		}
		
		
		public boolean existsTeam(String teamname) {
			return teamRepository.existsByTeamname(teamname);
		}
}
