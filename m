Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BBE2F57CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbhANCHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:07:05 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36629 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbhANCGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:06:50 -0500
Received: by mail-ot1-f43.google.com with SMTP id d20so3907186otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgKW8qpo7Yy7tEMcbJXs83Xuaa8pjIwYg8dr4C2Iq2M=;
        b=rC7Pm2gScpEwBS8cW1usfGQzfkWAPlFimJzxV/qQ/FsOFEP+ap9mkpQt+PAveff5+Z
         OeFhVuTrG4fcKn4CAj5sbUOtnw3tDN1D/AsCpxgE1A+Tc4obNuraus8Ho3UomJMkmmR/
         DpYmS9Ln6qTxh6FsEkB5XGpCgvCuBbrgdjmx3BL8wIiHQH77IG+73xSRI039nY0/B8cy
         V6OhCIyLWSLR1uV50/XxAgsmoVnIqYRKDXBpu1J+PFF3GV34H1j8tcKhMpJ18rDNTd0e
         4sQiDzjVX1SU9TkQGm4aBWnj3qodR+B/UWyP31NaWITVeRT8PCRnjPeOEhDVh2eKsqCm
         7NEA==
X-Gm-Message-State: AOAM532FF5N9oJ01nFk+RgR++6OEU8OAIwmSoC9RXByIdP6UbpW3aNGd
        2Qn+Dp7/6rQBkdx5RCgAWA==
X-Google-Smtp-Source: ABdhPJyorcBQnnEbV8eEcGd3433zi6165ApiHevL3R4LhFp+leaR1HQSNgN5H2sSorTfxkTGPObWWQ==
X-Received: by 2002:a9d:7504:: with SMTP id r4mr3050557otk.245.1610589969736;
        Wed, 13 Jan 2021 18:06:09 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x20sm814272oov.33.2021.01.13.18.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:06:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v5 1/9] arm64: pmu: Add function implementation to update event index in userpage
Date:   Wed, 13 Jan 2021 20:05:57 -0600
Message-Id: <20210114020605.3943992-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114020605.3943992-1-robh@kernel.org>
References: <20210114020605.3943992-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

In order to be able to access the counter directly for userspace,
we need to provide the index of the counter using the userpage.
We thus need to override the event_idx function to retrieve and
convert the perf_event index to armv8 hardware index.

Since the arm_pmu driver can be used by any implementation, even
if not armv8, two components play a role into making sure the
behaviour is correct and consistent with the PMU capabilities:

* the ARMPMU_EL0_RD_CNTR flag which denotes the capability to access
counter from userspace.
* the event_idx call back, which is implemented and initialized by
the PMU implementation: if no callback is provided, the default
behaviour applies, returning 0 as index value.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/kernel/perf_event.c | 21 +++++++++++++++++++++
 include/linux/perf/arm_pmu.h   |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 38bb07eff872..21f6f4cdd05f 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -873,6 +873,22 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 		clear_bit(idx - 1, cpuc->used_mask);
 }
 
+static int armv8pmu_access_event_idx(struct perf_event *event)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return 0;
+
+	/*
+	 * We remap the cycle counter index to 32 to
+	 * match the offset applied to the rest of
+	 * the counter indices.
+	 */
+	if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
+		return 32;
+
+	return event->hw.idx;
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -969,6 +985,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	if (armv8pmu_event_is_64bit(event))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
 
+	if (!armv8pmu_event_is_chained(event))
+		event->hw.flags |= ARMPMU_EL0_RD_CNTR;
+
 	/* Only expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
@@ -1100,6 +1119,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
+	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index bf7966776c55..bb69d14eaa82 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -26,6 +26,8 @@
  */
 /* Event uses a 64bit counter */
 #define ARMPMU_EVT_64BIT		1
+/* Allow access to hardware counter from userspace */
+#define ARMPMU_EL0_RD_CNTR		2
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
-- 
2.27.0

