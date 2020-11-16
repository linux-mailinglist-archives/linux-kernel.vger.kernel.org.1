Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E181D2B3D38
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgKPGmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:42:36 -0500
Received: from mail-eopbgr20128.outbound.protection.outlook.com ([40.107.2.128]:37929
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgKPGmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:42:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlNbID7ehU5FVHbYp2PsLTTwgEextz/TllhMlk6TZbbhES8KlDTpQy0EfAJc75LxA1iXNJGZuEOl1A1SGmxXmbKUSIXFHsRfkLuIDKu4tbsdY4qBwSGJ1AcJhiguT1o9oZg81l7Pk1SfJOhFs0Z8PF1kgyb4bj7NBUov08n6uaH3yOOgjhJv0xERU6x5ekr/121kCPxKzNQDVE6gNsk1H7vl/ItcTfQuWYsbAEAvdcTQEkpcTpST4O2/g0DJQg+J74mcEx+i+1wub9cyLSrWmTHhyQFjzsShDteFsyF+8dsXKHQNnxufIrNySfehpOjPhYu7cIqSTj4AVak1wmVNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83kNM5iSHIRUgRaoar08ICHR5xmf/8pDr2AGBEYMdoE=;
 b=m+eeQeTNzzhKMkxrS5myXP4mp1+CR0VUJn8PiZqV2tOtdHbQdgl9Hkp63IqWOuLqDo4cS3hMRmDlwZyNxsqwyDgMUrh21v474f5dovtjFmmMiWGQAT2gt0CzgDr9TXZJK1sA/C1lPalVItcjYnsNj1ZBzjxIMaaIC2H+sur4ZYR2/7ZWx3IkLgvKl+B7udBcOOwMQPSKbm+VmUGdNbRUXheGEPZVY1+zEAxCCXIt/O+qVQZKl981TNLm0Rte7afOwu6Pv557/cC9UsnZq6jdP/6KyyfLkaV4Gz8J85AEAAxh2v+lZsW+rLTwESD1GHGGtAoVmm3H8fjvQ5OSinjpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83kNM5iSHIRUgRaoar08ICHR5xmf/8pDr2AGBEYMdoE=;
 b=S0n67Jk1Cxu05XUku6tD9kperggX1PcG+fBspoRUiRLtMIW0dseER67L1DtJydfZwoWMyM0OTDE223bYBYSf8pL5URguMM8qMULPHnn8aQFF6RWv+U4koKCXAaJPnK/Tc1cM5r2ZaR2b6Thq6yNJCgEoTHJDiHGsX7pgHx9+Jcs=
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::29)
 by AM9PR10MB4230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 06:42:28 +0000
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887]) by AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887%6]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 06:42:26 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: [PATCH v3] mfd: kempld-core: Check for DMI definition before ACPI
Thread-Topic: [PATCH v3] mfd: kempld-core: Check for DMI definition before
 ACPI
Thread-Index: AQHWu+OkIu811TJCPUavMPQe+vS/Xg==
Date:   Mon, 16 Nov 2020 06:42:24 +0000
Message-ID: <ca31b0f1638d07f5c597c652ed887a3ce0f595aa.camel@kontron.com>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
         <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
In-Reply-To: <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44766c39-65e7-4179-89fe-08d889fac83f
x-ms-traffictypediagnostic: AM9PR10MB4230:
x-microsoft-antispam-prvs: <AM9PR10MB4230B5A7135790401526D46AE3E30@AM9PR10MB4230.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZopaRveoC5Mo8zIbHQxGSt1erQLfiuSmrf/TO182yruZa/Ycqna7GmvXSrH5/fFszF8yio/5usH09OQucsMYohDtPecrY3sHr/ulJlwTeX9irlzLiB38ieLkhYbp0ZlXdB7soYjdQrPvvUBf3YeuMVc2prqS6pbLCLJi4EvuROejp/ujvsh4EhnCWhuZKfssRot75F7AmlMDBIYyT3HZ6IOf/ZemwRblWS6WczPUQvfxi4rV4CaQB8RZPofkrtsBA1kSL01S1zBpkz1f8irQJ813Yv9T5PUJBK3KEHbSSGv2vohaq1MMSfITEPKv8LI5mueytpa6aLCvf1PLeWgZEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39850400004)(366004)(396003)(6512007)(76116006)(91956017)(478600001)(316002)(66946007)(36756003)(2906002)(66476007)(64756008)(66446008)(66556008)(54906003)(71200400001)(6486002)(83380400001)(4326008)(2616005)(5660300002)(8936002)(186003)(26005)(8676002)(6916009)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CmpU5X5LRKi8qWp9fMHysa0GrCRoftNB8A3Xv/jSlTRZ2bjHV+EYDDiofiuhToT9UB4BT1u71K1QjvZW4s+GLcTxFMcwJ3HrgflY2+1iSYKGF/QKTUaQgfiV4+VrpykOof6qhVdo5TWmftTezOsRNHYpTAs0TulEo5E2JeMy81PCrMK/hGe4yDfCkTWBwXCoX8dvPCPIthX4rIfCgpQNdcHhmlbAJaA0bJSNEEo3fqQcwlZ+ubPYJzoAdSKs5Z8/ZEWEBcUqpkXtgNUsc/ouxJGa2oNSVOU0Uyi/XcodBesibxIY2FqLnbmrK2AaBnnVXxmluF60kXewMnou2DiQpRwdKDn3QFYnZLdUlHetZyZJv22ofKmMkdzjkNyOA14uOkBwFTNpugH37LlswYi5IOsx2Ik7xa0ILrUovGLrHKt7adY5IK3ttMtYee+ZMlMlluOb6LuS0Rbg9udkpbvdjti8fE0aA5RdHIroZASvbHt6gQFbcTFDW0Z1xjGIUwpAhJE+FoQ7h+lCyYJVRFbQMUgZoIh52z+Ogmq9Qg8I1qvNNAddjAU0XsAeVC/kIVcLo5+Qi13t2ajXKyRZfWj0YBsQN2Lswf7cznzxJDEhwCQQkL4PZHkUxkSblzWZmFYfa6rU7WtW94R9nl16kd26Xyp3faJDPeJ8wrjmtWbt2JdPJlsqSBwHL5lBjxkvSYyLQL1xodzkJhEsflJ4u5d7Ea4e/g790VDvfK7uflgigx6BfB7U5eeTpILQYPh6Fm4PjgGOoehXSxKh2G3WbQnN7aL5/FH/jiaGOElDIdrGEemZEsvmCnUwiF+MxNkS41C96C/iuMMkcOQnDkt1RPKyiJuoiVsFSYIhasxGIOpQtuZv5ifDjOqXnruib1o38QVpg7T8SmgyrIfKmJk+MIpyWA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <815A32B513DF774987D951E9FBAA7706@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 44766c39-65e7-4179-89fe-08d889fac83f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 06:42:26.5522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jK751vGs+fZaBZkorAIF/Ru1Uf7P48TxiY22+L4ySFtRvv7Ikv17RTIwTj8CZYOoZAFjSDa3gOaHsrizm5IUg6FlAegPGfQ692fmYgsxHUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4230
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the detection order to priorize DMI table entries over available
ACPI entries.

This makes it more easy for product developers to patch product specific
handling into the driver.
Furthermore it allows to simplify the implementation a bit and
especially to remove the need to force synchronous probing.

Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

v3: Cleaned up comment, added Reviewed-by

 drivers/mfd/kempld-core.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 2c9295953c11..ecd26271b9a4 100644
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
@@ -894,24 +889,11 @@ static int __init kempld_init(void)
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
+	} else {
 		dmi_check_system(kempld_dmi_table);
+	}
=20
-	return 0;
+	return platform_driver_register(&kempld_driver);
 }
=20
 static void __exit kempld_exit(void)
--=20
2.25.1

