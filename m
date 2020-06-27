Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1918B20BFAB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 09:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgF0HdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 03:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgF0HdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:33:18 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF5DC03E97A;
        Sat, 27 Jun 2020 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=neOgU92RsrWDuksyQ2Z1wFdOnnGrSBcBhrDlZznOqq0=; b=u0A0PX8v6CDjtRXkekDJ9GPZcA
        FENXXFhI2izz8lcBcKb5aWOhXCPP2z4UVHieA7JWGSgOpclTA8JLr2Pp1pX2NQ83uXTaPwMmz5vAU
        U2X35b2VMZAlui75iR9AdUpKd9NGKPiN9uhpWEHxitnCXeatyhWsBdhNbQfPMM+0yjf4gSx3Z3HaH
        GWNHb/bJK5RuN1uXcAatmVe3NAk4BLtr/tn3Z2XPqLxGW1D9WJjqmZ2uo9zwBhUeXVOc4oJhuCyfR
        pxw/1+5SLMZzgs5r+Y0Gbv0CQqwFjeqFeXcCMxPp7rSw3Wq8fhJlCzQsJb5+fN9oNwPgV6zq4T/cc
        YpgPDRLQ==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5KS-0006q3-6c; Sat, 27 Jun 2020 07:32:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 13/14] blk-cgroup: remove blkcg_bio_issue_check
Date:   Sat, 27 Jun 2020 09:31:58 +0200
Message-Id: <20200627073159.2447325-14-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
References: <20200627073159.2447325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blkcg_bio_issue_check is a giant inline function that does three entirely
different things.  Factor out the blk-cgroup related bio initalization
into a new helper, and the open code the sequence in the only caller,
relying on the fact that all the actual functionality is stubbed out for
non-cgroup builds.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         | 34 +++++++++++++++++++++++
 block/blk-core.c           |  7 ++++-
 block/blk-throttle.c       |  5 ++--
 block/blk.h                |  2 ++
 include/linux/blk-cgroup.h | 56 ++------------------------------------
 5 files changed, 47 insertions(+), 57 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d21ec2acd716e7..1ce94afc03bcfd 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1813,6 +1813,40 @@ void bio_clone_blkg_association(struct bio *dst, struct bio *src)
 }
 EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
 
+static int blk_cgroup_io_type(struct bio *bio)
+{
+	if (op_is_discard(bio->bi_opf))
+		return BLKG_IOSTAT_DISCARD;
+	if (op_is_write(bio->bi_opf))
+		return BLKG_IOSTAT_WRITE;
+	return BLKG_IOSTAT_READ;
+}
+
+void blk_cgroup_bio_start(struct bio *bio)
+{
+	int rwd = blk_cgroup_io_type(bio), cpu;
+	struct blkg_iostat_set *bis;
+
+	cpu = get_cpu();
+	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
+	u64_stats_update_begin(&bis->sync);
+
+	/*
+	 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a split
+	 * bio and we would have already accounted for the size of the bio.
+	 */
+	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+		bio_set_flag(bio, BIO_CGROUP_ACCT);
+			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
+	}
+	bis->cur.ios[rwd]++;
+
+	u64_stats_update_end(&bis->sync);
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
+		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
+	put_cpu();
+}
+
 static int __init blkcg_init(void)
 {
 	blkcg_punt_bio_wq = alloc_workqueue("blkcg_punt_bio",
diff --git a/block/blk-core.c b/block/blk-core.c
index a9769c1a287546..76cfd5709f66cd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1073,8 +1073,13 @@ generic_make_request_checks(struct bio *bio)
 	if (unlikely(!current->io_context))
 		create_task_io_context(current, GFP_ATOMIC, q->node);
 
-	if (!blkcg_bio_issue_check(q, bio))
+	if (blk_throtl_bio(bio)) {
+		blkcg_bio_issue_init(bio);
 		return false;
+	}
+
+	blk_cgroup_bio_start(bio);
+	blkcg_bio_issue_init(bio);
 
 	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
 		trace_block_bio_queue(q, bio);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ac008345050010..9d00f62c05ecdf 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2158,9 +2158,10 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
-bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
-		    struct bio *bio)
+bool blk_throtl_bio(struct bio *bio)
 {
+	struct request_queue *q = bio->bi_disk->queue;
+	struct blkcg_gq *blkg = bio->bi_blkg;
 	struct throtl_qnode *qn = NULL;
 	struct throtl_grp *tg = blkg_to_tg(blkg ?: q->root_blkg);
 	struct throtl_service_queue *sq;
diff --git a/block/blk.h b/block/blk.h
index 3a120a070dac82..41a50880c94e98 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -288,10 +288,12 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
 extern int blk_throtl_init(struct request_queue *q);
 extern void blk_throtl_exit(struct request_queue *q);
 extern void blk_throtl_register_queue(struct request_queue *q);
+bool blk_throtl_bio(struct bio *bio);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
+static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 8ab043c911f233..431b2d18bf4074 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -517,14 +517,6 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
 					      (p_blkg)->q, false)))
 
-#ifdef CONFIG_BLK_DEV_THROTTLING
-extern bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
-			   struct bio *bio);
-#else
-static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
-				  struct bio *bio) { return false; }
-#endif
-
 bool __blkcg_punt_bio_submit(struct bio *bio);
 
 static inline bool blkcg_punt_bio_submit(struct bio *bio)
@@ -540,50 +532,6 @@ static inline void blkcg_bio_issue_init(struct bio *bio)
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 }
 
-static inline bool blkcg_bio_issue_check(struct request_queue *q,
-					 struct bio *bio)
-{
-	struct blkcg_gq *blkg = bio->bi_blkg;
-	bool throtl = false;
-
-	throtl = blk_throtl_bio(q, blkg, bio);
-	if (!throtl) {
-		struct blkg_iostat_set *bis;
-		int rwd, cpu;
-
-		if (op_is_discard(bio->bi_opf))
-			rwd = BLKG_IOSTAT_DISCARD;
-		else if (op_is_write(bio->bi_opf))
-			rwd = BLKG_IOSTAT_WRITE;
-		else
-			rwd = BLKG_IOSTAT_READ;
-
-		cpu = get_cpu();
-		bis = per_cpu_ptr(blkg->iostat_cpu, cpu);
-		u64_stats_update_begin(&bis->sync);
-
-		/*
-		 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a
-		 * split bio and we would have already accounted for the size of
-		 * the bio.
-		 */
-		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
-			bio_set_flag(bio, BIO_CGROUP_ACCT);
-			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
-		}
-		bis->cur.ios[rwd]++;
-
-		u64_stats_update_end(&bis->sync);
-		if (cgroup_subsys_on_dfl(io_cgrp_subsys))
-			cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
-		put_cpu();
-	}
-
-	blkcg_bio_issue_init(bio);
-
-	return !throtl;
-}
-
 static inline void blkcg_use_delay(struct blkcg_gq *blkg)
 {
 	if (WARN_ON_ONCE(atomic_read(&blkg->use_delay) < 0))
@@ -657,6 +605,7 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
 }
 
+void blk_cgroup_bio_start(struct bio *bio);
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
@@ -710,8 +659,7 @@ static inline void blkg_put(struct blkcg_gq *blkg) { }
 
 static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
-static inline bool blkcg_bio_issue_check(struct request_queue *q,
-					 struct bio *bio) { return true; }
+static inline void blk_cgroup_bio_start(struct bio *bio) { }
 
 #define blk_queue_for_each_rl(rl, q)	\
 	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
-- 
2.26.2

