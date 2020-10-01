Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46E28094F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgJAVRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:17:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:27026 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgJAVRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:17:35 -0400
IronPort-SDR: iCt5F0Xm6lIHn6yEIprmYl5tUHpBKlAcsLwK+UA6y10zs4z1NfzS9sW/xVOI9iakWA0XFfWptU
 646q3GyIgD/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="162916104"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="162916104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 14:17:32 -0700
IronPort-SDR: NTPEIf6h0orzGEwpntApAf89eHeQjG5N6MPpkc940fPwHIcIYufK6slFswvQSBoqe3Gt6TycFe
 Wr3h8ifvzdGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="352109940"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2020 14:17:30 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Check perf metrics feature for each CPU
Date:   Thu,  1 Oct 2020 14:17:11 -0700
Message-Id: <20201001211711.25708-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It might be possible that different CPUs have different CPU metrics on a
platform. In this case, writing the GLOBAL_CTRL_EN_PERF_METRICS bit to
the GLOBAL_CTRL register of a CPU, which doesn't support the TopDown
perf metrics feature, causes MSR access error.

Current TopDown perf metrics feature is enumerated using the boot CPU's
PERF_CAPABILITIES MSR. The MSR only indicates the boot CPU supports this
feature.

Check the PERF_CAPABILITIES MSR for each CPU. If any CPU doesn't support
the perf metrics feature, disable the feature globally.

Fixes: 59a854e2f3b9 ("perf/x86/intel: Support TopDown metrics on Ice Lake")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4def6fa63875..4d70c7d6c750 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4083,6 +4083,17 @@ static void intel_pmu_cpu_starting(int cpu)
 	if (x86_pmu.counter_freezing)
 		enable_counter_freeze();
 
+	/* Disable perf metrics if any added CPU doesn't support it. */
+	if (x86_pmu.intel_cap.perf_metrics) {
+		union perf_capabilities perf_cap;
+
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
+		if (!perf_cap.perf_metrics) {
+			x86_pmu.intel_cap.perf_metrics = 0;
+			x86_pmu.intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
+		}
+	}
+
 	if (!cpuc->shared_regs)
 		return;
 
-- 
2.17.1

