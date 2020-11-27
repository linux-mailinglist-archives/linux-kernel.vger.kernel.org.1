Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449E72C66A8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgK0NUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730416AbgK0NUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:20:37 -0500
Received: from localhost.localdomain (unknown [49.77.180.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03412224A;
        Fri, 27 Nov 2020 13:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606483236;
        bh=RoBnMKMk2+nQSgM8kG4CDxlDlRoChZXV1gVhZwUI/mk=;
        h=From:To:Cc:Subject:Date:From;
        b=aD4a3aXuvVS5sERq4Vw/tkWAbtLkwEe6aoGnFufe/CrjuPfV4U6T9ddEkKLYxDSaN
         VOCNU1vY5ZQWwY5c4FnXZUve6HAewAI0HdLONhTSuJlRMVw3c+lD13hIspjEfWV0Rt
         aJX0mYzd8knH6Vs4vMKkM2d12dzEYHJ6l2Afydd8=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix kbytes written stat for multi-device case
Date:   Fri, 27 Nov 2020 21:20:06 +0800
Message-Id: <20201127132006.6251-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

For multi-device case, one f2fs image includes multi devices, so it
needs to account bytes written of all block devices belong to the image
rather than one main block device, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 27 +++++++++++++++++++++++----
 fs/f2fs/f2fs.h       |  8 +-------
 fs/f2fs/super.c      |  5 +----
 fs/f2fs/sysfs.c      |  3 ++-
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9b0628e0d8bc..97ac921bd581 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1385,6 +1385,27 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	f2fs_submit_merged_write(sbi, META_FLUSH);
 }
 
+static inline u64 get_sectors_written(struct block_device *bdev)
+{
+	return bdev->bd_part ?
+		(u64)part_stat_read(bdev->bd_part, sectors[STAT_WRITE]) : 0;
+}
+
+u64 f2fs_get_sectors_written(struct f2fs_sb_info *sbi)
+{
+	if (f2fs_is_multi_device(sbi)) {
+		u64 sectors = 0;
+		int i;
+
+		for (i = 0; i < sbi->s_ndevs; i++)
+			sectors += get_sectors_written(FDEV(i).bdev);
+
+		return sectors;
+	}
+
+	return get_sectors_written(sbi->sb->s_bdev);
+}
+
 static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -1395,7 +1416,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	__u32 crc32 = 0;
 	int i;
 	int cp_payload_blks = __cp_payload(sbi);
-	struct super_block *sb = sbi->sb;
 	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	u64 kbytes_written;
 	int err;
@@ -1490,9 +1510,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Record write statistics in the hot node summary */
 	kbytes_written = sbi->kbytes_written;
-	if (sb->s_bdev->bd_part)
-		kbytes_written += BD_PART_WRITTEN(sbi);
-
+	kbytes_written += (f2fs_get_sectors_written(sbi) -
+				sbi->sectors_written_start) >> 1;
 	seg_i->journal->info.kbytes_written = cpu_to_le64(kbytes_written);
 
 	if (__remain_node_summaries(cpc->reason)) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bfefdf99cd3e..d32065417616 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1613,13 +1613,6 @@ static inline bool f2fs_is_multi_device(struct f2fs_sb_info *sbi)
 	return sbi->s_ndevs > 1;
 }
 
-/* For write statistics. Suppose sector size is 512 bytes,
- * and the return value is in kbytes. s is of struct f2fs_sb_info.
- */
-#define BD_PART_WRITTEN(s)						 \
-(((u64)part_stat_read((s)->sb->s_bdev->bd_part, sectors[STAT_WRITE]) -   \
-		(s)->sectors_written_start) >> 1)
-
 static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
 {
 	unsigned long now = jiffies;
@@ -3392,6 +3385,7 @@ void f2fs_update_dirty_page(struct inode *inode, struct page *page);
 void f2fs_remove_dirty_inode(struct inode *inode);
 int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
 void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type);
+u64 f2fs_get_sectors_written(struct f2fs_sb_info *sbi);
 int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi);
 int __init f2fs_create_checkpoint_caches(void);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e71db2a0a9c7..b0c6ef2df7b8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3719,10 +3719,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	/* For write statistics */
-	if (sb->s_bdev->bd_part)
-		sbi->sectors_written_start =
-			(u64)part_stat_read(sb->s_bdev->bd_part,
-					    sectors[STAT_WRITE]);
+	sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
 
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 8c63a6e61dfd..0a7383e1302d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -97,7 +97,8 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 
 	return sprintf(buf, "%llu\n",
 			(unsigned long long)(sbi->kbytes_written +
-			BD_PART_WRITTEN(sbi)));
+			((f2fs_get_sectors_written(sbi) -
+				sbi->sectors_written_start) >> 1)));
 }
 
 static ssize_t features_show(struct f2fs_attr *a,
-- 
2.22.0

