Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3502CADFD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbgLAVDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:03:34 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:29257 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLAVDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:03:32 -0500
Received: from localhost.localdomain ([81.185.163.171])
        by mwinf5d20 with ME
        id z91m230093iBeFl0391nDg; Tue, 01 Dec 2020 22:01:48 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Dec 2020 22:01:48 +0100
X-ME-IP: 81.185.163.171
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     haver@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] misc: genwqe: Use dma_set_mask_and_coherent to simplify code
Date:   Tue,  1 Dec 2020 22:01:47 +0100
Message-Id: <20201201210147.7917-1-christophe.jaillet@wanadoo.fr>
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
 drivers/misc/genwqe/card_base.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index c9b886618071..2e1befbd1ad9 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -1089,24 +1089,9 @@ static int genwqe_pci_setup(struct genwqe_dev *cd)
 	}
 
 	/* check for 64-bit DMA address supported (DAC) */
-	if (!pci_set_dma_mask(pci_dev, DMA_BIT_MASK(64))) {
-		err = pci_set_consistent_dma_mask(pci_dev, DMA_BIT_MASK(64));
-		if (err) {
-			dev_err(&pci_dev->dev,
-				"err: DMA64 consistent mask error\n");
-			err = -EIO;
-			goto out_release_resources;
-		}
 	/* check for 32-bit DMA address supported (SAC) */
-	} else if (!pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32))) {
-		err = pci_set_consistent_dma_mask(pci_dev, DMA_BIT_MASK(32));
-		if (err) {
-			dev_err(&pci_dev->dev,
-				"err: DMA32 consistent mask error\n");
-			err = -EIO;
-			goto out_release_resources;
-		}
-	} else {
+	if (dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64)) ||
+	    dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32))) {
 		dev_err(&pci_dev->dev,
 			"err: neither DMA32 nor DMA64 supported\n");
 		err = -EIO;
-- 
2.27.0

