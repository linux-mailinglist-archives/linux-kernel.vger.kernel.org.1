Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10C1C89FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 14:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgEGMCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 08:02:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbgEGMCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:02:09 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE6AA736A79F3AC5E6AE;
        Thu,  7 May 2020 20:02:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 20:01:57 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <irogers@google.com>, <robin.murphy@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 02/12] perf jevents: Add support for system events tables
Date:   Thu, 7 May 2020 19:57:41 +0800
Message-ID: <1588852671-61996-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process the JSONs to find support for "system" events, which are not tied
to a specific CPUID.

We now use a "COMPAT" property to match against the namespace ID from the
kernel PMU driver.

The generated pmu-events.c will now have 2 tables: a. As before, we will
have the event table for CPU events. b. New pmu_sys_event_tables[] table,
which will have events matched to SoCs.

It will look like this:

struct pmu_event pme_hisilicon_hip08_sys[] = {
{
	.name = "cycles",
	.compat = "HIP08",
	.event = "event=0",
	.desc = "Clock cycles",
	.topic = "smmu v3 pmcg",
	.long_desc = "Clock cycles",
},
{
	.name = "smmuv3_pmcg.l1_tlb",
	.compat = "HIP08",
	.event = "event=0x8a",
	.desc = "SMMUv3 PMCG l1_tlb. Unit: smmuv3_pmcg ",
	.topic = "smmu v3 pmcg",
	.long_desc = "SMMUv3 PMCG l1_tlb",
	.pmu = "smmuv3_pmcg",
},
...
};

struct pmu_event pme_arm_cortex_a53[] = {
{
	.name = "ext_mem_req",
	.event = "event=0xc0",
	.desc = "External memory request",
	.topic = "memory",
},
{
	.name = "ext_mem_req_nc",
	.event = "event=0xc1",
	.desc = "Non-cacheable external memory request",
	.topic = "memory",
},
...
};

struct pmu_event pme_hisilicon_hip08_cpu[] = {
{
	.name = "l2d_cache_refill_wr",
	.event = "event=0x53",
	.desc = "L2D cache refill, write",
	.topic = "core imp def",
	.long_desc = "Attributable Level 2 data cache refill, write",
},
...
};

struct pmu_events_map pmu_events_map[] = {
{
	.cpuid = "0x00000000410fd030",
	.version = "v1",
	.type = "core",
	.table = pme_arm_cortex_a53
},
{
	.cpuid = "0x00000000480fd010",
	.version = "v1",
	.type = "core",
	.table = pme_hisilicon_hip08_cpu
},
	{
		.table = 0
	},
};

struct pmu_event pme_hisilicon_hip08_cpu[] = {
{
	.name = "uncore_hisi_l3c.rd_cpipe",
	.event = "event=0",
	.desc = "Total read accesses. Unit: hisi_sccl,l3c ",
	.topic = "uncore l3c",
	.long_desc = "Total read accesses",
	.pmu = "hisi_sccl,l3c",
},
{
	.name = "uncore_hisi_l3c.wr_cpipe",
	.event = "event=0x1",
	.desc = "Total write accesses. Unit: hisi_sccl,l3c ",
	.topic = "uncore l3c",
	.long_desc = "Total write accesses",
	.pmu = "hisi_sccl,l3c",
},
...
};


struct pmu_sys_events pmu_sys_event_tables[] = {
{
	.table = pme_hisilicon_hip08_sys,
},
...
};

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c    | 138 ++++++++++++++++++++++++++++---------
 tools/perf/pmu-events/jevents.h    |  11 ++-
 tools/perf/pmu-events/pmu-events.h |   6 ++
 3 files changed, 118 insertions(+), 37 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index c7868d0a7a6b..acb6b77bddc0 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -53,6 +53,23 @@
 int verbose;
 char *prog;
 
+static LIST_HEAD(sys_event_tables);
+
+struct sys_event_table {
+	struct list_head list;
+	char *name;
+};
+
+static void free_sys_event_tables(void)
+{
+	struct sys_event_table *et, *next;
+
+	list_for_each_entry_safe(et, next, &sys_event_tables, list) {
+		free(et->name);
+		free(et);
+	}
+}
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 
@@ -318,12 +335,12 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 	close_table = 1;
 }
 
-static int print_events_table_entry(void *data, char *name, char *event,
-				    char *desc, char *long_desc,
+static int print_events_table_entry(void *data, char *name, char *compat,
+				    char *event, char *desc, char *long_desc,
 				    char *pmu, char *unit, char *perpkg,
-				    char *metric_expr,
-				    char *metric_name, char *metric_group,
-				    char *deprecated, char *metric_constraint)
+				    char *metric_expr, char *metric_name,
+				    char *metric_group, char *deprecated,
+				    char *metric_constraint)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -337,6 +354,9 @@ static int print_events_table_entry(void *data, char *name, char *event,
 
 	if (name)
 		fprintf(outfp, "\t.name = \"%s\",\n", name);
+	if (compat)
+		fprintf(outfp, "\t.compat = \"%s\",\n", compat);
+
 	if (event)
 		fprintf(outfp, "\t.event = \"%s\",\n", event);
 	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
@@ -367,6 +387,7 @@ static int print_events_table_entry(void *data, char *name, char *event,
 struct event_struct {
 	struct list_head list;
 	char *name;
+	char *compat;
 	char *event;
 	char *desc;
 	char *long_desc;
@@ -421,11 +442,12 @@ static void free_arch_std_events(void)
 	}
 }
 
-static int save_arch_std_events(void *data, char *name, char *event,
-				char *desc, char *long_desc, char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint)
+static int save_arch_std_events(void *data, char *name, char *compat,
+				char *event, char *desc, char *long_desc,
+				char *pmu, char *unit, char *perpkg,
+				char *metric_expr, char *metric_name,
+				char *metric_group, char *deprecated,
+				char *metric_constraint)
 {
 	struct event_struct *es;
 
@@ -513,12 +535,11 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 
 /* Call func with each event in the json file */
 int json_events(const char *fn,
-	  int (*func)(void *data, char *name, char *event, char *desc,
-		      char *long_desc,
-		      char *pmu, char *unit, char *perpkg,
-		      char *metric_expr,
-		      char *metric_name, char *metric_group,
-		      char *deprecated, char *metric_constraint),
+	  int (*func)(void *data, char *name, char *compat, char *event,
+		      char *desc, char *long_desc, char *pmu, char *unit,
+		      char *perpkg, char *metric_expr, char *metric_name,
+		      char *metric_group, char *deprecated,
+		      char *metric_constraint),
 	  void *data)
 {
 	int err;
@@ -537,7 +558,7 @@ int json_events(const char *fn,
 	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
-		char *event = NULL, *desc = NULL, *name = NULL;
+		char *event = NULL, *desc = NULL, *name = NULL, *compat = NULL;
 		char *long_desc = NULL;
 		char *extra_desc = NULL;
 		char *pmu = NULL;
@@ -584,6 +605,8 @@ int json_events(const char *fn,
 				free(code);
 			} else if (json_streq(map, field, "EventName")) {
 				addfield(map, &name, "", "", val);
+			} else if (json_streq(map, field, "Compat")) {
+				addfield(map, &compat, "", "", val);
 			} else if (json_streq(map, field, "BriefDescription")) {
 				addfield(map, &desc, "", "", val);
 				fixdesc(desc);
@@ -680,13 +703,15 @@ int json_events(const char *fn,
 			if (err)
 				goto free_strings;
 		}
-		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated, metric_constraint);
+		err = func(data, name, compat, real_event(name, event), desc,
+			   long_desc, pmu, unit, perpkg, metric_expr,
+			   metric_name, metric_group, deprecated,
+			   metric_constraint);
 free_strings:
+		free(name);
+		free(compat);
 		free(event);
 		free(desc);
-		free(name);
 		free(long_desc);
 		free(extra_desc);
 		free(pmu);
@@ -750,6 +775,25 @@ static char *file_name_to_table_name(char *fname)
 	return tblname;
 }
 
+static bool is_sys_dir(char *fname)
+{
+	char *pos;
+
+	while (true) {
+		pos = strchr(fname, '/');
+
+		if (!pos) {
+			if (!strcmp(fname, "sys"))
+				return true;
+			return false;
+		}
+
+		fname = pos + 1;
+	}
+
+	return false;
+}
+
 static void print_mapping_table_prefix(FILE *outfp)
 {
 	fprintf(outfp, "struct pmu_events_map pmu_events_map[] = {\n");
@@ -784,6 +828,23 @@ static void print_mapping_test_table(FILE *outfp)
 	fprintf(outfp, "},\n");
 }
 
+static int process_system_event_tables(FILE *outfp)
+{
+	struct sys_event_table *sys_event_table;
+
+	fprintf(outfp, "struct pmu_sys_events pmu_sys_event_tables[] = {");
+
+	list_for_each_entry(sys_event_table, &sys_event_tables, list) {
+		fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t},",
+			sys_event_table->name);
+	}
+	fprintf(outfp, "\n\t{\n\t\t.table = 0\n\t},");
+
+	fprintf(outfp, "\n};\n");
+
+	return 0;
+}
+
 static int process_mapfile(FILE *outfp, char *fpath)
 {
 	int n = 16384;
@@ -1029,6 +1090,18 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 			return -1;
 		}
 
+		if (is_sys_dir(bname)) {
+			struct sys_event_table *sys_event_table;
+
+			sys_event_table = malloc(sizeof(*sys_event_table));
+			if (!sys_event_table)
+				return -1;
+
+			sys_event_table->name = strdup(tblname);
+			list_add_tail(&sys_event_table->list,
+				      &sys_event_tables);
+		}
+
 		print_events_table_prefix(eventsfp, tblname);
 		return 0;
 	}
@@ -1180,7 +1253,6 @@ int main(int argc, char *argv[])
 	} else if (rc < 0) {
 		/* Make build fail */
 		fclose(eventsfp);
-		free_arch_std_events();
 		ret = 1;
 		goto out_free_mapfile;
 	} else if (rc) {
@@ -1206,27 +1278,31 @@ int main(int argc, char *argv[])
 	if (close_table)
 		print_events_table_suffix(eventsfp);
 
-	if (!mapfile) {
-		pr_info("%s: No CPU->JSON mapping?\n", prog);
-		goto empty_map;
+	if (mapfile) {
+		if (process_mapfile(eventsfp, mapfile)) {
+			pr_err("%s: Error processing mapfile %s\n", prog,
+			       mapfile);
+			/* Make build fail */
+			fclose(eventsfp);
+			ret = 1;
+		}
+	} else {
+		pr_err("%s: No CPU->JSON mapping?\n", prog);
 	}
 
-	if (process_mapfile(eventsfp, mapfile)) {
-		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
-		/* Make build fail */
+	if (process_system_event_tables(eventsfp)) {
 		fclose(eventsfp);
-		free_arch_std_events();
 		ret = 1;
 	}
 
-
 	goto out_free_mapfile;
 
 empty_map:
 	fclose(eventsfp);
 	create_empty_mapping(output_file);
-	free_arch_std_events();
 out_free_mapfile:
+	free_arch_std_events();
+	free_sys_event_tables();
 	free(mapfile);
 	return ret;
 }
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 2afc8304529e..7e324b210747 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -3,12 +3,11 @@
 #define JEVENTS_H 1
 
 int json_events(const char *fn,
-		int (*func)(void *data, char *name, char *event, char *desc,
-				char *long_desc,
-				char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint),
+		int (*func)(void *data, char *name, char *compat, char *event,
+			    char *desc, char *long_desc, char *pmu, char *unit,
+			    char *perpkg, char *metric_expr, char *metric_name,
+			    char *metric_group, char *deprecated,
+			    char *metric_constraint),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 53e76d5d5b37..cc6de8c5af49 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -7,6 +7,7 @@
  */
 struct pmu_event {
 	const char *name;
+	const char *compat;
 	const char *event;
 	const char *desc;
 	const char *topic;
@@ -37,10 +38,15 @@ struct pmu_events_map {
 	struct pmu_event *table;
 };
 
+struct pmu_sys_events {
+	struct pmu_event *table;
+};
+
 /*
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
 extern struct pmu_events_map pmu_events_map[];
+extern struct pmu_sys_events pmu_sys_event_tables[];
 
 #endif
-- 
2.16.4

