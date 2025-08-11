from pyspark.sql import functions as F
from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql.functions import *
from transformer.baseTransformer import BaseTransformer
    

class CommentTransformer(BaseTransformer):
    def __init__(self, sparkSession):
        super().__init__(sparkSession)

    def normalizeParentId(self, df, parentIdCol="parent_id", newCol="parent_clean"):
        return df.withColumn(
            newCol,
            F.regexp_replace(F.col(parentIdCol), r"^(t[13]_)", "")
        )

    def normalizeLinkId(self, df, linkIdCol="link_id", newCol="link_clean"):
        return df.withColumn(
            newCol,
            F.regexp_replace(F.col(linkIdCol), r"^t3_", "")
        )

    def markBodyRemoved(self, df, bodyCol="body", newCol="is_removed_body"):
        return df.withColumn(
            newCol,
            F.col(bodyCol) == "[removed]"
        )

    def markModComments(self, df, authorCol="author", newColMod="is_mod_comment", newColAutoMod="is_automod_comment"):
        df_with_mod = df.withColumn(
            newColMod,
            F.lower(F.col(authorCol)).like("%-modteam")
        )
        return df_with_mod.withColumn(
            newColAutoMod,
            F.col(authorCol) == "AutoModerator"
        )
    
    def transform(self, pathIn, pathOut, format="iceberg", checkpointPath=None, mode="append", streaming=False):
        df = self.readData(pathIn, format)
        df = self.convertTimestamp(df, "created_utc", "created_ts")
        df = self.convertTimestamp(df, "retrieved_on", "retrieved_ts")
        df = self.markAuthorDeleted(df, newCol="is_deleted_author")
        df = self.markBodyRemoved(df)
        df = self.normalizeParentId(df)
        df = self.normalizeLinkId(df)
        df = self.markModComments(df)
        self.writeData(df=df, pathOut=pathOut)