Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63072A3709
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgKBXQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBXQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:16:25 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A7C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 15:16:24 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 140so13160598qko.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 15:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHxtWmvNylnf6rQzFb0RZ+Rsys7/Rl/YzUaq91gRse4=;
        b=It7uQ2k7bjq8BKf/Fouo7sRWQsHa1XaQsV6zfNj4D0mHdlGBklYHTZELkSblWDF+tB
         t8zcSvDUacjYmU9/PqKsH9OmWhtjqam28TeCJK+4f/CVAJVYH5/siX4JUNtQOZFvTWZN
         C5bNwtHfeez4ZMTnNLE6FQbz+91pEWDySyuPkC7fEaMccvif6Z2zG13AJcLWA4gOG/ex
         4dn4cZIDa2d74nH+UhlH4gNHl1BPBRr6Lw29qIRcpdagazR3HAKYC3ht1RvLz2RT932c
         lw4Llp88yl3UDAAO4OIOR8Knik1pGZNGR3F57eD5A6UY5BHKxrnTA1MzLJwIboBUHI1d
         uveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHxtWmvNylnf6rQzFb0RZ+Rsys7/Rl/YzUaq91gRse4=;
        b=VfRqG5EomKGxMhF58GAJX+xqXs4v5tBfcClcR2wiveeAmfbVKklaX2sZo/tomLBcQm
         WELfKQOm2Io0p2sc7m1DVTJsEH/UYpXIBFrD8W70AC2yZrcL3a2BeEG1nDLY44z84BAi
         8TiqUxBx7TN4fWtbaTgj4PvNAnkkcDvQw3Y3QQSoMArExBE7QRZBBlYV2q57qZEyMOkO
         XZjj3BxSn/j5d1OCQhPtPkYXQV1NQ6Urv9ra8x1Hp8ZgwltaYMe0pf+0epF+H8JGBgj8
         gC9pIxu/VwsrZWkq2/qZaoMxdrYi1DEI+PHZIjewWvYz3D7sVIEpIFkIxcagHEwY/e/q
         eC1A==
X-Gm-Message-State: AOAM530a9gY4cMYjjz6eLh+092yXCZgbOHnvsQzBuc8UhrhMj6ChCMeA
        iwiRGIJsPVqDRimoL0cSgCaNumJBhVzV/A==
X-Google-Smtp-Source: ABdhPJyDaczguS96yeYRAd6X1o/f4eh5LCyfUzJKm7wkhLUZ+DZr970kItKctnqKe/QYC6KgtfikrQ==
X-Received: by 2002:a37:a58d:: with SMTP id o135mr15821909qke.480.1604358984107;
        Mon, 02 Nov 2020 15:16:24 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:e5d5:3d1c:2a85:1515])
        by smtp.googlemail.com with ESMTPSA id p5sm9201948qtu.13.2020.11.02.15.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:16:23 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Anders Larsen <al@alarsen.net>, linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH v3] qnx4: qnx4_block_map error handling
Date:   Mon,  2 Nov 2020 18:14:21 -0500
Message-Id: <20201102231420.1833852-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
References: <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qnx4_block_map() may return -EIO on funny qnx4 fs image, in this case do
not interpret -EIO as a correct block number

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: also check other callers according to Anders Larsen's<al@alarsen.net> comment
v3: change error code from EIO to ~0ull to avoid potential compiler
warning on signed/unsigned comparison
 fs/qnx4/dir.c   | 2 ++
 fs/qnx4/inode.c | 6 ++++--
 fs/qnx4/namei.c | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index a6ee23aadd28..0ff7b9f6a887 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -31,6 +31,8 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 
 	while (ctx->pos < inode->i_size) {
 		blknum = qnx4_block_map(inode, ctx->pos >> QNX4_BLOCK_SIZE_BITS);
+		if (blknum == ~0ull)
+			return -EIO;
 		bh = sb_bread(inode->i_sb, blknum);
 		if (bh == NULL) {
 			printk(KERN_ERR "qnx4_readdir: bread failed (%ld)\n", blknum);
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e8da1cde87b9..b4fff2db6c7e 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -59,6 +59,8 @@ static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_h
 	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%ld] iblock=[%ld]\n",inode->i_ino,iblock));
 
 	phys = qnx4_block_map( inode, iblock );
+	if (phys == ~0ull)
+		return -EIO;
 	if ( phys ) {
 		// logical block is before EOF
 		map_bh(bh, inode->i_sb, phys);
@@ -98,12 +100,12 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
 				bh = sb_bread(inode->i_sb, i_xblk - 1);
 				if ( !bh ) {
 					QNX4DEBUG((KERN_ERR "qnx4: I/O error reading xtnt block [%ld])\n", i_xblk - 1));
-					return -EIO;
+					return ~0ull;
 				}
 				xblk = (struct qnx4_xblk*)bh->b_data;
 				if ( memcmp( xblk->xblk_signature, "IamXblk", 7 ) ) {
 					QNX4DEBUG((KERN_ERR "qnx4: block at %ld is not a valid xtnt\n", qnx4_inode->i_xblk));
-					return -EIO;
+					return ~0ull;
 				}
 			}
 			block = try_extent(&xblk->xblk_xtnts[ix], &offset);
diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..c665ba730c11 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -66,6 +66,8 @@ static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
 	while (blkofs * QNX4_BLOCK_SIZE + offset < dir->i_size) {
 		if (!bh) {
 			block = qnx4_block_map(dir, blkofs);
+			if (block == ~0ull)
+				goto out;
 			if (block)
 				bh = sb_bread(dir->i_sb, block);
 			if (!bh) {
@@ -88,6 +90,7 @@ static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
 		blkofs++;
 	}
 	brelse(bh);
+out:
 	*res_dir = NULL;
 	return NULL;
 }
-- 
2.25.1

