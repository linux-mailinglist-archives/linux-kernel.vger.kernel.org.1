Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5D2DF9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgLUIhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:37:45 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AE4C061248
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:04 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n10so5925638pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EtaTARPLuxNd9yp7QOmPqgryVFCnyqjIqUr945Fpm/U=;
        b=adTqsf41W1IW0di11ZD1Aozlf9hvO+JSqVMUy9TvF9zw/wIYkPvXQFgSto+anIhJpN
         yWd2zanu2jvlI7K1GhyQWD1VvDAVVg04lK7WAXYGiGwzp1KGSWrLQTamRRNRVgva2ndO
         +wHp+tjs/GmYf/H1K5ZN8F8nsfGBXijXBbjVnElD/A0uCAAtAMYdv7HlUB+clZ5zkjcM
         abmovTSca4qJx0QrRKtYP0+YPCcaMWAdHS6CO6vrOniD//R+7XDho+48mY2zF/5dJSRP
         NwLmYSIcMPbETBcilvSdOIAl0G/kDFABI/58WIPpgecnJYT1ohOlWRI359PeYyiq5c3o
         6fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EtaTARPLuxNd9yp7QOmPqgryVFCnyqjIqUr945Fpm/U=;
        b=V5xV+EEMG7enQxMyjuOw0Z0BKFaoKqvd1iqmx7LSjmreODlbREtbRrH/idHqjXGKas
         FqCf6WYMz58eKDaX8OKjjv8stiM1A7Fl6RbzBzqHrGwgxADQ1dCSIoORUeyRd1RrC8pQ
         sF3uVtemaoFPxcXU/fSqsew3g/Bvma6vIZXcuFYvdNuQYRI2FVh7mAkiWsELNJBp+zm6
         rxLRfwj+4Byqvy5ehnW+Ni4lV9Y/qRjVpBwfkEYrkQAEF1/6VreCIZK1+wczap4bWyLz
         0nei9RaWWa14+kW/lvSZAyWoB+ab1UXLjqSvupCggeWL0iHneMQFfu4tJtkLPP+BWn7b
         XZDQ==
X-Gm-Message-State: AOAM530+ZKtlahgT2bYGk7+6GkxvUH7XFi4xdKi03sUdWLQ167qYzjSG
        yampC96QQR6QWWVUzDB/BnFq9Q==
X-Google-Smtp-Source: ABdhPJytiJsACVWxT0kxl3mc0RzjMi7VsHso1i74DuxZwVmga5xAG3E5RrWRu2UsxhF7EYvPvKyP/Q==
X-Received: by 2002:a63:1959:: with SMTP id 25mr14541289pgz.201.1608539823720;
        Mon, 21 Dec 2020 00:37:03 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id a18sm15449664pfg.107.2020.12.21.00.37.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Dec 2020 00:37:03 -0800 (PST)
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
Subject: [PATCH v1 2/7] perf arm-spe: Store TSC parameters in auxtrace info
Date:   Mon, 21 Dec 2020 16:35:52 +0800
Message-Id: <20201221083557.27642-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221083557.27642-1-leo.yan@linaro.org>
References: <20201221083557.27642-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSC parameters are used for conversion between arch timer counter
and kernel timestamp, this patch stores the parameters into the struct
perf_record_auxtrace_info, and it is saved in perf data file.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 23 +++++++++++++++++++++++
 tools/perf/util/arm-spe.h            |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 414c8a5584b1..dd940cf16f49 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -15,7 +15,9 @@
 #include "../../../util/event.h"
 #include "../../../util/evsel.h"
 #include "../../../util/evlist.h"
+#include "../../../util/mmap.h"
 #include "../../../util/session.h"
+#include "../../../util/tsc.h"
 #include <internal/lib.h> // page_size
 #include "../../../util/pmu.h"
 #include "../../../util/debug.h"
@@ -47,6 +49,9 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
+	struct perf_event_mmap_page *pc;
+	struct perf_tsc_conversion tc = { .time_mult = 0, };
+	int err;
 
 	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
 		return -EINVAL;
@@ -54,8 +59,26 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
+	pc = session->evlist->mmap[0].core.base;
+	if (pc) {
+		err = perf_read_tsc_conversion(pc, &tc);
+		if (err) {
+			if (err != -EOPNOTSUPP)
+				return err;
+		}
+
+		if (!tc.time_mult)
+			ui__warning("Arm SPE: arch timer not available\n");
+	}
+
 	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
 	auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
+	auxtrace_info->priv[ARM_SPE_TIME_SHIFT] = tc.time_shift;
+	auxtrace_info->priv[ARM_SPE_TIME_MULT] = tc.time_mult;
+	auxtrace_info->priv[ARM_SPE_TIME_ZERO] = tc.time_zero;
+	auxtrace_info->priv[ARM_SPE_TIME_CYCLES] = tc.time_cycles;
+	auxtrace_info->priv[ARM_SPE_TIME_MASK] = tc.time_mask;
+	auxtrace_info->priv[ARM_SPE_CAP_USER_TIME_SHORT] = tc.cap_user_time_short;
 
 	return 0;
 }
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 105ce0ea0a01..5bf3e838d226 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -11,6 +11,12 @@
 
 enum {
 	ARM_SPE_PMU_TYPE,
+	ARM_SPE_TIME_SHIFT,
+	ARM_SPE_TIME_MULT,
+	ARM_SPE_TIME_ZERO,
+	ARM_SPE_TIME_CYCLES,
+	ARM_SPE_TIME_MASK,
+	ARM_SPE_CAP_USER_TIME_SHORT,
 	ARM_SPE_AUXTRACE_PRIV_MAX,
 };
 
-- 
2.17.1

