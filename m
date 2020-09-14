Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10C2693F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgINRrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgINMFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:05:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A640AC061351
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so5419649pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j/6HwVpyTsA7z9Vl2wmHYe3cw1hSDvl7Zz8h5YgOZds=;
        b=Y/dOoNMuBgkwxcvT+hUX8k6okZ1RHHTdiQl0q20fDcjoSaNLlRt51ZcphRLhIZOjU1
         e4yCaxt0y04cfM2viez0pq+o4otf9Jhyvb+2q8LgEfp9jh6Gs9tY3sfuemiZwN4J5K3J
         O/ZTpzBDqEZ/mB1p0Wbbm1+lk2dcqIeKAnxF+2WNylJu+1XA7h2QJbDdR7CA8IYLhYRy
         c7cT+vkZVmOq2eu7ibrVZ42t0mFBCt5hRJxDAudxByqnVVPFMcqFoGN9S+pYzilZzlWj
         AfQSG6r+NalGgXGu1BjCvVbf4g0pBFjtNyR+grZWVIx3K5tb2vC/qhj1FQ7dBNEox1Tk
         d3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j/6HwVpyTsA7z9Vl2wmHYe3cw1hSDvl7Zz8h5YgOZds=;
        b=eSGI3ZKY0/rvhHkLEmkM1h1AJ0exKNTmncbyE6FrrpWzIlp36xu9GFswObvSQmEtYa
         HFcaiSuhUZgAE5vnKnHqq1SMLv0VzlSADKZKwNmDmNhuYDY7LrpFSDPNTX9g+PPxHDvJ
         EbDzX2a7ru+7E8yuHMJuZHh1REo/4DHlsx0wvbr8k3JIH//u4JpZKKRza9QwWbMeZV9/
         7IMa5+mwsS7VMgtW8FIIJxJD6r34PJte1d/P7QNgEZGdMIwzEf27arlddUqj9+PFgJVw
         3t/9hXGNYJvK8bBAt1oBrkUlor5SGXyhCBQpsyWIFGGu6ThboKuTMCDLqw+nGrQ/p5wf
         stlQ==
X-Gm-Message-State: AOAM53155mXqKGyDmvVq+Gxma2j3BuvM4u3y50hJhakUVV7stekXF5DF
        19UGX4qMNNQ6tQuHdZE8M3BvZA==
X-Google-Smtp-Source: ABdhPJzfTHvkBJwm+0nN7MNxYKqFAfISJSyds/ZflITL2a55vk9yLwbYw105SDNqxwdZ9xxlEqYNcw==
X-Received: by 2002:a17:90a:ea02:: with SMTP id w2mr13708647pjy.9.1600084504200;
        Mon, 14 Sep 2020 04:55:04 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id w185sm10709046pfc.36.2020.09.14.04.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 04:55:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/6] perf tsc: Move out common functions from x86
Date:   Mon, 14 Sep 2020 19:53:06 +0800
Message-Id: <20200914115311.2201-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914115311.2201-1-leo.yan@linaro.org>
References: <20200914115311.2201-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions perf_read_tsc_conversion() and perf_event__synth_time_conv()
should work as common functions rather than x86 specific, so move these
two functions out from arch/x86 folder and place them into util/tsc.c.

Since the function perf_event__synth_time_conv() will be linked in
util/tsc.c, remove its weak version.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/x86/util/tsc.c     | 73 +-----------------------------
 tools/perf/util/synthetic-events.c |  8 ----
 tools/perf/util/tsc.c              | 71 +++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 80 deletions(-)

diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 2f55afb14e1f..559365f8fe52 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -1,45 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdbool.h>
-#include <errno.h>
-
-#include <linux/stddef.h>
-#include <linux/perf_event.h>
-
 #include <linux/types.h>
-#include <asm/barrier.h>
-#include "../../../util/debug.h"
-#include "../../../util/event.h"
-#include "../../../util/synthetic-events.h"
-#include "../../../util/tsc.h"
-
-int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
-			     struct perf_tsc_conversion *tc)
-{
-	bool cap_user_time_zero;
-	u32 seq;
-	int i = 0;
-
-	while (1) {
-		seq = pc->lock;
-		rmb();
-		tc->time_mult = pc->time_mult;
-		tc->time_shift = pc->time_shift;
-		tc->time_zero = pc->time_zero;
-		cap_user_time_zero = pc->cap_user_time_zero;
-		rmb();
-		if (pc->lock == seq && !(seq & 1))
-			break;
-		if (++i > 10000) {
-			pr_debug("failed to get perf_event_mmap_page lock\n");
-			return -EINVAL;
-		}
-	}
 
-	if (!cap_user_time_zero)
-		return -EOPNOTSUPP;
-
-	return 0;
-}
+#include "../../../util/tsc.h"
 
 u64 rdtsc(void)
 {
@@ -49,36 +11,3 @@ u64 rdtsc(void)
 
 	return low | ((u64)high) << 32;
 }
-
-int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc,
-				struct perf_tool *tool,
-				perf_event__handler_t process,
-				struct machine *machine)
-{
-	union perf_event event = {
-		.time_conv = {
-			.header = {
-				.type = PERF_RECORD_TIME_CONV,
-				.size = sizeof(struct perf_record_time_conv),
-			},
-		},
-	};
-	struct perf_tsc_conversion tc;
-	int err;
-
-	if (!pc)
-		return 0;
-	err = perf_read_tsc_conversion(pc, &tc);
-	if (err == -EOPNOTSUPP)
-		return 0;
-	if (err)
-		return err;
-
-	pr_debug2("Synthesizing TSC conversion information\n");
-
-	event.time_conv.time_mult  = tc.time_mult;
-	event.time_conv.time_shift = tc.time_shift;
-	event.time_conv.time_zero  = tc.time_zero;
-
-	return process(tool, &event, NULL, machine);
-}
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 89b390623b63..3ca5d9399680 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2006,14 +2006,6 @@ int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct p
 	return 0;
 }
 
-int __weak perf_event__synth_time_conv(const struct perf_event_mmap_page *pc __maybe_unused,
-				       struct perf_tool *tool __maybe_unused,
-				       perf_event__handler_t process __maybe_unused,
-				       struct machine *machine __maybe_unused)
-{
-	return 0;
-}
-
 extern const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE];
 
 int perf_event__synthesize_features(struct perf_tool *tool, struct perf_session *session,
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index bfa782421cbd..9e3f04ddddf8 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -1,7 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+
 #include <linux/compiler.h>
+#include <linux/perf_event.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
+#include <asm/barrier.h>
+
+#include "event.h"
+#include "synthetic-events.h"
+#include "debug.h"
 #include "tsc.h"
 
 u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc)
@@ -25,6 +34,68 @@ u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc)
 	       ((rem * tc->time_mult) >> tc->time_shift);
 }
 
+int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
+			     struct perf_tsc_conversion *tc)
+{
+	bool cap_user_time_zero;
+	u32 seq;
+	int i = 0;
+
+	while (1) {
+		seq = pc->lock;
+		rmb();
+		tc->time_mult = pc->time_mult;
+		tc->time_shift = pc->time_shift;
+		tc->time_zero = pc->time_zero;
+		cap_user_time_zero = pc->cap_user_time_zero;
+		rmb();
+		if (pc->lock == seq && !(seq & 1))
+			break;
+		if (++i > 10000) {
+			pr_debug("failed to get perf_event_mmap_page lock\n");
+			return -EINVAL;
+		}
+	}
+
+	if (!cap_user_time_zero)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc,
+				struct perf_tool *tool,
+				perf_event__handler_t process,
+				struct machine *machine)
+{
+	union perf_event event = {
+		.time_conv = {
+			.header = {
+				.type = PERF_RECORD_TIME_CONV,
+				.size = sizeof(struct perf_record_time_conv),
+			},
+		},
+	};
+	struct perf_tsc_conversion tc;
+	int err;
+
+	if (!pc)
+		return 0;
+	err = perf_read_tsc_conversion(pc, &tc);
+	if (err == -EOPNOTSUPP)
+		return 0;
+	if (err)
+		return err;
+
+	pr_debug2("Synthesizing TSC conversion information\n");
+
+	event.time_conv.time_mult  = tc.time_mult;
+	event.time_conv.time_shift = tc.time_shift;
+	event.time_conv.time_zero  = tc.time_zero;
+
+	return process(tool, &event, NULL, machine);
+}
+
 u64 __weak rdtsc(void)
 {
 	return 0;
-- 
2.17.1

