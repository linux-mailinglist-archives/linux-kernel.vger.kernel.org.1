Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55621CB842
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 21:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEHT1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 15:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgEHT1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:27:13 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E095D20CC7;
        Fri,  8 May 2020 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588966033;
        bh=VhqAKcrwPY0cVjT8gdoCJ7J8gaWXKFNI6YLceVclDoY=;
        h=From:To:Cc:Subject:Date:From;
        b=fDj+DMEi/SmQgVWwDwS7YLee4L0T/31dur7XaM2FBscsNSoBZLyJ88HhASvA1cepz
         Bz8CQcGx+XeWTP6pjoPqcHhpIIzs5e/m5G5yZhombwWCdSy7pzfH4uJFDvzHDvaDDp
         nNFUwe47loM8tgvp8WqkChYCEg+e/zf5mXIQCJ4Y=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: remove blk_plugging in block_operations
Date:   Fri,  8 May 2020 12:27:11 -0700
Message-Id: <20200508192711.146175-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_plugging doesn't seem to give any benefit.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 97b6378554b40..cc9dd3bbf2188 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1169,8 +1169,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	struct blk_plug plug;
 	int err = 0, cnt = 0;
 
-	blk_start_plug(&plug);
-
 retry_flush_quotas:
 	f2fs_lock_all(sbi);
 	if (__need_flush_quota(sbi)) {
@@ -1198,7 +1196,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		f2fs_unlock_all(sbi);
 		err = f2fs_sync_dirty_inodes(sbi, DIR_INODE);
 		if (err)
-			goto out;
+			return err;
 		cond_resched();
 		goto retry_flush_quotas;
 	}
@@ -1214,7 +1212,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		f2fs_unlock_all(sbi);
 		err = f2fs_sync_inode_meta(sbi);
 		if (err)
-			goto out;
+			return err;
 		cond_resched();
 		goto retry_flush_quotas;
 	}
@@ -1229,7 +1227,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
 		atomic_dec(&sbi->wb_sync_req[NODE]);
 		if (err)
-			goto out;
+			return err;
 		cond_resched();
 		goto retry_flush_quotas;
 	}
@@ -1240,8 +1238,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	 */
 	__prepare_cp_block(sbi);
 	up_write(&sbi->node_change);
-out:
-	blk_finish_plug(&plug);
 	return err;
 }
 
-- 
2.26.2.645.ge9eca65c58-goog

