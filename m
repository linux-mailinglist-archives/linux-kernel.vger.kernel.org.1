Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CDB2A6152
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgKDKOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgKDKOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:14:37 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E5742224E;
        Wed,  4 Nov 2020 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604484876;
        bh=460hFjqB763PhSAMV3NkaCzxWFqVbXdGdkWowy5WOAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTLOMNMcB+shhvqxwmVvo51xzqsGLRwPFspAEap8+c7Ui4DBz3SIhupMsyau9aAAZ
         coYtYCgfTnf8+wjcB/q2fiSMrG2tNdjO4UBVXswWcbiIB83FCf4wiirFHkum8WIxSe
         BtT3UZrZ87c6V1Tc8UHO/uCNauki0E90LsERQEkg=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs/gaudi: fetch PLL info from FW
Date:   Wed,  4 Nov 2020 12:14:27 +0200
Message-Id: <20201104101429.15594-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104101429.15594-1-ogabbay@kernel.org>
References: <20201104101429.15594-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Once FW security is enabled there is no access to PLL registers,
need to read values from FW using a dedicated interface.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 26 +++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h  |  4 ++
 drivers/misc/habanalabs/gaudi/gaudi.c        | 41 +++++++++++++++-----
 3 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 8de6a8690b1b..d84a70ec0ce1 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -448,6 +448,32 @@ int hl_fw_cpucp_total_energy_get(struct hl_device *hdev, u64 *total_energy)
 	return rc;
 }
 
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev,
+		enum cpucp_pll_type_attributes pll_type,
+		enum cpucp_pll_reg_attributes pll_reg,
+		u32 *pll_info)
+{
+	struct cpucp_packet pkt;
+	long result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PLL_REG_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.pll_type = __cpu_to_le16(pll_type);
+	pkt.pll_reg = __cpu_to_le16(pll_reg);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+			HL_CPUCP_INFO_TIMEOUT_USEC, &result);
+	if (rc)
+		dev_err(hdev->dev, "Failed to read PLL info, error %d\n", rc);
+
+	*pll_info = result;
+
+	return rc;
+}
+
 static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 		u32 cpu_security_boot_status_reg)
 {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index fee68fc121d7..ce516e9e1ebe 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2113,6 +2113,10 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
 int hl_fw_cpucp_total_energy_get(struct hl_device *hdev,
 			u64 *total_energy);
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev,
+		enum cpucp_pll_type_attributes pll_type,
+		enum cpucp_pll_reg_attributes pll_reg,
+		u32 *pll_info);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
 			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 5df06c63ceb8..9e38ac6f7264 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -673,16 +673,33 @@ static int gaudi_early_fini(struct hl_device *hdev)
  * @hdev: pointer to hl_device structure
  *
  */
-static void gaudi_fetch_psoc_frequency(struct hl_device *hdev)
+static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 trace_freq = 0;
-	u32 pll_clk = 0;
-	u32 div_fctr = RREG32(mmPSOC_CPU_PLL_DIV_FACTOR_2);
-	u32 div_sel = RREG32(mmPSOC_CPU_PLL_DIV_SEL_2);
-	u32 nr = RREG32(mmPSOC_CPU_PLL_NR);
-	u32 nf = RREG32(mmPSOC_CPU_PLL_NF);
-	u32 od = RREG32(mmPSOC_CPU_PLL_OD);
+	u32 trace_freq = 0, pll_clk = 0;
+	u32 div_fctr, div_sel, nr, nf, od;
+	int rc;
+
+	if (hdev->asic_prop.fw_security_disabled) {
+		div_fctr = RREG32(mmPSOC_CPU_PLL_DIV_FACTOR_2);
+		div_sel = RREG32(mmPSOC_CPU_PLL_DIV_SEL_2);
+		nr = RREG32(mmPSOC_CPU_PLL_NR);
+		nf = RREG32(mmPSOC_CPU_PLL_NF);
+		od = RREG32(mmPSOC_CPU_PLL_OD);
+	} else {
+		rc = hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
+				cpucp_pll_div_factor_reg, &div_fctr);
+		rc |= hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
+				cpucp_pll_div_sel_reg, &div_sel);
+		rc |= hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
+				cpucp_pll_nr_reg, &nr);
+		rc |= hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
+				cpucp_pll_nf_reg, &nf);
+		rc |= hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
+				cpucp_pll_od_reg, &od);
+		if (rc)
+			return rc;
+	}
 
 	if (div_sel == DIV_SEL_REF_CLK || div_sel == DIV_SEL_DIVIDED_REF) {
 		if (div_sel == DIV_SEL_REF_CLK)
@@ -706,6 +723,8 @@ static void gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 	prop->psoc_pci_pll_nf = nf;
 	prop->psoc_pci_pll_od = od;
 	prop->psoc_pci_pll_div_factor = div_fctr;
+
+	return 0;
 }
 
 static int _gaudi_init_tpc_mem(struct hl_device *hdev,
@@ -1319,7 +1338,11 @@ static int gaudi_late_init(struct hl_device *hdev)
 
 	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_INTS_REGISTER);
 
-	gaudi_fetch_psoc_frequency(hdev);
+	rc = gaudi_fetch_psoc_frequency(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to fetch psoc frequency\n");
+		goto disable_pci_access;
+	}
 
 	rc = gaudi_mmu_clear_pgt_range(hdev);
 	if (rc) {
-- 
2.17.1

