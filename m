Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA92C4D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 03:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbgKZCYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 21:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733228AbgKZCYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 21:24:19 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2850C2075A;
        Thu, 26 Nov 2020 02:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606357459;
        bh=6XA/qLOngyDBniW52sdY2h+RkRTLQMuD9eGtpZ7QD58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbWylj94aEe5yLGR1ytq1uLUyNwVrbA9vB/J/Nt7E70LoOQH4/TMN6rl25PXXXzT3
         LdzIU/Ml62KHkIhD3lRC/bJodgO7q2745ImC/PZjC9fdhXvhuy6EHZet/ijaK3fnJy
         8c83CHjtZIXBZE9z6wZBHG2736slW+Strzin8thQ=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: fix wrong block count instead of bytes
Date:   Wed, 25 Nov 2020 18:24:15 -0800
Message-Id: <20201126022416.3068426-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201126022416.3068426-1-jaegeuk@kernel.org>
References: <20201126022416.3068426-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should convert cur_lblock, a block count, to bytes for len.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a84e5bc09337..e49c14ccfafe 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3893,7 +3893,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	sector_t highest_pblock = 0;
 	int nr_extents = 0;
 	unsigned long nr_pblocks;
-	unsigned long len;
+	u64 len;
 	int ret;
 
 	/*
@@ -3911,7 +3911,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 		cond_resched();
 
 		memset(&map_bh, 0, sizeof(struct buffer_head));
-		map_bh.b_size = len - cur_lblock;
+		map_bh.b_size = len - blks_to_bytes(inode, cur_lblock);
 
 		ret = get_data_block(inode, cur_lblock, &map_bh, 0,
 					F2FS_GET_BLOCK_FIEMAP, &next_pgofs);
-- 
2.29.2.454.gaff20da3a2-goog

