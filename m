Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF628B426
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbgJLLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:51:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33226 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbgJLLvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:51:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09CBpESx044270;
        Mon, 12 Oct 2020 06:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602503474;
        bh=m+bwzyoI0lwzXRNLUmQcL5EFk5qeHeEbSocrE9c3ZG4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fNwYEOoWd7EfshdHAmWcdHNakUlQdbthZT182SLgEqf47VN7YduLHKic6lMaYY2E8
         rpBW4pZ4OLMqBAx/9RklDM//MykWwPAfgQB4WSl+Fnxdyr80Xlgm4jZuS2rs1QF//Y
         doElHwDDwkkaRitFWA6QBx3qUX/uijIUc2NS8yLE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09CBpE5t070592
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 06:51:14 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 06:51:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 06:51:14 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09CBosx0088613;
        Mon, 12 Oct 2020 06:51:12 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH v3 08/11] soc: ti: k3-ringacc: Use the ti_sci set_cfg callback for ring configuration
Date:   Mon, 12 Oct 2020 14:51:16 +0300
Message-ID: <20201012115119.11333-9-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012115119.11333-1-peter.ujfalusi@ti.com>
References: <20201012115119.11333-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new set_cfg to configure the ring.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/soc/ti/k3-ringacc.c | 79 +++++++++++++++----------------------
 1 file changed, 32 insertions(+), 47 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 1147dc4c1d59..9ddd77113c5a 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -365,20 +365,16 @@ EXPORT_SYMBOL_GPL(k3_ringacc_request_rings_pair);
 
 static void k3_ringacc_ring_reset_sci(struct k3_ring *ring)
 {
+	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
 	struct k3_ringacc *ringacc = ring->parent;
 	int ret;
 
-	ret = ringacc->tisci_ring_ops->config(
-			ringacc->tisci,
-			TI_SCI_MSG_VALUE_RM_RING_COUNT_VALID,
-			ringacc->tisci_dev_id,
-			ring->ring_id,
-			0,
-			0,
-			ring->size,
-			0,
-			0,
-			0);
+	ring_cfg.nav_id = ringacc->tisci_dev_id;
+	ring_cfg.index = ring->ring_id;
+	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_RING_COUNT_VALID;
+	ring_cfg.count = ring->size;
+
+	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
 	if (ret)
 		dev_err(ringacc->dev, "TISCI reset ring fail (%d) ring_idx %d\n",
 			ret, ring->ring_id);
@@ -398,20 +394,16 @@ EXPORT_SYMBOL_GPL(k3_ringacc_ring_reset);
 static void k3_ringacc_ring_reconfig_qmode_sci(struct k3_ring *ring,
 					       enum k3_ring_mode mode)
 {
+	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
 	struct k3_ringacc *ringacc = ring->parent;
 	int ret;
 
-	ret = ringacc->tisci_ring_ops->config(
-			ringacc->tisci,
-			TI_SCI_MSG_VALUE_RM_RING_MODE_VALID,
-			ringacc->tisci_dev_id,
-			ring->ring_id,
-			0,
-			0,
-			0,
-			mode,
-			0,
-			0);
+	ring_cfg.nav_id = ringacc->tisci_dev_id;
+	ring_cfg.index = ring->ring_id;
+	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_RING_MODE_VALID;
+	ring_cfg.mode = mode;
+
+	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
 	if (ret)
 		dev_err(ringacc->dev, "TISCI reconf qmode fail (%d) ring_idx %d\n",
 			ret, ring->ring_id);
@@ -478,20 +470,15 @@ EXPORT_SYMBOL_GPL(k3_ringacc_ring_reset_dma);
 
 static void k3_ringacc_ring_free_sci(struct k3_ring *ring)
 {
+	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
 	struct k3_ringacc *ringacc = ring->parent;
 	int ret;
 
-	ret = ringacc->tisci_ring_ops->config(
-			ringacc->tisci,
-			TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER,
-			ringacc->tisci_dev_id,
-			ring->ring_id,
-			0,
-			0,
-			0,
-			0,
-			0,
-			0);
+	ring_cfg.nav_id = ringacc->tisci_dev_id;
+	ring_cfg.index = ring->ring_id;
+	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER;
+
+	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
 	if (ret)
 		dev_err(ringacc->dev, "TISCI ring free fail (%d) ring_idx %d\n",
 			ret, ring->ring_id);
@@ -575,28 +562,26 @@ EXPORT_SYMBOL_GPL(k3_ringacc_get_ring_irq_num);
 
 static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
 {
+	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
 	struct k3_ringacc *ringacc = ring->parent;
-	u32 ring_idx;
 	int ret;
 
 	if (!ringacc->tisci)
 		return -EINVAL;
 
-	ring_idx = ring->ring_id;
-	ret = ringacc->tisci_ring_ops->config(
-			ringacc->tisci,
-			TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER,
-			ringacc->tisci_dev_id,
-			ring_idx,
-			lower_32_bits(ring->ring_mem_dma),
-			upper_32_bits(ring->ring_mem_dma),
-			ring->size,
-			ring->mode,
-			ring->elm_size,
-			0);
+	ring_cfg.nav_id = ringacc->tisci_dev_id;
+	ring_cfg.index = ring->ring_id;
+	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER;
+	ring_cfg.addr_lo = lower_32_bits(ring->ring_mem_dma);
+	ring_cfg.addr_hi = upper_32_bits(ring->ring_mem_dma);
+	ring_cfg.count = ring->size;
+	ring_cfg.mode = ring->mode;
+	ring_cfg.size = ring->elm_size;
+
+	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
 	if (ret)
 		dev_err(ringacc->dev, "TISCI config ring fail (%d) ring_idx %d\n",
-			ret, ring_idx);
+			ret, ring->ring_id);
 
 	return ret;
 }
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

