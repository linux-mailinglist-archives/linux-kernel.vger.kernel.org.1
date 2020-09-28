Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87827A7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgI1Gjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:39:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43948 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1Gjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:39:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S6dPxF126293;
        Mon, 28 Sep 2020 01:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601275165;
        bh=bG303yFR4uOJmtzhuoEEplC+W0gyVvQTPQNVb5c+C7k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MfxwcITOMTdeNwqoPVBFK4jMNFlDmQOejEijdESHrKmECXrftrtFFglC+Fyh3JuNy
         Z2xtbr5g9eO8GylfnL8E8QJ7LmTxNliiWmPSGZErUWhKxFgnEZkUIqxhbuckmfByYU
         LZSbQ12dEpzD5m5xHqdXskuwi7p1eOSJXJh7TLmE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08S6dP0k021978
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 01:39:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 01:39:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 01:39:24 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S6dG3f111672;
        Mon, 28 Sep 2020 01:39:22 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] irqchip/ti-sci-inta: Add support for unmapped event handling
Date:   Mon, 28 Sep 2020 09:39:30 +0300
Message-ID: <20200928063930.12012-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928063930.12012-1-peter.ujfalusi@ti.com>
References: <20200928063930.12012-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA (BCDMA/PKTDMA and their rings/flows) events are under the INTA's
supervision as unmapped events in AM64.

In order to keep the current SW stack working, the INTA driver must replace
the dev_id with it's own when a request comes for BCDMA or PKTDMA
resources.

Implement parsing of the optional "ti,unmapped-event-sources" phandle array
to get the sci-dev-ids of the devices where the unmapped events originate.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/irqchip/irq-ti-sci-inta.c | 72 +++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index bc863ef7998d..02914d29140b 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -85,6 +85,8 @@ struct ti_sci_inta_vint_desc {
  * @base:		Base address of the memory mapped IO registers
  * @pdev:		Pointer to platform device.
  * @ti_sci_id:		TI-SCI device identifier
+ * @difu_cnt:		Number of TI-SCI device identifiers for unmapped events
+ * @dev_ids_for_unmapped: Pointer to an array of TI-SCI device identifiers
  */
 struct ti_sci_inta_irq_domain {
 	const struct ti_sci_handle *sci;
@@ -96,11 +98,33 @@ struct ti_sci_inta_irq_domain {
 	void __iomem *base;
 	struct platform_device *pdev;
 	u32 ti_sci_id;
+
+	int difu_cnt;
+	u32 *dev_ids_for_unmapped;
 };
 
 #define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_desc, \
 					events[i])
 
+static u16 ti_sci_inta_get_dev_id(struct ti_sci_inta_irq_domain *inta,
+				  u32 hwirq)
+{
+	u16 dev_id = HWIRQ_TO_DEVID(hwirq);
+	int i;
+
+	if (inta->difu_cnt == 0)
+		return dev_id;
+
+	for (i = 0; i < inta->difu_cnt; i++) {
+		if (dev_id == inta->dev_ids_for_unmapped[i]) {
+			dev_id = inta->ti_sci_id;
+			break;
+		}
+	}
+
+	return dev_id;
+}
+
 /**
  * ti_sci_inta_irq_handler() - Chained IRQ handler for the vint irqs
  * @desc:	Pointer to irq_desc corresponding to the irq
@@ -251,7 +275,7 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_event(struct ti_sci_inta
 	u16 dev_id, dev_index;
 	int err;
 
-	dev_id = HWIRQ_TO_DEVID(hwirq);
+	dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
 	dev_index = HWIRQ_TO_IRQID(hwirq);
 
 	event_desc = &vint_desc->events[free_bit];
@@ -352,14 +376,15 @@ static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
 {
 	struct ti_sci_inta_vint_desc *vint_desc;
 	struct ti_sci_inta_irq_domain *inta;
+	u16 dev_id;
 
 	vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
 	inta = vint_desc->domain->host_data;
+	dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
 	/* free event irq */
 	mutex_lock(&inta->vint_mutex);
 	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
-						 HWIRQ_TO_DEVID(hwirq),
-						 HWIRQ_TO_IRQID(hwirq),
+						 dev_id, HWIRQ_TO_IRQID(hwirq),
 						 inta->ti_sci_id,
 						 vint_desc->vint_id,
 						 event_desc->global_event,
@@ -562,7 +587,6 @@ static void ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
 	arg->desc = desc;
 	arg->hwirq = TO_HWIRQ(pdev->id, desc->inta.dev_index);
 }
-
 static struct msi_domain_ops ti_sci_inta_msi_ops = {
 	.set_desc	= ti_sci_inta_msi_set_desc,
 };
@@ -574,6 +598,42 @@ static struct msi_domain_info ti_sci_inta_msi_domain_info = {
 	.chip	= &ti_sci_inta_msi_irq_chip,
 };
 
+static int ti_sci_inta_get_unmapped_sources(struct ti_sci_inta_irq_domain *inta)
+{
+	struct device *dev = &inta->pdev->dev;
+	struct device_node *node = dev_of_node(dev);
+	struct of_phandle_iterator it;
+	int count, err, ret, i;
+
+	count = of_count_phandle_with_args(node, "ti,unmapped-event-sources",
+					   NULL);
+	if (count <= 0)
+		return count;
+
+	inta->dev_ids_for_unmapped = devm_kcalloc(dev, count,
+					sizeof(*inta->dev_ids_for_unmapped),
+					GFP_KERNEL);
+	if (!inta->dev_ids_for_unmapped)
+		return -ENOMEM;
+
+	i = 0;
+	of_for_each_phandle(&it, err, node, "ti,unmapped-event-sources",
+			    NULL, 0) {
+		ret = of_property_read_u32(it.node, "ti,sci-dev-id",
+					   &inta->dev_ids_for_unmapped[i++]);
+		if (ret) {
+			dev_err(dev, "ti,sci-dev-id read failure for %s\n",
+				of_node_full_name(it.node));
+			of_node_put(it.node);
+			return ret;
+		}
+	}
+
+	inta->difu_cnt = count;
+
+	return 0;
+}
+
 static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 {
 	struct irq_domain *parent_domain, *domain, *msi_domain;
@@ -629,6 +689,10 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	if (IS_ERR(inta->base))
 		return PTR_ERR(inta->base);
 
+	ret = ti_sci_inta_get_unmapped_sources(inta);
+	if (ret)
+		return ret;
+
 	domain = irq_domain_add_linear(dev_of_node(dev),
 				       ti_sci_get_num_resources(inta->vint),
 				       &ti_sci_inta_irq_domain_ops, inta);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

