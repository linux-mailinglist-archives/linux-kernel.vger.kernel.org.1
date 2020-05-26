Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86119CAB0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 21:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbgDBT6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 15:58:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:30535 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731823AbgDBT6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:58:40 -0400
IronPort-SDR: Lbrtsiv91lgAA92Oyj0IK/4HGNqvNhBMkz38nwYp0kfunSSzaUAzINiTRuppX4F34mOfEYQCRc
 Gd9H//bCVyMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 12:58:39 -0700
IronPort-SDR: tU6/jNkdsiiuD0tN4eL4XnBH7DbpSk0m1u9YbpcpV3Gwe8RxufSjalUvJp5iwtdWw5vd8W3NfU
 pdOF6xKKJ6cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="328936909"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2020 12:58:39 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2] perf/x86/intel/uncore: Add Comet Lake support
Date:   Thu,  2 Apr 2020 12:52:59 -0700
Message-Id: <1585857179-180207-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The uncore subsystem on Comet Lake is similar to Sky Lake.
The only difference is the new PCI IDs for IMC.

Share the perf code with Sky Lake.
Add new PCI IDs in the table.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Rebase on top of tip.git perf/core branch
  commit 629b3df7ecb0 ("Merge branch 'x86/cpu' into perf/core, to resolve conflict")

 arch/x86/events/intel/uncore.c     |  2 ++
 arch/x86/events/intel/uncore_snb.c | 66 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index cf76d66..b9c2876 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1514,6 +1514,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&skx_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&skl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&skl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&skl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&skl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&icl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_uncore_init),
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3de1065..5c40367 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -42,6 +42,17 @@
 #define PCI_DEVICE_ID_INTEL_WHL_UQ_IMC		0x3ed0
 #define PCI_DEVICE_ID_INTEL_WHL_4_UQ_IMC	0x3e34
 #define PCI_DEVICE_ID_INTEL_WHL_UD_IMC		0x3e35
+#define PCI_DEVICE_ID_INTEL_CML_H1_IMC		0x9b44
+#define PCI_DEVICE_ID_INTEL_CML_H2_IMC		0x9b54
+#define PCI_DEVICE_ID_INTEL_CML_H3_IMC		0x9b64
+#define PCI_DEVICE_ID_INTEL_CML_U1_IMC		0x9b51
+#define PCI_DEVICE_ID_INTEL_CML_U2_IMC		0x9b61
+#define PCI_DEVICE_ID_INTEL_CML_U3_IMC		0x9b71
+#define PCI_DEVICE_ID_INTEL_CML_S1_IMC		0x9b33
+#define PCI_DEVICE_ID_INTEL_CML_S2_IMC		0x9b43
+#define PCI_DEVICE_ID_INTEL_CML_S3_IMC		0x9b53
+#define PCI_DEVICE_ID_INTEL_CML_S4_IMC		0x9b63
+#define PCI_DEVICE_ID_INTEL_CML_S5_IMC		0x9b73
 #define PCI_DEVICE_ID_INTEL_ICL_U_IMC		0x8a02
 #define PCI_DEVICE_ID_INTEL_ICL_U2_IMC		0x8a12
 #define PCI_DEVICE_ID_INTEL_TGL_U1_IMC		0x9a02
@@ -771,6 +782,50 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_UD_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S4_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S5_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -863,6 +918,17 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(WHL_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
 	IMC_DEV(WHL_4_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
 	IMC_DEV(WHL_UD_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Dual Core */
+	IMC_DEV(CML_H1_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_H2_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_H3_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_U1_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_U2_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_U3_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S1_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S2_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S3_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S4_IMC, &skl_uncore_pci_driver),
+	IMC_DEV(CML_S5_IMC, &skl_uncore_pci_driver),
 	IMC_DEV(ICL_U_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	IMC_DEV(ICL_U2_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
 	{  /* end marker */ }
-- 
2.7.4

