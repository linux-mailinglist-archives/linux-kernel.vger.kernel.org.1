Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC327FCAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbgJAJwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:52:50 -0400
Received: from mail-eopbgr00104.outbound.protection.outlook.com ([40.107.0.104]:59679
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731067AbgJAJwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:52:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeFVLGuVx10C6fnKfZrrWZ848NZk9J/DC6opHPVZxgpkotXcDELpUJISJWNcS5D+snFghVahyO82eUqEBssZAzFkOqNv1zu11VSE94Tpb2YWV3YcZMLXmrIvkP7LZsoxlJp8HMKU5P2ik9aAGhilZDGszRkynTCfMm6+mdUfcpYC9TvmgZwkTFCG+z99ArtNgL9DcX9OlB+AtNvod2bn3apmjYP/hgQsYessoKo6GN5fmvGG4E5JIKP/uCp3k/V8m3hBUBuZr7Nw4YBwgEdSbEfjcYY56FqCgDeoYTsFdaI6LuC4kTD484rB1zKKYOCiECw/YzoHnbuwAO3W0FJfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdf0TTzNeLIE0H33RBB+tCI0qQINCctH7jMUrbPX5yE=;
 b=SeHZtoCbuxs4WWdvs0b7jTudUxU0303v2MyWvont5ycodq0QOxVNpms0I5CIaKLJGk9qlrHbh1fZ9HHa9ziur12heIWLmZi8BQUldjU79KWPHBwLRgosQudGf9X4aJr1DDhrVft7oG9YzBOsMD1Ts4WQCqI+oe6OWQtGcHk2RLwiwy4g0mQk4rfChi74NUTQ0fpxRE4iLAjnJJ/QKenFCiUkJnrPUSkiPgfsi4ZQZUgxZCuZsv6/5O66Q0TMF7P5bgn/FMKyekOTbdfvzykNRqVpU2/l0ND1tXrkFkjRdIk6E1KzWnoigEcl45dWHvzcqT1gFFIHuXCiiDhZ7+ZRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdf0TTzNeLIE0H33RBB+tCI0qQINCctH7jMUrbPX5yE=;
 b=Geg24OJ5o/kJv+L2y6nWU99SdmFiKeHiMFK1i1zExjmcACeZeVV1W1IFYMUsyxZ+ykQj9XmVJAvKFPfS8QxeUZzGzByoVFNH9rnoVoJCMYcY9ENuoYu8JroUaEqXLXbsz3Tt/xGYUPQmHwvjaIEvDvWTtf1Sx9kqlke7GiAshjo=
Received: from AM8PR10MB4066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::23)
 by AM0PR10MB3283.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Thu, 1 Oct
 2020 09:52:46 +0000
Received: from AM8PR10MB4066.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4d9:7d25:3bc9:603c]) by AM8PR10MB4066.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4d9:7d25:3bc9:603c%7]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 09:52:46 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: kempld-core: Mark kempld-acpi_table as __maybe_unused
Thread-Topic: [PATCH] mfd: kempld-core: Mark kempld-acpi_table as
 __maybe_unused
Thread-Index: AQHWl9idDQYeZ/9tfUC7Hluf7RcAMw==
Date:   Thu, 1 Oct 2020 09:52:46 +0000
Message-ID: <37c55c13f9042dde06fd67c829b06765286d0580.camel@kontron.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc94a1bb-5ebd-44f1-6c33-08d865efbfde
x-ms-traffictypediagnostic: AM0PR10MB3283:
x-microsoft-antispam-prvs: <AM0PR10MB32833E20B63BEDE6F562F28FE3300@AM0PR10MB3283.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNISd/u6CpsmklZN4xsK0/xF5DkTQ57+uty05M1JanveD8t7pnDCO6/gb0ZvLH63e/ZoLaBwEGiBs+IBI3lvq9NoPHTKRKXtUytsXLJZbWDUviXJf5dQ5gLNPevDC9C5MX9XmOlwNPoCoEvKm7ldECED4r+luhDnfuQTSFjnR7R/z+Pvoi/KSPmW9zgnhzxVpd5DEaFbXDsdN5g/YzFFXpS3iE42t1TQJxYxp/SDo4f0M3egg3w2oZFxMVWnEVEtunWk6o9EYyyEDEq1xTD5yzNq4ADAgWNT21aABDyaIrtUyAB66829Zyzldv23fzvNxhIOKywq3xhJloeGiXUlSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4066.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(26005)(6512007)(2906002)(76116006)(83380400001)(71200400001)(8676002)(186003)(4326008)(5660300002)(66476007)(36756003)(6916009)(2616005)(316002)(54906003)(8936002)(66446008)(64756008)(86362001)(66556008)(6506007)(6486002)(66946007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bvfsGSffZPatKJ7PRFuqAxv2fVw+C9gtvLZeKb21HrBFOkdLE90ipXpu0vHGmxjt2JwXOL2yJ3N5DwemTb9BkFh87QY0jJ5UJp248JaNuEnSqmSm6RImmf+GxMO/j2xUBh9sFMBwjn8n/s9DMZSEcAaMx1FEiqaNWLL0dfpbY7RvtJCUq77ErUOotH6cZ3fISoGSOxmMBKUPoEQn98NQvtbWE90IB11VO/0Yqto/o/0afBa0cK1HVORBcgUrw1Jikm9aGvb7twxJ8VFlHP6mYq4o9B1CCB0Zb2XKN3GbltKOyyiGHokQ8WUprZ+oOF0boWDWCIQyvthLi0bm+8tK1ofy6zc3hQFNpcRzHDptY8dk/pSojGuxvYgWt949GGP64PCOWrUfbwsZJmsDAkYIQEqwO1IlVWbEnZ0ICOWgCblRLUZMPV7JQY/P9VtaVibNUteuOVfl8IdtffC2I5rxZWM9GievyAnIMNHnyPUV3fam7LfA6DU21eX5s4+FVFhvSEGBTD/O2q5GKZlBj5B0n6COfpbOzabIFOzuK14zn5djtDbXghCeTVVvroLzjIoapAX12xJzflxxZZKZt3DdZevq5Y2fEZRRpJwld6//GQhkg3GFKesweJ+tISuXNAbQXxOVC2Lr60pzFtFlaqD7ug==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <33664278AECA684C9A7C75AB3412BABA@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4066.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dc94a1bb-5ebd-44f1-6c33-08d865efbfde
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 09:52:46.1866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U38Wni651PbsyBi+jZh0P39V276jZPa7rhnc39HRygqufsePF+EBoSiA5zkXnc8Wx96r0Ibjxl/7fLuyW0HGTZ4a2iVxsYEU8eIxp26oCYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3283
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel 0-DAY CI Kernel Test Service reports an unused variable
warning when compiling with clang for PowerPC:

>> drivers/mfd/kempld-core.c:556:36: warning: unused variable 'kempld_acpi_=
table' [-Wunused-const-variable]
   static const struct acpi_device_id kempld_acpi_table[] =3D {

The issue can be fixed by marking kempld_acpi_table as __maybe_unused.

Fixes: e8299c7313af ("[PATCH] mfd: Add ACPI support to Kontron PLD driver")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
---
 drivers/mfd/kempld-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 1dfe556df038..273481dfaad4 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -553,7 +553,7 @@ static int kempld_remove(struct platform_device *pdev)
 	return 0;
 }
=20
-static const struct acpi_device_id kempld_acpi_table[] =3D {
+static const struct acpi_device_id __maybe_unused kempld_acpi_table[] =3D =
{
 	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
 	{}
 };
--=20
2.25.1

