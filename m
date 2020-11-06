Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B382A935E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgKFJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgKFJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:50:12 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62327C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:50:12 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c20so824251pfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dwHpj1cW3L4kr58+zXOY+yCLUfLvqEMwWKgfEwMH/s=;
        b=UvGKpOWgoGOeeQEEqmtcQf04za5UTPBliknXTiFSg9S/PyE+v26r+EVnmD/gTW7uxq
         roBqFZxXykjYtFd2p0+YRpAGeUODSltiLqO20ZMiPnV6gllgsf91le3smtYsmEgvyMHJ
         NfZyl52rlzEXQ/aMTj1YxQsqjcnKaTSlMT5hKzNt/AxKCwPJSmCLKwOcjmIA/E6am87j
         j7Y2oyJCW/QsSQvDgq+GI/HxWwQMGM7SaCxk0ApT49O5mIN/Ox0m5Gl9eLYJYPez1Ft2
         gnU76O3nkPEvmT21qbqTpd+26NxqS2vnVHUlv89F1295fWtEBE5AxB2qs9k/v85QT3wK
         LB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/dwHpj1cW3L4kr58+zXOY+yCLUfLvqEMwWKgfEwMH/s=;
        b=iS7nb6PBe3yAtJSCh2LYhECKOGLs5SxlELmPKvApmOJUN2pXCjoIkXb31zGr8R9jls
         1peHvfHT/10HkAH40dcnWh1j1imgLGfT6zxxMJmKLJl6LvvP15+5CMl5gvmw5op+wPh8
         1B9ndIagtMoVtavIBBsEGshZeSFKn0pltsJzyl6JhNHnczflxRgVXdOULqrXsYGublD5
         4S3slfCiSASROWJtHSCw4rnw06cqc6r+dSDdYyvj70UEJL5ZSfi95qs49LBAk+SJuOdG
         wmqumkGuomLIUaLqh5IjaQOk7pcjLx5q1bOqdPCbBU+rg8xlPsZzC0fCt2cfEtO7Cb49
         v5rg==
X-Gm-Message-State: AOAM532ZJEiQPoXoF+TDMlApXEDchZsP7sK3xjsueGGeYXJKVc0dMsry
        aFqNH2AEEg67mL/YRJgkeypG9Q==
X-Google-Smtp-Source: ABdhPJxqvanSRvZbftvV9fjdwCxxQT0SoSe+H3ocssOuZ22lX0l5tNpnrlTKmm5zvL+mOpaxwfNJSQ==
X-Received: by 2002:a65:40ca:: with SMTP id u10mr1036986pgp.71.1604656211967;
        Fri, 06 Nov 2020 01:50:11 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id h5sm1545090pfk.126.2020.11.06.01.50.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:50:11 -0800 (PST)
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
Subject: [PATCH v4 9/9] perf mem: Support Arm SPE events
Date:   Fri,  6 Nov 2020 17:48:53 +0800
Message-Id: <20201106094853.21082-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
References: <20201106094853.21082-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Arm SPE events for perf memory profiling:

  'spe-load': event for only recording memory load ops;
  'spe-store': event for only recording memory store ops;
  'spe-ldst': event for recording memory load and store ops.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/Build        |  2 +-
 tools/perf/arch/arm64/util/mem-events.c | 37 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 8d2b9bcfffca..ead2f2275eee 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -10,4 +10,4 @@ perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
 			      ../../arm/util/auxtrace.o \
 			      ../../arm/util/cs-etm.o \
-			      arm-spe.o
+			      arm-spe.o mem-events.o
diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
new file mode 100644
index 000000000000..2a2497372671
--- /dev/null
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "map_symbol.h"
+#include "mem-events.h"
+
+#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
+
+static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+	E("spe-load",	"arm_spe_0/ts_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
+	E("spe-store",	"arm_spe_0/ts_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
+	E("spe-ldst",	"arm_spe_0/ts_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
+};
+
+static char mem_ev_name[100];
+
+struct perf_mem_event *perf_mem_events__ptr(int i)
+{
+	if (i >= PERF_MEM_EVENTS__MAX)
+		return NULL;
+
+	return &perf_mem_events[i];
+}
+
+char *perf_mem_events__name(int i)
+{
+	struct perf_mem_event *e = perf_mem_events__ptr(i);
+
+	if (i >= PERF_MEM_EVENTS__MAX)
+		return NULL;
+
+	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE)
+		scnprintf(mem_ev_name, sizeof(mem_ev_name),
+			  e->name, perf_mem_events__loads_ldlat);
+	else /* PERF_MEM_EVENTS__STORE */
+		scnprintf(mem_ev_name, sizeof(mem_ev_name), e->name);
+
+	return mem_ev_name;
+}
-- 
2.17.1

