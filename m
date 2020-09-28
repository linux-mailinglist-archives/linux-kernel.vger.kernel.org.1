Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C427B095
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgI1POC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:14:02 -0400
Received: from mail-eopbgr00098.outbound.protection.outlook.com ([40.107.0.98]:21413
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbgI1POB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U55CkoeRD1600CN0dal+VMTEB9WZ+ywyAImUXsAhLOo=;
 b=LPX7BIN1Cg5AnPI3Cl5p2u46LXVKfaPPigMe24bEkbLWIpoaoPNefK9jfFGrF0B8Fa8i69RhFJTUqrLa/R+VCYdsLW9UyED04Xtn/L1cEQVrKZmt6KZsrfnHYCm+cLV6WanAMyJ1yziLZ4qu+LkgNbcqCjdGVLsm9Jw397J91So=
Received: from DB6PR07CA0103.eurprd07.prod.outlook.com (2603:10a6:6:2c::17) by
 AM6PR10MB2213.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.25; Mon, 28 Sep 2020 15:13:56 +0000
Received: from DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::d8) by DB6PR07CA0103.outlook.office365.com
 (2603:10a6:6:2c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.15 via Frontend
 Transport; Mon, 28 Sep 2020 15:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; roeck-us.net; dkim=pass (signature was verified)
 header.d=l2task.onmicrosoft.com;roeck-us.net; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 DB5EUR03FT004.mail.protection.outlook.com (10.152.20.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 15:13:55 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.50) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 28 Sep 2020 15:13:56 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 9566092
X-ExclaimerImprintLatency: 592672
X-ExclaimerImprintAction: c3c1e2205dc6411faa4fca8eb5cb0331
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqQemtqzy8h9MVTi490HKp4k9/cVb7eseHKY31TTNMTzyWqE1sCenqYm+aUsZPBS8CZ0VbOhvcNh6v09ouviIFilrIyEhSsK/SkyxD5KiZfgaICEL1bIwdA8SjG8JaRE6Ny3fbqp3ZJil/SyMpSCY3E4OQ1hGNssIDokvrg57xdCM/JSi/vcUXWRwM+nZJkjSliP+epzObghI69hobvvIXiiSBO4xXOGNDndvujj4xo960NSLe55fgQV/v9MZYjo5gsjig25ehjatgjN6Fs5JYXvTdOnQxu85QQRncWAHQ9YWS0P1xWZ6SIQDcOGujpA07SWSHfuu3iBLvoL22Tf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U55CkoeRD1600CN0dal+VMTEB9WZ+ywyAImUXsAhLOo=;
 b=gjFEl4KX5pVg6j2WVc4vbNU0zEOwEzMjevI8ZPGxt+ACkY70Q37aimjmUjh6mBToiK5xVuINmgX2sLnUyU0DBNBK5ebn+nMmf8ZdSDELQfTKwDqV/ebw9k2RQ9hQz6FIXlQ2x7eFTNwrxvmT0RaVrYqHhHAYrPrBBn5Qs5sMOJVvJ99hop2q58O523x7W7BE9UavJI898rVoCOD1VL0+7Yi0U+2HkBDQ7GRtm7IJKJ275/QFPKYrK+gWGcN5slu2LMyJ6PJqbDdyn23sghuPzxQDsExt65KMku5RoUvPGNEaO4HrqKwW/rXM6mvAVBQJn/lWwsEwsWFz8exSCdMK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U55CkoeRD1600CN0dal+VMTEB9WZ+ywyAImUXsAhLOo=;
 b=LPX7BIN1Cg5AnPI3Cl5p2u46LXVKfaPPigMe24bEkbLWIpoaoPNefK9jfFGrF0B8Fa8i69RhFJTUqrLa/R+VCYdsLW9UyED04Xtn/L1cEQVrKZmt6KZsrfnHYCm+cLV6WanAMyJ1yziLZ4qu+LkgNbcqCjdGVLsm9Jw397J91So=
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM8PR10MB4196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 15:13:54 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:13:53 +0000
From:   "Bedel, Alban" <alban.bedel@aerq.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] hwmon: (lm75) Add regulator support
Thread-Topic: [PATCH 3/3] hwmon: (lm75) Add regulator support
Thread-Index: AQHWjNvvbjAVBGga5EO2Sw1jO6TDvalt4MuAgBBZbwA=
Date:   Mon, 28 Sep 2020 15:13:53 +0000
Message-ID: <d3c7959cd1e775ae4680a446328f271e7d6c42c6.camel@aerq.com>
References: <20200917101819.32045-1-alban.bedel@aerq.com>
         <20200917101819.32045-4-alban.bedel@aerq.com>
         <7986c014-b826-bad1-f19c-cdda31d20804@roeck-us.net>
In-Reply-To: <7986c014-b826-bad1-f19c-cdda31d20804@roeck-us.net>
Accept-Language: en-DE, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Authentication-Results-Original: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=aerq.com;
x-originating-ip: [62.214.82.242]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e2d13c7f-d73e-4739-e121-08d863c11e8e
x-ms-traffictypediagnostic: AM8PR10MB4196:|AM6PR10MB2213:
X-Microsoft-Antispam-PRVS: <AM6PR10MB221327DD77C798144F38ECC796350@AM6PR10MB2213.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Vz9LTvjA7WMH5ch5B2bi3UKTOweIJde9U9OSijG4JryDMSJCeSfrIh71CJUDad/5cuAcBMq+IAHW7KQYPpCAwaUPaVfmeDYY1IMgH6PyTc5gRz2e+FXghCVrCesnG056AkP1T5KreEk4luvgqRf21l5rPcmPqKpy7YiCBCd5JLlwKr8lf5RT76ycKbVfy2NdRb7BKso/9un2SHqD+PgYKbyDDK1eVTsjj5HQCyNIx8sEST4P3z+qNOcrpXMLuIs83WVyuz3eUFnKfx3TBfx2xtNXhxo0g7FGLrLYwhfYCIojUiecIoCf4R6z/HdUIHePdGcpYgjwx7iyMN1zHaYenq/a7Siog54JXBaPdVTl562X8TwT9T2PQIwHBD6m0xsA
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(376002)(39840400004)(54906003)(83380400001)(186003)(4326008)(36756003)(86362001)(478600001)(53546011)(6512007)(26005)(5660300002)(6486002)(2906002)(66556008)(8936002)(6506007)(2616005)(110136005)(99936003)(64756008)(66446008)(316002)(66946007)(66616009)(8676002)(76116006)(71200400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9ejsR4t6cKp3UJUwI140dJFudm8OW6BN6ck/4HGmUyZP7AEAUMnY3zhpl0MAv29VcPyK+gKH9AXsZL2ozhLHEoVtcljNhNsZu164vlodvSB69uE9rdofw69grsoR5UKu2S3+hhKv2MA3ZVeFJdO/wR0LG2Ep+zMY0Uw3n5ttbtvIDKheD54LRmPJ3e7t8S5rPej5zA02oJlYqIWtXlohq7uXnGs5owrjxxd+9cvULrYUPsv9fYqI+ezMEnJe60CQ8OQdtZletu2qDFTZIhfksDf/u4lkhjxsfKMA7kRVIPLn3Lp+nK70G9U3ebFz26VG0YTgdCGKuvntXy6qHCbfw3zRcxUnmoMNT2lIV3B2rW7C7Fc6GgN4Xj0KjWi8SzZfAKLoSDgxH7jN0+Q3CPMEYIt+sllo7YHXwEoBZOdlIaFAo7mPAlPfkvNpsLOM4+59dh2H3laW8gDcqsHaaPb+VatT3VNx6fBe44TQ88uECQkA4PKIvalOUTPlUcVkwXZOTe7OgpDmGTGdgIGahd+SCB/5RbMu+TrO1iMGdaYbmJtYAQoniGKqsp1CE+ngo5zj+O6Plm55s7mkqFBmBr+aZrUWszuQ27dwjqKVa/XWKLznlRRSPUXch0ynyxRnBWqyQwwYOA6+qVQ8mjU7RCSwjQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-MYdSYUOWWsRjTKwdY+DN"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4196
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0fff374e-1782-49a2-6a12-08d863c11d0a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dxBCOc4PRnlHZjbcmrQeASeYcM0hgwE7S9nUD2uTY7bmFLwqQy8MlHGdhMckJ0fG5UULzzj74A9/782YP31+0w4Gn410OoN3enQ24Iz4yGo1/7VYa+aHnDHWkt7BsEWDtqdiNragvluF/MhuPkHJokwk41l32MeGxbWs6y3sPodDo1kkiaObNfYxizlxiIK4hba8e2Vss3Q+5PuMC3kZ/phldjZKiF416uis9k1aDOSm4L9zmnYyt05hvT78/mYHZubKmGWc2Y3TTe3OJ44E0y4XtgC0+oT3df9XsdRHHcQQFnEdNHXxhiXStTAtx2FvaxAqh220PebEBK9mYuA5fgvD4bwq3fPYIEhFqrdY2NEat82mVqWizfsnRv6SenMvl7uNoeyf5wD1TItYyGIGy9329KGYBdYk93XgPbjiS3tifUPMXATITIE++seuhPGxQXLsOQS7ht+19Q4j+8ymf8vryI5F9sm3rBYYhSoIcYo=
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(396003)(376002)(39840400004)(346002)(136003)(46966005)(36756003)(478600001)(47076004)(2616005)(82310400003)(21480400003)(99936003)(5660300002)(316002)(110136005)(54906003)(186003)(336012)(53546011)(6506007)(70206006)(70586007)(8676002)(33964004)(8936002)(4326008)(2906002)(26005)(86362001)(6486002)(356005)(7596003)(7636003)(83380400001)(33310700002)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 15:13:55.8176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d13c7f-d73e-4739-e121-08d863c11e8e
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2213
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-MYdSYUOWWsRjTKwdY+DN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-17 at 22:33 -0700, Guenter Roeck wrote:
> On 9/17/20 3:18 AM, Alban Bedel wrote:
> > Add regulator support for boards where the sensor first need to be
> > powered up before it can be used.
> >=20
> > Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> > ---
> >  drivers/hwmon/lm75.c | 31 +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> > index ba0be48aeadd..b673f8d2ef20 100644
> > --- a/drivers/hwmon/lm75.c
> > +++ b/drivers/hwmon/lm75.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/of.h>
> >  #include <linux/regmap.h>
> >  #include <linux/util_macros.h>
> > +#include <linux/regulator/consumer.h>
> >  #include "lm75.h"
> > =20
> >  /*
> > @@ -101,6 +102,7 @@ static const unsigned short normal_i2c[] =3D {
> > 0x48, 0x49, 0x4a, 0x4b, 0x4c,
> >  struct lm75_data {
> >  	struct i2c_client		*client;
> >  	struct regmap			*regmap;
> > +	struct regulator		*vs;
> >  	u8				orig_conf;
> >  	u8				current_conf;
> >  	u8				resolution;	/* In bits, 9 to 16 */
> > @@ -540,6 +542,8 @@ static void lm75_remove(void *data)
> >  	struct i2c_client *client =3D lm75->client;
> > =20
> >  	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
> > +	if (lm75->vs)
> > +		regulator_disable(lm75->vs);
> >  }
> > =20
> >  static int
> > @@ -567,6 +571,14 @@ lm75_probe(struct i2c_client *client, const
> > struct i2c_device_id *id)
> >  	data->client =3D client;
> >  	data->kind =3D kind;
> > =20
> > +	data->vs =3D devm_regulator_get_optional(dev, "vs");
>=20
> Looking into the regulator API, it may be better if you use
> devm_regulator_get().
> AFAICS it returns a dummy regulator if there is none, and NULL if the
> regulator subsystem is disabled. So
> 	data->vs =3D devm_regulator_get(dev, "vs");
> 	if (IS_ERR(data->vs))
> 		return PTR_ERR(data->vs);
> should work and would be less messy.

Ok, I'll change that in the next version.

> > +	if (IS_ERR(data->vs)) {
> > +		if (PTR_ERR(data->vs) =3D=3D -ENODEV)
> > +			data->vs =3D NULL;
> > +		else
> > +			return PTR_ERR(data->vs);
> > +	}
> > +
> >  	data->regmap =3D devm_regmap_init_i2c(client,
> > &lm75_regmap_config);
> >  	if (IS_ERR(data->regmap))
> >  		return PTR_ERR(data->regmap);
> > @@ -581,11 +593,21 @@ lm75_probe(struct i2c_client *client, const
> > struct i2c_device_id *id)
> >  	data->sample_time =3D data->params->default_sample_time;
> >  	data->resolution =3D data->params->default_resolution;
> > =20
> > +	/* Enable the power */
> > +	if (data->vs) {
> > +		err =3D regulator_enable(data->vs);
> > +		if (err) {
> > +			dev_err(dev, "failed to enable regulator:
> > %d\n", err);
> > +			return err;
> > +		}
> > +	}
> > +
>=20
> How about device removal ? Don't you have to call regulator_disable()
> there as well ? If so, it might be best to use
> devm_add_action_or_reset() to register a disable function.

This is handled in lm75_remove() where I added the regulator_disable()
call.

Alban



--=-MYdSYUOWWsRjTKwdY+DN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0W61GceYqNjiMSkodJSaS524LbwFAl9x/bAACgkQdJSaS524
LbxHRBAAkjreOYBSO5hrjS7fs6lY6c73ifwaW/8K6z5SiZBOrdxnA09ZXpiXS9sT
KuoAPehMiT6nNz2azE9Vw9971pC72uUvYmCgpwJKDhLmnS7ZvfV7oskGZJSU1s8P
r0zl5FztqQpg8gP88ghhCGwE9QyZG74Imphq2u1BE4EgU7F27yIPbrfgUyqeofD9
fQZqjq2jJHbbsexOCJtvlPveXu5NKqkF7mghbgfWRsI96NEV2v+ldo0NFP12W2we
//IFxBj+UKaYGDPExrRZkGlRy1OktCHtKACf8nPuDa6qe3JeD6ORUHlD58q200Tl
BRxCBMnAGDC1YbKS2cZXXXwex/xUnnK7/Kg/AECsPS8CON9xR1QZrxQfAYLKqnQG
et8QEDAwIsl8P9sL0F7nqjP7okuKehExx3GDLP3Hz7meiisb6FwcVCBaIHGJNKce
qLPVqHISN0iUBAoypNUIoGiKZ0hLlu/wSPYrrNV+Ym+E1Uk/VllAZtgMV7g3pEf4
jfRGwO+Dy0eP5k8JRtoMnT+QJPxIvjKHVAuztmrPB6tXM6uaUmLjUkcOiLRZ6CtX
paxwH3nA3r5nsQbxxg1l9O7jF/Pk9U7jZ5Mt8Nhlyc2jsvkE3nxLmU5PFBRKX8Z/
z9ib4dfAjtYVM6x5k5HntqReRz1Eexj5s/czn9+LzVA7XCOrGjA=
=as+m
-----END PGP SIGNATURE-----

--=-MYdSYUOWWsRjTKwdY+DN--
