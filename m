Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6271A2C8874
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgK3Pno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:43:44 -0500
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:13395
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726483AbgK3Pnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:43:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVL3d7yXe1/r7PXxIDpA6qd3vZ63WmFgKzlJM3HOZXGpUN1U3J9POX57VX8zF0LVq7pLLMNR+lmTIOQn/Qv4Ne5QYuY7rA/gJI5ppxPkKuXGJ+ZERKY0v8GmhNIC+EZn9jRsprhO3h/j3UH9eHCnGJ7a2BOLvO0oL9Zx1pxJ4wv6wnSpFY0eDrpGxVRIW9jHWsXFNs1VuNwPc1Qj8wRrz2k65bj4bej3GvIwAEDon7PfyM5P/o8Qs4hFRpKN9da75sREE4fbsEqTYU9Q6/o8wSlcT6x1Wf8noiCHPWlTH3m4fX+lIS62CjtofQDP+cKx+c8Gyj5ScKIihUrGENxvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUV++1uNwRe8YwFM8iYe07xcJxvt0SFER54DqYkpYRw=;
 b=kYdwfovJfnGSVDex7SW+CtrHthTCDCwFxR5WGjv87qc/RFvMgZNhidBfx0oi26R5RrdQyxOf7Fgs2Ttyf9F5cMzEUuYR4IzuqKlDgS4aQSUjlV7pjPvFvvdzqgoIstfUn88WTTa+o90klaM+YX/C6IB9L8sAJNZ8n6rLlS+YuxdAAabPbUg7UVOWUczsQjKe5akvZab+tQ2mXsVWmpQjLYZ9gQXo9PZ0Y7hv892VT3SM7RRlEZpcaKaH2j31J3sZV7TiOXek/Z3/v+6ub19nTNvOpxbvJlIj17GGHJr6C2IX50KvOwPKxjCnxxydLzwmrKF+ZaKangccajIgBSOK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUV++1uNwRe8YwFM8iYe07xcJxvt0SFER54DqYkpYRw=;
 b=A/HBL+51vlBCWqg+CiRC/sabFnAe6EEZGj872R+82AbTF9y5/dXGVN16B6DvzvGC4xtmM/OSf+Gx5baPF9ggfSav/IYnNcKHFFmnueQehLJC1av4hx2R2czM9AlkpT3UJidQpbdnUl+TgQxp8z8b1Mrhzsd+UT/3E/WS8Pku+IA=
Received: from MR2P264CA0171.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::10) by
 AM6PR10MB3365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ec::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.24; Mon, 30 Nov 2020 15:42:49 +0000
Received: from VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::56) by MR2P264CA0171.outlook.office365.com
 (2603:10a6:501::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 15:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT045.mail.protection.outlook.com (10.152.12.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 30 Nov 2020 15:42:48 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 16:42:45 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 A1E2A3FBE4; Mon, 30 Nov 2020 15:42:45 +0000 (GMT)
Message-ID: <b89db088a0e1f6d2a574b4395d0360ce5caa8fae.1606750000.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606750000.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 15:42:45 +0000
Subject: [PATCH V2 1/9] regulator: da9121: Add header file
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b3b03d7-45dd-458b-ccac-08d895469716
X-MS-TrafficTypeDiagnostic: AM6PR10MB3365:
X-Microsoft-Antispam-PRVS: <AM6PR10MB3365DC91149F4CE39D549ACBCBF50@AM6PR10MB3365.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKXXEQH2KQmUgi0zQ3C+EJYjU6LOAG7HQYJc6kb4+LYR/LCKTMzdRc9F2BhE1Nl4HrbJRWbVtdJuJvhyLzyx14bV3NdyUqqO2aAXt9p7pOL7FO5ksrKpz0LalyWquapKi4yrEosi1yN6jO4DziJs8Yk975USrdh0GfpwPgZCimgPOp42ZpWvTWr5wnSqFlzpMFYbjoWlX+cu+YI6upGjKhsCrIK7thVuHavQJjkflhPx5JhM6pMPgAjrPMGTk/B3NpBXQvLxUhWHm2VwevD08SOGv+6iIveSQi5/3oIzZGpJpBZfhacvEMcpP80Q9ipDtSRsHP+NKNsn7H2NEIDYuonHnbH//Y+1YVyi2JriwcQET5WhC6ZMcLJye1DUlYo+l55QVsj37OsyHKcYpBZk6w==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(70586007)(2616005)(30864003)(86362001)(2906002)(19627235002)(70206006)(5660300002)(478600001)(8676002)(110136005)(42186006)(6266002)(54906003)(26005)(107886003)(426003)(316002)(186003)(8936002)(4326008)(336012)(356005)(47076004)(36756003)(83380400001)(81166007)(82310400003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 15:42:48.5359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b03d7-45dd-458b-ccac-08d895469716
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header file for Dialog Semiconductor DA9121 regulator and related
devices, mostly autogenerated from the chip design databases, and update
driver to replace local defines with those from header.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c |  15 +-
 drivers/regulator/da9121-regulator.h | 291 +++++++++++++++++++++++++++++++++++
 2 files changed, 296 insertions(+), 10 deletions(-)
 create mode 100644 drivers/regulator/da9121-regulator.h

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 66bdfd1..c11fe04 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -9,12 +9,7 @@
 #include <linux/regmap.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-
-#define DA9121_BUCK_BUCK1_0			0x20
-#define DA9121_BUCK_BUCK1_0_CH1_EN		BIT(0)
-
-#define DA9121_BUCK_BUCK1_5			0x25
-#define DA9121_BUCK_BUCK1_5_CH1_A_VOUT		GENMASK(7, 0)
+#include "da9121-regulator.h"
 
 #define DA9121_MIN_MV		300
 #define DA9121_MAX_MV		1900
@@ -47,10 +42,10 @@
 	.min_uV = DA9121_MIN_MV * 1000,
 	.uV_step = DA9121_STEP_MV * 1000,
 	.linear_min_sel = DA9121_MIN_SEL,
-	.vsel_reg = DA9121_BUCK_BUCK1_5,
-	.vsel_mask = DA9121_BUCK_BUCK1_5_CH1_A_VOUT,
-	.enable_reg = DA9121_BUCK_BUCK1_0,
-	.enable_mask = DA9121_BUCK_BUCK1_0_CH1_EN,
+	.vsel_reg = DA9121_REG_BUCK_BUCK1_5,
+	.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	.enable_reg = DA9121_REG_BUCK_BUCK1_0,
+	.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
 	/* Default value of BUCK_BUCK1_0.CH1_SRC_DVC_UP */
 	.ramp_delay = 20000,
 	/* tBUCK_EN */
diff --git a/drivers/regulator/da9121-regulator.h b/drivers/regulator/da9121-regulator.h
new file mode 100644
index 0000000..3c34cb8
--- /dev/null
+++ b/drivers/regulator/da9121-regulator.h
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * DA9121 Single-channel dual-phase 10A buck converter
+ * DA9130 Single-channel dual-phase 10A buck converter (Automotive)
+ * DA9217 Single-channel dual-phase  6A buck converter
+ * DA9122 Dual-channel single-phase  5A buck converter
+ * DA9131 Dual-channel single-phase  5A buck converter (Automotive)
+ * DA9220 Dual-channel single-phase  3A buck converter
+ * DA9132 Dual-channel single-phase  3A buck converter (Automotive)
+ *
+ * Copyright (C) 2020  Dialog Semiconductor
+ *
+ * Authors: Steve Twiss, Dialog Semiconductor
+ *          Adam Ward, Dialog Semiconductor
+ */
+
+#ifndef __DA9121_REGISTERS_H__
+#define __DA9121_REGISTERS_H__
+
+/* Values for: DA9121_REG_BUCK_BUCKx_4 registers, fields CHx_y_MODE
+ *             DA9121_REG_BUCK_BUCKx_7 registers, fields CHx_RIPPLE_CANCEL
+ */
+#include <dt-bindings/regulator/dlg,da9121-regulator.h>
+
+enum da9121_variant {
+	DA9121_TYPE_DA9121_DA9130,
+	DA9121_TYPE_DA9220_DA9132,
+	DA9121_TYPE_DA9122_DA9131,
+	DA9121_TYPE_DA9217
+};
+
+/* Minimum, maximum and default polling millisecond periods are provided
+ * here as an example. It is expected that any final implementation will
+ * include a modification of these settings to match the required
+ * application.
+ */
+#define DA9121_DEFAULT_POLLING_PERIOD_MS	3000
+#define DA9121_MAX_POLLING_PERIOD_MS		10000
+#define DA9121_MIN_POLLING_PERIOD_MS		1000
+
+/* Registers */
+
+#define DA9121_REG_SYS_STATUS_0		0x01
+#define DA9121_REG_SYS_STATUS_1		0x02
+#define DA9121_REG_SYS_STATUS_2		0x03
+#define DA9121_REG_SYS_EVENT_0		0x04
+#define DA9121_REG_SYS_EVENT_1		0x05
+#define DA9121_REG_SYS_EVENT_2		0x06
+#define DA9121_REG_SYS_MASK_0		0x07
+#define DA9121_REG_SYS_MASK_1		0x08
+#define DA9121_REG_SYS_MASK_2		0x09
+#define DA9121_REG_SYS_MASK_3		0x0A
+#define DA9121_REG_SYS_CONFIG_0		0x0B
+#define DA9121_REG_SYS_CONFIG_1		0x0C
+#define DA9121_REG_SYS_CONFIG_2		0x0D
+#define DA9121_REG_SYS_CONFIG_3		0x0E
+#define DA9121_REG_SYS_GPIO0_0		0x10
+#define DA9121_REG_SYS_GPIO0_1		0x11
+#define DA9121_REG_SYS_GPIO1_0		0x12
+#define DA9121_REG_SYS_GPIO1_1		0x13
+#define DA9121_REG_SYS_GPIO2_0		0x14
+#define DA9121_REG_SYS_GPIO2_1		0x15
+#define DA9121_REG_BUCK_BUCK1_0		0x20
+#define DA9121_REG_BUCK_BUCK1_1		0x21
+#define DA9121_REG_BUCK_BUCK1_2		0x22
+#define DA9121_REG_BUCK_BUCK1_3		0x23
+#define DA9121_REG_BUCK_BUCK1_4		0x24
+#define DA9121_REG_BUCK_BUCK1_5		0x25
+#define DA9121_REG_BUCK_BUCK1_6		0x26
+#define DA9121_REG_BUCK_BUCK1_7		0x27
+#define DA9xxx_REG_BUCK_BUCK2_0		0x28
+#define DA9xxx_REG_BUCK_BUCK2_1		0x29
+#define DA9xxx_REG_BUCK_BUCK2_2		0x2A
+#define DA9xxx_REG_BUCK_BUCK2_3		0x2B
+#define DA9xxx_REG_BUCK_BUCK2_4		0x2C
+#define DA9xxx_REG_BUCK_BUCK2_5		0x2D
+#define DA9xxx_REG_BUCK_BUCK2_6		0x2E
+#define DA9xxx_REG_BUCK_BUCK2_7		0x2F
+#define DA9121_REG_OTP_DEVICE_ID	0x48
+#define DA9121_REG_OTP_VARIANT_ID	0x49
+#define DA9121_REG_OTP_CUSTOMER_ID	0x4A
+#define DA9121_REG_OTP_CONFIG_ID	0x4B
+
+/* Register bits */
+
+/* DA9121_REG_SYS_STATUS_0 */
+
+#define DA9xxx_MASK_SYS_STATUS_0_SG			BIT(2)
+#define DA9121_MASK_SYS_STATUS_0_TEMP_CRIT		BIT(1)
+#define DA9121_MASK_SYS_STATUS_0_TEMP_WARN		BIT(0)
+
+/* DA9121_REG_SYS_STATUS_1 */
+
+#define DA9xxx_MASK_SYS_STATUS_1_PG2			BIT(7)
+#define DA9xxx_MASK_SYS_STATUS_1_OV2			BIT(6)
+#define DA9xxx_MASK_SYS_STATUS_1_UV2			BIT(5)
+#define DA9xxx_MASK_SYS_STATUS_1_OC2			BIT(4)
+#define DA9121_MASK_SYS_STATUS_1_PG1			BIT(3)
+#define DA9121_MASK_SYS_STATUS_1_OV1			BIT(2)
+#define DA9121_MASK_SYS_STATUS_1_UV1			BIT(1)
+#define DA9121_MASK_SYS_STATUS_1_OC1			BIT(0)
+
+/* DA9121_REG_SYS_STATUS_2 */
+
+#define DA9121_MASK_SYS_STATUS_2_GPIO2			BIT(2)
+#define DA9121_MASK_SYS_STATUS_2_GPIO1			BIT(1)
+#define DA9121_MASK_SYS_STATUS_2_GPIO0			BIT(0)
+
+/* DA9121_REG_SYS_EVENT_0 */
+
+#define DA9xxx_MASK_SYS_EVENT_0_E_SG			BIT(2)
+#define DA9121_MASK_SYS_EVENT_0_E_TEMP_CRIT		BIT(1)
+#define DA9121_MASK_SYS_EVENT_0_E_TEMP_WARN		BIT(0)
+
+/* DA9121_REG_SYS_EVENT_1 */
+
+#define DA9xxx_MASK_SYS_EVENT_1_E_PG2			BIT(7)
+#define DA9xxx_MASK_SYS_EVENT_1_E_OV2			BIT(6)
+#define DA9xxx_MASK_SYS_EVENT_1_E_UV2			BIT(5)
+#define DA9xxx_MASK_SYS_EVENT_1_E_OC2			BIT(4)
+#define DA9121_MASK_SYS_EVENT_1_E_PG1			BIT(3)
+#define DA9121_MASK_SYS_EVENT_1_E_OV1			BIT(2)
+#define DA9121_MASK_SYS_EVENT_1_E_UV1			BIT(1)
+#define DA9121_MASK_SYS_EVENT_1_E_OC1			BIT(0)
+
+/* DA9121_REG_SYS_EVENT_2 */
+
+#define DA9121_MASK_SYS_EVENT_2_E_GPIO2			BIT(2)
+#define DA9121_MASK_SYS_EVENT_2_E_GPIO1			BIT(1)
+#define DA9121_MASK_SYS_EVENT_2_E_GPIO0			BIT(0)
+
+/* DA9121_REG_SYS_MASK_0 */
+
+#define DA9xxx_MASK_SYS_MASK_0_M_SG			BIT(2)
+#define DA9121_MASK_SYS_MASK_0_M_TEMP_CRIT		BIT(1)
+#define DA9121_MASK_SYS_MASK_0_M_TEMP_WARN		BIT(0)
+
+/* DA9121_REG_SYS_MASK_1 */
+
+#define DA9xxx_MASK_SYS_MASK_1_M_PG2			BIT(7)
+#define DA9xxx_MASK_SYS_MASK_1_M_OV2			BIT(6)
+#define DA9xxx_MASK_SYS_MASK_1_M_UV2			BIT(5)
+#define DA9xxx_MASK_SYS_MASK_1_M_OC2			BIT(4)
+#define DA9121_MASK_SYS_MASK_1_M_PG1			BIT(3)
+#define DA9121_MASK_SYS_MASK_1_M_OV1			BIT(2)
+#define DA9121_MASK_SYS_MASK_1_M_UV1			BIT(1)
+#define DA9121_MASK_SYS_MASK_1_M_OC1			BIT(0)
+
+/* DA9121_REG_SYS_MASK_2 */
+
+#define DA9121_MASK_SYS_MASK_2_M_GPIO2			BIT(2)
+#define DA9121_MASK_SYS_MASK_2_M_GPIO1			BIT(1)
+#define DA9121_MASK_SYS_MASK_2_M_GPIO0			BIT(0)
+
+/* DA9122_REG_SYS_MASK_3 */
+
+#define DA9121_MASK_SYS_MASK_3_M_VR_HOT			BIT(3)
+#define DA9xxx_MASK_SYS_MASK_3_M_SG_STAT		BIT(2)
+#define DA9xxx_MASK_SYS_MASK_3_M_PG2_STAT		BIT(1)
+#define DA9121_MASK_SYS_MASK_3_M_PG1_STAT		BIT(0)
+
+/* DA9121_REG_SYS_CONFIG_0 */
+
+#define DA9121_MASK_SYS_CONFIG_0_CH1_DIS_DLY		0xF0
+#define DA9121_MASK_SYS_CONFIG_0_CH1_EN_DLY		0x0F
+
+/* DA9xxx_REG_SYS_CONFIG_1 */
+
+#define DA9xxx_MASK_SYS_CONFIG_1_CH2_DIS_DLY		0xF0
+#define DA9xxx_MASK_SYS_CONFIG_1_CH2_EN_DLY		0x0F
+
+/* DA9121_REG_SYS_CONFIG_2 */
+
+#define DA9121_MASK_SYS_CONFIG_2_OC_LATCHOFF		0x60
+#define DA9121_MASK_SYS_CONFIG_2_OC_DVC_MASK		BIT(4)
+#define DA9121_MASK_SYS_CONFIG_2_PG_DVC_MASK		0x0C
+
+/* DA9121_REG_SYS_CONFIG_3 */
+
+#define DA9121_MASK_SYS_CONFIG_3_OSC_TUNE		0X70
+#define DA9121_MASK_SYS_CONFIG_3_I2C_TIMEOUT		BIT(1)
+
+/* DA9121_REG_SYS_GPIO0_0 */
+
+#define DA9121_MASK_SYS_GPIO0_0_GPIO0_MODE		0X1E
+#define DA9121_MASK_SYS_GPIO0_0_GPIO0_OBUF		BIT(0)
+
+/* DA9121_REG_SYS_GPIO0_1 */
+
+#define DA9121_MASK_SYS_GPIO0_1_GPIO0_DEB_FALL		BIT(7)
+#define DA9121_MASK_SYS_GPIO0_1_GPIO0_DEB_RISE		BIT(6)
+#define DA9121_MASK_SYS_GPIO0_1_GPIO0_DEB		0x30
+#define DA9121_MASK_SYS_GPIO0_1_GPIO0_PUPD		BIT(3)
+#define DA9121_MASK_SYS_GPIO0_1_GPIO0_POL		BIT(2)
+#define DA9121_MASK_SYS_GPIO0_1_GPIO0_TRIG		0x03
+
+/* DA9121_REG_SYS_GPIO1_0 */
+
+#define DA9121_MASK_SYS_GPIO1_0_GPIO1_MODE		0x1E
+#define DA9121_MASK_SYS_GPIO1_0_GPIO1_OBUF		BIT(0)
+
+/* DA9121_REG_SYS_GPIO1_1 */
+
+#define DA9121_MASK_SYS_GPIO1_1_GPIO1_DEB_FALL		BIT(7)
+#define DA9121_MASK_SYS_GPIO1_1_GPIO1_DEB_RISE		BIT(6)
+#define DA9121_MASK_SYS_GPIO1_1_GPIO1_DEB		0x30
+#define DA9121_MASK_SYS_GPIO1_1_GPIO1_PUPD		BIT(3)
+#define DA9121_MASK_SYS_GPIO1_1_GPIO1_POL		BIT(2)
+#define DA9121_MASK_SYS_GPIO1_1_GPIO1_TRIG		0x03
+
+/* DA9121_REG_SYS_GPIO2_0 */
+
+#define DA9121_MASK_SYS_GPIO2_0_GPIO2_MODE		0x1E
+#define DA9121_MASK_SYS_GPIO2_0_GPIO2_OBUF		BIT(0)
+
+/* DA9121_REG_SYS_GPIO2_1 */
+
+#define DA9121_MASK_SYS_GPIO2_1_GPIO2_DEB_FALL		BIT(7)
+#define DA9121_MASK_SYS_GPIO2_1_GPIO2_DEB_RISE		BIT(6)
+#define DA9121_MASK_SYS_GPIO2_1_GPIO2_DEB		0x30
+#define DA9121_MASK_SYS_GPIO2_1_GPIO2_PUPD		BIT(3)
+#define DA9121_MASK_SYS_GPIO2_1_GPIO2_POL		BIT(2)
+#define DA9121_MASK_SYS_GPIO2_1_GPIO2_TRIG		0x03
+
+/* DA9121_REG_BUCK_BUCK1_0 / DA9xxx_REG_BUCK_BUCK2_0 */
+
+#define DA9121_MASK_BUCK_BUCKx_0_CHx_SR_DVC_DWN		0x70
+#define DA9121_MASK_BUCK_BUCKx_0_CHx_SR_DVC_UP		0x0E
+#define DA9121_MASK_BUCK_BUCKx_0_CHx_EN			BIT(0)
+
+/* DA9121_REG_BUCK_BUCK1_1 / DA9xxx_REG_BUCK_BUCK2_1 */
+
+#define DA9121_MASK_BUCK_BUCKx_1_CHx_SR_SHDN		0x70
+#define DA9121_MASK_BUCK_BUCKx_1_CHx_SR_STARTUP		0x0E
+#define DA9121_MASK_BUCK_BUCKx_1_CHx_PD_DIS		BIT(0)
+
+/* DA9121_REG_BUCK_BUCK1_2 / DA9xxx_REG_BUCK_BUCK2_2 */
+
+#define DA9121_MASK_BUCK_BUCKx_2_CHx_ILIM		0x0F
+
+/* DA9121_REG_BUCK_BUCK1_3 / DA9xxx_REG_BUCK_BUCK2_3 */
+
+#define DA9121_MASK_BUCK_BUCKx_3_CHx_VMAX		0xFF
+
+/* DA9121_REG_BUCK_BUCK1_4 / DA9xxx_REG_BUCK_BUCK2_4 */
+
+#define DA9121_MASK_BUCK_BUCKx_4_CHx_VSEL		BIT(4)
+#define DA9121_MASK_BUCK_BUCKx_4_CHx_B_MODE		0x0C
+#define DA9121_MASK_BUCK_BUCKx_4_CHx_A_MODE		0x03
+
+/* DA9121_REG_BUCK_BUCK1_5 / DA9xxx_REG_BUCK_BUCK2_5 */
+
+#define DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT		0xFF
+
+/* DA9121_REG_BUCK_BUCK1_6 / DA9xxx_REG_BUCK_BUCK2_6 */
+
+#define DA9121_MASK_BUCK_BUCKx_6_CHx_B_VOUT		0xFF
+
+/* DA9121_REG_BUCK_BUCK1_7 / DA9xxx_REG_BUCK_BUCK2_7 */
+
+#define DA9xxx_MASK_BUCK_BUCKx_7_CHx_RIPPLE_CANCEL	0x03
+
+
+/* DA9121_REG_OTP_DEVICE_ID */
+
+#define DA9121_MASK_OTP_DEVICE_ID_DEV_ID		0xFF
+
+#define DA9121_DEVICE_ID	0x05
+
+/* DA9121_REG_OTP_VARIANT_ID */
+
+#define DA9121_SHIFT_OTP_VARIANT_ID_MRC			4
+#define DA9121_MASK_OTP_VARIANT_ID_MRC			0xF0
+#define DA9121_SHIFT_OTP_VARIANT_ID_VRC			0
+#define DA9121_MASK_OTP_VARIANT_ID_VRC			0x0F
+
+#define DA9121_VARIANT_MRC_BASE	0x2
+#define DA9121_VARIANT_VRC	0x1
+#define DA9220_VARIANT_VRC	0x0
+#define DA9122_VARIANT_VRC	0x2
+#define DA9217_VARIANT_VRC	0x7
+
+/* DA9121_REG_OTP_CUSTOMER_ID */
+
+#define DA9121_MASK_OTP_CUSTOMER_ID_CUST_ID		0xFF
+
+/* DA9121_REG_OTP_CONFIG_ID */
+
+#define DA9121_MASK_OTP_CONFIG_ID_CONFIG_REV		0xFF
+
+#endif /* __DA9121_REGISTERS_H__ */
-- 
1.9.1

