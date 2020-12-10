Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674B02D6962
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404526AbgLJVFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393955AbgLJVFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:05:42 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs/gaudi: retry loading TPC f/w on -EINTR
Date:   Thu, 10 Dec 2020 23:04:50 +0200
Message-Id: <20201210210450.2179-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210210450.2179-1-ogabbay@kernel.org>
References: <20201210210450.2179-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If loading the firmware file for the TPC f/w was interrupted, try
to do it again, up to 5 times.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 88d0e4356d59..8c09e4466af8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -838,11 +838,17 @@ static int gaudi_init_tpc_mem(struct hl_device *hdev)
 	size_t fw_size;
 	void *cpu_addr;
 	dma_addr_t dma_handle;
-	int rc;
+	int rc, count = 5;
 
+again:
 	rc = request_firmware(&fw, GAUDI_TPC_FW_FILE, hdev->dev);
+	if (rc == -EINTR && count-- > 0) {
+		msleep(50);
+		goto again;
+	}
+
 	if (rc) {
-		dev_err(hdev->dev, "Firmware file %s is not found!\n",
+		dev_err(hdev->dev, "Failed to load firmware file %s\n",
 				GAUDI_TPC_FW_FILE);
 		goto out;
 	}
-- 
2.17.1

