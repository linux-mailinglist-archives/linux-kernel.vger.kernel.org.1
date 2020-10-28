Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D5729D917
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbgJ1WoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389503AbgJ1Wn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:43:59 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17768C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:43:59 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e3so465177vsr.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o+aw422Im4Ichg/wUKoGWmj123l3key7lcjo++Bjumk=;
        b=HNcjK0/JO1L83CmLO+3wusD4wDLZ2IvDw84984aaq0z1bEIeFM3R6Tt9uDag/IG5es
         wD3N4rfHvJTZcA2pYTByCkjSHZlq8PdORvIbQXrJD5cWx3NMqCDNmpOqMPdBO+/FRAro
         /rDO1wGLvKR27M/L+lhtLV4Eeylyi/cQUj5Wgqoz04wCsnlN3fT1BHZ/9lJWsra6xrtr
         uLCx5TiF0alxQvBi4jUv0RWwHf8a8g3GD+soCzF00dyfg4hsEFvMEVDPy39IOhR9S7Yk
         3vi69dnxH1H6f9fq9lmw2YZd9j5q7QL4Hamb6THL0c1v0T59RDQcU9QL6dgFuT20m/XS
         bgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o+aw422Im4Ichg/wUKoGWmj123l3key7lcjo++Bjumk=;
        b=XgdvlKwFDfE6xLiIlATwvlsQY43iX4MIMSYLewI4/6a5lYE7BR73thTPAP6a7mffLt
         RaCvx//usa8NJmJMJHch4CAaGTsTdGhmVm0cnfjWtQRWKURJaGpxwA2G9Te10Zn0uFcE
         8/BMQnJn913j3rRzDv5kbFiR2aFXcH+UMSF0ay4Zih/HGi1od4DDowLKo9qE3HumsQP7
         Fnz0Nymr0emY4+dVdhG9A9Rqxu9pHZeKc+wcyk3vzItNs0g3R1AgmeLZ+hWkXtrrvsAY
         RtnOCx/WIzjXYO9TUX9R/7UVg4HPw38PlR7nnXfNZcdN0Y1fnjSItZ0yGDENLcLamQwv
         FrVQ==
X-Gm-Message-State: AOAM530RaKoi8YuitmZ1eodDL9wC64W0hyGEKTO50Wu202fDUYrgvHWG
        quzRfkzmGXYKjgl+cTjR3MwAMIEe/YUcd5d7
X-Google-Smtp-Source: ABdhPJwCUyokVIcSdALfYMm5SQrRoMPAP//iqCaeYqnuCEprNvRQ5scEg9XRIDATk49FIblPyql0jQ==
X-Received: by 2002:a17:902:8647:b029:d3:d448:98a8 with SMTP id y7-20020a1709028647b02900d3d44898a8mr6201014plt.29.1603867139483;
        Tue, 27 Oct 2020 23:38:59 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id n19sm4459819pfu.24.2020.10.27.23.38.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Oct 2020 23:38:58 -0700 (PDT)
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
Subject: [PATCH v3 7/9] perf mem: Support Arm SPE events
Date:   Wed, 28 Oct 2020 14:38:11 +0800
Message-Id: <20201028063813.8562-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028063813.8562-1-leo.yan@linaro.org>
References: <20201028063813.8562-1-leo.yan@linaro.org>
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
index b53294d74b01..cf6d7e799f33 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -9,4 +9,4 @@ perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
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

