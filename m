Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35755223DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGQOIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:08:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:11837 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgGQOH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:27 -0400
IronPort-SDR: xjOEaVRL5FsZQMjz/eMiXbzDKtEgsqgAe1y6wuUPHYvD6vDaqhGPz7g0ZM4wP+taXdNXpUyT9r
 5zS+hyg7ZzXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167722810"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167722810"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:07:27 -0700
IronPort-SDR: 3LRflFszD+gkChtUTjMXPL/544T4lv2YGa31DrlHoexqkXL6VBkWy72U3XUHNWgQuQZzDCG6Et
 ytVAatouC4vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460856491"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 07:07:26 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 08/14] perf/x86: Add a macro for RDPMC offset of fixed counters
Date:   Fri, 17 Jul 2020 07:05:48 -0700
Message-Id: <20200717140554.22863-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717140554.22863-1-kan.liang@linux.intel.com>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The RDPMC base offset of fixed counters is hard-code. Use a meaningful
name to replace the magic number to improve the readability of the code.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c            | 3 ++-
 arch/x86/include/asm/perf_event.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8aa7da80f5d6..ace21b133015 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1158,7 +1158,8 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
 				(idx - INTEL_PMC_IDX_FIXED);
-		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) | 1<<30;
+		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) |
+					INTEL_PMC_FIXED_RDPMC_BASE;
 		break;
 
 	default:
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8870eb1c3b17..84bfb9d1f948 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -196,6 +196,9 @@ struct x86_pmu_capability {
  * Fixed-purpose performance events:
  */
 
+/* RDPMC offset for Fixed PMCs */
+#define INTEL_PMC_FIXED_RDPMC_BASE		(1 << 30)
+
 /*
  * All the fixed-mode PMCs are configured via this single MSR:
  */
-- 
2.17.1

