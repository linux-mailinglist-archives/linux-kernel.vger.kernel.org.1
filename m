Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2122D6961
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403858AbgLJVFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393954AbgLJVFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:05:42 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: adjust pci controller init to new firmware
Date:   Thu, 10 Dec 2020 23:04:49 +0200
Message-Id: <20201210210450.2179-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the firmware security is enabled, the pcie_aux_dbi_reg_addr
register in the PCI controller is blocked. Therefore, ignore
the result of writing to this register and assume it worked. Also
remove the prints on errors in the internal ELBI write function.

If the security is enabled, the firmware is responsible for setting
this register correctly so we won't have any problem.

If the security is disabled, the write will work (unless something
is totally broken at the PCI level and then the whole sequence
will fail).

In addition, remove a write to register pcie_aux_dbi_reg_addr+4,
which was never actually needed.

Moreover, PCIE_DBI registers are blocked to access from host when
firmware security is enabled. Use a different register to flush the
writes.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/pci.c          | 28 +++++++++++--------
 drivers/misc/habanalabs/gaudi/gaudi.c         |  4 +--
 .../misc/habanalabs/gaudi/gaudi_coresight.c   |  3 +-
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
index 923b2606e29f..b4725e6101f6 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci.c
@@ -130,10 +130,8 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE)
 		return 0;
 
-	if (val & PCI_CONFIG_ELBI_STS_ERR) {
-		dev_err(hdev->dev, "Error writing to ELBI\n");
+	if (val & PCI_CONFIG_ELBI_STS_ERR)
 		return -EIO;
-	}
 
 	if (!(val & PCI_CONFIG_ELBI_STS_MASK)) {
 		dev_err(hdev->dev, "ELBI write didn't finish in time\n");
@@ -160,8 +158,12 @@ int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data)
 
 	dbi_offset = addr & 0xFFF;
 
-	rc = hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0x00300000);
-	rc |= hl_pci_elbi_write(hdev, prop->pcie_dbi_base_address + dbi_offset,
+	/* Ignore result of writing to pcie_aux_dbi_reg_addr as it could fail
+	 * in case the firmware security is enabled
+	 */
+	hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0x00300000);
+
+	rc = hl_pci_elbi_write(hdev, prop->pcie_dbi_base_address + dbi_offset,
 				data);
 
 	if (rc)
@@ -244,9 +246,11 @@ int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
 
 	rc |= hl_pci_iatu_write(hdev, offset + 0x4, ctrl_reg_val);
 
-	/* Return the DBI window to the default location */
-	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
-	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr + 4, 0);
+	/* Return the DBI window to the default location
+	 * Ignore result of writing to pcie_aux_dbi_reg_addr as it could fail
+	 * in case the firmware security is enabled
+	 */
+	hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
 
 	if (rc)
 		dev_err(hdev->dev, "failed to map bar %u to 0x%08llx\n",
@@ -294,9 +298,11 @@ int hl_pci_set_outbound_region(struct hl_device *hdev,
 	/* Enable */
 	rc |= hl_pci_iatu_write(hdev, 0x004, 0x80000000);
 
-	/* Return the DBI window to the default location */
-	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
-	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr + 4, 0);
+	/* Return the DBI window to the default location
+	 * Ignore result of writing to pcie_aux_dbi_reg_addr as it could fail
+	 * in case the firmware security is enabled
+	 */
+	hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b0528883a995..88d0e4356d59 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3761,7 +3761,7 @@ static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 static void gaudi_pre_hw_init(struct hl_device *hdev)
 {
 	/* Perform read from the device to make sure device is up */
-	RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+	RREG32(mmHW_STATE);
 
 	if (hdev->asic_prop.fw_security_disabled) {
 		/* Set the access through PCI bars (Linux driver only) as
@@ -3847,7 +3847,7 @@ static int gaudi_hw_init(struct hl_device *hdev)
 	}
 
 	/* Perform read from the device to flush all configuration */
-	RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+	RREG32(mmHW_STATE);
 
 	return 0;
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index 2e3612e1ee28..88a09d42e111 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -9,6 +9,7 @@
 #include "../include/gaudi/gaudi_coresight.h"
 #include "../include/gaudi/asic_reg/gaudi_regs.h"
 #include "../include/gaudi/gaudi_masks.h"
+#include "../include/gaudi/gaudi_reg_map.h"
 
 #include <uapi/misc/habanalabs.h>
 #define SPMU_SECTION_SIZE		MME0_ACC_SPMU_MAX_OFFSET
@@ -874,7 +875,7 @@ int gaudi_debug_coresight(struct hl_device *hdev, void *data)
 	}
 
 	/* Perform read from the device to flush all configuration */
-	RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+	RREG32(mmHW_STATE);
 
 	return rc;
 }
-- 
2.17.1

