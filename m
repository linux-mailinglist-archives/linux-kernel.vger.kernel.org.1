Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20F1284BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgJFMlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:41:10 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:47739 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgJFMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601988067; x=1633524067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=uW2wVCE0fdVcJc5KeJb9HPd/tw2Lj3G+kCxi3x3dF+c=;
  b=AtN0oKyOj2QMTQcBpo3BEa4tR/Cg8lpVCXEDTTp4/mi/jTb8AiiJIZev
   g7FTczEA/6nWUampM9/QR5gcdRfWEjeOeKtrBDsf+0tPT59u96YLriEtP
   sxXX0Di8tPwnCz54qzntJAF+/bx7QW43nQHWcT+HVhwK5XVJdbOGsTEqd
   s=;
X-IronPort-AV: E=Sophos;i="5.77,343,1596499200"; 
   d="scan'208";a="80729222"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 06 Oct 2020 12:41:02 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 7EC9DA241F;
        Tue,  6 Oct 2020 12:40:50 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 6 Oct 2020 12:40:32 +0000
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
Subject: [RFC v15 1/8] mm/damon/core: Account age of target regions
Date:   Tue, 6 Oct 2020 14:39:24 +0200
Message-ID: <20201006123931.5847-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006123931.5847-1-sjpark@amazon.com>
References: <20201006123931.5847-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D18UWA002.ant.amazon.com (10.43.160.199) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON can be used for data access pattern aware memory management
optimizations.  For that, users should run DAMON, read the monitoring
results, analyze it, plan a new memory management scheme, and apply the
new scheme by themselves.  It would not be too hard, but still require
some level of effort.  For complicated cases, this effort is inevitable.

That said, in many cases, users would simply want to apply an actions to
a memory region of a specific size having a specific access frequency
for a specific time.  For example, "page out a memory region larger than
100 MiB but having a low access frequency more than 10 minutes", or "Use
THP for a memory region larger than 2 MiB having a high access frequency
for more than 2 seconds".

For such optimizations, users will need to first account the age of each
region themselves.  To reduce such efforts, this commit implements a
simple age account of each region in DAMON.  For each aggregation step,
DAMON compares the access frequency with that from last aggregation and
reset the age of the region if the change is significant.  Else, the age
is incremented.  Also, in case of the merge of regions, the region
size-weighted average of the ages is set as the age of merged new
region.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 10 ++++++++++
 mm/damon/core.c       | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d675ea908a02..696f25e25d95 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -28,12 +28,22 @@ struct damon_addr_range {
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
  * @list:		List head for siblings.
+ * @age:		Age of this region.
+ * @last_nr_accesses:	Internal value for age calculation.
+ *
+ * @age is initially zero, increased for each aggregation interval, and reset
+ * to zero again if the access frequency is significantly changed.  If two
+ * regions are merged into a new region, both @nr_accesses and @age of the new
+ * region are set as region size-weighted average of those of the two regions.
  */
 struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	struct list_head list;
+
+	unsigned int age;
+	unsigned int last_nr_accesses;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7c547e1022af..cf3a83509bfc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -51,6 +51,9 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->nr_accesses = 0;
 	INIT_LIST_HEAD(&region->list);
 
+	region->age = 0;
+	region->last_nr_accesses = 0;
+
 	return region;
 }
 
@@ -443,6 +446,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 
 		damon_for_each_region(r, t) {
 			trace_damon_aggregated(t, r, damon_nr_regions(t));
+			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
 	}
@@ -460,6 +464,7 @@ static void damon_merge_two_regions(struct damon_region *l,
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
+	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	damon_destroy_region(r);
 }
@@ -479,6 +484,11 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
+		if (diff_of(r->nr_accesses, r->last_nr_accesses) > thres)
+			r->age = 0;
+		else
+			r->age++;
+
 		if (prev && prev->ar.end == r->ar.start &&
 		    diff_of(prev->nr_accesses, r->nr_accesses) <= thres &&
 		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
@@ -522,6 +532,9 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
 	r->ar.end = new->ar.start;
 
+	new->age = r->age;
+	new->last_nr_accesses = r->last_nr_accesses;
+
 	damon_insert_region(new, r, damon_next_region(r));
 }
 
-- 
2.17.1

