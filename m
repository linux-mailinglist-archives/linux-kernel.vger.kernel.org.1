Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587BD2DFA00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgLUIhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUIhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:37:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A42C061257
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c12so6046422pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b068LKjtP71mGJpSQ/VpoinaM2P4/nqDUkwHrhfB0UE=;
        b=WhlktoI4MHLp1tM/BNYzd7mGk1oxvluTIIj9/uYOg9DfK8ICIechD3T2rMt9+Irksp
         Qv2QhGSSrKWHxg+1hDanN4GimuZEIJFn3BI/ELL8vluWelVPh1C/VRQBJLJ3yl01zaLQ
         0iKmuHXYpbnoSeobkE6VR3n3XpCF0H3bAvTXWcgOJi7k9kCrhPZq00mjcFqTEk9ANwJG
         KaV32ZsEQ7ffuyGuMpIVlN+I2ukMgBTrh2vhvrqbyo+Xjsv3iIHdnmpVwPA4p/E9lvRS
         Ir4UJ00uvxwirZkKRMIzafM8DyFBp6i2tANiPgdPSjuN0+2w58yU5lgxSrbdy3epyJKy
         35hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b068LKjtP71mGJpSQ/VpoinaM2P4/nqDUkwHrhfB0UE=;
        b=YN2aQjXhbVJFEEe0tw6sOdE5p8QSLVt7fYUbA3zbvJPkjcyd3K2fNzNTxIX2kSoWoY
         UHBDGUUcT4EddhpZ5AVKmk2VT87QmzUbrnJcaPsQ7LYnb7u1/nZNUzNTFia1AcQ2aNSZ
         HqlvAvvUMaTsiKJZPLaPmweiOP6WqLUz3USa3V18AeqsP+YCGdjgrSwJabGJlfLYT4HM
         8OVAELV/vhFp8X6DF+ees/RyzcWZxRsIzTCuROkNX7EpiA2MvG04IILBMRtiejHYffkF
         GVs066MG9BYX+AO/jN5bDtmmZd+BOY7REoVOpCnUgmeAGMS5zECnDZf+3oHs2WDzqq2H
         cDMw==
X-Gm-Message-State: AOAM531vzYbhrPZUoyDsvopKWI35H/qBhmVBM6zp8HMKXuBg+uyAzxdT
        69Drz4flQ6UKemzFuTJnvFnDBw==
X-Google-Smtp-Source: ABdhPJyNhA+8P/7imhHPI+0VbMULS1oQVQjnYEUjXPCWSB0BAiHcyqoRslNGvNB12IWN4WNvFJ5aBw==
X-Received: by 2002:a62:8c97:0:b029:19e:56cc:b025 with SMTP id m145-20020a628c970000b029019e56ccb025mr14521928pfd.77.1608539827134;
        Mon, 21 Dec 2020 00:37:07 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id y5sm9283552pgs.90.2020.12.21.00.37.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Dec 2020 00:37:06 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/7] perf arm-spe: Dump TSC parameters
Date:   Mon, 21 Dec 2020 16:35:53 +0800
Message-Id: <20201221083557.27642-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221083557.27642-1-leo.yan@linaro.org>
References: <20201221083557.27642-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSC parameters are stored in auxtrace info, this patch dumps these
parameters for reporting the raw data.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8901a1656a41..a504ceec2de6 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -26,6 +26,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include "thread-stack.h"
+#include "tsc.h"
 #include "tool.h"
 #include "util/synthetic-events.h"
 
@@ -45,6 +46,8 @@ struct arm_spe {
 	struct machine			*machine;
 	u32				pmu_type;
 
+	struct perf_tsc_conversion	tc;
+
 	u8				timeless_decoding;
 	u8				data_queued;
 
@@ -722,14 +725,23 @@ static bool arm_spe_evsel_is_auxtrace(struct perf_session *session,
 
 static const char * const arm_spe_info_fmts[] = {
 	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
+	[ARM_SPE_TIME_SHIFT]		= "  Time Shift         %"PRIu64"\n",
+	[ARM_SPE_TIME_MULT]		= "  Time Muliplier     %"PRIu64"\n",
+	[ARM_SPE_TIME_ZERO]		= "  Time Zero          %"PRIu64"\n",
+	[ARM_SPE_TIME_CYCLES]		= "  Time Cycles        %"PRIu64"\n",
+	[ARM_SPE_TIME_MASK]		= "  Time Mask          %#"PRIx64"\n",
+	[ARM_SPE_CAP_USER_TIME_SHORT]	= "  Cap Time Short     %"PRId64"\n",
 };
 
 static void arm_spe_print_info(__u64 *arr)
 {
+	int i;
+
 	if (!dump_trace)
 		return;
 
-	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
+	for (i = 0; i < ARM_SPE_AUXTRACE_PRIV_MAX; i++)
+		fprintf(stdout, arm_spe_info_fmts[i], arr[i]);
 }
 
 struct arm_spe_synth {
@@ -934,6 +946,12 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
 	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+	spe->tc.time_shift = auxtrace_info->priv[ARM_SPE_TIME_SHIFT];
+	spe->tc.time_mult = auxtrace_info->priv[ARM_SPE_TIME_MULT];
+	spe->tc.time_zero = auxtrace_info->priv[ARM_SPE_TIME_ZERO];
+	spe->tc.time_cycles = auxtrace_info->priv[ARM_SPE_TIME_CYCLES];
+	spe->tc.time_mask = auxtrace_info->priv[ARM_SPE_TIME_MASK];
+	spe->tc.cap_user_time_short = auxtrace_info->priv[ARM_SPE_CAP_USER_TIME_SHORT];
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 	spe->auxtrace.process_event = arm_spe_process_event;
-- 
2.17.1

