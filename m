Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757C427B10C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgI1Pju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:39:50 -0400
Received: from mail-eopbgr40115.outbound.protection.outlook.com ([40.107.4.115]:21930
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbgI1Pjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68PAdlAqYyEGoSKGhq5oEl4+uaRRAvu0cvAKn8tGV6U=;
 b=gCa2NwWJCqombE9oTOkC1qiKCEouHe9HGX//cjZQ5CXafm3rMZXMml5mlgnqHdt3H/l8XXOQzUWDcUscUqz/GkH4xnQQ/ufGFuamLAIBPzXaAgz8phYY9tExXwJDnWQbWtJPRVwynt3RvLiLLrnyMKF1haqL6IloqGTw7ZLo560=
Received: from AM0PR06CA0111.eurprd06.prod.outlook.com (2603:10a6:208:ab::16)
 by VI1PR10MB2381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 15:39:44 +0000
Received: from AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:ab:cafe::bc) by AM0PR06CA0111.outlook.office365.com
 (2603:10a6:208:ab::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 15:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT037.mail.protection.outlook.com (10.152.17.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 15:39:43 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.55) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 28 Sep 2020 15:39:44 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 6442469
X-ExclaimerImprintLatency: 667347
X-ExclaimerImprintAction: b597f7f0f3984dabb641a5617a0bdff6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAIT5hL7f9VmNtqYvyIvXSxRRw49h0UGO7++ehU2RamqoZ/O3IvGmlyzB7Wr44gCklvfp5kYETMJyEk8PzNCq3wkE4n1sqSJ5aTUzUVkW2yM2+ey8CL4Rb8QSi3IhERjNY32ziAFsNP54xExOizrOX6rFXDnFlL40RrQw9Qv8RdKw3M1AV8worde6eNfvishfZrvPN/4S8T46t3gXHnI5pnW62LiWMcWf26tNO07XBYD7BXBlqr1r7ChVJ3y3OmSsxIH7VmH4/7KMeClW2YbG070OJPVHOvWKXQNmh3Gpd9ihRyJWhm/QnQ1ElCJI2M86iIn8sDsN9xHXndQmlUbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXqcpcVCdpx4cbyvCQ04EfegM35DpG+4r3LeMzDNRlA=;
 b=EZEqggDK9BkHPWKco/+vCpi4BasmYpC65LHSaolBb1kixujoIh7l5CZZhoSVLfHouLBbppVOaNW5WQPT3jqo6mwFy7azoJWoIxHJhLBCto1XT2Y37Gc/ijOspAPc4fDsB5LdaN5joVOLayn3ld1vteBq+hyZQuqJC9be29dNViIzjsIVLcHVC76l9Iyw+tdwpetkRwv0LVpknaoEDb5sMfiOjrrZPVR5Zix5F6FPsWyZNbxQpJ/Mv/QkXiQUR+W7v4Ad2zEDtbEIM8gxmaP9J8mXxUxQ7rUxoh8qeZxKXnviQOgwT8M5pYWwLR1+KIlRl08MfLs7PvgNsatpfUxCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXqcpcVCdpx4cbyvCQ04EfegM35DpG+4r3LeMzDNRlA=;
 b=uXV+a1Oy0b1+MoT9u5/+AkZTx7FaW9pHpIqG8hjYMfNKVje+pOnkeY0ee9D9ubT9Aq2oc6YrPt1a4zDIBsEqAufEDW6XCWQoAFxFnwD3dhYQrktF8d6YDYO8wuiyRlfZ774BBkgCZjcT7SfvY7P30KtZMGhoKRBSrXWg2eW2bsE=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM0PR10MB2673.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:133::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Mon, 28 Sep
 2020 15:39:41 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:39:41 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH v2 3/3] hwmon: (lm75) Add regulator support
Date:   Mon, 28 Sep 2020 17:39:23 +0200
Message-ID: <20200928153923.134151-4-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928153923.134151-1-alban.bedel@aerq.com>
References: <20200928153923.134151-1-alban.bedel@aerq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::25) To AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:161::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.aerq.local (62.214.82.242) by AM4P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 15:39:41 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [62.214.82.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f024feb-5092-42df-faa3-08d863c4b8f8
X-MS-TrafficTypeDiagnostic: AM0PR10MB2673:|VI1PR10MB2381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB238134D6C1106F864FFA5B0096350@VI1PR10MB2381.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CExtcK19a1gqeKnYQAD0F9wTFHk8vr0cqXl6mLiLUSnYowdn3BKsmGd4Z+ePWTfKtYRHGKjOKKy8snlFzqvvon0K/608UAznJ+LWtS252tsoayaCUWDkYlL8Walx2c8IkuKTThV79tKwPhTnY1O0g5N88f8t3h42dskxQ2jRuRoW/bNjBe4SdqGKPQqRRhHKoPjzZ+Nt46zmYOauAzOX9imMTfGeTkmkXnJexgsBNd9oPvhHct3JbyfHRNt8p5jS4pkXreqiuNul+w6ozG8gMllekzrABE98o38Hn7omPhWtM9iZLnGoSdOZq4WWca22sMh28b9je8v7XaaV8mFkz2TheecX0lhe0jbzGpUURzHPaBh4CZpw6lNUp9tRmB64
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(136003)(376002)(366004)(396003)(346002)(2906002)(8936002)(8676002)(44832011)(6512007)(6486002)(5660300002)(2616005)(1076003)(66946007)(66556008)(66476007)(316002)(6666004)(6916009)(54906003)(52116002)(6506007)(956004)(83380400001)(86362001)(478600001)(26005)(36756003)(4326008)(107886003)(186003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ebACxqztMFcgDYJzdUpOlvsgqpo+JgvLt673QLb/+muoxhfEpfLAFooGgucHjy3Y8LATI1MztpXTq76FWiIzRfiu1JnEDH5ZKqZmliU3mnjyL5zK7tok4KLlJkm2bTLsWMCTZr8hCIIrixDXuMA2DxzHMijEJmNphurR71IWp3Y/m60zzUSNJSsPGtqB9O+roTdYCHfYjiBfgoWA84S7kf7ewBbK3xtbIKwR50gmM49iwA06aVJaeEJKglp0g34Yb5j5buoBSnyR+z061EvxMc/zJmy30wGuoKeMVggYrfTz2Cgbn6LsFnYDRIo8sD8/O0wmRfQCIwhvzuJjcdngAPUrhK3Yrtjsvx4hlDeQMR4xLFZ4QvMt7+vsy8IdYT8u1zJudQJH5BH0TBriZaeO6/8YFSndHwyPIvqCJkTewle/loyk8uXtGV5t86y7wJ5p/fPS9DB31VYPz4jtuQEAFg6pb+1+y70vHw6i8bHvbO9btADsokfHzXQYCKV2L0WsdkSxqPC/K3d2h34Ssurnr8MJwulHxYJ8tivpr3MUTtV7Bq80I4fxRvhM63LOU3VV6UrNIOsZsdKFuJhV6PKk2TjQGE8SszQiZ33G/VhZphUbLzjQshhVO/IGYKYtuoCin9qsg6wU/Z5LqGakHt8RXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2673
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f96b3581-dbc9-4995-2f7e-08d863c4b741
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5QO2kgvo6AFtUl7zskcPAx1wORtQ+q4tvPz4oziuvn3xk2sGsBoRS7VyYKEnVVhQufbon28jddw5yOWnJK82Xfa0Ki8+UCSqXj8PmVQiobQgaexJ0MFoclHQgdSQRcBCPgv0wthSj7U7gaCIs4VNe+mNnD9VSgMkAwDpdTArBaAv88YTDW/Dd7db7FJ//92VGbORmGcrFDn+kUKpnMeRhCscCXOD2fOE2owd1mku+vOGxnHjjMr5l+8tRVOeKF++MyVOqExG2fmBNOiXikHVJB8EJscvZOp839/HcZt2rzZj8S2ojqPXt8Wea4by9cCZBO6BF5yk1NBi4PG4vttQVPjmFOk1suc0dlqoe3M909ELbRNlmSmSui7hmB+QQoDbFMCGj6vrp7UuYJaiZNaOMu9GFnozECjsirJnOyuKF1w0zLJCLpndW690QEdWOwnIXMadFA1C3fsVUlF/SXA7X8ikYZWLEts2xTPMFoDBmg=
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(39840400004)(376002)(346002)(136003)(396003)(46966005)(478600001)(83380400001)(2616005)(44832011)(107886003)(47076004)(956004)(7636003)(356005)(33310700002)(316002)(36756003)(7596003)(6512007)(4326008)(8936002)(82310400003)(2906002)(8676002)(6666004)(86362001)(5660300002)(6916009)(336012)(54906003)(6486002)(1076003)(70206006)(70586007)(6506007)(26005)(186003)(16526019);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 15:39:43.6871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f024feb-5092-42df-faa3-08d863c4b8f8
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2381
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator support for boards where the sensor first need to be
powered up before it can be used.

Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
---
v2: Rely on dummy regulators instead of explicitly handling missing
    regulator
---
 drivers/hwmon/lm75.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ba0be48aeadd..e394df648c26 100644
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
@@ -540,6 +542,7 @@ static void lm75_remove(void *data)
 	struct i2c_client *client =3D lm75->client;
=20
 	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
+	regulator_disable(lm75->vs);
 }
=20
 static int
@@ -567,6 +570,10 @@ lm75_probe(struct i2c_client *client, const struct i2c=
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
@@ -581,11 +588,19 @@ lm75_probe(struct i2c_client *client, const struct i2=
c_device_id *id)
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
@@ -593,7 +608,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_=
device_id *id)
 	err =3D lm75_write_config(data, data->params->set_mask,
 				data->params->clr_mask);
 	if (err)
-		return err;
+		goto disable_regulator;
=20
 	err =3D devm_add_action_or_reset(dev, lm75_remove, data);
 	if (err)
@@ -608,6 +623,10 @@ lm75_probe(struct i2c_client *client, const struct i2c=
_device_id *id)
 	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
=20
 	return 0;
+
+disable_regulator:
+	regulator_disable(data->vs);
+	return err;
 }
=20
 static const struct i2c_device_id lm75_ids[] =3D {
--=20
2.25.1

