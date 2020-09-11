Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61F266A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgIKVvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:51:50 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40198 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIKVvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:51:25 -0400
Received: by mail-il1-f195.google.com with SMTP id y2so10344544ilp.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evx4ES4Aelq1S/aOsFR1P9EyHf1WVald+woJD7LPgyY=;
        b=EFupZm/0IFrMHl8lLrhitY+emMWkFiTuZzuO/fMGYuDcYFKvsg5riv8PIKKX3ewzwM
         FqfVKTsEz+foy5fvGUgm/w1RUu+5WGDtYppqT0PQqnv8SkYtDFYXAPHHHhzwD13UxMOs
         mKXz+K3249Jjfz5uUb4n2/EgTtkuIOUAgHPcDnWQypLxNVlfCj4/1dHx5N4okI4/xNux
         5w3fob/PS3SpS0s3Z22bAp+qMFA/kwRzXNiccrtvT62fMD0UEudna/hNzAhZRxr5VXXc
         uWQjt1879zSepGt/QBjNRb7L8aiiCb6Y/zNESZjq1F1Xs6A4e/KQSOta1MTkeIyrpPU+
         3LZA==
X-Gm-Message-State: AOAM5318Y7+jG74BYw7FenLw5BU2HEploA90NHWSLn44E0Z3HYf9Jt6x
        BtfIwAvJoykLcnEczx38VQ==
X-Google-Smtp-Source: ABdhPJy49H3SBbV929nN2baxj6ixmZSc9YaVzPXbw/IqlTXjF+g/yq7TxUwSRljSTzHL1xS7P9+rYg==
X-Received: by 2002:a92:cd11:: with SMTP id z17mr3449198iln.31.1599861083542;
        Fri, 11 Sep 2020 14:51:23 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id a20sm1927966ilq.57.2020.09.11.14.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:51:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v3 02/10] arm64: pmu: Add function implementation to update event index in userpage
Date:   Fri, 11 Sep 2020 15:51:10 -0600
Message-Id: <20200911215118.2887710-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911215118.2887710-1-robh@kernel.org>
References: <20200911215118.2887710-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
index 70538ae684da..2727d126cecd 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -820,6 +820,22 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
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
@@ -916,6 +932,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	if (armv8pmu_event_is_64bit(event))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
 
+	if (!armv8pmu_event_is_chained(event))
+		event->hw.flags |= ARMPMU_EL0_RD_CNTR;
+
 	/* Only expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
@@ -1092,6 +1111,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
+	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 5b616dde9a4c..74fbbbd29dc7 100644
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
2.25.1

