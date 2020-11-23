Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030A92BFFA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 06:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgKWF25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 00:28:57 -0500
Received: from z5.mailgun.us ([104.130.96.5]:17267 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKWF25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 00:28:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606109337; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=IDh9u37lBrJNl2jBeZqDrURG7xBb2r4TgSKLEjPenr8=; b=sTMaLU545fXHpvkVXuCC9JnaZKWqaqS6FZY3hwbhBlVaNpFgYDJs12Tyex9SeCNwB7ZNqxWJ
 a7FkYUm36Iub1egwhqYi81SOB0daBCKW07ningYdUCFMqR5e0LVBkdg2nzfpvWlO70xioqAk
 ZZRSdCY9+Wkmgg/RBFnB8+lr7pc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fbb4897c6fdb18c63e179ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 05:28:55
 GMT
Sender: stummala=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5184CC43461; Mon, 23 Nov 2020 05:28:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 793E7C433ED;
        Mon, 23 Nov 2020 05:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 793E7C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: change to use rwsem for cp_mutex
Date:   Mon, 23 Nov 2020 10:58:32 +0530
Message-Id: <1606109312-1944-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rwsem to ensure serialization of the callers and to avoid
starvation of high priority tasks, when the system is under
heavy IO workload.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/checkpoint.c | 8 ++++----
 fs/f2fs/f2fs.h       | 2 +-
 fs/f2fs/gc.c         | 4 ++--
 fs/f2fs/recovery.c   | 4 ++--
 fs/f2fs/super.c      | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 023462e..7fb8c80 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -348,13 +348,13 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 		goto skip_write;
 
 	/* if locked failed, cp will flush dirty pages instead */
-	if (!mutex_trylock(&sbi->cp_mutex))
+	if (!down_write_trylock(&sbi->cp_global_sem))
 		goto skip_write;
 
 	trace_f2fs_writepages(mapping->host, wbc, META);
 	diff = nr_pages_to_write(sbi, META, wbc);
 	written = f2fs_sync_meta_pages(sbi, META, wbc->nr_to_write, FS_META_IO);
-	mutex_unlock(&sbi->cp_mutex);
+	up_write(&sbi->cp_global_sem);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - written - diff);
 	return 0;
 
@@ -1572,7 +1572,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		f2fs_warn(sbi, "Start checkpoint disabled!");
 	}
 	if (cpc->reason != CP_RESIZE)
-		mutex_lock(&sbi->cp_mutex);
+		down_write(&sbi->cp_global_sem);
 
 	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
 		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
@@ -1647,7 +1647,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
 out:
 	if (cpc->reason != CP_RESIZE)
-		mutex_unlock(&sbi->cp_mutex);
+		up_write(&sbi->cp_global_sem);
 	return err;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e082677..842c2ca 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1369,7 +1369,7 @@ struct f2fs_sb_info {
 	int cur_cp_pack;			/* remain current cp pack */
 	spinlock_t cp_lock;			/* for flag in ckpt */
 	struct inode *meta_inode;		/* cache meta blocks */
-	struct mutex cp_mutex;			/* checkpoint procedure lock */
+	struct rw_semaphore cp_global_sem;	/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
 	struct rw_semaphore node_write;		/* locking node writes */
 	struct rw_semaphore node_change;	/* locking node change */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 05641a1..3ef84e6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1986,7 +1986,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 
 	freeze_super(sbi->sb);
 	down_write(&sbi->gc_lock);
-	mutex_lock(&sbi->cp_mutex);
+	down_write(&sbi->cp_global_sem);
 
 	spin_lock(&sbi->stat_lock);
 	if (shrunk_blocks + valid_user_blocks(sbi) +
@@ -2031,7 +2031,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		spin_unlock(&sbi->stat_lock);
 	}
 out_err:
-	mutex_unlock(&sbi->cp_mutex);
+	up_write(&sbi->cp_global_sem);
 	up_write(&sbi->gc_lock);
 	thaw_super(sbi->sb);
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 0947d36..da75d5d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -799,7 +799,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	INIT_LIST_HEAD(&dir_list);
 
 	/* prevent checkpoint */
-	mutex_lock(&sbi->cp_mutex);
+	down_write(&sbi->cp_global_sem);
 
 	/* step #1: find fsynced inode numbers */
 	err = find_fsync_dnodes(sbi, &inode_list, check_only);
@@ -850,7 +850,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err)
 		clear_sbi_flag(sbi, SBI_POR_DOING);
 
-	mutex_unlock(&sbi->cp_mutex);
+	up_write(&sbi->cp_global_sem);
 
 	/* let's drop all the directory inodes for clean checkpoint */
 	destroy_fsync_dnodes(&dir_list, err);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87f7a6e..e33b0da 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3552,7 +3552,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->valid_super_block = valid_super_block;
 	init_rwsem(&sbi->gc_lock);
 	mutex_init(&sbi->writepages);
-	mutex_init(&sbi->cp_mutex);
+	init_rwsem(&sbi->cp_global_sem);
 	init_rwsem(&sbi->node_write);
 	init_rwsem(&sbi->node_change);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

