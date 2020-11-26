Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF2C2C4D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 03:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbgKZCYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 21:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732996AbgKZCYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 21:24:19 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7661420B1F;
        Thu, 26 Nov 2020 02:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606357458;
        bh=/EK1Ht2YSmcXKzOA8XtJjuwxh82MdQhwULTWNbahAzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDUXp9ny7CBTuPZ8sC/bxZ+iYpk1wYi7jCwz0arWov+y+oumFdeW2Jx3tPMkM4oN3
         +Oe1Rwjz7ItOp0C+A3MQ5zo3nLmCvrCFuNuhdfTw8lUSAF0UnYxfPg07DEiuk9rn4Z
         gwKpkcEwcLmR/Q3JllIeq9NKWb2uJAn9yj1kZCC4=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: use new conversion functions between blks and bytes
Date:   Wed, 25 Nov 2020 18:24:14 -0800
Message-Id: <20201126022416.3068426-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201126022416.3068426-1-jaegeuk@kernel.org>
References: <20201126022416.3068426-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up blks and bytes conversions.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a8612c6f40ab..a84e5bc09337 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1750,6 +1750,16 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
 	return true;
 }
 
+static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
+{
+	return (bytes >> inode->i_blkbits);
+}
+
+static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
+{
+	return (blks << inode->i_blkbits);
+}
+
 static int __get_data_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh, int create, int flag,
 			pgoff_t *next_pgofs, int seg_type, bool may_write)
@@ -1758,7 +1768,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	int err;
 
 	map.m_lblk = iblock;
-	map.m_len = bh->b_size >> inode->i_blkbits;
+	map.m_len = bytes_to_blks(inode, bh->b_size);
 	map.m_next_pgofs = next_pgofs;
 	map.m_next_extent = NULL;
 	map.m_seg_type = seg_type;
@@ -1768,7 +1778,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	if (!err) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
-		bh->b_size = (u64)map.m_len << inode->i_blkbits;
+		bh->b_size = blks_to_bytes(inode, map.m_len);
 	}
 	return err;
 }
@@ -1808,16 +1818,6 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 						NO_CHECK_TYPE, create);
 }
 
-static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
-{
-	return (bytes >> inode->i_blkbits);
-}
-
-static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
-{
-	return (blks << inode->i_blkbits);
-}
-
 static int f2fs_xattr_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo)
 {
@@ -2053,8 +2053,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 					bool is_readahead)
 {
 	struct bio *bio = *bio_ret;
-	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocksize = 1 << blkbits;
+	const unsigned blocksize = blks_to_bytes(inode, 1);
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
@@ -2063,8 +2062,8 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 
 	block_in_file = (sector_t)page_index(page);
 	last_block = block_in_file + nr_pages;
-	last_block_in_file = (f2fs_readpage_limit(inode) + blocksize - 1) >>
-							blkbits;
+	last_block_in_file = bytes_to_blks(inode,
+			f2fs_readpage_limit(inode) + blocksize - 1);
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
 
@@ -2177,16 +2176,15 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	struct bio *bio = *bio_ret;
 	unsigned int start_idx = cc->cluster_idx << cc->log_cluster_size;
 	sector_t last_block_in_file;
-	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocksize = 1 << blkbits;
+	const unsigned blocksize = blks_to_bytes(inode, 1);
 	struct decompress_io_ctx *dic = NULL;
 	int i;
 	int ret = 0;
 
 	f2fs_bug_on(sbi, f2fs_cluster_is_empty(cc));
 
-	last_block_in_file = (f2fs_readpage_limit(inode) +
-					blocksize - 1) >> blkbits;
+	last_block_in_file = bytes_to_blks(inode,
+			f2fs_readpage_limit(inode) + blocksize - 1);
 
 	/* get rid of pages beyond EOF */
 	for (i = 0; i < cc->cluster_size; i++) {
@@ -3968,7 +3966,6 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	struct inode *inode = mapping->host;
 	unsigned blocks_per_page;
 	unsigned long page_no;
-	unsigned blkbits;
 	sector_t probe_block;
 	sector_t last_block;
 	sector_t lowest_block = -1;
@@ -3979,8 +3976,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	if (PAGE_SIZE == F2FS_BLKSIZE)
 		return check_swap_activate_fast(sis, swap_file, span);
 
-	blkbits = inode->i_blkbits;
-	blocks_per_page = PAGE_SIZE >> blkbits;
+	blocks_per_page = bytes_to_blks(inode, PAGE_SIZE);
 
 	/*
 	 * Map all the blocks into the extent list.  This code doesn't try
@@ -3988,7 +3984,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	 */
 	probe_block = 0;
 	page_no = 0;
-	last_block = i_size_read(inode) >> blkbits;
+	last_block = bytes_to_blks(inode, i_size_read(inode));
 	while ((probe_block + blocks_per_page) <= last_block &&
 			page_no < sis->max) {
 		unsigned block_in_page;
@@ -4028,7 +4024,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 			}
 		}
 
-		first_block >>= (PAGE_SHIFT - blkbits);
+		first_block >>= (PAGE_SHIFT - inode->i_blkbits);
 		if (page_no) {	/* exclude the header page */
 			if (first_block < lowest_block)
 				lowest_block = first_block;
-- 
2.29.2.454.gaff20da3a2-goog

