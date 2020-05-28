Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9027F1E5DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbgE1LBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 07:01:46 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36146 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388087AbgE1LBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:01:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TztfJev_1590663686;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TztfJev_1590663686)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 19:01:26 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v11 04/16] mm/compaction: rename compact_deferred as compact_should_defer
Date:   Thu, 28 May 2020 19:00:46 +0800
Message-Id: <1590663658-184131-5-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compact_deferred is a defer suggestion check, deferring action does in
defer_compaction not here. so, better rename it to avoid confusing.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/compaction.h        | 4 ++--
 include/trace/events/compaction.h | 2 +-
 mm/compaction.c                   | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 3ed2f22b588a..9626f057b9f2 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -100,7 +100,7 @@ extern enum compact_result compaction_suitable(struct zone *zone, int order,
 		unsigned int alloc_flags, int highest_zoneidx);
 
 extern void defer_compaction(struct zone *zone, int order);
-extern bool compaction_deferred(struct zone *zone, int order);
+extern bool compaction_should_defer(struct zone *zone, int order);
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
 extern bool compaction_restarting(struct zone *zone, int order);
@@ -199,7 +199,7 @@ static inline void defer_compaction(struct zone *zone, int order)
 {
 }
 
-static inline bool compaction_deferred(struct zone *zone, int order)
+static inline bool compaction_should_defer(struct zone *zone, int order)
 {
 	return true;
 }
diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 54e5bf081171..33633c71df04 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -274,7 +274,7 @@
 		1UL << __entry->defer_shift)
 );
 
-DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_deferred,
+DEFINE_EVENT(mm_compaction_defer_template, mm_compaction_should_defer,
 
 	TP_PROTO(struct zone *zone, int order),
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 38cdf392837b..c359772dbfcc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -154,7 +154,7 @@ void defer_compaction(struct zone *zone, int order)
 }
 
 /* Returns true if compaction should be skipped this time */
-bool compaction_deferred(struct zone *zone, int order)
+bool compaction_should_defer(struct zone *zone, int order)
 {
 	unsigned long defer_limit = 1UL << zone->compact_defer_shift;
 
@@ -168,7 +168,7 @@ bool compaction_deferred(struct zone *zone, int order)
 	if (zone->compact_considered >= defer_limit)
 		return false;
 
-	trace_mm_compaction_deferred(zone, order);
+	trace_mm_compaction_should_defer(zone, order);
 
 	return true;
 }
@@ -2379,7 +2379,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		enum compact_result status;
 
 		if (prio > MIN_COMPACT_PRIORITY
-					&& compaction_deferred(zone, order)) {
+				&& compaction_should_defer(zone, order)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
 			continue;
 		}
@@ -2563,7 +2563,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (!populated_zone(zone))
 			continue;
 
-		if (compaction_deferred(zone, cc.order))
+		if (compaction_should_defer(zone, cc.order))
 			continue;
 
 		if (compaction_suitable(zone, cc.order, 0, zoneid) !=
-- 
1.8.3.1

