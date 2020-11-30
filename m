Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311ED2C8A46
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgK3RA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:29 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:23009
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729141AbgK3RA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XacQ5oZAEpLS0BsN8xIAHvLnrYm57hAof/ZdtEJHpioAUbHcEmxNA5jgXbrJzJqYcnVtwbjIAtJC+KItEhLyzjEq9FNlkF60oFHeJqV6hYiplKcdR5K9CStOH/H03zVWymDKyNVaPAGw7c/2HtGYPX5GIn9bcQtYM3f6zfaiMuZDlxv9cuGT96aw28yIKPtbMngEIgfDT6iISV5eNy1n0evTONI6jjTDI7oTQhEST2B1kUpWGVUIsgmmyspp0VKOiD7j2oI76G32o1CTi7iuu0JojHSoAGOeFqy/v+kW4ImIXkzm6Fj4hCxQrBrXZ7iqyrPPanGBFpSK9eUxfswNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JWr3tVoiYS/ggG1ay7j1/kCEB9Qo+Mgk1pXwxxBNYA=;
 b=EkcL2psrTGl694Hz3ROarAeK34ow4k12kl6ZcEuZbFGf/jdgLYbVHOW5KacRJY0aist4C9iUY+ylwXfxjig0WpSlYezb6yfBjBS19Ty7Cwyzbe40pun63Vkmn/5UnKHvsvlYoYCAIZodt4NZxQ3/gBh9/X6g5G8Vt2wGv5+BCvd0/N1n6yTnB3P9R8zq0kQ6chHW9vBCwTas+QWB1QeVXv2Wr5omnRZwXV5Wje9iQm3XJACBZN6PRcjV4wv2yWNdAMd3LraJFiAQxhlxnyOvFQIPkX9xtO09gaFWCxU0f3vqjWPDgiwTptNnA0teydP5yCEyNiP6Ib9KHKLppkMwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JWr3tVoiYS/ggG1ay7j1/kCEB9Qo+Mgk1pXwxxBNYA=;
 b=AnV/hUILQLUj+vYaRPX1Xez/5e+4ixX1oh7pJ/hYQshymUfz4kwL+lQzPvvHklnyUaqjUWHN0lZTcXT3x+weFQyuqIADqh4FPq4gLDKzG5WKhjQkxDIUeVnJC6XuYtHFFJtd24Ip1OvT1vmzT5S2uuaRnSbFuD8zvSA/aL7Bln0=
Received: from AM6PR0502CA0048.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::25) by AM6PR10MB2278.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 16:59:36 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::10) by AM6PR0502CA0048.outlook.office365.com
 (2603:10a6:20b:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 16:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 16:59:35 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 17:59:16 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 D1A6B3FBE4; Mon, 30 Nov 2020 16:59:14 +0000 (GMT)
Message-ID: <fe21796bbcbadff84a472a4cc581ae8fafc7f8f5.1606755367.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 16:59:14 +0000
Subject: [PATCH V3 10/10] regulator: da9121: add interrupt support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 354f43cb-5168-4be9-19f3-08d895515198
X-MS-TrafficTypeDiagnostic: AM6PR10MB2278:
X-Microsoft-Antispam-PRVS: <AM6PR10MB2278D946B1967CBF6E386582CBF50@AM6PR10MB2278.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:234;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNW1d1qAyuaNgJAxJOJVDVXpUW1ipN+5wnFCRALGeRrwFHuURvYwTerib5zhieUQCeG9yJ8u4CFqYyM5Bo7nQXAXSfU5w+WB6tcrITZktWkXnjolK5NEduyKM+X3AGQYZdWkBlRgYGg/svD4KAr9iKktvF7yVrJatWGoAErzqmDJ9c0DcqxRibddai+F3f7xpKOnZwI7KIvpfKmOkDMPqPb0pwF2UFQsf0gxEJn0QWQ/T+n1aMy6k7uBdwA9uPF/Kzfsy4cK728KX50J+IPPvmCRByoyRhqNkKK46Lst3iUljsf63LLjpmMz+IeFKEI2CwrdfvIzvn2UrFMnKNlAkNSWXSl/2jVe47RRfno2KemxgMfJc4Rz8jp9+KvoopEaGqxHoptXS/+MPr5qVtY9+g==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(47076004)(2616005)(4326008)(426003)(5660300002)(82310400003)(6266002)(336012)(8676002)(478600001)(86362001)(81166007)(356005)(82740400003)(36756003)(45080400002)(42186006)(70206006)(186003)(19627235002)(8936002)(70586007)(2906002)(83380400001)(30864003)(26005)(110136005)(316002)(54906003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 16:59:35.2524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354f43cb-5168-4be9-19f3-08d895515198
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2278
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds interrupt handler for variants, and notifications for events; over
temperature/voltage/current. Because the IRQs are triggered by persisting
status, they must be masked and the status polled until clear, before the
IRQ can be enabled again.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 286 +++++++++++++++++++++++++++++++++++
 1 file changed, 286 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 8e50f55..d9a8a4b 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -23,15 +23,21 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/regulator/da9121.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 #include "da9121-regulator.h"
 
 /* Chip data */
 struct da9121 {
 	struct device *dev;
+	struct delayed_work work;
 	struct da9121_pdata *pdata;
 	struct regmap *regmap;
 	struct regulator_dev *rdev[DA9121_IDX_MAX];
+	unsigned int persistent[2];
+	unsigned int passive_delay;
+	int chip_irq;
 	int variant_id;
 };
 
@@ -106,6 +112,59 @@ struct da9121_field {
 	{ DA9xxx_REG_BUCK_BUCK2_4, DA9121_MASK_BUCK_BUCKx_4_CHx_A_MODE },
 };
 
+struct status_event_data {
+	int buck_id; /* 0=core, 1/2-buck */
+	int reg_index;  /* index for status/event/mask register selection */
+	int status_bit; /* bit masks... */
+	int event_bit;
+	int mask_bit;
+	unsigned long notification; /* Notification for status inception */
+	char *warn; /* if NULL, notify - otherwise dev_warn this string */
+};
+
+#define DA9121_STATUS(id, bank, name, notification, warning) \
+	{ id, bank, \
+	DA9121_MASK_SYS_STATUS_##bank##_##name, \
+	DA9121_MASK_SYS_EVENT_##bank##_E_##name, \
+	DA9121_MASK_SYS_MASK_##bank##_M_##name, \
+	notification, warning }
+
+/* For second buck related event bits that are specific to DA9122, DA9220 variants */
+#define DA9xxx_STATUS(id, bank, name, notification, warning) \
+	{ id, bank, \
+	DA9xxx_MASK_SYS_STATUS_##bank##_##name, \
+	DA9xxx_MASK_SYS_EVENT_##bank##_E_##name, \
+	DA9xxx_MASK_SYS_MASK_##bank##_M_##name, \
+	notification, warning }
+
+/* The status signals that may need servicing, depending on device variant.
+ * After assertion, they persist; so event is notified, the IRQ disabled,
+ * and status polled until clear again and IRQ is reenabled.
+ *
+ * SG/PG1/PG2 should be set when device first powers up and should never
+ * re-occur. When this driver starts, it is expected that these will have
+ * self-cleared for when the IRQs are enabled, so these should never be seen.
+ * If seen, the implication is that the device has reset.
+ *
+ * GPIO0/1/2 are not configured for use by default, so should not be seen.
+ */
+const struct status_event_data status_event_handling[] = {
+	DA9xxx_STATUS(0, 0, SG, 0, "Handled E_SG\n"),
+	DA9121_STATUS(0, 0, TEMP_CRIT, (REGULATOR_EVENT_OVER_TEMP|REGULATOR_EVENT_DISABLE), NULL),
+	DA9121_STATUS(0, 0, TEMP_WARN, REGULATOR_EVENT_OVER_TEMP, NULL),
+	DA9121_STATUS(1, 1, PG1, 0, "Handled E_PG1\n"),
+	DA9121_STATUS(1, 1, OV1, REGULATOR_EVENT_REGULATION_OUT, NULL),
+	DA9121_STATUS(1, 1, UV1, REGULATOR_EVENT_UNDER_VOLTAGE, NULL),
+	DA9121_STATUS(1, 1, OC1, REGULATOR_EVENT_OVER_CURRENT, NULL),
+	DA9xxx_STATUS(2, 1, PG2, 0, "Handled E_PG2\n"),
+	DA9xxx_STATUS(2, 1, OV2, REGULATOR_EVENT_REGULATION_OUT, NULL),
+	DA9xxx_STATUS(2, 1, UV2, REGULATOR_EVENT_UNDER_VOLTAGE, NULL),
+	DA9xxx_STATUS(2, 1, OC2, REGULATOR_EVENT_OVER_CURRENT, NULL),
+	DA9121_STATUS(0, 2, GPIO0, 0, "Handled E_GPIO0\n"),
+	DA9121_STATUS(0, 2, GPIO1, 0, "Handled E_GPIO1\n"),
+	DA9121_STATUS(0, 2, GPIO2, 0, "Handled E_GPIO2\n"),
+};
+
 static int da9121_get_current_limit(struct regulator_dev *rdev)
 {
 	struct da9121 *chip = rdev_get_drvdata(rdev);
@@ -479,6 +538,157 @@ static int da9121_of_parse_cb(struct device_node *np,
 	[DA9121_TYPE_DA9217] = { &da9217_reg, NULL },
 };
 
+static void da9121_status_poll_on(struct work_struct *work)
+{
+	struct da9121 *chip = container_of(work, struct da9121, work.work);
+	int status[3] = {0};
+	int clear[3] = {0};
+	unsigned long delay;
+	int i;
+	int ret;
+
+	ret = regmap_bulk_read(chip->regmap, DA9121_REG_SYS_STATUS_0, status, 2);
+	if (ret < 0) {
+		dev_err(chip->dev,
+			"Failed to read STATUS registers: %d\n", ret);
+		goto error;
+	}
+
+	/* Possible events are tested to be within range for the variant, potentially
+	 * masked by the IRQ handler (not just warned about), as having been masked,
+	 * and the respective state cleared - then flagged to unmask for next IRQ.
+	 */
+	for (i = 0; i < ARRAY_SIZE(status_event_handling); i++) {
+		const struct status_event_data *item = &status_event_handling[i];
+		int reg_idx = item->reg_index;
+		bool relevant = (item->buck_id <= variant_parameters[chip->variant_id].num_bucks);
+		bool supported = (item->warn == NULL);
+		bool persisting = (chip->persistent[reg_idx] & item->event_bit);
+		bool now_cleared = !(status[reg_idx] & item->status_bit);
+
+		if (relevant && supported && persisting && now_cleared) {
+			clear[reg_idx] |= item->mask_bit;
+			chip->persistent[reg_idx] &= ~item->event_bit;
+		}
+	}
+
+	for (i = 0; i < 2; i++) {
+		if (clear[i]) {
+			unsigned int reg = DA9121_REG_SYS_MASK_0 + i;
+			unsigned int mbit = clear[i];
+
+			ret = regmap_update_bits(chip->regmap, reg, mbit, 0);
+			if (ret < 0) {
+				dev_err(chip->dev,
+					"Failed to unmask 0x%02x %d\n",
+					reg, ret);
+				goto error;
+			}
+		}
+	}
+
+	if (chip->persistent[0] | chip->persistent[1]) {
+		delay = msecs_to_jiffies(chip->passive_delay);
+		queue_delayed_work(system_freezable_wq, &chip->work, delay);
+	}
+
+error:
+	return;
+}
+
+static irqreturn_t da9121_irq_handler(int irq, void *data)
+{
+	struct da9121 *chip = data;
+	struct regulator_dev *rdev;
+	int event[3] = {0};
+	int handled[3] = {0};
+	int mask[3] = {0};
+	int ret = IRQ_NONE;
+	int i;
+	int err;
+
+	err = regmap_bulk_read(chip->regmap, DA9121_REG_SYS_EVENT_0, event, 3);
+	if (err < 0) {
+		dev_err(chip->dev, "Failed to read EVENT registers %d\n", err);
+		ret = IRQ_NONE;
+		goto error;
+	}
+
+	err = regmap_bulk_read(chip->regmap, DA9121_REG_SYS_MASK_0, mask, 3);
+	if (err < 0) {
+		dev_err(chip->dev,
+			"Failed to read MASK registers: %d\n", ret);
+		ret = IRQ_NONE;
+		goto error;
+	}
+
+	rdev = chip->rdev[DA9121_IDX_BUCK1];
+
+	/* Possible events are tested to be within range for the variant, currently
+	 * enabled, and having triggered this IRQ. The event may then be notified,
+	 * or a warning given for unexpected events - those from device POR, and
+	 * currently unsupported GPIO configurations.
+	 */
+	for (i = 0; i < ARRAY_SIZE(status_event_handling); i++) {
+		const struct status_event_data *item = &status_event_handling[i];
+		int reg_idx = item->reg_index;
+		bool relevant = (item->buck_id <= variant_parameters[chip->variant_id].num_bucks);
+		bool enabled = !(mask[reg_idx] & item->mask_bit);
+		bool active = (event[reg_idx] & item->event_bit);
+		bool notify = (item->warn == NULL);
+
+		if (relevant && enabled && active) {
+			if (notify) {
+				chip->persistent[reg_idx] |= item->event_bit;
+				regulator_notifier_call_chain(rdev, item->notification, NULL);
+			} else {
+				dev_warn(chip->dev, item->warn);
+				handled[reg_idx] |= item->event_bit;
+				ret = IRQ_HANDLED;
+			}
+		}
+	}
+
+	for (i = 0; i < 3; i++) {
+		if (event[i] != handled[i]) {
+			dev_warn(chip->dev,
+				"Unhandled event(s) in bank%d 0x%02x\n", i,
+				event[i] ^ handled[i]);
+		}
+	}
+
+	/* Mask the interrupts for persistent events OV, OC, UV, WARN, CRIT */
+	for (i = 0; i < 2; i++) {
+		if (handled[i]) {
+			unsigned int reg = DA9121_REG_SYS_MASK_0 + i;
+			unsigned int mbit = handled[i];
+
+			err = regmap_update_bits(chip->regmap, reg, mbit, mbit);
+			if (err < 0) {
+				dev_err(chip->dev,
+					"Failed to mask 0x%02x interrupt %d\n",
+					reg, err);
+				ret = IRQ_NONE;
+				goto error;
+			}
+		}
+	}
+
+	/* clear the events */
+	if (handled[0] | handled[1] | handled[2]) {
+		err = regmap_bulk_write(chip->regmap, DA9121_REG_SYS_EVENT_0, handled, 3);
+		if (err < 0) {
+			dev_err(chip->dev, "Fail to write EVENTs %d\n", err);
+			ret = IRQ_NONE;
+			goto error;
+		}
+	}
+
+	queue_delayed_work(system_freezable_wq, &chip->work, 0);
+error:
+	return ret;
+}
+
 static int da9121_set_regulator_config(struct da9121 *chip)
 {
 	struct regulator_config config = { };
@@ -711,6 +921,56 @@ static int da9121_assign_chip_model(struct i2c_client *i2c,
 	return ret;
 }
 
+static int da9121_config_irq(struct i2c_client *i2c,
+			struct da9121 *chip)
+{
+	unsigned int p_delay = DA9121_DEFAULT_POLLING_PERIOD_MS;
+	const int mask_all[4] = { 0, 0, 0xFF, 0xFF };
+	int ret = 0;
+
+	chip->chip_irq = i2c->irq;
+
+	if (chip->chip_irq != 0) {
+		if (!of_property_read_u32(chip->dev->of_node,
+					  "dlg,irq-polling-delay-passive-ms",
+					  &p_delay)) {
+			if (p_delay < DA9121_MIN_POLLING_PERIOD_MS ||
+			    p_delay > DA9121_MAX_POLLING_PERIOD_MS) {
+				dev_warn(chip->dev,
+					 "Out-of-range polling period %d ms\n",
+					 p_delay);
+				p_delay = DA9121_DEFAULT_POLLING_PERIOD_MS;
+			}
+		}
+
+		chip->passive_delay = p_delay;
+
+		ret = devm_request_threaded_irq(chip->dev,
+					chip->chip_irq, NULL,
+					da9121_irq_handler,
+					IRQF_TRIGGER_LOW|IRQF_ONESHOT,
+					"da9121", chip);
+		if (ret != 0) {
+			dev_err(chip->dev, "Failed IRQ request: %d\n",
+				chip->chip_irq);
+			goto error;
+		}
+
+		ret = regmap_bulk_write(chip->regmap, DA9121_REG_SYS_MASK_0, mask_all, 4);
+		if (ret != 0) {
+			dev_err(chip->dev, "Failed to set IRQ masks: %d\n",
+				ret);
+			goto error;
+		}
+
+		INIT_DELAYED_WORK(&chip->work, da9121_status_poll_on);
+		dev_info(chip->dev, "Interrupt polling period set at %d ms\n",
+			 chip->passive_delay);
+	}
+error:
+	return ret;
+}
+
 static const struct of_device_id da9121_dt_ids[] = {
 	{ .compatible = "dlg,da9121", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
 	{ .compatible = "dlg,da9130", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
@@ -738,6 +998,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct da9121 *chip;
+	const int mask_all[4] = { 0xFF, 0xFF, 0xFF, 0xFF };
 	int ret = 0;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(struct da9121), GFP_KERNEL);
@@ -753,12 +1014,36 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		goto error;
 
+	ret = regmap_bulk_write(chip->regmap, DA9121_REG_SYS_MASK_0, mask_all, 4);
+	if (ret != 0) {
+		dev_err(chip->dev, "Failed to set IRQ masks: %d\n", ret);
+		goto error;
+	}
+
 	ret = da9121_set_regulator_config(chip);
+	if (ret < 0)
+		goto error;
+
+	ret = da9121_config_irq(i2c, chip);
 
 error:
 	return ret;
 }
 
+static int da9121_i2c_remove(struct i2c_client *i2c)
+{
+	struct da9121 *chip = i2c_get_clientdata(i2c);
+	const int mask_all[4] = { 0xFF, 0xFF, 0xFF, 0xFF };
+	int ret = 0;
+
+	cancel_delayed_work_sync(&chip->work);
+
+	ret = regmap_bulk_write(chip->regmap, DA9121_REG_SYS_MASK_0, mask_all, 4);
+	if (ret != 0)
+		dev_err(chip->dev, "Failed to set IRQ masks: %d\n", ret);
+	return ret;
+}
+
 static const struct i2c_device_id da9121_i2c_id[] = {
 	{"da9121", DA9121_TYPE_DA9121_DA9130},
 	{"da9130", DA9121_TYPE_DA9121_DA9130},
@@ -777,6 +1062,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 		.of_match_table = of_match_ptr(da9121_dt_ids),
 	},
 	.probe = da9121_i2c_probe,
+	.remove = da9121_i2c_remove,
 	.id_table = da9121_i2c_id,
 };
 
-- 
1.9.1

