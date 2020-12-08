Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7CD2D2837
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgLHJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:54:24 -0500
Received: from mail-eopbgr140082.outbound.protection.outlook.com ([40.107.14.82]:44175
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbgLHJyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:54:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th1lO6GfJT1n203/xhH9iQMSvVlVQ6pC9qAAbU3ms13mbuE2mBBAdjzY9IH1pSejUUZ8/3Tw49a8AtjRhJmR6A3Jv3C5a9JQNW0I0SjfpdO2db7v44S8B2Vh/wuMB3bidZ8NUBXEFaMBdMnWty4Rgkn9ELil6+37GsjnNEBzXuv4FJAcZVQD4PkYpQpAZO8GHMXv5otMtIUyaPdEX8T0IQvf+CFdpPO9H8cc1gqajiEjiTRTziFVH8QhouFW3pY/qs8Upcbluh6Uln1QAb8HfDDUndwEzZzpKFiXty7Neh9f+zyE4047E5dKYgsb+8AcvCuOyIA7M9Es5yQ40gBMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N98wKlfvZuDhKJImMYJMaTp7av5K80BrmbQ512zdBTU=;
 b=ZOGPVQ14e8Fwuaj0yLZuy69RTwjBXenr6XVaiGwb0+mX3xB/Oy9gpH+e+BOQ7pppSIHFhblHcw9AxhXUFahpHNWDor57LXPILg4sh3sKrp4GYUDtbHwnR0A7ee4zxG7BreehBqOhXQuJsXfdrPmUi7dzWbD6A9YkFP2SYRQOrme06kRZDE2UXm2kHll/wnkD8O7k+VxOJnKBpmxckcAc+pYyqDQcsdRXz2bO/fdm5cLaXnJINjAKMJ0DnYBxPF+fBarQyI/WEmeS3BHvyApoiinfD8WuafG/PcNXwyaPZxJcm+4Af5BYpSp2i+IEv8Fnc/cOLze0vX29rDX32cK/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N98wKlfvZuDhKJImMYJMaTp7av5K80BrmbQ512zdBTU=;
 b=y1zMZq9zRMl/HGXEX95TBGKDAtH03aOzsXfW8TIteZZChO8PHtQpYtHl8ekOam67nPTvS7n9ET292jLlMY23o1lcjGjbL7Z+Cglhgo9JCCWKyJ3jqWViAVG7BUXxl+aPQ6synfSPShq3z9Pu5GEPK425cOEaOJhaxtPwXmJ+BoU=
Received: from AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:aa::16)
 by AM6PR10MB2536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 09:53:34 +0000
Received: from AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5438:1932:b075:be6c]) by AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5438:1932:b075:be6c%6]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 09:53:32 +0000
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9121: Potential Oops in
 da9121_assign_chip_model()
Thread-Topic: [PATCH] regulator: da9121: Potential Oops in
 da9121_assign_chip_model()
Thread-Index: AQHWzMJFZGlOjig7rEuJfrRCFSzSBqns9kOQ
Date:   Tue, 8 Dec 2020 09:53:32 +0000
Message-ID: <AM6PR10MB2807B94531075D81CF3D1694ECCD0@AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM>
References: <X85soGKnWAjPUA7a@mwanda>
In-Reply-To: <X85soGKnWAjPUA7a@mwanda>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87057ecd-84c8-4daa-c950-08d89b5f1f9b
x-ms-traffictypediagnostic: AM6PR10MB2536:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB253619CFD69D43D97436E512CBCD0@AM6PR10MB2536.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RrQ7j/44peH6blqDzawNGeEx0PuVf8n+RYf33f1faj51DBaPLRQVnoSvOdupPzwgYx46GvU8DibukUmCDqLvX4MuAiasSYQ+hgMP4xZ7o+q2+Ed1S0MOpHw1YLoTLaKvIUGuiBvvRGPC2KIwBbR/j9nlYvfeL2SztXu+bNGyTMigpVvCiFo/H0Zz1yBcibBWuyQqDvJF8JcRk8nOSYT1DZeneOBp7EBCB/JyVnhb8WYqUQ4P/MssTbRDZlXoPnihXvDK8agouPGhYdEgdu0GwpzRwbSV4KF5JNnzg7FxetzDqLuKimmzVjkRddxXlnXRrLW83fprp3Hx35FJaMa8KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(52536014)(54906003)(64756008)(186003)(55236004)(66476007)(110136005)(4326008)(66446008)(76116006)(2906002)(66946007)(66556008)(9686003)(71200400001)(5660300002)(508600001)(7696005)(83380400001)(8936002)(86362001)(8676002)(6506007)(33656002)(55016002)(53546011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?29NXD8hMSRCthOuWM4XHixVcXnfVX0ex7LaurdQFobLp8hoiyZT77pv8kE2T?=
 =?us-ascii?Q?gwMXYV0eOheKWvYN5chG7d061evATYO8OUk1IlPHLfzyARkvR7n/IkuyWaou?=
 =?us-ascii?Q?gC+0gwM2RntPOHBrq2L/kKXwtWHQiTG1970wvh1O5sTWv/+/CFefBjVJOgb9?=
 =?us-ascii?Q?ivzTBqwhqmjlFei2u5LaBTuqswY+i0P2q8R5VkvoioW/mCXR6spT4IMDbEf4?=
 =?us-ascii?Q?xyMUkpd9s3N5gJoZ+PNwtRX31baTgx7oMAYWBTAUGKQ7DxXRTCFzhiiCkfnQ?=
 =?us-ascii?Q?5hI9+oNybH6pFsn0C2Rk9pPB0FJ+ourgzoCJ4JCvu1WGxxFwjgMkahJXvx8E?=
 =?us-ascii?Q?2szgn9G/Y8a/X2sk8Kqr9ujN6SZHf7bJznX6krVTkqpuoZzNN235mosMDDy0?=
 =?us-ascii?Q?kIhqLRA//BiNomGUhN6i7N64IFB1yvI3IDOEvdJYNvWrfK9VPJyKg0JfY4E2?=
 =?us-ascii?Q?FEBtboQ52NULIwymhG7n3ad4Y7kndfVY0Qk1hdVd7pw6slz/GDbmqFDyRwpc?=
 =?us-ascii?Q?8aqxfzRB7m7Zd1S7TLIq7+3DNJG1SNiMchcGnjXLauB6CmnsZ8TPTTMTHEIr?=
 =?us-ascii?Q?wkwbdcYnVfPXLFt+7sQmSTHJF7APeMPUBY4Kp4yW0QskaMJwrKQeym+OEnI8?=
 =?us-ascii?Q?cGy1fl8tAhJE220p0TpE/Gb9Gj4KluPpvHKXrbRKrMXmbMfLzGcjwOdlOztO?=
 =?us-ascii?Q?JeBqKDjWOpHftW6d9AXYSYsAUfp5kV5at3qNL8bVuGtY16CejZt70v8cUfpV?=
 =?us-ascii?Q?D3Ytwy5vSB97S2ulXocmZnRoVqX8/HGUw2SckIW4QOFDN5CiSSQyYZ967YrI?=
 =?us-ascii?Q?ere2nE1tp43WJZEojU100a/HFG4bqfuw3Y2Y9fvns5vq/Gs8kjMn46qTJ49E?=
 =?us-ascii?Q?+6oROfQcWb0dekmwu2RddCflb5V7KsuSIp57NDOg9cetGgASDqC4+q1A3Mfx?=
 =?us-ascii?Q?ZLLYfWV9hJHFlbuiCDCg+DjmnQ110i0QL6hugXQFTi4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 87057ecd-84c8-4daa-c950-08d89b5f1f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 09:53:32.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14/zHxG+wZrz72vNotN6hovtqI02yTXJX5p9VD+5OgG0tewGGUFYImrqeVqWWL5HjVat9UQrHTWfxP3nRE6xnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2536
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Adam Ward <Adam.Ward.opensource@diasemi.com>

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: 07 December 2020 17:56
> To: Support Opensource <Support.Opensource@diasemi.com>; Adam Ward
> <Adam.Ward.opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> <broonie@kernel.org>; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: [PATCH] regulator: da9121: Potential Oops in
> da9121_assign_chip_model()
>=20
> There is a missing "return ret;" on this error path so we call
> "da9121_check_device_type(i2c, chip);" which will end up dereferencing
> "chip->regmap" and lead to an Oops.
>=20
> Fixes: c860476b9e3a ("regulator: da9121: Add device variant regmaps")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/regulator/da9121-regulator.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9=
121-
> regulator.c
> index db1c2cc838bc..e4fc3a7cd5d8 100644
> --- a/drivers/regulator/da9121-regulator.c
> +++ b/drivers/regulator/da9121-regulator.c
> @@ -915,6 +915,7 @@ static int da9121_assign_chip_model(struct i2c_client
> *i2c,
>  		ret =3D PTR_ERR(chip->regmap);
>  		dev_err(chip->dev, "Failed to configure a register map: %d\n",
>  			ret);
> +		return ret;
>  	}
>=20
>  	ret =3D da9121_check_device_type(i2c, chip);
> --
> 2.29.2

