Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E72F284BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgJFMls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:41:48 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:10878 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgJFMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601988107; x=1633524107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PAYn8w+uMmIbD04eOFO3e2KDvKGrIy/WNCbGQFZGDiY=;
  b=tnJz8Ux9D8VNRa/HXYgeQQWftO72vV5At7ODJZdbHmX7wgOKovggpyOh
   KMYIQ4SA+brRR3mwe7+BZmVjVmiVgaXAYrQGG7j3X/1CzzQlN30mfAXJ8
   YrYYK5Prvxzt08Rc6zsRxPmTLphaiOE2ARHbc+nY0iBrzcUTan1RP6ZJ3
   Q=;
X-IronPort-AV: E=Sophos;i="5.77,343,1596499200"; 
   d="scan'208";a="58312529"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 06 Oct 2020 12:41:42 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 0E7C2A0489;
        Tue,  6 Oct 2020 12:41:29 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 6 Oct 2020 12:41:11 +0000
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
Subject: [RFC v15 3/8] mm/damon/primitives: Support DAMON-based Operation Schemes
Date:   Tue, 6 Oct 2020 14:39:26 +0200
Message-ID: <20201006123931.5847-4-sjpark@amazon.com>
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

This commit makes DAMON's default primitives for virtual address spaces
to support DAMON-based Operation Schemes (DAMOS) by implementing actions
application functions and registering it to the monitoring context.  The
implementation simply links 'madvise()' for related DAMOS actions.  That
is, 'madvise(MADV_WILLNEED)' is called for 'WILLNEED' DAMOS action and
similar for other actions ('COLD', 'PAGEOUT', 'HUGEPAGE', 'NOHUGEPAGE').

So, the kernel space DAMON users can now use the DAMON-based
optimizations with only small amount of code.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  2 ++
 mm/damon/primitives.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 92944a336286..3aaea4fdde80 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -323,6 +323,8 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx);
 unsigned int damon_va_check_accesses(struct damon_ctx *ctx);
 bool damon_va_target_valid(struct damon_target *t);
 void damon_va_cleanup(struct damon_ctx *ctx);
+int damon_va_apply_scheme(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_va_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_PRIMITIVES */
diff --git a/mm/damon/primitives.c b/mm/damon/primitives.c
index abc072008faf..2224e3e139a8 100644
--- a/mm/damon/primitives.c
+++ b/mm/damon/primitives.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "damon-prmt: " fmt
 
+#include <asm-generic/mman-common.h>
 #include <linux/damon.h>
 #include <linux/mm.h>
 #include <linux/mmu_notifier.h>
@@ -582,6 +583,66 @@ void damon_va_cleanup(struct damon_ctx *ctx)
 	}
 }
 
+#ifndef CONFIG_ADVISE_SYSCALLS
+static int damos_madvise(struct damon_target *target, struct damon_region *r,
+			int behavior)
+{
+	return -EINVAL;
+}
+#else
+static int damos_madvise(struct damon_target *target, struct damon_region *r,
+			int behavior)
+{
+	struct task_struct *t;
+	struct mm_struct *mm;
+	int ret = -ENOMEM;
+
+	t = damon_get_task_struct(target);
+	if (!t)
+		goto out;
+	mm = damon_get_mm(target);
+	if (!mm)
+		goto put_task_out;
+
+	ret = do_madvise(t, mm, PAGE_ALIGN(r->ar.start),
+			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
+	mmput(mm);
+put_task_out:
+	put_task_struct(t);
+out:
+	return ret;
+}
+#endif	/* CONFIG_ADVISE_SYSCALLS */
+
+int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme)
+{
+	int madv_action;
+
+	switch (scheme->action) {
+	case DAMOS_WILLNEED:
+		madv_action = MADV_WILLNEED;
+		break;
+	case DAMOS_COLD:
+		madv_action = MADV_COLD;
+		break;
+	case DAMOS_PAGEOUT:
+		madv_action = MADV_PAGEOUT;
+		break;
+	case DAMOS_HUGEPAGE:
+		madv_action = MADV_HUGEPAGE;
+		break;
+	case DAMOS_NOHUGEPAGE:
+		madv_action = MADV_NOHUGEPAGE;
+		break;
+	default:
+		pr_warn("Wrong action %d\n", scheme->action);
+		return -EINVAL;
+	}
+
+	return damos_madvise(t, r, madv_action);
+}
+
 void damon_va_set_primitives(struct damon_ctx *ctx)
 {
 	ctx->primitive.init_target_regions = damon_va_init_regions;
@@ -590,6 +651,7 @@ void damon_va_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.check_accesses = damon_va_check_accesses;
 	ctx->primitive.target_valid = damon_va_target_valid;
 	ctx->primitive.cleanup = damon_va_cleanup;
+	ctx->primitive.apply_scheme = damon_va_apply_scheme;
 }
 
 #include "primitives-test.h"
-- 
2.17.1

