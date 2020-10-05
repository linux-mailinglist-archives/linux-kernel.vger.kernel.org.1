Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83DE28345D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgJEK6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:58:47 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:51049 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJEK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601895527; x=1633431527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rWHwBW9odJPqpm8jQnNHAqv59PCTaiCF9pp/UZsKxQo=;
  b=iM1jt+cXoPxIMDRrtHIX2LG9YZl2MttyPMGoZ8vz4Th2R5JjoCLjVFTW
   HxY5Wz4NY9GDixl+LsojOwUzbLAGGmn9CTuiZMrosh4GtrEno0+fzvxA5
   vZKouDDtdkqUjeG2oU/rT4jfoPSIjzy+5NhVwYp/9t5l/QvyTTjJu8vqh
   s=;
X-IronPort-AV: E=Sophos;i="5.77,338,1596499200"; 
   d="scan'208";a="59450984"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 05 Oct 2020 10:58:46 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id CF0CCC0658;
        Mon,  5 Oct 2020 10:58:33 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.146) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 5 Oct 2020 10:58:16 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v21 09/18] mm/damon: Add a tracepoint
Date:   Mon, 5 Oct 2020 12:55:13 +0200
Message-ID: <20201005105522.23841-10-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005105522.23841-1-sjpark@amazon.com>
References: <20201005105522.23841-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.146]
X-ClientProxiedBy: EX13d09UWC002.ant.amazon.com (10.43.162.102) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a tracepoint for DAMON.  It traces the monitoring
results of each region for each aggregation interval.  Using this, DAMON
can easily integrated with tracepoints supporting tools such as perf.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c              |  7 +++++-
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/damon.h

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
new file mode 100644
index 000000000000..2f422f4f1fb9
--- /dev/null
+++ b/include/trace/events/damon.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM damon
+
+#if !defined(_TRACE_DAMON_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DAMON_H
+
+#include <linux/damon.h>
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(damon_aggregated,
+
+	TP_PROTO(struct damon_target *t, struct damon_region *r,
+		unsigned int nr_regions),
+
+	TP_ARGS(t, r, nr_regions),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, target_id)
+		__field(unsigned int, nr_regions)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned int, nr_accesses)
+	),
+
+	TP_fast_assign(
+		__entry->target_id = t->id;
+		__entry->nr_regions = nr_regions;
+		__entry->start = r->ar.start;
+		__entry->end = r->ar.end;
+		__entry->nr_accesses = r->nr_accesses;
+	),
+
+	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u",
+			__entry->target_id, __entry->nr_regions,
+			__entry->start, __entry->end, __entry->nr_accesses)
+);
+
+#endif /* _TRACE_DAMON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 36428327e848..d7957d8ff530 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -13,6 +13,9 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/damon.h>
+
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define MIN_REGION PAGE_SIZE
 
@@ -386,8 +389,10 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	damon_for_each_target(t, c) {
 		struct damon_region *r;
 
-		damon_for_each_region(r, t)
+		damon_for_each_region(r, t) {
+			trace_damon_aggregated(t, r, damon_nr_regions(t));
 			r->nr_accesses = 0;
+		}
 	}
 }
 
-- 
2.17.1

