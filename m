Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5482ADAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgKJPlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:41:52 -0500
Received: from mail-eopbgr140113.outbound.protection.outlook.com ([40.107.14.113]:19940
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730299AbgKJPlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:41:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ncy0CwDHseszSL78E42KATUhY/3pnHNIhgmTWzKDDk2Bn/sSXsS9cJne/RNmC8tVl+7w9bJ01s5zOPLyTCngTZl3UssIR7+lZCOnpbLJ3NhEA38UTP1MGApe97jEQBTFIYcZyto7hMszC+GAkuF8IaT42Fva4tkqquHIhNfHal6/7hthI6N8AcZlwBzEFGqW1pKiqHXJWwpsQNtNPx4YxnQViZBNXTP0W5miKKcxhkBbhQrxPxNIwtG5WCnWpV62bXyn2oroQwXOo35U0fMTg7kUfu9pvOI6RlQ83OMWQuXvqfkyJnOLF1Bs6tOZyK3zRR/CP/PStAt4l8DMdGZLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ0MX6UgezRoWXJuWm6yiQv9khSgu58Cw9Miof30pT4=;
 b=JyypttK8hWmz3qD5mIRQL8wF4yrPhMwfzrQ6C7+CrzLAaUbdPWbpGFGyr0tHn28lpuepEPCcr5NvOmfWRWLM/kNN8sMsQUUW1Z2gGnxzWKBGZow47pDW05H6Va85o9AghyB9pvzzXcCuejCpU3yYbVUFVlkJLNGLZoZT56ilTOgZzU+YsrHhoV1RYf1Kc0/jJhZaNHg0/KKVLowJTLCIpUmM/gx36p5rtFY5eONemqLVOr4ulZqfwmUxCNPUi0ceG5UGy/flUaiBv3T36tTuGzS0elTB/Ks/9nmGufVB+QAucCyAxaC5EgLg6MZyS+oqyheDnxZsH1xDBkbOccY48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ0MX6UgezRoWXJuWm6yiQv9khSgu58Cw9Miof30pT4=;
 b=oSpxTNQmz/2VFrf0cxZIX2qTyF1CqvNpMz2WXXkuG6+Jqa1/pVMUBs7MN1eKgG1CHdenv1h+xAnE7qaoEwihPC3Z8IITy+8CzbQKm/Y7F6YAPL3NMrnN7ELZuukz72Ead9MqKNDLP1FZfS3tSp+BpWWDjDemd5Eu3OhvPbZYSB0=
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::29)
 by AM9PR10MB4466.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 15:41:47 +0000
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887]) by AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887%6]) with mapi id 15.20.3541.022; Tue, 10 Nov 2020
 15:41:47 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: Re: [PATCH] mfd: kempld-core: Check for DMI definition before ACPI
Thread-Topic: [PATCH] mfd: kempld-core: Check for DMI definition before ACPI
Thread-Index: AQHWtzWk3mu/iHMWGUeZlaHx0+OPBKnBcDgAgAARWgA=
Date:   Tue, 10 Nov 2020 15:41:47 +0000
Message-ID: <b9a01e2c8b54fbadfaff8d3a5888802ce4859ed4.camel@kontron.com>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
         <28a160ac-df8c-0fcb-8814-03125d753be3@roeck-us.net>
In-Reply-To: <28a160ac-df8c-0fcb-8814-03125d753be3@roeck-us.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3d72ce3-67a7-4cea-96f1-08d8858f2278
x-ms-traffictypediagnostic: AM9PR10MB4466:
x-microsoft-antispam-prvs: <AM9PR10MB446634778480BC4B47670A30E3E90@AM9PR10MB4466.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvUwVfDEBEvHysvB2oXe0INP/+bpoqkHwe4DwrXtydR9XD0yCv0GzXDCGim4yMOEA5Gt5McnIIKrt5JJSowi4jGeL38VDkkpe8+1FnkGNYqTwbxPZkyMYzKddQJ6IZQ3H3GXHh9g7QOvTKx0AIb3s6jAnBk/x0p5qYaGyW0+KzHlsUkGXNofxp2AY8IAoY+rlHNDyedQQsfnUismxSHtZiCLBtM653SP2Z8G8pKquXffbgExrB5nny9GfGXgtBGLdVQTm/erM9y4NWvAlPLmsrb4F0bZARBLCcbAJN2nzD9aJziOqKMw5jKuiluviCiW1nCMEPKzswrST3m+f0kGzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(2906002)(6486002)(2616005)(86362001)(26005)(66946007)(54906003)(110136005)(5660300002)(8676002)(76116006)(91956017)(66556008)(66446008)(64756008)(66476007)(4001150100001)(478600001)(316002)(186003)(8936002)(53546011)(6506007)(4326008)(6512007)(83380400001)(36756003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WzlL64TGSAW5tq1jrGyfkq4gs7OKT1ps0/RKC0Zy2FtFtysHF0Pvfm8f38cOVIPOYJX02PqQl8CT2ELRHqJWLZk9G0fDkGg9Jx4zTGf3UutOZq6NCkd2ogCS0kGsw8izvr8P0t4qGT1haNl9EAqTKnh3pLR8YAnRqfuYrzSn6q4NRwFYNMUC8thesLLTcvLGfZEF5FiO+dY9MrgSqB/7FIXgNp+0uDK9tZs6mHRYquXtsLgrs0H6B7MJN2UPXq8gDfdgobzjfq9s/nLBjTMecPrI3aylSNdusPmOOgixH503SjxPOrewL3zHzPkNV2OzaJceaUoh0REeHN8HFW42Mf7YcyKfwu7ZCk9pUi9pVPCHOgXMWFxH4lmzOPrhFn+xAwwbMk9WqAmCQM7z02v0AahAxkPLT74gzlod7MwZLIlyySCsB9pAVqcESgt0FjPqXMCQWDdetivBhuEs5apRqbsrZtyEWrQOtLFNRGQsPVbFJiHdgeuZigh43QE2x8Q1ciWv3AYMZLkaj5gIjF5Eg2yBJnUJ8ZjQ8Uj7FfMqgqBGE+eJvhIqHF5G2NPqUsEhudLsW8ieOPg1LFXJ9QhnvfvjHrkQTC8PQBr/CO6wNExuov1OMxHPwI2yRtB+9hWSJLPHcAWH3JIixdvhaB1sKuXBOgbJCwmmUf3PrlnEbSwkUxOisUirWzTeHrqv4GQsHU67EBFZDrpyr3zwbjp6iFLZQK00uqtob5SPiiY7ZlIkodTb3OYIS3+yCxIA/hcN6IgynyoDbJzBjwMuOnvQy+VDnPT92y4wo8LJnke95lXdONvZ8hn5TrfVH1uxxmUc86Cr4X0uhb+QxbSMcFJf+MbWLPqw5m2N/5JIS1ldTP7p/FVA964KWUIeQ9XPYlGrytlcl3CwN8moR7suRei/Ag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <6A8C155602C73B4F999E119DD10EFAEB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d72ce3-67a7-4cea-96f1-08d8858f2278
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 15:41:47.7071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkZ88Q9RyZE3OBn6sL9LZKkQ9MafJ2wHRvyU0fjwmYWmKuTiKWBJrfRgy0HXNWVgAz0bGn3+YtTtbegAMwADRRi599556Y+zPtNdY103Pgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4466
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

thank you for the feedback! checkpatch didn't catch this.
I sent v2 of the patch.

Best regards,
  Michael

On Tue, 2020-11-10 at 06:39 -0800, Guenter Roeck wrote:
> On 11/9/20 11:46 PM, Michael Brunner wrote:
> > Change the detection order to priorize DMI table entries over
> > available
> > ACPI entries.
> >=20
> > This makes it more easy for product developers to patch product
> > specific
> > handling into the driver.
> > Furthermore it allows to simplify the implementation a bit and
> > especially to remove the need to force synchronous probing.
> >=20
> > Based on the following commit introduced with v5.10-rc1:
> > commit e8299c7313af ("mfd: Add ACPI support to Kontron PLD driver")
> >=20
> > Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> > ---
> >  drivers/mfd/kempld-core.c | 23 ++---------------------
> >  1 file changed, 2 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> > index 2c9295953c11..aa7f386646a1 100644
> > --- a/drivers/mfd/kempld-core.c
> > +++ b/drivers/mfd/kempld-core.c
> > @@ -125,7 +125,6 @@ static const struct kempld_platform_data
> > kempld_platform_data_generic =3D {
> >  };
> > =20
> >  static struct platform_device *kempld_pdev;
> > -static bool kempld_acpi_mode;
> > =20
> >  static int kempld_create_platform_device(const struct
> > dmi_system_id *id)
> >  {
> > @@ -501,8 +500,6 @@ static int kempld_probe(struct platform_device
> > *pdev)
> >  		ret =3D kempld_get_acpi_data(pdev);
> >  		if (ret)
> >  			return ret;
> > -
> > -		kempld_acpi_mode =3D true;
> >  	} else if (kempld_pdev !=3D pdev) {
> >  		/*
> >  		 * The platform device we are probing is not the one we
> > @@ -565,7 +562,6 @@ static struct platform_driver kempld_driver =3D {
> >  	.driver		=3D {
> >  		.name	=3D "kempld",
> >  		.acpi_match_table =3D ACPI_PTR(kempld_acpi_table),
> > -		.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
> >  	},
> >  	.probe		=3D kempld_probe,
> >  	.remove		=3D kempld_remove,
> > @@ -884,7 +880,6 @@ MODULE_DEVICE_TABLE(dmi, kempld_dmi_table);
> >  static int __init kempld_init(void)
> >  {
> >  	const struct dmi_system_id *id;
> > -	int ret;
> > =20
> >  	if (force_device_id[0]) {
> >  		for (id =3D kempld_dmi_table;
> > @@ -894,24 +889,10 @@ static int __init kempld_init(void)
> >  					break;
> >  		if (id->matches[0].slot =3D=3D DMI_NONE)
> >  			return -ENODEV;
> > -	}
> > -
> > -	ret =3D platform_driver_register(&kempld_driver);
> > -	if (ret)
> > -		return ret;
> > -
> > -	/*
> > -	 * With synchronous probing the device should already be probed
> > now.
> > -	 * If no device id is forced and also no ACPI definition for
> > the
> > -	 * device was found, scan DMI table as fallback.
> > -	 *
> > -	 * If drivers_autoprobing is disabled and the device is found
> > here,
> > -	 * only that device can be bound manually later.
> > -	 */
> > -	if (!kempld_pdev && !kempld_acpi_mode)
> > +	} else
>=20
> 	} else {
> >  		dmi_check_system(kempld_dmi_table);
> 	}
>=20
> Guenter
>=20
> > =20
> > -	return 0;
> > +	return platform_driver_register(&kempld_driver);
> >  }
> > =20
> >  static void __exit kempld_exit(void)
> >=20
