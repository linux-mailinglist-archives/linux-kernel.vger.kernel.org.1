Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CBF2C0F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389664AbgKWPxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:53:32 -0500
Received: from mail-eopbgr50095.outbound.protection.outlook.com ([40.107.5.95]:29415
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730775AbgKWPxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:53:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4s+SVVHNsjFmsiqfQmvOo1PkY3m8ycdJ494gzC8Vf7tG2HldfJ/Xu9kBnmfmcTawff5/gtPxoJbe+nvbG9fza+2FN7D8zkZ+ncajcGTgDPZ5nUN6T56Cfosu7A9Sww03cWOQwHzOjjORv0HY077w4aJvTzYR/4GmHEHrxDFimbrvXX95pEA4tqxj+MqMvWD4obueGOXtbHLL+EBPyYMk5+XQPaOPCUPstYjUUGvWehNnNEBXrvoMUy/iaHoYvIZ3IFaG8FBW70Aed21lwZnuv9vEo1AeBu0Fr8EVk2soMdqlSPOVSrwr6E47odNPclDYUo8m78yAw6FlUmR0eVdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcmQuwEgZvcO+0cSDNxmxyw0a9WUVQ4wnsDoYQi6wY0=;
 b=VRdIpWTKBwgov9WSXWTWaMSatIktXi/pkhprSV+3zWNScdYQi1GJSnBe8CCfwSI9RWPDjfaRHD1sYxGh81rHv+eDgTsJZdShCS85VInNXPwI5u+hl1PyprpSg1P1tqdRkUSN3bC9mjizy5HQ27UY8NY5KGVicjfo/JvOBcxPNny6yOEtbxdaDVEifjqwWuhPMkLBYnCBbDxBgLOmcwpOjUjJkAlKS2vc331dWSOM9JHO0rUsVG1P/rGG4LdRn+ERWx1mY+I0qW9jZ5ir4oavyQvUAP9FEro4PTqklX0UTECeIn7wA1q9CuvT0r6jMu/Na5SVl+q8Gu65ouXu8mf7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcmQuwEgZvcO+0cSDNxmxyw0a9WUVQ4wnsDoYQi6wY0=;
 b=cikynOu8E6UJfYzebQqAiDXqaef+HsdutHraglEHWvE3BL3cyNck/UEY/tYp25eVF39qWemqtx2Ee5QRBthUe/0wBctcARWAKQL+5FwS/4fhvafFHc38y8xZSBF5hv3LRgCyk5Jh2iyzg6T8uTRyiaiehrZbxAGEDyVQbslbTKM=
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::29)
 by AM9PR10MB4369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:272::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Mon, 23 Nov
 2020 15:53:27 +0000
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887]) by AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887%6]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 15:53:27 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mfd: kempld-core: Add support for additional devices
Thread-Topic: [PATCH v2] mfd: kempld-core: Add support for additional devices
Thread-Index: AQHWwbDI2MexDMwSPEGCaqLvR6cu8Q==
Date:   Mon, 23 Nov 2020 15:53:27 +0000
Message-ID: <76458fc9615cf2fb805ccd4196e3e9824ad18523.camel@kontron.com>
References: <0474e39790ab7351b1b11b565b995b94d49fb87c.camel@kontron.com>
In-Reply-To: <0474e39790ab7351b1b11b565b995b94d49fb87c.camel@kontron.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18175d63-d0ad-4ec5-cc8f-08d88fc7ead7
x-ms-traffictypediagnostic: AM9PR10MB4369:
x-microsoft-antispam-prvs: <AM9PR10MB4369F8701A6B8E9EC4D8DB73E3FC0@AM9PR10MB4369.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPPz5DzJ6ZIjzCCy+M2v5PRyGTIpd0/tQU99xX8uCUNckCcKcRv/cnqkpA4LwwtwL1N3k2yz3SjmxAb+wxvc5afezINtZNjcETq7Is5SsUJHVwQ5yU5EHewBeCEd94JKyYjK0OnJIql/WO/ukQ27T9H0uaWIcj6JoS9wQiXq1eBgNaPEodvFg6mw16mINqM1MZf/ghBftMruPA0wBL505VDrvjkJYwjrbHdsewz/Web2i4vzce6xFPjvDG+NzxVbMeIUbSV413BojgvY/hEZCr+CeG7V30gz2kUdCLI67w2VQ1DGFrMbsl6LiXaMU800KRLCguCgI65nvcOi+MRKEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(6916009)(186003)(478600001)(26005)(5660300002)(6506007)(36756003)(86362001)(66556008)(64756008)(66476007)(66446008)(6512007)(6486002)(54906003)(2906002)(91956017)(76116006)(4326008)(66946007)(8936002)(2616005)(8676002)(83380400001)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-15?Q?ZEzjfiPuEaIQba7WwCGD3pAAO0/I6mS5+fkG8UeT+kTwSLU9WQQOgtwr6?=
 =?iso-8859-15?Q?ecIAQ9Gso/0QBjC4qixFRI70VIpUPLgwU7wWtryp5oAqNwXn2atQszHBh?=
 =?iso-8859-15?Q?K0U3s9dFjtGu6a1T48vDNghWKiVP9NVNW38La4CSF+LVyGPzbx6/chJh4?=
 =?iso-8859-15?Q?3qWM844X++Jv5e7+tudeUxn3ELpu2yutgJvLtCZH1Eezm0f1L5kClSTnT?=
 =?iso-8859-15?Q?JiSjmEq3Ar6eS49UQ6WPAMsrs1/XRt/kpY1/DNWDaiz81030fB0L5omj8?=
 =?iso-8859-15?Q?FDUCTgo9wlMwx/93TebEdBY6n5ndoV6GGV8bGawiNjWXZfXTHLq5UysON?=
 =?iso-8859-15?Q?u29bYa37R9cPx5tCTjtguJ6ebVKHI+j2yopDzTbagLz7bUd4rnSp/wZdY?=
 =?iso-8859-15?Q?MtxuRz0dEV8upHS2j/mivSzH8lstNeI9hPEshttloBBmC4fmtSWbE70lH?=
 =?iso-8859-15?Q?Co2e0VCCZQJb715UVqu+Gxw6qM2EjdHcApvRcJbNOREnbEIaaT/MLyA9U?=
 =?iso-8859-15?Q?lk0kgQljWdCFX0Dgf2cQPjmYnV/wOsr9IeDmMWpdebZrht7jpIxBy3eM6?=
 =?iso-8859-15?Q?NoHNyIyR63XUGKN1gWHPo8HvNMSjGujT3V+WoRQNdD3KSQkjrPnW6CUAS?=
 =?iso-8859-15?Q?xYOk1Ho5JjJF36u8C1eUI1gX05bFQs3MfD5mr2f84n4V7CDHQAf2M5+lm?=
 =?iso-8859-15?Q?Wd0m9Pjvk0c7LpAfvAVeEs0n6UD0pY/Hs9ARCoBo1+lyTkZMgB175TVw8?=
 =?iso-8859-15?Q?7AVSEIendJtR/XliOEPQ8+Hm5sBVUZ5buV5wimEvFBsbUNxinqMed7agz?=
 =?iso-8859-15?Q?oRwnUOq9qtH1FoP0c/PWT38rx4so7jDaHlQ2WBU4Qmz3h0J897e6Af1qa?=
 =?iso-8859-15?Q?zxq9+Ph6jHxbvvjxjaN4d+cBQ1hIbkM1r7f2eizYQQez+DO0GKA2ojCBR?=
 =?iso-8859-15?Q?s13qKKd/8FCtEBV5uAoqxk+CTJXMzHjb8BeqNLjFx49Q8Dx5hJ0Gn77a7?=
 =?iso-8859-15?Q?F4+KIHn71etXl6DQt9qL9vpJSBub1z2RZeD1eDY3EqgB3XJfRs3/+yc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <6C45F9E83DE69D4CAC6FC6881F8BE9E1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 18175d63-d0ad-4ec5-cc8f-08d88fc7ead7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 15:53:27.3010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Ir/a8Z8qlaMstOwAmVtFx4Nk5IsLtOgGZsYw+7a1b8SitupWHg0em6VFrMz8zn6T5K9l5VCM8/UELiKWeGevXvuLH1b2QCJVAv4y3FwkMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4369
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This update includes DMI IDs for the following Kontron modules and
systems:
COMe-bDV7, COMe-cDV7, COMe-m4AL, COMe-mCT10, SMARC-sXAL, SMARC-sXA4,
Qseven-Q7AL, mITX-APL, pITX-APL and KBox A-203

Furthermore the ACPI HID KEM0000 is added, as it is also reserved for
kempld devices.

Instead of also adding the newly supported devices to the Kconfig
description this patch removes the lengthy list. With future usage of
the ACPI HIDs it will not be necessary to explicitly add support for
each individual device to the driver and therefore the list would
become incomplete anyway.

Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
---

 v2: Corrected a board name, only use 4 digits for IDs

 drivers/mfd/Kconfig       | 30 ++--------------
 drivers/mfd/kempld-core.c | 76 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b99a13669bf..befd19da8562 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -720,33 +720,9 @@ config MFD_KEMPLD
 	select MFD_CORE
 	help
 	  This is the core driver for the PLD (Programmable Logic Device) found
-	  on some Kontron ETX and COMexpress (ETXexpress) modules. The PLD
-	  device may provide functions like watchdog, GPIO, UART and I2C bus.
-
-	  The following modules are supported:
-		* COMe-bBD#
-		* COMe-bBL6
-		* COMe-bHL6
-		* COMe-bSL6
-		* COMe-bIP#
-		* COMe-bKL6
-		* COMe-bPC2 (ETXexpress-PC)
-		* COMe-bSC# (ETXexpress-SC T#)
-		* COMe-cAL6
-		* COMe-cBL6
-		* COMe-cBT6
-		* COMe-cBW6
-		* COMe-cCT6
-		* COMe-cDC2 (microETXexpress-DC)
-		* COMe-cHL6
-		* COMe-cKL6
-		* COMe-cPC2 (microETXexpress-PC)
-		* COMe-cSL6
-		* COMe-mAL10
-		* COMe-mBT10
-		* COMe-mCT10
-		* COMe-mTT10 (nanoETXexpress-TT)
-		* ETX-OH
+	  on some Kontron ETX and nearly all COMexpress (ETXexpress) modules as
+	  well as on some other Kontron products. The PLD device may provide
+	  functions like watchdog, GPIO, UART and I2C bus.
=20
 	  This driver can also be built as a module. If so, the module
 	  will be called kempld-core.
diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index ecd26271b9a4..9166075c1f32 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -552,6 +552,7 @@ static int kempld_remove(struct platform_device *pdev)
=20
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id kempld_acpi_table[] =3D {
+	{ "KEM0000", (kernel_ulong_t)&kempld_platform_data_generic },
 	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
 	{}
 };
@@ -584,6 +585,14 @@ static const struct dmi_system_id kempld_dmi_table[] _=
_initconst =3D {
 		},
 		.driver_data =3D (void *)&kempld_platform_data_generic,
 		.callback =3D kempld_create_platform_device,
+	}, {
+		.ident =3D "BDV7",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "COMe-bDV7"),
+		},
+		.driver_data =3D (void *)&kempld_platform_data_generic,
+		.callback =3D kempld_create_platform_device,
 	}, {
 		.ident =3D "BHL6",
 		.matches =3D {
@@ -648,6 +657,14 @@ static const struct dmi_system_id kempld_dmi_table[] _=
_initconst =3D {
 		},
 		.driver_data =3D (void *)&kempld_platform_data_generic,
 		.callback =3D kempld_create_platform_device,
+	}, {
+		.ident =3D "CDV7",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "COMe-cDV7"),
+		},
+		.driver_data =3D (void *)&kempld_platform_data_generic,
+		.callback =3D kempld_create_platform_device,
 	}, {
 		.ident =3D "CHL6",
 		.matches =3D {
@@ -767,6 +784,22 @@ static const struct dmi_system_id kempld_dmi_table[] _=
_initconst =3D {
 		},
 		.driver_data =3D (void *)&kempld_platform_data_generic,
 		.callback =3D kempld_create_platform_device,
+	}, {
+		.ident =3D "A203",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "KBox A-203"),
+		},
+		.driver_data =3D (void *)&kempld_platform_data_generic,
+		.callback =3D kempld_create_platform_device,
+	}, {
+		.ident =3D "M4A1",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "COMe-m4AL"),
+		},
+		.driver_data =3D (void *)&kempld_platform_data_generic,
+		.callback =3D kempld_create_platform_device,
 	}, {
 		.ident =3D "MAL1",
 		.matches =3D {
@@ -775,6 +808,14 @@ static const struct dmi_system_id kempld_dmi_table[] _=
_initconst =3D {
 		},
 		.driver_data =3D (void *)&kempld_platform_data_generic,
 		.callback =3D kempld_create_platform_device,
+	}, {
+		.ident =3D "MAPL",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "mITX-APL"),
+		},
+		.driver_data =3D (void *)&kempld_platform_data_generic,
+		.callback =3D kempld_create_platform_device,
 	}, {
 		.ident =3D "MBR1",
 		.matches =3D {
@@ -823,6 +864,30 @@ static const struct dmi_system_id kempld_dmi_table[] _=
_initconst =3D {
 		},
 		.driver_data =3D (void *)&kempld_platform_data_generic,
 		.callback =3D kempld_create_platform_device,
+	}, {
+		.ident =3D "PAPL",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "pITX-APL"),
+		},
+		.driver_data =3D (void *)&kempld_platform_data_generic,
+		.callback =3D kempld_create_platform_device,
+	}, {
+		.ident =3D "SXAL",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "SMARC-sXAL"),
+		},
+		.driver_data =3D (void *)&kempld_platform_data_generic,
+		.callback =3D kempld_create_platform_device,
+	}, {
+		.ident =3D "SXAL4",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "SMARC-sXA4"),
+		},
+		.driver_data =3D (void *)&kempld_platform_data_generic,
+		.callback =3D kempld_create_platform_device,
 	}, {
 		.ident =3D "UNP1",
 		.matches =3D {
@@ -863,8 +928,7 @@ static const struct dmi_system_id kempld_dmi_table[] __=
initconst =3D {
 		},
 		.driver_data =3D (void *)&kempld_platform_data_generic,
 		.callback =3D kempld_create_platform_device,
-	},
-	{
+	}, {
 		.ident =3D "UTH6",
 		.matches =3D {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
@@ -872,6 +936,14 @@ static const struct dmi_system_id kempld_dmi_table[] _=
_initconst =3D {
 		},
 		.driver_data =3D (void *)&kempld_platform_data_generic,
 		.callback =3D kempld_create_platform_device,
+	}, {
+		.ident =3D "Q7AL",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "Qseven-Q7AL"),
+		},
+		.driver_data =3D (void *)&kempld_platform_data_generic,
+		.callback =3D kempld_create_platform_device,
 	},
 	{}
 };
--=20
2.25.1

