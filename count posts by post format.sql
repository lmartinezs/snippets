#select count(*) as TOTAL from wp_posts where post_type ='post' and post_status='publish';

SET @slug = "post-format-video";
SET @taxonomy = "post_format"; # post_tag, category, post_format
SELECT
	count(*) FROM wp_posts

LEFT JOIN wp_term_relationships ON 
	(wp_posts.ID = wp_term_relationships.object_id)
LEFT JOIN wp_term_taxonomy ON 
	(wp_term_relationships.term_taxonomy_id = wp_term_taxonomy.term_taxonomy_id)
LEFT JOIN wp_terms ON 
	(wp_term_taxonomy.term_taxonomy_id = wp_terms.term_id)
	
WHERE wp_posts.post_status = 'publish' and wp_posts.post_type='post'
AND wp_term_taxonomy.taxonomy = @taxonomy
AND wp_terms.slug = @slug
ORDER BY post_date DESC;
