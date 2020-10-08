Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258B628739F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgJHLwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:52:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59846 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbgJHLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:52:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 098BqR9I025555;
        Thu, 8 Oct 2020 06:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602157947;
        bh=b6NbIl0T+fVXTC6tZjqlPBmBmOziOBTnnQgOMOY82q4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EiaiNdAarKLLU81nye6C2EHD3nBifEdV83nVbpqko/+pMwXv/2Jw8cW3lsRQ2UMUW
         tmf7iyOzdqDXJIHSy0Z2TuhW2zoBNzKu3302Vn6YnB2CijwdHMu4OpC3oJypysFokZ
         Oago7xN80NJDh2lIL81ECczRVYbKWi8k3gAJPlrs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 098BqRr5085764
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 06:52:27 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 06:52:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 06:52:27 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 098Bq3sC083508;
        Thu, 8 Oct 2020 06:52:25 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH v2 10/11] soc: ti: k3-ringacc: Use correct device for allocation in RING mode
Date:   Thu, 8 Oct 2020 14:52:23 +0300
Message-ID: <20201008115224.1591-11-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008115224.1591-1-peter.ujfalusi@ti.com>
References: <20201008115224.1591-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RING mode the ringacc does not access the ring memory. In this access
mode the ringacc coherency does not have meaning.

If the ring is configured in RING mode, then the ringacc itself will not
access to the ring memory. Only the requester (user) of the ring is going
to read/write to the memory.
Extend the ring configuration parameters with a device pointer to be used
for DMA API when the ring is configured in RING mode.

Extending the ring configuration struct will allow per ring selection of
device to be used for allocation, thus allowing per ring coherency.

To avoid regression, fall back to use the ringacc dev in case the alloc_dev
is not provided.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/soc/ti/k3-ringacc.c       | 14 +++++++++++---
 include/linux/soc/ti/k3-ringacc.h |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 9ddd77113c5a..7d0b4092fce8 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -141,6 +141,7 @@ struct k3_ring_state {
  * @parent: Pointer on struct @k3_ringacc
  * @use_count: Use count for shared rings
  * @proxy_id: RA Ring Proxy Id (only if @K3_RINGACC_RING_USE_PROXY)
+ * @dma_dev: device to be used for DMA API (allocation, mapping)
  */
 struct k3_ring {
 	struct k3_ring_rt_regs __iomem *rt;
@@ -160,6 +161,7 @@ struct k3_ring {
 	struct k3_ringacc	*parent;
 	u32		use_count;
 	int		proxy_id;
+	struct device	*dma_dev;
 };
 
 struct k3_ringacc_ops {
@@ -508,11 +510,12 @@ int k3_ringacc_ring_free(struct k3_ring *ring)
 
 	k3_ringacc_ring_free_sci(ring);
 
-	dma_free_coherent(ringacc->dev,
+	dma_free_coherent(ring->dma_dev,
 			  ring->size * (4 << ring->elm_size),
 			  ring->ring_mem_virt, ring->ring_mem_dma);
 	ring->flags = 0;
 	ring->ops = NULL;
+	ring->dma_dev = NULL;
 	if (ring->proxy_id != K3_RINGACC_PROXY_NOT_USED) {
 		clear_bit(ring->proxy_id, ringacc->proxy_inuse);
 		ring->proxy = NULL;
@@ -633,8 +636,12 @@ int k3_ringacc_ring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
 	switch (ring->mode) {
 	case K3_RINGACC_RING_MODE_RING:
 		ring->ops = &k3_ring_mode_ring_ops;
+		ring->dma_dev = cfg->dma_dev;
+		if (!ring->dma_dev)
+			ring->dma_dev = ringacc->dev;
 		break;
 	case K3_RINGACC_RING_MODE_MESSAGE:
+		ring->dma_dev = ringacc->dev;
 		if (ring->proxy)
 			ring->ops = &k3_ring_mode_proxy_ops;
 		else
@@ -646,7 +653,7 @@ int k3_ringacc_ring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
 		goto err_free_proxy;
 	}
 
-	ring->ring_mem_virt = dma_alloc_coherent(ringacc->dev,
+	ring->ring_mem_virt = dma_alloc_coherent(ring->dma_dev,
 					ring->size * (4 << ring->elm_size),
 					&ring->ring_mem_dma, GFP_KERNEL);
 	if (!ring->ring_mem_virt) {
@@ -669,12 +676,13 @@ int k3_ringacc_ring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
 	return 0;
 
 err_free_mem:
-	dma_free_coherent(ringacc->dev,
+	dma_free_coherent(ring->dma_dev,
 			  ring->size * (4 << ring->elm_size),
 			  ring->ring_mem_virt,
 			  ring->ring_mem_dma);
 err_free_ops:
 	ring->ops = NULL;
+	ring->dma_dev = NULL;
 err_free_proxy:
 	ring->proxy = NULL;
 	return ret;
diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
index 5a472eca5ee4..658dc71d2901 100644
--- a/include/linux/soc/ti/k3-ringacc.h
+++ b/include/linux/soc/ti/k3-ringacc.h
@@ -67,6 +67,9 @@ struct k3_ring;
  *	 few times. It's usable when the same ring is used as Free Host PD ring
  *	 for different flows, for example.
  *	 Note: Locking should be done by consumer if required
+ * @dma_dev: Master device which is using and accessing to the ring
+ *	memory when the mode is K3_RINGACC_RING_MODE_RING. Memory allocations
+ *	should be done using this device.
  */
 struct k3_ring_cfg {
 	u32 size;
@@ -74,6 +77,8 @@ struct k3_ring_cfg {
 	enum k3_ring_mode mode;
 #define K3_RINGACC_RING_SHARED BIT(1)
 	u32 flags;
+
+	struct device *dma_dev;
 };
 
 #define K3_RINGACC_RING_ID_ANY (-1)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

