# R for Data Science

install.packages("tidyverse")
library(tidyverse)

# These packages provide data on airline flights, world development, and baseball that we’ll use to illustrate key data science ideas.
install.packages(c("nycflights13", "gapminder", "Laman"))

# 3 Data visualisation
# 3.1.1 Prerequistites
install.packages("tidyverse")
library(tidyverse)
# package::function()
# ggplot2::ggplot()

# 3.2.1 The mpg data frame
mpg

# 3.2.2 Creating a ggplot
ggplot(data = mpg) + 
	geom_point(mapping = aes(x = displ, y = hwy))
  
# 3.2.3 A graphing template
ggplot(data = <DATA>) + 
	<GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
	
# 3.2.4 Exercises
# Q: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
# A: Nothing
# Q: How many rows are in mpg? How many columns?
mpg
# A: 234 rows and 11 columns
# Q: What does the drv variable describe? Read the help for ?mpg to find out.
?mpg
# A: drv is the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd
# Q: Make a scatterplot of hwy vs cyl
# A:
ggplot(data = mpg) +
	geom_point(mapping = aes(x = hwy, y = cyl))
# Q: What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data = mpg) +
	geom_point(mapping = aes(x = class, y = drv))
# A: scatterplot is not useful for two catagorical (discrete) variables

# 3.3 Aesthetic mappings
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 3.3.1 Exercises
# Q: What’s gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# A: color is inside the aesthetic instead of outside. 
# To set an aesthetic manually, set the aesthetic by name as an argument of your geom function; 
# i.e. it goes outside of aes().
# Q: Which variables in mpg are categorical? Which variables are continuous? 
# (Hint: type ?mpg to read the documentation for the dataset). 
# How can you see this information when you run mpg?
mpg
?mpg
# A: manufacturer, model, trans, drv, fl, and class are catagorical. 
# displ, year, cyl, cty, and hwy are continuous.
# The variable type is under the name of the variable in the tibble (ex. chr, dbl, int)
# Q: Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?
# A: Color has an intensity scale instead of distinct colors. 
# Size is made for continuous and groups (bins) the values. 
# Shape gives an error - continuous variable can not be mapped to shape
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cty))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cty))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = cty))
# Q: What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = hwy, y = hwy, color = hwy))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = drv, color = drv))
# A: Will map 1:1 linear
# Q: What does the stroke aesthetic do? What shapes does it work with? 
# (Hint: use ?geom_point)
?geom_point
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)
# A: stoke modifies the width of the border of shapes with a border
# Q: What happens if you map an aesthetic to something other than a variable name, 
# like aes(colour = displ < 5)? Note, you’ll also need to specify x and y.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cty, y = hwy, color = displ < 5))
# A: It indicates TRUE or FALSE instead of the value

# 3.5 Facets
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)
  
# 3.5.1 Exercises
# Q: What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ displ)
# A: It creates the facets by each value, 
# but this is too many facets and most are not interesting
# Q: What do the empty cells in plot with facet_grid(drv ~ cyl) mean? 
# How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
# A: There is no values that have both at those values.
# The scatterplot shows points only where there are values for each variable,
# So the points are missing at the same 'intersections' as the empty cells
# Q: What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
# A: The first facets in the rows dimension and the second facets in the columns dimension
# The . is a placeholder for the format without putting a variable in
# Q: What are the advantages to using faceting instead of the colour aesthetic? 
# What are the disadvantages? How might the balance change if you had a larger dataset?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# A: Faceting shows data that might be overlapping (and covering up). 
# Don't have to go back and forth with the legend to identity colors.
# Disadvantage is the it is easier to compare differences with color.
# If you had a larger dataset, color would get too busy and confusing.
# Q: Read ?facet_wrap. What does nrow do? What does ncol do? 
# What other options control the layout of the individual panels? 
# Why doesn’t facet_grid() have nrow and ncol arguments?
?facet_wrap
# A: nrow controls the number of rows. ncol controls the number of columns.
# Other options are scales, shrink, labeller, as.table, switch, drop, dir, and strip.position
# facet_grid does not have nrow and ncol because they are determined by the unique values of the variables
# Q: When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?
# A: Align things vertically to ease comparisons
  
# 3.6 Geometric objects
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
  
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
  
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
              
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
    
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
  
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
  
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
  
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
  
# 3.61 Exercises
# Q: What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
# A: geom_line, geom_boxplot, geom_histogram, geom_area
# Q: Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
# Q: What does show.legend = FALSE do? What happens if you remove it?
# Why do you think I used it earlier in the chapter?
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
#    show.legend = FALSE
  )
# A: Removes the legend from the graphic. If you remove it, the legend is added to the graphic.
# You used it because it wasn't necessary for demontrating the differences.
# Q: What does the se argument to geom_smooth() do?
# A: When set to FALSE, it removes the confidence interval around the smoothed conditional means
# Q: Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# A: No, because they are using the same set of mappings.
# Q: Recreate the R code necessary to generate the following graphs.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size = 5) + 
  geom_smooth(size = 2, se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size = 5) + 
  geom_smooth(mapping = aes(group = drv), show.legend = FALSE, size = 2, se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(size = 5) + 
  geom_smooth(size = 2, se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = drv), size = 5) + 
  geom_smooth(size = 2, se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = drv), size = 5) + 
  geom_smooth(mapping = aes(linetype = drv),size = 2, se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, fill = drv)) + 
  geom_point(size = 4, shape = 21, color = "white", stroke = 3)

# 3.7 Statistical transformations
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
  
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))
  
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")
  
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))
  
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )
  
# 3.7.1 Exercises
# Q: What is the default geom associated with stat_summary()? 
# How could you rewrite the previous plot to use that geom function instead of the stat function?
# A: geom_pointrange()
ggplot(data = diamonds) + 
	geom_pointrange(
		mapping = aes(x = cut, y = depth),
		stat = "summary",
		fun.min = min,
		fun.max = max,
		fun = median
	)
# Q: What does geom_col() do? How is it different to geom_bar()?
# A: geom_col() represents the values in the data with bar height 
# while geom_bar() represents the number of cases in each group with bar height.
# geom_bar() uses stat_count() by default and geom_col() uses stat_identity() by default
# Q: Most geoms and stats come in pairs that are almost always used in concert. 
# Read through the documentation and make a list of all the pairs. What do they have in common?
# A: 
#| geom                       | stat                       |
#|----------------------------|----------------------------|
#| `geom_bar()`               | `stat_count()`             |
#| `geom_bin2d()`             | `stat_bin_2d()`            |
#| `geom_boxplot()`           | `stat_boxplot()`           |
#| `geom_contour_filled()`    | `stat_contour_filled()`    |
#| `geom_contour()`           | `stat_contour()`           |
#| `geom_count()`             | `stat_sum()`               |
#| `geom_density_2d()`        | `stat_density_2d()`        |
#| `geom_density()`           | `stat_density()`           |
#| `geom_dotplot()`           | `stat_bindot()`            |
#| `geom_function()`          | `stat_function()`          |
#| `geom_sf()`                | `stat_sf()`                |
#| `geom_sf()`                | `stat_sf()`                |
#| `geom_smooth()`            | `stat_smooth()`            |
#| `geom_violin()`            | `stat_ydensity()`          |
#| `geom_hex()`               | `stat_bin_hex()`           |
#| `geom_qq_line()`           | `stat_qq_line()`           |
#| `geom_qq()`                | `stat_qq()`                |
#| `geom_quantile()`          | `stat_quantile()`          |
#Table: Complementary geoms and stats
#These pairs of geoms and stats tend to have their names in common, 
#such `stat_smooth()` and `geom_smooth()` and  be documented on the same help page.
#The pairs of geoms and stats that are used in concert often have each other as the 
#default stat (for a geom) or geom (for a stat).





# 3.8 Position adjustments
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
  
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
  
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
  
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
  
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
  
# 3.9 Coordinate systems
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
  
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()
  
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

# 3.10 The layered grammer of graphics
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
     mapping = aes(<MAPPINGS>),
     stat = <STAT>, 
     position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
  
# 4 Workflow: basics
# 4.1 Coding basics
object_name <- value
# RStudio’s keyboard shortcut: Alt + - (the minus sign). 
# Notice that RStudio automagically surrounds <- with spaces, which is a good code formatting practice.

# 4.2 What's in a name?
i_use_snake_case
otherPeopleUseCamelCase
some.people.use.periods
And_aFew.People_RENOUNCEconvention

# 4.3 Calling functions
function_name(arg1 = val1, arg2 = val2, ...)
seq(1, 10)
x <- "hello world"

y <- seq(1, 10, length.out = 5)
y
(y <- seq(1, 10, length.out = 5))

# 5 Data transformation
# 5.1.1 Prerequistites
library(nycflights13)
library(tidyverse)
