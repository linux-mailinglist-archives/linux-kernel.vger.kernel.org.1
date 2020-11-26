Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85082C4D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 03:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbgKZCYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 21:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732996AbgKZCYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 21:24:18 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55B52075A;
        Thu, 26 Nov 2020 02:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606357457;
        bh=Alo9zNvA+1NWVx4osETZs6kbouoDQ8KV8oIAa+Uia5M=;
        h=From:To:Cc:Subject:Date:From;
        b=Rq1/TfKWQipMYYQjxO+g6ZXa133wOfhTo/9bTZlcCrkesTrP1NsicguAgztC7GyvN
         TlgSUFZxT2FMRdeE/hRYYu3AShOJ4oosWSJ5DDYdvEtAoog2qJckNSGv6rgomOhRcS
         fW2g+lubvcQm+XdKQvmzdZAuZgR0IlveFnufGKdw=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: rename logical_to_blk and blk_to_logical
Date:   Wed, 25 Nov 2020 18:24:13 -0800
Message-Id: <20201126022416.3068426-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames two functions like below having u64.
 - logical_to_blk to bytes_to_blks
 - blk_to_logical to blks_to_bytes

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index be4da52604ed..a8612c6f40ab 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1808,14 +1808,14 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 						NO_CHECK_TYPE, create);
 }
 
-static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
+static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
 {
-	return (offset >> inode->i_blkbits);
+	return (bytes >> inode->i_blkbits);
 }
 
-static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
+static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
 {
-	return (blk << inode->i_blkbits);
+	return (blks << inode->i_blkbits);
 }
 
 static int f2fs_xattr_fiemap(struct inode *inode,
@@ -1843,7 +1843,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			return err;
 		}
 
-		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
+		phys = blks_to_bytes(inode, ni.blk_addr);
 		offset = offsetof(struct f2fs_inode, i_addr) +
 					sizeof(__le32) * (DEF_ADDRS_PER_INODE -
 					get_inline_xattr_addrs(inode));
@@ -1875,7 +1875,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			return err;
 		}
 
-		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
+		phys = blks_to_bytes(inode, ni.blk_addr);
 		len = inode->i_sb->s_blocksize;
 
 		f2fs_put_page(page, 1);
@@ -1945,18 +1945,18 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			goto out;
 	}
 
-	if (logical_to_blk(inode, len) == 0)
-		len = blk_to_logical(inode, 1);
+	if (bytes_to_blks(inode, len) == 0)
+		len = blks_to_bytes(inode, 1);
 
-	start_blk = logical_to_blk(inode, start);
-	last_blk = logical_to_blk(inode, start + len - 1);
+	start_blk = bytes_to_blks(inode, start);
+	last_blk = bytes_to_blks(inode, start + len - 1);
 
 next:
 	memset(&map_bh, 0, sizeof(struct buffer_head));
 	map_bh.b_size = len;
 
 	if (compr_cluster)
-		map_bh.b_size = blk_to_logical(inode, cluster_size - 1);
+		map_bh.b_size = blks_to_bytes(inode, cluster_size - 1);
 
 	ret = get_data_block(inode, start_blk, &map_bh, 0,
 					F2FS_GET_BLOCK_FIEMAP, &next_pgofs);
@@ -1967,7 +1967,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!buffer_mapped(&map_bh)) {
 		start_blk = next_pgofs;
 
-		if (blk_to_logical(inode, start_blk) < blk_to_logical(inode,
+		if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
 						max_inode_blocks(inode)))
 			goto prep_next;
 
@@ -1993,9 +1993,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		compr_cluster = false;
 
 
-		logical = blk_to_logical(inode, start_blk - 1);
-		phys = blk_to_logical(inode, map_bh.b_blocknr);
-		size = blk_to_logical(inode, cluster_size);
+		logical = blks_to_bytes(inode, start_blk - 1);
+		phys = blks_to_bytes(inode, map_bh.b_blocknr);
+		size = blks_to_bytes(inode, cluster_size);
 
 		flags |= FIEMAP_EXTENT_ENCODED;
 
@@ -2013,14 +2013,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		goto prep_next;
 	}
 
-	logical = blk_to_logical(inode, start_blk);
-	phys = blk_to_logical(inode, map_bh.b_blocknr);
+	logical = blks_to_bytes(inode, start_blk);
+	phys = blks_to_bytes(inode, map_bh.b_blocknr);
 	size = map_bh.b_size;
 	flags = 0;
 	if (buffer_unwritten(&map_bh))
 		flags = FIEMAP_EXTENT_UNWRITTEN;
 
-	start_blk += logical_to_blk(inode, size);
+	start_blk += bytes_to_blks(inode, size);
 
 prep_next:
 	cond_resched();
@@ -3903,7 +3903,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	 * to be very smart.
 	 */
 	cur_lblock = 0;
-	last_lblock = logical_to_blk(inode, i_size_read(inode));
+	last_lblock = bytes_to_blks(inode, i_size_read(inode));
 	len = i_size_read(inode);
 
 	while (cur_lblock <= last_lblock && cur_lblock < sis->max) {
@@ -3925,7 +3925,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 			goto err_out;
 
 		pblock = map_bh.b_blocknr;
-		nr_pblocks = logical_to_blk(inode, map_bh.b_size);
+		nr_pblocks = bytes_to_blks(inode, map_bh.b_size);
 
 		if (cur_lblock + nr_pblocks >= sis->max)
 			nr_pblocks = sis->max - cur_lblock;
-- 
2.29.2.454.gaff20da3a2-goog

