Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72A12DBDFF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgLPJuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:50:11 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:50677 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgLPJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608112210; x=1639648210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jk1a1eNXyHawqdXbc/seXg9Qwshk6tmctCaAv0I6QJY=;
  b=CjyE79m0mmFotSf8z/sB2FGeECkKmdo6TvzIqMkNkBsECzXc5qe+lA2B
   fLOArY9XNdSbTJy7hzYCQlcZ+6Yh0IvmJcVcr8qCsGhXhrgfjkaJPOHF6
   5+yOCTFnVB646TcoAkiFv8uPvXOdAQxjcP8IxRmbLR84B8qRR/yGWjVtY
   U=;
X-IronPort-AV: E=Sophos;i="5.78,424,1599523200"; 
   d="scan'208";a="903546665"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 16 Dec 2020 09:49:28 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com (Postfix) with ESMTPS id CCD37C1D03;
        Wed, 16 Dec 2020 09:45:57 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.31) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Dec 2020 09:45:24 +0000
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
Subject: [RFC v10 08/13] damon/dbgfs: Support physical memory monitoring
Date:   Wed, 16 Dec 2020 10:42:16 +0100
Message-ID: <20201216094221.11898-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216094221.11898-1-sjpark@amazon.com>
References: <20201216094221.11898-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.31]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit makes the 'damon-dbgfs' to support the physical memory
monitoring, in addition to the virtual memory monitoring.

Users can do the physical memory monitoring by writing a special
keyword, 'paddr\n' to the 'pids' debugfs file.  Then, DAMON will check
the special keyword and configure the monitoring context to run using
the primitives for physical memory.  This will internally add one fake
monitoring target process, which has target id 42.

Unlike the virtual memory monitoring, the monitoring target region will
not be automatically set.  Therefore, users should also set the
monitoring target address region using the 'init_regions' debugfs file.

Finally, the physical memory monitoring will not automatically
terminated.  The user should explicitly turn off the monitoring by
writing 'off' to the 'monitor_on' debugfs file.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/Kconfig | 2 +-
 mm/damon/dbgfs.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 89c06ac8c9eb..38f4cfce72dd 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -56,7 +56,7 @@ config DAMON_VADDR_KUNIT_TEST
 
 config DAMON_DBGFS
 	bool "DAMON debugfs interface"
-	depends on DAMON_VADDR && DEBUG_FS
+	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
 	help
 	  This builds the debugfs interface for DAMON.  The user space admins
 	  can use the interface for arbitrary data access monitoring.
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 2f1ec6ebd9f0..ea03d7d5b879 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -462,6 +462,15 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		return PTR_ERR(kbuf);
 
 	nrs = kbuf;
+	if (!strncmp(kbuf, "paddr\n", count)) {
+		/* Configure the context for physical memory monitoring */
+		damon_pa_set_primitives(ctx);
+		/* target id is meaningless here, but we set it just for fun */
+		scnprintf(kbuf, count, "42    ");
+	} else {
+		/* Configure the context for virtual memory monitoring */
+		damon_va_set_primitives(ctx);
+	}
 
 	targets = str_to_target_ids(nrs, ret, &nr_targets);
 	if (!targets) {
-- 
2.17.1

