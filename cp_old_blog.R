new_post_dir = "~/Projects/personal/researchBlog_distill/_posts"
old_post_dir = "~/Projects/personal/researchBlog_blogdown_convertFolders-bundle/content/post"

old_posts = dir(old_post_dir, full.names = TRUE, recursive = FALSE)

old_properties = file.info(old_posts)

keep_old = old_posts[old_properties$isdir]

new_posts = dir(new_post_dir)

keep_old = keep_old[!(basename(keep_old) %in% new_posts)]

purrr::walk(keep_old, function(in_dir){
  new_loc = file.path(new_post_dir, basename(in_dir))
  dir.create(new_loc)
  index_loc = file.path(in_dir, "index.Rmd")
  split_name = strsplit(basename(new_loc), "-", fixed = TRUE)[[1]]
  split_name = split_name[seq(4, length(split_name))]
  new_index = file.path(new_loc, paste0(paste(split_name, collapse = "-"), ".Rmd"))
  file.copy(index_loc, new_index)
})

new_posts2 = dir(new_post_dir, full.names = TRUE)
purrr::walk(new_posts2, function(in_dir){
  file.create(file.path(in_dir, "refs.bib"))
})
