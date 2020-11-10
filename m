Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD6A2AD0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgKJHqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:46:53 -0500
Received: from mail-vi1eur05on2112.outbound.protection.outlook.com ([40.107.21.112]:47232
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726849AbgKJHqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:46:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGksPsv2cY5e74WD98YrZ9Ox4EESfiGxPK7ebU81UfAH+tV0W01Vi0kqeZGsgYyj2I6a6RzRvwdBh8JL2v1EUe1KqlYIfopbYGtEG9kgQDzqsD30KyMhaDSDuowtWBlwe570Yz1mmnpJygzutYe65rLCwCCCG8VKAGODOlXuGBrz0TycMP7q4lAjZHOQZ5wGax4VJzKiy037LLeA2KQRkizlG4IxAc/NYaWtEb4gZlsoif3a8m63ZcOH3ExyjLEw2jFtjFuaXfZRuCHI0YmN5pK+BWYbx1kVurK4Gz8bbOVQDkWRVpw1MGE/zeKsgH+GTybrRn1WiRZM+KVM0MEc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz8xVzQqkk9LAp616Gq4lGoeV3MCt3nyDcSp3MBE4RA=;
 b=d97Khp4QMWPs/mbDbMAA5TbExVBZfaDQ8wgfR/28dJjqcu3gBosuO/HNjqB6+W6r+FKIfBh5JmltRyCoawv4mQqB61GXJTiaR8Ne7xzGo9g6iGhYmW0+5WO5VhjjDHZrIwJoDyjKV2yqqGtM+v9ktIWjJbI2WS7oZWI3EcRAj9XKmqPO76PIy+waZlTKKABw6YvDE+NpqpSjX6oN5Go6om6RJzV5htEVzkdMIu/0xeXlb5wDkGRJa+o0Ya/r0lN82/kCbz7V0kRtGp4DwiuzePyEKkZ7cneaoHgb4n317n9xHGb7UT4Xo6YxMv6aTVKCEtXmtotVJlAcegdFnIRKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz8xVzQqkk9LAp616Gq4lGoeV3MCt3nyDcSp3MBE4RA=;
 b=SvIevHT73vSEsaYYfJsgvbZUpdVCMnj8sB9keDG0zx24lSFRWp4tKJgYAaBwvzJO7GN7twa6gsAZrKlfX0wruM6BVt4fkYVRa2IW7LMqiArZNctUfXwvpvn3OxOoPpH+19ltpeRMWvwRPQNiCiqnSBvDqzLvWB6E2nYFMXE7D68=
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::29)
 by AM0PR10MB3715.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 10 Nov
 2020 07:46:48 +0000
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887]) by AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887%6]) with mapi id 15.20.3541.022; Tue, 10 Nov 2020
 07:46:48 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: [PATCH] mfd: kempld-core: Check for DMI definition before ACPI
Thread-Topic: [PATCH] mfd: kempld-core: Check for DMI definition before ACPI
Thread-Index: AQHWtzWk3mu/iHMWGUeZlaHx0+OPBA==
Date:   Tue, 10 Nov 2020 07:46:48 +0000
Message-ID: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1956cd9d-3a3e-45fc-8a1a-08d8854cc78e
x-ms-traffictypediagnostic: AM0PR10MB3715:
x-microsoft-antispam-prvs: <AM0PR10MB3715CC27228C5A7AA6295B92E3E90@AM0PR10MB3715.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hrLEXHJ32hHqzeYAQDAoUTN5T6U1O9FIjSCIBtOWevf3FHjHT1H4f+XBmPhS8CeHs12lZNYmV/o9gIGq0z3qUqPfIuJ5gyqsPvn8ihcJGJ6S0Ohhx1gtGklSU6fDExpL5Qw1NnQakoww8zYiBKZcAFAlW1lCIcWmdst39dFLmWRbnqhyJyUrTnHPYbh5kQk/9K/dvbHM5WCBm1rn4iFYh90Byo3KtTEOZldIGNZnVvotqfeQXn7fFaExu/SyopMbEvnfw6w3bt1fFo0dTescrPQhsz5CMRswXv/inv1xr42gMSmgF9WCDyURqdEsjztGxaCkB7ROTl2ulrYqZTPOZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39850400004)(376002)(36756003)(71200400001)(186003)(26005)(316002)(2616005)(54906003)(6506007)(2906002)(4326008)(86362001)(6486002)(66556008)(91956017)(478600001)(76116006)(5660300002)(64756008)(6916009)(6512007)(8676002)(66476007)(66946007)(66446008)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GA3uJFvN1M4qAazrCHHK16dL3dIyJxP2P1pU/M0/kqn13XUjGgApWVlMP7aDZUvW8xU3rdifoUUcwvHB6njj7ZIVyTXagDElAAO5YcU5HguULcDH21xxXIQEnfpeB42X8NN+QBjGchE2VrRqLy2j+DShNqib2wqUIF53BLq7ir1Ex+UKkGYMotSlZVJwMCh0x/brsBhQS9VeTjjYHsFv3AdZOTRgFnZM0FNtaIFdoZySF079BGL0XGXd31RgsMkRiRj78wdgxWPMODyP/+No5p5SjmI37CCBHTvhpWBIxR6ZakTZ4uEqGwNfjf50KK8iI4fy0h0x45HUhkFKJD8N3bOssuqWTy2/peiseAgFuyLoCYnZAIVOcXy+pKo77XiCmIBqYWl+Ae1V1uQPTrIXroIP6MGRIUK7MLAi+PezuAD2lz16lRpDrpb1z6I/lPKqFDR9f7oEeAnKI2Z+GRHMdLQKAiZfvj2q+igueWXQPKeqjHydbF/k6ibWIg8pQZmwuhMJ+FoEG7Uda2wx24yq6yQxpm7xgaZfpmaDSkTeCjcZagCcLSrj9pQsSdU00rDm24kU46NedQvO2l2E0S/Gm2sldzTeDKS42JDK7WqGs4e+igFI/xKaUuuzRR4aEOmhc14rWIkWs6/HyrHvZX2+fW7oDs6sh/G07O2Fs/mgjgmiBVV1HljleD2lG9uAXmaWTIfx2TJJVpip9ntsOJG4aR96naMydazO6szktboNHQWwHix4oRACpkWWe+DYz0la5sfqGUO6LvIO1n/IQMlqcW3g6AtkbHv8XL5vlT4SCCuS1XE1m5UJ59XfIjLnwgMAi+/URXI34dyAykVnINzaMp2jWdIhf1LMbqFrFnsPWGOVEu6r+jNUj5FqH+X9ZNcUl6yy4sB/LW/7+fTY3E5bxQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <7724A8B3BAC13E47ADD67766478FC24C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1956cd9d-3a3e-45fc-8a1a-08d8854cc78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 07:46:48.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ltCZrWNwufdSP+2r19Y8T1iBc6bbAoJmhhZFckKMqJcoPGQUq/lGm9+uRp/5s9yrnHa9Ty2YFjzUDUz2/2nUE65awdziZDVNpNpahutOhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3715
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the detection order to priorize DMI table entries over available
ACPI entries.

This makes it more easy for product developers to patch product specific
handling into the driver.
Furthermore it allows to simplify the implementation a bit and
especially to remove the need to force synchronous probing.

Based on the following commit introduced with v5.10-rc1:
commit e8299c7313af ("mfd: Add ACPI support to Kontron PLD driver")

Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
---
 drivers/mfd/kempld-core.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 2c9295953c11..aa7f386646a1 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -125,7 +125,6 @@ static const struct kempld_platform_data kempld_platfor=
m_data_generic =3D {
 };
=20
 static struct platform_device *kempld_pdev;
-static bool kempld_acpi_mode;
=20
 static int kempld_create_platform_device(const struct dmi_system_id *id)
 {
@@ -501,8 +500,6 @@ static int kempld_probe(struct platform_device *pdev)
 		ret =3D kempld_get_acpi_data(pdev);
 		if (ret)
 			return ret;
-
-		kempld_acpi_mode =3D true;
 	} else if (kempld_pdev !=3D pdev) {
 		/*
 		 * The platform device we are probing is not the one we
@@ -565,7 +562,6 @@ static struct platform_driver kempld_driver =3D {
 	.driver		=3D {
 		.name	=3D "kempld",
 		.acpi_match_table =3D ACPI_PTR(kempld_acpi_table),
-		.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
 	},
 	.probe		=3D kempld_probe,
 	.remove		=3D kempld_remove,
@@ -884,7 +880,6 @@ MODULE_DEVICE_TABLE(dmi, kempld_dmi_table);
 static int __init kempld_init(void)
 {
 	const struct dmi_system_id *id;
-	int ret;
=20
 	if (force_device_id[0]) {
 		for (id =3D kempld_dmi_table;
@@ -894,24 +889,10 @@ static int __init kempld_init(void)
 					break;
 		if (id->matches[0].slot =3D=3D DMI_NONE)
 			return -ENODEV;
-	}
-
-	ret =3D platform_driver_register(&kempld_driver);
-	if (ret)
-		return ret;
-
-	/*
-	 * With synchronous probing the device should already be probed now.
-	 * If no device id is forced and also no ACPI definition for the
-	 * device was found, scan DMI table as fallback.
-	 *
-	 * If drivers_autoprobing is disabled and the device is found here,
-	 * only that device can be bound manually later.
-	 */
-	if (!kempld_pdev && !kempld_acpi_mode)
+	} else
 		dmi_check_system(kempld_dmi_table);
=20
-	return 0;
+	return platform_driver_register(&kempld_driver);
 }
=20
 static void __exit kempld_exit(void)
--=20
2.25.1

