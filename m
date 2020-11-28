Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1A2C754B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbgK1WXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 17:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731877AbgK1WW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:22:56 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E68C22370;
        Sat, 28 Nov 2020 22:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606602136;
        bh=YMvgZQokqx1UW0diE7v6izOmhhHChC0C4Ev03Ee4mqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNSNQJ+tCTVdBY/PJBuINfioXg9c4GTPy95ZkjDk73Ps0fAcBb/d8+QDjr2tz1fj3
         D0/jvpOvQkWh6fjLX30TGUMATx4HXLLC3isuSsA/nIvR9xsJ/RxcuEDg43TDQYRTA6
         02Vs44+68bTJlasAuq/qypEkiRxgk95arwfO7LE8=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: change messages to debug level
Date:   Sun, 29 Nov 2020 00:22:05 +0200
Message-Id: <20201128222207.23722-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201128222207.23722-1-ogabbay@kernel.org>
References: <20201128222207.23722-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some messages should be changed to debug mode as we want to keep
minimal prints during normal operation of the device.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index c4a8d6ca34bb..0e1c629e9800 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -526,7 +526,7 @@ static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 
 	security_val = RREG32(cpu_security_boot_status_reg);
 	if (security_val & CPU_BOOT_DEV_STS0_ENABLED)
-		dev_info(hdev->dev, "Device security status %#x\n",
+		dev_dbg(hdev->dev, "Device security status %#x\n",
 				security_val);
 }
 
@@ -806,7 +806,7 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			hdev->asic_prop.hard_reset_done_by_fw = true;
 	}
 
-	dev_info(hdev->dev, "Firmware hard-reset is %s\n",
+	dev_dbg(hdev->dev, "Firmware hard-reset is %s\n",
 		hdev->asic_prop.hard_reset_done_by_fw ? "enabled" : "disabled");
 
 	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 568afe1b6849..aac3c9c5a2e0 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1732,7 +1732,7 @@ static int gaudi_enable_msi_single(struct hl_device *hdev)
 {
 	int rc, irq;
 
-	dev_info(hdev->dev, "Working in single MSI IRQ mode\n");
+	dev_dbg(hdev->dev, "Working in single MSI IRQ mode\n");
 
 	irq = gaudi_pci_irq_vector(hdev, 0, false);
 	rc = request_irq(irq, gaudi_irq_handler_single, 0,
-- 
2.17.1

