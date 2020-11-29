Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8587B2C792F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 13:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbgK2M5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 07:57:01 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:29701 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgK2M5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 07:57:01 -0500
Received: from localhost.localdomain ([92.131.86.32])
        by mwinf5d20 with ME
        id yCvE230080hrljw03CvER4; Sun, 29 Nov 2020 13:55:17 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Nov 2020 13:55:17 +0100
X-ME-IP: 92.131.86.32
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mst@redhat.com, jasowang@redhat.com, lingshan.zhu@intel.com,
        eli@mellanox.com, parav@mellanox.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] vdpa: ifcvf: Use dma_set_mask_and_coherent to simplify code
Date:   Sun, 29 Nov 2020 13:54:34 +0100
Message-Id: <20201129125434.1462638-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.

While at it, fix a typo (s/confiugration/configuration)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 8b4028556cb6..fa1af301cf55 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -417,16 +417,9 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (ret) {
-		IFCVF_ERR(pdev, "No usable DMA confiugration\n");
-		return ret;
-	}
-
-	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (ret) {
-		IFCVF_ERR(pdev,
-			  "No usable coherent DMA confiugration\n");
+		IFCVF_ERR(pdev, "No usable DMA configuration\n");
 		return ret;
 	}
 
-- 
2.27.0

