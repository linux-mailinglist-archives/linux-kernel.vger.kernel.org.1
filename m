Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C92854BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgJFWrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:47:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:56741 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgJFWrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:47:18 -0400
IronPort-SDR: UkaWsmNA0+BpStqISKpI+Vj7Z2oY2w03G4+L7ywOmYT9Qz6jzDLOEDI0RZ4OHOhLEMV+3giqhi
 JPArPk2vf3zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="162114472"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="162114472"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 15:47:17 -0700
IronPort-SDR: 3GSeBuX9gYBXk59hSX2MWNh6zHH/bMul9sxxNhrsEMMhC/tKkZaNgMkzdOfvIwuTXcNgIiKWwK
 MPBrAcx+1hBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="518529577"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2020 15:47:17 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 2AE01580782;
        Tue,  6 Oct 2020 15:47:17 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 2/3] platform/x86: intel_pmc_core: Fix TigerLake power gating status map
Date:   Tue,  6 Oct 2020 15:47:01 -0700
Message-Id: <20201006224702.12697-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201006224702.12697-1-david.e.box@linux.intel.com>
References: <20201006224702.12697-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

TigerLake's LPM power gating status register has errors in the bit-to-name
mapping as well as with the marked reserved bits according to the actual
implementation. Hence, update the right bit-to-name mapping and the
reserved bits in accordance with actual implementation.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index ed9fdf7c8928..cf4006e08c69 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -426,30 +426,30 @@ static const struct pmc_bit_map tgl_clocksource_status_map[] = {
 };
 
 static const struct pmc_bit_map tgl_power_gating_status_map[] = {
-	{"SPI_PG_STS",				BIT(2)},
-	{"xHCI_PG_STS",				BIT(3)},
-	{"PCIe_Ctrller_A_PG_STS",		BIT(4)},
-	{"PCIe_Ctrller_B_PG_STS",		BIT(5)},
-	{"PCIe_Ctrller_C_PG_STS",		BIT(6)},
-	{"GBE_PG_STS",				BIT(7)},
-	{"SATA_PG_STS",				BIT(8)},
-	{"HDA0_PG_STS",				BIT(9)},
-	{"HDA1_PG_STS",				BIT(10)},
-	{"HDA2_PG_STS",				BIT(11)},
-	{"HDA3_PG_STS",				BIT(12)},
-	{"PCIe_Ctrller_D_PG_STS",		BIT(13)},
-	{"ISIO_PG_STS",				BIT(14)},
-	{"SMB_PG_STS",				BIT(16)},
-	{"ISH_PG_STS",				BIT(17)},
-	{"ITH_PG_STS",				BIT(19)},
-	{"SDX_PG_STS",				BIT(20)},
-	{"xDCI_PG_STS",				BIT(25)},
-	{"DCI_PG_STS",				BIT(26)},
-	{"CSME0_PG_STS",			BIT(27)},
-	{"CSME_KVM_PG_STS",			BIT(28)},
-	{"CSME1_PG_STS",			BIT(29)},
-	{"CSME_CLINK_PG_STS",			BIT(30)},
-	{"CSME2_PG_STS",			BIT(31)},
+	{"CSME_PG_STS",				BIT(0)},
+	{"SATA_PG_STS",				BIT(1)},
+	{"xHCI_PG_STS",				BIT(2)},
+	{"UFSX2_PG_STS",			BIT(3)},
+	{"OTG_PG_STS",				BIT(5)},
+	{"SPA_PG_STS",				BIT(6)},
+	{"SPB_PG_STS",				BIT(7)},
+	{"SPC_PG_STS",				BIT(8)},
+	{"SPD_PG_STS",				BIT(9)},
+	{"SPE_PG_STS",				BIT(10)},
+	{"SPF_PG_STS",				BIT(11)},
+	{"LSX_PG_STS",				BIT(13)},
+	{"P2SB_PG_STS",				BIT(14)},
+	{"PSF_PG_STS",				BIT(15)},
+	{"SBR_PG_STS",				BIT(16)},
+	{"OPIDMI_PG_STS",			BIT(17)},
+	{"THC0_PG_STS",				BIT(18)},
+	{"THC1_PG_STS",				BIT(19)},
+	{"GBETSN_PG_STS",			BIT(20)},
+	{"GBE_PG_STS",				BIT(21)},
+	{"LPSS_PG_STS",				BIT(22)},
+	{"MMP_UFSX2_PG_STS",			BIT(23)},
+	{"MMP_UFSX2B_PG_STS",			BIT(24)},
+	{"FIA_PG_STS",				BIT(25)},
 	{}
 };
 
-- 
2.20.1

