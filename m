Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8948F2ECCE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbhAGJdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:33:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10115 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbhAGJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:33:31 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DBLbY2NRRz15q3p;
        Thu,  7 Jan 2021 17:31:53 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 7 Jan 2021 17:32:41 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: fix potential deadlock
Date:   Thu, 7 Jan 2021 17:32:37 +0800
Message-ID: <20210107093237.117526-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic/269 reports a hangtask issue, the root cause is ABBA deadlock
described as below:

Thread A			Thread B
- down_write(&sbi->gc_lock) -- A
				- f2fs_write_data_pages
				 - lock all pages in cluster -- B
				 - f2fs_write_multi_pages
				  - f2fs_write_raw_pages
				   - f2fs_write_single_data_page
				    - f2fs_balance_fs
				     - down_write(&sbi->gc_lock) -- A
- f2fs_gc
 - do_garbage_collect
  - ra_data_block
   - pagecache_get_page -- B

To fix this, it needs to avoid calling f2fs_balance_fs() if there is
still cluster pages been locked in context of cluster writeback, so
instead, let's call f2fs_balance_fs() in the end of
f2fs_write_raw_pages() when all cluster pages were unlocked.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c |  4 +++-
 fs/f2fs/data.c     | 10 ++++++----
 fs/f2fs/f2fs.h     |  2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index cb16b0437bd4..fc3d67055ce5 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1461,7 +1461,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 
 		ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
 						NULL, NULL, wbc, io_type,
-						compr_blocks);
+						compr_blocks, false);
 		if (ret) {
 			if (ret == AOP_WRITEPAGE_ACTIVATE) {
 				unlock_page(cc->rpages[i]);
@@ -1495,6 +1495,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		}
 
 		*submitted += _submitted;
+
+		f2fs_balance_fs(F2FS_M_SB(mapping), true);
 	}
 	return 0;
 out_err:
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 427a527eb17e..f8578fad7cd1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2684,7 +2684,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 				sector_t *last_block,
 				struct writeback_control *wbc,
 				enum iostat_type io_type,
-				int compr_blocks)
+				int compr_blocks,
+				bool allow_balance)
 {
 	struct inode *inode = page->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -2822,7 +2823,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	}
 	unlock_page(page);
 	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode) &&
-					!F2FS_I(inode)->cp_task)
+			!F2FS_I(inode)->cp_task && allow_balance)
 		f2fs_balance_fs(sbi, need_balance_fs);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -2869,7 +2870,7 @@ static int f2fs_write_data_page(struct page *page,
 #endif
 
 	return f2fs_write_single_data_page(page, NULL, NULL, NULL,
-						wbc, FS_DATA_IO, 0);
+						wbc, FS_DATA_IO, 0, true);
 }
 
 /*
@@ -3037,7 +3038,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			}
 #endif
 			ret = f2fs_write_single_data_page(page, &submitted,
-					&bio, &last_block, wbc, io_type, 0);
+					&bio, &last_block, wbc, io_type,
+					0, true);
 			if (ret == AOP_WRITEPAGE_ACTIVATE)
 				unlock_page(page);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 67086c6072ad..5cc1486f0b9f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3511,7 +3511,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 				struct bio **bio, sector_t *last_block,
 				struct writeback_control *wbc,
 				enum iostat_type io_type,
-				int compr_blocks);
+				int compr_blocks, bool allow_balance);
 void f2fs_invalidate_page(struct page *page, unsigned int offset,
 			unsigned int length);
 int f2fs_release_page(struct page *page, gfp_t wait);
-- 
2.29.2

