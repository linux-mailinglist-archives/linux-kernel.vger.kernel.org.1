Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116B928593B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgJGHRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:17:11 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:48286 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgJGHRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602055030; x=1633591030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0TPx4DnhcZ8KiVDLDYWFNaniT35+H2YSfcBfIDd9jFc=;
  b=FknP0FPbkl92dUECnQrTyD6hD2sH8xsDLq5jsXKqFSEv2Xo6MIOUiqoO
   Us/ALCbJcmgKpZhgwUAPeGm5XbmDFsuMEI/hU5p4Zq3nfjlhir/CVSoD5
   FbIAQDJ3ph1p4e9Fr3uen3JzkC0Dblx8n9OOepqq4jlwgULk4lMY4vw7n
   s=;
X-IronPort-AV: E=Sophos;i="5.77,345,1596499200"; 
   d="scan'208";a="59960935"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 07 Oct 2020 07:17:09 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 9AF97A17C5;
        Wed,  7 Oct 2020 07:16:57 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.73) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 7 Oct 2020 07:16:41 +0000
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
Subject: [RFC v9 07/10] damon/dbgfs: Support physical memory monitoring
Date:   Wed, 7 Oct 2020 09:14:06 +0200
Message-ID: <20201007071409.12174-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007071409.12174-1-sjpark@amazon.com>
References: <20201007071409.12174-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D31UWA003.ant.amazon.com (10.43.160.130) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
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
 mm/damon/dbgfs.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 28076557ea86..8a80f4cc2fef 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -484,10 +484,19 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		return PTR_ERR(kbuf);
 
 	nrs = kbuf;
-
-	if (!strncmp(kbuf, "pidfd ", 6)) {
-		received_pidfds = true;
-		nrs = &kbuf[6];
+	if (!strncmp(kbuf, "paddr\n", count)) {
+		/* Configure the context for physical memory monitoring */
+		damon_pa_set_primitives(ctx);
+		/* target id is meaningless here, but we set it just for fun */
+		scnprintf(kbuf, count, "42    ");
+	} else {
+		/* Configure the context for virtual memory monitoring */
+		damon_va_set_primitives(ctx);
+
+		if (!strncmp(kbuf, "pidfd ", 6)) {
+			received_pidfds = true;
+			nrs = &kbuf[6];
+		}
 	}
 
 	targets = str_to_target_ids(nrs, ret, &nr_targets);
-- 
2.17.1

