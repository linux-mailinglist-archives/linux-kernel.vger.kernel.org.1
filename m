Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902682BA9F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgKTMPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:15:15 -0500
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:15776
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbgKTMPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:15:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLFXQKnrbdS9OyOOmEE52kiN+7PWCaLgZU3oMGHO698wbX7ehB5iqyRPv7Ptft8TkgXWbWjdQdTv8P4xbzRtQKHxxxiCZXaS7sI81j2mFugh4C3dhvAOC7Xbpbj6Kd8KjCJNFVL7F6wIXZSbOfKHggqwaCwpaU/CMJJlxLJcsn0z88sbKTip8ETCTd6QTaIYcrGiuhE2BVXI4UMaTtdaaWrKTAVFgIev6J2jnhrbF4POglIIj5lzJIXVMygfQ17Cl28QByiK5ZspEZSg0AO0c7c1h/PQfH+qcjAaXDFQxs0ZqyqVQAqi0a+f4vYOGLtdDEIMuxk3abMrK3z0Q4GWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD8N8O6psuSbznlN6qTiY72gCio7BughXkBTcrXYiCA=;
 b=a3vXfbLlFWJc6nu2S7SBmGg9XW1YKh1L2EInaicGv4LgjVRf6MnqCn7TabvwrxkikHyq74U5nPjxSk8WiezmTPNPlvFcfe6yWggOZ3s/jJeAdgIEZVGV1xuqP4+6rjtKi4cK11AqyK7dexmm/9Td2kxaSYO3q2dUYP17h5f7frmwN68toXQ6gmLZHZAYC0M0NFA9WoQM7novsPzSbh1hRCp3wTJ3pPJ5/CTLBdm91S9P7UT6z6fWe+6NKz5zE0jpX3bNmGE7ypLLm+El5qd+tqs2QGOvAy4GBbyKrI8i3P2/M+1S+N0q1Y68OxxiRd37YMuEY/E+K7xUbWRLFkQB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD8N8O6psuSbznlN6qTiY72gCio7BughXkBTcrXYiCA=;
 b=gxNlifd15n9u0GGyDwBd0WxE+TEUVy5yZAdRvdYj6U4HGKxQ9hBgp6TbdX7Ws/FSWYGpHPCaqgkkCLe/C8aF7sLSEEagNHk4pHeQ05kSIExKz2FFQlI6X6J3UzSEFhvzIRIgCMoSusrYbiK3FuyEveroIIlH/9uHsPIOF+MKhRA=
Received: from AM7PR04CA0002.eurprd04.prod.outlook.com (2603:10a6:20b:110::12)
 by HE1PR1001MB0986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:72::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 20 Nov
 2020 12:15:01 +0000
Received: from AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::98) by AM7PR04CA0002.outlook.office365.com
 (2603:10a6:20b:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 12:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT003.mail.protection.outlook.com (10.152.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 12:15:01 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Nov 2020 13:14:59 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 1BAD73FBAB; Fri, 20 Nov 2020 12:14:59 +0000 (GMT)
Message-ID: <ef98a01f6281ae6c925f283b51804f7f5194d230.1605868780.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <adam.ward@diasemi.com>
Date:   Fri, 20 Nov 2020 12:14:59 +0000
Subject: [PATCH 9/9] regulator: da9121: add interrupt support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce2dd94-7961-47f3-7196-08d88d4de7e9
X-MS-TrafficTypeDiagnostic: HE1PR1001MB0986:
X-Microsoft-Antispam-PRVS: <HE1PR1001MB0986E1A1B8C3C94EAD1F1A23CBFF0@HE1PR1001MB0986.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:192;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FitiZI9YUQSlZxmTofK8T+1ddT/HizKRaPxdteUmEMPyBWKLc7t8j+o1on7DggfW8D/dxf7BQMGm4bW/mTYkKyQm5G/Rg7IEzUeJX8NbtQ/JX82Co+Lux4yyuajrXgN1R8UYlfgnbmtepdJAUuTGQmFc4EtzPGP/KWcaZ59FonSFjcmsH3oIZ/PIiUlqjoWkkjGI6Q9Qpfz/G+iLa7utdL4tRSfLnNL3c+/F2Fati9oRhzK93jA7TXRz5v3CSPLHJERwWiyBKpIrGF9JEmnHugJS1mfvQH9kynLfwQIDFo8AxRgp6Pkzx2BVPjpHnjyOArP8444ftPMTbxTOkhHOZ3JXJ0K5W0jFp/DjBEPhYR2cahCuaUn7Xf3aj3NixBst0jeEjMxAff2yhOFQfQRKmIFYTF92YD89I9C6WFSLf2BErbtN0quEXBOLH6mPnAFh
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(44832011)(33310700002)(70206006)(70586007)(5660300002)(426003)(82740400003)(45080400002)(83380400001)(186003)(2616005)(36756003)(2906002)(336012)(30864003)(36906005)(4326008)(26005)(6266002)(47076004)(316002)(356005)(81166007)(110136005)(82310400003)(54906003)(42186006)(478600001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 12:15:01.3270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce2dd94-7961-47f3-7196-08d88d4de7e9
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB0986
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds interrupt handler for variants, and notifications for events; over
temperature/voltage/current.
Also handling of persistent events and respective timing configuration.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 548 +++++++++++++++++++++++++++++++++++
 1 file changed, 548 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 3addbd2..37a767e 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -24,15 +24,22 @@
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
+	struct regmap *regmap;
 	struct da9121_pdata *pdata;
 	struct regmap *regmap;
 	struct regulator_dev *rdev[DA9121_IDX_MAX];
+	unsigned int persistent[2];
+	unsigned int passive_delay;
+	int chip_irq;
 	int variant_id;
 };
 
@@ -92,6 +99,104 @@ struct da9121_variant_info {
 	{ 1, 2, &da9121_6A_2phase_current  },	//DA9121_TYPE_DA9217
 };
 
+static void da9121_status_poll_on(struct work_struct *work)
+{
+	struct da9121 *chip = container_of(work, struct da9121, work.work);
+	enum { R0 = 0, R1, R2, REG_MAX_NUM };
+	int status[REG_MAX_NUM] = {0};
+	int clear[REG_MAX_NUM] = {0};
+	unsigned long delay;
+	int i;
+	int ret;
+
+	/* If persistent-notification, status will be true
+	 * If not persistent-notification any longer, status will be false
+	 */
+	ret = regmap_bulk_read(chip->regmap, DA9121_REG_SYS_STATUS_0,
+			(void *)status, (size_t)REG_MAX_NUM);
+	if (ret < 0) {
+		dev_err(chip->dev,
+			"Failed to read STATUS registers: %d\n", ret);
+		goto error;
+	}
+
+	/* 0 TEMP_CRIT */
+	if ((chip->persistent[R0] & DA9121_MASK_SYS_EVENT_0_E_TEMP_CRIT) &&
+	    !(status[R0] & DA9121_MASK_SYS_STATUS_0_TEMP_CRIT)) {
+		clear[R0] |= DA9121_MASK_SYS_MASK_0_M_TEMP_CRIT;
+		chip->persistent[R0] &= ~DA9121_MASK_SYS_EVENT_0_E_TEMP_CRIT;
+	}
+	/* 0 TEMP_WARN */
+	if ((chip->persistent[R0] & DA9121_MASK_SYS_EVENT_0_E_TEMP_WARN) &&
+	    !(status[R0] & DA9121_MASK_SYS_STATUS_0_TEMP_WARN)) {
+		clear[R0] |= DA9121_MASK_SYS_MASK_0_M_TEMP_WARN;
+		chip->persistent[R0] &= ~DA9121_MASK_SYS_EVENT_0_E_TEMP_WARN;
+	}
+
+	/* 1 OV1 */
+	if ((chip->persistent[R1] & DA9121_MASK_SYS_EVENT_1_E_OV1) &&
+	    !(status[R1] & DA9121_MASK_SYS_STATUS_1_OV1)) {
+		clear[R1] |= DA9121_MASK_SYS_MASK_1_M_OV1;
+		chip->persistent[R1] &= ~DA9121_MASK_SYS_EVENT_1_E_OV1;
+	}
+	/* 1 UV1 */
+	if ((chip->persistent[R1] & DA9121_MASK_SYS_EVENT_1_E_UV1) &&
+	    !(status[R1] & DA9121_MASK_SYS_STATUS_1_UV1)) {
+		clear[R1] |= DA9121_MASK_SYS_MASK_1_M_UV1;
+		chip->persistent[R1] &= ~DA9121_MASK_SYS_EVENT_1_E_UV1;
+	}
+	/* 1 OC1 */
+	if ((chip->persistent[R1] & DA9121_MASK_SYS_EVENT_1_E_OC1) &&
+	    !(status[R1] & DA9121_MASK_SYS_STATUS_1_OC1)) {
+		clear[R1] |= DA9121_MASK_SYS_MASK_1_M_OC1;
+		chip->persistent[R1] &= ~DA9121_MASK_SYS_EVENT_1_E_OC1;
+	}
+
+	if (variant_parameters[chip->variant_id].num_bucks == 2) {
+		/* 1 OV2 */
+		if ((chip->persistent[R1] & DA9xxx_MASK_SYS_EVENT_1_E_OV2) &&
+		    !(status[R1] & DA9xxx_MASK_SYS_STATUS_1_OV2)) {
+			clear[R1] |= DA9xxx_MASK_SYS_MASK_1_M_OV2;
+			chip->persistent[R1] &= ~DA9xxx_MASK_SYS_EVENT_1_E_OV2;
+		}
+		/* 1 UV2 */
+		if ((chip->persistent[R1] & DA9xxx_MASK_SYS_EVENT_1_E_UV2) &&
+		    !(status[R1] & DA9xxx_MASK_SYS_STATUS_1_UV2)) {
+			clear[R1] |= DA9xxx_MASK_SYS_MASK_1_M_UV2;
+			chip->persistent[R1] &= ~DA9xxx_MASK_SYS_EVENT_1_E_UV2;
+		}
+		/* 1 OC2 */
+		if ((chip->persistent[R1] & DA9xxx_MASK_SYS_EVENT_1_E_OC2) &&
+		    !(status[R1] & DA9xxx_MASK_SYS_STATUS_1_OC2)) {
+			clear[R1] |= DA9xxx_MASK_SYS_MASK_1_M_OC2;
+			chip->persistent[R1] &= ~DA9xxx_MASK_SYS_EVENT_1_E_OC2;
+		}
+	}
+
+	for (i = R0; i < REG_MAX_NUM-1; i++) {
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
+	if (chip->persistent[R0] | chip->persistent[R1]) {
+		delay = msecs_to_jiffies(chip->passive_delay);
+		queue_delayed_work(system_freezable_wq, &chip->work, delay);
+	}
+
+error:
+	return;
+}
+
 static bool da9121_rdev_to_buck_reg_mask(struct regulator_dev *rdev, bool mode,
 					 unsigned int *reg, unsigned int *msk)
 {
@@ -528,6 +633,311 @@ static struct da9121_pdata *da9121_parse_regulators_dt(struct da9121 *chip)
 }
 #endif
 
+static inline int da9121_handle_notifier(
+		struct da9121 *chip, struct regulator_dev *rdev,
+		unsigned int event_bank, unsigned int event, unsigned int ebit)
+{
+	enum { R0 = 0, R1, R2, REG_MAX_NUM };
+	unsigned long notification = 0;
+	int ret = 0;
+
+	if (event & ebit) {
+		switch (event_bank) {
+		case DA9121_REG_SYS_EVENT_0:
+			switch (event & ebit) {
+			case DA9121_MASK_SYS_EVENT_0_E_TEMP_CRIT:
+				chip->persistent[R0] |= DA9121_MASK_SYS_EVENT_0_E_TEMP_CRIT;
+				notification |= REGULATOR_EVENT_OVER_TEMP |
+						REGULATOR_EVENT_DISABLE;
+				break;
+			case DA9121_MASK_SYS_EVENT_0_E_TEMP_WARN:
+				chip->persistent[R0] |= DA9121_MASK_SYS_EVENT_0_E_TEMP_WARN;
+				notification |= REGULATOR_EVENT_OVER_TEMP;
+				break;
+			default:
+				dev_warn(chip->dev,
+					 "Unhandled event in bank0 0x%02x\n",
+					 event & ebit);
+				ret = -EINVAL;
+				break;
+			}
+			break;
+		case DA9121_REG_SYS_EVENT_1:
+			switch (event & ebit) {
+			case DA9121_MASK_SYS_EVENT_1_E_OV1:
+				chip->persistent[R1] |= DA9121_MASK_SYS_EVENT_1_E_OV1;
+				notification |= REGULATOR_EVENT_REGULATION_OUT;
+				break;
+			case DA9121_MASK_SYS_EVENT_1_E_UV1:
+				chip->persistent[R1] |= DA9121_MASK_SYS_EVENT_1_E_UV1;
+				notification |= REGULATOR_EVENT_UNDER_VOLTAGE;
+				break;
+			case DA9121_MASK_SYS_EVENT_1_E_OC1:
+				chip->persistent[R1] |= DA9121_MASK_SYS_EVENT_1_E_OC1;
+				notification |= REGULATOR_EVENT_OVER_CURRENT;
+				break;
+			case DA9xxx_MASK_SYS_EVENT_1_E_OV2:
+				chip->persistent[R1] |= DA9xxx_MASK_SYS_EVENT_1_E_OV2;
+				notification |= REGULATOR_EVENT_REGULATION_OUT;
+				break;
+			case DA9xxx_MASK_SYS_EVENT_1_E_UV2:
+				chip->persistent[R1] |= DA9xxx_MASK_SYS_EVENT_1_E_UV2;
+				notification |= REGULATOR_EVENT_UNDER_VOLTAGE;
+				break;
+			case DA9xxx_MASK_SYS_EVENT_1_E_OC2:
+				chip->persistent[R1] |= DA9xxx_MASK_SYS_EVENT_1_E_OC2;
+				notification |= REGULATOR_EVENT_OVER_CURRENT;
+				break;
+			default:
+				dev_warn(chip->dev,
+					 "Unhandled event in bank1 0x%02x\n",
+					 event & ebit);
+				ret = -EINVAL;
+				break;
+			}
+			break;
+		default:
+			dev_warn(chip->dev,
+				 "Unhandled event bank 0x%02x\n", event_bank);
+			ret = -EINVAL;
+			goto error;
+		}
+
+		regulator_notifier_call_chain(rdev, notification, NULL);
+	}
+
+error:
+	return ret;
+}
+
+static irqreturn_t da9121_irq_handler(int irq, void *data)
+{
+	struct da9121 *chip = data;
+	struct regulator_dev *rdev;
+	enum { R0 = 0, R1, R2, REG_MAX_NUM };
+	int event[REG_MAX_NUM] = {0};
+	int handled[REG_MAX_NUM] = {0};
+	int mask[REG_MAX_NUM] = {0};
+	int ret = IRQ_NONE;
+	int i;
+	int err;
+
+	err = regmap_bulk_read(chip->regmap, DA9121_REG_SYS_EVENT_0,
+			(void *)event, (size_t)REG_MAX_NUM);
+	if (err < 0) {
+		dev_err(chip->dev, "Failed to read EVENT registers %d\n", err);
+		ret = IRQ_NONE;
+		goto error;
+	}
+
+	err = regmap_bulk_read(chip->regmap, DA9121_REG_SYS_MASK_0,
+			(void *)mask, (size_t)REG_MAX_NUM);
+	if (err < 0) {
+		dev_err(chip->dev,
+			"Failed to read MASK registers: %d\n", ret);
+		ret = IRQ_NONE;
+		goto error;
+	}
+
+	rdev = chip->rdev[DA9121_IDX_BUCK1];
+
+	/* 0 SYSTEM_GOOD */
+	if (!(mask[R0] & DA9xxx_MASK_SYS_MASK_0_M_SG) &&
+	    (event[R0] & DA9xxx_MASK_SYS_EVENT_0_E_SG)) {
+		dev_warn(chip->dev, "Handled E_SG\n");
+		handled[R0] |= DA9xxx_MASK_SYS_EVENT_0_E_SG;
+		ret = IRQ_HANDLED;
+	}
+
+	/* 0 TEMP_CRIT */
+	if (!(mask[R0] & DA9121_MASK_SYS_MASK_0_M_TEMP_CRIT) &&
+	    (event[R0] & DA9121_MASK_SYS_EVENT_0_E_TEMP_CRIT)) {
+		err = da9121_handle_notifier(chip, rdev,
+			DA9121_REG_SYS_EVENT_0,	event[R0],
+			DA9121_MASK_SYS_EVENT_0_E_TEMP_CRIT);
+		if (!err) {
+			handled[R0] |= DA9121_MASK_SYS_EVENT_0_E_TEMP_CRIT;
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	/* 0 TEMP_WARN */
+	if (!(mask[R0] & DA9121_MASK_SYS_MASK_0_M_TEMP_WARN) &&
+	    (event[R0] & DA9121_MASK_SYS_EVENT_0_E_TEMP_WARN)) {
+		err = da9121_handle_notifier(chip, rdev,
+			DA9121_REG_SYS_EVENT_0, event[R0],
+			DA9121_MASK_SYS_EVENT_0_E_TEMP_WARN);
+		if (!err) {
+			handled[R0] |= DA9121_MASK_SYS_EVENT_0_E_TEMP_WARN;
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	if (event[R0] != handled[R0]) {
+		dev_warn(chip->dev,
+			 "Unhandled event in bank0 0x%02x\n",
+			 event[R0] ^ handled[R0]);
+	}
+
+	/* 1 PG1 */
+	if (!(mask[R1] & DA9121_MASK_SYS_MASK_1_M_PG1) &&
+	    (event[R1] & DA9121_MASK_SYS_EVENT_1_E_PG1)) {
+		dev_warn(chip->dev, "Handled E_PG1\n");
+		handled[R1] |= DA9121_MASK_SYS_EVENT_1_E_PG1;
+		ret = IRQ_HANDLED;
+	}
+
+	/* 1 OV1 */
+	if (!(mask[R1] & DA9121_MASK_SYS_MASK_1_M_OV1) &&
+	    (event[R1] & DA9121_MASK_SYS_EVENT_1_E_OV1)) {
+		err = da9121_handle_notifier(chip, rdev,
+			DA9121_REG_SYS_EVENT_1,	event[R1],
+			DA9121_MASK_SYS_EVENT_1_E_OV1);
+		if (!err) {
+			handled[R1] |= DA9121_MASK_SYS_EVENT_1_E_OV1;
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	/* 1 UV1 */
+	if (!(mask[R1] & DA9121_MASK_SYS_MASK_1_M_UV1) &&
+	    (event[R1] & DA9121_MASK_SYS_EVENT_1_E_UV1)) {
+		err = da9121_handle_notifier(chip, rdev,
+			DA9121_REG_SYS_EVENT_1,	event[R1],
+			DA9121_MASK_SYS_EVENT_1_E_UV1);
+		if (!err) {
+			handled[R1] |= DA9121_MASK_SYS_EVENT_1_E_UV1;
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	/* 1 OC1 */
+	if (!(mask[R1] & DA9121_MASK_SYS_MASK_1_M_OC1) &&
+	    (event[R1] & DA9121_MASK_SYS_EVENT_1_E_OC1)) {
+		err = da9121_handle_notifier(chip, rdev,
+			DA9121_REG_SYS_EVENT_1,	event[R1],
+			DA9121_MASK_SYS_EVENT_1_E_OC1);
+		if (!err) {
+			handled[R1] |= DA9121_MASK_SYS_EVENT_1_E_OC1;
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	if (variant_parameters[chip->variant_id].num_bucks == 2) {
+		struct regulator_dev *rdev2 = chip->rdev[DA9121_IDX_BUCK2];
+
+		/* 1 PG2 */
+		if (!(mask[R1] & DA9xxx_MASK_SYS_MASK_1_M_PG2) &&
+		    (event[R1] & DA9xxx_MASK_SYS_EVENT_1_E_PG2)) {
+			dev_warn(chip->dev, "Handled E_PG2\n");
+			handled[R1] |= DA9xxx_MASK_SYS_EVENT_1_E_PG2;
+			ret = IRQ_HANDLED;
+		}
+
+		/* 1 OV2 */
+		if (!(mask[R1] & DA9xxx_MASK_SYS_MASK_1_M_OV2) &&
+		    (event[R1] & DA9xxx_MASK_SYS_EVENT_1_E_OV2)) {
+			err = da9121_handle_notifier(chip, rdev2,
+				DA9121_REG_SYS_EVENT_1,	event[R1],
+				DA9xxx_MASK_SYS_EVENT_1_E_OV2);
+			if (!err) {
+				handled[R1] |= DA9xxx_MASK_SYS_EVENT_1_E_OV2;
+				ret = IRQ_HANDLED;
+			}
+		}
+
+		/* 1 UV2 */
+		if (!(mask[R1] & DA9xxx_MASK_SYS_MASK_1_M_UV2) &&
+		    (event[R1] & DA9xxx_MASK_SYS_EVENT_1_E_UV2)) {
+			err = da9121_handle_notifier(chip, rdev2,
+				DA9121_REG_SYS_EVENT_1,	event[R1],
+				DA9xxx_MASK_SYS_EVENT_1_E_UV2);
+			if (!err) {
+				handled[R1] |= DA9xxx_MASK_SYS_EVENT_1_E_UV2;
+				ret = IRQ_HANDLED;
+			}
+		}
+
+		/* 1 OC2 */
+		if (!(mask[R1] & DA9xxx_MASK_SYS_MASK_1_M_OC2) &&
+		    (event[R1] & DA9xxx_MASK_SYS_EVENT_1_E_OC2)) {
+			err = da9121_handle_notifier(chip, rdev2,
+				DA9121_REG_SYS_EVENT_1,	event[R1],
+				DA9xxx_MASK_SYS_EVENT_1_E_OC2);
+			if (!err) {
+				handled[R1] |= DA9xxx_MASK_SYS_EVENT_1_E_OC2;
+				ret = IRQ_HANDLED;
+			}
+		}
+	}
+
+	if (event[R1] != handled[R1]) {
+		dev_warn(chip->dev,
+			 "Unhandled event in bank1 0x%02x\n",
+			 event[R1] ^ handled[R1]);
+	}
+
+	/* DA9121_REG_SYS_EVENT_2 */
+	if (!(mask[R2] & DA9121_MASK_SYS_MASK_2_M_GPIO2) &&
+	    (event[R2] & DA9121_MASK_SYS_EVENT_2_E_GPIO2)) {
+		dev_warn(chip->dev, "Handled E_GPIO2\n");
+		handled[R2] |= DA9121_MASK_SYS_EVENT_2_E_GPIO2;
+		ret = IRQ_HANDLED;
+	}
+
+	if (!(mask[R2] & DA9121_MASK_SYS_MASK_2_M_GPIO1) &&
+	    (event[R2] & DA9121_MASK_SYS_EVENT_2_E_GPIO1)) {
+		dev_warn(chip->dev, "Handled E_GPIO1\n");
+		handled[R2] |= DA9121_MASK_SYS_EVENT_2_E_GPIO1;
+		ret = IRQ_HANDLED;
+	}
+
+	if (!(mask[R2] & DA9121_MASK_SYS_MASK_2_M_GPIO0) &&
+	    (event[R2] & DA9121_MASK_SYS_EVENT_2_E_GPIO0)) {
+		dev_warn(chip->dev, "Handled E_GPIO0\n");
+		handled[R2] |= DA9121_MASK_SYS_EVENT_2_E_GPIO0;
+		ret = IRQ_HANDLED;
+	}
+
+	if (event[R2] != handled[R2]) {
+		dev_warn(chip->dev,
+			 "Unhandled event in bank2 0x%02x\n",
+			 event[R2] ^ handled[R2]);
+	}
+
+	/* Mask the interrupts for persistent events OV, OC, UV, WARN, CRIT */
+	for (i = R0; i < REG_MAX_NUM-1; i++) {
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
+	if (handled[R0] | handled[R1] | handled[R2]) {
+		err = regmap_bulk_write(chip->regmap, DA9121_REG_SYS_EVENT_0,
+				(const void *)handled, (size_t)REG_MAX_NUM);
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
@@ -835,6 +1245,117 @@ static int da9121_assign_chip_model(struct i2c_client *i2c,
 	return ret;
 }
 
+static int da9121_set_irq_masks(struct da9121 *chip, bool mask_irqs)
+{
+	unsigned int mask0, update0;
+	unsigned int mask1, update1;
+	unsigned int mask3;
+	int ret = 0;
+
+	if (chip->chip_irq != 0) {
+		mask0 = DA9121_MASK_SYS_MASK_0_M_TEMP_CRIT |
+			DA9121_MASK_SYS_MASK_0_M_TEMP_WARN;
+
+		mask1 = DA9121_MASK_SYS_MASK_1_M_OV1 |
+			DA9121_MASK_SYS_MASK_1_M_UV1 |
+			DA9121_MASK_SYS_MASK_1_M_OC1;
+
+		if (mask_irqs) {
+			update0 = mask0;
+			update1 = mask1;
+		} else {
+			update0 = 0;
+			update1 = 0;
+		}
+
+		ret = regmap_update_bits(chip->regmap,
+				DA9121_REG_SYS_MASK_0,
+				mask0,
+				update0);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to write MASK 0 reg %d\n",
+				ret);
+			goto error;
+		}
+
+		ret = regmap_update_bits(chip->regmap,
+				DA9121_REG_SYS_MASK_1,
+				mask1,
+				update1);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to write MASK 1 reg %d\n",
+				ret);
+			goto error;
+		}
+
+		/* permanently disable IRQs for VR_HOT and PG1_STAT */
+		mask3 = DA9121_MASK_SYS_MASK_3_M_VR_HOT |
+			DA9121_MASK_SYS_MASK_3_M_PG1_STAT;
+
+		ret = regmap_update_bits(chip->regmap,
+				DA9121_REG_SYS_MASK_3,
+				mask3,
+				mask3);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to write MASK 3 reg %d\n",
+			ret);
+			goto error;
+		}
+	}
+
+error:
+	return ret;
+}
+
+static int da9121_config_irq(struct i2c_client *i2c,
+			struct da9121 *chip)
+{
+	unsigned int p_delay = DA9121_DEFAULT_POLLING_PERIOD_MS;
+	int ret = 0;
+
+	chip->chip_irq = i2c->irq;
+
+	if (chip->chip_irq != 0) {
+		if (!of_property_read_u32(chip->dev->of_node,
+					  "dlg,irq-polling-delay-passive",
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
+		ret = da9121_set_irq_masks(chip, false);
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
@@ -877,6 +1398,12 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		goto error;
 
+	ret = da9121_set_irq_masks(chip, true);
+	if (ret != 0) {
+		dev_err(chip->dev, "Failed to set IRQ masks: %d\n", ret);
+		goto error;
+	}
+
 	if (!chip->pdata)
 		chip->pdata = da9121_parse_regulators_dt(chip);
 
@@ -889,6 +1416,26 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		goto error;
 
+	ret = da9121_config_irq(i2c, chip);
+	if (ret < 0)
+		goto error;
+
+error:
+	return ret;
+}
+
+static int da9121_i2c_remove(struct i2c_client *i2c)
+{
+	struct da9121 *chip = i2c_get_clientdata(i2c);
+	int ret = 0;
+
+	ret = da9121_set_irq_masks(chip, true);
+	if (ret != 0) {
+		dev_err(chip->dev, "Failed to set IRQ masks: %d\n", ret);
+		goto error;
+	}
+
+	cancel_delayed_work(&chip->work);
 error:
 	return ret;
 }
@@ -911,6 +1458,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 		.of_match_table = of_match_ptr(da9121_dt_ids),
 	},
 	.probe = da9121_i2c_probe,
+	.remove = da9121_i2c_remove,
 	.id_table = da9121_i2c_id,
 };
 
-- 
1.9.1

