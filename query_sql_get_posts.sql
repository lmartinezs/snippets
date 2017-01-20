#SET @slug = "futbol";
SET @nameCategory = "Autos";
SET @taxonomy = "category"; # post_tag, category, post_format
SELECT
	post_title,	
	post_status,
	post_date, 	
	post_modified,
	post_type,
    emma_term_taxonomy.taxonomy,
    emma_terms.name
FROM emma_posts

LEFT JOIN emma_term_relationships ON 
	(emma_posts.ID = emma_term_relationships.object_id)
LEFT JOIN emma_term_taxonomy ON 
	(emma_term_relationships.term_taxonomy_id = emma_term_taxonomy.term_taxonomy_id)
LEFT JOIN emma_terms ON 
	(emma_term_taxonomy.term_taxonomy_id = emma_terms.term_id)
	
WHERE emma_posts.post_status = 'publish'
AND emma_term_taxonomy.taxonomy = @taxonomy
#AND emma_terms.slug = @slug
AND emma_terms.name = @nameCategory
ORDER BY post_date DESC;