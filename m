Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9712A34B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgKBT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:58:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgKBT6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:58:09 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D26422268;
        Mon,  2 Nov 2020 19:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604347088;
        bh=ejE9iILqVYTShF72EFQ6/LSqxfheCsrQNtzmn9GbvXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YToVwpXDU+K++OZA0B0sPbp8TERyKc+2KQjbvx+ssfc7X+G5cSfa/qJZdBBXVrSzD
         TTTbXwGZ9m3KSYFj+pGNzS+mdVBpgpn9mKPOWn2mEiEpIcPEkcNIAv8Ih3gTWtIVRO
         6lo0HtewBq02ihBC0gWi65pThKeokWYktIB1cgH8=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: minimize prints when everything is fine
Date:   Mon,  2 Nov 2020 21:57:58 +0200
Message-Id: <20201102195802.10608-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102195802.10608-1-ogabbay@kernel.org>
References: <20201102195802.10608-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to print when the driver starts to initialize the H/W. Drivers
should be silent when everything is OK.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 --
 drivers/misc/habanalabs/goya/goya.c   | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2910f427c716..9d9d22c4452c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2947,8 +2947,6 @@ static int gaudi_hw_init(struct hl_device *hdev)
 {
 	int rc;
 
-	dev_info(hdev->dev, "Starting initialization of H/W\n");
-
 	gaudi_pre_hw_init(hdev);
 
 	gaudi_init_pci_dma_qmans(hdev);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5db52064ed9e..f41fe748f1ca 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2505,8 +2505,6 @@ static int goya_hw_init(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int rc;
 
-	dev_info(hdev->dev, "Starting initialization of H/W\n");
-
 	/* Perform read from the device to make sure device is up */
 	RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
 
-- 
2.17.1

