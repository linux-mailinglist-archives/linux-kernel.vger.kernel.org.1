Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE372935D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405184AbgJTHco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:32:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47466 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405114AbgJTHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:32:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09K7WLl8045172;
        Tue, 20 Oct 2020 02:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603179141;
        bh=8VCLbjZNFvQajYb9DjyRzVeIPKJ6kvSBGwv/2GfPNfA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J9V6hRl8+fXrPOhcv3J1WskHwU+jQIZiEWdk8XULbujv5zNxUqZLY1+xuRzPehLF1
         SfXyiRdD+2SgqMgm7QiEWWkML+dGZRZq9VzSKf3B2V2DGtZA0N5pXXhpPNQF379ONe
         hB7v7gMC5VeTgQ/gn8BwYzH5EmhorlqlC4TG2BiE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09K7WLjW030906
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 02:32:21 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 20
 Oct 2020 02:32:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 20 Oct 2020 02:32:21 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09K7WCid069455;
        Tue, 20 Oct 2020 02:32:18 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/2] irqchip/ti-sci-inta: Add support for unmapped event handling
Date:   Tue, 20 Oct 2020 10:32:43 +0300
Message-ID: <20201020073243.19255-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020073243.19255-1-peter.ujfalusi@ti.com>
References: <20201020073243.19255-1-peter.ujfalusi@ti.com>
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
 drivers/irqchip/irq-ti-sci-inta.c | 83 +++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index e0cceb81c648..b2ab8db439d9 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -85,6 +85,17 @@ struct ti_sci_inta_vint_desc {
  * @base:		Base address of the memory mapped IO registers
  * @pdev:		Pointer to platform device.
  * @ti_sci_id:		TI-SCI device identifier
+ * @unmapped_cnt:	Number of @unmapped_dev_ids entries
+ * @unmapped_dev_ids:	Pointer to an array of TI-SCI device identifiers of
+ *			unmapped event sources.
+ *			Unmapped Events are not part of the Global Event Map and
+ *			they are converted to Global event within INTA to be
+ *			received by the same INTA to generate an interrupt.
+ *			In case an interrupt request comes for a device which is
+ *			generating Unmapped Event, we must use the INTA's TI-SCI
+ *			device identifier in place of the source device
+ *			identifier to let sysfw know where it has to program the
+ *			Global Event number.
  */
 struct ti_sci_inta_irq_domain {
 	const struct ti_sci_handle *sci;
@@ -96,11 +107,37 @@ struct ti_sci_inta_irq_domain {
 	void __iomem *base;
 	struct platform_device *pdev;
 	u32 ti_sci_id;
+
+	int unmapped_cnt;
+	u16 *unmapped_dev_ids;
 };
 
 #define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_desc, \
 					events[i])
 
+static u16 ti_sci_inta_get_dev_id(struct ti_sci_inta_irq_domain *inta, u32 hwirq)
+{
+	u16 dev_id = HWIRQ_TO_DEVID(hwirq);
+	int i;
+
+	if (inta->unmapped_cnt == 0)
+		return dev_id;
+
+	/*
+	 * For devices sending Unmapped Events we must use the INTA's TI-SCI
+	 * device identifier number to be able to convert it to a Global Event
+	 * and map it to an interrupt.
+	 */
+	for (i = 0; i < inta->unmapped_cnt; i++) {
+		if (dev_id == inta->unmapped_dev_ids[i]) {
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
@@ -251,7 +288,7 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_event(struct ti_sci_inta
 	u16 dev_id, dev_index;
 	int err;
 
-	dev_id = HWIRQ_TO_DEVID(hwirq);
+	dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
 	dev_index = HWIRQ_TO_IRQID(hwirq);
 
 	event_desc = &vint_desc->events[free_bit];
@@ -352,14 +389,15 @@ static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
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
@@ -574,6 +612,41 @@ static struct msi_domain_info ti_sci_inta_msi_domain_info = {
 	.chip	= &ti_sci_inta_msi_irq_chip,
 };
 
+static int ti_sci_inta_get_unmapped_sources(struct ti_sci_inta_irq_domain *inta)
+{
+	struct device *dev = &inta->pdev->dev;
+	struct device_node *node = dev_of_node(dev);
+	struct of_phandle_iterator it;
+	int count, err, ret, i;
+
+	count = of_count_phandle_with_args(node, "ti,unmapped-event-sources", NULL);
+	if (count <= 0)
+		return 0;
+
+	inta->unmapped_dev_ids = devm_kcalloc(dev, count,
+					      sizeof(*inta->unmapped_dev_ids),
+					      GFP_KERNEL);
+	if (!inta->unmapped_dev_ids)
+		return -ENOMEM;
+
+	i = 0;
+	of_for_each_phandle(&it, err, node, "ti,unmapped-event-sources", NULL, 0) {
+		u32 dev_id;
+
+		ret = of_property_read_u32(it.node, "ti,sci-dev-id", &dev_id);
+		if (ret) {
+			dev_err(dev, "ti,sci-dev-id read failure for %pOFf\n", it.node);
+			of_node_put(it.node);
+			return ret;
+		}
+		inta->unmapped_dev_ids[i++] = dev_id;
+	}
+
+	inta->unmapped_cnt = count;
+
+	return 0;
+}
+
 static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 {
 	struct irq_domain *parent_domain, *domain, *msi_domain;
@@ -629,6 +702,10 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
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

