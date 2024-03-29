public class APIResponse {
   public Integer input_index;
	public Integer candidate_index;
	public String delivery_line_1;
	public String last_line;
	public String delivery_point_barcode;
	
	public AddressComponent components;
	public AddressMetadata metadata;
	public AddressAnalysis analysis;
	
	public APIResponse(){
			this.components = new AddressComponent();
			this.metadata = new AddressMetadata();
			this.analysis = new AddressAnalysis();
		}
    
	public static APIResponse parse(String json) {
		return (APIResponse) System.JSON.deserialize(json, APIResponse.class);
	}

	public class AddressComponent {
		public String primary_number;
		public String street_name;
		public String street_suffix;
		public String city_name;
		public String state_abbreviation;
		public String zipcode;
		public String plus4_code;
		public String delivery_point;
		public String delivery_point_check_digit;
	}

	

	public class AddressAnalysis {
		public String dpv_match_code;
		public String dpv_footnotes;
		public String dpv_cmra;
		public String dpv_vacant;
		public String active;
		public String footnotes;
	}

	public class AddressMetadata {
		public String record_type;
		public String zip_type;
		public String county_fips;
		public String county_name;
		public String carrier_route;
		public String congressional_district;
		public String rdi;
		public String elot_sequence;
		public String elot_sort;
		public Double latitude;
		public Double longitude;
		public String precision;
		public String time_zone;
		public Integer utc_offset;
		public Boolean dst;
	}

}



	
	
	
