Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2443825B0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgIBQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 12:06:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgIBQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:06:04 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082G2tgm121589;
        Wed, 2 Sep 2020 12:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qVxqqF7MISAKbhSWn1uUmoW1vitJe1aMnMtpxVUtGMc=;
 b=kTQ/fMgD8Ayq1rRTtN8pT+u4gfxW/FbWYyLNvkoOoLyKoXF5sBFIWTKmYbXafSy5/rft
 qri/JWLsKPHBbO8PgNpi004Cf71yma5r4JdbieuCy7tdjJ3H4iSqbl6DSlXXVxeuSi2a
 Lf7bvwDn5Pylt5fB74go724Icf9fYtwagabpp6wcrMqu3BYIUg0cIgetcdiFwEmwqVOb
 hEvufMjrVO/XvR3VZRki2oRPoMffwSifmNGFqqM816QnnEN70qwlZiuCuxMICPrxro8q
 71xvliPQV045lppn1HJUFZq6Rp/zbWi2b9/S2lZ7nMVSijeEBeYwQb5eMT5QQNL5iXkD pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33aefs08yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 12:05:40 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 082G3Ohr125423;
        Wed, 2 Sep 2020 12:05:39 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33aefs08xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 12:05:39 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082G30T0003373;
        Wed, 2 Sep 2020 16:05:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 339ap7say3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 16:05:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 082G42Qv58655042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 16:04:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 388DCA404D;
        Wed,  2 Sep 2020 16:05:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 551E0A4059;
        Wed,  2 Sep 2020 16:05:29 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.83.99])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 16:05:29 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v7 2/5] perf/jevents: Add new structure to pass json fields.
Date:   Wed,  2 Sep 2020 21:34:36 +0530
Message-Id: <20200902160439.335232-3-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902160439.335232-1-kjain@linux.ibm.com>
References: <20200902160439.335232-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_09:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=4 mlxscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new structure called 'json_event' inside jevents.h
file to improve the callback prototype inside jevent files.
Initially, whenever user want to add new field, they need to update
in all function callback which make it more and more complex with
increased number of parmeters.
With this change, we just need to add it in new structure 'json_event'.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c | 214 +++++++++++++++-----------------
 1 file changed, 98 insertions(+), 116 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 558b6b6270da..388dd287d736 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -52,6 +52,23 @@
 int verbose;
 char *prog;
 
+struct json_event {
+	char *name;
+	char *event;
+	char *desc;
+	char *long_desc;
+	char *pmu;
+	char *unit;
+	char *perpkg;
+	char *metric_expr;
+	char *metric_name;
+	char *metric_group;
+	char *deprecated;
+	char *metric_constraint;
+};
+
+typedef int (*func)(void *data, struct json_event *je);
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 
@@ -70,11 +87,6 @@ int eprintf(int level, int var, const char *fmt, ...)
 	return ret;
 }
 
-__attribute__((weak)) char *get_cpu_str(void)
-{
-	return NULL;
-}
-
 static void addfield(char *map, char **dst, const char *sep,
 		     const char *a, jsmntok_t *bt)
 {
@@ -317,12 +329,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 	close_table = 1;
 }
 
-static int print_events_table_entry(void *data, char *name, char *event,
-				    char *desc, char *long_desc,
-				    char *pmu, char *unit, char *perpkg,
-				    char *metric_expr,
-				    char *metric_name, char *metric_group,
-				    char *deprecated, char *metric_constraint)
+static int print_events_table_entry(void *data, struct json_event *je)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -334,30 +341,30 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	 */
 	fprintf(outfp, "{\n");
 
-	if (name)
-		fprintf(outfp, "\t.name = \"%s\",\n", name);
-	if (event)
-		fprintf(outfp, "\t.event = \"%s\",\n", event);
-	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
+	if (je->name)
+		fprintf(outfp, "\t.name = \"%s\",\n", je->name);
+	if (je->event)
+		fprintf(outfp, "\t.event = \"%s\",\n", je->event);
+	fprintf(outfp, "\t.desc = \"%s\",\n", je->desc);
 	fprintf(outfp, "\t.topic = \"%s\",\n", topic);
-	if (long_desc && long_desc[0])
-		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
-	if (pmu)
-		fprintf(outfp, "\t.pmu = \"%s\",\n", pmu);
-	if (unit)
-		fprintf(outfp, "\t.unit = \"%s\",\n", unit);
-	if (perpkg)
-		fprintf(outfp, "\t.perpkg = \"%s\",\n", perpkg);
-	if (metric_expr)
-		fprintf(outfp, "\t.metric_expr = \"%s\",\n", metric_expr);
-	if (metric_name)
-		fprintf(outfp, "\t.metric_name = \"%s\",\n", metric_name);
-	if (metric_group)
-		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
-	if (deprecated)
-		fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
-	if (metric_constraint)
-		fprintf(outfp, "\t.metric_constraint = \"%s\",\n", metric_constraint);
+	if (je->long_desc && je->long_desc[0])
+		fprintf(outfp, "\t.long_desc = \"%s\",\n", je->long_desc);
+	if (je->pmu)
+		fprintf(outfp, "\t.pmu = \"%s\",\n", je->pmu);
+	if (je->unit)
+		fprintf(outfp, "\t.unit = \"%s\",\n", je->unit);
+	if (je->perpkg)
+		fprintf(outfp, "\t.perpkg = \"%s\",\n", je->perpkg);
+	if (je->metric_expr)
+		fprintf(outfp, "\t.metric_expr = \"%s\",\n", je->metric_expr);
+	if (je->metric_name)
+		fprintf(outfp, "\t.metric_name = \"%s\",\n", je->metric_name);
+	if (je->metric_group)
+		fprintf(outfp, "\t.metric_group = \"%s\",\n", je->metric_group);
+	if (je->deprecated)
+		fprintf(outfp, "\t.deprecated = \"%s\",\n", je->deprecated);
+	if (je->metric_constraint)
+		fprintf(outfp, "\t.metric_constraint = \"%s\",\n", je->metric_constraint);
 	fprintf(outfp, "},\n");
 
 	return 0;
@@ -379,17 +386,17 @@ struct event_struct {
 	char *metric_constraint;
 };
 
-#define ADD_EVENT_FIELD(field) do { if (field) {		\
-	es->field = strdup(field);				\
+#define ADD_EVENT_FIELD(field) do { if (je->field) {		\
+	es->field = strdup(je->field);				\
 	if (!es->field)						\
 		goto out_free;					\
 } } while (0)
 
 #define FREE_EVENT_FIELD(field) free(es->field)
 
-#define TRY_FIXUP_FIELD(field) do { if (es->field && !*field) {\
-	*field = strdup(es->field);				\
-	if (!*field)						\
+#define TRY_FIXUP_FIELD(field) do { if (es->field && !je->field) {\
+	je->field = strdup(es->field);				\
+	if (!je->field)						\
 		return -ENOMEM;					\
 } } while (0)
 
@@ -420,11 +427,7 @@ static void free_arch_std_events(void)
 	}
 }
 
-static int save_arch_std_events(void *data, char *name, char *event,
-				char *desc, char *long_desc, char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint)
+static int save_arch_std_events(void *data, struct json_event *je)
 {
 	struct event_struct *es;
 
@@ -484,11 +487,8 @@ static char *real_event(const char *name, char *event)
 }
 
 static int
-try_fixup(const char *fn, char *arch_std, char **event, char **desc,
-	  char **name, char **long_desc, char **pmu, char **filter,
-	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
-	  char **metric_group, unsigned long long eventcode,
-	  char **deprecated, char **metric_constraint)
+try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
+	  struct json_event *je)
 {
 	/* try to find matching event from arch standard values */
 	struct event_struct *es;
@@ -497,8 +497,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 		if (!strcmp(arch_std, es->name)) {
 			if (!eventcode && es->event) {
 				/* allow EventCode to be overridden */
-				free(*event);
-				*event = NULL;
+				free(je->event);
+				je->event = NULL;
 			}
 			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
 			return 0;
@@ -511,14 +511,9 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 }
 
 /* Call func with each event in the json file */
-int json_events(const char *fn,
-	  int (*func)(void *data, char *name, char *event, char *desc,
-		      char *long_desc,
-		      char *pmu, char *unit, char *perpkg,
-		      char *metric_expr,
-		      char *metric_name, char *metric_group,
-		      char *deprecated, char *metric_constraint),
-	  void *data)
+static int json_events(const char *fn,
+		int (*func)(void *data, struct json_event *je),
+			void *data)
 {
 	int err;
 	size_t size;
@@ -536,18 +531,10 @@ int json_events(const char *fn,
 	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
-		char *event = NULL, *desc = NULL, *name = NULL;
-		char *long_desc = NULL;
+		char *event = NULL;
 		char *extra_desc = NULL;
-		char *pmu = NULL;
 		char *filter = NULL;
-		char *perpkg = NULL;
-		char *unit = NULL;
-		char *metric_expr = NULL;
-		char *metric_name = NULL;
-		char *metric_group = NULL;
-		char *deprecated = NULL;
-		char *metric_constraint = NULL;
+		struct json_event je = {};
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
@@ -582,14 +569,14 @@ int json_events(const char *fn,
 				eventcode |= strtoul(code, NULL, 0) << 21;
 				free(code);
 			} else if (json_streq(map, field, "EventName")) {
-				addfield(map, &name, "", "", val);
+				addfield(map, &je.name, "", "", val);
 			} else if (json_streq(map, field, "BriefDescription")) {
-				addfield(map, &desc, "", "", val);
-				fixdesc(desc);
+				addfield(map, &je.desc, "", "", val);
+				fixdesc(je.desc);
 			} else if (json_streq(map, field,
 					     "PublicDescription")) {
-				addfield(map, &long_desc, "", "", val);
-				fixdesc(long_desc);
+				addfield(map, &je.long_desc, "", "", val);
+				fixdesc(je.long_desc);
 			} else if (json_streq(map, field, "PEBS") && nz) {
 				precise = val;
 			} else if (json_streq(map, field, "MSRIndex") && nz) {
@@ -609,34 +596,34 @@ int json_events(const char *fn,
 
 				ppmu = field_to_perf(unit_to_pmu, map, val);
 				if (ppmu) {
-					pmu = strdup(ppmu);
+					je.pmu = strdup(ppmu);
 				} else {
-					if (!pmu)
-						pmu = strdup("uncore_");
-					addfield(map, &pmu, "", "", val);
-					for (s = pmu; *s; s++)
+					if (!je.pmu)
+						je.pmu = strdup("uncore_");
+					addfield(map, &je.pmu, "", "", val);
+					for (s = je.pmu; *s; s++)
 						*s = tolower(*s);
 				}
-				addfield(map, &desc, ". ", "Unit: ", NULL);
-				addfield(map, &desc, "", pmu, NULL);
-				addfield(map, &desc, "", " ", NULL);
+				addfield(map, &je.desc, ". ", "Unit: ", NULL);
+				addfield(map, &je.desc, "", je.pmu, NULL);
+				addfield(map, &je.desc, "", " ", NULL);
 			} else if (json_streq(map, field, "Filter")) {
 				addfield(map, &filter, "", "", val);
 			} else if (json_streq(map, field, "ScaleUnit")) {
-				addfield(map, &unit, "", "", val);
+				addfield(map, &je.unit, "", "", val);
 			} else if (json_streq(map, field, "PerPkg")) {
-				addfield(map, &perpkg, "", "", val);
+				addfield(map, &je.perpkg, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
-				addfield(map, &deprecated, "", "", val);
+				addfield(map, &je.deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
-				addfield(map, &metric_name, "", "", val);
+				addfield(map, &je.metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
-				addfield(map, &metric_group, "", "", val);
+				addfield(map, &je.metric_group, "", "", val);
 			} else if (json_streq(map, field, "MetricConstraint")) {
-				addfield(map, &metric_constraint, "", "", val);
+				addfield(map, &je.metric_constraint, "", "", val);
 			} else if (json_streq(map, field, "MetricExpr")) {
-				addfield(map, &metric_expr, "", "", val);
-				for (s = metric_expr; *s; s++)
+				addfield(map, &je.metric_expr, "", "", val);
+				for (s = je.metric_expr; *s; s++)
 					*s = tolower(*s);
 			} else if (json_streq(map, field, "ArchStdEvent")) {
 				addfield(map, &arch_std, "", "", val);
@@ -645,7 +632,7 @@ int json_events(const char *fn,
 			}
 			/* ignore unknown fields */
 		}
-		if (precise && desc && !strstr(desc, "(Precise Event)")) {
+		if (precise && je.desc && !strstr(je.desc, "(Precise Event)")) {
 			if (json_streq(map, precise, "2"))
 				addfield(map, &extra_desc, " ",
 						"(Must be precise)", NULL);
@@ -655,48 +642,43 @@ int json_events(const char *fn,
 		}
 		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
 		addfield(map, &event, ",", buf, NULL);
-		if (desc && extra_desc)
-			addfield(map, &desc, " ", extra_desc, NULL);
-		if (long_desc && extra_desc)
-			addfield(map, &long_desc, " ", extra_desc, NULL);
+		if (je.desc && extra_desc)
+			addfield(map, &je.desc, " ", extra_desc, NULL);
+		if (je.long_desc && extra_desc)
+			addfield(map, &je.long_desc, " ", extra_desc, NULL);
 		if (filter)
 			addfield(map, &event, ",", filter, NULL);
 		if (msr != NULL)
 			addfield(map, &event, ",", msr->pname, msrval);
-		if (name)
-			fixname(name);
+		if (je.name)
+			fixname(je.name);
 
 		if (arch_std) {
 			/*
 			 * An arch standard event is referenced, so try to
 			 * fixup any unassigned values.
 			 */
-			err = try_fixup(fn, arch_std, &event, &desc, &name,
-					&long_desc, &pmu, &filter, &perpkg,
-					&unit, &metric_expr, &metric_name,
-					&metric_group, eventcode,
-					&deprecated, &metric_constraint);
+			err = try_fixup(fn, arch_std, eventcode, &je);
 			if (err)
 				goto free_strings;
 		}
-		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated, metric_constraint);
+		je.event = real_event(je.name, event);
+		err = func(data, &je);
 free_strings:
 		free(event);
-		free(desc);
-		free(name);
-		free(long_desc);
+		free(je.desc);
+		free(je.name);
+		free(je.long_desc);
 		free(extra_desc);
-		free(pmu);
+		free(je.pmu);
 		free(filter);
-		free(perpkg);
-		free(deprecated);
-		free(unit);
-		free(metric_expr);
-		free(metric_name);
-		free(metric_group);
-		free(metric_constraint);
+		free(je.perpkg);
+		free(je.deprecated);
+		free(je.unit);
+		free(je.metric_expr);
+		free(je.metric_name);
+		free(je.metric_group);
+		free(je.metric_constraint);
 		free(arch_std);
 
 		if (err)
-- 
2.26.2

