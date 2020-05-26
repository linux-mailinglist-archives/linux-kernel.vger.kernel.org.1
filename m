Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22B71C8BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEGNPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 09:15:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:20457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgEGNPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:15:07 -0400
IronPort-SDR: O+JV0cHl8O1N+PMXwMXK47YRWjv8OyIDj5KvwNra425p8nxvZdwIyapP/ZJKfBI3FhJp60vJfJ
 2V/I3wEAVhtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 06:15:06 -0700
IronPort-SDR: 8RSo0c3f2gSplsUiw0cxweuZNAgLDmDNfEWoYJnnNENEuf7bYXpmNJIA3/PIJdQ7YUowPVeCmK
 c53L2dJHdaYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="305116684"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by FMSMGA003.fm.intel.com with ESMTP; 07 May 2020 06:15:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/rapl: Add Ice Lake RAPL support
Date:   Thu,  7 May 2020 06:14:18 -0700
Message-Id: <1588857258-38213-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Enable RAPL support for Intel Ice Lake X and Ice Lake D.

For RAPL support, it is identical to Sky Lake X.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index a5dbd25..9e1e141 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -738,6 +738,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&model_hsw),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&model_hsx),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
 	{},
-- 
2.7.4

