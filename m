Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83857278A43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgIYOBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:01:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:49919 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgIYOBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:01:31 -0400
IronPort-SDR: Euy6m9D6s1CMLOolgf+wjIM4OcZlk/DOoM/Ci35CJ0AwprVMw5slf9JywsAMaVcbe7FVIVYAzT
 G0p5wZesdAqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141546634"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="141546634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 06:50:30 -0700
IronPort-SDR: LCYM3+v6nxWAWmcETmpdelkbZXuPnpoRPYjX8Zxiy1bqdzvljf/9ziBRblaLCGVMkqwrfdUSBy
 5qCefoEFktdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="310824566"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2020 06:50:30 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, asit.k.mallick@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/3] perf/x86/intel/uncore: Update Ice Lake uncore units
Date:   Fri, 25 Sep 2020 06:49:04 -0700
Message-Id: <20200925134905.8839-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925134905.8839-1-kan.liang@linux.intel.com>
References: <20200925134905.8839-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There are some updates for the Icelake model specific uncore performance
monitors. (The update can be found at 10th generation intel core
processors families specification update Revision 004, ICL068)

1) Counter 0 of ARB uncore unit is not available for software use
2) The global 'enable bit' (bit 29) and 'freeze bit' (bit 31) of
   MSR_UNC_PERF_GLOBAL_CTRL cannot be used to control counter behavior.
   Needs to use local enable in event select MSR.

Accessing the modified bit/registers will be ignored by HW. Users may
observe inaccurate results with the current code.

The changes of the MSR_UNC_PERF_GLOBAL_CTRL imply that groups cannot be
read atomically anymore. Although the error of the result for a group
becomes a bit bigger, it still far lower than not using a group. The
group support is still kept. Only Remove the *_box() related
implementation.

Since the counter 0 of ARB uncore unit is not available, update the MSR
address for the ARB uncore unit.

There is no change for IMC uncore unit, which only include free-running
counters.

Fixes: 6e394376ee89 ("perf/x86/intel/uncore: Add Intel Icelake uncore support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index d2d43b6d6946..2bdfcf80b434 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -126,6 +126,10 @@
 #define ICL_UNC_CBO_0_PER_CTR0			0x702
 #define ICL_UNC_CBO_MSR_OFFSET			0x8
 
+/* ICL ARB register */
+#define ICL_UNC_ARB_PER_CTR			0x3b1
+#define ICL_UNC_ARB_PERFEVTSEL			0x3b3
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
@@ -313,6 +317,12 @@ void skl_uncore_cpu_init(void)
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
 }
 
+static struct intel_uncore_ops icl_uncore_msr_ops = {
+	.disable_event	= snb_uncore_msr_disable_event,
+	.enable_event	= snb_uncore_msr_enable_event,
+	.read_counter	= uncore_msr_read_counter,
+};
+
 static struct intel_uncore_type icl_uncore_cbox = {
 	.name		= "cbox",
 	.num_counters   = 4,
@@ -321,7 +331,7 @@ static struct intel_uncore_type icl_uncore_cbox = {
 	.event_ctl	= SNB_UNC_CBO_0_PERFEVTSEL0,
 	.event_mask	= SNB_UNC_RAW_EVENT_MASK,
 	.msr_offset	= ICL_UNC_CBO_MSR_OFFSET,
-	.ops		= &skl_uncore_msr_ops,
+	.ops		= &icl_uncore_msr_ops,
 	.format_group	= &snb_uncore_format_group,
 };
 
@@ -350,13 +360,25 @@ static struct intel_uncore_type icl_uncore_clockbox = {
 	.single_fixed	= 1,
 	.event_mask	= SNB_UNC_CTL_EV_SEL_MASK,
 	.format_group	= &icl_uncore_clock_format_group,
-	.ops		= &skl_uncore_msr_ops,
+	.ops		= &icl_uncore_msr_ops,
 	.event_descs	= icl_uncore_events,
 };
 
+static struct intel_uncore_type icl_uncore_arb = {
+	.name		= "arb",
+	.num_counters   = 1,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 44,
+	.perf_ctr	= ICL_UNC_ARB_PER_CTR,
+	.event_ctl	= ICL_UNC_ARB_PERFEVTSEL,
+	.event_mask	= SNB_UNC_RAW_EVENT_MASK,
+	.ops		= &icl_uncore_msr_ops,
+	.format_group	= &snb_uncore_format_group,
+};
+
 static struct intel_uncore_type *icl_msr_uncores[] = {
 	&icl_uncore_cbox,
-	&snb_uncore_arb,
+	&icl_uncore_arb,
 	&icl_uncore_clockbox,
 	NULL,
 };
@@ -374,7 +396,6 @@ void icl_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = icl_msr_uncores;
 	icl_uncore_cbox.num_boxes = icl_get_cbox_num();
-	snb_uncore_arb.ops = &skl_uncore_msr_ops;
 }
 
 static struct intel_uncore_type *tgl_msr_uncores[] = {
-- 
2.17.1

