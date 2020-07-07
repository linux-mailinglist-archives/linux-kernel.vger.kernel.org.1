Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D2D216CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGGMXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 08:23:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgGGMXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:23:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067C3xuI120941;
        Tue, 7 Jul 2020 08:23:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32482ku2vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 08:23:38 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 067C4GxY122500;
        Tue, 7 Jul 2020 08:23:38 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32482ku2ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 08:23:37 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067CL4tZ022057;
        Tue, 7 Jul 2020 12:23:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 322hd7sqvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 12:23:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067CNW0U64553402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 12:23:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25390AE056;
        Tue,  7 Jul 2020 12:23:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E8DBAE045;
        Tue,  7 Jul 2020 12:23:28 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.118.59])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 12:23:28 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com, kjain@linux.ibm.com
Subject: [RFC v2 1/5] perf/pmu-events/jevents: Add enum to store aggregation like PerPkg
Date:   Tue,  7 Jul 2020 17:53:10 +0530
Message-Id: <20200707122314.624400-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707122314.624400-1-kjain@linux.ibm.com>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_07:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=3 cotscore=-2147483648
 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially, every time we want to add new terms like chip, core, thread
etc, we need to create corrsponding fields in pmu_events and event
struct.
This patch adds an enum called 'aggr_mode_class' which store all these
aggregation like perpkg/percore. It also adds new field 'aggr_mode'
to capture these terms.
Now, if user wants to add any new term, they just need to add it in
the enum defined.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/pmu-events/jevents.c    | 39 +++++++++++++++++++-----------
 tools/perf/pmu-events/jevents.h    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  6 ++++-
 tools/perf/tests/pmu-events.c      |  8 +++---
 tools/perf/util/pmu.c              |  6 ++---
 5 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fa86c5f997cc..b2f59f0af63d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -53,6 +53,17 @@
 int verbose;
 char *prog;
 
+enum aggr_mode_class {
+	PerPkg = 1
+};
+
+enum aggr_mode_class convert(const char *aggr_mode)
+{
+	if (!strcmp(aggr_mode, "PerPkg"))
+		return PerPkg;
+	return -1;
+}
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 
@@ -320,7 +331,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 
 static int print_events_table_entry(void *data, char *name, char *event,
 				    char *desc, char *long_desc,
-				    char *pmu, char *unit, char *perpkg,
+				    char *pmu, char *unit, char *aggr_mode,
 				    char *metric_expr,
 				    char *metric_name, char *metric_group,
 				    char *deprecated, char *metric_constraint)
@@ -345,10 +356,10 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
 	if (pmu)
 		fprintf(outfp, "\t.pmu = \"%s\",\n", pmu);
+	if (aggr_mode)
+		fprintf(outfp, "\t.aggr_mode = \"%d\",\n", convert(aggr_mode));
 	if (unit)
 		fprintf(outfp, "\t.unit = \"%s\",\n", unit);
-	if (perpkg)
-		fprintf(outfp, "\t.perpkg = \"%s\",\n", perpkg);
 	if (metric_expr)
 		fprintf(outfp, "\t.metric_expr = \"%s\",\n", metric_expr);
 	if (metric_name)
@@ -372,7 +383,7 @@ struct event_struct {
 	char *long_desc;
 	char *pmu;
 	char *unit;
-	char *perpkg;
+	char *aggr_mode;
 	char *metric_expr;
 	char *metric_name;
 	char *metric_group;
@@ -401,7 +412,7 @@ struct event_struct {
 	op(long_desc);						\
 	op(pmu);						\
 	op(unit);						\
-	op(perpkg);						\
+	op(aggr_mode);					\
 	op(metric_expr);					\
 	op(metric_name);					\
 	op(metric_group);					\
@@ -423,7 +434,7 @@ static void free_arch_std_events(void)
 
 static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
+				char *unit, char *aggr_mode, char *metric_expr,
 				char *metric_name, char *metric_group,
 				char *deprecated, char *metric_constraint)
 {
@@ -487,7 +498,7 @@ static char *real_event(const char *name, char *event)
 static int
 try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
-	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
+	  char **aggr_mode, char **unit, char **metric_expr, char **metric_name,
 	  char **metric_group, unsigned long long eventcode,
 	  char **deprecated, char **metric_constraint)
 {
@@ -515,7 +526,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
 		      char *long_desc,
-		      char *pmu, char *unit, char *perpkg,
+		      char *pmu, char *unit, char *aggr_mode,
 		      char *metric_expr,
 		      char *metric_name, char *metric_group,
 		      char *deprecated, char *metric_constraint),
@@ -542,7 +553,7 @@ int json_events(const char *fn,
 		char *extra_desc = NULL;
 		char *pmu = NULL;
 		char *filter = NULL;
-		char *perpkg = NULL;
+		char *aggr_mode = NULL;
 		char *unit = NULL;
 		char *metric_expr = NULL;
 		char *metric_name = NULL;
@@ -625,8 +636,8 @@ int json_events(const char *fn,
 				addfield(map, &filter, "", "", val);
 			} else if (json_streq(map, field, "ScaleUnit")) {
 				addfield(map, &unit, "", "", val);
-			} else if (json_streq(map, field, "PerPkg")) {
-				addfield(map, &perpkg, "", "", val);
+			} else if (json_streq(map, field, "AggregationMode")) {
+				addfield(map, &aggr_mode, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
 				addfield(map, &deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
@@ -673,7 +684,7 @@ int json_events(const char *fn,
 			 * fixup any unassigned values.
 			 */
 			err = try_fixup(fn, arch_std, &event, &desc, &name,
-					&long_desc, &pmu, &filter, &perpkg,
+					&long_desc, &pmu, &filter, &aggr_mode,
 					&unit, &metric_expr, &metric_name,
 					&metric_group, eventcode,
 					&deprecated, &metric_constraint);
@@ -681,7 +692,7 @@ int json_events(const char *fn,
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name,
+			   pmu, unit, aggr_mode, metric_expr, metric_name,
 			   metric_group, deprecated, metric_constraint);
 free_strings:
 		free(event);
@@ -691,7 +702,7 @@ int json_events(const char *fn,
 		free(extra_desc);
 		free(pmu);
 		free(filter);
-		free(perpkg);
+		free(aggr_mode);
 		free(deprecated);
 		free(unit);
 		free(metric_expr);
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 2afc8304529e..63e72c0c312f 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -6,7 +6,7 @@ int json_events(const char *fn,
 		int (*func)(void *data, char *name, char *event, char *desc,
 				char *long_desc,
 				char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
+				char *unit, char *aggr_mode, char *metric_expr,
 				char *metric_name, char *metric_group,
 				char *deprecated, char *metric_constraint),
 		void *data);
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c8f306b572f4..71b7aa6278d0 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -2,6 +2,10 @@
 #ifndef PMU_EVENTS_H
 #define PMU_EVENTS_H
 
+enum aggr_mode_class {
+	PerPkg = 1
+};
+
 /*
  * Describe each PMU event. Each CPU has a table of PMU events.
  */
@@ -13,7 +17,7 @@ struct pmu_event {
 	const char *long_desc;
 	const char *pmu;
 	const char *unit;
-	const char *perpkg;
+	const char *aggr_mode;
 	const char *metric_expr;
 	const char *metric_name;
 	const char *metric_group;
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index ab64b4a4e284..51b9c0399611 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -206,10 +206,10 @@ static int test_pmu_event_table(void)
 				return -1;
 			}
 
-			if (!is_same(table->perpkg, te->perpkg)) {
-				pr_debug2("testing event table %s: mismatched perpkg, %s vs %s\n",
-					  table->name, table->perpkg,
-					  te->perpkg);
+			if (!is_same(table->aggr_mode, te->aggr_mode)) {
+				pr_debug2("testing event table %s: mismatched aggr_mode, %s vs %s\n",
+					  table->name, table->aggr_mode,
+					  te->aggr_mode);
 				return -1;
 			}
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 93fe72a9dc0b..3cafbb320d68 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -306,7 +306,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *desc, char *val,
 				 char *long_desc, char *topic,
-				 char *unit, char *perpkg,
+				 char *unit, char *aggr_mode,
 				 char *metric_expr,
 				 char *metric_name,
 				 char *deprecated)
@@ -378,7 +378,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 			return -1;
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
-	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
+	alias->per_pkg = aggr_mode && sscanf(aggr_mode, "%d", &num) == 1 && num == 1;
 	alias->str = strdup(newval);
 
 	if (deprecated)
@@ -776,7 +776,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
 				(char *)pe->desc, (char *)pe->event,
 				(char *)pe->long_desc, (char *)pe->topic,
-				(char *)pe->unit, (char *)pe->perpkg,
+				(char *)pe->unit, (char *)pe->aggr_mode,
 				(char *)pe->metric_expr,
 				(char *)pe->metric_name,
 				(char *)pe->deprecated);
-- 
2.26.2

