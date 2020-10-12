Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC1C28BB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgJLO5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:57:38 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:16440 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729667AbgJLO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:57:37 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 10:57:37 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09CEgrdP019827;
        Mon, 12 Oct 2020 09:48:12 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00010702.pphosted.com with ESMTP id 3438yyv1t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 09:48:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQSaZoi4wuNFcrsXf9EFJfIpAarniJo17JYHoe1f3FOdf2nRb/n8tZEluyscVjtT+u9tNqDzOYJ9PlHn4O7tsUMQBiFBPKFvFC46URGh1CMFYKdzDO7hSe20HXLhpAzIm5Rw9u69GtAxE7xc60Lpf0zBA61tleTZgga9SWOln2NNkEeTqGu3Era2jSuf6EZKF7tEl0KtgcxfZkHv+APicHTFGCrXMndGpRpqCwL16dZqTwrgkeJD98y4BdtL9PX1VfCwbzmpPWG/OK7oX5YHN17VYyxJOC8WH6l+eoIME5mcFNNqpSliBCv8joSmaFHPnu+0eykdnaMKudfRQ4OXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGfWjRya9WYLkpO62aD2QGy8AT0qNa8M0bEd3wp6HM4=;
 b=gE/XbRqpf6IVlDt+PrevT+KH+ZOGx29sFgLCXlTAvPuSfN+xpyNYvPxbiNTss9oMeI5o4mR9Ip7o4BtwTarjf1Kt58dpvc2jww5fFd4w7OSmO33UVutveDSyCCOPPWrNRT2nflcp4arkaLzDInzUyGHfwnt5phpPV+ByUUUJLzcXNekHuRcV/7yiNW7GMN0wippFBR8RCzDgp+jQqfC26Agz3htHX+iXyAPqqjde4aYXOwmYXd5+URZtNzKQIfMRVr18ulTcLtUhpMAMLAxtYDJNwOikmqRzDl8xVz5WAJzt4tpdvetyviEMF+//vQvbGfnGek8VtzaMx2mitCo++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGfWjRya9WYLkpO62aD2QGy8AT0qNa8M0bEd3wp6HM4=;
 b=ieDcnYaGmxbvJeLbz2Dcm7WyQOir9YApN9b19zKkfitdoV6BszeWMmhOySeYlTPAszKgtSiK/w9qM2JUuvbRW2qDGvNmT/PlRcadTsklWcSjczbI5po43ODUWL7+NtjRVCIqaNjdD3b0fmkfNCBENLzPiR26N1UT77BIm7GR7LM=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN2PR04MB2207.namprd04.prod.outlook.com
 (2603:10b6:804:10::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 14:48:10 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 14:48:10 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] extcon: add driver for TI TUSB320
Date:   Mon, 12 Oct 2020 09:47:52 -0500
Message-Id: <20201012144754.738830-1-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: DM6PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:5:190::16) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 14:48:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c23117b-51fd-4c97-c196-08d86ebdd667
X-MS-TrafficTypeDiagnostic: SN2PR04MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR04MB2207AA5FE3DFDB4AF7CD403587070@SN2PR04MB2207.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1TxFGfyCRCkY94M6IJircZD+ANC738DiU0cKCJyZV4xbkE8meV/Qdt6cdw8s1zla38aygCl0OUonSFL9GNQ/CPN/cGiqxtVqKFpQSJD/GYVLDiEBnz44pJ0KXzNyVfBf9Se0DC1z/C30aO2Ij8mqIG3HC1ZcROaQZqOjJUpzWRTOLkXAFQBIHMu7y9olNRGwWbY2JART5kH6v3/nLeQ3mqSatOg1JmXNSiJ14jGw9EusFapztJWytT60YUd5r9cRKnwQ7ihYiibCTQD/BOhWiy3+0dPg6c06phST3LV881BTC8BWloTY4PRYbsyTVILHOK84tCQhErxTauVZRPjFmHLnCXnG4+7E/D3syG/8u3OZgrfMuUyjH3bZVWXQDt8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(5660300002)(66946007)(4326008)(86362001)(83380400001)(66556008)(66476007)(478600001)(69590400008)(2906002)(1076003)(2616005)(316002)(186003)(16526019)(8936002)(8676002)(6666004)(44832011)(6486002)(6506007)(110136005)(36756003)(52116002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dnCieqo8QJxLdECkxZK0nQEeeHGCr/mB+WxjrDZd1jM2dOFCkVWvOwwcQsIbkDiNqGXBXcDfWLOYjPAxFnElhX8YYzh609DUy0LkvjIckxCBeAAVd5qoU7RHWREqW9I6UlK7OwekkhTyZ3hOyCHFz5/8lt650u94hqiqBKHcHsPFkdWue026gozqXpithxJmCHDWEF0itwRvH+MWat3EGrJoO7AVEJfBpBNmoVlQ/jwSyFBiO6Wdpx/XVIqMugF05jL7XkOAwjTHJPIpDs6Edv6vEJF8jdGEgHTkC22wPoAuKs+CStcKVoy0VT2ly2CCakQahwfZxSbYduCBuomAaK8deWZQ7xE88MZke48G+/4DBGGic/u/Sq672BTJit+Zu4moZW/LGl4mtTEkbbRR0KUOPjuD3Q4liZPajKoCtf6zopZ4BMwyAz4R/ByNAmmWbh4kE+37UdhUWyLOcCYPMMOIOMOO+Yda/ub6WSdSQJBmszhPbXu8pEPD89I3nTLjZQuCZak4u7N0FWjRTpPqVJLJVacaGPsR8b25xM9586BFkHaJVwulCTs+mmRkA0TEb0nG30VuflCg+m+tSG/OCv75qVdI8NdZ31vpqTLX32NipV4iJ0FwkGGegApujALqb1GXHvbnbenWV5hbQifpJLBw3HVpbWH+N2oGjWrSEqLTj01o1cyho/wbgKjebkXoFTre7wGN2FWV6K+yUT6zgw==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c23117b-51fd-4c97-c196-08d86ebdd667
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 14:48:10.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7r3WnljrivryAfOYBr8rlWrcbUz5VihDi0XNJNkSc3IMeoEpthesWb90P4125rh0+UsVl+oDxpOf0TxnnUlBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_12:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010120119
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

 drivers/extcon/Kconfig               |   8 ++
 drivers/extcon/Makefile              |   1 +
 drivers/extcon/extcon-usbc-tusb320.c | 191 +++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)
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
index 000000000000..93f1843ca89b
--- /dev/null
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -0,0 +1,191 @@
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
+#include <linux/irq.h>
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
+#define TUSB320_ATTACHED_STATE_DFP  		0x1
+#define TUSB320_ATTACHED_STATE_UFP  		0x2
+#define TUSB320_ATTACHED_STATE_ACC  		0x3
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
+		return -ENOMEM;
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
+					dev_name(priv->dev), priv);
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

