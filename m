Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF1B2B6F75
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbgKQT5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:57:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:48614 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbgKQT5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:57:35 -0500
IronPort-SDR: ZCaeSgsdJ/AxFkM165nze7m+Oplj2cHC95ed/sEdeBs2rEcjatEhap9OWaap7PX7Gz8UZoN01Y
 06HDmTU5eIMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150270474"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150270474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:57:32 -0800
IronPort-SDR: bi1F7sxK4X5gicZkkuDwW5LXZNsgy2jl0VbQZ/C5cNoLqnLPFvkdEhuODnTGxBINqC3Y2Y5RLm
 +Vutd6nzN2yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544188132"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2020 11:57:32 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 06/12] perf mem: Clean up output format
Date:   Tue, 17 Nov 2020 11:56:31 -0800
Message-Id: <20201117195637.6499-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117195637.6499-1-kan.liang@linux.intel.com>
References: <20201117195637.6499-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Now, "--phys-data" is the only option which impacts the output format.
A simple "if else" is enough to handle the option. But there will be
more options added, e.g. "--data-page-size", which also impact the
output format. The code will become too complex to be maintained.

Divide the big printf into several small pieces. Output the specific
piece only if the related option is applied.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-mem.c | 93 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 7fb04f41cd99..200ff7c9d7b7 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -147,7 +147,7 @@ dump_raw_samples(struct perf_tool *tool,
 {
 	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
 	struct addr_location al;
-	const char *fmt;
+	const char *fmt, *field_sep;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		fprintf(stderr, "problem processing %d event, skipping it.\n",
@@ -161,60 +161,41 @@ dump_raw_samples(struct perf_tool *tool,
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
 
-	if (mem->phys_addr) {
-		if (symbol_conf.field_sep) {
-			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s0x%016"PRIx64
-			      "%s%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
-		} else {
-			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
-			      "%s0x%016"PRIx64"%s%5"PRIu64"%s0x%06"PRIx64
-			      "%s%s:%s\n";
-			symbol_conf.field_sep = " ";
-		}
-
-		printf(fmt,
-			sample->pid,
-			symbol_conf.field_sep,
-			sample->tid,
-			symbol_conf.field_sep,
-			sample->ip,
-			symbol_conf.field_sep,
-			sample->addr,
-			symbol_conf.field_sep,
-			sample->phys_addr,
-			symbol_conf.field_sep,
-			sample->weight,
-			symbol_conf.field_sep,
-			sample->data_src,
-			symbol_conf.field_sep,
-			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
-			al.sym ? al.sym->name : "???");
+	field_sep = symbol_conf.field_sep;
+	if (field_sep) {
+		fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s";
 	} else {
-		if (symbol_conf.field_sep) {
-			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s%"PRIu64
-			      "%s0x%"PRIx64"%s%s:%s\n";
-		} else {
-			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
-			      "%s%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
-			symbol_conf.field_sep = " ";
-		}
+		fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64"%s";
+		symbol_conf.field_sep = " ";
+	}
+	printf(fmt,
+		sample->pid,
+		symbol_conf.field_sep,
+		sample->tid,
+		symbol_conf.field_sep,
+		sample->ip,
+		symbol_conf.field_sep,
+		sample->addr,
+		symbol_conf.field_sep);
 
-		printf(fmt,
-			sample->pid,
-			symbol_conf.field_sep,
-			sample->tid,
-			symbol_conf.field_sep,
-			sample->ip,
-			symbol_conf.field_sep,
-			sample->addr,
-			symbol_conf.field_sep,
-			sample->weight,
-			symbol_conf.field_sep,
-			sample->data_src,
-			symbol_conf.field_sep,
-			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
-			al.sym ? al.sym->name : "???");
+	if (mem->phys_addr) {
+		printf("0x%016"PRIx64"%s",
+			sample->phys_addr,
+			symbol_conf.field_sep);
 	}
+
+	if (field_sep)
+		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
+	else
+		fmt = "%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
+
+	printf(fmt,
+		sample->weight,
+		symbol_conf.field_sep,
+		sample->data_src,
+		symbol_conf.field_sep,
+		al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
+		al.sym ? al.sym->name : "???");
 out_put:
 	addr_location__put(&al);
 	return 0;
@@ -254,10 +235,12 @@ static int report_raw_events(struct perf_mem *mem)
 	if (ret < 0)
 		goto out_delete;
 
+	printf("# PID, TID, IP, ADDR, ");
+
 	if (mem->phys_addr)
-		printf("# PID, TID, IP, ADDR, PHYS ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
-	else
-		printf("# PID, TID, IP, ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
+		printf("PHYS ADDR, ");
+
+	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
 
 	ret = perf_session__process_events(session);
 
-- 
2.17.1

