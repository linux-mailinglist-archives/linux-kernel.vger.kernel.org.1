Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B501E3809
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 07:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgE0FZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 01:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbgE0FY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:24:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23996C03E96E;
        Tue, 26 May 2020 22:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iHue7do6hun8JuTKkSqk6A1cSmWyXJMC7S37LKm+NoE=; b=EPMjuf39RInO9H+7VH8ftwUsNo
        nBrbMYTAFmxnLpfrZuVpY1ScxzqreAWOBCfaA7t5yKouEBcGkF9zKhgo5jFl18sDpjYO43J7js0Vl
        Hb6NNOxtLRfEynBwLQdDay3+Um06Dr8ig1m32jrhdmQZtDRCwxnqoBSie14OkjGMbx+mZ0IV03DQP
        oUDXNo3i728smfUjqtKqSWR4ki3hlV882jwsTd8h58POGiLeciUCsShGrp6BgatfPJG/3XbAAcU4G
        BvKXGJA002dkPLiBeS7htj5e0awbv+zJCGVKvc8zdxfH/6a3hKVqayJ4HXCmIftDglf8J0L7QRaCO
        l8BfM76g==;
Received: from [2001:4bb8:18c:5da7:8164:affc:3c20:853d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdoYe-0000sT-VA; Wed, 27 May 2020 05:24:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/16] block: always use a percpu variable for disk stats
Date:   Wed, 27 May 2020 07:24:14 +0200
Message-Id: <20200527052419.403583-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu variables have a perfectly fine working stub implementation
for UP kernels, so use that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk.h               |  2 +-
 block/genhd.c             | 12 +++------
 block/partitions/core.c   |  5 ++--
 include/linux/genhd.h     | 13 ---------
 include/linux/part_stat.h | 55 ++++++++-------------------------------
 5 files changed, 18 insertions(+), 69 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index bdf5e94467aa2..0ecba2ab383d6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -378,7 +378,7 @@ static inline void hd_struct_put(struct hd_struct *part)
 
 static inline void hd_free_part(struct hd_struct *part)
 {
-	free_part_stats(part);
+	free_percpu(part->dkstats);
 	kfree(part->info);
 	percpu_ref_exit(&part->ref);
 }
diff --git a/block/genhd.c b/block/genhd.c
index 094ed90964964..3e7df0a3e6bb0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -92,7 +92,6 @@ const char *bdevname(struct block_device *bdev, char *buf)
 }
 EXPORT_SYMBOL(bdevname);
 
-#ifdef CONFIG_SMP
 static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 {
 	int cpu;
@@ -112,12 +111,6 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 		stat->io_ticks += ptr->io_ticks;
 	}
 }
-#else /* CONFIG_SMP */
-static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
-{
-	memcpy(stat, &part->dkstats, sizeof(struct disk_stats));
-}
-#endif /* CONFIG_SMP */
 
 static unsigned int part_in_flight(struct request_queue *q,
 		struct hd_struct *part)
@@ -1688,14 +1681,15 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 
 	disk = kzalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
 	if (disk) {
-		if (!init_part_stats(&disk->part0)) {
+		disk->part0.dkstats = alloc_percpu(struct disk_stats);
+		if (!disk->part0.dkstats) {
 			kfree(disk);
 			return NULL;
 		}
 		init_rwsem(&disk->lookup_sem);
 		disk->node_id = node_id;
 		if (disk_expand_part_tbl(disk, 0)) {
-			free_part_stats(&disk->part0);
+			free_percpu(disk->part0.dkstats);
 			kfree(disk);
 			return NULL;
 		}
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 297004fd22648..78951e33b2d7c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -387,7 +387,8 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (!p)
 		return ERR_PTR(-EBUSY);
 
-	if (!init_part_stats(p)) {
+	p->dkstats = alloc_percpu(struct disk_stats);
+	if (!p->dkstats) {
 		err = -ENOMEM;
 		goto out_free;
 	}
@@ -468,7 +469,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 out_free_info:
 	kfree(p->info);
 out_free_stats:
-	free_part_stats(p);
+	free_percpu(p->dkstats);
 out_free:
 	kfree(p);
 	return ERR_PTR(err);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index a9384449465a3..f0d6d77309a54 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -39,15 +39,6 @@ extern struct class block_class;
 #include <linux/fs.h>
 #include <linux/workqueue.h>
 
-struct disk_stats {
-	u64 nsecs[NR_STAT_GROUPS];
-	unsigned long sectors[NR_STAT_GROUPS];
-	unsigned long ios[NR_STAT_GROUPS];
-	unsigned long merges[NR_STAT_GROUPS];
-	unsigned long io_ticks;
-	local_t in_flight[2];
-};
-
 #define PARTITION_META_INFO_VOLNAMELTH	64
 /*
  * Enough for the string representation of any kind of UUID plus NULL.
@@ -72,11 +63,7 @@ struct hd_struct {
 	seqcount_t nr_sects_seq;
 #endif
 	unsigned long stamp;
-#ifdef	CONFIG_SMP
 	struct disk_stats __percpu *dkstats;
-#else
-	struct disk_stats dkstats;
-#endif
 	struct percpu_ref ref;
 
 	sector_t alignment_offset;
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index ece607607a864..6644197980b92 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -4,19 +4,23 @@
 
 #include <linux/genhd.h>
 
+struct disk_stats {
+	u64 nsecs[NR_STAT_GROUPS];
+	unsigned long sectors[NR_STAT_GROUPS];
+	unsigned long ios[NR_STAT_GROUPS];
+	unsigned long merges[NR_STAT_GROUPS];
+	unsigned long io_ticks;
+	local_t in_flight[2];
+};
+
 /*
  * Macros to operate on percpu disk statistics:
  *
- * {disk|part|all}_stat_{add|sub|inc|dec}() modify the stat counters
- * and should be called between disk_stat_lock() and
- * disk_stat_unlock().
+ * {disk|part|all}_stat_{add|sub|inc|dec}() modify the stat counters and should
+ * be called between disk_stat_lock() and disk_stat_unlock().
  *
  * part_stat_read() can be called at any time.
- *
- * part_stat_{add|set_all}() and {init|free}_part_stats are for
- * internal use only.
  */
-#ifdef	CONFIG_SMP
 #define part_stat_lock()	({ rcu_read_lock(); get_cpu(); })
 #define part_stat_unlock()	do { put_cpu(); rcu_read_unlock(); } while (0)
 
@@ -44,43 +48,6 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 				sizeof(struct disk_stats));
 }
 
-static inline int init_part_stats(struct hd_struct *part)
-{
-	part->dkstats = alloc_percpu(struct disk_stats);
-	if (!part->dkstats)
-		return 0;
-	return 1;
-}
-
-static inline void free_part_stats(struct hd_struct *part)
-{
-	free_percpu(part->dkstats);
-}
-
-#else /* !CONFIG_SMP */
-#define part_stat_lock()	({ rcu_read_lock(); 0; })
-#define part_stat_unlock()	rcu_read_unlock()
-
-#define part_stat_get(part, field)		((part)->dkstats.field)
-#define part_stat_get_cpu(part, field, cpu)	part_stat_get(part, field)
-#define part_stat_read(part, field)		part_stat_get(part, field)
-
-static inline void part_stat_set_all(struct hd_struct *part, int value)
-{
-	memset(&part->dkstats, value, sizeof(struct disk_stats));
-}
-
-static inline int init_part_stats(struct hd_struct *part)
-{
-	return 1;
-}
-
-static inline void free_part_stats(struct hd_struct *part)
-{
-}
-
-#endif /* CONFIG_SMP */
-
 #define part_stat_read_accum(part, field)				\
 	(part_stat_read(part, field[STAT_READ]) +			\
 	 part_stat_read(part, field[STAT_WRITE]) +			\
-- 
2.26.2

