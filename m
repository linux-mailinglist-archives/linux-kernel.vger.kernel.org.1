Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED95B292A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgJSPgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:36:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:27597 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbgJSPgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:36:18 -0400
IronPort-SDR: VrA0WIjrCCVGeMPLyB/LaRuTy8SjFkVZnx9qkB3ZHf4TrceSg0VByNefDUcxhRzEe5WRJNatzn
 Xy0rGZpMQdpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="154839786"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="154839786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 08:36:17 -0700
IronPort-SDR: 1fwBb7bHp1v4DiNzVw1LFjXNfrQJ713yWSA5xULdA6/zc+0SKFpIkF08GU7giSnDQndLgPaTvY
 qqbSN98WbqCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="465569445"
Received: from ssp-rkls-cdi470.jf.intel.com ([10.54.55.84])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2020 08:36:18 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/4] perf/x86/intel/uncore: Add Rocket Lake support
Date:   Mon, 19 Oct 2020 08:35:28 -0700
Message-Id: <20201019153528.13850-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019153528.13850-1-kan.liang@linux.intel.com>
References: <20201019153528.13850-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For Rocket Lake, the MSR uncore, e.g., CBOX, ARB and CLOCKBOX, are the
same as Tiger Lake. Share the perf code with it.

For Rocket Lake and Tiger Lake, the 8th CBOX is not mapped into a
different MSR space anymore. Add rkl_uncore_msr_init_box() to replace
skl_uncore_msr_init_box().

The IMC uncore is the similar to Ice Lake. Add new PCIIDs of IMC for
Rocket Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |  6 ++++++
 arch/x86/events/intel/uncore_snb.c | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86d012b3e0b4..1db6a7113bdb 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1636,6 +1636,11 @@ static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst = {
 	.mmio_init = tgl_l_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun rkl_uncore_init __initconst = {
+	.cpu_init = tgl_uncore_cpu_init,
+	.pci_init = skl_uncore_pci_init,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1683,6 +1688,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&tgl_l_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index de3d9621b694..6bbf54bf28b9 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -60,7 +60,8 @@
 #define PCI_DEVICE_ID_INTEL_TGL_U3_IMC		0x9a12
 #define PCI_DEVICE_ID_INTEL_TGL_U4_IMC		0x9a14
 #define PCI_DEVICE_ID_INTEL_TGL_H_IMC		0x9a36
-
+#define PCI_DEVICE_ID_INTEL_RKL_1_IMC		0x4c43
+#define PCI_DEVICE_ID_INTEL_RKL_2_IMC		0x4c53
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -405,6 +406,12 @@ static struct intel_uncore_type *tgl_msr_uncores[] = {
 	NULL,
 };
 
+static void rkl_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+}
+
 void tgl_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = tgl_msr_uncores;
@@ -412,6 +419,7 @@ void tgl_uncore_cpu_init(void)
 	icl_uncore_cbox.ops = &skl_uncore_msr_ops;
 	icl_uncore_clockbox.ops = &skl_uncore_msr_ops;
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
+	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
 enum {
@@ -880,6 +888,14 @@ static const struct pci_device_id icl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICL_U2_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RKL_1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RKL_2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -973,6 +989,8 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(CML_S5_IMC, &skl_uncore_pci_driver),
 	IMC_DEV(ICL_U_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	IMC_DEV(ICL_U2_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
+	IMC_DEV(RKL_1_IMC, &icl_uncore_pci_driver),
+	IMC_DEV(RKL_2_IMC, &icl_uncore_pci_driver),
 	{  /* end marker */ }
 };
 
-- 
2.25.1

