Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC02B5BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgKQJcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:32:02 -0500
Received: from mail-eopbgr80124.outbound.protection.outlook.com ([40.107.8.124]:5283
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726853AbgKQJcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:32:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjBiE2NzCuQu8o2IGCCb5WF+jSyEZtnXvWkvfOlBnpiSV63k7p/vAmpieHrip5hC3leIgp40jMjK8N8YlyfEgo/sSWCysv3fvItPS9jxeREaGrJbPuT43NhAe0JIC/UOXzV/RnS5lqeiggHK+xjBtP4PGxdaxCBNIaoyZwmbZQfugyNw++434jKKh66vCEE297mKpkepFDxSKFL+1hxQAqTZpSv4eTlU56FC3ekZ5FI+j5RgNny/yzNV5G2h91TjQ58I/CCOlLf9BSzQvprDSavC0/oPKnjlS+XTv8tZbKimsDS7pfkb8gHYq7Iwgr2Yhst2+lgtNSLqPQnfU/sDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn7RlMRSU6pLElXTKkI4aGI2VJ6hdXwyTjMZoWCBPL0=;
 b=IUqnKm4vScoZ1CPDNcOVSwhYijuRkc2EABOu7Wi7aAzlDeKB2x5a6VaSuKcD2RewbDwTPDXU3jygK+HHfoFzWBuJuIsdGTSTFJ8GVJWtSBzQIjGsn1rX9V476xz3Ip3Yy6ggBJovl+4qVEXXqN/qdtFBiRz+nC8kzqhGThLmJ1JUErSfmbqoc1LFNRjwq8Uo4CCuFJVuh5f8eH2Df7Pi/6OaUel8P8EkzL9YLkfuNPaZAfnPrNHL2xn2wo6S5YoA80UzzH76kDTcuqpMhA/BRrxFG4tMAd0rxQQymhaCzBObyDW0s/EgPa+mLTvmY/JkuaghAJk2JifS78kwVyZKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn7RlMRSU6pLElXTKkI4aGI2VJ6hdXwyTjMZoWCBPL0=;
 b=dOmHZRXkqMsI0/kdo1DPysVnFSl02dI/9Emarycwf34qXBtsolBBK5/AJ9YrwTkXCAj3bUNmQxOzuSbIuEMUTPBeF4q0YZMAzwW76VlY9S1VR8bj86+tuPkFsNswcjwa08ExdhwMxW7bsoFcVROlyK7LK8v7KWgCIy1ynTw0Dvc=
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::29)
 by AM0PR10MB2209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 09:31:55 +0000
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887]) by AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887%6]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 09:31:55 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: kempld-core: Add support for additional devices
Thread-Topic: [PATCH] mfd: kempld-core: Add support for additional devices
Thread-Index: AQHWvMR9xprY6L7MJ0eowbJbdpiLwg==
Date:   Tue, 17 Nov 2020 09:31:55 +0000
Message-ID: <0474e39790ab7351b1b11b565b995b94d49fb87c.camel@kontron.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deba8acf-62f2-43f1-0d58-08d88adb9fb5
x-ms-traffictypediagnostic: AM0PR10MB2209:
x-microsoft-antispam-prvs: <AM0PR10MB2209F2C818A6FC835AF9CAE0E3E20@AM0PR10MB2209.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56hDVxbEta6VDa1YtVyYFqaYem/JhfoQEdjCnXJ4zVnF3AFvlh770IHpmwf8mPOVn5uAVnKQSNnxKrekNgEEpfeUplgQ39obXNqQKoBUmYZIiDn2wTsVBsjXxZfT1u/FZIcyFhB+mu6W9LtmuYfuaMq38LUE7Xxdh9uvGDbyyuYTarvV9s2Drladf+SH4YHbRc1JurQ0CmhB8Tiu9iG5cFZf5rEfTMLAYGgsBt+W2rpDNwVopmK4I9eSsu5kvAhV8nFYxUwBe76ZbEPTssxyyHIgZoeYOxy8OTDBIIoP7CkAvktxOuClvWg13Ecb/vnvGLHh3XgI/4EmXkWFHcz2EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(5660300002)(71200400001)(186003)(2616005)(86362001)(4326008)(91956017)(76116006)(66946007)(66556008)(6506007)(66446008)(66476007)(36756003)(26005)(2906002)(64756008)(6916009)(6512007)(8676002)(6486002)(54906003)(316002)(83380400001)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /Q1iU/hW7w4OA3Qv7LhOKUJ4OEFYHlnBADL61UqT/LpfDK76CPgn+/UZguhrCFULAM4WdNV+z+qYBuSCBb5tOiec86I0IRfMSM4eyNEchOYf0smTFALbpOYG0qclqNLTm9pXjutWN5D+jHAwfnf0IyEGuNBdf5tug9S5cJ0qztYUAQSzjbZawaIluKWYypVo7nHEMKpzcqMo9CL2mfRpBI58m+4VsAXe7gnM+70T8yZl9PjPyv69+QQaZtklaiePcn8v5JvjaPPuc5HRqYyEDEMmIXSGcZsn6hbtcsSHxt35yKIIiyLmwHEYqVCwAI6os/KzSAJpp01vIteIhNM8kOZJB3R8yhDEWkVTkb/l6JYQJMldy5464H49SjiayQ/4gSXh97f0YOHyouEsBbOMz4YhrgM0cJpy3bz2R2m9CykIHkDLWcGiju7vSrHxe2Licunr7hJFMHOThOyQdRe4B4mJ54tO4laW5NtNVcZpvNNuJAd2Y3FO3s/NRJw54f1RoGAK66cEA938TQZjKadi7pDUgQDhfQJ6vF6fzMXCKMgWLsGucjpProJbAsXmiZaWjv6PdiCbN1ubDZQm4IP0sWLik9sswRBeR2eL5LEuud8RUgMKbL+cuYu/zdutUNNipcqold2BY7jB3CHTONiS7FpMqxgob35pgZpmo4jyCblFwDeLsnZxdjgTrgnhpAa5zh9S/YdmBsqQkbOizQP2WPKbWPePfE3a+fhrk6mpwDqZi9aFVxvUOgUK4le2768Ghmx9V0AqbHKL4DRk48KtgPwgmQxg3JnkdfR5ITnHbyVHAyKcVneA0mh04V5LL7neiH2qS7Q/k9MbL3Ml32HBSRhTX0RgMtCOjz7xicLQzbnCPgAqIR9uzDcLp3hn3n0masau6ACUdTpY/VhJQ0CvOA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <3CE374EDFED8874C895499CDBEA49D47@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: deba8acf-62f2-43f1-0d58-08d88adb9fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 09:31:55.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jICfSdvoZCk6RPIjzkIsgUG/7bi1hUWZ14PSsZE9NZ1SQs5E0GY+84iAwmf9XeER8UZdfew50G/Y+x06K47pvn90onDlVsSTlHHWuD+TN6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2209
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
index ecd26271b9a4..4ea0ecd45324 100644
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
+		.ident =3D "KBOXA203",
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
+		.ident =3D "MITXAPL",
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
+		.ident =3D "PITXAPL",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
+			DMI_MATCH(DMI_BOARD_NAME, "COMe-mCT"),
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

