Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080602A3503
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgKBUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgKBUSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:18:05 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2558AC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 12:18:05 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j62so10150134qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 12:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxL+CoiTkqaGHZCArw1QAkP8ZWyh7VFOGPGDijfn9bM=;
        b=RSusDGeSp99V1dsxfRHAbTLOG8VzDnujb7yGZri4RDwiP8S6FMTCTADAOpa5TksRot
         1buYt9iKqT+aaNUe5Dz+Wq88tHSunlkto+S0qj+41ib97rImNGGMBvAobfonWxpiMNeG
         xsDC/KIbLKIdTSCrJNkW/2bNb66z/zjN8L8H0+L/OCQhSbul/OwY5SaTAyn69h9zzkpP
         fGvQOGODcezhOhm9bvYJ+OZOL1BqKpWg8lwZ+aP3MiaPIbiMRMPzWbmCmSWBBp6J2FR0
         RdARTMlSpdU7tfOzjQurMeqa2vKUXAW75i/YwI+6kdSS5hnm+V8Jh8Us9NdvkVIiek+9
         XgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxL+CoiTkqaGHZCArw1QAkP8ZWyh7VFOGPGDijfn9bM=;
        b=el09afaOpD635REk2jJ48lqeP9qmY6iwRRs9jCeKGaXkexth3xhk00Kl1+S2pPId/P
         1RpyG13AA2uDtCWdzaZsI/lQL5pugE5hrMk2XW+nX+jDAiYalqOT32W2gnFN2e4ImAK6
         TtyCY5UzDoUHMcBRJorjfQa4I4vt567JSKOqdxpJqsGn30zlG0Fm/AsAt0fhDKZ4nYKK
         /Qo6gluO74TazvF9qDrrLexhFJs5OEKmWphYLRN27qKqLHEJjYPFPNtD/8zaxXtkPx27
         59gI0Zni/TO5AD5I7siawLGg2VhaWKQo7lbtLrMDzGgYL4qt0SELz3fhbEQsVqIt0twU
         m6Gg==
X-Gm-Message-State: AOAM532FazIqazCkGE8Q8GUbjZUAUh4AoVxR/ta5UcejxfcLTccTEAXX
        yWUas44Z5jvePuMM8CnBTzo=
X-Google-Smtp-Source: ABdhPJwf53JBSuKKpcmSJARcW2JNdnA1PizCp6zCe1FizMzsm6F2nH+GMQ8CLL6ajdGMWGklN6rWUg==
X-Received: by 2002:ac8:5854:: with SMTP id h20mr15908089qth.176.1604348284376;
        Mon, 02 Nov 2020 12:18:04 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:e5d5:3d1c:2a85:1515])
        by smtp.googlemail.com with ESMTPSA id o187sm8773107qkb.120.2020.11.02.12.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:18:03 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Anders Larsen <al@alarsen.net>, linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH v2] qnx4: do not interpret -EIO as a correct address
Date:   Mon,  2 Nov 2020 15:15:36 -0500
Message-Id: <20201102201536.1267680-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1966437.kWHqOGhHGQ@alarsen.net>
References: <1966437.kWHqOGhHGQ@alarsen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qnx4_block_map() may return -EIO on funny qnx4 fs image, in this case do
not interpret -EIO as a correct address

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: also check other callers according to Anders Larsen's<al@alarsen.net> comment
 fs/qnx4/dir.c   | 2 ++
 fs/qnx4/inode.c | 2 ++
 fs/qnx4/namei.c | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index a6ee23aadd28..11aaf59f0411 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -31,6 +31,8 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 
 	while (ctx->pos < inode->i_size) {
 		blknum = qnx4_block_map(inode, ctx->pos >> QNX4_BLOCK_SIZE_BITS);
+		if (blknum == -EIO)
+			return -EIO;
 		bh = sb_bread(inode->i_sb, blknum);
 		if (bh == NULL) {
 			printk(KERN_ERR "qnx4_readdir: bread failed (%ld)\n", blknum);
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e8da1cde87b9..d3a40c5b1a9a 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -59,6 +59,8 @@ static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_h
 	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%ld] iblock=[%ld]\n",inode->i_ino,iblock));
 
 	phys = qnx4_block_map( inode, iblock );
+	if (phys == -EIO)
+		return -EIO;
 	if ( phys ) {
 		// logical block is before EOF
 		map_bh(bh, inode->i_sb, phys);
diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..164e0c07e3ff 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -66,6 +66,8 @@ static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
 	while (blkofs * QNX4_BLOCK_SIZE + offset < dir->i_size) {
 		if (!bh) {
 			block = qnx4_block_map(dir, blkofs);
+			if (block == -EIO)
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

