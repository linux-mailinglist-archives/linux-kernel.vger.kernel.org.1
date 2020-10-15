Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C76D28F45D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgJOOIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:08:02 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:64226 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgJOOH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:07:59 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09FE4E4N002262;
        Thu, 15 Oct 2020 09:07:53 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-00010702.pphosted.com with ESMTP id 343as5w54u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 09:07:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJbbkISqSV0D9u7VmpTqwyDfK5L2ZIUuK2F5KjV0UvVecSKcBhXWKarZhhphcdzjNrwsnsfJKy07C1dyXc6IbAmGUA6VigYe7OMfu6jsBIk+jCEUUf2sCQSUW6GaaIUX782N0YVP707QGJOcVfKcs6nYfE8SE2Qt198C2aAh+ilVzpW6HaGyuUsyb9y6NqDE5MYRYtDacSvIq3mFucXDHShER8vdZ1HVQ7mJMQSPxcQrm7ApQmh4lZrGY5nAH/4MTQvD5XSC+xb+pHVaxLKIKZNxZ1+h8HRbK5dIh1VDbk3T5mPL3QFlGvswGMxaUysrLyxLt7DjZHrAFANyPhmaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWxcVsUwwbTIty2x76nsyVtM8J1bAROQmiCSUuu68D4=;
 b=j6j3sjB2RRdLz9+RIrQRmMjMbIQzW1aI2ydJ9FI1JNFqKwyFCDRj9nyCQ6RpEw3O+fUHACOPLpEWuGfif9sYsi6ZPgXQMQnYGx3niXg5CPAmV2rXurI9EpUYiJ3XEtlnF2kvnASJcR/gyCAcYvdjKcArkV0iYKq25YejDAFrhTluv7yC5Lg1vcf9FM1PaBI5O/XhP/2tmHerDkbjOS9ICMFstPU++akp2n8GU3fG3kGeZofQZjCB1RzqkTyvYU1k+dsutnIL4zgpPpS7uVqQ9Ikb/wXi0fi5yoOoznPNjBx/8YN2EP+MLxHtqafAhvBu2pTlBL4R2ewdyYVcsWzlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWxcVsUwwbTIty2x76nsyVtM8J1bAROQmiCSUuu68D4=;
 b=BMFzsCjGUSYiptVxae927mhSGQqPkRGULvQFC3owuwhd4COWNZzOwV3Zu7bCa16dRG0rJh9JVxiDltEQ21aN6knLIcyy28P1szK4gAt0ykBjg2//FMsUVQrHP61xRljnTHmNJB//oR8PZ7RxUpjdq3r36NKYxRT4jq9Cnbue5N4=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB5421.namprd04.prod.outlook.com
 (2603:10b6:805:f6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Thu, 15 Oct
 2020 14:07:50 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.034; Thu, 15 Oct 2020
 14:07:50 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] extcon: add driver for TI TUSB320
Date:   Thu, 15 Oct 2020 09:07:34 -0500
Message-Id: <20201015140737.1183818-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 14:07:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 678b3840-3108-4e24-7a86-08d87113b3ae
X-MS-TrafficTypeDiagnostic: SN6PR04MB5421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB54212F632B035D707AB32C3487020@SN6PR04MB5421.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yzqi8Uzn+Fjvs+v+kXIfqinDYELWoMKft0ssjaGq82Wwa8Hg+lNx7A7/qXKPEwqWvX28VdrJuLauIhVz5Yfy5+LaWEpQplWhxJ1oq5p48NFfQdKwW+YbGRqD1H1e152qg7L2/nOiCk5lYn93YD5FyLF+KZfEYQizrgiuM8uf5ldeYIUUIDDb6R237RL1KHNt/SO9njst9YMymWihjW+pHLwqKTefFXVDiYfv1a4UW1WhIkBbEhESUowHwsAeg12pQ3783Nt4UiTbOnhMnZ5EVp6ce9pzoveOsct3kG7Eyvhh3Aft2FZ3/QkxHEjSXV9fh7ffCKu95Uz5YXkEGA+SdrvG97jOC9FAIZOnhzTHYmuJM3oBqdati3j9GvQ57Hj2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(366004)(136003)(69590400008)(83380400001)(4326008)(6666004)(478600001)(8936002)(2906002)(8676002)(186003)(16526019)(66946007)(110136005)(316002)(66556008)(86362001)(66476007)(2616005)(5660300002)(6486002)(1076003)(6512007)(6506007)(52116002)(36756003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hEGSHdlkdzU8te/IHG3N3Sk+2XbBRd1N6Qm2IjL3XjejFR5D9ykFDoK43psPqUnHoJ8YXuW8AGYLyYw52/yXPJ2aItApXR3fh1G1LkgrbK0HcgnFspGP/nbA+9y1snf0Lt8lr0U+40ZFrpFHsEqyN/gJ0qg3rGz+Edn7HFY/Oa8KmIUobYHafK9CIRD8AxwmvvpdKTYtorYhcBnxs8lEgGAsoyOiRSehVdZ69LxpvhVrGp5XbpKe66vSthp8+d3L55pWRKKg9d5qoo6Tvc2VrCkp6hSH/5Zz5uZD9n2idHpMZamsE7PGp7Q8jN5xjFet0lyCYaAeF0OQMmA5CuHtbXUs8ouQ/bW09YVejUtw+Ag4tBqvqIPQrdFKn0xF3D7cMNrR3vn53DRDLvLhULPJ0Kn6CLXvSXVDTMO7xooI+KavfFnAaTpAdRK3sWLe2rQDgMn9hJD4enjA6Ud0HvprKfr30X4XnzgHr1gj/Q/1z6l9MVAUwfScp3rAlOVtTXixisup83LmQHxbMzWlGUGQRGzHp9I29v8KDf/kw/fFaKTdiaa0ZIVrXLF7PJjpXZb3hL8ey7BvFzjRPdiwAo7+D43t5gPRg3Syf92NJgyh0QgN00Etk6Uv01DO58WiiDhBhrg1nUsNUJZBN0kvDwVA75GE4cE+X6KAgVmt9VnBZRl0YD+0pINIhpeY3x+DRkW3IiQuNelC7z68FSGHogfTcg==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678b3840-3108-4e24-7a86-08d87113b3ae
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 14:07:50.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKQtQQUkuAHKU1g3xzSw9ynjvGUllKxv9FTk3qlNdmR8KfcZfsvORbrTlSZy50oZ3UEiYcUznW0g6Kd9BK1xWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5421
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_08:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 clxscore=1015
 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an extcon driver for the TI TUSB320 USB Type-C device.
This can be used to detect whether the port is configured as a
downstream or upstream facing port.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
Changes since v1:
- Drop license text that's redundant with SPDX tag
- Cleanup, sort list of includes
- Add additional register defines
- Switch to use regmap API
- Fix Kconfig to depend on I2C, not GPIOLIB
since v2:
- Drop unused irq.h
- Fix spaces in definitions
- Return PTR_ERR(priv->edev) instead of -ENOMEM
- Remove unused i2c_device_id table
- use client->name instead of dev_name() in request_irq to be more
  descriptive

 drivers/extcon/Kconfig               |   8 ++
 drivers/extcon/Makefile              |   1 +
 drivers/extcon/extcon-usbc-tusb320.c | 184 +++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/extcon/extcon-usbc-tusb320.c

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index aac507bff135..af58ebca2bf6 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -186,4 +186,12 @@ config EXTCON_USBC_CROS_EC
 	  Say Y here to enable USB Type C cable detection extcon support when
 	  using Chrome OS EC based USB Type-C ports.
 
+config EXTCON_USBC_TUSB320
+	tristate "TI TUSB320 USB-C extcon support"
+	depends on I2C
+	select REGMAP_I2C
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
index 000000000000..805af73b4152
--- /dev/null
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * drivers/extcon/extcon-tusb320.c - TUSB320 extcon driver
+ *
+ * Copyright (C) 2020 National Instruments Corporation
+ * Author: Michael Auchter <michael.auchter@ni.com>
+ */
+
+#include <linux/extcon-provider.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define TUSB320_REG9				0x9
+#define TUSB320_REG9_ATTACHED_STATE_SHIFT	6
+#define TUSB320_REG9_ATTACHED_STATE_MASK	0x3
+#define TUSB320_REG9_CABLE_DIRECTION		BIT(5)
+#define TUSB320_REG9_INTERRUPT_STATUS		BIT(4)
+#define TUSB320_ATTACHED_STATE_NONE		0x0
+#define TUSB320_ATTACHED_STATE_DFP		0x1
+#define TUSB320_ATTACHED_STATE_UFP		0x2
+#define TUSB320_ATTACHED_STATE_ACC		0x3
+
+struct tusb320_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct extcon_dev *edev;
+};
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
+static int tusb320_check_signature(struct tusb320_priv *priv)
+{
+	static const char sig[] = { '\0', 'T', 'U', 'S', 'B', '3', '2', '0' };
+	unsigned val;
+	int i, ret;
+
+	for (i = 0; i < sizeof(sig); i++) {
+		ret = regmap_read(priv->regmap, sizeof(sig) - 1 - i, &val);
+		if (ret < 0)
+			return ret;
+		if (val != sig[i]) {
+			dev_err(priv->dev, "signature mismatch!\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
+{
+	struct tusb320_priv *priv = dev_id;
+	int state, polarity;
+	unsigned reg;
+
+	if (regmap_read(priv->regmap, TUSB320_REG9, &reg)) {
+		dev_err(priv->dev, "error during i2c read!\n");
+		return IRQ_NONE;
+	}
+
+	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
+		return IRQ_NONE;
+
+	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
+		TUSB320_REG9_ATTACHED_STATE_MASK;
+	polarity = !!(reg & TUSB320_REG9_CABLE_DIRECTION);
+
+	dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
+		tusb_attached_states[state], polarity);
+
+	extcon_set_state(priv->edev, EXTCON_USB,
+			 state == TUSB320_ATTACHED_STATE_UFP);
+	extcon_set_state(priv->edev, EXTCON_USB_HOST,
+			 state == TUSB320_ATTACHED_STATE_DFP);
+	extcon_set_property(priv->edev, EXTCON_USB,
+			    EXTCON_PROP_USB_TYPEC_POLARITY,
+			    (union extcon_property_value)polarity);
+	extcon_set_property(priv->edev, EXTCON_USB_HOST,
+			    EXTCON_PROP_USB_TYPEC_POLARITY,
+			    (union extcon_property_value)polarity);
+	extcon_sync(priv->edev, EXTCON_USB);
+	extcon_sync(priv->edev, EXTCON_USB_HOST);
+
+	regmap_write(priv->regmap, TUSB320_REG9, reg);
+
+	return IRQ_HANDLED;
+}
+
+static const struct regmap_config tusb320_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int tusb320_extcon_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct tusb320_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = &client->dev;
+
+	priv->regmap = devm_regmap_init_i2c(client, &tusb320_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	ret = tusb320_check_signature(priv);
+	if (ret)
+		return ret;
+
+	priv->edev = devm_extcon_dev_allocate(priv->dev, tusb320_extcon_cable);
+	if (IS_ERR(priv->edev)) {
+		dev_err(priv->dev, "failed to allocate extcon device\n");
+		return PTR_ERR(priv->edev);
+	}
+
+	ret = devm_extcon_dev_register(priv->dev, priv->edev);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to register extcon device\n");
+		return ret;
+	}
+
+	extcon_set_property_capability(priv->edev, EXTCON_USB,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+	extcon_set_property_capability(priv->edev, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+
+	/* update initial state */
+	tusb320_irq_handler(client->irq, priv);
+
+	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
+					tusb320_irq_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					client->name, priv);
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

