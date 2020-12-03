Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA18B2CE03B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgLCU4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgLCU4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:56:13 -0500
From:   Jaegeuk Kim <jaegeuk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: introduce max_io_bytes, a sysfs entry, to limit bio size
Date:   Thu,  3 Dec 2020 12:55:22 -0800
Message-Id: <20201203205522.891082-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203205522.891082-1-jaegeuk@kernel.org>
References: <20201203205522.891082-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds max_io_bytes to limit bio size when f2fs tries to merge
consecutive IOs. This can give a testing point to split out bios and check
end_io handles those bios correctly. This is used to capture a recent bug
on the decompression and fsverity flow.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 7 +++++++
 fs/f2fs/data.c                          | 3 +++
 fs/f2fs/f2fs.h                          | 1 +
 fs/f2fs/sysfs.c                         | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 67b3ed8e8c2f..3dfee94e0618 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -370,3 +370,10 @@ Date:		April 2020
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Give a way to change iostat_period time. 3secs by default.
 		The new iostat trace gives stats gap given the period.
+What:		/sys/fs/f2fs/<disk>/max_io_bytes
+Date:		December 2020
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	This gives a control to limit the bio size in f2fs.
+		Default is zero, which will follow underlying block layer limit,
+		whereas, if it has a certain bytes value, f2fs won't submit a
+		bio larger than that size.
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e85fd8f77f3f..cb28089e1eff 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -736,6 +736,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 				block_t last_blkaddr, block_t cur_blkaddr)
 {
+	if (unlikely(sbi->max_io_bytes &&
+			bio->bi_iter.bi_size >= sbi->max_io_bytes))
+		return false;
 	if (last_blkaddr + 1 != cur_blkaddr)
 		return false;
 	return __same_bdev(sbi, cur_blkaddr, bio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 36090cd09011..594df6391390 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1446,6 +1446,7 @@ struct f2fs_sb_info {
 	loff_t max_file_blocks;			/* max block index of file */
 	int dir_level;				/* directory level */
 	int readdir_ra;				/* readahead inode in readdir */
+	u64 max_io_bytes;			/* max io bytes to merge IOs */
 
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index fce2997382af..989a649cfa8b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -567,6 +567,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info,
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_period_ms, iostat_period_ms);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_io_bytes, max_io_bytes);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_super_block, extension_list, extension_list);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -651,6 +652,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(iostat_enable),
 	ATTR_LIST(iostat_period_ms),
 	ATTR_LIST(readdir_ra),
+	ATTR_LIST(max_io_bytes),
 	ATTR_LIST(gc_pin_file_thresh),
 	ATTR_LIST(extension_list),
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-- 
2.29.2.576.ga3fc446d84-goog

