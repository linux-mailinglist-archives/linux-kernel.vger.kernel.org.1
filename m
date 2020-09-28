Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735C627ABF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgI1KiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:38:12 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:20212 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgI1KiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601289491; x=1632825491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6GREaQYLw0Ho63BrhBcruGzxG22Apn0xI0E3Xv5Cu8Q=;
  b=DV6kV1ZsCtU0XeSG+du53H6tso3KaM6trzvS1zHSWPLWhLoZ/1bwb5g0
   5+DmT49KKAF1J21CbdJyRiEH7VWSJdaeCE7cHxfIiUaaqJKtqO3wExp1Y
   LL/gRjAKo7E4QRwhwN1qW4kh9jv87fnjz06iJyavS8NrtlXLl+JatGfI4
   A=;
X-IronPort-AV: E=Sophos;i="5.77,313,1596499200"; 
   d="scan'208";a="79768829"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 28 Sep 2020 10:38:07 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id B18CAA1EDC;
        Mon, 28 Sep 2020 10:37:54 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 28 Sep 2020 10:37:28 +0000
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
Subject: [RFC PATCH 5/5] mm/damon/primitives: Make coexistable with Idle Page Tracking
Date:   Mon, 28 Sep 2020 12:35:28 +0200
Message-ID: <20200928103528.4256-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928103528.4256-1-sjpark@amazon.com>
References: <20200928103528.4256-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D10UWA003.ant.amazon.com (10.43.160.248) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON's reference 'primitives' internally use 'PG_Idle' flag.  Because
the flag is also used by Idle Page Tracking but there was no way to
synchronize with it, the 'primitives' were configured to be exclusive
with Idle Page Tracking before.  However, as we can now synchronize with
Idle Page Tracking using 'idle_page_lock', this commit makes the
primitives to do the synchronization and coexistable with Idle Page
Tracking.

In more detail, the 'primitives' only require the users to do the
synchronization by themselves.  Real synchronization is done by the
DAMON debugfs interface, who is the only one user of the 'primitives' as
of now.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h     |  1 +
 include/linux/page_idle.h |  2 ++
 mm/damon/Kconfig          |  2 +-
 mm/damon/dbgfs.c          | 32 +++++++++++++++++++++++++++++++-
 mm/damon/primitives.c     | 16 +++++++++++++++-
 mm/page_idle.c            |  2 +-
 6 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 606e59f785a2..12200a1171a8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -312,6 +312,7 @@ void kdamond_init_phys_regions(struct damon_ctx *ctx);
 void kdamond_update_phys_regions(struct damon_ctx *ctx);
 void kdamond_prepare_phys_access_checks(struct damon_ctx *ctx);
 unsigned int kdamond_check_phys_accesses(struct damon_ctx *ctx);
+bool kdamond_phys_target_valid(struct damon_target *t);
 void damon_set_paddr_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_PRIMITIVES */
diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index d8a6aecf99cb..bcbb965b566c 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -8,6 +8,8 @@
 
 #ifdef CONFIG_PAGE_IDLE_FLAG
 
+extern struct mutex page_idle_lock;
+
 #ifdef CONFIG_64BIT
 static inline bool page_is_young(struct page *page)
 {
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 8b3f3dd3bd32..64d69a239408 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -26,7 +26,7 @@ config DAMON_KUNIT_TEST
 
 config DAMON_PRIMITIVES
 	bool "DAMON primitives for virtual/physical address spaces monitoring"
-	depends on DAMON && MMU && !IDLE_PAGE_TRACKING
+	depends on DAMON && MMU
 	select PAGE_EXTENSION if !64BIT
 	select PAGE_IDLE_FLAG
 	help
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 7a6c279690f8..ce12e92e1667 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -12,6 +12,7 @@
 #include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/page_idle.h>
 #include <linux/slab.h>
 
 #define MIN_RECORD_BUFFER_LEN	1024
@@ -28,6 +29,7 @@ struct debugfs_recorder {
 /* Monitoring contexts for debugfs interface users. */
 static struct damon_ctx **debugfs_ctxs;
 static int debugfs_nr_ctxs = 1;
+static int debugfs_nr_terminated_ctxs;
 
 static DEFINE_MUTEX(damon_dbgfs_lock);
 
@@ -106,9 +108,20 @@ static void debugfs_init_vm_regions(struct damon_ctx *ctx)
 	kdamond_init_vm_regions(ctx);
 }
 
+static void debugfs_unlock_page_idle_lock(void)
+{
+	mutex_lock(&damon_dbgfs_lock);
+	if (++debugfs_nr_terminated_ctxs == debugfs_nr_ctxs) {
+		debugfs_nr_terminated_ctxs = 0;
+		mutex_unlock(&page_idle_lock);
+	}
+	mutex_unlock(&damon_dbgfs_lock);
+}
+
 static void debugfs_vm_cleanup(struct damon_ctx *ctx)
 {
 	debugfs_flush_rbuffer(ctx->private);
+	debugfs_unlock_page_idle_lock();
 	kdamond_vm_cleanup(ctx);
 }
 
@@ -120,6 +133,8 @@ static void debugfs_init_phys_regions(struct damon_ctx *ctx)
 static void debugfs_phys_cleanup(struct damon_ctx *ctx)
 {
 	debugfs_flush_rbuffer(ctx->private);
+	debugfs_unlock_page_idle_lock();
+
 }
 
 /*
@@ -197,6 +212,21 @@ static char *user_input_str(const char __user *buf, size_t count, loff_t *ppos)
 	return kbuf;
 }
 
+static int debugfs_start_ctx_ptrs(struct damon_ctx **ctxs, int nr_ctxs)
+{
+	int rc;
+
+	if (!mutex_trylock(&page_idle_lock))
+		return -EBUSY;
+
+	rc = damon_start_ctx_ptrs(ctxs, nr_ctxs);
+	if (rc)
+		mutex_unlock(&page_idle_lock);
+
+	return rc;
+}
+
+
 static ssize_t debugfs_monitor_on_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
@@ -212,7 +242,7 @@ static ssize_t debugfs_monitor_on_write(struct file *file,
 	if (sscanf(kbuf, "%s", kbuf) != 1)
 		return -EINVAL;
 	if (!strncmp(kbuf, "on", count))
-		err = damon_start_ctx_ptrs(debugfs_ctxs, debugfs_nr_ctxs);
+		err = debugfs_start_ctx_ptrs(debugfs_ctxs, debugfs_nr_ctxs);
 	else if (!strncmp(kbuf, "off", count))
 		err = damon_stop_ctx_ptrs(debugfs_ctxs, debugfs_nr_ctxs);
 	else
diff --git a/mm/damon/primitives.c b/mm/damon/primitives.c
index e762dc8a5f2e..442b41b79b82 100644
--- a/mm/damon/primitives.c
+++ b/mm/damon/primitives.c
@@ -30,6 +30,10 @@
 
 #include "damon.h"
 
+#ifndef CONFIG_IDLE_PAGE_TRACKING
+DEFINE_MUTEX(page_idle_lock);
+#endif
+
 /* Minimal region size.  Every damon_region is aligned by this. */
 #ifndef CONFIG_DAMON_KUNIT_TEST
 #define MIN_REGION PAGE_SIZE
@@ -776,6 +780,9 @@ bool kdamond_vm_target_valid(struct damon_target *t)
 {
 	struct task_struct *task;
 
+	if (!mutex_is_locked(&page_idle_lock))
+		return false;
+
 	task = damon_get_task_struct(t);
 	if (task) {
 		put_task_struct(task);
@@ -795,6 +802,13 @@ void kdamond_vm_cleanup(struct damon_ctx *ctx)
 	}
 }
 
+bool kdamond_phys_target_valid(struct damon_target *t)
+{
+	if (!mutex_is_locked(&page_idle_lock))
+		return false;
+	return true;
+}
+
 #ifndef CONFIG_ADVISE_SYSCALLS
 static int damos_madvise(struct damon_target *target, struct damon_region *r,
 			int behavior)
@@ -874,7 +888,7 @@ void damon_set_paddr_primitives(struct damon_ctx *ctx)
 	ctx->update_target_regions = kdamond_update_phys_regions;
 	ctx->prepare_access_checks = kdamond_prepare_phys_access_checks;
 	ctx->check_accesses = kdamond_check_phys_accesses;
-	ctx->target_valid = NULL;
+	ctx->target_valid = kdamond_phys_target_valid;
 	ctx->cleanup = NULL;
 	ctx->apply_scheme = NULL;
 }
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 0aa45f848570..958dcc18f6cd 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -16,7 +16,7 @@
 #define BITMAP_CHUNK_SIZE	sizeof(u64)
 #define BITMAP_CHUNK_BITS	(BITMAP_CHUNK_SIZE * BITS_PER_BYTE)
 
-static DEFINE_MUTEX(page_idle_lock);
+DEFINE_MUTEX(page_idle_lock);
 
 /*
  * Idle page tracking only considers user memory pages, for other types of
-- 
2.17.1

