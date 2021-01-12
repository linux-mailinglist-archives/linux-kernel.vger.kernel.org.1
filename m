Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703062F39B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406379AbhALTKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:10:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406210AbhALTJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:09:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E0B323107;
        Tue, 12 Jan 2021 19:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478558;
        bh=pEd5mOkGbeo1XNWPByxMQx6S3nSjCeApWjn6kvYzM9s=;
        h=From:To:Cc:Subject:Date:From;
        b=eFh7oRTS1IxZgKWu02RvrclusbWO7i1UH7zrsU3S3F6pcYOkzqhvDMdMCuAsEiwQA
         3e79fSg6bz1uKM+AtruyaWXuhjv9I6vEwiH0zSl49WzfHnmmIqXjYIng6W3Hb3KoCi
         62ARt7hSnCxhOfiy3n4OWPTT2Z8r+oV4G18yRvuTS893wXWzga6+3Cq0H1rUI+5vWO
         fAKDhXa7WJSt+h9kkZG8ycCd4L88tNkVGUZqcFo8wtrEplbRPQAhr1rP+178sio0sk
         /+KyQruMpiKMjo9Vw4yJdekRF59JkUGtPxvm2z1fEkjlJkCuu5lSQIZ30Dg5ww7YMF
         jyRABJWOcwguw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/4] habanalabs: Use 'dma_set_mask_and_coherent()'
Date:   Tue, 12 Jan 2021 21:09:12 +0200
Message-Id: <20210112190915.21164-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Axe 'hl_pci_set_dma_mask()' and replace it with an equivalent
'dma_set_mask_and_coherent()' call.

This makes the code a bit less verbose.

It also removes an erroneous comment, because 'hl_pci_set_dma_mask()'
does not try to use a fall-back value.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/pci/pci.c | 43 ++++--------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index c56ec1574127..b799f9258fb0 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -307,40 +307,6 @@ int hl_pci_set_outbound_region(struct hl_device *hdev,
 	return rc;
 }
 
-/**
- * hl_pci_set_dma_mask() - Set DMA masks for the device.
- * @hdev: Pointer to hl_device structure.
- *
- * This function sets the DMA masks (regular and consistent) for a specified
- * value. If it doesn't succeed, it tries to set it to a fall-back value
- *
- * Return: 0 on success, non-zero for failure.
- */
-static int hl_pci_set_dma_mask(struct hl_device *hdev)
-{
-	struct pci_dev *pdev = hdev->pdev;
-	int rc;
-
-	/* set DMA mask */
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(hdev->dma_mask));
-	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to set pci dma mask to %d bits, error %d\n",
-			hdev->dma_mask, rc);
-		return rc;
-	}
-
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(hdev->dma_mask));
-	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to set pci consistent dma mask to %d bits, error %d\n",
-			hdev->dma_mask, rc);
-		return rc;
-	}
-
-	return 0;
-}
-
 /**
  * hl_pci_init() - PCI initialization code.
  * @hdev: Pointer to hl_device structure.
@@ -377,9 +343,14 @@ int hl_pci_init(struct hl_device *hdev)
 		goto unmap_pci_bars;
 	}
 
-	rc = hl_pci_set_dma_mask(hdev);
-	if (rc)
+	rc = dma_set_mask_and_coherent(&pdev->dev,
+					DMA_BIT_MASK(hdev->dma_mask));
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to set dma mask to %d bits, error %d\n",
+			hdev->dma_mask, rc);
 		goto unmap_pci_bars;
+	}
 
 	return 0;
 
-- 
2.25.1

