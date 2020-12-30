Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258012E7713
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 09:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL3Ija (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 03:39:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10099 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL3Ija (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 03:39:30 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D5Pmm3pZkzMBkC;
        Wed, 30 Dec 2020 16:37:44 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 30 Dec 2020 16:38:36 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: trival cleanup in move_data_block()
Date:   Wed, 30 Dec 2020 16:38:35 +0800
Message-ID: <20201230083835.115049-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trival cleanups:
- relocate set_summary() before its use
- relocate "allocate block address" to correct place
- remove unneeded f2fs_wait_on_page_writeback()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 43919a3ae6a6..4561c44dfa8f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1169,8 +1169,6 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	if (err)
 		goto put_out;
 
-	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
-
 	/* read page */
 	fio.page = page;
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
@@ -1207,6 +1205,9 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		}
 	}
 
+	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
+
+	/* allocate block address */
 	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
 				&sum, type, NULL);
 
@@ -1234,9 +1235,6 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	set_page_writeback(fio.encrypted_page);
 	ClearPageError(page);
 
-	/* allocate block address */
-	f2fs_wait_on_page_writeback(dn.node_page, NODE, true, true);
-
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
 	fio.new_blkaddr = newaddr;
-- 
2.29.2

