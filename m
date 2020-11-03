Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA612A4D41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgKCRkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgKCRkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:40:35 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB6CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:40:34 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id w5so8151246qvn.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVcmv6D+u3AH4N0KzNvvXN8VdK2XK1ualXQAARNXnFQ=;
        b=N4bN6HCoroW8kYnJzOeJ6qx2K5SaqNeE7KLk8N5i6eWbyzeCbqyTpnnfyX1u2Iy/YL
         xqfj52oa7rvGYLUtIzKbbR72TaqLx8aec+g2AgNqKgeNMmialGL9Dq8EqZHtNZ//gLrG
         ezbnPk3OwLGSW/ec8MIZ1NaPwmn+ta6ubBKpOHIBhPtC04H+abSbkXEcJANJEke3O2xF
         EaU6aFU5fygk64Ked5tSVNkkAyBafsD49bLvsIhLSAS44PX5sIw+dANrkNd66PyqD4fq
         MCa7zuBNxhbZ8h5yaoG2WiYeyoSMLAEuLMwQ/A7YEZATZ+Gbkle7k+1pZvHHAf4qDC4E
         pFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVcmv6D+u3AH4N0KzNvvXN8VdK2XK1ualXQAARNXnFQ=;
        b=oXUmZ3PvtL+kOB4QFymCnttgrZPY+gdFIT3rkxDFcr1VLwBVbHwwtwgdGeM75D9LnT
         wdGj4RJ2z/y3EbDszd3VxyBGLd8EdWnO/ew9l8kKNWUjkyqWbTqhms6EgloHCVi2Zn8p
         Y8DKiRlXIbLv2Or6QuZSrSwbkA4dyukRjv/Das5q3Y76VDifiFloOY6vTHiqyprvBmeB
         xenjAyf9APTowbadvqpuBQWjYYGk5Fxdez0vjEEK0fOeIc0xlEPfWALP0aNdR2jBHWFr
         +bU95L/60c9iRd9A/ISRAW/SrRtF3qTWm09v6V1fLyE2Qa7zpzjGUqIGZSAse/EcjGC6
         NPXA==
X-Gm-Message-State: AOAM532Lg4dIzYG4guOuH9S1/m6jdTGYLOEhz5Ti+7IOwtDw5GuAx7vX
        Mvy6ITMqwFjtiF6v/jZdfeB7CMyBBZrPMA==
X-Google-Smtp-Source: ABdhPJyALyHy5btnS5jPgFVjD1Au69+RFv2AIbUs4jbL565YJ71nPYRN+kjpQ9GFBL+TNVFW7WymUw==
X-Received: by 2002:a05:6214:144b:: with SMTP id b11mr25173810qvy.3.1604425233554;
        Tue, 03 Nov 2020 09:40:33 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:e5d5:3d1c:2a85:1515])
        by smtp.googlemail.com with ESMTPSA id z69sm11134278qkb.7.2020.11.03.09.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 09:40:33 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     David.Laight@aculab.com, Anders Larsen <al@alarsen.net>,
        linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH v4] qnx4: qnx4_block_map error handling
Date:   Tue,  3 Nov 2020 12:35:57 -0500
Message-Id: <20201103173556.1940414-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7d978bf40c5845e8b89a740250ba958a@AcuMS.aculab.com>
References: <7d978bf40c5845e8b89a740250ba958a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qnx4_block_map() may return -EIO on funny qnx4 fs image, in this case do
not interpret error as a valid block number.

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: also check other callers according to Anders Larsen's<al@alarsen.net> comment
v3: change error code from EIO to ~0ull to avoid potential compiler
warning on signed/unsigned comparison
v4: revert error code back to -EIO and dedicate return value for error code. Also
print a message to let user know there is an error.
 fs/qnx4/dir.c   |  5 ++++-
 fs/qnx4/inode.c | 14 +++++++++-----
 fs/qnx4/namei.c |  6 +++++-
 fs/qnx4/qnx4.h  |  2 +-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index a6ee23aadd28..49ccd7ddd83b 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -25,12 +25,15 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 	unsigned long blknum;
 	int ix, ino;
 	int size;
+	int result;
 
 	QNX4DEBUG((KERN_INFO "qnx4_readdir:i_size = %ld\n", (long) inode->i_size));
 	QNX4DEBUG((KERN_INFO "pos                 = %ld\n", (long) ctx->pos));
 
 	while (ctx->pos < inode->i_size) {
-		blknum = qnx4_block_map(inode, ctx->pos >> QNX4_BLOCK_SIZE_BITS);
+		result = qnx4_block_map(inode, ctx->pos >> QNX4_BLOCK_SIZE_BITS, &blknum);
+		if (result)
+			return result;
 		bh = sb_bread(inode->i_sb, blknum);
 		if (bh == NULL) {
 			printk(KERN_ERR "qnx4_readdir: bread failed (%ld)\n", blknum);
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e8da1cde87b9..3333a4ef65fe 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -54,11 +54,14 @@ static int qnx4_remount(struct super_block *sb, int *flags, char *data)
 
 static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_head *bh, int create )
 {
+	int result;
 	unsigned long phys;
 
 	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%ld] iblock=[%ld]\n",inode->i_ino,iblock));
 
-	phys = qnx4_block_map( inode, iblock );
+	result = qnx4_block_map(inode, iblock, &phys);
+	if (result)
+		return result;
 	if ( phys ) {
 		// logical block is before EOF
 		map_bh(bh, inode->i_sb, phys);
@@ -75,7 +78,7 @@ static inline u32 try_extent(qnx4_xtnt_t *extent, u32 *offset)
 	return 0;
 }
 
-unsigned long qnx4_block_map( struct inode *inode, long iblock )
+int qnx4_block_map(struct inode *inode, long iblock , unsigned long *phys)
 {
 	int ix;
 	long i_xblk;
@@ -97,12 +100,12 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
 				// read next xtnt block.
 				bh = sb_bread(inode->i_sb, i_xblk - 1);
 				if ( !bh ) {
-					QNX4DEBUG((KERN_ERR "qnx4: I/O error reading xtnt block [%ld])\n", i_xblk - 1));
+					printk(KERN_ERR "qnx4: I/O error reading xtnt block [%ld])\n", i_xblk - 1);
 					return -EIO;
 				}
 				xblk = (struct qnx4_xblk*)bh->b_data;
 				if ( memcmp( xblk->xblk_signature, "IamXblk", 7 ) ) {
-					QNX4DEBUG((KERN_ERR "qnx4: block at %ld is not a valid xtnt\n", qnx4_inode->i_xblk));
+					printk(KERN_ERR "qnx4: block at %d is not a valid xtnt\n", qnx4_inode->di_xblk);
 					return -EIO;
 				}
 			}
@@ -123,7 +126,8 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
 	}
 
 	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %ld = %ld\n",iblock,inode->i_ino,block));
-	return block;
+	*phys = block;
+	return 0;
 }
 
 static int qnx4_statfs(struct dentry *dentry, struct kstatfs *buf)
diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..3d64b34dbe6e 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -59,13 +59,16 @@ static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
 {
 	unsigned long block, offset, blkofs;
 	struct buffer_head *bh;
+	int result;
 
 	*res_dir = NULL;
 	bh = NULL;
 	block = offset = blkofs = 0;
 	while (blkofs * QNX4_BLOCK_SIZE + offset < dir->i_size) {
 		if (!bh) {
-			block = qnx4_block_map(dir, blkofs);
+			result = qnx4_block_map(dir, blkofs, &block);
+			if (result)
+				goto out;
 			if (block)
 				bh = sb_bread(dir->i_sb, block);
 			if (!bh) {
@@ -88,6 +91,7 @@ static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
 		blkofs++;
 	}
 	brelse(bh);
+out:
 	*res_dir = NULL;
 	return NULL;
 }
diff --git a/fs/qnx4/qnx4.h b/fs/qnx4/qnx4.h
index 6283705466a4..efa76aa551fc 100644
--- a/fs/qnx4/qnx4.h
+++ b/fs/qnx4/qnx4.h
@@ -24,7 +24,7 @@ struct qnx4_inode_info {
 extern struct inode *qnx4_iget(struct super_block *, unsigned long);
 extern struct dentry *qnx4_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags);
 extern unsigned long qnx4_count_free_blocks(struct super_block *sb);
-extern unsigned long qnx4_block_map(struct inode *inode, long iblock);
+extern int qnx4_block_map(struct inode *inode, long iblock, unsigned long* phys);
 
 extern const struct inode_operations qnx4_dir_inode_operations;
 extern const struct file_operations qnx4_dir_operations;
-- 
2.25.1

