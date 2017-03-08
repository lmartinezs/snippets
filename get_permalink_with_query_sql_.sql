SELECT wpp.post_title, wpp.guid, wpp.post_date, CONCAT(wpo_su.option_value, 
	REPLACE( REPLACE( REPLACE( REPLACE( REPLACEwpo.option_value,'%year%',date_format(wpp.post_date,'%Y')) ,'%monthnum%',date_format(wpp.post_date,'%m')) ,'%day%',date_format(wpp.post_date,'%d')) ,'%postname%',wpp.post_name ) ,'%category%',wpc.slug ) ) as permalink 
	FROM wp_posts wpp INNER JOIN wp_options wpo on wpo.option_name='permalink_structure' 
	INNER JOIN wp_options wpo_su on wpo_su.option_name='siteurl' 
	INNER JOIN ( select wtr.object_id ID, max(wpt.slug) slug from wp_term_relationships wtr 
	INNER JOIN wp_term_taxonomy wtt on wtt.term_taxonomy_id=wtr.term_taxonomy_id and wtt.taxonomy='category' 
	INNER JOIN wp_terms wpt on wpt.term_id=wtt.term_id group by wtr.object_id ) wpc on wpc.ID=wpp.ID 
	WHERE wpp.post_type = 'post' AND wpp.post_status = 'publish'
	ORDER BY wpp.post_date DESC;