Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C72A9359
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKFJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgKFJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:50:01 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:49:59 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id j5so422738plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7f0Xbxp0l73CuXczuH9NbSRse7uN6mi3bE07Itm9aPI=;
        b=zFFNR1KN2QlUPHVWR6Bjs4PbEW3xToifk2UhHKY6vBbX8e6VFqmElcGRzGufKq+5Us
         IxFbi6zgFsA5eCV9S3Y2iFUUGmcNRMttb/6OmuNr5fwa47KH5AHwgWqbXXc6FVYszxHO
         cC4Q51FPBYgvo3LJEBMMYeEMLHg52f171tZo6n4vVxfvYeIJnBjIzb78nF6CklV5SR7D
         GB299YTnIUpE0/4WExrNN4xAGRHHvSc4KVpX/WAM5+6q1ode6ruZPVjO7OPQ4sUrO8sJ
         1eFwUczb1kuXeXYQgqHpXFhyaZz8W8wkJDGLB8gATudTp+r2SC0x1NS3HlNj10d6KHWX
         UiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7f0Xbxp0l73CuXczuH9NbSRse7uN6mi3bE07Itm9aPI=;
        b=emVD+ZL6j8XfsX+S6Lgxm76dBN0busbaRIumDW+/qhqFCIjXUlS5Dl/mWOPk6HELzU
         tDRb0nw2Hf1elNRwCu+4wJup8hKSIZN3DK9nkHvSVCsowQpiyTT5s9OIvvYe+sPwVhNd
         VZfWp4ADR0pWJ7xdF6TLbkcxkJDctJnf9TJbJRAksGZ4induEwVG5V2cpv/rVPK+XXUC
         hxXuC0nlsExJaL0Np58cDaQ2mZEownFgu5q5gAh7oEDrmCEn399k4pKHuQAU1gC0vpkk
         yOUqQ7Lc+TkCYSUIv6LQrU0UItwdfEDcp+PXVRP+6v+jsvxG/cJjM59XUoPLiLOscWku
         0y/w==
X-Gm-Message-State: AOAM530qcuOb4+UAXQXDw6PXp56WKeGtCxA0PZyKE+VSGO61jaioiHvw
        vjRzUaYWo4tP/Ix/ZElwvBTAKg==
X-Google-Smtp-Source: ABdhPJyZY9T7mOxSSsA5QwOWZe8P1lSV1dNtbi2VzATehH/0vFnnhUkJJmhqdylvS8v8kMMdHJS7VA==
X-Received: by 2002:a17:902:b789:b029:d6:d543:bd14 with SMTP id e9-20020a170902b789b02900d6d543bd14mr1269444pls.16.1604656199457;
        Fri, 06 Nov 2020 01:49:59 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id w22sm1230549pge.25.2020.11.06.01.49.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 01:49:58 -0800 (PST)
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
Subject: [PATCH v4 7/9] perf mem: Support AUX trace
Date:   Fri,  6 Nov 2020 17:48:51 +0800
Message-Id: <20201106094853.21082-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106094853.21082-1-leo.yan@linaro.org>
References: <20201106094853.21082-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf memory tool doesn't support AUX trace data so it cannot receive the
hardware tracing data.  On Arm64, although it doesn't support PMU events
for memory load and store, but Arm SPE is a good candidate for memory
profiling, the hardware tracer can record memory accessing operations
with affiliated information (e.g. physical address and virtual address
for accessing, cache levels, TLB walking, latency, etc).

To allow "perf mem" tool to support AUX trace, this patch adds the AUX
callbacks for session structure; make itrace memory event as default for
"perf mem", this tells the AUX trace decoder to synthesize memory
samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 72ce4b8fbb0f..fdfbff7592f4 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -7,6 +7,7 @@
 #include "perf.h"
 
 #include <subcmd/parse-options.h>
+#include "util/auxtrace.h"
 #include "util/trace-event.h"
 #include "util/tool.h"
 #include "util/session.h"
@@ -255,6 +256,12 @@ static int process_sample_event(struct perf_tool *tool,
 
 static int report_raw_events(struct perf_mem *mem)
 {
+	struct itrace_synth_opts itrace_synth_opts = {
+		.set = true,
+		.mem = true,	/* Only enable memory event */
+		.default_no_sample = true,
+	};
+
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -267,6 +274,8 @@ static int report_raw_events(struct perf_mem *mem)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	session->itrace_synth_opts = &itrace_synth_opts;
+
 	if (mem->cpu_list) {
 		ret = perf_session__cpu_bitmap(session, mem->cpu_list,
 					       mem->cpu_bitmap);
@@ -410,8 +419,12 @@ int cmd_mem(int argc, const char **argv)
 			.comm		= perf_event__process_comm,
 			.lost		= perf_event__process_lost,
 			.fork		= perf_event__process_fork,
+			.attr		= perf_event__process_attr,
 			.build_id	= perf_event__process_build_id,
 			.namespaces	= perf_event__process_namespaces,
+			.auxtrace_info  = perf_event__process_auxtrace_info,
+			.auxtrace       = perf_event__process_auxtrace,
+			.auxtrace_error = perf_event__process_auxtrace_error,
 			.ordered_events	= true,
 		},
 		.input_name		 = "perf.data",
-- 
2.17.1

