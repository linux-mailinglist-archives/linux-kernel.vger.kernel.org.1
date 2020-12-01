Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53E02CA290
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgLAMVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:21:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9081 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLAMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:21:16 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Clh4Z2lrszLyCh;
        Tue,  1 Dec 2020 20:19:58 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 20:20:22 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: support compress level
Date:   Tue, 1 Dec 2020 20:20:19 +0800
Message-ID: <20201201122019.50077-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand 'compress_algorithm' mount option to accept parameter as format of
<algorithm>:<level>, by this way, it gives a way to allow user to do more
specified config on lz4 and zstd compression level, then f2fs compression
can provide higher compress ratio.

In order to set compress level for lz4 algorithm, it needs to set
CONFIG_LZ4HC_COMPRESS and CONFIG_F2FS_FS_LZ4HC config to enable lz4hc
compress algorithm.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- support more generic mount option to configure compress level
- add to support setting compress level for zstd instead of only for lz4
 Documentation/filesystems/f2fs.rst |  5 +++
 fs/f2fs/Kconfig                    |  9 ++++
 fs/f2fs/compress.c                 | 40 ++++++++++++++++--
 fs/f2fs/f2fs.h                     |  9 ++++
 fs/f2fs/super.c                    | 66 +++++++++++++++++++++++++++++-
 include/linux/f2fs_fs.h            |  3 ++
 6 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 8830a11a11be..ec7498d8f8cd 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -249,6 +249,11 @@ checkpoint=%s[:%u[%]]	 Set to "disable" to turn off checkpointing. Set to "enabl
 			 This space is reclaimed once checkpoint=enable.
 compress_algorithm=%s	 Control compress algorithm, currently f2fs supports "lzo",
 			 "lz4", "zstd" and "lzo-rle" algorithm.
+compress_algorithm=%s:%d Control compress algorithm and its compress level, now, only
+			 "lz4" and "zstd" support compress level config.
+			 		level range
+			 lz4		3 - 16
+			 zstd		1 - 22
 compress_log_size=%u	 Support configuring compress cluster size, the size will
 			 be 4KB * (1 << %u), 16KB is minimum size, also it's
 			 default size.
diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index d13c5c6a9787..8134b145ae4f 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -119,6 +119,15 @@ config F2FS_FS_LZ4
 	help
 	  Support LZ4 compress algorithm, if unsure, say Y.
 
+config F2FS_FS_LZ4HC
+	bool "LZ4HC compression support"
+	depends on F2FS_FS_COMPRESSION
+	depends on F2FS_FS_LZ4
+	select LZ4HC_COMPRESS
+	default y
+	help
+	  Support LZ4HC compress algorithm, if unsure, say Y.
+
 config F2FS_FS_ZSTD
 	bool "ZSTD compression support"
 	depends on F2FS_FS_COMPRESSION
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7a7b29f3679a..32a5d7a13bd9 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -254,8 +254,13 @@ static const struct f2fs_compress_ops f2fs_lzo_ops = {
 #ifdef CONFIG_F2FS_FS_LZ4
 static int lz4_init_compress_ctx(struct compress_ctx *cc)
 {
-	cc->private = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
-				LZ4_MEM_COMPRESS, GFP_NOFS);
+	unsigned int size;
+	unsigned char level = F2FS_I(cc->inode)->i_compress_flag >>
+						COMPRESS_LEVEL_OFFSET;
+
+	size = level ? LZ4HC_MEM_COMPRESS : LZ4_MEM_COMPRESS;
+
+	cc->private = f2fs_kvmalloc(F2FS_I_SB(cc->inode), size, GFP_NOFS);
 	if (!cc->private)
 		return -ENOMEM;
 
@@ -274,10 +279,34 @@ static void lz4_destroy_compress_ctx(struct compress_ctx *cc)
 	cc->private = NULL;
 }
 
+#ifdef CONFIG_F2FS_FS_LZ4HC
+static int lz4hc_compress_pages(struct compress_ctx *cc)
+{
+	unsigned char level = F2FS_I(cc->inode)->i_compress_flag >>
+						COMPRESS_LEVEL_OFFSET;
+	int len;
+
+	if (level)
+		len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
+					cc->clen, level, cc->private);
+	else
+		len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
+						cc->clen, cc->private);
+	if (!len)
+		return -EAGAIN;
+
+	cc->clen = len;
+	return 0;
+}
+#endif
+
 static int lz4_compress_pages(struct compress_ctx *cc)
 {
 	int len;
 
+#ifdef CONFIG_F2FS_FS_LZ4HC
+	return lz4hc_compress_pages(cc);
+#endif
 	len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
 						cc->clen, cc->private);
 	if (!len)
@@ -327,8 +356,13 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	ZSTD_CStream *stream;
 	void *workspace;
 	unsigned int workspace_size;
+	unsigned char level = F2FS_I(cc->inode)->i_compress_flag >>
+						COMPRESS_LEVEL_OFFSET;
+
+	if (!level)
+		level = F2FS_ZSTD_DEFAULT_CLEVEL;
 
-	params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, cc->rlen, 0);
+	params = ZSTD_getParams(level, cc->rlen, 0);
 	workspace_size = ZSTD_CStreamWorkspaceBound(params.cParams);
 
 	workspace = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index caee0c29a97b..aae72d2ebad4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -149,6 +149,7 @@ struct f2fs_mount_info {
 	/* For compression */
 	unsigned char compress_algorithm;	/* algorithm type */
 	unsigned char compress_log_size;	/* cluster log size */
+	unsigned char compress_level;		/* compress level */
 	bool compress_chksum;			/* compressed data chksum */
 	unsigned char compress_ext_cnt;		/* extension count */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
@@ -734,6 +735,7 @@ struct f2fs_inode_info {
 	atomic_t i_compr_blocks;		/* # of compressed blocks */
 	unsigned char i_compress_algorithm;	/* algorithm type */
 	unsigned char i_log_cluster_size;	/* log of cluster size */
+	unsigned char i_compress_level;		/* compress level (lz4hc,zstd) */
 	unsigned short i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
 };
@@ -1294,6 +1296,9 @@ struct compress_data {
 
 #define F2FS_COMPRESSED_PAGE_MAGIC	0xF5F2C000
 
+#define	COMPRESS_LEVEL_OFFSET	8
+#define COMPRESS_INVALID_LEVEL	0xff
+
 /* compress context */
 struct compress_ctx {
 	struct inode *inode;		/* inode the context belong to */
@@ -3935,6 +3940,10 @@ static inline void set_compress_context(struct inode *inode)
 				1 << COMPRESS_CHKSUM : 0;
 	F2FS_I(inode)->i_cluster_size =
 			1 << F2FS_I(inode)->i_log_cluster_size;
+	if (F2FS_I(inode)->i_compress_algorithm == COMPRESS_LZ4 &&
+			F2FS_OPTION(sbi).compress_level)
+		F2FS_I(inode)->i_flags |= F2FS_OPTION(sbi).compress_level <<
+							COMPRESS_LEVEL_OFFSET;
 	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
 	set_inode_flag(inode, FI_COMPRESSED_FILE);
 	stat_inc_compr_inode(inode);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b0c6ef2df7b8..d4472917ffc1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -25,6 +25,8 @@
 #include <linux/quota.h>
 #include <linux/unicode.h>
 #include <linux/part_stat.h>
+#include <linux/zstd.h>
+#include <linux/lz4.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -464,6 +466,50 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 	return 0;
 }
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+static int f2fs_compress_set_level(struct f2fs_sb_info *sbi, const char *str,
+						int type)
+{
+	unsigned int level;
+	int len;
+
+	if (type == COMPRESS_LZ4)
+		len = 3;
+	else if (type == COMPRESS_ZSTD)
+		len = 4;
+
+	if (strlen(str) == len)
+		return 0;
+
+	str += len;
+
+	if (str[0] != ':') {
+		f2fs_info(sbi, "wrong format, e.g. <alg_name>:<compr_level>");
+		return -EINVAL;
+	}
+	if (kstrtouint(str + 1, 10, &level))
+		return -EINVAL;
+	if (type == COMPRESS_LZ4) {
+#ifdef CONFIG_F2FS_FS_LZ4HC
+		if (level < LZ4HC_MIN_CLEVEL || level > LZ4HC_MAX_CLEVEL) {
+			f2fs_info(sbi, "invalid lz4hc compress level: %d", level);
+			return -EINVAL;
+		}
+#else
+		f2fs_info(sbi, "doesn't support lz4hc compression");
+		return 0;
+#endif
+	} else if (type == COMPRESS_ZSTD) {
+		if (!level || level > ZSTD_maxCLevel()) {
+			f2fs_info(sbi, "invalid zstd compress level: %d", level);
+			return -EINVAL;
+		}
+	}
+	F2FS_OPTION(sbi).compress_level = level;
+	return 0;
+}
+#endif
+
 static int parse_options(struct super_block *sb, char *options, bool is_remount)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -884,10 +930,22 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (!strcmp(name, "lzo")) {
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZO;
-			} else if (!strcmp(name, "lz4")) {
+			} else if (!strncmp(name, "lz4", 3)) {
+				ret = f2fs_compress_set_level(sbi, name,
+								COMPRESS_LZ4);
+				if (ret) {
+					kfree(name);
+					return -EINVAL;
+				}
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_LZ4;
-			} else if (!strcmp(name, "zstd")) {
+			} else if (!strncmp(name, "zstd", 4)) {
+				ret = f2fs_compress_set_level(sbi, name,
+								COMPRESS_ZSTD);
+				if (ret) {
+					kfree(name);
+					return -EINVAL;
+				}
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_ZSTD;
 			} else if (!strcmp(name, "lzo-rle")) {
@@ -1530,6 +1588,9 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 	}
 	seq_printf(seq, ",compress_algorithm=%s", algtype);
 
+	if (F2FS_OPTION(sbi).compress_level != COMPRESS_INVALID_LEVEL)
+		seq_printf(seq, ":%d", F2FS_OPTION(sbi).compress_level);
+
 	seq_printf(seq, ",compress_log_size=%u",
 			F2FS_OPTION(sbi).compress_log_size);
 
@@ -1692,6 +1753,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
 	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
 	F2FS_OPTION(sbi).compress_ext_cnt = 0;
+	F2FS_OPTION(sbi).compress_level = COMPRESS_INVALID_LEVEL;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
 	sbi->sb->s_flags &= ~SB_INLINECRYPT;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 55be7afeee90..2dcc63fe8494 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -275,6 +275,9 @@ struct f2fs_inode {
 			__u8 i_compress_algorithm;	/* compress algorithm */
 			__u8 i_log_cluster_size;	/* log of cluster size */
 			__le16 i_compress_flag;		/* compress flag */
+						/* 0 bit: chksum flag
+						 * [10,15] bits: compress level
+						 */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		} __packed;
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
-- 
2.26.2

