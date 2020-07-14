Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D6821EFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGNMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 08:02:20 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:52586 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728087AbgGNMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:02:14 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with SMTP; 14 Jul 2020 15:02:11 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06EC25dh004353;
        Tue, 14 Jul 2020 15:02:11 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v2 04/11] platform/mellanox: mlxreg-hotplug: Use capability register for attribute creation
Date:   Tue, 14 Jul 2020 15:01:56 +0300
Message-Id: <20200714120203.10352-5-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200714120203.10352-1-vadimp@mellanox.com>
References: <20200714120203.10352-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the 'sysfs' attributes according to configuration provided
through the capability register, which purpose is to indicate the
actual number of the components within the particular group.
Such components could be, for example the FAN or power supply units.
The motivation is to avoid adding a new code in the future in order to
distinct between the systems types supporting a different number of the
components like power supplies, FANs, ASICs, line cards.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v1->v2:
Comments pointed out by Andy:
- Fix commit text.
- Modify loop over unmasked units - use for_each_set_bit().
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 60 ++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index 19af2897ef75..d9863e7fd491 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -173,17 +173,49 @@ static int mlxreg_hotplug_attr_init(struct mlxreg_hotplug_priv_data *priv)
 	struct mlxreg_core_hotplug_platform_data *pdata;
 	struct mlxreg_core_item *item;
 	struct mlxreg_core_data *data;
-	int num_attrs = 0, id = 0, i, j;
+	unsigned long mask;
+	u32 regval;
+	int num_attrs = 0, id = 0, i, j, k, ret;
 
 	pdata = dev_get_platdata(&priv->pdev->dev);
 	item = pdata->items;
 
 	/* Go over all kinds of items - psu, pwr, fan. */
 	for (i = 0; i < pdata->counter; i++, item++) {
-		num_attrs += item->count;
+		if (item->capability) {
+			/*
+			 * Read group capability register to get actual number
+			 * of interrupt capable components and set group mask
+			 * accordingly.
+			 */
+			ret = regmap_read(priv->regmap, item->capability,
+					  &regval);
+			if (ret)
+				return ret;
+
+			item->mask = GENMASK((regval & item->mask) - 1, 0);
+		}
+
 		data = item->data;
-		/* Go over all units within the item. */
-		for (j = 0; j < item->count; j++, data++, id++) {
+
+		/* Go over all unmasked units within item. */
+		mask = item->mask;
+		k = 0;
+		for_each_set_bit(j, &mask, item->count) {
+			if (data->capability) {
+				/*
+				 * Read capability register and skip non
+				 * relevant attributes.
+				 */
+				ret = regmap_read(priv->regmap,
+						  data->capability, &regval);
+				if (ret)
+					return ret;
+				if (!(regval & data->bit)) {
+					data++;
+					continue;
+				}
+			}
 			PRIV_ATTR(id) = &PRIV_DEV_ATTR(id).dev_attr.attr;
 			PRIV_ATTR(id)->name = devm_kasprintf(&priv->pdev->dev,
 							     GFP_KERNEL,
@@ -201,9 +233,13 @@ static int mlxreg_hotplug_attr_init(struct mlxreg_hotplug_priv_data *priv)
 			PRIV_DEV_ATTR(id).dev_attr.show =
 						mlxreg_hotplug_attr_show;
 			PRIV_DEV_ATTR(id).nr = i;
-			PRIV_DEV_ATTR(id).index = j;
+			PRIV_DEV_ATTR(id).index = k;
 			sysfs_attr_init(&PRIV_DEV_ATTR(id).dev_attr.attr);
+			data++;
+			id++;
+			k++;
 		}
+		num_attrs += k;
 	}
 
 	priv->group.attrs = devm_kcalloc(&priv->pdev->dev,
@@ -481,20 +517,6 @@ static int mlxreg_hotplug_set_irq(struct mlxreg_hotplug_priv_data *priv)
 	item = pdata->items;
 
 	for (i = 0; i < pdata->counter; i++, item++) {
-		if (item->capability) {
-			/*
-			 * Read group capability register to get actual number
-			 * of interrupt capable components and set group mask
-			 * accordingly.
-			 */
-			ret = regmap_read(priv->regmap, item->capability,
-					  &regval);
-			if (ret)
-				goto out;
-
-			item->mask = GENMASK((regval & item->mask) - 1, 0);
-		}
-
 		/* Clear group presense event. */
 		ret = regmap_write(priv->regmap, item->reg +
 				   MLXREG_HOTPLUG_EVENT_OFF, 0);
-- 
2.11.0

