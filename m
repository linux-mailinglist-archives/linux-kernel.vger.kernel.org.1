Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514262DBCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgLPIq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:46:27 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:15841 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgLPIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608108387; x=1639644387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=d5Dwu12G70RPXtr6ZcK3mCRob0N4SZzNNQ50Ho7aEBg=;
  b=KDSyhyCixqOCXtKC6Ads401QvcpXE+QrD9qyqC7P4yXWN7yNx4dIuYBC
   7GfJDlYA6FHdbJWOvPcXT7XCZkm2xBDuM2K6jBjvIWWEAMCl2LAyuaZcL
   zt54InpinMMRC8tAKA3xWBY9LcEXeaF9Tjz5JcL3GCR4bUc934zFu2hex
   4=;
X-IronPort-AV: E=Sophos;i="5.78,424,1599523200"; 
   d="scan'208";a="71553003"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Dec 2020 08:45:46 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id E8813A1E86;
        Wed, 16 Dec 2020 08:45:33 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.102) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Dec 2020 08:45:17 +0000
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
Subject: [RFC v15.1 3/8] mm/damon/vaddr: Support DAMON-based Operation Schemes
Date:   Wed, 16 Dec 2020 09:43:59 +0100
Message-ID: <20201216084404.23183-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216084404.23183-1-sjpark@amazon.com>
References: <20201216084404.23183-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.102]
X-ClientProxiedBy: EX13D22UWB003.ant.amazon.com (10.43.161.76) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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
 mm/damon/vaddr.c      | 56 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index cfcd399da134..8988238cb29e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -362,6 +362,8 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx);
 unsigned int damon_va_check_accesses(struct damon_ctx *ctx);
 bool damon_va_target_valid(void *t);
 void damon_va_cleanup(struct damon_ctx *ctx);
+int damon_va_apply_scheme(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_va_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_VADDR */
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 8ee48a4abc17..ebf4720c057a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "damon-va: " fmt
 
+#include <asm-generic/mman-common.h>
 #include <linux/damon.h>
 #include <linux/mm.h>
 #include <linux/mmu_notifier.h>
@@ -572,6 +573,60 @@ void damon_va_cleanup(struct damon_ctx *ctx)
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
+	struct mm_struct *mm;
+	int ret = -ENOMEM;
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		goto out;
+
+	ret = do_madvise(mm, PAGE_ALIGN(r->ar.start),
+			PAGE_ALIGN(r->ar.end - r->ar.start), behavior);
+	mmput(mm);
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
@@ -581,6 +636,7 @@ void damon_va_set_primitives(struct damon_ctx *ctx)
 	ctx->primitive.reset_aggregated = NULL;
 	ctx->primitive.target_valid = damon_va_target_valid;
 	ctx->primitive.cleanup = damon_va_cleanup;
+	ctx->primitive.apply_scheme = damon_va_apply_scheme;
 }
 
 #include "vaddr-test.h"
-- 
2.17.1

