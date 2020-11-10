Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CBF2ADA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbgKJPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:23:25 -0500
Received: from mail-eopbgr60118.outbound.protection.outlook.com ([40.107.6.118]:58349
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730368AbgKJPXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:23:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYTV4msY65SNCALJbs/IPLxniWyAuaiJPlyS1pT9hoX+EuSK4P6ZVEz9a6aY+rKtyp33t6n3RBQk8WWjSH6OJDtKPsNzlQ+iTBYeZ+79HVfSB8LUhvnC2UxXdvukM/TQC1A0tUqFa20MhEz+YbMa8+x+gR/wxm5fboNKJER4aaHB6NMQVy3Gp5137qmxw9o+0lQ4vsyC2+GU5DkvY62XN+aCmfw+Nhv2Ti/8IOfdoJe2d3WETJE8JyWGay6FC5THokT7ji6xdN18MIWxL1yRgssgznyAu6Nl0UyxN+eA7bDGhYuP67//EH0BDPp39sMeqZMyNR0hxPLloj9AEeVlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNucDwXLJuDWCOPS7x4q+A0AZcHoymZqCkKSpFKDnH0=;
 b=CywxSgEf+w4L2g1INauszPKPsN1eAW2ABmNxf65eEWzE4bPkXH/o4mn4m+ZjivTpOeJEM/Q98dggUshClXMuw0QxCjW4p+88DmaW2cmi26PvE80dWP2hr2iL6tqsex0LtpkiMgDFjBdu87+CQVhw+TjCj8rMCAE/cjIEGto8Z6cMqsxkSx24q5SmmkafRKkUeTm5sbrdnW+yncJs1Qp0ISoZY7Iid44Vx5RzUmIjNT6LrODegiCOLG7OGUyGpxJuqEy93dTEmD7/GPUUCuXMdqG/nFsOJDdjfF8LzG6NmLR9xR/Ixsdd8Z9J6CgF5rAeifG58FxNIgRygqYY1q/jIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNucDwXLJuDWCOPS7x4q+A0AZcHoymZqCkKSpFKDnH0=;
 b=nxucrICIXnliNXa1c2TU42KVcFgKJyof0w0cZ2Cl4uDK4VWIP/0Lt+/Gb2MfAK8ZcCPxUzxiJN9iUmCJA/51W3UeU8j+ftG/9/MwQFCcZOvL9aeSkAZzKmWQ1nd9tQGSb4vOFTHX9MXX/GhTOrvEXlgj+Tg9Fs20mVjQtfNvOcc=
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::29)
 by AM9PR10MB4417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 15:23:22 +0000
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887]) by AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887%6]) with mapi id 15.20.3541.022; Tue, 10 Nov 2020
 15:23:22 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: [PATCH v2] mfd: kempld-core: Check for DMI definition before ACPI
Thread-Topic: [PATCH v2] mfd: kempld-core: Check for DMI definition before
 ACPI
Thread-Index: AQHWt3VsEBqb6T2PvkCar7YtrCX9HQ==
Date:   Tue, 10 Nov 2020 15:23:21 +0000
Message-ID: <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
In-Reply-To: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e62b63c-266e-48cf-b271-08d8858c8f5e
x-ms-traffictypediagnostic: AM9PR10MB4417:
x-microsoft-antispam-prvs: <AM9PR10MB44172F8B0C813A5405FC933BE3E90@AM9PR10MB4417.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Veg46npR+yeohDG4kmmKavxHBEs3hGNk6FiKSdOpTxzapPRvXdABPQ7tGmlG0pC7NUk5M7/DouzZmsOCir5JGLEVJDWhD2IJR6qdCq30nCjid0mgnl0pERTciMzNY9e5wPWQncJEFdYmP3/lysVqO6f8oV8rwbqFMRfNxUsXpH2pM0TRUb6nFtkaKygYfuKeTji4imShXrQbVMVmfylZCDtNNO1UrVRvL9WKsfRedgOXkE5UtB2sSGz9XIwmllexZw55mczIeUrZNAZ7oxwPMSGPh2ErCTkDyXjZHyfFTQw1aEvsKNIGtgC6A9VbS5Dgpawpokvs9wLgUUIF0QL+9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(376002)(396003)(346002)(26005)(5660300002)(76116006)(186003)(54906003)(36756003)(6512007)(8936002)(66946007)(6506007)(86362001)(83380400001)(2616005)(91956017)(8676002)(6486002)(478600001)(71200400001)(66476007)(64756008)(4326008)(66556008)(66446008)(2906002)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MJgTq2hiXCeYBbJRNTI4EIxKfzuj0V5wW7HtFRZpQpDXUwwXnhZtrZjCGFbLCbZqYG0dUVf1sjYXHLBX9HOoJPajVP6MNSMVJ6A10mD1z1rMhsttReNTJ94v3dDubrIblGZZNjANG80ejOqH/gR88zWfUtpePYIck/VFfrIIB6QTu89loqK486+DTMoZ1uq68MQF8edlFre2wjb6HPwBVNvECmERckE5on+ug8z4T6/s7WozPfjWWwvPsSYOv7Dk2pff3wWh5DJklWGrdsD40ro7K6eN0GEYMzWOrAKF2Aa5/rEY6PQHVQKXUAnNg+S9Cx8TA7qWY0UqQUM66ET4tKpP+4dJHgLoLrcDguaejecuAKhvrQSiP9+7fvhTv5GSIkUE5SrLX4+GSRg3tJ6VaN+9F3rAT0HgTjsWERsf828XdD0PuNFu4c1KMkSxA7F7Px6IDmegwWhjWvRGIUhEZca0VqHL6NkP9B4ZJRzvcsfKmAjFGzMZi4zlZB9LHbbrB+BQeI5tVem/t+bxVsjCTw1W4/0pbhMuyul4RikQlevI1KNChwRjDj5RgX23bOS3LzRNAcQ+reG3BfSpjsLeAhvc/qsY3mcqG1sh8+S3gJNYPYchtspoYTHlzv6gA5kAxipt9FLzxVcr+q22dOpTeMuKmpXUQyyjbQn+KHWiDyeVppBg7jCy7SU5rBVMvQXzKM7va1uWLj9ZjCihGajcMWkxrTfwCbWBGPfTmeObs7z0D5etyqHIn442wpj1Y911wamm8LGGGRHfsfJUR6sBZPbi/zRQvIaMTffZgIPaAWmxEQtqu7mud7HlPV9NuJBVzEZPzB8RNexudy1l2B5gsMNwJbal603N/Ktu+z8wb/xn2yYsY8X3qzKBypIkrbV1C1GNlykrbNZgWfKwNSbF/g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <DE0A88AFB39E684681ACBFEC9960CABB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e62b63c-266e-48cf-b271-08d8858c8f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 15:23:21.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHP4cSsQ/LlUxfcJDSxEWf6O5XuVc6kowubtkN6ECagVAu3gAiQPump5C2q9TH5J5AmdoUr25ZqkHpZE0DrmWWOR7BBydDVO84FgXCp0fJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4417
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

v2: Fixed coding style as suggested by Guenther Roeck

Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
---
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

