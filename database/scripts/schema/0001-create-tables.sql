CREATE TABLE [dbo].[foos] (
    [foo_id] [bigint] IDENTITY(1,1) NOT NULL,
    [name] [nvarchar] (1000) NOT NULL,

    CONSTRAINT [PK_foos] PRIMARY KEY CLUSTERED 
    (
        [foo_id] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY];
