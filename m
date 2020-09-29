Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CABA27D140
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgI2Oee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:34:34 -0400
Received: from mail-eopbgr50092.outbound.protection.outlook.com ([40.107.5.92]:18915
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730216AbgI2Oee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrSrq0jBHQsBcnWZCkQUDE/BkZm+8J9JZlDyrMpuITo=;
 b=cKLYlKY4uixuJNWEdXemYHWZwYTfhw7bt5dpkfb0homlX+oSXpIby3Z0AG+SGVZ9vck2AkphUhFFGlyrTi8p1z9QwWDKM1Y8MA7ReIYZ3p1RmJIyc7hpaiXWnGFHbWEzA8S3mPltR6QUeG2JdJbQ48B8i648b3MY/GrYUDytwqA=
Received: from DB6PR0301CA0014.eurprd03.prod.outlook.com (2603:10a6:4:3e::24)
 by VI1PR10MB1967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:32::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 14:34:25 +0000
Received: from DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::bf) by DB6PR0301CA0014.outlook.office365.com
 (2603:10a6:4:3e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Tue, 29 Sep 2020 14:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 DB5EUR03FT031.mail.protection.outlook.com (10.152.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 14:34:19 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.54) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Tue, 29 Sep 2020 14:34:25 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 61502230
X-ExclaimerImprintLatency: 714627
X-ExclaimerImprintAction: d3ffd55065b24ad08e04a7174299f924
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dwf7uaI0bEVI0gNSQvJx8QD5X5oljTiipvnrUKgcFCHoD5tlfZdXR29RgokpozBixi8A59wLtYAaAG0848LpeQMLsvc+2nAjBj3yLcRbu4f0hhxlaGSSTeYJWz4AqpzmqRwGy9JZLWMtz9ygVOrmqmljpCWD9A619dy5s2OVBOQCYgB9J2ttc9EhOhU4ZCkCVa5qceqo5MY3x9txB+R0nrfx5im019y2LCxc+BUn5DoMtAPZaRJZOAobBU/9f/YjKdCbawZZq2RDM+rXQGLxEUzWnuOMJt1Pz3M6lZNP8chCeLv/owNhp6rzYwZFPD8eevjXFFeLgl6clBhgc157vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZCzGttv3NXhc2gWdM9N0P0SPKv/oQKx1ybTKGqbab0=;
 b=VOQFf9/MPkEEnQ+7gW+/y3F/EaTO0c4CrLlkz2CpaXhEJUr/uDbFUharcW7GMjDGLyimjrpXxt4p3T0vtJDPZHbtxRhujXu3/gaFF7BSOW8vQOXmAixCq66mS4ckfIJ1TU5JTcxE5F0s84pa28b1+sM/IwpaSc+HghYMoOTshOG8WsRf4pqRW56JMSnYJE/ojcahsXTzpRPpgRE0uaPHkZumOkPIUakJN8bnLexjMwvC6wJs9JkB+wwhzX/3rr0T1MbaznJ3LnovX83W0JOB6Z5IvyUVC1Kfb4cZ7pp4zLOzJYXYOyFy4CoZc7p43xqlo4fqUVzka6JPGw4fIohu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZCzGttv3NXhc2gWdM9N0P0SPKv/oQKx1ybTKGqbab0=;
 b=gI5TwmtW1tLlKeZgr81YgwhFE83VocpIGmDnD/pbVN5Ih8CJcA0C1V9J94/fyg85+5tNlTnDf/UMUDQuqbIIbRvU5i08UGxOoITv+3H6uRqspBAT9piQtMTGbXUmBHNAmsSBnpTFRZMLJTAmyAhNoWvK3OJwxvC97GYDF+ivBts=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e4::19)
 by DBAPR10MB4091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 14:34:11 +0000
Received: from DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14f7:2e71:2913:d431]) by DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14f7:2e71:2913:d431%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 14:34:11 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH v3 3/3] hwmon: (lm75) Add regulator support
Date:   Tue, 29 Sep 2020 16:33:45 +0200
Message-ID: <20200929143345.73170-4-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929143345.73170-1-alban.bedel@aerq.com>
References: <20200929143345.73170-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [88.130.152.63]
X-ClientProxiedBy: AM0PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:208:1::42) To DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:e4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.dotsec.gv (88.130.152.63) by AM0PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:208:1::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 14:34:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985b0929-3730-4c62-2d92-08d86484c3a1
X-MS-TrafficTypeDiagnostic: DBAPR10MB4091:|VI1PR10MB1967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB1967ECCEA9597592F6A9306E96320@VI1PR10MB1967.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mMcRoSiGWcDIwReyYiULzrNsbRDPiL4OdTSGb7lpVnkeHkpxYeLv37Bj6H4QEeVH/eMejtn1Vkqplvi5B2pktH1mKhFUXy2x0POVgoqFTcnaDNXW+THEpHNNxRPFPjERPpTpbAaqgh52oqZV6fy/i5shMmH4nA1ypkrGApx/VIS8y6fEoMbmgvc7GzF5W4gDYV9FChxsGpS0tkaIpO1D18wH9tK8Qzc4SpbdD8beE78S5x7KuLD2UZ+tp29LMS/8N4Nsfhjtfdov3cW/rZvlndfutxHBl8xo+ye7RXcONTbEhdX1D1V6J4h2dhOWYFJ6NChxS4NiGIqDKVmrEJwelTbxW6alh1xXJSiPjuOHDGi4eJm9x2ZShGP+klkAvLOp
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(346002)(376002)(2616005)(44832011)(6666004)(6506007)(1076003)(26005)(54906003)(36756003)(8936002)(186003)(52116002)(66946007)(5660300002)(508600001)(16526019)(6916009)(8676002)(6512007)(6486002)(956004)(2906002)(107886003)(66476007)(4326008)(66556008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Jny0eqPXjP24Tn23zD+KEzZG9ZWehZy6qv0Opm8BwoOSU3OwfiOwZWJAvkIyteg1S7IoKpCImAqPiZg98sb9Kie9rOVzC3tz8Fybf4dX5dTU2IPDhBqJivxObJvulga2QdpTTu9iQc6NuK039Y8Y3JJNDkbtvKqrUmsFvYth2XhQ4ACDvohTytaQAgdz6fPOrpftTNUV6hYNpLaDasaHszibFBkrSv7zty6PEbXwKvpBC3ca7zTpF14HbgWe7FtMbSz0reb91NekL8EYARUSu47qCMqXDn94nKyxc6rsjjMt9tBeqwzuzxyZ1MaEzBpgjKlUXwYfLXIQVkRCM9tdE4hPJgJV5NQyecgi8coYPE7nCuDFBV9shloAPpRJYDMNf5+EXPbpkCMFcSZQmQyC7xdwi9JCcI36FOZPtrZuQxotRIfJYtCbxaNmSzysS0a6BK86YNJ9ITSBarcp/fxS8nbTLZziErFmnPUTqxAyJF8bmWdX2wTMsrTNOBym/Q2ZnISDOiex80Dd+7an/08HDJv0/4pFJSpSRx7vr7Q5Xf5Y8c15uTT9gISWtzhUtZIantsJsegFyMpMEzlmL7IOI+HKgt0UIia+seHVha3e3TnqPV07cvOnB7+nd4ZQvoZmsWEL+OTBafE/UxEZnWOBJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4091
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b212cbfe-b0b2-43d0-0233-08d86484bb61
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ET2C6+JTGSn9Or1ljiG+QDXX/ya8y8OKeqQFA+NY5D0tmoQFLIOWzbryCliFtc3sKhtp4mSV2bQFCJenSm5jBpY63SHmK/PSWV9I+yQeHJ3sPHkATu0KQRMj/8cnsQ48oEqCBLEJ5APAh8bb73KeKB2XxbWXMqM8ZPi3MAjIFPgddXjHy19ONAzFzbJGnmEm5iNzVpZcxlse36haksDf6Iq2p/mHRGqDF6seynNM2nl944xArLZ0SILmK22rHGkjf2ITbBWh2hM7z/tbedVoPZdiwcodfzBCxhZWvqoZRgDDaqF+9qRwSA6NdwFN2NKzLCq/VITsODvVxhmoIe6JOqn/gKX1LquKttYM9aiAah8/SpzmUgwoW/SSScDIVR9qocV2vqwcAcWhjSf+vOpVlxycuXw/ti2TtjsanI6FQPVqN5rmbPz5eFb6W+m1rbz2Zvm3zg+EdHD6mTsqrPD/oMjlXdq+wnx0lqanXYbYSoY=
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39830400003)(46966005)(8936002)(2616005)(2906002)(956004)(478600001)(36756003)(44832011)(6666004)(107886003)(6506007)(26005)(4326008)(336012)(8676002)(6486002)(6512007)(186003)(54906003)(16526019)(6916009)(33310700002)(70586007)(356005)(7636003)(7596003)(70206006)(1076003)(47076004)(316002)(5660300002)(82310400003)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 14:34:19.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985b0929-3730-4c62-2d92-08d86484c3a1
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1967
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

