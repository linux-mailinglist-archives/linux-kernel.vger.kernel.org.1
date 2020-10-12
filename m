Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC228B119
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgJLJG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:06:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbgJLJGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:06:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 80AB1FCFC1F4BC6F89CA;
        Mon, 12 Oct 2020 17:06:47 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 17:06:40 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: introduce check_swap_activate_fast()
Date:   Mon, 12 Oct 2020 17:06:05 +0800
Message-ID: <20201012090605.30604-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_swap_activate() will lookup block mapping via bmap() one by one, so
its performance is very bad, this patch introduces check_swap_activate_fast()
to use f2fs_fiemap() to boost this process, since f2fs_fiemap() will lookup
block mappings in batch, therefore, it can improve swapon()'s performance
significantly.

Note that this enhancement only works when page size is equal to f2fs' block
size.

Testcase: (backend device: zram)
- touch file
- pin & fallocate file to 8GB
- mkswap file
- swapon file

Before:
real	0m2.999s
user	0m0.000s
sys	0m2.980s

After:
real	0m0.081s
user	0m0.000s
sys	0m0.064s

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ee87407602fa..be4da52604ed 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3883,6 +3883,83 @@ int f2fs_migrate_page(struct address_space *mapping,
 #endif
 
 #ifdef CONFIG_SWAP
+static int check_swap_activate_fast(struct swap_info_struct *sis,
+				struct file *swap_file, sector_t *span)
+{
+	struct address_space *mapping = swap_file->f_mapping;
+	struct inode *inode = mapping->host;
+	sector_t cur_lblock;
+	sector_t last_lblock;
+	sector_t pblock;
+	sector_t lowest_pblock = -1;
+	sector_t highest_pblock = 0;
+	int nr_extents = 0;
+	unsigned long nr_pblocks;
+	unsigned long len;
+	int ret;
+
+	/*
+	 * Map all the blocks into the extent list.  This code doesn't try
+	 * to be very smart.
+	 */
+	cur_lblock = 0;
+	last_lblock = logical_to_blk(inode, i_size_read(inode));
+	len = i_size_read(inode);
+
+	while (cur_lblock <= last_lblock && cur_lblock < sis->max) {
+		struct buffer_head map_bh;
+		pgoff_t next_pgofs;
+
+		cond_resched();
+
+		memset(&map_bh, 0, sizeof(struct buffer_head));
+		map_bh.b_size = len - cur_lblock;
+
+		ret = get_data_block(inode, cur_lblock, &map_bh, 0,
+					F2FS_GET_BLOCK_FIEMAP, &next_pgofs);
+		if (ret)
+			goto err_out;
+
+		/* hole */
+		if (!buffer_mapped(&map_bh))
+			goto err_out;
+
+		pblock = map_bh.b_blocknr;
+		nr_pblocks = logical_to_blk(inode, map_bh.b_size);
+
+		if (cur_lblock + nr_pblocks >= sis->max)
+			nr_pblocks = sis->max - cur_lblock;
+
+		if (cur_lblock) {	/* exclude the header page */
+			if (pblock < lowest_pblock)
+				lowest_pblock = pblock;
+			if (pblock + nr_pblocks - 1 > highest_pblock)
+				highest_pblock = pblock + nr_pblocks - 1;
+		}
+
+		/*
+		 * We found a PAGE_SIZE-length, PAGE_SIZE-aligned run of blocks
+		 */
+		ret = add_swap_extent(sis, cur_lblock, nr_pblocks, pblock);
+		if (ret < 0)
+			goto out;
+		nr_extents += ret;
+		cur_lblock += nr_pblocks;
+	}
+	ret = nr_extents;
+	*span = 1 + highest_pblock - lowest_pblock;
+	if (cur_lblock == 0)
+		cur_lblock = 1;	/* force Empty message */
+	sis->max = cur_lblock;
+	sis->pages = cur_lblock - 1;
+	sis->highest_bit = cur_lblock - 1;
+out:
+	return ret;
+err_out:
+	pr_err("swapon: swapfile has holes\n");
+	return -EINVAL;
+}
+
 /* Copied from generic_swapfile_activate() to check any holes */
 static int check_swap_activate(struct swap_info_struct *sis,
 				struct file *swap_file, sector_t *span)
@@ -3899,6 +3976,9 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	int nr_extents = 0;
 	int ret;
 
+	if (PAGE_SIZE == F2FS_BLKSIZE)
+		return check_swap_activate_fast(sis, swap_file, span);
+
 	blkbits = inode->i_blkbits;
 	blocks_per_page = PAGE_SIZE >> blkbits;
 
-- 
2.26.2

