Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2122FDFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbhAUClu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:41:50 -0500
Received: from mail-eopbgr660087.outbound.protection.outlook.com ([40.107.66.87]:10320
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732731AbhATXuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:50:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0knbFjO+w2gUkrRCchFC5VOBBryAMWgia9sENVAcQEpHvLGYMI7V7a0BQn8hMBhteZCFow7T8AkZfB65LNCWY0p9p4h1MlxJJ4kJ4nLSf5kbxLtVGkaCrCUcvRL9q4HKGG/N/+okF2BhO2aadfabwc17RfxN0NQ5twk/rZDgTVBYSO79pSxWssJcqWnAMcdw0ba/0XwVIp4VX/nmfHoB1outIPOktEqHdZ8nS0EtwKY3X3tJHiih0EfiLqMU1ICMUO5n3kCkAc+99jsxmzQ8jhGjTDvJdPq71InG5S7VgYpXvhRuWblzig2BynRXeDgUuGQQKnBkF2QexGLTHacTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuk2c6iHeImrruiPP6AfiYMVFvIGf6D4qVeP0mx8g0k=;
 b=kiJUoYuPDZTPGgI6ytbN9H3dqAikZW/LSFZgW11RTQiNWv5r3k6VT8KSQEm1Ls9diKnGbXHBygOMFQaj7LwMoz8bYZ8as2jg/o3LVTG5yKT7RDdA1ayFVWD9I/87A8vTtZr8PjXK3Wz9aKk3DwmC8PBe1gmj4t6bFS27QYf1A90qAZyc6gOj8+AMb2NgaX+ALdohnSnWWTiEaDhRI9zEwONwjPUB+6TFetLU+xSHj35WjEa7Q24/LIblqxwxy/fKs6fO2zN393mPsB83orfcCE+l3dQ7374Y9KT993HTC7C3bVZqZJsrpzfU50UvqsGKQn0SI6gGL2xHPZc5/dt2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stfx.ca; dmarc=pass action=none header.from=stfx.ca; dkim=pass
 header.d=stfx.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stfxca.onmicrosoft.com; s=selector2-stfxca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuk2c6iHeImrruiPP6AfiYMVFvIGf6D4qVeP0mx8g0k=;
 b=dTsIjx3FdUFkm9h9mQ5gPoSIDjWzXm33LzHOntFzdl2WPvqV0NsIUlpsDO5FHoQZ5CbPtbNZoHsmzKOKRowLWvAA4X4tuIUsmAt9bPNDYKtEy7cbSeIczvwSHeyjcgdem6y+AYxXaHM5diA1lyNPb5LZP9Cn7/pEi2edBzExf2M=
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:17::19)
 by YTBPR01MB2367.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:1d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 20 Jan
 2021 23:49:38 +0000
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::807a:7935:d3ff:e93f]) by YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::807a:7935:d3ff:e93f%7]) with mapi id 15.20.3763.015; Wed, 20 Jan 2021
 23:49:38 +0000
From:   "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
To:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix the issue that the tick_nohz_get_sleep_length() function
 could return a negative value
Thread-Topic: [PATCH] fix the issue that the tick_nohz_get_sleep_length()
 function could return a negative value
Thread-Index: AQHW74aZwo6PzoiITE+MgNGZUUOG8A==
Date:   Wed, 20 Jan 2021 23:49:38 +0000
Message-ID: <YTBPR01MB3262A1EAA009500DF6DD2132C4A20@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=stfx.ca;
x-originating-ip: [24.89.210.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 349b1cda-c873-43e8-9db3-08d8bd9e0c9d
x-ms-traffictypediagnostic: YTBPR01MB2367:
x-microsoft-antispam-prvs: <YTBPR01MB2367300C9A9E20F77E4219F1C4A20@YTBPR01MB2367.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBXFlox5uAFPGRMSZEUd0/G8brYvlzHBRTPQhjfbZiOjWX3/jJWvI+uqr+ZQ2Mj2Q5LVpEDW7KwzoqGmMbdkK6YplWUwH64y0z6ctgRzBz7cKWQ0sCjasmYllvgzVqgf55wVsnFrdmApWvYRmpCi7dv8WyCyoaieSXwYqxylWJ9GKi0us9YLJIxVqAA8G+Qy8AwElr7QX7JxyfG/2NdT//+YJ9eiotUVzREGDokbHm4lYOknDIxKY2OaM2JjDZb6nyEEKCGPpgrPF3F8olbpLX15v0Tz9oIqKR8rG9aHpjyrXDDwOyKhJEPwjvgLLPWs6A4cwqiPkSl5ItrldMuRjkcSF0HIXT2cYPL4qAlFA7ISUshaJs6Za9KIc5lypgwx/PYxo5+Q0UTYNA9E+fKCuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(396003)(136003)(366004)(66446008)(66946007)(86362001)(66556008)(8936002)(8676002)(9686003)(33656002)(76116006)(66476007)(64756008)(55016002)(316002)(786003)(6506007)(26005)(478600001)(7696005)(71200400001)(110136005)(52536014)(186003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YCPgDWdSUvNwybe3mO1DjBI+sDnS7Ots1NAZWvVO6ZSa3KmUt0My4El4LcPjLg1pLKui7KpAuacukvryS5+lNmsbs9yU0KuguPG2EUnIgAu8zaExnP+w9tmmgLOXcEpDOSWgAqug+3D78AkhmiQ9DrXF3ZArlbSi1hSYucpYO/UpvVa0Vq5l/FFU0ewGcVAp0odo8tlASPjQRSzQ0rKvA1MgKMcvXpYqFHzTPvLvnf2oNfHGScr9Rr0CmiAVrvqmD0Q9sF49X2lgawynuS/nvmj5/msOP+mpjBUjI4w44LCFrPjE6RiGwArhKEPYOaOwYUMkZGATJqnC2nLo2HSV4iQHKFaXal2I7/w1Olp9Xsc3j30gibaDNAqvwo3juyfG7O3wYh/r7jCQhmLyfDaltOhE11j1gU61hVWdiz5fI6JkxHKW3XCgXyhgbp8N9F9Q+iJMXUS4EeSMD/wGJRe7Z/DWm+1atl9GjdrDqNye6V7p9anXx4daqyEoYfdQo7p7cb2ONJFs+bm3i5543YvY46/wgJOwVjva/h1aYpqcPP1xI1eKDXnnLqeMuFHmw5HBHBQiH6jGA9h3jpEeeO2taYpT5Kz1Z7iWIwjyWRU++fC2VtHfbOLirsQxsSNA8m5tpYfmb5AuczhA6mwukS5m1pM/QBndSdVvu9IzydWRDG5mGzwbHv669zxcGuXoRE178E6ravX1O6IzlBR++jUyjy2BoDr9mL+giSURSwPdlVo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stfx.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 349b1cda-c873-43e8-9db3-08d8bd9e0c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 23:49:38.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c46abc7-960b-4124-8950-1628b2b192f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGaQo2SCFDb2OH8FS32apa2Gzvy5CVepu5Y1DmFumg6QQP0IwrFjo/u/81gDYYbJHrKPZLVjin0aPNN3IHvUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2367
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBpc3N1ZSB0aGF0IHRoZSB0aWNrX25vaHpfZ2V0X3NsZWVwX2xlbmd0aCgpIGZ1bmN0
aW9uIGNvdWxkIHJldHVybiBhIApuZWdhdGl2ZSB2YWx1ZS4KClRoZSB2YXJpYWJsZSAiZGV2LT5u
ZXh0X2V2ZW50IiBoYXMgYSBzbWFsbCBwb3NzaWJpbGl0eSB0byBiZSBzbWFsbGVyIHRoYW4gCnRo
ZSB2YXJpYWJsZSAibm93IiBkdXJpbmcgcnVubmluZywgd2hpY2ggd291bGQgcmVzdWx0IGluIGEg
bmVnYXRpdmUgdmFsdWUgCm9mICIqZGVsdGFfbmV4dCIuIFRoZSB2YXJpYWJsZSAibmV4dF9ldmVu
dCIgYWxzbyBoYXMgYSBzbWFsbCBwb3NpYmlsaXR5IHRvIApiZSBzbWFsbGVyIHRoYW4gdGhlIHZh
cmlhYmxlICJub3ciLiBCb3RoIGNhc2UgY291bGQgbGVhZCB0byBhIG5lZ2F0aXZlIApyZXR1cm4g
b2YgZnVuY3Rpb24gdGlja19ub2h6X2dldF9zbGVlcF9sZW5ndGgoKS4KClNpZ25lZC1vZmYtYnk6
IFRpIFpob3UgPHgyMDE5Y3dtQHN0ZnguY2E+Ci0tLQotLS0gdGlwL2tlcm5lbC90aW1lL3RpY2st
c2NoZWQuYy5vcmlnCTIwMjEtMDEtMjAgMDU6MzQ6MjUuMTUxMzI1OTEyIC0wNDAwCisrKyB0aXAv
a2VybmVsL3RpbWUvdGljay1zY2hlZC5jCTIwMjEtMDEtMjAgMTk6NDQ6MjguMjM4NTM4MzgwIC0w
NDAwCkBAIC0xMTQyLDYgKzExNDIsOSBAQCBrdGltZV90IHRpY2tfbm9oel9nZXRfc2xlZXBfbGVu
Z3RoKGt0aW1lCiAKIAkqZGVsdGFfbmV4dCA9IGt0aW1lX3N1YihkZXYtPm5leHRfZXZlbnQsIG5v
dyk7CiAKKwlpZiAodW5saWtlbHkoKmRlbHRhX25leHQgPCAwKSkKKwkJKmRlbHRhX25leHQgPSAw
OworCiAJaWYgKCFjYW5fc3RvcF9pZGxlX3RpY2soY3B1LCB0cykpCiAJCXJldHVybiAqZGVsdGFf
bmV4dDsKIApAQCAtMTE1Niw2ICsxMTU5LDkgQEAga3RpbWVfdCB0aWNrX25vaHpfZ2V0X3NsZWVw
X2xlbmd0aChrdGltZQogCW5leHRfZXZlbnQgPSBtaW5fdCh1NjQsIG5leHRfZXZlbnQsCiAJCQkg
ICBocnRpbWVyX25leHRfZXZlbnRfd2l0aG91dCgmdHMtPnNjaGVkX3RpbWVyKSk7CiAKKwlpZiAo
dW5saWtlbHkobmV4dF9ldmVudCA8IG5vdykpCisJCW5leHRfZXZlbnQgPSBub3c7CisKIAlyZXR1
cm4ga3RpbWVfc3ViKG5leHRfZXZlbnQsIG5vdyk7CiB9CiAK
