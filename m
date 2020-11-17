Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52A12B6F74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbgKQT5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:57:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:48614 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbgKQT5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:57:32 -0500
IronPort-SDR: BfaaBRqU4ccb8+V9JIp5Dexd4a4Kqh9cN8/FiH0R9QQu38tjr0Ui2d4wzYUiV6QG4uWi6HdVuy
 Nj355/b7KMPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150270471"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150270471"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:57:31 -0800
IronPort-SDR: Sa9bkql1dqesnIJ/miqf4qmuqNS0e23j0KXbH2KdG/s5Vwqa1x4rdDFRGPPFqudYV+G2St2nA7
 fi3EyC/7dnGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544188131"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2020 11:57:31 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 05/12] perf mem: Factor out a function to generate sort order
Date:   Tue, 17 Nov 2020 11:56:30 -0800
Message-Id: <20201117195637.6499-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117195637.6499-1-kan.liang@linux.intel.com>
References: <20201117195637.6499-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Now, "--phys-data" is the only option which impacts the sort order.
A simple "if else" is enough to handle the option. But there will be
more options added, e.g. "--data-page-size", which also impact the sort
order. The code will become too complex to be maintained.

Divide the sort order string into several small pieces.
The first piece is always the default sort string for LOAD/STORE.
Appends the specific sort string if related option is applied.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-mem.c | 41 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 3523279af6af..7fb04f41cd99 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -265,11 +265,35 @@ static int report_raw_events(struct perf_mem *mem)
 	perf_session__delete(session);
 	return ret;
 }
+static char *get_sort_order(struct perf_mem *mem)
+{
+	bool has_extra_options = mem->phys_addr ? true : false;
+	char sort[128];
+
+	/*
+	 * there is no weight (cost) associated with stores, so don't print
+	 * the column
+	 */
+	if (!(mem->operation & MEM_OPERATION_LOAD)) {
+		strcpy(sort, "--sort=mem,sym,dso,symbol_daddr,"
+			     "dso_daddr,tlb,locked");
+	} else if (has_extra_options) {
+		strcpy(sort, "--sort=local_weight,mem,sym,dso,symbol_daddr,"
+			     "dso_daddr,snoop,tlb,locked");
+	} else
+		return NULL;
+
+	if (mem->phys_addr)
+		strcat(sort, ",phys_daddr");
+
+	return strdup(sort);
+}
 
 static int report_events(int argc, const char **argv, struct perf_mem *mem)
 {
 	const char **rep_argv;
 	int ret, i = 0, j, rep_argc;
+	char *new_sort_order;
 
 	if (mem->dump_raw)
 		return report_raw_events(mem);
@@ -283,20 +307,9 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
 	rep_argv[i++] = "--mem-mode";
 	rep_argv[i++] = "-n"; /* display number of samples */
 
-	/*
-	 * there is no weight (cost) associated with stores, so don't print
-	 * the column
-	 */
-	if (!(mem->operation & MEM_OPERATION_LOAD)) {
-		if (mem->phys_addr)
-			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
-					"dso_daddr,tlb,locked,phys_daddr";
-		else
-			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
-					"dso_daddr,tlb,locked";
-	} else if (mem->phys_addr)
-		rep_argv[i++] = "--sort=local_weight,mem,sym,dso,symbol_daddr,"
-				"dso_daddr,snoop,tlb,locked,phys_daddr";
+	new_sort_order = get_sort_order(mem);
+	if (new_sort_order)
+		rep_argv[i++] = new_sort_order;
 
 	for (j = 1; j < argc; j++, i++)
 		rep_argv[i] = argv[j];
-- 
2.17.1

