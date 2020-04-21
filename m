Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B05C1B2531
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgDULgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 07:36:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgDULgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:36:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E3F3D244BF4870A871B2;
        Tue, 21 Apr 2020 19:36:33 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 19:36:24 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: don't handle non-compressed data in workqueue
Date:   Tue, 21 Apr 2020 19:36:21 +0800
Message-ID: <20200421113621.60996-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bio has no compressed data, we don't need to handle end_io work in
workqueue, instead, it should just let interrupter handle it directly
to speed up IO response.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ff8a92df8d99..8607c02e8f96 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -114,7 +114,8 @@ static enum count_type __read_io_type(struct page *page)
 /* postprocessing steps for read bios */
 enum bio_post_read_step {
 	STEP_DECRYPT,
-	STEP_DECOMPRESS,
+	STEP_DECOMPRESS_NOWQ,		/* handle normal cluster data inplace */
+	STEP_DECOMPRESS,		/* handle compressed cluster data in workqueue */
 	STEP_VERITY,
 };
 
@@ -990,7 +991,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	if (f2fs_encrypted_file(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
 	if (f2fs_compressed_file(inode))
-		post_read_steps |= 1 << STEP_DECOMPRESS;
+		post_read_steps |= 1 << STEP_DECOMPRESS_NOWQ;
 	if (f2fs_need_verity(inode, first_idx))
 		post_read_steps |= 1 << STEP_VERITY;
 
@@ -2189,6 +2190,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	for (i = 0; i < dic->nr_cpages; i++) {
 		struct page *page = dic->cpages[i];
 		block_t blkaddr;
+		struct bio_post_read_ctx *ctx;
 
 		blkaddr = data_blkaddr(dn.inode, dn.node_page,
 						dn.ofs_in_node + i + 1);
@@ -2225,6 +2227,11 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
 			goto submit_and_realloc;
 
+		/* tag STEP_DECOMPRESS to handle IO in wq */
+		ctx = bio->bi_private;
+		if (!(ctx->enabled_steps & (1 << STEP_DECOMPRESS)))
+			ctx->enabled_steps |= 1 << STEP_DECOMPRESS;
+
 		inc_page_count(sbi, F2FS_RD_DATA);
 		f2fs_update_iostat(sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
 		ClearPageError(page);
-- 
2.18.0.rc1

