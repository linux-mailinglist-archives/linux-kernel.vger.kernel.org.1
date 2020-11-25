Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3DD2C3701
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 04:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgKYC6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:58:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7677 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgKYC6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:58:31 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cglv34JSVz15RqZ;
        Wed, 25 Nov 2020 10:58:07 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 10:58:19 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Lei Li <noctis.akm@gmail.com>
Subject: [PATCH] f2fs: fix to avoid REQ_TIME and CP_TIME collision
Date:   Wed, 25 Nov 2020 10:57:36 +0800
Message-ID: <20201125025736.58540-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lei Li reported a issue: if foreground operations are frequent, background
checkpoint may be always skipped due to below check, result in losing more
data after sudden power-cut.

f2fs_balance_fs_bg()
...
	if (!is_idle(sbi, REQ_TIME) &&
		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
		return;

E.g:
cp_interval = 5 second
idle_interval = 2 second
foreground operation interval = 1 second (append 1 byte per second into file)

In such case, no matter when it calls f2fs_balance_fs_bg(), is_idle(, REQ_TIME)
returns false, result in skipping background checkpoint.

This patch changes as below to make trigger condition being more reasonable:
- trigger sync_fs() if dirty_{nats,nodes} and prefree segs exceeds threshold;
- skip triggering sync_fs() if there is any background inflight IO or there is
foreground operation recently and meanwhile cp_rwsem is being held by someone;

Reported-by: Lei Li <noctis.akm@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 19 +++++++++++++------
 fs/f2fs/segment.c | 47 +++++++++++++++++++++++++++--------------------
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4f2766f3d2c1..b5054ffe3e1c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2416,24 +2416,31 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
 	return entry;
 }
 
-static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
+static inline bool is_inflight_io(struct f2fs_sb_info *sbi, int type)
 {
-	if (sbi->gc_mode == GC_URGENT_HIGH)
-		return true;
-
 	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
 		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
 		get_pages(sbi, F2FS_WB_CP_DATA) ||
 		get_pages(sbi, F2FS_DIO_READ) ||
 		get_pages(sbi, F2FS_DIO_WRITE))
-		return false;
+		return true;
 
 	if (type != DISCARD_TIME && SM_I(sbi) && SM_I(sbi)->dcc_info &&
 			atomic_read(&SM_I(sbi)->dcc_info->queued_discard))
-		return false;
+		return true;
 
 	if (SM_I(sbi) && SM_I(sbi)->fcc_info &&
 			atomic_read(&SM_I(sbi)->fcc_info->queued_flush))
+		return true;
+	return false;
+}
+
+static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
+{
+	if (sbi->gc_mode == GC_URGENT_HIGH)
+		return true;
+
+	if (is_inflight_io(sbi, type))
 		return false;
 
 	if (sbi->gc_mode == GC_URGENT_LOW &&
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 39d6dce09fb7..bd066cff0bf9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -529,31 +529,38 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
-	if (!is_idle(sbi, REQ_TIME) &&
-		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
+	if (excess_dirty_nats(sbi) || excess_dirty_nodes(sbi) ||
+		excess_prefree_segs(sbi))
+		goto do_sync;
+
+	/* there is background inflight IO or foreground operation recently */
+	if (is_inflight_io(sbi, REQ_TIME) ||
+		(!f2fs_time_over(sbi, REQ_TIME) && rwsem_is_locked(&sbi->cp_rwsem)))
 		return;
 
+	/* exceed periodical checkpoint timeout threshold */
+	if (f2fs_time_over(sbi, CP_TIME))
+		goto do_sync;
+
 	/* checkpoint is the only way to shrink partial cached entries */
-	if (!f2fs_available_free_memory(sbi, NAT_ENTRIES) ||
-			!f2fs_available_free_memory(sbi, INO_ENTRIES) ||
-			excess_prefree_segs(sbi) ||
-			excess_dirty_nats(sbi) ||
-			excess_dirty_nodes(sbi) ||
-			f2fs_time_over(sbi, CP_TIME)) {
-		if (test_opt(sbi, DATA_FLUSH) && from_bg) {
-			struct blk_plug plug;
-
-			mutex_lock(&sbi->flush_lock);
-
-			blk_start_plug(&plug);
-			f2fs_sync_dirty_inodes(sbi, FILE_INODE);
-			blk_finish_plug(&plug);
+	if (f2fs_available_free_memory(sbi, NAT_ENTRIES) ||
+		f2fs_available_free_memory(sbi, INO_ENTRIES))
+		return;
 
-			mutex_unlock(&sbi->flush_lock);
-		}
-		f2fs_sync_fs(sbi->sb, true);
-		stat_inc_bg_cp_count(sbi->stat_info);
+do_sync:
+	if (test_opt(sbi, DATA_FLUSH) && from_bg) {
+		struct blk_plug plug;
+
+		mutex_lock(&sbi->flush_lock);
+
+		blk_start_plug(&plug);
+		f2fs_sync_dirty_inodes(sbi, FILE_INODE);
+		blk_finish_plug(&plug);
+
+		mutex_unlock(&sbi->flush_lock);
 	}
+	f2fs_sync_fs(sbi->sb, true);
+	stat_inc_bg_cp_count(sbi->stat_info);
 }
 
 static int __submit_flush_wait(struct f2fs_sb_info *sbi,
-- 
2.26.2

