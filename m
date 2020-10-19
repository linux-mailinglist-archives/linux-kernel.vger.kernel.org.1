Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12420292A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgJSPgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:36:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:27586 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbgJSPgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:36:17 -0400
IronPort-SDR: UerDYQGb9l/5xARUr97VeCbmH2le/5LC5saEDytHUukwfskmmYwKcB/p6Ff4pTc+/m3LzuiX5R
 bDB/UtQuAfwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="154839780"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="154839780"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 08:36:15 -0700
IronPort-SDR: Wc9ReX2xD8saHrGMLgZValDvl1fB6Ovu6yFX7Xihy8FoKYyWWXWo5IdxV+YEKlnZG21viXFjP5
 yVt3T736uYJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="465569437"
Received: from ssp-rkls-cdi470.jf.intel.com ([10.54.55.84])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2020 08:36:16 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/4] perf/x86/cstate: Add Rocket Lake CPU support
Date:   Mon, 19 Oct 2020 08:35:26 -0700
Message-Id: <20201019153528.13850-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019153528.13850-1-kan.liang@linux.intel.com>
References: <20201019153528.13850-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From the perspective of Intel cstate residency counters, Rocket Lake is
the same as Ice Lake and Tiger Lake. Share the code with them. Update
the comments for Rocket Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 442e1ed4acd4..a161a0bb4c42 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -51,46 +51,46 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT
+ *						TNT,RKL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL
+ *						ICL,TGL,RKL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,TGL,TNT
+ *						KBL,CML,ICL,TGL,TNT,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL,KBL,CML,ICL,TGL,TNT
+ *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT
+ *						TNT,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL,TGL
+ *						KBL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT
+ *						TNT,RKL
  *			       Scope: Package (physical package)
  *
  */
@@ -649,6 +649,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.25.1

