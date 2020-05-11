Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CB1CDA0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgEKMgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 08:36:55 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:65330 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgEKMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589200614; x=1620736614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gm3RkgBnFlsR0KLH3wADEsc5/8hUuBZNui1ctNCxs+I=;
  b=IXydZQPY2T8TD0lqihRT0yIYqDx+FFgQMYBThgp1CExFlc0yP4gZ4Gqw
   GUIslID03Sxxwpi2B7G8UhRvTCMEqbkCTJdkgUVP+tp6lbc73bivlG4SZ
   8gJ7L9GE1KNbtnWetE8ODn1MDOKJWGaUsaAlJoviQUV3pMfTtQB1Atr7x
   Y=;
IronPort-SDR: bD3UbNFmyebn4uwq18PQt0i8oiWF+RXahclxjzXJksOdvJkbbH5fFLifCG5di9rzz3zM8c6HQk
 dpxbU9ZLF78w==
X-IronPort-AV: E=Sophos;i="5.73,380,1583193600"; 
   d="scan'208";a="34195023"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 May 2020 12:36:49 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 5E2E3A2340;
        Mon, 11 May 2020 12:36:38 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:36:37 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.253) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:36:22 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 06/16] mm/damon: Split regions into 3 subregions if necessary
Date:   Mon, 11 May 2020 14:32:52 +0200
Message-ID: <20200511123302.12520-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511123302.12520-1-sjpark@amazon.com>
References: <20200511123302.12520-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D06UWC001.ant.amazon.com (10.43.162.91) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Suppose that there are a very wide and cold region and a hot region, and
both regions are identified by DAMON.  And then, the middle small region
inside the very wide and cold region becomes hot.  DAMON will not be
able to identify this new region because the adaptive regions adjustment
mechanism splits each region to only two subregions.

This commit modifies the logic to split each region to 3 subregions if
such corner case is detected.

Suggested-by: James Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index cec946197e13..fbf37df841ce 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -650,26 +650,32 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 	damon_insert_region(new, r, damon_next_region(r));
 }
 
-/* Split every region in the given task into two randomly-sized regions */
-static void damon_split_regions_of(struct damon_ctx *ctx, struct damon_task *t)
+/* Split every region in the given task into 'nr_subs' regions */
+static void damon_split_regions_of(struct damon_ctx *ctx,
+				     struct damon_task *t, int nr_subs)
 {
 	struct damon_region *r, *next;
-	unsigned long sz_orig_region, sz_left_region;
+	unsigned long sz_region, sz_sub = 0;
+	int i;
 
 	damon_for_each_region_safe(r, next, t) {
-		sz_orig_region = r->vm_end - r->vm_start;
-
-		/*
-		 * Randomly select size of left sub-region to be at least
-		 * 10 percent and at most 90% of original region
-		 */
-		sz_left_region = ALIGN_DOWN(damon_rand(1, 10) * sz_orig_region
-					    / 10, MIN_REGION);
-		/* Do not allow blank region */
-		if (sz_left_region == 0 || sz_left_region >= sz_orig_region)
-			continue;
-
-		damon_split_region_at(ctx, r, sz_left_region);
+		sz_region = r->vm_end - r->vm_start;
+
+		for (i = 0; i < nr_subs - 1 &&
+				sz_region > 2 * MIN_REGION; i++) {
+			/*
+			 * Randomly select size of left sub-region to be at
+			 * least 10 percent and at most 90% of original region
+			 */
+			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
+					sz_region / 10, MIN_REGION);
+			/* Do not allow blank region */
+			if (sz_sub == 0 || sz_sub >= sz_region)
+				continue;
+
+			damon_split_region_at(ctx, r, sz_sub);
+			sz_region = sz_sub;
+		}
 	}
 }
 
@@ -687,14 +693,25 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 	unsigned int nr_regions = 0;
+	static unsigned int last_nr_regions;
+	int nr_subregions = 2;
 
 	damon_for_each_task(ctx, t)
 		nr_regions += nr_damon_regions(t);
+
 	if (nr_regions > ctx->max_nr_regions / 2)
 		return;
 
+	/* If number of regions is not changed, we are maybe in corner case */
+	if (last_nr_regions == nr_regions &&
+			nr_regions < ctx->max_nr_regions / 3)
+		nr_subregions = 3;
+
 	damon_for_each_task(ctx, t)
-		damon_split_regions_of(ctx, t);
+		damon_split_regions_of(ctx, t, nr_subregions);
+
+	if (!last_nr_regions)
+		last_nr_regions = nr_regions;
 }
 
 /*
-- 
2.17.1

