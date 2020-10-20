Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB3D293782
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392335AbgJTJEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:04:08 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:35118 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390480AbgJTJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603184647; x=1634720647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ex0dyR52pQlWbtLTi7+DCeRnQUrgwEcr4wvrGWXwkYQ=;
  b=N59dxQVRDLccHIXz4MUOX2nfa18sYFbSmM+pQtqWZqBY6HncOF4l/nXw
   JYKnnx6PahFQQI4nmB254NV3lOX3rgjmrwn5vvPN+5kcJhPwYn50qTA5M
   31GixShz6c6a1UhLBGj7m5Wp31wz+yJYoQSIfI8Z2mq7YfKvM6tOBA8Ne
   o=;
X-IronPort-AV: E=Sophos;i="5.77,396,1596499200"; 
   d="scan'208";a="85042254"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Oct 2020 09:04:07 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com (Postfix) with ESMTPS id B46DAA88A7;
        Tue, 20 Oct 2020 09:04:02 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 20 Oct 2020 09:03:44 +0000
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
Subject: [PATCH v22 08/18] mm/damon/primitives: Make coexistable with Idle Page Tracking
Date:   Tue, 20 Oct 2020 10:59:30 +0200
Message-ID: <20201020085940.13875-9-sjpark@amazon.com>
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

DAMON's reference 'primitives' internally use 'PG_Idle' flag.  Because
the flag is also used by Idle Page Tracking but there was no way to
synchronize with it, the 'primitives' were configured to be exclusive
with Idle Page Tracking before.  However, as we can now synchronize with
Idle Page Tracking using 'idle_page_lock', this commit makes the
primitives to do the synchronization and coexistable with Idle Page
Tracking.

Note that the 'primitives' only require the users to do the
synchronization by themselves.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/page_idle.h | 2 ++
 mm/damon/Kconfig          | 2 +-
 mm/damon/primitives.c     | 7 +++++++
 mm/page_idle.c            | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

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
index 0d2a18ddb9d8..63b9c905b548 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -14,7 +14,7 @@ config DAMON
 
 config DAMON_PRIMITIVES
 	bool "Monitoring primitives for virtual address spaces monitoring"
-	depends on DAMON && MMU && !IDLE_PAGE_TRACKING
+	depends on DAMON && MMU
 	select PAGE_EXTENSION if !64BIT
 	select PAGE_IDLE_FLAG
 	help
diff --git a/mm/damon/primitives.c b/mm/damon/primitives.c
index 9b603ac0077c..59f4de703413 100644
--- a/mm/damon/primitives.c
+++ b/mm/damon/primitives.c
@@ -15,6 +15,10 @@
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 
+#ifndef CONFIG_IDLE_PAGE_TRACKING
+DEFINE_MUTEX(page_idle_lock);
+#endif
+
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define MIN_REGION PAGE_SIZE
 
@@ -552,6 +556,9 @@ bool damon_va_target_valid(struct damon_target *t)
 {
 	struct task_struct *task;
 
+	if (!mutex_is_locked(&page_idle_lock))
+		return false;
+
 	task = damon_get_task_struct(t);
 	if (task) {
 		put_task_struct(task);
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

