Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B12D2CA47E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbgLANxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:53:43 -0500
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:58386
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391417AbgLANxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:53:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+nsPPZqXQhKbMk2ZuZsxQZLyMy8D/pOQlZ8JNDBNNJfma3WfwCeiZ8xXeiG6oSV0CYtKJoUz5PcFNyE/JIqfGC59dbMjtpXaOzIwd/hiwmvmnDmHjNkZkiMiE1E/6AQRhmVSzk3X2hSfHB9Dv7etUrqXXkpVDeAAEBLeMFBrRRZkBC8u4UdXxAilqBbYC6/oIy9AqkRCsATrXzLnDu7smTB6aDuA7pofh+XdMdMPpfb5aurWI+0NUh3aNePIM9E3VjHEkOWusenON+KPcD4aYt5ktR8GR+euqqlaU1ne1YcmWeMVpJXNzqW7pR3upQJPCdNbi6OxFI4RH50TuYNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WShl6ODzqDCurh78QROjMRWv+VsqPn2jFepveeE24yE=;
 b=T6KgugO0rAErRdR6Fp0JQY6jDN2PbGVVFXQjYVlL2Khzam6zfQpY7S6zoHQdzaH7oTV3SBzGzVid+44XT6dKd7osez0TtKXHPbr38UbRfKnRtBFIPWepgeh9yt5RqlqPUxjaHzpTXLuUjycC6vuSPkqJ28/x/WaMoEkFNN6J3o7pmvEhAayYPcE2qP3R58c3aP3Xv0JTPmbIvoPBw7BM6C1kszkqQosxJHUdcM1OMThbqNaD87BoR8fOZmrBX70oePKw5x32VTeTJkTPyAr1cvshUQYvxWl15+N81rU27CY2oBrMrEAGv2wAqmZw7a4As3qmTicTIBNumPznFxpAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WShl6ODzqDCurh78QROjMRWv+VsqPn2jFepveeE24yE=;
 b=pvB/MC8pJLVWRr8BX3nV17vJCI7S7oDKT+qXEAm2tvCwj+kB1WFgD3JrgquBPtn+e/lTJ7Zzy/kPBCZN2u35WGaR+tr247V9sQyJ5gxIk5zeGSvfLD4EJhD+eiOrf6QwhLqMmYIaOWuaTdDgxEKMFuH9HY8d3n4guVT0s2+z3vM=
Received: from AM6PR04CA0011.eurprd04.prod.outlook.com (2603:10a6:20b:92::24)
 by AM7PR10MB3494.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 1 Dec
 2020 13:52:47 +0000
Received: from AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:92:cafe::71) by AM6PR04CA0011.outlook.office365.com
 (2603:10a6:20b:92::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 1 Dec 2020 13:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT056.mail.protection.outlook.com (10.152.9.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Tue, 1 Dec 2020 13:52:46 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 1 Dec 2020 14:52:36 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 92D113FBE8; Tue,  1 Dec 2020 13:52:36 +0000 (GMT)
Message-ID: <16d3f144f3b2d69b5788e0ee30dc3f3e94d3a55b.1606830377.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 1 Dec 2020 13:52:36 +0000
Subject: [PATCH V4 10/10] regulator: da9121: add interrupt support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93891913-0101-4d00-03b5-08d89600627f
X-MS-TrafficTypeDiagnostic: AM7PR10MB3494:
X-Microsoft-Antispam-PRVS: <AM7PR10MB34943BE16B0AA32951C5C169CBF40@AM7PR10MB3494.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:234;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MlzRWcgbe7JY8icQSPz+RlrJFjYwzBOkfssFC6ibR0WqTdlcWS+9Nmo0JVIGOGecE7eAfU9i3lqXb34BoSbBplxQHm+n7By/hhAanSv+puTsFEp0nSTq4TwRf6334BO9pdgif/+Wa3E+YPYIYYnyQGZtN05E/STSJ/Y2nqafArJ8/1RYkcojbZibGvjoWFKJ3629D+FLVK+m74mtKho4FziTbS9IQptFARXuasle6W+E5HUVTdyOVFQTeN0jGr63x7ge38jKpcDQF9n/RHm5sRJ3h+vTcJmyhv8C+sU1FS+tNjOKHKjhdbdjIo1cJINK9KGByaT+GHGsNTq4epQPemUL20BBi5rEev4XvcXsPYObJ7AEfWXwUsuzMEbcZRuwE1eQlrfTsJsVYsb92UG0Hw==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966005)(336012)(498600001)(30864003)(356005)(2906002)(110136005)(45080400002)(54906003)(8676002)(81166007)(42186006)(4326008)(36756003)(8936002)(82310400003)(186003)(83380400001)(6266002)(2616005)(107886003)(426003)(70586007)(70206006)(47076004)(5660300002)(86362001)(26005)(19627235002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 13:52:46.7163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93891913-0101-4d00-03b5-08d89600627f
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3494
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
index 8e50f55..3e59f68 100644
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
@@ -711,6 +921,55 @@ static int da9121_assign_chip_model(struct i2c_client *i2c,
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
+		ret = request_threaded_irq(chip->chip_irq, NULL,
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
@@ -738,6 +997,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct da9121 *chip;
+	const int mask_all[4] = { 0xFF, 0xFF, 0xFF, 0xFF };
 	int ret = 0;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(struct da9121), GFP_KERNEL);
@@ -753,12 +1013,37 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
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
+	free_irq(chip->chip_irq, chip);
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

