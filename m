Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193AD26AB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgIOSHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:07:21 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:26906 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbgIOSDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600193022; x=1631729022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rU/hvNQ4KOXq6vAima+hbiKNVR2CLXhJJ3q5+iUMNvE=;
  b=ApauS6QFWFnVhnmTv0FpY2MPm4h0/CzZA21d0X0GJbq+vtx2dn8vr2XS
   0kyO+ALiuJ6S6mFwGuMVtGTmQ2Mdm4xJE6imc92Jvu2xJa9j1QEUNBSVa
   CwUjJGh/3mJtUzmvcpAgsSDz/XJpuo2vEqDvjkmmRzCG8o74//eUkSXUF
   I=;
X-IronPort-AV: E=Sophos;i="5.76,430,1592870400"; 
   d="scan'208";a="54124498"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 15 Sep 2020 18:03:32 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id B0500A2159;
        Tue, 15 Sep 2020 18:03:20 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.34) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 15 Sep 2020 18:03:00 +0000
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
Subject: [RFC PATCH 1/2] mm/damon: Put more information in kdamond thread name
Date:   Tue, 15 Sep 2020 20:02:23 +0200
Message-ID: <20200915180225.17439-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915180225.17439-1-sjpark@amazon.com>
References: <20200915180225.17439-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D06UWC004.ant.amazon.com (10.43.162.97) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

While multiple kdamond threads can run, it is hard to distinguish each
thread as all kdamond threads has same name, 'kdamond'.  This commit
puts more information including if it is spawned from the user context
(via the debugfs interface) and for what context it is running.  The
format of the name is:

    kdamond.<current pid>.<# of context>

If it is not spawned from the user context, <current pid> becomes 0.
Using this information, for example, the user space could easily account
CPU usage of DAMON that they requested in fine granularity.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon.c b/mm/damon.c
index c92e4c76aa53..abb8c07a4c7d 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1552,6 +1552,8 @@ static bool damon_kdamond_running(struct damon_ctx *ctx)
  * __damon_start() - Starts monitoring with given context.
  * @ctx:	monitoring context
  *
+ * This function should be called while damon_lock is hold.
+ *
  * Return: 0 on success, negative error code otherwise.
  */
 static int __damon_start(struct damon_ctx *ctx)
@@ -1562,7 +1564,8 @@ static int __damon_start(struct damon_ctx *ctx)
 	if (!ctx->kdamond) {
 		err = 0;
 		ctx->kdamond_stop = false;
-		ctx->kdamond = kthread_create(kdamond_fn, ctx, "kdamond");
+		ctx->kdamond = kthread_create(kdamond_fn, ctx, "kdamond.%d.%d",
+				current ? current->pid : 0, nr_running_ctxs);
 		if (IS_ERR(ctx->kdamond))
 			err = PTR_ERR(ctx->kdamond);
 		else
-- 
2.17.1

