Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E8329375D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392258AbgJTJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:01:11 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:1698 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392186AbgJTJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603184470; x=1634720470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kYfu257hraDIVWnN2ur3f67o7iLdxFJlqqlPASzOVSA=;
  b=SXTGRVDDFPhrNmI8YOEPKeFEa9XprJEhazZMkgGRFqPe5UeJBjeX4RPt
   Cd0YL0adhb7Vuh6kBUUdi/hiCqsTSl4y5qtdv2a1AyNWSZ9ZOgPRJqeuc
   Ft7Rq5v9ep3O2OgfuvIgDeEMBoDnABrHcAX08hI4r3JtpqnjvoAkCYmKw
   U=;
X-IronPort-AV: E=Sophos;i="5.77,396,1596499200"; 
   d="scan'208";a="60707311"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 20 Oct 2020 09:01:01 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 3998FA202F;
        Tue, 20 Oct 2020 09:00:54 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 20 Oct 2020 09:00:32 +0000
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
Subject: [PATCH v22 01/18] mm: Introduce Data Access MONitor (DAMON)
Date:   Tue, 20 Oct 2020 10:59:23 +0200
Message-ID: <20201020085940.13875-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020085940.13875-1-sjpark@amazon.com>
References: <20201020085940.13875-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D41UWC001.ant.amazon.com (10.43.162.107) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON is a data access monitoring framework for the Linux kernel.  The
core mechanisms of DAMON make it

 - accurate (the monitoring output is useful enough for DRAM level
   performance-centric memory management; It might be inappropriate for
   CPU Cache levels, though),
 - light-weight (the monitoring overhead is normally low enough to be
   applied online), and
 - scalable (the upper-bound of the overhead is in constant range
   regardless of the size of target workloads).

Using this framework, hence, we can easily write efficient kernel space
data access monitoring applications.  For example, the kernel's memory
management mechanisms can make advanced decisions using this.
Experimental data access aware optimization works that incurring high
access monitoring overhead could implemented again on top of this.

Due to its simple and flexible interface, providing user space interface
would be also easy.  Then, user space users who have some special
workloads can write personalized applications for better understanding
and optimizations of their workloads and systems.

That said, this commit is implementing only basic data structures and
simple manipulation functions of the structures.  The core mechanisms of
DAMON will be implemented by following commits.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
Reviewed-by: Varad Gautam <vrd@amazon.de>
---
 include/linux/damon.h |  95 +++++++++++++++++++++++++++++++++
 mm/Kconfig            |   2 +
 mm/Makefile           |   1 +
 mm/damon/Kconfig      |  15 ++++++
 mm/damon/Makefile     |   3 ++
 mm/damon/core.c       | 121 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 237 insertions(+)
 create mode 100644 include/linux/damon.h
 create mode 100644 mm/damon/Kconfig
 create mode 100644 mm/damon/Makefile
 create mode 100644 mm/damon/core.c

diff --git a/include/linux/damon.h b/include/linux/damon.h
new file mode 100644
index 000000000000..183e0edd7f43
--- /dev/null
+++ b/include/linux/damon.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DAMON api
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#ifndef _DAMON_H_
+#define _DAMON_H_
+
+#include <linux/types.h>
+
+/**
+ * struct damon_addr_range - Represents an address region of [@start, @end).
+ * @start:	Start address of the region (inclusive).
+ * @end:	End address of the region (exclusive).
+ */
+struct damon_addr_range {
+	unsigned long start;
+	unsigned long end;
+};
+
+/**
+ * struct damon_region - Represents a monitoring target region.
+ * @ar:			The address range of the region.
+ * @nr_accesses:	Access frequency of this region.
+ * @list:		List head for siblings.
+ */
+struct damon_region {
+	struct damon_addr_range ar;
+	unsigned int nr_accesses;
+	struct list_head list;
+};
+
+/**
+ * struct damon_target - Represents a monitoring target.
+ * @id:			Unique identifier for this target.
+ * @regions_list:	Head of the monitoring target regions of this target.
+ * @list:		List head for siblings.
+ *
+ * Each monitoring context could have multiple targets.  For example, a context
+ * for virtual memory address spaces could have multiple target processes.  The
+ * @id of each target should be unique among the targets of the context.  For
+ * example, in the virtual address monitoring context, it could be a pidfd or
+ * an address of an mm_struct.
+ */
+struct damon_target {
+	unsigned long id;
+	struct list_head regions_list;
+	struct list_head list;
+};
+
+/**
+ * struct damon_ctx - Represents a context for each monitoring.
+ * @targets_list:	Head of monitoring targets (&damon_target) list.
+ */
+struct damon_ctx {
+	struct list_head targets_list;	/* 'damon_target' objects */
+};
+
+#define damon_next_region(r) \
+	(container_of(r->list.next, struct damon_region, list))
+
+#define damon_prev_region(r) \
+	(container_of(r->list.prev, struct damon_region, list))
+
+#define damon_for_each_region(r, t) \
+	list_for_each_entry(r, &t->regions_list, list)
+
+#define damon_for_each_region_safe(r, next, t) \
+	list_for_each_entry_safe(r, next, &t->regions_list, list)
+
+#define damon_for_each_target(t, ctx) \
+	list_for_each_entry(t, &(ctx)->targets_list, list)
+
+#define damon_for_each_target_safe(t, next, ctx) \
+	list_for_each_entry_safe(t, next, &(ctx)->targets_list, list)
+
+#ifdef CONFIG_DAMON
+
+struct damon_region *damon_new_region(unsigned long start, unsigned long end);
+inline void damon_insert_region(struct damon_region *r,
+		struct damon_region *prev, struct damon_region *next);
+void damon_add_region(struct damon_region *r, struct damon_target *t);
+void damon_destroy_region(struct damon_region *r);
+
+struct damon_target *damon_new_target(unsigned long id);
+void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
+void damon_free_target(struct damon_target *t);
+void damon_destroy_target(struct damon_target *t);
+unsigned int damon_nr_regions(struct damon_target *t);
+
+#endif	/* CONFIG_DAMON */
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 6c974888f86f..19fe2251c87a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -868,4 +868,6 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+source "mm/damon/Kconfig"
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index d5649f1c12c0..5d969d09521b 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -121,3 +121,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_DAMON) += damon/
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
new file mode 100644
index 000000000000..d00e99ac1a15
--- /dev/null
+++ b/mm/damon/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Data Access Monitoring"
+
+config DAMON
+	bool "DAMON: Data Access Monitoring Framework"
+	help
+	  This builds a framework that allows kernel subsystems to monitor
+	  access frequency of each memory region. The information can be useful
+	  for performance-centric DRAM level memory management.
+
+	  See https://damonitor.github.io/doc/html/latest-damon/index.html for
+	  more information.
+
+endmenu
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
new file mode 100644
index 000000000000..4fd2edb4becf
--- /dev/null
+++ b/mm/damon/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DAMON)		:= core.o
diff --git a/mm/damon/core.c b/mm/damon/core.c
new file mode 100644
index 000000000000..4562b2458719
--- /dev/null
+++ b/mm/damon/core.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Access Monitor
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#define pr_fmt(fmt) "damon: " fmt
+
+#include <linux/damon.h>
+#include <linux/slab.h>
+
+/*
+ * Functions and macros for DAMON data structures
+ */
+
+/*
+ * Construct a damon_region struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+struct damon_region *damon_new_region(unsigned long start, unsigned long end)
+{
+	struct damon_region *region;
+
+	region = kmalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return NULL;
+
+	region->ar.start = start;
+	region->ar.end = end;
+	region->nr_accesses = 0;
+	INIT_LIST_HEAD(&region->list);
+
+	return region;
+}
+
+/*
+ * Add a region between two other regions
+ */
+inline void damon_insert_region(struct damon_region *r,
+		struct damon_region *prev, struct damon_region *next)
+{
+	__list_add(&r->list, &prev->list, &next->list);
+}
+
+void damon_add_region(struct damon_region *r, struct damon_target *t)
+{
+	list_add_tail(&r->list, &t->regions_list);
+}
+
+static void damon_del_region(struct damon_region *r)
+{
+	list_del(&r->list);
+}
+
+static void damon_free_region(struct damon_region *r)
+{
+	kfree(r);
+}
+
+void damon_destroy_region(struct damon_region *r)
+{
+	damon_del_region(r);
+	damon_free_region(r);
+}
+
+/*
+ * Construct a damon_target struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+struct damon_target *damon_new_target(unsigned long id)
+{
+	struct damon_target *t;
+
+	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+
+	t->id = id;
+	INIT_LIST_HEAD(&t->regions_list);
+
+	return t;
+}
+
+void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
+{
+	list_add_tail(&t->list, &ctx->targets_list);
+}
+
+static void damon_del_target(struct damon_target *t)
+{
+	list_del(&t->list);
+}
+
+void damon_free_target(struct damon_target *t)
+{
+	struct damon_region *r, *next;
+
+	damon_for_each_region_safe(r, next, t)
+		damon_free_region(r);
+	kfree(t);
+}
+
+void damon_destroy_target(struct damon_target *t)
+{
+	damon_del_target(t);
+	damon_free_target(t);
+}
+
+unsigned int damon_nr_regions(struct damon_target *t)
+{
+	struct damon_region *r;
+	unsigned int nr_regions = 0;
+
+	damon_for_each_region(r, t)
+		nr_regions++;
+
+	return nr_regions;
+}
-- 
2.17.1

