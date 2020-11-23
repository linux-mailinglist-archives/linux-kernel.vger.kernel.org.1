Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED05D2BFE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgKWDSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgKWDSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:18:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3EFC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:18:03 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n137so3555553pfd.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjLsbUaqfKFGANYSzVJCJ4DzwFOIjnzbFmDEwR+KDb0=;
        b=loHH8aLfeAQgvSfnU1RknoT/L5AuC9ISVx2CV+eDlWFIf3I+0zTaa/StP6GO6TOWpn
         6WVwK18ORrkwgAPIpeqRl367g1r6zxXJZwGJ8DkGzsrvOWnJz/Uj31jrMCzpEDY8Fgpx
         3DLaPyK7WaaxKqFR1Y3HygAuP7rEyufqqwpx2EMAreuDjvyKitMX6Cvc5eqn2gk/YZhc
         j2qBnTniU73l+cpMRV6/j1lGdv9+4eEDavazVeLfUZX5VrTUUP+kBmiMWk3346lfVL/2
         aDR7mIUB+LWPVkuE5FCJ9K/zU6FnxxSSmHx4quoQZUMqOaNtrndF3Jv2zRL8K4SqMgwA
         r+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjLsbUaqfKFGANYSzVJCJ4DzwFOIjnzbFmDEwR+KDb0=;
        b=gbk8wxJCk8AnZ4F3St8n39lV3sPDt/JlHWsdJXeTmKXcSOVOLjzVzosP+698Be1Ykx
         3F3mKJbC34+cKiBpwzZbb5H/8MVs2T++i9KnNojIwlKLzBk+mC9q611uWtLR9ocYqwTQ
         zI4ts5dJ/F4kSARZp37yJchU4oTK00LqWvKeZIiXHyckQOzsPAXAYIjs0LTB1HWOTfij
         f/6HERGlq0TRV4uzEWjM8upBY9W+1fulN634flzg2MERGpQkwUvwyKmtw7MV0pCupyt3
         acy0WmjyylhKh5xfDbRqdWLQV1h3lH6boY4ns913XE95Cl4A0hn7Akx8IQ84uXi/sB43
         fHfQ==
X-Gm-Message-State: AOAM531kpA0K9RcDiJD3lf0Hw0ecQxi+XvwR7p8mdRVXWOy9CyleBfwh
        s6yZ6zGyHKwyjepNf6iS4wfB6R2A15Y=
X-Google-Smtp-Source: ABdhPJzzCisCzij78K2z6i2/m4zf8gNnqD6i7qRO1OWPlMTJrCEYBjbOhMuhP0ycswTxRC96j4GfGQ==
X-Received: by 2002:a65:52c4:: with SMTP id z4mr26938950pgp.238.1606101482693;
        Sun, 22 Nov 2020 19:18:02 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id i3sm7214044pjs.34.2020.11.22.19.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 19:18:02 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs: add compress_mode mount option
Date:   Mon, 23 Nov 2020 12:17:50 +0900
Message-Id: <20201123031751.36811-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We will add a new "compress_mode" mount option to control file
compression mode. This supports "fs-based" and "user-based".
In "fs-based" mode (default), f2fs does automatic compression on
the compression enabled files. In "user-based" mode, f2fs disables
the automaic compression and gives the user discretion of choosing
the target file and the timing. It means the user can do manual
compression/decompression on the compression enabled files using ioctls.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/filesystems/f2fs.rst |  7 +++++++
 fs/f2fs/data.c                     | 10 +++++-----
 fs/f2fs/f2fs.h                     | 30 ++++++++++++++++++++++++++++++
 fs/f2fs/segment.c                  |  2 +-
 fs/f2fs/super.c                    | 23 +++++++++++++++++++++++
 5 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index b8ee761c9922..0679c53d5012 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -260,6 +260,13 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
 			 For other files, we can still enable compression via ioctl.
 			 Note that, there is one reserved special extension '*', it
 			 can be set to enable compression for all files.
+compress_mode=%s	 Control file compression mode. This supports "fs-based" and
+			 "user-based". In "fs-based" mode (default), f2fs does
+			 automatic compression on the compression enabled files.
+			 In "user-based" mode, f2fs disables the automaic compression
+			 and gives the user discretion of choosing the target file and
+			 the timing. The user can do manual compression/decompression
+			 on the compression enabled files using ioctls.
 inlinecrypt		 When possible, encrypt/decrypt the contents of encrypted
 			 files using the blk-crypto framework rather than
 			 filesystem-layer encryption. This allows the use of
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index be4da52604ed..69370f0073dd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2896,7 +2896,7 @@ static int f2fs_write_data_page(struct page *page,
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		goto out;
 
-	if (f2fs_compressed_file(inode)) {
+	if (f2fs_need_compress_write(inode)) {
 		if (f2fs_is_compressed_cluster(inode, page->index)) {
 			redirty_page_for_writepage(wbc, page);
 			return AOP_WRITEPAGE_ACTIVATE;
@@ -2988,7 +2988,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 readd:
 			need_readd = false;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-			if (f2fs_compressed_file(inode)) {
+			if (f2fs_need_compress_write(inode)) {
 				ret = f2fs_init_compress_ctx(&cc);
 				if (ret) {
 					done = 1;
@@ -3067,7 +3067,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				goto continue_unlock;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-			if (f2fs_compressed_file(inode)) {
+			if (f2fs_need_compress_write(inode)) {
 				get_page(page);
 				f2fs_compress_ctx_add_page(&cc, page);
 				continue;
@@ -3120,7 +3120,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	/* flush remained pages in compress cluster */
-	if (f2fs_compressed_file(inode) && !f2fs_cluster_is_empty(&cc)) {
+	if (f2fs_need_compress_write(inode) && !f2fs_cluster_is_empty(&cc)) {
 		ret = f2fs_write_multi_pages(&cc, &submitted, wbc, io_type);
 		nwritten += submitted;
 		wbc->nr_to_write -= submitted;
@@ -3164,7 +3164,7 @@ static inline bool __should_serialize_io(struct inode *inode,
 	if (IS_NOQUOTA(inode))
 		return false;
 
-	if (f2fs_compressed_file(inode))
+	if (f2fs_need_compress_write(inode))
 		return true;
 	if (wbc->sync_mode != WB_SYNC_ALL)
 		return true;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e0826779a101..88e012d07ad5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -149,6 +149,7 @@ struct f2fs_mount_info {
 	unsigned char compress_algorithm;	/* algorithm type */
 	unsigned compress_log_size;		/* cluster log size */
 	unsigned char compress_ext_cnt;		/* extension count */
+	int compress_mode;			/* compression mode */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 };
 
@@ -677,6 +678,7 @@ enum {
 	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
+	FI_ENABLE_COMPRESS,	/* enable compression in user-based compression mode */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -1243,6 +1245,18 @@ enum fsync_mode {
 	FSYNC_MODE_NOBARRIER,	/* fsync behaves nobarrier based on posix */
 };
 
+enum {
+	COMPR_MODE_FS,		/*
+				 * automatically compress compression
+				 * enabled files
+				 */
+	COMPR_MODE_USER,	/*
+				 * automatical compression is disabled.
+				 * user can control the file compression
+				 * using ioctls
+				 */
+};
+
 /*
  * this value is set in page as a private data which indicate that
  * the page is atomically written, and it is in inmem_pages list.
@@ -2752,6 +2766,22 @@ static inline int f2fs_compressed_file(struct inode *inode)
 		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
 }
 
+static inline int f2fs_need_compress_write(struct inode *inode)
+{
+	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
+
+	if (!f2fs_compressed_file(inode))
+		return 0;
+
+	if (compress_mode == COMPR_MODE_FS)
+		return 1;
+	else if (compress_mode == COMPR_MODE_USER &&
+			is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
+		return 1;
+
+	return 0;
+}
+
 static inline unsigned int addrs_per_inode(struct inode *inode)
 {
 	unsigned int addrs = CUR_ADDRS_PER_INODE(inode) -
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1596502f7375..652ca049bb7e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3254,7 +3254,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			else
 				return CURSEG_COLD_DATA;
 		}
-		if (file_is_cold(inode) || f2fs_compressed_file(inode))
+		if (file_is_cold(inode) || f2fs_need_compress_write(inode))
 			return CURSEG_COLD_DATA;
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87f7a6e86370..ea2385aa7f48 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -146,6 +146,7 @@ enum {
 	Opt_compress_algorithm,
 	Opt_compress_log_size,
 	Opt_compress_extension,
+	Opt_compress_mode,
 	Opt_atgc,
 	Opt_err,
 };
@@ -214,6 +215,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_compress_algorithm, "compress_algorithm=%s"},
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
+	{Opt_compress_mode, "compress_mode=%s"},
 	{Opt_atgc, "atgc"},
 	{Opt_err, NULL},
 };
@@ -934,10 +936,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
 			break;
+		case Opt_compress_mode:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "fs-based")) {
+				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
+			} else if (!strcmp(name, "user-based")) {
+				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_USER;
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 #else
 		case Opt_compress_algorithm:
 		case Opt_compress_log_size:
 		case Opt_compress_extension:
+		case Opt_compress_mode:
 			f2fs_info(sbi, "compression options not supported");
 			break;
 #endif
@@ -1523,6 +1540,11 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 		seq_printf(seq, ",compress_extension=%s",
 			F2FS_OPTION(sbi).extensions[i]);
 	}
+
+	if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_FS)
+		seq_printf(seq, ",compress_mode=%s", "fs-based");
+	else if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER)
+		seq_printf(seq, ",compress_mode=%s", "user-based");
 }
 
 static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
@@ -1672,6 +1694,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
 	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
 	F2FS_OPTION(sbi).compress_ext_cnt = 0;
+	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
 	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-- 
2.29.2.454.gaff20da3a2-goog

