Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA052BBDCE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 08:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgKUHbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 02:31:38 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:53301 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgKUHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 02:31:37 -0500
Received: from localhost.localdomain ([81.185.161.242])
        by mwinf5d61 with ME
        id uvXW230025E5lq903vXW9e; Sat, 21 Nov 2020 08:31:33 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Nov 2020 08:31:33 +0100
X-ME-IP: 81.185.161.242
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        miaoqinglang@huawei.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] crypto: cavium/zip - Use dma_set_mask_and_coherent to simplify code
Date:   Sat, 21 Nov 2020 08:31:31 +0100
Message-Id: <20201121073131.1321343-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/cavium/zip/zip_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/cavium/zip/zip_main.c b/drivers/crypto/cavium/zip/zip_main.c
index d35216e2f6cd..812b4ac9afd6 100644
--- a/drivers/crypto/cavium/zip/zip_main.c
+++ b/drivers/crypto/cavium/zip/zip_main.c
@@ -263,15 +263,9 @@ static int zip_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_disable_device;
 	}
 
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 	if (err) {
-		dev_err(dev, "Unable to get usable DMA configuration\n");
-		goto err_release_regions;
-	}
-
-	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
-	if (err) {
-		dev_err(dev, "Unable to get 48-bit DMA for allocations\n");
+		dev_err(dev, "Unable to get usable 48-bit DMA configuration\n");
 		goto err_release_regions;
 	}
 
-- 
2.27.0

