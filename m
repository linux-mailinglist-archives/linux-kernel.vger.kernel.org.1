Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4E828345B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgJEK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:58:32 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:18963 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJEK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601895512; x=1633431512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sovS4fsavcCCXLTzHaW2dVDQJFnArtjht8C/IMsjG80=;
  b=q28zzBMCKpf9I6mi5/3FxdXpVLnd8SI28tr3V5Ce6+WgGpr4DtrJbgBx
   8N2waPkqGgaht23BdB/qofSMd+PO5dxuRJhPnryjCJyWem1Hnw423HCTE
   XV2eGHl+vXPgddyo1oyy0yV3BHYZyzcn0kp2s3aNJ0f44ib/F/cuMEWKl
   8=;
X-IronPort-AV: E=Sophos;i="5.77,338,1596499200"; 
   d="scan'208";a="80357873"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Oct 2020 10:58:27 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id B07C9A1F92;
        Mon,  5 Oct 2020 10:58:14 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.146) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 5 Oct 2020 10:57:58 +0000
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
Subject: [PATCH v21 08/18] mm/damon/primitives: Make coexistable with Idle Page Tracking
Date:   Mon, 5 Oct 2020 12:55:12 +0200
Message-ID: <20201005105522.23841-9-sjpark@amazon.com>
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
index 6c8cb66866ac..9f33677e4807 100644
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

