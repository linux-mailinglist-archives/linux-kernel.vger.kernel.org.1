Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEBB2A9352
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgKFJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgKFJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:49:26 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:49:26 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so414516pls.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wIjhrssAiBDg/GkLmZoS0mFtmljZ0v4XQMutOe+GHHs=;
        b=phqu7L2XWVUq0w7ywlgnGKtvXYLUHrYXwVJSuI1pNY4bYdqsXn8rwwK7Wabi72OU18
         iT7yv/FYq5L9Zflu6h4L1o7HG2r8MPVEh6E+dC2iAXKlAGf/1CNdOY0aaE4elTyEpFmK
         DGCssDFu/1Ra3dsfW3C26EIow/obpDfJCZpgzA0EWcJ0hwwCOvci5MfMIMPvsupt7N6Q
         +DtTlESW1u22t80J1eWj/3uOr5NaMyTngNuwBmsyndWWRhyUD+7aZ8ZHZa3juySTjV6j
         gLi0meD5hUXA/jP82RvPSfQHg61s/gGt94tB3Rw+Qh8rF1OfRFw4OQ/Pnt56aQjcr9go
         YxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wIjhrssAiBDg/GkLmZoS0mFtmljZ0v4XQMutOe+GHHs=;
        b=FK4c75eNoVtk3JkrXgeBBUe8JHQoLNERU4pNxHOZ7e7A3M6ziLly0a05ZxmvITr3fF
         LpGSzIAotn4GsWIbrR+KxlWKMstS9xiTOzv5TT4iRmcfN71IozAVbNad8o1BBprK3P4W
         QqxAVm00SCGgK850Mz7dM4MLcJqSZfko/2/pKuY81EyfMnOj0VvdVZSgDUMSaazPm6C8
         Hftg1voS3IFeGld5SXQR6rCFBy23X2tZKsqSpsmBHBvQtA9e/Bb7VV4GC2lObHaPs8Bz
         SkLQF2OP/ZkTFfSpZaQXwGePsUh3H3IyEkfdsIn66NGfsz3WzfrDkl596WJ/DHjw3h4V
         66BQ==
X-Gm-Message-State: AOAM530qGgZSK9CoVWCEa/LbhAqDLrzkaX0cZWqY9mQHW28FWeP8dPec
        9am1evY8GHDWhLObmcDaFxxs3Q==
X-Google-Smtp-Source: ABdhPJxkRL9/ztxMvkS/jvpjGTFW/zAqpMhyplFGCHB8I9vXAS9wcTPI9h7xEgNVXFl6Lcr7NdPhdA==
X-Received: by 2002:a17:902:b585:b029:d6:87ca:40b7 with SMTP id a5-20020a170902b585b02900d687ca40b7mr1286139pls.24.1604656166288;
        Fri, 06 Nov 2020 01:49:26 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id b4sm1388801pfi.208.2020.11.06.01.49.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:49:25 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/9] perf mem: Introduce weak function perf_mem_events__ptr()
Date:   Fri,  6 Nov 2020 17:48:46 +0800
Message-Id: <20201106094853.21082-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
References: <20201106094853.21082-1-leo.yan@linaro.org>
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

