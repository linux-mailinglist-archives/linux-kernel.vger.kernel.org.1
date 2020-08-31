Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09502571C5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgHaCQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 22:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgHaCQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:16:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB9DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 19:09:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so2026765pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZA4Jxp1/LovkIERwC8cRY8LKXjFkLRRUzr+YgrmuJM=;
        b=R4cn6i0AMPdk0bD8kYRDnEkMkspxSvJEzFNyjc6q1ZprCAa8Q4k/n8KgM4niF+mlRh
         r/8SfOLdZb0Gt8K55TjxH9nMYXsbVe4bt8e9FmZEVW4IgTBqhquqqR7D0Ux8mNcX1W+L
         gX12loSHdxpLB3fasawc1h176DRu+RsW/juqMuX/8jxZJxLY3/wgxuOca7TdPyviNBe9
         TxulGl/BF3W9GbmHxgVAaRiPWGC2vHI8GX4344pWk8fTQ7HaihQXkjVJakI6YDyWl78Q
         DAzZAwP5M+F4dsPB0vHvQKKVLNaOkLL8NhsvGzMHXhpJ6AdipuKQ5qfXQRz9V2zJ2VNL
         mxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZA4Jxp1/LovkIERwC8cRY8LKXjFkLRRUzr+YgrmuJM=;
        b=kaZQwxtEqc3hIntNnc2fZDNEHRyO5L4rsDb1QJfremLbObN0tz5NIKox1IcGQu5KY5
         d019Fy/MsxoRz8ewB/okVdTr9PldwlW3ZEwS3daXDTaD5ABJ4UrsvzH4U2Vy3UYlNVzD
         Rxb96vCqRGpkVJ/WsCXH2WVTUs+VF2iikkWHC/tN1R/y+YDI69kxB7vs9EzZ2McaKp8H
         mAhyBwb1zkGn1KxIiI0iBm+7u8qGaZWKeqCsnqiawi12S9yeSMKsLsMc1SBTs8V7Qrew
         HfVgBCVOVxCt52RC5CMD9iVMEf+JlUN6UnZy9DqOjs5OJVM/YDR1Bh02/tRv5WT9uh3L
         BSiA==
X-Gm-Message-State: AOAM533UFNhcbF1eoSclJInxp2au5EV9v+Idgg3XtbPfYTMVlJ1OHj//
        ACGxpOLgv0jrzuUlufnuMZjsHr9WH+w=
X-Google-Smtp-Source: ABdhPJyph/vYXHaoDuzLw6oSx9KKY6yc0pI+qOzxSdYQiGFrnNK3kZitaLxd0YmuOPySIBuv8d5fIQ==
X-Received: by 2002:a63:110c:: with SMTP id g12mr6364680pgl.91.1598839795696;
        Sun, 30 Aug 2020 19:09:55 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id m24sm5524916pgn.44.2020.08.30.19.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 19:09:55 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: change compr_blocks of superblock info to 64bit
Date:   Mon, 31 Aug 2020 11:09:49 +0900
Message-Id: <20200831020949.3218854-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Current compr_blocks of superblock info is not 64bit value. We are
accumulating each i_compr_blocks count of inodes to this value and
those are 64bit values. So, need to change this to 64bit value.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/debug.c | 6 +++---
 fs/f2fs/f2fs.h  | 9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 4276c0f79beb..257e658b3a5e 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -131,7 +131,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->inline_inode = atomic_read(&sbi->inline_inode);
 	si->inline_dir = atomic_read(&sbi->inline_dir);
 	si->compr_inode = atomic_read(&sbi->compr_inode);
-	si->compr_blocks = atomic_read(&sbi->compr_blocks);
+	si->compr_blocks = atomic64_read(&sbi->compr_blocks);
 	si->append = sbi->im[APPEND_INO].ino_num;
 	si->update = sbi->im[UPDATE_INO].ino_num;
 	si->orphans = sbi->im[ORPHAN_INO].ino_num;
@@ -342,7 +342,7 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->inline_inode);
 		seq_printf(s, "  - Inline_dentry Inode: %u\n",
 			   si->inline_dir);
-		seq_printf(s, "  - Compressed Inode: %u, Blocks: %u\n",
+		seq_printf(s, "  - Compressed Inode: %u, Blocks: %llu\n",
 			   si->compr_inode, si->compr_blocks);
 		seq_printf(s, "  - Orphan/Append/Update Inode: %u, %u, %u\n",
 			   si->orphans, si->append, si->update);
@@ -542,7 +542,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->inline_inode, 0);
 	atomic_set(&sbi->inline_dir, 0);
 	atomic_set(&sbi->compr_inode, 0);
-	atomic_set(&sbi->compr_blocks, 0);
+	atomic64_set(&sbi->compr_blocks, 0);
 	atomic_set(&sbi->inplace_count, 0);
 	for (i = META_CP; i < META_MAX; i++)
 		atomic_set(&sbi->meta_count[i], 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 02811ce15059..f60414805e05 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1552,7 +1552,7 @@ struct f2fs_sb_info {
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	atomic_t compr_inode;			/* # of compressed inodes */
-	atomic_t compr_blocks;			/* # of compressed blocks */
+	atomic64_t compr_blocks;		/* # of compressed blocks */
 	atomic_t vw_cnt;			/* # of volatile writes */
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
 	atomic_t max_vw_cnt;			/* max # of volatile writes */
@@ -3533,7 +3533,8 @@ struct f2fs_stat_info {
 	int nr_discard_cmd;
 	unsigned int undiscard_blks;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
-	int compr_inode, compr_blocks;
+	int compr_inode;
+	unsigned long long compr_blocks;
 	int aw_cnt, max_aw_cnt, vw_cnt, max_vw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
 	unsigned int bimodal, avg_vblocks;
@@ -3618,9 +3619,9 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 			(atomic_dec(&F2FS_I_SB(inode)->compr_inode));	\
 	} while (0)
 #define stat_add_compr_blocks(inode, blocks)				\
-		(atomic_add(blocks, &F2FS_I_SB(inode)->compr_blocks))
+		(atomic64_add(blocks, &F2FS_I_SB(inode)->compr_blocks))
 #define stat_sub_compr_blocks(inode, blocks)				\
-		(atomic_sub(blocks, &F2FS_I_SB(inode)->compr_blocks))
+		(atomic64_sub(blocks, &F2FS_I_SB(inode)->compr_blocks))
 #define stat_inc_meta_count(sbi, blkaddr)				\
 	do {								\
 		if (blkaddr < SIT_I(sbi)->sit_base_addr)		\
-- 
2.28.0.402.g5ffc5be6b7-goog

