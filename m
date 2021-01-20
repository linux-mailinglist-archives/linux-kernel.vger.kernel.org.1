Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FAB2FD920
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392574AbhATTHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:07:12 -0500
Received: from mail-eopbgr660082.outbound.protection.outlook.com ([40.107.66.82]:59520
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392308AbhATS7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:59:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc5uJBUm4G4IJDLgnQoRGrzyCW10QUN+hswB6hatHgEXRYqAX8T8O4/cIsIajhyr2K6Gi9oqQsubYY4aocnClTwwzM9277amcf21GihEXuAd1RRyMOOZTg1mNmOw9ynnoyHM8LTDnTEZav99LdMD8phqFVdpQqPutXXziSkKh5pGhagcyxdHrMmKJSiHqV7r8SNPbc4ugTCpuxenqYStQp23Xs+7Ck/FPq43wdNbq6eEWFMG9oCXuqQVKV31vyjn/R1N6wmxt7Gno/zhM+n7MQnt9T7RNuNyln0TOQtYjgL8efecnGApMwp2Ycj2nLdEkNbc+oLYt49FcBbuF5jnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHFE0y0iZpXhq/M79spUiE1TZ4n7DTzG7vMJhf8p3/E=;
 b=nQDFzFn9mKa8TS1KxTuGC5hm9TOrotUfN4ewYX5WCfCIh+/sDg13kKX7YXCzxc4kuXXO9ChDzeOqNTt/76ea1fGh9+6KyLl0d+dUQ6A89n3FUfr0gKdeg9PnaJQ7cLIpX0+Hmu1w2gOrUHEc4TY8Q5mjHaDSqyLSLnUrmVKNF3HO9n5YtZGWxyCSL+BcxCPW9dBuRfkBYikrwJaTR4hMSi4xdnL+wNT1i523p0uPcqqQofEll7CZLR1Zw795um9TIWl+VfPq23IIxniS2MyWSwtUdPq8Wxe4T0iXCMC84gr+lGBg643NCB+EcUVZViDgy1X3wWDX8KYuvzlcEu3azA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stfx.ca; dmarc=pass action=none header.from=stfx.ca; dkim=pass
 header.d=stfx.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stfxca.onmicrosoft.com; s=selector2-stfxca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHFE0y0iZpXhq/M79spUiE1TZ4n7DTzG7vMJhf8p3/E=;
 b=TkNuxqVc4CrDuUoVuROVLlv0aA5tTeUXTkz3JZ4L3gMpdooBGyWjuPSs9XkgnLOeaMoF5TytL89H6d48NakN3ucDDD2RfLPuFukU7MZVU/QnZeKKN5tFaevdaLKwcUXexnBYTMs2ygsgLEpZY1DhdqVuIEbkZa4vGaQT6SWbDdw=
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:17::19)
 by YTBPR01MB2461.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:22::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 18:58:47 +0000
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::807a:7935:d3ff:e93f]) by YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::807a:7935:d3ff:e93f%7]) with mapi id 15.20.3763.015; Wed, 20 Jan 2021
 18:58:47 +0000
From:   "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix the issue that the tick_nohz_get_sleep_length() function
 could return a negative value
Thread-Topic: [PATCH] fix the issue that the tick_nohz_get_sleep_length()
 function could return a negative value
Thread-Index: AQHW715CibVWBoZHJ0KucY8wOFCqYQ==
Date:   Wed, 20 Jan 2021 18:58:47 +0000
Message-ID: <YTBPR01MB3262E37307F17B3374B64CF6C4A20@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=stfx.ca;
x-originating-ip: [24.89.210.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4c48ee0-fdba-4c3a-dce0-08d8bd756b07
x-ms-traffictypediagnostic: YTBPR01MB2461:
x-microsoft-antispam-prvs: <YTBPR01MB246129F0A14EFC396148426CC4A20@YTBPR01MB2461.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Lhk6KCnF5d2GIKHbHzBfD7QdGwsU5QCYWjuC2Qh79O9PljMMMrt3WvnC2I6T06WwUNpHpjhrsG8b7FReIHZI9uuX2G7co9xSYPRuVrNY4sscMag9xHWudFUNkvXv2DOVWwEzFnc16kDO/HBYyxWBjpKETjPfofZNZnooowaUSMhUl3VIeJEjR8ytpyhZJb+KLKn2U/8biKuAbBJX/IJoLpWoRp2E4CVjCci21HqTTaRD2CBHhoPXzWwuItpMpHniFuTlBPyIwKipbJEFM2Ckdh6kSRngHOTSC+tnaDtjmSoViNio66qtLgFzbx2giYPwAK1tsKWUBcwFQOkHRSpw7VDOSGy3H0keoffc64ozzYwZONTfT/UFL57Pr4AkL3SDW4jBL9Pt5E2XZnuou5vPbAG7KlXZSl7AAJ/eHN6r7z5M9WTQkUeoaLXJaBhBCWsK32owqlAO6s+orMlOPHmy//ws98lJwnlFZkj9Y8ePaUtegWhYNcKJ/Fqiuq3y2Y/MiWkqS8XpJER9UzOzCAvbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(71200400001)(6916009)(83380400001)(33656002)(478600001)(66946007)(786003)(5660300002)(66556008)(86362001)(66476007)(76116006)(9686003)(52536014)(4744005)(66446008)(8676002)(55016002)(8936002)(186003)(2906002)(64756008)(26005)(6506007)(7696005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?dC9CNElNRDYzd3lTTDZIODdjM3lUenBzd3RtSmJoYXMyN2RJbnBHSU84OWU5?=
 =?gb2312?B?MmtzYUk2bUIreDBmTzFGVGhNa2dORjhUMUpzRjVoUXNtLzA3ZkFTRUliaW5S?=
 =?gb2312?B?ZU4vS1czQ0N0aGdFQjZacDhxZHMzQVN3OFpONHBxTkJoV3ZTdWFXanBJeloz?=
 =?gb2312?B?ODErR2N3UCtXR3NFdDcyNUx0YjhSbjhFM0ZocWJlblkxdDFlcHVybWJRam5F?=
 =?gb2312?B?bXQ2TTMrWXlycFBqVzM0RTN1MDNtaUtiVlZnYnhpMCtwTlVhUFFmTEE0dHVH?=
 =?gb2312?B?YmZCVUlFMjhPcEIyYXdrczloMmRxZ2lTa2hHV0U5SUo0R0twU1M2cDdkNUNr?=
 =?gb2312?B?eEg3MnpwV29hVVl0TVlib1cxUzlBNzlkOUFnRzRzcE94T0ZsbjNpdi8yTnNR?=
 =?gb2312?B?N3FmZnEwTWdFQ2lNL1Q1WlkxbWNxYlVPblJVQ1pBZUIvY1piL3ZkMWJ1dGN2?=
 =?gb2312?B?dlJVM2pYU2NmOVQyOWR3dlI3TWFhcFJxS3c5cllhbUNDVGR3WXdsYzAyVUxu?=
 =?gb2312?B?MzhPa2VaUlV0WGF0SjEzbkgrUVhJNE84b2luK3ZrcXNBOFBubk83a2R6NXNJ?=
 =?gb2312?B?MmZ6YndER2pWTzZJSHVvSXJjcFp3d1Y1QmlnZmlxYS9oQXpDSi95ZEZ0eTlK?=
 =?gb2312?B?NHJJZE1pa1RqendwSE4yYmZMSVVwMGFNT2g2TWRBbXBGREU2TUdLZFJPbnFV?=
 =?gb2312?B?YnlwTjliMXpMR2tGT3VaQjdXaWRCclNDS0NqZGdCZEFjSFUrTDNJUUtlUWhv?=
 =?gb2312?B?VDduejhrOHdBWXJsZXdxcUUyRXJZK0FZT0lISTlldCswbURxQ2o1TSt6Rk94?=
 =?gb2312?B?WCtkbUJHTk1MaUNmc01WYnIrbDArUTFuc1o2QnFHdlhFcUd0ZloybW5UM1No?=
 =?gb2312?B?YzFvaElJdmVkWmFOWVNCaTU0MWxVZXVITWRnU2N3cldwZDBGdzQyWjNuWEdr?=
 =?gb2312?B?WHhZUGQ2cnB5R0l6c2FVTlFNcVBSUFUvUTBjdUJCa1FjNmQ0bTdFaE1yYmtF?=
 =?gb2312?B?dmpJbUdvYjVYcnZZa1FzbWtEWitrVytIcitFeUNyS25tZHFJRVRnbmY4UlQ5?=
 =?gb2312?B?RStPbllSS2lPMWc1b0lXM0NtcXBVcS9QakEvODlaRll1bzkweVorMktNa29W?=
 =?gb2312?B?dEs0NEYzNTBVa003ZTd5Z0pMRjhhcG04UzRvSFM5dk5VQlNUeW83U1hJUERP?=
 =?gb2312?B?K2VyYUo3MStKaG5uSmx5ZXVqSyt1MG4rVStDUXQvRm1GSVB3UjhCTWNpYWtu?=
 =?gb2312?B?Ukd4azZDbEM1ZXNpZjZocVJuSGhDa1ZQVHc2NDA3d2xoVVdRSUhMRTJLbUd0?=
 =?gb2312?B?dTc3ZExyL2N0cVg1eHphSWxRWEFNSTRIQmxqcDJQeFZVL3d5UUxSak5NdDd0?=
 =?gb2312?Q?L+s40xUfYF46HSlNj7ZHy7JWFLTdCWGw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stfx.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c48ee0-fdba-4c3a-dce0-08d8bd756b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 18:58:47.7006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c46abc7-960b-4124-8950-1628b2b192f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUQR9F++IZ58jr6JZ//DBUVFBOveZaizDUH+xZqTAAbSWGRSyyfE0Ud5Pj2pMUdeEWiEn0QhZRxHG6Ajs+ucnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2461
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBpc3N1ZSB0aGF0IHRoZSB0aWNrX25vaHpfZ2V0X3NsZWVwX2xlbmd0aCgpIGZ1bmN0
aW9uIGNvdWxkIHJldHVybgphIG5lZ2F0aXZlIHZhbHVlLgoKVGhlIHZhcmlhYmxlICJuZXh0X2V2
ZW50IiBoYXMgYSBzbWFsbCBwb3NzaWJpbGl0eSB0byBiZSBzbWFsbGVyIHRoYW4gdGhlCnZhcmlh
YmxlICJub3ciIGR1cmluZyBydW5uaW5nLiBTaW5jZSBib3RoIHRoZSBtZW51IGlkbGUgZ292ZXJu
b3IgYW5kIHRoZQp0ZW8gaWRsZSBnb3Zlcm5vciB1c2UgdTY0IHRvIHN0b3JlIHRoZSByZXR1cm4g
dmFsdWUgb2YgdGhlIGZ1bmN0aW9uLCB0aGlzCm1heSByZXN1bHQgaW4gYW4gZXh0cmVtZWx5IGxh
cmdlIGFuZCBpbnZhbGlkIHZhbHVlLgoKT25lIGNhbiBlYXNpbHkgZGV0ZWN0IHRoZSBleGlzdGVu
Y2Ugb2YgdGhpcyBpc3N1ZSBieSB1c2luZyBwcmludGsgdG8Kb3V0cHV0IGEgd2FybmluZy4KClNp
Z25lZC1vZmYtYnk6IFRpIFpob3UgPHgyMDE5Y3dtQHN0ZnguY2E+Ci0tLQotLS0gdGlwL2tlcm5l
bC90aW1lL3RpY2stc2NoZWQuYy5vcmlnICAgMjAyMS0wMS0yMCAwNTozNDoyNS4xNTEzMjU5MTIg
LTA0MDAKKysrIHRpcC9rZXJuZWwvdGltZS90aWNrLXNjaGVkLmMgICAgICAgIDIwMjEtMDEtMjAg
MDc6MDk6MTUuMDYwOTgwODg2IC0wNDAwCkBAIC0xMTU2LDYgKzExNTYsOSBAQCBrdGltZV90IHRp
Y2tfbm9oel9nZXRfc2xlZXBfbGVuZ3RoKGt0aW1lCiAgICAgICAgbmV4dF9ldmVudCA9IG1pbl90
KHU2NCwgbmV4dF9ldmVudCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgaHJ0aW1lcl9uZXh0
X2V2ZW50X3dpdGhvdXQoJnRzLT5zY2hlZF90aW1lcikpOwoKKyAgICAgICBpZiAodW5saWtlbHko
bmV4dF9ldmVudCA8IG5vdykpCisgICAgICAgICAgICAgICBuZXh0X2V2ZW50ID0gbm93OworCiAg
ICAgICAgcmV0dXJuIGt0aW1lX3N1YihuZXh0X2V2ZW50LCBub3cpOwogfQ==
