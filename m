Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B82EB3CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbhAEUAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:00:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:12060 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbhAEUAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:00:16 -0500
IronPort-SDR: crDFpW3A47PTXT0eT5y8eZJnCsfJXVK78lLc/qx8XZFRlaJjeQ3iz80c3kMYxnnG+7St/21yig
 bYJQb0b6Ee7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="174594254"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="174594254"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 11:58:30 -0800
IronPort-SDR: n3jcd0p+EU7homeD09ODlfLKYQ0gI2au8uGQ3PFHzwWbR1244Bnf2u/l1SwxALmlGQLSvStV8w
 /WRRoe6fyL8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="421901278"
Received: from ssp-iclu-cdi187.jf.intel.com ([10.54.55.67])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2021 11:58:30 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com, mark.rutland@arm.com, will@kernel.org,
        mpe@ellerman.id.au, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 1/6] perf mem: Clean up output format
Date:   Tue,  5 Jan 2021 11:57:47 -0800
Message-Id: <20210105195752.43489-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105195752.43489-1-kan.liang@linux.intel.com>
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-mem.c | 93 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 823742036ddb..7d6ee2208709 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -172,7 +172,7 @@ dump_raw_samples(struct perf_tool *tool,
 {
 	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
 	struct addr_location al;
-	const char *fmt;
+	const char *fmt, *field_sep;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		fprintf(stderr, "problem processing %d event, skipping it.\n",
@@ -186,60 +186,41 @@ dump_raw_samples(struct perf_tool *tool,
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
@@ -287,10 +268,12 @@ static int report_raw_events(struct perf_mem *mem)
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
2.25.1

