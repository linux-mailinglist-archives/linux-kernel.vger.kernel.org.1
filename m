Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1F2A65F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgKDOJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbgKDOJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:23 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5467C2236F;
        Wed,  4 Nov 2020 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498962;
        bh=fv6XfjHG8ZIIsa87jtEIKZWaWa19bUpBegHs0UJskMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSG6+59ArlhD++hfW8cEM37Nd528pFuXXug9hcVFYzfjpledvPpqflnSLs4G2oSr6
         ahM7dErxyvGr+wQyJJRixYcs77p1EHux/P0Qg4oHPMmvTQQf53hIhZ+CW2eG1BHkaD
         tTC5QbAM40XZu+KWIs2sybjtp36lC61svikXw+00=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Igor Grinberg <igrinberg@habana.ai>
Subject: [PATCH] habanalabs/gaudi: remove pcie_en strap toggle
Date:   Wed,  4 Nov 2020 16:09:00 +0200
Message-Id: <20201104140908.10178-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Grinberg <igrinberg@habana.ai>

Since the very large grace period is over and this functionality
prevents us to implement the new reset sequence and apply security
settings, we need to remove the code toggling the PCIE_EN bit in the
straps register.
Remove it for good.

Signed-off-by: Igor Grinberg <igrinberg@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ae4f3669261d..c075f7f10843 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3871,7 +3871,7 @@ static int gaudi_hw_init(struct hl_device *hdev)
 static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u32 status, reset_timeout_ms, cpu_timeout_ms, boot_strap = 0;
+	u32 status, reset_timeout_ms, cpu_timeout_ms;
 
 	if (!hard_reset) {
 		dev_err(hdev->dev, "GAUDI doesn't support soft-reset\n");
@@ -3903,16 +3903,6 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	/* Tell ASIC not to re-initialize PCIe */
 	WREG32(mmPREBOOT_PCIE_EN, LKD_HARD_RESET_MAGIC);
 
-	boot_strap = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
-
-	/* H/W bug WA:
-	 * rdata[31:0] = strap_read_val;
-	 * wdata[31:0] = rdata[30:21],1'b0,rdata[20:0]
-	 */
-	boot_strap = (((boot_strap & 0x7FE00000) << 1) |
-			(boot_strap & 0x001FFFFF));
-	WREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS, boot_strap & ~0x2);
-
 	/* Restart BTL/BLR upon hard-reset */
 	if (hdev->asic_prop.fw_security_disabled)
 		WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
@@ -3935,8 +3925,6 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 			"Timeout while waiting for device to reset 0x%x\n",
 			status);
 
-	WREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS, boot_strap);
-
 	if (gaudi) {
 		gaudi->hw_cap_initialized &= ~(HW_CAP_CPU | HW_CAP_CPU_Q |
 				HW_CAP_HBM | HW_CAP_PCI_DMA |
-- 
2.17.1

