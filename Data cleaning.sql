-- copying our raw data to another table for proccessing
create table layoffs_staging
like layoffs;

insert layoffs_staging
select *
from layoffs ;

select *
from layoffs_staging;

-- removing duplicates
select *,
row_number() OVER(partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num
from layoffs_staging;

CREATE TABLE layoffs_staging2 (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rownum`  int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_staging2
select *,
row_number() OVER(partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num
from layoffs_staging;

delete
from layoffs_staging2
where rownum > 1 ;

select *
from layoffs_staging2;

-- standardizing data
select distinct *
from layoffs_staging2
order by 1;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto %';

update layoffs_staging2
set location = 'Florianapolis' 
where location like 'FlorianÃ³polis';

update layoffs_staging2
set company = trim(company);

update layoffs_staging2
set country = 'United States'
where country like 'Unites States.';

update layoffs_staging2
set `date` = STR_TO_Date(`date`,'%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;

select *
from layoffs_staging2;

-- Removing null values ( where it is possible)
select *
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company =t2.company
where t1.industry is null and t2.industry is not null;

Update layoffs_staging2
set industry = null
where industry like '' ;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company =t2.company
set t1.industry = t2.industry
where t1.industry is null and t2.industry is not null;

select distinct industry
from layoffs_staging2;

-- deleting useless data
select *
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

delete 
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

alter table layoffs_staging2
drop column rownum;

select *
from layoffs_staging2;











