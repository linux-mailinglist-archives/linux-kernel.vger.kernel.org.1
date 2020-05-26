Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB921AF614
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDSBIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgDSBIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:08:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE57C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:08:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g30so3142215pfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Olj04Do6gygcKAJRoJMrCILRMDLLQbwoilaI8H7Pa0=;
        b=KwgdNnrZIhRP4HJL8UOYeQmWqimdUEYYF2+YbDZhdhayr9SgDbIhNe9FrHf5milbs/
         9EkhK1jtfkAPnwEwoJnmyq4vszEbaxPjgvUi+dZLz94iPzSorejZbl2s+LxD/GFrNKMI
         YfNjK/7PX1p1FVT05MjgwNJIOdlQOQL/zYo2JDjUQVgAWiM2P4H/8r1Lotqjc8vmUSiS
         PywcBTImgOf8hfyvGJSfR3YN/5Dh2EtbsGtok4jTAiIhvY9ATlOGb3XFQluI6w4RI+JA
         SLwR4RLDemlAfbw0t/I2/qA5WYCe/JcrfI+7lKL4h6RzGJiLPDzkFW98tXHtcGuscUA3
         0pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Olj04Do6gygcKAJRoJMrCILRMDLLQbwoilaI8H7Pa0=;
        b=strlSkmjdoh1nU9TJ6lsjnooQYBIY2GhqLxlv04V5P7aZMZWLTqxhVjPAcC3ZsG09o
         haaCJuau6z+DWCX4g6mOaPkrY8p0A67tyKsqyKFiXQw+M4HQqRM1tCcWUr40Z/sjTXsQ
         fe5DJjMemJCs7QlPm31624m/XrerCaAJJMRo6xdPFHQOnZ5pt/Yx3wz2jnzSDq3aNESq
         mep27cFyp71gkc4y1mW7Woy6xfXmdH+OyRc5E43lENNPGv4PC9ea6VYo5hvbyfguy44l
         llQf3BNZlhTIwcQscxTM/36lA1lsjNy+I3GxohdPit6ndJ0e6vDuNbnA2HpqtBqSyOlO
         gVig==
X-Gm-Message-State: AGi0PuaakYq+yFG55gpnhxufiCkEWd7KbDe5wvoTAg7GtG4dnKg+iInh
        EuI6WhsXXnBYCPnZO2jy3es=
X-Google-Smtp-Source: APiQypJNro+dvBmUzAfa/RNYplXPsfDeMB3GYwtyHbHwJY1QrjXizWFDErzASJ25umG9pO6jcguwSA==
X-Received: by 2002:a63:4f52:: with SMTP id p18mr3550573pgl.56.1587258510478;
        Sat, 18 Apr 2020 18:08:30 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id p10sm5362192pff.210.2020.04.18.18.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 18:08:29 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Manish Chopra <manishc@marvell.com>
Cc:     realwakka <realwakka@gmail.com>, GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: qlge: replace deprecated apis pci_dma_*
Date:   Sun, 19 Apr 2020 10:08:16 +0900
Message-Id: <20200419010816.29125-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: realwakka <realwakka@gmail.com>

Replace legacy/depreacted pci_dma_* functions to new dma_* functions.
Also replace PCI_DMA_* macro to DMA* macro.

Signed-off-by: realwakka <realwakka@gmail.com>
---
 drivers/staging/qlge/qlge_main.c | 162 +++++++++++++++----------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index c92820f07968..95a61018b6d2 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -215,11 +215,11 @@ int ql_write_cfg(struct ql_adapter *qdev, void *ptr, int size, u32 bit,
 	u32 value;
 
 	direction =
-	    (bit & (CFG_LRQ | CFG_LR | CFG_LCQ)) ? PCI_DMA_TODEVICE :
-	    PCI_DMA_FROMDEVICE;
+	    (bit & (CFG_LRQ | CFG_LR | CFG_LCQ)) ? DMA_TO_DEVICE :
+	    DMA_FROM_DEVICE;
 
-	map = pci_map_single(qdev->pdev, ptr, size, direction);
-	if (pci_dma_mapping_error(qdev->pdev, map)) {
+	map = dma_map_single(&qdev->pdev->dev, ptr, size, direction);
+	if (dma_mapping_error(&qdev->pdev->dev, map)) {
 		netif_err(qdev, ifup, qdev->ndev, "Couldn't map DMA area.\n");
 		return -ENOMEM;
 	}
@@ -248,7 +248,7 @@ int ql_write_cfg(struct ql_adapter *qdev, void *ptr, int size, u32 bit,
 	status = ql_wait_cfg(qdev, bit);
 exit:
 	ql_sem_unlock(qdev, SEM_ICB_MASK);	/* does flush too */
-	pci_unmap_single(qdev->pdev, map, size, direction);
+	dma_unmap_single(&qdev->pdev->dev, map, size, direction);
 	return status;
 }
 
@@ -983,14 +983,14 @@ static struct qlge_bq_desc *ql_get_curr_lchunk(struct ql_adapter *qdev,
 {
 	struct qlge_bq_desc *lbq_desc = qlge_get_curr_buf(&rx_ring->lbq);
 
-	pci_dma_sync_single_for_cpu(qdev->pdev, lbq_desc->dma_addr,
-				    qdev->lbq_buf_size, PCI_DMA_FROMDEVICE);
+	dma_sync_single_for_cpu(&qdev->pdev->dev, lbq_desc->dma_addr,
+				qdev->lbq_buf_size, DMA_FROM_DEVICE);
 
 	if ((lbq_desc->p.pg_chunk.offset + qdev->lbq_buf_size) ==
 	    ql_lbq_block_size(qdev)) {
 		/* last chunk of the master page */
-		pci_unmap_page(qdev->pdev, lbq_desc->dma_addr,
-			       ql_lbq_block_size(qdev), PCI_DMA_FROMDEVICE);
+		dma_unmap_page(&qdev->pdev->dev, lbq_desc->dma_addr,
+			       ql_lbq_block_size(qdev), DMA_FROM_DEVICE);
 	}
 
 	return lbq_desc;
@@ -1036,10 +1036,10 @@ static int qlge_refill_sb(struct rx_ring *rx_ring,
 		return -ENOMEM;
 	skb_reserve(skb, QLGE_SB_PAD);
 
-	sbq_desc->dma_addr = pci_map_single(qdev->pdev, skb->data,
+	sbq_desc->dma_addr = dma_map_single(&qdev->pdev->dev, skb->data,
 					    SMALL_BUF_MAP_SIZE,
-					    PCI_DMA_FROMDEVICE);
-	if (pci_dma_mapping_error(qdev->pdev, sbq_desc->dma_addr)) {
+					    DMA_FROM_DEVICE);
+	if (dma_mapping_error(&qdev->pdev->dev, sbq_desc->dma_addr)) {
 		netif_err(qdev, ifup, qdev->ndev, "PCI mapping failed.\n");
 		dev_kfree_skb_any(skb);
 		return -EIO;
@@ -1064,10 +1064,10 @@ static int qlge_refill_lb(struct rx_ring *rx_ring,
 		page = alloc_pages(gfp | __GFP_COMP, qdev->lbq_buf_order);
 		if (unlikely(!page))
 			return -ENOMEM;
-		dma_addr = pci_map_page(qdev->pdev, page, 0,
+		dma_addr = dma_map_page(&qdev->pdev->dev, page, 0,
 					ql_lbq_block_size(qdev),
-					PCI_DMA_FROMDEVICE);
-		if (pci_dma_mapping_error(qdev->pdev, dma_addr)) {
+					DMA_FROM_DEVICE);
+		if (dma_mapping_error(&qdev->pdev->dev, dma_addr)) {
 			__free_pages(page, qdev->lbq_buf_order);
 			netif_err(qdev, drv, qdev->ndev,
 				  "PCI mapping failed.\n");
@@ -1224,20 +1224,20 @@ static void ql_unmap_send(struct ql_adapter *qdev,
 					     qdev->ndev,
 					     "unmapping OAL area.\n");
 			}
-			pci_unmap_single(qdev->pdev,
+			dma_unmap_single(&qdev->pdev->dev,
 					 dma_unmap_addr(&tx_ring_desc->map[i],
 							mapaddr),
 					 dma_unmap_len(&tx_ring_desc->map[i],
 						       maplen),
-					 PCI_DMA_TODEVICE);
+					 DMA_TO_DEVICE);
 		} else {
 			netif_printk(qdev, tx_done, KERN_DEBUG, qdev->ndev,
 				     "unmapping frag %d.\n", i);
-			pci_unmap_page(qdev->pdev,
+			dma_unmap_page(&qdev->pdev->dev,
 				       dma_unmap_addr(&tx_ring_desc->map[i],
 						      mapaddr),
 				       dma_unmap_len(&tx_ring_desc->map[i],
-						     maplen), PCI_DMA_TODEVICE);
+						     maplen), DMA_TO_DEVICE);
 		}
 	}
 
@@ -1263,9 +1263,9 @@ static int ql_map_send(struct ql_adapter *qdev,
 	/*
 	 * Map the skb buffer first.
 	 */
-	map = pci_map_single(qdev->pdev, skb->data, len, PCI_DMA_TODEVICE);
+	map = dma_map_single(&qdev->pdev->dev, skb->data, len, DMA_TO_DEVICE);
 
-	err = pci_dma_mapping_error(qdev->pdev, map);
+	err = dma_mapping_error(&qdev->pdev->dev, map);
 	if (err) {
 		netif_err(qdev, tx_queued, qdev->ndev,
 			  "PCI mapping failed with error: %d\n", err);
@@ -1310,10 +1310,10 @@ static int ql_map_send(struct ql_adapter *qdev,
 			 *      etc...
 			 */
 			/* Tack on the OAL in the eighth segment of IOCB. */
-			map = pci_map_single(qdev->pdev, &tx_ring_desc->oal,
+			map = dma_map_single(&qdev->pdev->dev, &tx_ring_desc->oal,
 					     sizeof(struct oal),
-					     PCI_DMA_TODEVICE);
-			err = pci_dma_mapping_error(qdev->pdev, map);
+					     DMA_TO_DEVICE);
+			err = dma_mapping_error(&qdev->pdev->dev, map);
 			if (err) {
 				netif_err(qdev, tx_queued, qdev->ndev,
 					  "PCI mapping outbound address list with error: %d\n",
@@ -1584,8 +1584,8 @@ static void ql_process_mac_rx_skb(struct ql_adapter *qdev,
 	}
 	skb_reserve(new_skb, NET_IP_ALIGN);
 
-	pci_dma_sync_single_for_cpu(qdev->pdev, sbq_desc->dma_addr,
-				    SMALL_BUF_MAP_SIZE, PCI_DMA_FROMDEVICE);
+	dma_sync_single_for_cpu(&qdev->pdev->dev, sbq_desc->dma_addr,
+				SMALL_BUF_MAP_SIZE, DMA_FROM_DEVICE);
 
 	skb_put_data(new_skb, skb->data, length);
 
@@ -1707,8 +1707,8 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 		 * Headers fit nicely into a small buffer.
 		 */
 		sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
-		pci_unmap_single(qdev->pdev, sbq_desc->dma_addr,
-				 SMALL_BUF_MAP_SIZE, PCI_DMA_FROMDEVICE);
+		dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
+				 SMALL_BUF_MAP_SIZE, DMA_FROM_DEVICE);
 		skb = sbq_desc->p.skb;
 		ql_realign_skb(skb, hdr_len);
 		skb_put(skb, hdr_len);
@@ -1737,10 +1737,10 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 			 * buffer.
 			 */
 			sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
-			pci_dma_sync_single_for_cpu(qdev->pdev,
-						    sbq_desc->dma_addr,
-						    SMALL_BUF_MAP_SIZE,
-						    PCI_DMA_FROMDEVICE);
+			dma_sync_single_for_cpu(&qdev->pdev->dev,
+						sbq_desc->dma_addr,
+						SMALL_BUF_MAP_SIZE,
+						DMA_FROM_DEVICE);
 			skb_put_data(skb, sbq_desc->p.skb->data, length);
 		} else {
 			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
@@ -1750,9 +1750,9 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 			skb = sbq_desc->p.skb;
 			ql_realign_skb(skb, length);
 			skb_put(skb, length);
-			pci_unmap_single(qdev->pdev, sbq_desc->dma_addr,
+			dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
 					 SMALL_BUF_MAP_SIZE,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 			sbq_desc->p.skb = NULL;
 		}
 	} else if (ib_mac_rsp->flags3 & IB_MAC_IOCB_RSP_DL) {
@@ -1787,9 +1787,9 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 					     "No skb available, drop the packet.\n");
 				return NULL;
 			}
-			pci_unmap_page(qdev->pdev, lbq_desc->dma_addr,
+			dma_unmap_page(&qdev->pdev->dev, lbq_desc->dma_addr,
 				       qdev->lbq_buf_size,
-				       PCI_DMA_FROMDEVICE);
+				       DMA_FROM_DEVICE);
 			skb_reserve(skb, NET_IP_ALIGN);
 			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
 				     "%d bytes of headers and data in large. Chain page to new skb and pull tail.\n",
@@ -1820,8 +1820,8 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 		int size, i = 0;
 
 		sbq_desc = qlge_get_curr_buf(&rx_ring->sbq);
-		pci_unmap_single(qdev->pdev, sbq_desc->dma_addr,
-				 SMALL_BUF_MAP_SIZE, PCI_DMA_FROMDEVICE);
+		dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
+				 SMALL_BUF_MAP_SIZE, DMA_FROM_DEVICE);
 		if (!(ib_mac_rsp->flags4 & IB_MAC_IOCB_RSP_HS)) {
 			/*
 			 * This is an non TCP/UDP IP frame, so
@@ -2636,17 +2636,17 @@ static netdev_tx_t qlge_send(struct sk_buff *skb, struct net_device *ndev)
 static void ql_free_shadow_space(struct ql_adapter *qdev)
 {
 	if (qdev->rx_ring_shadow_reg_area) {
-		pci_free_consistent(qdev->pdev,
-				    PAGE_SIZE,
-				    qdev->rx_ring_shadow_reg_area,
-				    qdev->rx_ring_shadow_reg_dma);
+		dma_free_coherent(&qdev->pdev->dev,
+				  PAGE_SIZE,
+				  qdev->rx_ring_shadow_reg_area,
+				  qdev->rx_ring_shadow_reg_dma);
 		qdev->rx_ring_shadow_reg_area = NULL;
 	}
 	if (qdev->tx_ring_shadow_reg_area) {
-		pci_free_consistent(qdev->pdev,
-				    PAGE_SIZE,
-				    qdev->tx_ring_shadow_reg_area,
-				    qdev->tx_ring_shadow_reg_dma);
+		dma_free_coherent(&qdev->pdev->dev,
+				  PAGE_SIZE,
+				  qdev->tx_ring_shadow_reg_area,
+				  qdev->tx_ring_shadow_reg_dma);
 		qdev->tx_ring_shadow_reg_area = NULL;
 	}
 }
@@ -2654,8 +2654,8 @@ static void ql_free_shadow_space(struct ql_adapter *qdev)
 static int ql_alloc_shadow_space(struct ql_adapter *qdev)
 {
 	qdev->rx_ring_shadow_reg_area =
-		pci_zalloc_consistent(qdev->pdev, PAGE_SIZE,
-				      &qdev->rx_ring_shadow_reg_dma);
+		dma_alloc_coherent(&qdev->pdev->dev, PAGE_SIZE,
+				   &qdev->rx_ring_shadow_reg_dma, GFP_ATOMIC);
 	if (!qdev->rx_ring_shadow_reg_area) {
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Allocation of RX shadow space failed.\n");
@@ -2663,8 +2663,8 @@ static int ql_alloc_shadow_space(struct ql_adapter *qdev)
 	}
 
 	qdev->tx_ring_shadow_reg_area =
-		pci_zalloc_consistent(qdev->pdev, PAGE_SIZE,
-				      &qdev->tx_ring_shadow_reg_dma);
+		dma_alloc_coherent(&qdev->pdev->dev, PAGE_SIZE,
+				   &qdev->tx_ring_shadow_reg_dma, GFP_ATOMIC);
 	if (!qdev->tx_ring_shadow_reg_area) {
 		netif_err(qdev, ifup, qdev->ndev,
 			  "Allocation of TX shadow space failed.\n");
@@ -2673,10 +2673,10 @@ static int ql_alloc_shadow_space(struct ql_adapter *qdev)
 	return 0;
 
 err_wqp_sh_area:
-	pci_free_consistent(qdev->pdev,
-			    PAGE_SIZE,
-			    qdev->rx_ring_shadow_reg_area,
-			    qdev->rx_ring_shadow_reg_dma);
+	dma_free_coherent(&qdev->pdev->dev,
+			  PAGE_SIZE,
+			  qdev->rx_ring_shadow_reg_area,
+			  qdev->rx_ring_shadow_reg_dma);
 	return -ENOMEM;
 }
 
@@ -2702,8 +2702,8 @@ static void ql_free_tx_resources(struct ql_adapter *qdev,
 				 struct tx_ring *tx_ring)
 {
 	if (tx_ring->wq_base) {
-		pci_free_consistent(qdev->pdev, tx_ring->wq_size,
-				    tx_ring->wq_base, tx_ring->wq_base_dma);
+		dma_free_coherent(&qdev->pdev->dev, tx_ring->wq_size,
+				  tx_ring->wq_base, tx_ring->wq_base_dma);
 		tx_ring->wq_base = NULL;
 	}
 	kfree(tx_ring->q);
@@ -2714,8 +2714,8 @@ static int ql_alloc_tx_resources(struct ql_adapter *qdev,
 				 struct tx_ring *tx_ring)
 {
 	tx_ring->wq_base =
-	    pci_alloc_consistent(qdev->pdev, tx_ring->wq_size,
-				 &tx_ring->wq_base_dma);
+	    dma_alloc_coherent(&qdev->pdev->dev, tx_ring->wq_size,
+			       &tx_ring->wq_base_dma, GFP_ATOMIC);
 
 	if (!tx_ring->wq_base ||
 	    tx_ring->wq_base_dma & WQ_ADDR_ALIGN)
@@ -2729,8 +2729,8 @@ static int ql_alloc_tx_resources(struct ql_adapter *qdev,
 
 	return 0;
 err:
-	pci_free_consistent(qdev->pdev, tx_ring->wq_size,
-			    tx_ring->wq_base, tx_ring->wq_base_dma);
+	dma_free_coherent(&qdev->pdev->dev, tx_ring->wq_size,
+			  tx_ring->wq_base, tx_ring->wq_base_dma);
 	tx_ring->wq_base = NULL;
 pci_alloc_err:
 	netif_err(qdev, ifup, qdev->ndev, "tx_ring alloc failed.\n");
@@ -2748,17 +2748,17 @@ static void ql_free_lbq_buffers(struct ql_adapter *qdev, struct rx_ring *rx_ring
 			&lbq->queue[lbq->next_to_clean];
 
 		if (lbq_desc->p.pg_chunk.offset == last_offset)
-			pci_unmap_page(qdev->pdev, lbq_desc->dma_addr,
+			dma_unmap_page(&qdev->pdev->dev, lbq_desc->dma_addr,
 				       ql_lbq_block_size(qdev),
-				       PCI_DMA_FROMDEVICE);
+				       DMA_FROM_DEVICE);
 		put_page(lbq_desc->p.pg_chunk.page);
 
 		lbq->next_to_clean = QLGE_BQ_WRAP(lbq->next_to_clean + 1);
 	}
 
 	if (rx_ring->master_chunk.page) {
-		pci_unmap_page(qdev->pdev, rx_ring->chunk_dma_addr,
-			       ql_lbq_block_size(qdev), PCI_DMA_FROMDEVICE);
+		dma_unmap_page(&qdev->pdev->dev, rx_ring->chunk_dma_addr,
+			       ql_lbq_block_size(qdev), DMA_FROM_DEVICE);
 		put_page(rx_ring->master_chunk.page);
 		rx_ring->master_chunk.page = NULL;
 	}
@@ -2777,9 +2777,9 @@ static void ql_free_sbq_buffers(struct ql_adapter *qdev, struct rx_ring *rx_ring
 			return;
 		}
 		if (sbq_desc->p.skb) {
-			pci_unmap_single(qdev->pdev, sbq_desc->dma_addr,
+			dma_unmap_single(&qdev->pdev->dev, sbq_desc->dma_addr,
 					 SMALL_BUF_MAP_SIZE,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 			dev_kfree_skb(sbq_desc->p.skb);
 			sbq_desc->p.skb = NULL;
 		}
@@ -2820,8 +2820,8 @@ static int qlge_init_bq(struct qlge_bq *bq)
 	__le64 *buf_ptr;
 	int i;
 
-	bq->base = pci_alloc_consistent(qdev->pdev, QLGE_BQ_SIZE,
-					&bq->base_dma);
+	bq->base = dma_alloc_coherent(&qdev->pdev->dev, QLGE_BQ_SIZE,
+				      &bq->base_dma, GFP_ATOMIC);
 	if (!bq->base) {
 		netif_err(qdev, ifup, qdev->ndev,
 			  "ring %u %s allocation failed.\n", rx_ring->cq_id,
@@ -2850,8 +2850,8 @@ static void ql_free_rx_resources(struct ql_adapter *qdev,
 {
 	/* Free the small buffer queue. */
 	if (rx_ring->sbq.base) {
-		pci_free_consistent(qdev->pdev, QLGE_BQ_SIZE,
-				    rx_ring->sbq.base, rx_ring->sbq.base_dma);
+		dma_free_coherent(&qdev->pdev->dev, QLGE_BQ_SIZE,
+				  rx_ring->sbq.base, rx_ring->sbq.base_dma);
 		rx_ring->sbq.base = NULL;
 	}
 
@@ -2861,8 +2861,8 @@ static void ql_free_rx_resources(struct ql_adapter *qdev,
 
 	/* Free the large buffer queue. */
 	if (rx_ring->lbq.base) {
-		pci_free_consistent(qdev->pdev, QLGE_BQ_SIZE,
-				    rx_ring->lbq.base, rx_ring->lbq.base_dma);
+		dma_free_coherent(&qdev->pdev->dev, QLGE_BQ_SIZE,
+				  rx_ring->lbq.base, rx_ring->lbq.base_dma);
 		rx_ring->lbq.base = NULL;
 	}
 
@@ -2872,9 +2872,9 @@ static void ql_free_rx_resources(struct ql_adapter *qdev,
 
 	/* Free the rx queue. */
 	if (rx_ring->cq_base) {
-		pci_free_consistent(qdev->pdev,
-				    rx_ring->cq_size,
-				    rx_ring->cq_base, rx_ring->cq_base_dma);
+		dma_free_coherent(&qdev->pdev->dev,
+				  rx_ring->cq_size,
+				  rx_ring->cq_base, rx_ring->cq_base_dma);
 		rx_ring->cq_base = NULL;
 	}
 }
@@ -2890,8 +2890,8 @@ static int ql_alloc_rx_resources(struct ql_adapter *qdev,
 	 * Allocate the completion queue for this rx_ring.
 	 */
 	rx_ring->cq_base =
-	    pci_alloc_consistent(qdev->pdev, rx_ring->cq_size,
-				 &rx_ring->cq_base_dma);
+	    dma_alloc_coherent(&qdev->pdev->dev, rx_ring->cq_size,
+			       &rx_ring->cq_base_dma, GFP_ATOMIC);
 
 	if (!rx_ring->cq_base) {
 		netif_err(qdev, ifup, qdev->ndev, "rx_ring alloc failed.\n");
@@ -4430,13 +4430,13 @@ static int ql_init_device(struct pci_dev *pdev, struct net_device *ndev,
 	}
 
 	pci_set_master(pdev);
-	if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
+	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
 		set_bit(QL_DMA64, &qdev->flags);
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 	} else {
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (!err)
-		       err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		       err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	}
 
 	if (err) {
-- 
2.17.1

