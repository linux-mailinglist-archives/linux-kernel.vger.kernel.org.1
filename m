Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F396292A88
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgJSPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:36:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:27586 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbgJSPgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:36:15 -0400
IronPort-SDR: j7WgUsF1PKXIHIHgw9QuXhrM8X0TdfpVt5pHSJXz2wV2CkEzPhoSZg8oDkVY7RKS+8BB/yjXrY
 DqID7HWG1q4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="154839776"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="154839776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 08:36:14 -0700
IronPort-SDR: M16PbTSby3rYVxwbu/yW8op8C8ul79HAza3egza1WDu8+IfrQc6/7+q5g6sgEtgx1TVmAwwOj+
 tse9P9YBGFlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="465569432"
Received: from ssp-rkls-cdi470.jf.intel.com ([10.54.55.84])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2020 08:36:14 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/4] perf/x86/intel: Add Rocket Lake CPU support
Date:   Mon, 19 Oct 2020 08:35:25 -0700
Message-Id: <20201019153528.13850-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From the perspective of Intel PMU, Rocket Lake is the same as Ice Lake
and Tiger Lake. Share the perf code with them.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bdf28d2f27e8..4def6fa63875 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5425,6 +5425,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ICELAKE:
 	case INTEL_FAM6_TIGERLAKE_L:
 	case INTEL_FAM6_TIGERLAKE:
+	case INTEL_FAM6_ROCKETLAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
-- 
2.25.1

