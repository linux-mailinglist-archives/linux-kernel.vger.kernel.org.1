Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44952E74DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgL2Vhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgL2Vhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:37:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6215222225;
        Tue, 29 Dec 2020 21:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609277822;
        bh=wyTNMhnhZthRPoza2DR8Wr/bx4nAWlyeuYeELmYoeRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcRlFLG744NqSTr7ZusEkxrxl7oS3C7WhapKbTg6JgJ4rdoABOyXWCNu2VBTvBRGh
         4tNBEPLr8jAFhUQOmmRhQQXi/nIP8mshKDR9nL5dLzzjggDIeEvspDukg0AVayX9v1
         r/8NzSIAR06SfqZmsi5bMo2u/+jPNP6tSkwL+mU2Th3UQDOPAtKAc/WkaEaPQo8aG2
         7QMaX8CVNrFg60Aak+uOiUnuKCtI3h1cOGsfrL1eXZyAoJwGwVzzUQZYF0CD1CwdjN
         oZ+2c3XBcdBYzhmbjuqZb8+loe+UAR0em96KyLcTceWP2WIL2iqHONxrQe2hVz2sBB
         bqRd0WFfTwlmQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/8] habanalabs/gaudi: add debug prints for security status
Date:   Tue, 29 Dec 2020 23:36:49 +0200
Message-Id: <20201229213653.29749-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229213653.29749-1-ogabbay@kernel.org>
References: <20201229213653.29749-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to have more information while debugging boot issues,
we should print the firmware security status at every boot stage.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 20f77f58edef..94dda314233b 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -654,6 +654,9 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		prop->fw_security_disabled = true;
 	}
 
+	dev_dbg(hdev->dev, "Firmware preboot security status %#x\n",
+			security_status);
+
 	dev_dbg(hdev->dev, "Firmware preboot hard-reset is %s\n",
 			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
 
@@ -748,6 +751,10 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		if (prop->fw_boot_cpu_security_map &
 				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
+
+		dev_dbg(hdev->dev,
+			"Firmware boot CPU security status %#x\n",
+			prop->fw_boot_cpu_security_map);
 	}
 
 	dev_dbg(hdev->dev, "Firmware boot CPU hard-reset is %s\n",
@@ -832,6 +839,10 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		if (prop->fw_app_security_map &
 				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
+
+		dev_dbg(hdev->dev,
+			"Firmware application CPU security status %#x\n",
+			prop->fw_app_security_map);
 	}
 
 	dev_dbg(hdev->dev, "Firmware application CPU hard-reset is %s\n",
-- 
2.25.1

