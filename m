Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339692F0C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 06:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbhAKFQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 00:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbhAKFQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 00:16:34 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D008C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:15:54 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s15so8876958plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DyRqOwQ0dcS8usSOyzJO32W3NIEwDXzrQrOJSBGDM8k=;
        b=AgDKg1s20J45iQH5qwhv3TmhdxxPLvAzDfabMHjRl5+sa6wU4XoXRUO4TagzEWLZMu
         ZOAB/3PeIcidapklaCcYa2lDR/heMN0++wQXLC9dWK9E2a/0tFAk+LTvzMoA0VP/aGxl
         iqQoNn3D1XNl9V+gx0wql5SpdzoCTRfssWm4rqbF6qBltXU3M6gImGlitnaF9I+wM8gW
         THdh7xTmVJabh7Npo5UC5tTvg2L/0coCFceAObmOxcSoKJ343emW4lfNiWoFPUIGCiI2
         vCDACX+F8M8BhuwXQitmkTbS3fK/skN/sBCJ79A2NgIocR3DTBfgORXULyIqKhjGxpxZ
         0p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DyRqOwQ0dcS8usSOyzJO32W3NIEwDXzrQrOJSBGDM8k=;
        b=jKrTXWLhSnoCxVEa44T+0Bllrdnx4FVSgj7qkNRa0RUBBQOZEMgVqVTjvpjM/f6O0d
         39beW6+Qjw76wsfvmoKIAAocZwvonQuU95M3WtrfUC2ZOrO1ktiM+0NgsVi7xO9LkpV0
         i27e04FUCBJr24xLte9Iy9bFjhJDr5FawiyMQisY7Qbfccsa1V9hCJZLx5K7h5WaiXGe
         ZCTyjxfKu8QQQEt/cnSMUUo7kk6bjFXG7gjwGqs8Tn5NWs63vouMxXPitW50Ud9UySCH
         Og+s9HcpXWsnaCNae5RCWrG6bAJ+TsvIeMNGuyQq2xHnaDzUK45ZIQUgl+odwPvwHlc0
         iH3A==
X-Gm-Message-State: AOAM533OMXiSfcRBT4gh2VtaVjnnXe6xzw2SW++MNV9Np3YyD5DTFdQ5
        y+4jC2s8cY0eMiPBZR8hJz9/FLxv5f8=
X-Google-Smtp-Source: ABdhPJyj1nFIXBeuoYXtUXLntnU4m4J8DrUUFvr5hEQQ/QpA01k8GChbNockKwUDbNVDVNIx6phk2w==
X-Received: by 2002:a17:90a:68c3:: with SMTP id q3mr15855450pjj.135.1610342152264;
        Sun, 10 Jan 2021 21:15:52 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id i25sm17729224pgb.33.2021.01.10.21.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 21:15:51 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH 1/2] f2fs: introduce checkpoint=merge mount option
Date:   Mon, 11 Jan 2021 14:15:42 +0900
Message-Id: <20210111051543.243387-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We've added a new mount option "checkpoint=merge", which creates a
kernel daemon and makes it to merge concurrent checkpoint requests as
much as possible to eliminate redundant checkpoint issues. Plus, we
can eliminate the sluggish issue caused by slow checkpoint operation
when the checkpoint is done in a process context in a cgroup having
low i/o budget and cpu shares, and The below verification result
explains this.
The basic idea has come from https://opensource.samsung.com.

[Verification]
Android Pixel Device(ARM64, 7GB RAM, 256GB UFS)
Create two I/O cgroups (fg w/ weight 100, bg w/ wight 20)

In "fg" cgroup,
- thread A => trigger 1000 checkpoint operations
  "for i in `seq 1 1000`; do touch test_dir1/file; fsync test_dir1;
   done"
- thread B => gererating async. I/O
  "fio --rw=write --numjobs=1 --bs=128k --runtime=3600 --time_based=1
       --filename=test_img --name=test"

In "bg" cgroup,
- thread C => trigger repeated checkpoint operations
  "echo $$ > /dev/blkio/bg/tasks; while true; do touch test_dir2/file;
   fsync test_dir2; done"

We've measured thread A's execution time.

[ w/o patch ]
Elapsed Time: Avg. 68 seconds
[ w/  patch ]
Elapsed Time: Avg. 48 seconds

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 Documentation/filesystems/f2fs.rst |   6 +
 fs/f2fs/checkpoint.c               | 176 +++++++++++++++++++++++++++++
 fs/f2fs/debug.c                    |   6 +
 fs/f2fs/f2fs.h                     |  24 ++++
 fs/f2fs/super.c                    |  53 ++++++++-
 5 files changed, 261 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index dae15c96e659..bccc021bf31a 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -247,6 +247,12 @@ checkpoint=%s[:%u[%]]	 Set to "disable" to turn off checkpointing. Set to "enabl
 			 hide up to all remaining free space. The actual space that
 			 would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
 			 This space is reclaimed once checkpoint=enable.
+			 Here is another option "merge", which creates a kernel daemon
+			 and makes it to merge concurrent checkpoint requests as much
+			 as possible to eliminate redundant checkpoint issues. Plus,
+			 we can eliminate the sluggish issue caused by slow checkpoint
+			 operation when the checkpoint is done in a process context in
+			 a cgroup having low i/o budget and cpu shares.
 compress_algorithm=%s	 Control compress algorithm, currently f2fs supports "lzo",
 			 "lz4", "zstd" and "lzo-rle" algorithm.
 compress_log_size=%u	 Support configuring compress cluster size, the size will
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 897edb7c951a..11288f435dbe 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -13,6 +13,7 @@
 #include <linux/f2fs_fs.h>
 #include <linux/pagevec.h>
 #include <linux/swap.h>
+#include <linux/kthread.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -20,6 +21,8 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
+#define DEFAULT_CHECKPOINT_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
+
 static struct kmem_cache *ino_entry_slab;
 struct kmem_cache *f2fs_inode_entry_slab;
 
@@ -1707,3 +1710,176 @@ void f2fs_destroy_checkpoint_caches(void)
 	kmem_cache_destroy(ino_entry_slab);
 	kmem_cache_destroy(f2fs_inode_entry_slab);
 }
+
+static int __write_checkpoint_sync(struct f2fs_sb_info *sbi)
+{
+	struct cp_control cpc = { .reason = CP_SYNC, };
+	int err;
+
+	down_write(&sbi->gc_lock);
+	err = f2fs_write_checkpoint(sbi, &cpc);
+	up_write(&sbi->gc_lock);
+
+	return err;
+}
+
+static void __checkpoint_and_complete_reqs(struct f2fs_sb_info *sbi)
+{
+	struct ckpt_req_control *cprc = sbi->cprc_info;
+	struct ckpt_req *req, *next;
+	struct llist_node *dispatch_list;
+	int ret;
+
+	dispatch_list = llist_del_all(&cprc->issue_list);
+	if (!dispatch_list)
+		return;
+	dispatch_list = llist_reverse_order(dispatch_list);
+
+	ret = __write_checkpoint_sync(sbi);
+	atomic_inc(&cprc->issued_ckpt);
+
+	llist_for_each_entry_safe(req, next, dispatch_list, llnode) {
+		atomic_dec(&cprc->queued_ckpt);
+		atomic_inc(&cprc->total_ckpt);
+		req->complete_time = jiffies;
+		req->ret = ret;
+		complete(&req->wait);
+	}
+}
+
+static int issue_checkpoint_thread(void *data)
+{
+	struct f2fs_sb_info *sbi = data;
+	struct ckpt_req_control *cprc = sbi->cprc_info;
+	wait_queue_head_t *q = &cprc->ckpt_wait_queue;
+repeat:
+	if (kthread_should_stop())
+		return 0;
+
+	sb_start_intwrite(sbi->sb);
+
+	if (!llist_empty(&cprc->issue_list))
+		__checkpoint_and_complete_reqs(sbi);
+
+	sb_end_intwrite(sbi->sb);
+
+	wait_event_interruptible(*q,
+		kthread_should_stop() || !llist_empty(&cprc->issue_list));
+	goto repeat;
+}
+
+static void flush_remained_ckpt_reqs(struct f2fs_sb_info *sbi,
+		struct ckpt_req *wait_req)
+{
+	struct ckpt_req_control *cprc = sbi->cprc_info;
+
+	if (!llist_empty(&cprc->issue_list)) {
+		__checkpoint_and_complete_reqs(sbi);
+	} else {
+		/* already dispatched by issue_checkpoint_thread */
+		if (wait_req)
+			wait_for_completion(&wait_req->wait);
+	}
+}
+
+static void init_ckpt_req(struct ckpt_req *req)
+{
+	memset(req, 0, sizeof(struct ckpt_req));
+
+	req->owner = current;
+	init_completion(&req->wait);
+}
+
+int f2fs_issue_checkpoint(struct f2fs_sb_info *sbi)
+{
+	struct ckpt_req_control *cprc = sbi->cprc_info;
+	struct ckpt_req req;
+
+	if (!cprc || !cprc->f2fs_issue_ckpt)
+		return __write_checkpoint_sync(sbi);
+
+	init_ckpt_req(&req);
+
+	req.queue_time = jiffies;
+	llist_add(&req.llnode, &cprc->issue_list);
+	atomic_inc(&cprc->queued_ckpt);
+
+	/* update issue_list before we wake up issue_checkpoint thread */
+	smp_mb();
+
+	if (waitqueue_active(&cprc->ckpt_wait_queue))
+		wake_up(&cprc->ckpt_wait_queue);
+
+	if (cprc->f2fs_issue_ckpt)
+		wait_for_completion(&req.wait);
+	else
+		flush_remained_ckpt_reqs(sbi, &req);
+
+	return req.ret;
+}
+
+int f2fs_create_ckpt_req_control(struct f2fs_sb_info *sbi)
+{
+	dev_t dev = sbi->sb->s_bdev->bd_dev;
+	struct ckpt_req_control *cprc;
+	bool need_free = true;
+
+	if (sbi->cprc_info) {
+		cprc = sbi->cprc_info;
+		if (cprc->f2fs_issue_ckpt)
+			return 0;
+
+		need_free = false;
+		goto init_thread;
+	}
+
+	cprc = f2fs_kzalloc(sbi, sizeof(struct ckpt_req_control), GFP_KERNEL);
+	if (!cprc)
+		return -ENOMEM;
+	atomic_set(&cprc->issued_ckpt, 0);
+	atomic_set(&cprc->total_ckpt, 0);
+	atomic_set(&cprc->queued_ckpt, 0);
+	init_waitqueue_head(&cprc->ckpt_wait_queue);
+	init_llist_head(&cprc->issue_list);
+	sbi->cprc_info = cprc;
+
+init_thread:
+	if (!test_opt(sbi, MERGE_CHECKPOINT))
+		return 0;
+
+	cprc->f2fs_issue_ckpt = kthread_run(issue_checkpoint_thread, sbi,
+			"f2fs_ckpt-%u:%u", MAJOR(dev), MINOR(dev));
+	if (IS_ERR(cprc->f2fs_issue_ckpt)) {
+		int err = PTR_ERR(cprc->f2fs_issue_ckpt);
+
+		if (need_free) {
+			kvfree(cprc);
+			sbi->cprc_info = NULL;
+		}
+		return err;
+	}
+
+	set_task_ioprio(cprc->f2fs_issue_ckpt, DEFAULT_CHECKPOINT_IOPRIO);
+
+	return 0;
+}
+
+void f2fs_destroy_ckpt_req_control(struct f2fs_sb_info *sbi, bool free)
+{
+	struct ckpt_req_control *cprc = sbi->cprc_info;
+
+	if (cprc && cprc->f2fs_issue_ckpt) {
+		struct task_struct *ckpt_task = cprc->f2fs_issue_ckpt;
+
+		cprc->f2fs_issue_ckpt = NULL;
+		kthread_stop(ckpt_task);
+
+		flush_remained_ckpt_reqs(sbi, NULL);
+	}
+
+	if (free) {
+		kvfree(cprc);
+		sbi->cprc_info = NULL;
+	}
+}
+
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 197c914119da..6ee81afae6b7 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -120,6 +120,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 			atomic_read(&SM_I(sbi)->dcc_info->discard_cmd_cnt);
 		si->undiscard_blks = SM_I(sbi)->dcc_info->undiscard_blks;
 	}
+	si->nr_issued_ckpt = atomic_read(&sbi->cprc_info->issued_ckpt);
+	si->nr_total_ckpt = atomic_read(&sbi->cprc_info->total_ckpt);
+	si->nr_queued_ckpt = atomic_read(&sbi->cprc_info->queued_ckpt);
 	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
 	si->rsvd_segs = reserved_segments(sbi);
 	si->overp_segs = overprovision_segments(sbi);
@@ -417,6 +420,9 @@ static int stat_show(struct seq_file *s, void *v)
 				si->meta_count[META_NAT]);
 		seq_printf(s, "  - ssa blocks : %u\n",
 				si->meta_count[META_SSA]);
+		seq_printf(s, "CP merge (Queued: %4d, Issued: %4d, Total: %4d)\n",
+				si->nr_queued_ckpt, si->nr_issued_ckpt,
+				si->nr_total_ckpt);
 		seq_printf(s, "GC calls: %d (BG: %d)\n",
 			   si->call_count, si->bg_gc);
 		seq_printf(s, "  - data segments : %d (%d)\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bb11759191dc..4de5285df17d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -97,6 +97,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 #define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
 #define F2FS_MOUNT_NORECOVERY		0x04000000
 #define F2FS_MOUNT_ATGC			0x08000000
+#define F2FS_MOUNT_MERGE_CHECKPOINT	0x10000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
@@ -266,6 +267,24 @@ struct fsync_node_entry {
 	unsigned int seq_id;	/* sequence id */
 };
 
+struct ckpt_req {
+	struct completion wait;
+	struct llist_node llnode;
+	int ret;
+	struct task_struct *owner;
+	unsigned long queue_time;	/* request queued time in jiffies */
+	unsigned long complete_time;	/* request completed time in jiffies */
+};
+
+struct ckpt_req_control {
+	struct task_struct *f2fs_issue_ckpt;	/* checkpoint task */
+	wait_queue_head_t ckpt_wait_queue;	/* waiting queue for wake-up */
+	atomic_t issued_ckpt;			/* # of actually issued ckpts */
+	atomic_t total_ckpt;			/* # of total ckpts */
+	atomic_t queued_ckpt;			/* # of queued ckpts */
+	struct llist_head issue_list;		/* list for command issue */
+};
+
 /* for the bitmap indicate blocks to be discarded */
 struct discard_entry {
 	struct list_head list;	/* list head */
@@ -1404,6 +1423,7 @@ struct f2fs_sb_info {
 	wait_queue_head_t cp_wait;
 	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
 	long interval_time[MAX_TIME];		/* to store thresholds */
+	struct ckpt_req_control *cprc_info;	/* for checkpoint request control */
 
 	struct inode_management im[MAX_INO_ENTRY];	/* manage inode cache */
 
@@ -3418,6 +3438,9 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi);
 int __init f2fs_create_checkpoint_caches(void);
 void f2fs_destroy_checkpoint_caches(void);
+int f2fs_issue_checkpoint(struct f2fs_sb_info *sbi);
+int f2fs_create_ckpt_req_control(struct f2fs_sb_info *sbi);
+void f2fs_destroy_ckpt_req_control(struct f2fs_sb_info *sbi, bool free);
 
 /*
  * data.c
@@ -3530,6 +3553,7 @@ struct f2fs_stat_info {
 	int nr_discarding, nr_discarded;
 	int nr_discard_cmd;
 	unsigned int undiscard_blks;
+	int nr_issued_ckpt, nr_total_ckpt, nr_queued_ckpt;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
 	int compr_inode;
 	unsigned long long compr_blocks;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b4a07fe62d1a..5cd89c231223 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -143,6 +143,7 @@ enum {
 	Opt_checkpoint_disable_cap,
 	Opt_checkpoint_disable_cap_perc,
 	Opt_checkpoint_enable,
+	Opt_checkpoint_merge,
 	Opt_compress_algorithm,
 	Opt_compress_log_size,
 	Opt_compress_extension,
@@ -213,6 +214,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
 	{Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
 	{Opt_checkpoint_enable, "checkpoint=enable"},
+	{Opt_checkpoint_merge, "checkpoint=merge"},
 	{Opt_compress_algorithm, "compress_algorithm=%s"},
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
@@ -872,6 +874,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_checkpoint_enable:
 			clear_opt(sbi, DISABLE_CHECKPOINT);
 			break;
+		case Opt_checkpoint_merge:
+			set_opt(sbi, MERGE_CHECKPOINT);
+			break;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		case Opt_compress_algorithm:
 			if (!f2fs_sb_has_compression(sbi)) {
@@ -1040,6 +1045,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
+			test_opt(sbi, MERGE_CHECKPOINT)) {
+		f2fs_err(sbi, "checkpoint=merge cannot be used with checkpoint=disable\n");
+		return -EINVAL;
+	}
+
 	/* Not pass down write hints if the number of active logs is lesser
 	 * than NR_CURSEG_PERSIST_TYPE.
 	 */
@@ -1245,6 +1256,12 @@ static void f2fs_put_super(struct super_block *sb)
 	/* prevent remaining shrinker jobs */
 	mutex_lock(&sbi->umount_mutex);
 
+	/*
+	 * flush all issued checkpoints and destroy checkpoint request control.
+	 * after then, all checkpoints should be done by each process context.
+	 */
+	f2fs_destroy_ckpt_req_control(sbi, true);
+
 	/*
 	 * We don't need to do checkpoint when superblock is clean.
 	 * But, the previous checkpoint was not done by umount, it needs to do
@@ -1347,10 +1364,13 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 		struct cp_control cpc;
 
 		cpc.reason = __get_cp_reason(sbi);
-
-		down_write(&sbi->gc_lock);
-		err = f2fs_write_checkpoint(sbi, &cpc);
-		up_write(&sbi->gc_lock);
+		if (test_opt(sbi, MERGE_CHECKPOINT) && cpc.reason == CP_SYNC) {
+			err = f2fs_issue_checkpoint(sbi);
+		} else {
+			down_write(&sbi->gc_lock);
+			err = f2fs_write_checkpoint(sbi, &cpc);
+			up_write(&sbi->gc_lock);
+		}
 	}
 	f2fs_trace_ios(NULL, 1);
 
@@ -1674,6 +1694,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	if (test_opt(sbi, DISABLE_CHECKPOINT))
 		seq_printf(seq, ",checkpoint=disable:%u",
 				F2FS_OPTION(sbi).unusable_cap);
+	if (test_opt(sbi, MERGE_CHECKPOINT))
+		seq_puts(seq, ",checkpoint=merge");
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
@@ -1954,6 +1976,18 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
+	if (!test_opt(sbi, MERGE_CHECKPOINT)) {
+		f2fs_destroy_ckpt_req_control(sbi, false);
+	} else {
+		err = f2fs_create_ckpt_req_control(sbi);
+		if (err) {
+			f2fs_err(sbi,
+				"Failed to initialize F2FS issue_checkpoint_thread (%d)",
+				err);
+			goto restore_gc;
+		}
+	}
+
 	/*
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
@@ -3701,6 +3735,15 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	f2fs_init_fsync_node_info(sbi);
 
+	/* setup checkpoint request control */
+	err = f2fs_create_ckpt_req_control(sbi);
+	if (err) {
+		f2fs_err(sbi,
+		    "Failed to initialize F2FS checkpoint request control (%d)",
+		    err);
+		goto free_cprc;
+	}
+
 	/* setup f2fs internal modules */
 	err = f2fs_build_segment_manager(sbi);
 	if (err) {
@@ -3910,6 +3953,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_sm:
 	f2fs_destroy_segment_manager(sbi);
 	f2fs_destroy_post_read_wq(sbi);
+free_cprc:
+	f2fs_destroy_ckpt_req_control(sbi, true);
 free_devices:
 	destroy_device_list(sbi);
 	kvfree(sbi->ckpt);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

