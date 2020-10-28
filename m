Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFE929DA68
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390273AbgJ1XVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgJ1XTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:19:24 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C7EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:19:23 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u127so1355339oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wIjhrssAiBDg/GkLmZoS0mFtmljZ0v4XQMutOe+GHHs=;
        b=j/Zycd4OcQN/6MVCLd6KQJ0aGo2E4uyI8jB5BYH+fkgtx7WL1R+hJxgUvFEi/p1Zjm
         Qwi7nMzNR+tMHrtUjZ9x+E/nmu7AcO2ZNqQZxfF4WEJ3CUzXzTTIjCvUu1n17uYzJYEw
         fiv2LB5UkkesJ1RFqI7zBoRA/Ii2dySGG2wy/qNiAJj3StbNdDvx7wqTdHxBRw0pvih3
         fsQKNs4aaPVLRcmLPuLUsuQhDZlWTIFh5XLZK3JFgiw5uH61Sub/89GBxEw82uRo9JdT
         6PS5zIzLkWf7dGDyuWXOIKskjH5DzQvGu7khktrZQwykE83qR345d/KRbRXCQvZQF9IQ
         9GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wIjhrssAiBDg/GkLmZoS0mFtmljZ0v4XQMutOe+GHHs=;
        b=eRzraS2h/cksrHGyF5AZC0FUtL9Itcb9gqwC+r5oh0ySZSflv7VCnz5Jk4SdurmfgL
         ChudClBaZsZ+XamLciy7IDPsiUGWm/tixRNjDQ09DzyoNRF3O1ZUkuWD6Oz7RkqOj4Q+
         YCDMK07ITkx9PiYMMVj121pJhbDsLq3vIqnAJbzayDQos95A8BcFQ3JpdnFHzlIlkrOu
         fpUN1sXvG06H3hXj9ylszv0pQzBqd9koBjuSXZ4w8NFORGz3YVpQf7iLvsRVQ7A06BEQ
         EOC9K3YWKGxLR2k04FurxA5EyMlyERBbACStt9eqnmFCR+x0irnC6pmWYMIdCh0+Rw+z
         j+SA==
X-Gm-Message-State: AOAM530N128hJUys9fAz+qXivCo+zXFz8YIFNWJTi8Fc/k5Ko/4mZPcv
        zR7sqG0Jq0Luwk1WNur2MDTvrOtg058Zj+Tc
X-Google-Smtp-Source: ABdhPJzJ+3PQl78egCx2uY0oKSXzWLtHnfR1btWr9nPTX9rxZSv2lyHGzB4bX7md6yQDkz/oHtM0WA==
X-Received: by 2002:a17:90a:1102:: with SMTP id d2mr5789627pja.178.1603867114673;
        Tue, 27 Oct 2020 23:38:34 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id nk13sm1256725pjb.1.2020.10.27.23.38.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:38:34 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?UTF-8?q?Andr=C3=A9=20Przywara?= <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/9] perf mem: Introduce weak function perf_mem_events__ptr()
Date:   Wed, 28 Oct 2020 14:38:06 +0800
Message-Id: <20201028063813.8562-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028063813.8562-1-leo.yan@linaro.org>
References: <20201028063813.8562-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different architectures might use different event or different event
parameters for memory profiling, this patch introduces weak function
perf_mem_events__ptr(), which allows to return back architecture
specific memory event.

Since the variable 'perf_mem_events' can be only accessed by the
function perf_mem_events__ptr(), marks the variable as 'static', this
allows the architectures to define its own memory event array.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c     | 18 ++++++++++++------
 tools/perf/builtin-mem.c     | 21 ++++++++++++++-------
 tools/perf/util/mem-events.c | 26 +++++++++++++++++++-------
 tools/perf/util/mem-events.h |  2 +-
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d5bea5d3cd51..4d1a08e38233 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2867,6 +2867,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	int ret;
 	bool all_user = false, all_kernel = false;
 	bool event_set = false;
+	struct perf_mem_event *e;
 	struct option options[] = {
 	OPT_CALLBACK('e', "event", &event_set, "event",
 		     "event selector. Use 'perf c2c record -e list' to list available events",
@@ -2894,11 +2895,15 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "record";
 
 	if (!event_set) {
-		perf_mem_events[PERF_MEM_EVENTS__LOAD].record  = true;
-		perf_mem_events[PERF_MEM_EVENTS__STORE].record = true;
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+		e->record = true;
+
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
+		e->record = true;
 	}
 
-	if (perf_mem_events[PERF_MEM_EVENTS__LOAD].record)
+	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+	if (e->record)
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
@@ -2906,12 +2911,13 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "--sample-cpu";
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		if (!perf_mem_events[j].record)
+		e = perf_mem_events__ptr(j);
+		if (!e->record)
 			continue;
 
-		if (!perf_mem_events[j].supported) {
+		if (!e->supported) {
 			pr_err("failed: event '%s' not supported\n",
-			       perf_mem_events[j].name);
+			       perf_mem_events__name(j));
 			free(rec_argv);
 			return -1;
 		}
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 3523279af6af..9a7df8d01296 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -64,6 +64,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	const char **rec_argv;
 	int ret;
 	bool all_user = false, all_kernel = false;
+	struct perf_mem_event *e;
 	struct option options[] = {
 	OPT_CALLBACK('e', "event", &mem, "event",
 		     "event selector. use 'perf mem record -e list' to list available events",
@@ -86,13 +87,18 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 	rec_argv[i++] = "record";
 
-	if (mem->operation & MEM_OPERATION_LOAD)
-		perf_mem_events[PERF_MEM_EVENTS__LOAD].record = true;
+	if (mem->operation & MEM_OPERATION_LOAD) {
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+		e->record = true;
+	}
 
-	if (mem->operation & MEM_OPERATION_STORE)
-		perf_mem_events[PERF_MEM_EVENTS__STORE].record = true;
+	if (mem->operation & MEM_OPERATION_STORE) {
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
+		e->record = true;
+	}
 
-	if (perf_mem_events[PERF_MEM_EVENTS__LOAD].record)
+	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+	if (e->record)
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
@@ -101,10 +107,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		rec_argv[i++] = "--phys-data";
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		if (!perf_mem_events[j].record)
+		e = perf_mem_events__ptr(j);
+		if (!e->record)
 			continue;
 
-		if (!perf_mem_events[j].supported) {
+		if (!e->supported) {
 			pr_err("failed: event '%s' not supported\n",
 			       perf_mem_events__name(j));
 			free(rec_argv);
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 35c8d175a9d2..7a5a0d699e27 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -17,7 +17,7 @@ unsigned int perf_mem_events__loads_ldlat = 30;
 
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
-struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
 	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
 };
@@ -28,19 +28,31 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
 
+struct perf_mem_event * __weak perf_mem_events__ptr(int i)
+{
+	if (i >= PERF_MEM_EVENTS__MAX)
+		return NULL;
+
+	return &perf_mem_events[i];
+}
+
 char * __weak perf_mem_events__name(int i)
 {
+	struct perf_mem_event *e = perf_mem_events__ptr(i);
+
+	if (!e)
+		return NULL;
+
 	if (i == PERF_MEM_EVENTS__LOAD) {
 		if (!mem_loads_name__init) {
 			mem_loads_name__init = true;
 			scnprintf(mem_loads_name, sizeof(mem_loads_name),
-				  perf_mem_events[i].name,
-				  perf_mem_events__loads_ldlat);
+				  e->name, perf_mem_events__loads_ldlat);
 		}
 		return mem_loads_name;
 	}
 
-	return (char *)perf_mem_events[i].name;
+	return (char *)e->name;
 }
 
 int perf_mem_events__parse(const char *str)
@@ -61,7 +73,7 @@ int perf_mem_events__parse(const char *str)
 
 	while (tok) {
 		for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-			struct perf_mem_event *e = &perf_mem_events[j];
+			struct perf_mem_event *e = perf_mem_events__ptr(j);
 
 			if (strstr(e->tag, tok))
 				e->record = found = true;
@@ -90,7 +102,7 @@ int perf_mem_events__init(void)
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		char path[PATH_MAX];
-		struct perf_mem_event *e = &perf_mem_events[j];
+		struct perf_mem_event *e = perf_mem_events__ptr(j);
 		struct stat st;
 
 		scnprintf(path, PATH_MAX, "%s/devices/%s",
@@ -108,7 +120,7 @@ void perf_mem_events__list(void)
 	int j;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		struct perf_mem_event *e = &perf_mem_events[j];
+		struct perf_mem_event *e = perf_mem_events__ptr(j);
 
 		fprintf(stderr, "%-13s%-*s%s\n",
 			e->tag,
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 904dad34f7f7..726a9c8103e4 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -31,13 +31,13 @@ enum {
 	PERF_MEM_EVENTS__MAX,
 };
 
-extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
 extern unsigned int perf_mem_events__loads_ldlat;
 
 int perf_mem_events__parse(const char *str);
 int perf_mem_events__init(void);
 
 char *perf_mem_events__name(int i);
+struct perf_mem_event *perf_mem_events__ptr(int i);
 
 void perf_mem_events__list(void);
 
-- 
2.17.1

