Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356982C8B21
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgK3RcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:32:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:3449 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387510AbgK3RcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:32:19 -0500
IronPort-SDR: rpNlXePmiX5bYTutbgHenqUnWljwexVHG7wTwrzrjj/9ai0KfpXL/me96wrTwFrqFiUClirOA4
 eVPawRA8gFMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151926514"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151926514"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 09:29:04 -0800
IronPort-SDR: IwRtHP6mu60EN9FHu7CRc8y6P6BOo/0Vi5pe3apEVRyVPyllo9/LQi1rYM43uybuAV0BaSLK+a
 /B1xg7/Q42BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="334736306"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2020 09:29:03 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 05/12] perf mem: Factor out a function to generate sort order
Date:   Mon, 30 Nov 2020 09:27:56 -0800
Message-Id: <20201130172803.2676-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130172803.2676-1-kan.liang@linux.intel.com>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
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

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-mem.c | 41 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index fdfbff7592f4..823742036ddb 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -298,11 +298,35 @@ static int report_raw_events(struct perf_mem *mem)
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
@@ -316,20 +340,9 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
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

