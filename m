Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3D2D3B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 07:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgLIG0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:26:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9402 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgLIG0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:26:10 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CrRq85JpCz7Bk1;
        Wed,  9 Dec 2020 14:24:52 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Dec 2020 14:25:14 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RESEND 1/6] f2fs: compress: support chksum
Date:   Wed, 9 Dec 2020 14:24:52 +0800
Message-ID: <20201209062457.111907-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports to store chksum value with compressed
data, and verify the integrality of compressed data while
reading the data.

The feature can be enabled through specifying mount option
'compress_chksum'.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.rst |  1 +
 fs/f2fs/compress.c                 | 22 ++++++++++++++++++++++
 fs/f2fs/f2fs.h                     | 16 ++++++++++++++--
 fs/f2fs/inode.c                    |  3 +++
 fs/f2fs/super.c                    |  9 +++++++++
 include/linux/f2fs_fs.h            |  2 +-
 6 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 5eb8d63439ec..41de149f11cb 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -267,6 +267,7 @@ compress_mode=%s	 Control file compression mode. This supports "fs" and "user"
 			 choosing the target file and the timing. The user can do manual
 			 compression/decompression on the compression enabled files using
 			 ioctls.
+compress_chksum		 Support verifying chksum of raw data in compressed cluster.
 inlinecrypt		 When possible, encrypt/decrypt the contents of encrypted
 			 files using the blk-crypto framework rather than
 			 filesystem-layer encryption. This allows the use of
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 708a563583db..4bcbacfe3325 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -602,6 +602,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 				f2fs_cops[fi->i_compress_algorithm];
 	unsigned int max_len, new_nr_cpages;
 	struct page **new_cpages;
+	u32 chksum = 0;
 	int i, ret;
 
 	trace_f2fs_compress_pages_start(cc->inode, cc->cluster_idx,
@@ -655,6 +656,11 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 
 	cc->cbuf->clen = cpu_to_le32(cc->clen);
 
+	if (fi->i_compress_flag & 1 << COMPRESS_CHKSUM)
+		chksum = f2fs_crc32(F2FS_I_SB(cc->inode),
+					cc->cbuf->cdata, cc->clen);
+	cc->cbuf->chksum = cpu_to_le32(chksum);
+
 	for (i = 0; i < COMPRESS_DATA_RESERVED_SIZE; i++)
 		cc->cbuf->reserved[i] = cpu_to_le32(0);
 
@@ -790,6 +796,22 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 
 	ret = cops->decompress_pages(dic);
 
+	if (!ret && (fi->i_compress_flag & 1 << COMPRESS_CHKSUM)) {
+		u32 provided = le32_to_cpu(dic->cbuf->chksum);
+		u32 calculated = f2fs_crc32(sbi, dic->cbuf->cdata, dic->clen);
+
+		if (provided != calculated) {
+			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
+				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
+				printk_ratelimited(
+					"%sF2FS-fs (%s): checksum invalid, nid = %lu, %x vs %x",
+					KERN_INFO, sbi->sb->s_id, dic->inode->i_ino,
+					provided, calculated);
+			}
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+		}
+	}
+
 out_vunmap_cbuf:
 	vm_unmap_ram(dic->cbuf, dic->nr_cpages);
 out_vunmap_rbuf:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6edb2adc410e..7364d453783f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -145,7 +145,8 @@ struct f2fs_mount_info {
 
 	/* For compression */
 	unsigned char compress_algorithm;	/* algorithm type */
-	unsigned compress_log_size;		/* cluster log size */
+	unsigned char compress_log_size;	/* cluster log size */
+	bool compress_chksum;			/* compressed data chksum */
 	unsigned char compress_ext_cnt;		/* extension count */
 	int compress_mode;			/* compression mode */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
@@ -675,6 +676,7 @@ enum {
 	FI_ATOMIC_REVOKE_REQUEST, /* request to drop atomic data */
 	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
+	FI_COMPRESS_CORRUPT,	/* indicate compressed cluster is corrupted */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
 	FI_ENABLE_COMPRESS,	/* enable compression in "user" compression mode */
 	FI_MAX,			/* max flag, never be used */
@@ -733,6 +735,7 @@ struct f2fs_inode_info {
 	atomic_t i_compr_blocks;		/* # of compressed blocks */
 	unsigned char i_compress_algorithm;	/* algorithm type */
 	unsigned char i_log_cluster_size;	/* log of cluster size */
+	unsigned short i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
 };
 
@@ -1290,9 +1293,15 @@ enum compress_algorithm_type {
 	COMPRESS_MAX,
 };
 
-#define COMPRESS_DATA_RESERVED_SIZE		5
+enum compress_flag {
+	COMPRESS_CHKSUM,
+	COMPRESS_MAX_FLAG,
+};
+
+#define COMPRESS_DATA_RESERVED_SIZE		4
 struct compress_data {
 	__le32 clen;			/* compressed data size */
+	__le32 chksum;			/* compressed data chksum */
 	__le32 reserved[COMPRESS_DATA_RESERVED_SIZE];	/* reserved */
 	u8 cdata[];			/* compressed data */
 };
@@ -3918,6 +3927,9 @@ static inline void set_compress_context(struct inode *inode)
 			F2FS_OPTION(sbi).compress_algorithm;
 	F2FS_I(inode)->i_log_cluster_size =
 			F2FS_OPTION(sbi).compress_log_size;
+	F2FS_I(inode)->i_compress_flag =
+			F2FS_OPTION(sbi).compress_chksum ?
+				1 << COMPRESS_CHKSUM : 0;
 	F2FS_I(inode)->i_cluster_size =
 			1 << F2FS_I(inode)->i_log_cluster_size;
 	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 657db2fb6739..349d9cb933ee 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -456,6 +456,7 @@ static int do_read_inode(struct inode *inode)
 					le64_to_cpu(ri->i_compr_blocks));
 			fi->i_compress_algorithm = ri->i_compress_algorithm;
 			fi->i_log_cluster_size = ri->i_log_cluster_size;
+			fi->i_compress_flag = le16_to_cpu(ri->i_compress_flag);
 			fi->i_cluster_size = 1 << fi->i_log_cluster_size;
 			set_inode_flag(inode, FI_COMPRESSED_FILE);
 		}
@@ -634,6 +635,8 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 					&F2FS_I(inode)->i_compr_blocks));
 			ri->i_compress_algorithm =
 				F2FS_I(inode)->i_compress_algorithm;
+			ri->i_compress_flag =
+				cpu_to_le16(F2FS_I(inode)->i_compress_flag);
 			ri->i_log_cluster_size =
 				F2FS_I(inode)->i_log_cluster_size;
 		}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1610d38ed83b..53c84eb9c330 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -147,6 +147,7 @@ enum {
 	Opt_compress_log_size,
 	Opt_compress_extension,
 	Opt_compress_mode,
+	Opt_compress_chksum,
 	Opt_atgc,
 	Opt_err,
 };
@@ -216,6 +217,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
 	{Opt_compress_mode, "compress_mode=%s"},
+	{Opt_compress_chksum, "compress_chksum"},
 	{Opt_atgc, "atgc"},
 	{Opt_err, NULL},
 };
@@ -950,11 +952,15 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			}
 			kfree(name);
 			break;
+		case Opt_compress_chksum:
+			F2FS_OPTION(sbi).compress_chksum = true;
+			break;
 #else
 		case Opt_compress_algorithm:
 		case Opt_compress_log_size:
 		case Opt_compress_extension:
 		case Opt_compress_mode:
+		case Opt_compress_chksum:
 			f2fs_info(sbi, "compression options not supported");
 			break;
 #endif
@@ -1545,6 +1551,9 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 		seq_printf(seq, ",compress_mode=%s", "fs");
 	else if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER)
 		seq_printf(seq, ",compress_mode=%s", "user");
+
+	if (F2FS_OPTION(sbi).compress_chksum)
+		seq_puts(seq, ",compress_chksum");
 }
 
 static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a5dbb57a687f..7dc2a06cf19a 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -273,7 +273,7 @@ struct f2fs_inode {
 			__le64 i_compr_blocks;	/* # of compressed blocks */
 			__u8 i_compress_algorithm;	/* compress algorithm */
 			__u8 i_log_cluster_size;	/* log of cluster size */
-			__le16 i_padding;		/* padding */
+			__le16 i_compress_flag;		/* compress flag */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		} __packed;
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
-- 
2.29.2

