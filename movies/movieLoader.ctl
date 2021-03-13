LOAD DATA
CHARACTERSET	UTF8
INFILE 'movieRecords.dat'
	INTO	TABLE	movietbl
	FIELDS	TERMINATED BY ','
	TRAILING NULLCOLS
	(
		id			CHAR(4),
		title		CHAR(80),
		director	CHAR(80),
		star		CHAR(80),
		scriptFname	FILLER CHAR(80),
		filmFname	FILLER CHAR(80),
		script		LOBFILE(scriptFname)	TERMINATED BY EOF,
		film		LOBFILE(filmFname)		TERMINATED BY EOF
	)