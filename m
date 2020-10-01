Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7702A2801DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbgJAO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:58:11 -0400
Received: from mail-eopbgr140093.outbound.protection.outlook.com ([40.107.14.93]:5942
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732346AbgJAO6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrSrq0jBHQsBcnWZCkQUDE/BkZm+8J9JZlDyrMpuITo=;
 b=oAuW4ta4y4SBzGyIszTAkiPd5hG+iMV4oYd3ovdVQrxqWdHPcHyZeWuEW14XOlyp77XDSfc72RS0QhA8sPXRKyKJeTVynMDAiQjb39skLBa9/W5sFTL0CzzclvH9NsjGsAPswCyONDe7T+cpjjY5Ju5Ogf0jJXkCGRLAEbWDCEo=
Received: from AM5PR04CA0035.eurprd04.prod.outlook.com (2603:10a6:206:1::48)
 by DB6PR1001MB1432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 14:57:56 +0000
Received: from AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::60) by AM5PR04CA0035.outlook.office365.com
 (2603:10a6:206:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Thu, 1 Oct 2020 14:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT016.mail.protection.outlook.com (10.152.16.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 14:57:56 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.54) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 1 Oct 2020 14:57:56 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 14769244
X-ExclaimerImprintLatency: 666080
X-ExclaimerImprintAction: 699df22015724b938393615ba1b30463
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C73GAz62vGvBno0vE2LvRSktYZQwBysNgBLjA4OvWJmzotPFCErb52MmOFgHyKD8h+Rx9ZLA2PTv20ScEfwByc2dffbKTl1LeVGP3j9kNskoU9HdaJ5/Wrm7FyM9l3F0WNLBKaK/zWKJ95xGGHgRVhwpHfSUsTuz8upcz39CK090b9LlcdFJlkJsjQicxNmBI8WJmFfHOmBcKtectW2fHZqwoHZqQ8fQ5JEdNEGzxRv/MwR6wa5OWV8JPzkGsVRPOZpNfA+niUfVvz2kXCdoHaQwp+YO7cpazZoYfBTeqfwkji6EfvJLqqJyKBUaRfgkJ9cdLpY0XvMVUXMaKxQ0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZCzGttv3NXhc2gWdM9N0P0SPKv/oQKx1ybTKGqbab0=;
 b=j8J+mFZA3JPK9BZ9AA4BuM0/pyVUwaUbB6zTRIy816LY/VstEUf7ZZdDtLvZ2WkbiokaCgmES3QKpjiR/B62zSy8v6+AeM2hjumK0gxpjxVA/Oq94Hth1/djv8XNVsVk+jnJDc8gRGlmcpmxb/EV4BejrSDgsktO4i89ri0rzfRMOq36PhOifsRl9ymRaeo1fA0ftEMOkDjcgAPrKKysFsLAIsSzxQT9pMjhsEA71wia4mg0mfB86o6htfjB6dD1IB7yhYrO0QEyJCbgHgSJDy0Xz8caWA4k+OSJmfkJMnyNfS49PYNxZ6otRrmF7iWZnbpJLQRk7cMxqLQ9/4WqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZCzGttv3NXhc2gWdM9N0P0SPKv/oQKx1ybTKGqbab0=;
 b=o3XNPWhEZORRVJKqzuxD61N4fYw27Ib+F2WAKoZetkBy8eCGJw2FzEhbuW0VTFaIq+cfEKAPahQjy58Hloa/Sz52l7jg576MH2DINy6WgmszpyT2Cvd9FPHQguuPB5TUKIs99FeReZy+RRmQd9EN/VigDhnBPkvzsSe3pZnftLs=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM0PR10MB2417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 14:57:49 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 14:57:49 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH v4 3/3] hwmon: (lm75) Add regulator support
Date:   Thu,  1 Oct 2020 16:57:38 +0200
Message-ID: <20201001145738.17326-4-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001145738.17326-1-alban.bedel@aerq.com>
References: <20201001145738.17326-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [87.123.201.111]
X-ClientProxiedBy: AM0PR06CA0121.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::26) To AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:161::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.dotsec.gv (87.123.201.111) by AM0PR06CA0121.eurprd06.prod.outlook.com (2603:10a6:208:ab::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Thu, 1 Oct 2020 14:57:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0edca079-2850-4b1f-5466-08d8661a61bc
X-MS-TrafficTypeDiagnostic: AM0PR10MB2417:|DB6PR1001MB1432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR1001MB14322EC3F113498CF63286A296300@DB6PR1001MB1432.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: eB5h7Q3A50T3k3+iowFPaqEFSQ+Vy8k8aOI295jPQx7Q286vf07Qc5JV+vB7mOqqrHSufo/M2QC2X5jvr5E4q2LF15Q0+7pe9toVM3R3FcZ+FbvguxKZ9x71g5XKWXQegem9tpUKgCkEhL52wuyUFVFQrV4wJ8OTzrGUQufprUbRpt0llfFUGdhml+E7nsCerxuIcWgqcOU3Dm0BVGzGZJNuCqhHKhOeVpFbSsRDTFJgJR6Yjxa1ePnr6c23x4qXuIXxx3r3ktISoLgh17sMPdsr7w0P1VnjY3zkuRZyT2qCgCydAsSzh5n/vY+sZ8oLau+I1szZnYPOOfKMvcuSvw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(136003)(346002)(376002)(8936002)(26005)(4326008)(36756003)(5660300002)(54906003)(8676002)(2616005)(86362001)(186003)(478600001)(16526019)(6486002)(52116002)(6506007)(44832011)(66946007)(2906002)(6666004)(6916009)(316002)(956004)(6512007)(1076003)(66556008)(66476007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: K9qQjZmC5VRV0mZmPqD68M2Y5+wGYTUqPXNWOoXWbWOawQu8Dxg9TOzeMrhQYve4wpdSQ2AbJfd8xEubcBEX3XiDiknBH5e/vWvP76AOMuoMGy6zVNVxHnRDhqRC3y4+kuV4kvy/cxXWT3IbeLhxcU6iLGS4+mpJTGABmCYVDB5lSgRe6Fu3gWqyrAeWJfb4s0yRuyMsdC52HodL1Hs8zdOoXoGfs2tHobXVnxh3CgGVzmINJyc/V0ZNB/5MPdoxdsN4u4484gcD2IwKCCD2OgiuYrFQFfO2eJKrWmo+zQtQv10/aMkdd1+wOS1rEE6syX1RQ/T0/bgsX0+H3aaaXERyJRggETbO2nmfCWlnp0AjwmtQKdpV4GO1F7G9Yje9EN7+2Sou7qud18Mar6nLxOGUwfgWt7EpzLnVxu80OfSSDqs/I9W9UVgXOtfkqrxnVltCcgseisrhkyeg+KtfhbEHlw1kRp0sEm0DCNOPBgxVaqk2XF/VTU+TvovjIUP2MqptQXnd5t5ncKYEthKUxYoZgFVh5kY1+r6aihlYKqgREgivI5vIZIf9FFqJ6pH9+7fOe9OlxWUMEpIUoUaH4qCM0kCnPJhYPXwwlDz+y7DS7AYU0rFbzxpkWvzMCcEvJIfIGjREPsbiQ3B8NiGNPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2417
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: fe81bc17-a9e0-442a-d028-08d8661a5d57
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOvHNa8qgy4IsUDHzOQOne8i58EDen8N0+pEJGtSzUuk3lCuBCtUJlaIs3bALVru/hASWYy4x12IyEiCjlUIHAP+Dm8fjsO5XULG3Js6n1cBOiqiq+871n8imoETzl/3Ay05TEVIAQwA7/ihgiX1LwZ/U1TZk6OLrBgpcNAN7KY/jNrug7C8InoGAGenP480OcXVmCT0e8C5Rz1Ccu8JYHLqfUo26xATeniVLgVaaoem7SN2dELrN9aZ1O6BxwKdrDG/trkqTvny3ZUfMTpQE1CeG8YdtA6ZZiD5sq97943D23RmjjoGlx0ikiMulAPNIPoU+DIFS/c3DVuWWNkoJZKuOCmlrq9+T5e7sO/pXpL8kQJfYVVDiF06iFo/VhHj3n92BH2WV3gIq8YObn+s+DlEcxYolM0z7felxqJlsTdMg+NyFBfF+zsqE1hy777G
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(346002)(39840400004)(376002)(396003)(136003)(46966005)(16526019)(316002)(26005)(6486002)(186003)(47076004)(7636003)(478600001)(356005)(33310700002)(70586007)(7596003)(107886003)(44832011)(54906003)(70206006)(2906002)(6916009)(6512007)(6666004)(4326008)(1076003)(956004)(2616005)(6506007)(86362001)(336012)(36756003)(8936002)(5660300002)(8676002)(82310400003);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 14:57:56.0173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edca079-2850-4b1f-5466-08d8661a61bc
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1432
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator support for boards where the sensor first need to be
powered up before it can be used.

Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
---
v2: Rely on dummy regulators instead of explicitly handling missing
    regulator
v3: Use a devm action to handle disabling the regulator
---
 drivers/hwmon/lm75.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ba0be48aeadd..e9c1f55b2706 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/util_macros.h>
+#include <linux/regulator/consumer.h>
 #include "lm75.h"
=20
 /*
@@ -101,6 +102,7 @@ static const unsigned short normal_i2c[] =3D { 0x48, 0x=
49, 0x4a, 0x4b, 0x4c,
 struct lm75_data {
 	struct i2c_client		*client;
 	struct regmap			*regmap;
+	struct regulator		*vs;
 	u8				orig_conf;
 	u8				current_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
@@ -534,6 +536,13 @@ static const struct regmap_config lm75_regmap_config =
=3D {
 	.use_single_write =3D true,
 };
=20
+static void lm75_disable_regulator(void *data)
+{
+	struct lm75_data *lm75 =3D data;
+
+	regulator_disable(lm75->vs);
+}
+
 static void lm75_remove(void *data)
 {
 	struct lm75_data *lm75 =3D data;
@@ -567,6 +576,10 @@ lm75_probe(struct i2c_client *client, const struct i2c=
_device_id *id)
 	data->client =3D client;
 	data->kind =3D kind;
=20
+	data->vs =3D devm_regulator_get(dev, "vs");
+	if (IS_ERR(data->vs))
+		return PTR_ERR(data->vs);
+
 	data->regmap =3D devm_regmap_init_i2c(client, &lm75_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
@@ -581,6 +594,17 @@ lm75_probe(struct i2c_client *client, const struct i2c=
_device_id *id)
 	data->sample_time =3D data->params->default_sample_time;
 	data->resolution =3D data->params->default_resolution;
=20
+	/* Enable the power */
+	err =3D regulator_enable(data->vs);
+	if (err) {
+		dev_err(dev, "failed to enable regulator: %d\n", err);
+		return err;
+	}
+
+	err =3D devm_add_action_or_reset(dev, lm75_disable_regulator, data);
+	if (err)
+		return err;
+
 	/* Cache original configuration */
 	status =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
 	if (status < 0) {
--=20
2.25.1

