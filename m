Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D50B2C11A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgKWRJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:09:24 -0500
Received: from m12-16.163.com ([220.181.12.16]:39973 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732339AbgKWRJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=lu+CC
        nmMmBQ4sYbPblnDdIkRR6VjoKrmcs5W1hkypLg=; b=n3Ti7z0bLalc+elkGblNv
        Pk+bYnyEUNwgk0Ld9arIrQEidv5VbktV8cZ17om2EDMKEl2tiTZr0U5jVBKly/SL
        eeATyIBe72DcyHrgtIcox3679RNhIpiy2YMYwzZJ3ORjN71/aKyQ7yqDG0emZfGp
        YT85SHhfqguaPNN+1kujgE=
Received: from localhost (unknown [101.86.213.141])
        by smtp12 (Coremail) with SMTP id EMCowAC3BUFx7Ltf73e_Ng--.5074S2;
        Tue, 24 Nov 2020 01:08:01 +0800 (CST)
Date:   Tue, 24 Nov 2020 01:08:01 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, nigupta@nvidia.com, vbabka@suse.cz,
        bhe@redhat.com, mateusznosek0@gmail.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/compaction: make defer_compaction and compaction_deferred
 static
Message-ID: <20201123170801.GA9625@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EMCowAC3BUFx7Ltf73e_Ng--.5074S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFyktF1rCw1Uuw4UWFW3KFg_yoW5ur1xpF
        1Uu3W7A3s5XF15WrW8tF48Aa1Yvw4fKF18Ary0g348Jw1Yk3Z2y3WktFy5CF1UXryayr4j
        vF4UGw1kKrZxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2zuZUUUUU=
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiWRLlX1WBthD70wAAsr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

defer_compaction() and  compaction_deferred() and
compaction_restarting() in mm/compaction.c won't
be used in other files, so make them static, and
remove the declaration in the header file.

Take the chance to fix a typo.

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/compaction.h | 12 ------------
 mm/compaction.c            |  8 ++++----
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 1de5a1151ee7..ed4070ed41ef 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -98,11 +98,8 @@ extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern enum compact_result compaction_suitable(struct zone *zone, int order,
 		unsigned int alloc_flags, int highest_zoneidx);
 
-extern void defer_compaction(struct zone *zone, int order);
-extern bool compaction_deferred(struct zone *zone, int order);
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
-extern bool compaction_restarting(struct zone *zone, int order);
 
 /* Compaction has made some progress and retrying makes sense */
 static inline bool compaction_made_progress(enum compact_result result)
@@ -194,15 +191,6 @@ static inline enum compact_result compaction_suitable(struct zone *zone, int ord
 	return COMPACT_SKIPPED;
 }
 
-static inline void defer_compaction(struct zone *zone, int order)
-{
-}
-
-static inline bool compaction_deferred(struct zone *zone, int order)
-{
-	return true;
-}
-
 static inline bool compaction_made_progress(enum compact_result result)
 {
 	return false;
diff --git a/mm/compaction.c b/mm/compaction.c
index 13cb7a961b31..60135a820b55 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(__ClearPageMovable);
  * allocation success. 1 << compact_defer_shift, compactions are skipped up
  * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
  */
-void defer_compaction(struct zone *zone, int order)
+static void defer_compaction(struct zone *zone, int order)
 {
 	zone->compact_considered = 0;
 	zone->compact_defer_shift++;
@@ -172,7 +172,7 @@ void defer_compaction(struct zone *zone, int order)
 }
 
 /* Returns true if compaction should be skipped this time */
-bool compaction_deferred(struct zone *zone, int order)
+static bool compaction_deferred(struct zone *zone, int order)
 {
 	unsigned long defer_limit = 1UL << zone->compact_defer_shift;
 
@@ -209,7 +209,7 @@ void compaction_defer_reset(struct zone *zone, int order,
 }
 
 /* Returns true if restarting compaction after many failures */
-bool compaction_restarting(struct zone *zone, int order)
+static bool compaction_restarting(struct zone *zone, int order)
 {
 	if (order < zone->compact_order_failed)
 		return false;
@@ -237,7 +237,7 @@ static void reset_cached_positions(struct zone *zone)
 }
 
 /*
- * Compound pages of >= pageblock_order should consistenly be skipped until
+ * Compound pages of >= pageblock_order should consistently be skipped until
  * released. It is always pointless to compact pages of such order (if they are
  * migratable), and the pageblocks they occupy cannot contain any free pages.
  */
-- 
2.29.2


