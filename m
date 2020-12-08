Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A7B2D3327
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgLHUQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:26028 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbgLHUNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:13:10 -0500
IronPort-SDR: mgz76JDZK1hYo8CommT5pH5e1X3E+biYd3nWIV6+O+giQZ0jHi6LRtfeMgjRau0drnTWnCYHkY
 S5iG7IG3BGAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="153200904"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="153200904"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 12:06:56 -0800
IronPort-SDR: LcBgJBjwVqhEq2UGQLE+FMAKGdu2reCISnQEUBB2BKbkxNdu9ggIxDHEfbtfNcrhIwZ4jEelX/
 JLcnqPrRwjIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="542141614"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga005.fm.intel.com with ESMTP; 08 Dec 2020 12:06:55 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, yunying.sun@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Add Tremont Topdown support
Date:   Tue,  8 Dec 2020 12:05:52 -0800
Message-Id: <1607457952-3519-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Tremont has four L1 Topdown events, TOPDOWN_FE_BOUND.ALL,
TOPDOWN_BAD_SPECULATION.ALL, TOPDOWN_BE_BOUND.ALL and
TOPDOWN_RETIRING.ALL. They are available on GP counters.

Export them to sysfs and facilitate the perf stat tool.

 $perf stat --topdown -- sleep 1

 Performance counter stats for 'sleep 1':

            retiring      bad speculation       frontend bound
backend bound
               24.9%                16.8%                31.7%
26.6%

       1.001224610 seconds time elapsed

       0.001150000 seconds user
       0.000000000 seconds sys

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 546cc89..2239b22 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -1901,6 +1901,19 @@ static __initconst const u64 tnt_hw_cache_extra_regs
 	},
 };
 
+EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_tnt,        "event=0x71,umask=0x0");
+EVENT_ATTR_STR(topdown-retiring,       td_retiring_tnt,        "event=0xc2,umask=0x0");
+EVENT_ATTR_STR(topdown-bad-spec,       td_bad_spec_tnt,        "event=0x73,umask=0x6");
+EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_tnt,        "event=0x74,umask=0x0");
+
+static struct attribute *tnt_events_attrs[] = {
+	EVENT_PTR(td_fe_bound_tnt),
+	EVENT_PTR(td_retiring_tnt),
+	EVENT_PTR(td_bad_spec_tnt),
+	EVENT_PTR(td_be_bound_tnt),
+	NULL,
+};
+
 static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
 	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
 	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x800ff0ffffff9fffull, RSP_0),
@@ -5174,6 +5187,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.get_event_constraints = tnt_get_event_constraints;
+		td_attr = tnt_events_attrs;
 		extra_attr = slm_format_attr;
 		pr_cont("Tremont events, ");
 		name = "Tremont";
-- 
2.7.4

