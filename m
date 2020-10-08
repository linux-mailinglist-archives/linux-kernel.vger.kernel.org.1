Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1E4287EBE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 00:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgJHWjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 18:39:51 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:31810 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728348AbgJHWjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 18:39:51 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 098MXBRH021616;
        Thu, 8 Oct 2020 17:39:45 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-00010702.pphosted.com with ESMTP id 3429jg89f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 17:39:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIba1hpohbcqmnbAMzy1SSt3Djb3QGxrkTsjdNY06mTPtYMLXPBys+aAyGMI+ZMtHsNNQh8wLfeKUFiU/0g84lymtZ9AUN8UauphuncE8W3/3/iOmtP/Mp1nASaoADgVKSMIw3Qem6Ghe5LgkFih+N4WiShBKq03BUKUftGIbYMiEXsXpv53nkVgi3XhNul7D63XlekZOn2UqMGJaGHSl8VwwX2qZz2Y/nZUXQDnqxERWxzQgmgyyQS5eyO5Zzikf1tsqh/VgOcuA7FIFsBNeuDcFtHDfpgsnX5wxlU7/OZiwDFlmEvNS9cAVCz6UZO8yYozxp3fpUk9egrPi7OpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t51MzIHh4fYbJ71EeUb5TJrKR2roW1ZXmleeRYsx8uI=;
 b=QgQHzDr+kNIaH40UK64TLmZyxavukQXVmekZ33WHjwa9GerzAlur6EQGn1beA3oOeT+dQEDI3+ZN4SXbA036sZ7kqHnygfiogDpLFd6BQXplHEdhbmSf+Ks47L5/PRkqfujATn+7bCAWKVo3oGgeAV4glpi89/VDLWtjAtP8V4DabxwRTculbX3m2lWfJ11tfGLVgXstU7I2otglLv0BmfjR+VqCx0YG0v1z0mT5yb1r6EMk7W4/+LCdQenmbDuVZOcRa2btkObQOdonuQjRyQCXx6YG8x7jkVrT5bZSjCmn2p16T92o2aUB/lk4B0JN37k5UjF09A9tQd6cznw2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t51MzIHh4fYbJ71EeUb5TJrKR2roW1ZXmleeRYsx8uI=;
 b=Wht7NMfquaMm/Tj0A26BOYXJuY0wXXrzdj4xKMsHAD5fCCtdbuJKqijANZFTnbTlGmX7Ce08R1WtaNKaHgmoLNpjr1gskpSWMcawgb06d11VunxsZhU7gIQ2e+VV3xyWiTZiq1pWJbGsffdvgIZOEBgCaK+wqjt6tdV4JBfKE2I=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4447.namprd04.prod.outlook.com
 (2603:10b6:805:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 8 Oct
 2020 22:39:42 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 22:39:42 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] extcon: add driver for TI TUSB320
Date:   Thu,  8 Oct 2020 17:39:27 -0500
Message-Id: <20201008223929.399791-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: SN4PR0501CA0056.namprd05.prod.outlook.com
 (2603:10b6:803:41::33) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by SN4PR0501CA0056.namprd05.prod.outlook.com (2603:10b6:803:41::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Thu, 8 Oct 2020 22:39:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ad09a44-6878-439f-b427-08d86bdb0c58
X-MS-TrafficTypeDiagnostic: SN6PR04MB4447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB4447D562F725BBA3D01A14AF870B0@SN6PR04MB4447.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwycKVMGA0S4MDJA42dx9rfHNc7/LUqiy1eV6BKuOTKAD+Fc2QqXpxeIrqbDBeUwPtBSqCaiNK6jOjBj9XqdKoE7J02NP4iINxCuQuhnrl4kZT8GMsN0/VfRCfpCggFRWHp04c5jce8Wc+wkCCjo7M/JskcFRbQj9PX9cajDYiIJSPsTk6ZdnxqPrL1NgkgQxrFWyl5DrYjQu5dhLbTxYq7GgZCmDGq2jSEuZgzadTGaO3HYkwDH4wcWJRlMJVsCsXHz2txYY0kcUNXxA15RjHwSCUP11tK29gtQnUneV8O+YsIJe8ByCx4QtN9MJFSznfRrdn1Y2hgYAHIfK5QGbEFLeGqVthcMd/esY/T7xRoLOTqLLEFsA03HePzB6eRg7Wbo00x8XN2XMJO1Ic1kxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(396003)(366004)(316002)(4326008)(2616005)(186003)(52116002)(5660300002)(8936002)(16526019)(8676002)(36756003)(66946007)(6512007)(478600001)(110136005)(6506007)(44832011)(66556008)(6666004)(1076003)(66476007)(69590400008)(2906002)(6486002)(83380400001)(86362001)(2004002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8PrMdQ4T57VHE339OHNp8aJlUPkto5Fsli39dDpgraoWcXlSThr6qDZxfwu2QUCwqCWRIxSdglTJj7z6xkFHuc1bqci6GaUzFX5sUA8RdMw1YgKSfSQPkGieHVhRsuNSGGxPxP1HcDfzJdjWNyTfJhF82lEdsRh79+Y4C/CGDFuouF6BWYKd5zddFHarv7lsgW7ao1CEXEN3WgoWJ4Aci7qmJEva5lF5gmD5nbjoVGu21GIZ1bY6qqVR9bZ62Xs3BcxynTkbdApkkayd+QsebHtYxEYl5tpGjZxzuREQe6W9/soqTzIl/ZtrJ9bcKpZJqKgyVrOsqrVJS7vThksvz2fo3TCVSLz7SIiWm6eyvf8JtLSRBlonJUvS32vq25EcfdkUPmGXauJZws83S3Bhg27hXUB7i5HDxa3OkNyp1lJ4c9uKOuXoqEH/zo/9QxDAHqufWcYoifXGaauiPvZXYbFH+O3CpSUzfEuo/MnQwfGrV79IDWUIDGeQ2ysxi/fdWI92gKhdJYNH72sappYtPZ+TNsGjNYErg6diP1+zIW04Sc+Q+3f0lrRZmBjc5uSVEkzX7Or998ZcS7oSDimcX1gPrJ/5o/nHXz86c5c3BzWqhKzbjTJHyEi8m3Gnn0y2pd8tLqqAsd8JBAQRHZIOc6smX+FzKOPmkG6TUSItO2uIfNuzh5T0vrOVzXxVA7MkwCGv7aQ2S0eb+pikmYyatw==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad09a44-6878-439f-b427-08d86bdb0c58
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 22:39:42.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH/aZTuJL+dKQzAIVVm9+Rz+PRElHV3ds4K64uA0Wjk7w19aKRiMG81TX4+j2KxPHCWWqHCvAHazkZBcHXirYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4447
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_15:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010080158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an extcon driver for the TI TUSB320 USB Type-C device.
This can be used to detect whether the port is configured as a
downstream or upstream facing port.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/extcon/Kconfig               |   7 ++
 drivers/extcon/Makefile              |   1 +
 drivers/extcon/extcon-usbc-tusb320.c | 180 +++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 drivers/extcon/extcon-usbc-tusb320.c

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index aac507bff135..241acaf8b882 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -186,4 +186,11 @@ config EXTCON_USBC_CROS_EC
 	  Say Y here to enable USB Type C cable detection extcon support when
 	  using Chrome OS EC based USB Type-C ports.
 
+config EXTCON_USBC_TUSB320
+	tristate "TI TUSB320 USB-C extcon support"
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Say Y here to enable support for USB Type C cable detection extcon
+	  support using a TUSB320.
+
 endif
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 52096fd8a216..fe10a1b7d18b 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
 obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
 obj-$(CONFIG_EXTCON_USB_GPIO)	+= extcon-usb-gpio.o
 obj-$(CONFIG_EXTCON_USBC_CROS_EC) += extcon-usbc-cros-ec.o
+obj-$(CONFIG_EXTCON_USBC_TUSB320) += extcon-usbc-tusb320.o
diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
new file mode 100644
index 000000000000..217d6f416ff6
--- /dev/null
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * drivers/extcon/extcon-tusb320.c - TUSB320 extcon driver
+ *
+ * Copyright (C) 2020 National Instruments Corporation
+ * Author: Michael Auchter <michael.auchter@ni.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/extcon-provider.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#define TUSB320_REG_9 0x9
+#define TUSB320_REG_9_INTERRUPT_STATUS BIT(4)
+#define TUSB320_REG_9_GET_ATTACHED_STATE(reg) (((reg) >> 6) & 0x3)
+#define TUSB320_REG_9_GET_CABLE_DIR(reg) (((reg) >> 5) & 1)
+#define TUSB320_ATTACHED_STATE_NONE 0x0
+#define TUSB320_ATTACHED_STATE_DFP  0x1
+#define TUSB320_ATTACHED_STATE_UFP  0x2
+#define TUSB320_ATTACHED_STATE_ACC  0x3
+
+static const char * const tusb_attached_states[] = {
+	[TUSB320_ATTACHED_STATE_NONE] = "not attached",
+	[TUSB320_ATTACHED_STATE_DFP]  = "downstream facing port",
+	[TUSB320_ATTACHED_STATE_UFP]  = "upstream facing port",
+	[TUSB320_ATTACHED_STATE_ACC]  = "accessory",
+};
+
+static const unsigned int tusb320_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_NONE,
+};
+
+static int tusb320_check_signature(struct i2c_client *client)
+{
+	static const char sig[] = { '\0', 'T', 'U', 'S', 'B', '3', '2', '0' };
+	int i, ret;
+
+	for (i = 0; i < sizeof(sig); i++) {
+		ret = i2c_smbus_read_byte_data(client, sizeof(sig) - 1 - i);
+		if (ret < 0)
+			return ret;
+		if (ret != sig[i]) {
+			dev_err(&client->dev, "signature mismatch!\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
+{
+	struct i2c_client *client = dev_id;
+	struct extcon_dev *edev = i2c_get_clientdata(client);
+	int reg, state, polarity;
+
+	reg = i2c_smbus_read_byte_data(client, TUSB320_REG_9);
+	if (reg < 0) {
+		dev_err(&client->dev, "error during i2c read: %d\n", reg);
+		return IRQ_NONE;
+	}
+
+	if (!(reg & TUSB320_REG_9_INTERRUPT_STATUS))
+		return IRQ_NONE;
+
+	state = TUSB320_REG_9_GET_ATTACHED_STATE(reg);
+	polarity = TUSB320_REG_9_GET_CABLE_DIR(reg);
+
+	dev_dbg(&client->dev, "attached state: %s, polarity: %d\n",
+		tusb_attached_states[state], polarity);
+
+	extcon_set_state(edev, EXTCON_USB,
+			 state == TUSB320_ATTACHED_STATE_UFP);
+	extcon_set_state(edev, EXTCON_USB_HOST,
+			 state == TUSB320_ATTACHED_STATE_DFP);
+	extcon_set_property(edev, EXTCON_USB,
+			    EXTCON_PROP_USB_TYPEC_POLARITY,
+			    (union extcon_property_value)polarity);
+	extcon_set_property(edev, EXTCON_USB_HOST,
+			    EXTCON_PROP_USB_TYPEC_POLARITY,
+			    (union extcon_property_value)polarity);
+	extcon_sync(edev, EXTCON_USB);
+	extcon_sync(edev, EXTCON_USB_HOST);
+
+	i2c_smbus_write_byte_data(client, TUSB320_REG_9, reg);
+
+	return IRQ_HANDLED;
+}
+
+static int tusb320_extcon_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct extcon_dev *edev;
+	int ret;
+
+	ret = tusb320_check_signature(client);
+	if (ret)
+		return ret;
+
+	edev = devm_extcon_dev_allocate(&client->dev, tusb320_extcon_cable);
+	if (IS_ERR(edev)) {
+		dev_err(&client->dev, "failed to allocate extcon device\n");
+		return -ENOMEM;
+	}
+	i2c_set_clientdata(client, edev);
+
+	ret = devm_extcon_dev_register(&client->dev, edev);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to register extcon device\n");
+		return ret;
+	}
+
+	extcon_set_property_capability(edev, EXTCON_USB,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+	extcon_set_property_capability(edev, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+
+	/* update initial state */
+	tusb320_irq_handler(client->irq, client);
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, tusb320_irq_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					dev_name(&client->dev), client);
+
+	return ret;
+}
+
+static const struct of_device_id tusb320_extcon_dt_match[] = {
+	{ .compatible = "ti,tusb320", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
+
+static const struct i2c_device_id tusb320_i2c_id[] = {
+	{ "tusb320", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tusb320_i2c_id);
+
+static struct i2c_driver tusb320_extcon_driver = {
+	.probe		= tusb320_extcon_probe,
+	.driver		= {
+		.name	= "extcon-tusb320",
+		.of_match_table = tusb320_extcon_dt_match,
+	},
+};
+
+static int __init tusb320_init(void)
+{
+	return i2c_add_driver(&tusb320_extcon_driver);
+}
+subsys_initcall(tusb320_init);
+
+static void __exit tusb320_exit(void)
+{
+	i2c_del_driver(&tusb320_extcon_driver);
+}
+module_exit(tusb320_exit);
+
+MODULE_AUTHOR("Michael Auchter <michael.auchter@ni.com>");
+MODULE_DESCRIPTION("TI TUSB320 extcon driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.4

