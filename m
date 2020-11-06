Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087ED2A9354
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgKFJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKFJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:49:34 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593C5C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:49:34 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q10so850017pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLoaN0bUGAjyACWGQ4ilg/aySDuWDCN5uiBqYD9NKjs=;
        b=lO8Ivpn/n53uM2t69MyoP4roRM3K7I1R9QqLKltABwYqaCduXTn0amu200lzE3WAXU
         sEr2SSuKNn+LpfeJaOsZaa7DzoJ57CcE65XLM8ju5DCSMrmn0ee5rZFmx3fXzW9XmJVo
         tIhvplRHG/BOS9bL5o25t/zwV0wNX3Sd/++0YceSuSVPoXJMSfnmeu+ZT5M5Ai3LOaEY
         kP2nKsppqZ0AT8k/m/0yj9J9UWBkf5HgnySlmjdDanQfj0/zyOyV8aGlU8O90c4cVP6p
         qbrvzLI/HakTKqjzCznJb1apgzGi8veHuf91XWSJEpyhvafGNFzmxon5M85q2oIbLvi/
         tT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLoaN0bUGAjyACWGQ4ilg/aySDuWDCN5uiBqYD9NKjs=;
        b=hfDYRhK44GjKwnB22HHXsSqRUNrlZN/1CoIj0JljqT9IROqi4wu8B+qn/EazhWofK0
         v3mofc0dBy7cJe+G7MDJWorxDvbE56YKpPhTsg25tYgpb40OQsnCOwcMtQ7zqJSTPZhf
         aGNR6t14Eg5b15Q/awQepzeumw60cLrjC0/Stm2qk90HRXH5tWLefd2wDjenUzxmP1wH
         ZSfHzS47piAoekfGnNuE4bYrK6yPV2IgqN30zfGF5lNdeiu9N1wn9v42zRZLk307wZXq
         71oz63gU1E0GgJ/JtzeW2to24O+HqPrKnhc6VGZV9BYX0rQVKclFAgRjr2TEWoXkf21y
         wgFw==
X-Gm-Message-State: AOAM5308oIWRyU1lrDoufz4E0+bsUNwj2yiCoPGZE6QVSmbBQQ2lojQK
        mKdaXzERJfr0Cx/HSj9WSri+pA==
X-Google-Smtp-Source: ABdhPJwKHw90WM1OlgW4VjxbHzzl3ppmODXw/M7qtJdgU1JGQcLVipqZSD/vKV7RWPbXBU6THq3qpA==
X-Received: by 2002:a63:4949:: with SMTP id y9mr1056219pgk.135.1604656173865;
        Fri, 06 Nov 2020 01:49:33 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id a7sm1780389pjz.10.2020.11.06.01.49.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:49:33 -0800 (PST)
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
Subject: [PATCH v4 3/9] perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
Date:   Fri,  6 Nov 2020 17:48:47 +0800
Message-Id: <20201106094853.21082-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
References: <20201106094853.21082-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the architectures with perf memory profiling, two types of hardware
events have been supported: load and store; if want to profile memory
for both load and store operations, the tool will use these two events
at the same time, the usage is:

  # perf mem record -t load,store -- uname

But this cannot be applied for AUX tracing event, the same PMU event can
be used to only trace memory load, or only memory store, or trace for
both memory load and store.

This patch introduces a new event PERF_MEM_EVENTS__LOAD_STORE, which is
used to support the event which can record both memory load and store
operations.

When user specifies memory operation type as 'load,store', or doesn't
set type so use 'load,store' as default, if the arch supports the event
PERF_MEM_EVENTS__LOAD_STORE, the tool will convert the required
operations to this single event; otherwise, if the arch doesn't support
PERF_MEM_EVENTS__LOAD_STORE, the tool rolls back to enable both events
PERF_MEM_EVENTS__LOAD and PERF_MEM_EVENTS__STORE, which keeps the same
behaviour with before.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c     | 24 ++++++++++++++++++------
 tools/perf/util/mem-events.c | 13 ++++++++++++-
 tools/perf/util/mem-events.h |  1 +
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 9a7df8d01296..21ebe0f47e64 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -87,14 +87,26 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 	rec_argv[i++] = "record";
 
-	if (mem->operation & MEM_OPERATION_LOAD) {
-		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
-		e->record = true;
-	}
+	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
 
-	if (mem->operation & MEM_OPERATION_STORE) {
-		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
+	/*
+	 * The load and store operations are required, use the event
+	 * PERF_MEM_EVENTS__LOAD_STORE if it is supported.
+	 */
+	if (e->tag &&
+	    (mem->operation & MEM_OPERATION_LOAD) &&
+	    (mem->operation & MEM_OPERATION_STORE)) {
 		e->record = true;
+	} else {
+		if (mem->operation & MEM_OPERATION_LOAD) {
+			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+			e->record = true;
+		}
+
+		if (mem->operation & MEM_OPERATION_STORE) {
+			e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
+			e->record = true;
+		}
 	}
 
 	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 7a5a0d699e27..19007e463b8a 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -20,6 +20,7 @@ unsigned int perf_mem_events__loads_ldlat = 30;
 static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
 	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
+	E(NULL,			NULL,				NULL),
 };
 #undef E
 
@@ -75,6 +76,9 @@ int perf_mem_events__parse(const char *str)
 		for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 			struct perf_mem_event *e = perf_mem_events__ptr(j);
 
+			if (!e->tag)
+				continue;
+
 			if (strstr(e->tag, tok))
 				e->record = found = true;
 		}
@@ -105,6 +109,13 @@ int perf_mem_events__init(void)
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
 		struct stat st;
 
+		/*
+		 * If the event entry isn't valid, skip initialization
+		 * and "e->supported" will keep false.
+		 */
+		if (!e->tag)
+			continue;
+
 		scnprintf(path, PATH_MAX, "%s/devices/%s",
 			  mnt, e->sysfs_name);
 
@@ -123,7 +134,7 @@ void perf_mem_events__list(void)
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
 
 		fprintf(stderr, "%-13s%-*s%s\n",
-			e->tag,
+			e->tag ?: "",
 			verbose > 0 ? 25 : 0,
 			verbose > 0 ? perf_mem_events__name(j) : "",
 			e->supported ? ": available" : "");
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 726a9c8103e4..5ef178278909 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -28,6 +28,7 @@ struct mem_info {
 enum {
 	PERF_MEM_EVENTS__LOAD,
 	PERF_MEM_EVENTS__STORE,
+	PERF_MEM_EVENTS__LOAD_STORE,
 	PERF_MEM_EVENTS__MAX,
 };
 
-- 
2.17.1

