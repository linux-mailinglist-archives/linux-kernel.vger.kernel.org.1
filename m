Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB226D8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgIQKUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:20:10 -0400
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:42148
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbgIQKTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFj9h7r7ozNGnPt47YpvBRdgckEyygFIeRjKIFnQ5j0=;
 b=c34WJ/8bAlWEbpvpMtBtT2ddQ6dFH3/msMRFoU1aalZjMc7snV9j3by8C5+mfjouUwZ05VBnM4s/gLL+Q1ZPvJzIgfDAA/MmFIdRxMCCIy5VkJ1dPEYnTaoZ4YDAdkuvWUpRdYHeZdgF0NVD1a2Ym2SRhPM8VODsNZG9E+5y/24=
Received: from MR2P264CA0136.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:30::28)
 by AM0PR10MB3346.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Thu, 17 Sep
 2020 10:19:00 +0000
Received: from VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:30:cafe::a) by MR2P264CA0136.outlook.office365.com
 (2603:10a6:500:30::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Thu, 17 Sep 2020 10:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 VE1EUR03FT034.mail.protection.outlook.com (10.152.18.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3391.15 via Frontend Transport; Thu, 17 Sep 2020 10:18:59 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.53) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 17 Sep 2020 10:19:00 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 16504004
X-ExclaimerImprintLatency: 1406658
X-ExclaimerImprintAction: 7d0dfec0ed3a4f1191c140e798e7ae15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPeSjQkSD6NcmKU3zC7f4C8LwlDebDbE1BcZ+g9D4qBhlMZTPpkfoUNvslivjwsVmyfn2TcqJj+OWtBTRMtTv7i1u4Ab84C4D9SA9rD+GB/k2VbzJ2S8cqW34NsnoKAqs8tHIVyeA5jf/OUlF86ZYt3Wdi08SC8UmfaeJIouE/vwlltFVGRUy1cKhF3oZZAoAvmEahczrMUhAb4jDF+rpx94r4qh/qR9AZrpTQveBK6Eq2CFCsbfIQK6Byx8I+jDgGIyTq+BmKD34N7xhz0jgO+Pe+rw5NkY/jicaU/lRFFGoeNXW653ubjnAo+vg/cAFJ+7ZVBmVNFFAuXsYxb4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF9I6T9rtUQ1XrHNHrKN5feHSvZits1kim3qz0K1dQQ=;
 b=f8J+hftdgpny91myVhftgtFYYvGHXFmH1YeAbsTY5DifxpfG43e+4vbFQqyPVWoWA2WVVy3CcFOOstKi52iuBnGK43AeIs5ZdmqN5mLvMOgA0/c/SZ1IMQq5EDifOvx7wqgro9/+YiFayrFKqVDk2mQV6449ggA7t7tdCLjJAaKBxcylgfG1EFowU5jsDBksYurLRI7Mc/DdzGBwMuyVE6mXO/4bv/W30Ay5JwXyzk4+CmwIKcA9JhJWieCsit0eaj0RUped/1ezk629CnT6b4hK+EEcEOwp9pqGj/t8+cTnjDkYbIA6cF1bCZTZHO8xh7p9XXwfNKnpAVzRQdnMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF9I6T9rtUQ1XrHNHrKN5feHSvZits1kim3qz0K1dQQ=;
 b=CHjl+nl/etVauA0vSPgRgmZvwlN8JMMrtC126uPw3NfOQxVvMvEkFE8qIsLwjJqGKvuhzEie2E/QIPjhvTgJFYPnmPMlJ13ne2YylV6pGwDTGjEK4mgh3pgjWBzItlFnigZVWVeT8nkKdUxgNH2beieGh845/9E+UpTdOl1/ctc=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM8PR10MB3987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 17 Sep
 2020 10:18:50 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 10:18:50 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH 3/3] hwmon: (lm75) Add regulator support
Date:   Thu, 17 Sep 2020 12:18:19 +0200
Message-ID: <20200917101819.32045-4-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917101819.32045-1-alban.bedel@aerq.com>
References: <20200917101819.32045-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0017.eurprd07.prod.outlook.com
 (2603:10a6:203:51::27) To AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:161::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.dotsec.gv (87.123.201.53) by AM5PR0701CA0017.eurprd07.prod.outlook.com (2603:10a6:203:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend Transport; Thu, 17 Sep 2020 10:18:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [87.123.201.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9ab855b-09dd-4148-bd29-08d85af31835
X-MS-TrafficTypeDiagnostic: AM8PR10MB3987:|AM0PR10MB3346:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB33469CA32755D307FAC10A4B963E0@AM0PR10MB3346.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aLO+ZcDaScPtlXbixUF5a21T1M4nMX7etnFXd8p1+McSCFexkqdD0J6vuYMUHnpg4ZsGhgpDkzQr9KEIyV/336M0K9H9SZECgUvNhz9j/IGJavl2JRbmLu92eFb4h7lrFR22QUAatk2mezVWOaRZmnUUagVkENS4e1+snekol4TBp8x1MckcHzwcyLts8Kad3g60f+wQvMHG5xOgd9VTrTgKlp17UPit70XXOGl5LvWxuLy4CNN2du3GyY9cRvhERoUUfropvQHmyUyFumoJKeXjTrfJjYqm6dK2SB4K4wJZBZUfMM6eZptDJP+UHRtsXzGZP9wU74RXB+VoWERMkg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39840400004)(1076003)(83380400001)(36756003)(66946007)(66556008)(66476007)(44832011)(316002)(6506007)(8676002)(107886003)(2616005)(956004)(4326008)(52116002)(6666004)(16526019)(26005)(5660300002)(186003)(54906003)(86362001)(2906002)(478600001)(6486002)(6512007)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VuQEtTysjpdXKJax03KW6dlE+N+R2qCJ6pMr7dSBpLdl7NWsMYrI0EJrqmz6veYRO4oZ52u+YJxPua278UWjpWHiVBOcnZ1fmRC1SbMVLii3VRW+EJzKPhPdz6SX8HqfakTZq/lHXAY4QYwLfR+08HfGJUVeMmfhOEQfDBE/EBhGqM7aLjHb01M582TeDS4KdnSqoVTIM8wRGSv9XsERZ7fM0NxT+NZOckPy3IQQpaz80Wn4y6PZRUxRxHlNzzTcOwCn2vN4II8C/TLD3n/fbmvyIKoq2CwK5UYdddHSUnRLSO3zW99H8dXaK2DIDXqzil4GkEBU0qHyBYFNrwKppMNkBOvdKsAXM9hr+jhYRnkgVTixskZsymZJOd8HvFA324YdBQMHDFsDDziy4vbu8g47JCw2dwX13tBD5Ga/AtDZKqE4bnTDNR4g3Cy8KuCZFUrCf3yxfKRJYEPo1clVNdvmkYLzJ+NKrqg11GU/t9KLOlAei5HINGkxUYj9zN+GgV7prOAxKBpHkArdO+Rhzge0sPnFYIRUsNP2kG41b6aZkcdlUTxkXLQ3uZiGG2WxjaSzOBKK1RZZx6RTyMV3UfxHMST8JiRRaa6xcCIGPGgaik7r4vvhyHc4tLO3IFA/8GZvwkBWfRnETI7TnNif1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3987
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3b4c6634-b1c8-4b71-659b-08d85af3122d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZR77K4nmjQWj1pvnjk++R285yBS/ozT21rz0ajyVzMK4HkVTo7MEybBnlK3DO2fT5JJhZWHfh3yv1iw7FxyZWwtOsSJ7V6XOIRDGgiYE2+q76bFkUZ4danN1G/zwaUGOIDHa6HLG6DAjraGiReCEpe1VkqifG5verYLXp77JsYpUQBBOgSigTqbBaOEw9Q5IvAICU+ylTmvjHi5jtRkzsQdTGx1pns5OldrFxFznWiMjqXh/9CECzYK42JzN5Sz0vt7WC55LcALg9gv4A0eGCe49VDXvkkLLQVIW2Tkd5EfYqhaWTcqNLr77fXqiqZSWeXrBKEmB1TgjFiPE+nBqJYlr58LWaiTKmRETRAl3RCRrkRibN5L/g8UhjQRFW3FWP19/izljDoo7oJd/6QMozZ815kKqjLU8mfCI5jkUwieEKqUW3fipHcGu8lX9fcg
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39840400004)(46966005)(6666004)(107886003)(6486002)(86362001)(6916009)(1076003)(5660300002)(70206006)(6512007)(70586007)(82310400003)(6506007)(316002)(2906002)(8676002)(8936002)(36756003)(2616005)(83380400001)(7636003)(7596003)(54906003)(478600001)(26005)(47076004)(956004)(356005)(336012)(186003)(44832011)(33310700002)(4326008)(16526019);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 10:18:59.1978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ab855b-09dd-4148-bd29-08d85af31835
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3346
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator support for boards where the sensor first need to be
powered up before it can be used.

Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
---
 drivers/hwmon/lm75.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ba0be48aeadd..b673f8d2ef20 100644
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
@@ -540,6 +542,8 @@ static void lm75_remove(void *data)
 	struct i2c_client *client =3D lm75->client;
=20
 	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
+	if (lm75->vs)
+		regulator_disable(lm75->vs);
 }
=20
 static int
@@ -567,6 +571,14 @@ lm75_probe(struct i2c_client *client, const struct i2c=
_device_id *id)
 	data->client =3D client;
 	data->kind =3D kind;
=20
+	data->vs =3D devm_regulator_get_optional(dev, "vs");
+	if (IS_ERR(data->vs)) {
+		if (PTR_ERR(data->vs) =3D=3D -ENODEV)
+			data->vs =3D NULL;
+		else
+			return PTR_ERR(data->vs);
+	}
+
 	data->regmap =3D devm_regmap_init_i2c(client, &lm75_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
@@ -581,11 +593,21 @@ lm75_probe(struct i2c_client *client, const struct i2=
c_device_id *id)
 	data->sample_time =3D data->params->default_sample_time;
 	data->resolution =3D data->params->default_resolution;
=20
+	/* Enable the power */
+	if (data->vs) {
+		err =3D regulator_enable(data->vs);
+		if (err) {
+			dev_err(dev, "failed to enable regulator: %d\n", err);
+			return err;
+		}
+	}
+
 	/* Cache original configuration */
 	status =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
 	if (status < 0) {
 		dev_dbg(dev, "Can't read config? %d\n", status);
-		return status;
+		err =3D status;
+		goto disable_regulator;
 	}
 	data->orig_conf =3D status;
 	data->current_conf =3D status;
@@ -593,7 +615,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_=
device_id *id)
 	err =3D lm75_write_config(data, data->params->set_mask,
 				data->params->clr_mask);
 	if (err)
-		return err;
+		goto disable_regulator;
=20
 	err =3D devm_add_action_or_reset(dev, lm75_remove, data);
 	if (err)
@@ -608,6 +630,11 @@ lm75_probe(struct i2c_client *client, const struct i2c=
_device_id *id)
 	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
=20
 	return 0;
+
+disable_regulator:
+	if (data->vs)
+		regulator_disable(data->vs);
+	return err;
 }
=20
 static const struct i2c_device_id lm75_ids[] =3D {
--=20
2.25.1

