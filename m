Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE192A964A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgKFMkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:40:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7606 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgKFMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:40:15 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSKjC4fF0zLvMc;
        Fri,  6 Nov 2020 20:39:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 20:39:57 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <irogers@google.com>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <linux-imx@nxp.com>,
        <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v5 02/13] perf jevents: Add support for system events tables
Date:   Fri, 6 Nov 2020 20:35:42 +0800
Message-ID: <1604666153-4187-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
References: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process the JSONs to find support for "system" events, which are not tied
to a specific CPUID.

A "COMPAT" property is now used to match against the namespace ID from the
kernel PMU driver.

The generated pmu-events.c will now have 2 tables:
a. CPU events, as before.
b. New pmu_sys_event_tables[] table, which will have events matched to
   specific SoCs.

It will look like this:

struct pmu_event pme_hisilicon_hip08_sys[] = {
{
	.name = "cycles",
	.compat = "0x00030736",
	.event = "event=0",
	.desc = "Clock cycles",
	.topic = "smmu v3 pmcg",
	.long_desc = "Clock cycles",
},
{
	.name = "smmuv3_pmcg.l1_tlb",
	.compat = "0x00030736",
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
 tools/perf/pmu-events/jevents.c    | 74 +++++++++++++++++++++++++++++-
 tools/perf/pmu-events/pmu-events.h |  6 +++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9022216b1253..7a65fd2d25bb 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -55,6 +55,7 @@ char *prog;
 
 struct json_event {
 	char *name;
+	char *compat;
 	char *event;
 	char *desc;
 	char *long_desc;
@@ -82,6 +83,23 @@ enum aggr_mode_class convert(const char *aggr_mode)
 
 typedef int (*func)(void *data, struct json_event *je);
 
+static LIST_HEAD(sys_event_tables);
+
+struct sys_event_table {
+	struct list_head list;
+	char *soc_id;
+};
+
+static void free_sys_event_tables(void)
+{
+	struct sys_event_table *et, *next;
+
+	list_for_each_entry_safe(et, next, &sys_event_tables, list) {
+		free(et->soc_id);
+		free(et);
+	}
+}
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 
@@ -360,6 +378,8 @@ static int print_events_table_entry(void *data, struct json_event *je)
 	if (je->event)
 		fprintf(outfp, "\t.event = \"%s\",\n", je->event);
 	fprintf(outfp, "\t.desc = \"%s\",\n", je->desc);
+	if (je->compat)
+		fprintf(outfp, "\t.compat = \"%s\",\n", je->compat);
 	fprintf(outfp, "\t.topic = \"%s\",\n", topic);
 	if (je->long_desc && je->long_desc[0])
 		fprintf(outfp, "\t.long_desc = \"%s\",\n", je->long_desc);
@@ -390,6 +410,7 @@ struct event_struct {
 	struct list_head list;
 	char *name;
 	char *event;
+	char *compat;
 	char *desc;
 	char *long_desc;
 	char *pmu;
@@ -583,6 +604,8 @@ static int json_events(const char *fn,
 				free(code);
 			} else if (json_streq(map, field, "EventName")) {
 				addfield(map, &je.name, "", "", val);
+			} else if (json_streq(map, field, "Compat")) {
+				addfield(map, &je.compat, "", "", val);
 			} else if (json_streq(map, field, "BriefDescription")) {
 				addfield(map, &je.desc, "", "", val);
 				fixdesc(je.desc);
@@ -683,6 +706,7 @@ static int json_events(const char *fn,
 		free(event);
 		free(je.desc);
 		free(je.name);
+		free(je.compat);
 		free(je.long_desc);
 		free(extra_desc);
 		free(je.pmu);
@@ -747,6 +771,15 @@ static char *file_name_to_table_name(char *fname)
 	return tblname;
 }
 
+static bool is_sys_dir(char *fname)
+{
+	size_t len = strlen(fname), len2 = strlen("/sys");
+
+	if (len2 > len)
+		return false;
+	return !strcmp(fname+len-len2, "/sys");
+}
+
 static void print_mapping_table_prefix(FILE *outfp)
 {
 	fprintf(outfp, "struct pmu_events_map pmu_events_map[] = {\n");
@@ -781,6 +814,23 @@ static void print_mapping_test_table(FILE *outfp)
 	fprintf(outfp, "},\n");
 }
 
+static int process_system_event_tables(FILE *outfp)
+{
+	struct sys_event_table *sys_event_table;
+
+	fprintf(outfp, "\nstruct pmu_sys_events pmu_sys_event_tables[] = {");
+
+	list_for_each_entry(sys_event_table, &sys_event_tables, list) {
+		fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t},",
+			sys_event_table->soc_id);
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
@@ -1026,6 +1076,22 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 			return -1;
 		}
 
+		if (is_sys_dir(bname)) {
+			struct sys_event_table *sys_event_table;
+
+			sys_event_table = malloc(sizeof(*sys_event_table));
+			if (!sys_event_table)
+				return -1;
+
+			sys_event_table->soc_id = strdup(tblname);
+			if (!sys_event_table->soc_id) {
+				free(sys_event_table);
+				return -1;
+			}
+			list_add_tail(&sys_event_table->list,
+				      &sys_event_tables);
+		}
+
 		print_events_table_prefix(eventsfp, tblname);
 		return 0;
 	}
@@ -1185,10 +1251,16 @@ int main(int argc, char *argv[])
 	}
 
 	rc = process_mapfile(eventsfp, mapfile);
-	fclose(eventsfp);
 	if (rc) {
 		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
 		/* Make build fail */
+		ret = 1;
+		goto err_close_eventsfp;
+	}
+
+	rc = process_system_event_tables(eventsfp);
+	fclose(eventsfp);
+	if (rc) {
 		ret = 1;
 		goto err_out;
 	}
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 7da1a3743b77..d1172f6aebf1 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -12,6 +12,7 @@ enum aggr_mode_class {
  */
 struct pmu_event {
 	const char *name;
+	const char *compat;
 	const char *event;
 	const char *desc;
 	const char *topic;
@@ -43,10 +44,15 @@ struct pmu_events_map {
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
2.26.2

