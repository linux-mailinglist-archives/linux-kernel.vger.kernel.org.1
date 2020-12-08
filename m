Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955B92D2156
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 04:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgLHDPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:15:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8963 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLHDPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:15:39 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cqlf14DmMzhp6j;
        Tue,  8 Dec 2020 11:14:33 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Dec 2020 11:14:50 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4] f2fs: compress: support chksum
Date:   Tue, 8 Dec 2020 11:14:37 +0800
Message-ID: <20201208031437.56627-1-yuchao0@huawei.com>
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
v4:
- enhance readability
- remove WARN_ON_ONCE()
 Documentation/filesystems/f2fs.rst |  1 +
 fs/f2fs/compress.c                 | 22 ++++++++++++++++++++++
 fs/f2fs/f2fs.h                     | 16 ++++++++++++++--
 fs/f2fs/inode.c                    |  3 +++
 fs/f2fs/super.c                    |  9 +++++++++
 include/linux/f2fs_fs.h            |  2 +-
 6 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index b8ee761c9922..985ae7d35066 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -260,6 +260,7 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
 			 For other files, we can still enable compression via ioctl.
 			 Note that, there is one reserved special extension '*', it
 			 can be set to enable compression for all files.
+compress_chksum		 Support verifying chksum of raw data in compressed cluster.
 inlinecrypt		 When possible, encrypt/decrypt the contents of encrypted
 			 files using the blk-crypto framework rather than
 			 filesystem-layer encryption. This allows the use of
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 14262e0f1cd6..9313c8695855 100644
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
index 0d25f5ca5618..0b314b2034d8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -147,7 +147,8 @@ struct f2fs_mount_info {
 
 	/* For compression */
 	unsigned char compress_algorithm;	/* algorithm type */
-	unsigned compress_log_size;		/* cluster log size */
+	unsigned char compress_log_size;	/* cluster log size */
+	bool compress_chksum;			/* compressed data chksum */
 	unsigned char compress_ext_cnt;		/* extension count */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 };
@@ -676,6 +677,7 @@ enum {
 	FI_ATOMIC_REVOKE_REQUEST, /* request to drop atomic data */
 	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
+	FI_COMPRESS_CORRUPT,	/* indicate compressed cluster is corrupted */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
 	FI_MAX,			/* max flag, never be used */
 };
@@ -733,6 +735,7 @@ struct f2fs_inode_info {
 	atomic_t i_compr_blocks;		/* # of compressed blocks */
 	unsigned char i_compress_algorithm;	/* algorithm type */
 	unsigned char i_log_cluster_size;	/* log of cluster size */
+	unsigned short i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
 };
 
@@ -1272,9 +1275,15 @@ enum compress_algorithm_type {
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
@@ -3888,6 +3897,9 @@ static inline void set_compress_context(struct inode *inode)
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
index 82baaa89c893..f3d919ee4dee 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -146,6 +146,7 @@ enum {
 	Opt_compress_algorithm,
 	Opt_compress_log_size,
 	Opt_compress_extension,
+	Opt_compress_chksum,
 	Opt_atgc,
 	Opt_err,
 };
@@ -214,6 +215,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_compress_algorithm, "compress_algorithm=%s"},
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
+	{Opt_compress_chksum, "compress_chksum"},
 	{Opt_atgc, "atgc"},
 	{Opt_err, NULL},
 };
@@ -934,10 +936,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
 			break;
+		case Opt_compress_chksum:
+			F2FS_OPTION(sbi).compress_chksum = true;
+			break;
 #else
 		case Opt_compress_algorithm:
 		case Opt_compress_log_size:
 		case Opt_compress_extension:
+		case Opt_compress_chksum:
 			f2fs_info(sbi, "compression options not supported");
 			break;
 #endif
@@ -1523,6 +1529,9 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 		seq_printf(seq, ",compress_extension=%s",
 			F2FS_OPTION(sbi).extensions[i]);
 	}
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

