package src.UIPages.GameSelection {
	import src.InGame.InstanceSelection;
	/**
	 * ...
	 * @author Xiler
	 */
	public class SelectionData {
		private var x_mapPackage:Vector.<SelectionBase>;
		private var x_enemyPackage:Vector.<SelectionBase>;
		private var x_playerPackage:Vector.<SelectionBase>;
		
		public function SelectionData() {
			this.x_mapPackage = new Vector.<SelectionBase>;
			this.x_enemyPackage = new Vector.<SelectionBase>;
			this.x_playerPackage = new Vector.<SelectionBase>;
			
//MAPS
			x_mapPackage.push( new SelectionBase(
			"Concrete Map",
			new P_Map1(),
			"All Tunnels",
			InstanceSelection.TEST_MAP5));
			
			x_mapPackage.push( new SelectionBase(
			"Original Map",
			new P_Map1(),
			' "sam" - Alex ',
			InstanceSelection.TEST_MAP));
			
			x_mapPackage.push( new SelectionBase(
			"Big Map",
			new P_Map1(),
			"Its pretty big",
			InstanceSelection.TEST_MAP2));
			
			x_mapPackage.push( new SelectionBase(
			"Open World",
			new P_Map1(),
			"If you fall ...  you fall forever",
			InstanceSelection.TEST_MAP3));
			
			x_mapPackage.push( new SelectionBase(
			"Just Another",
			new P_Map1(),
			"another map",
			InstanceSelection.TEST_MAP4));
			
			
//ENEMIES
			x_enemyPackage.push(new SelectionBase(
			"Zombie",
			new P_Map1(),
			"The undead - come back to find you",
			InstanceSelection.TYPE_ZOMBIE));
			
			x_enemyPackage.push(new SelectionBase(
			"Entity",
			new P_Map1(),
			"A twisted entity emanating with dark forsaken energies.",
			InstanceSelection.TYPE_ENTITY));
			
//CHARACTERS
			x_playerPackage.push(new SelectionBase(
			"Lozzo",
			new P_Map1(),
			" Lozzo is gay",
			InstanceSelection.LOZZO));
			
			x_playerPackage.push(new SelectionBase(
			"Ralf",
			new P_Map1(),
			"' Ralf is retarded ",
			InstanceSelection.RALF));
			
		}
		public function get mapPackage():Vector.<SelectionBase>{
			return this.x_mapPackage;
		}
		public function get enemyPackage():Vector.<SelectionBase> {
			return this.x_enemyPackage;
		}
		public function get playerPackage():Vector.<SelectionBase> {
			return this.x_playerPackage;
		}
	}
}