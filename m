Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3110B29D32F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgJ1Vlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgJ1Vl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:41:29 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F6FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:41:29 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id s1so510620qvm.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MZws/yHeMeZIdN0QaM5yV/E7HIfLgH25EcF8ntilLJg=;
        b=IITH0aW/Iy98o1mD08/jT0jklhoPMhvcjuumLNH5H+oY2uixh0bgviuxGGyQ+6WV2T
         3K9/nkMaWQ3U5jpKTvf6oqPpNwFbh1/bC+Zry0/l10Rm3jBDOUByoFCP/9Es0O92PJJv
         +fdWca+aoBFZTklnT4D9oZbeM5lReXKB7LwytieIYwDHe2gwx58MRG32jW2G+GXfZKIr
         pwvlJtJZAC7N2Bwj+gUhlBiDkOv5olDkVm4VQUa2q8VRfDPualLwmFWpITpydKobtNni
         ZZ6IyjkmmBerXQrPlYpdvZSLBiQqV6PnCnmMqR09njuOvw4VQrd4OLjAxEKeqt3wZNJk
         EcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MZws/yHeMeZIdN0QaM5yV/E7HIfLgH25EcF8ntilLJg=;
        b=R+/N+EEjyhy3ghVoBjMEy139uV3uesbyeZBg2QmGAPijWsGmR8wJKl+ESF5s8s7t49
         GddamKrzVrekkGRkqC/mRAUoGPxsEvG0xnYXXLBuNFaueGg7x4CfWyh+gT1mGjC4PM2w
         Vyn+j8XKEGOp+mxfGcCiY7FJrPsiwMN/9YLWEYLe1hP1RV9fWS9KKEpPNQ0flZdHB7Ce
         qPnWAgUAVWAcNFM1Ila4QrxnBdR/3h3ddYCV45XI5TQ833tMWV/7X04hKH2hE7mkLB8W
         SW6QX86ARq48iADmkEEZLHY6Lmnmg3pzyeRIghaX4SU5joE5kYq+L5UvaTFBmAn9uqhm
         Fxqg==
X-Gm-Message-State: AOAM531WHZqsi+RbFjd8NuPONQ00nWrYIIYuMH+BKhxis6BJi8/+dep6
        bnQ26b2RrITwhajhi58e8nqey+h9Exip5htL
X-Google-Smtp-Source: ABdhPJwJv62nvQGcNGugNXS8WGpowmteHMkD1GzLgt6WSpm84TMzNTgVPuaLGT9yaliTSeyhj0kLvw==
X-Received: by 2002:a17:902:a3c2:b029:d6:3951:5bdc with SMTP id q2-20020a170902a3c2b02900d639515bdcmr6107502plb.71.1603867119624;
        Tue, 27 Oct 2020 23:38:39 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id j11sm4374936pfe.80.2020.10.27.23.38.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:38:39 -0700 (PDT)
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
Subject: [PATCH v3 3/9] perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
Date:   Wed, 28 Oct 2020 14:38:07 +0800
Message-Id: <20201028063813.8562-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028063813.8562-1-leo.yan@linaro.org>
References: <20201028063813.8562-1-leo.yan@linaro.org>
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
operations, thus a new type option "ldst" is added:

  # perf mem record -t ldst -- uname

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c     | 13 ++++++++++---
 tools/perf/util/mem-events.c | 13 ++++++++++++-
 tools/perf/util/mem-events.h |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 9a7df8d01296..31144f586e77 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -19,8 +19,9 @@
 #include "util/symbol.h"
 #include <linux/err.h>
 
-#define MEM_OPERATION_LOAD	0x1
-#define MEM_OPERATION_STORE	0x2
+#define MEM_OPERATION_LOAD		0x1
+#define MEM_OPERATION_STORE		0x2
+#define MEM_OPERATION_LOAD_STORE	0x4
 
 struct perf_mem {
 	struct perf_tool	tool;
@@ -97,6 +98,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		e->record = true;
 	}
 
+	if (mem->operation & MEM_OPERATION_LOAD_STORE) {
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
+		e->record = true;
+	}
+
 	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
 	if (e->record)
 		rec_argv[i++] = "-W";
@@ -326,6 +332,7 @@ struct mem_mode {
 static const struct mem_mode mem_modes[]={
 	MEM_OPT("load", MEM_OPERATION_LOAD),
 	MEM_OPT("store", MEM_OPERATION_STORE),
+	MEM_OPT("ldst", MEM_OPERATION_LOAD_STORE),
 	MEM_END
 };
 
@@ -405,7 +412,7 @@ int cmd_mem(int argc, const char **argv)
 	};
 	const struct option mem_options[] = {
 	OPT_CALLBACK('t', "type", &mem.operation,
-		   "type", "memory operations(load,store) Default load,store",
+		   "type", "memory operations(load,store,ldst) Default load,store",
 		    parse_mem_ops),
 	OPT_BOOLEAN('D', "dump-raw-samples", &mem.dump_raw,
 		    "dump raw samples in ASCII"),
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 7a5a0d699e27..2e82b4e78f29 100644
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
+			e->tag ? e->tag : "",
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

