Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9602F460B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbhAMINI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:13:08 -0500
Received: from mail-eopbgr1310099.outbound.protection.outlook.com ([40.107.131.99]:39488
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbhAMINH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:13:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYVlqeuZ0/80UkZNr+BkQSAw3uZoMLiMUaK1onybTWKxHCXsA61t21U0agmfZjjYfBql1P2hyJMyr+LM7xs1OsVI+BxyKPwA7NSbsGuZdDkNwmY/fh4h7Z7vgp4JMKc7gw71boaHgheqZ49N4QeN+/H1aX6BoOogEbJsL4vdaSoe3Y6dMIyeLAHEFfQjgpMRWuwQcG2/M4YlRpByp6/2AVt+oatqE7rC2kI+6/UDP2APm8eWVNvBCxFCa6Zq4EYBj65RuCOCNClsApsT4G0K29R05gBaI6Gk2rcygt75QuQNB8oxKLtZIFYCJB2A+L5POvPRZMpUcBhDoIOhf83dLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99ZgweiB9ViK6XVyVH4WxbtBrvv2BVkbv+M6R0/VPq0=;
 b=UTuL2RFfpLUW7PGwd+nhvJOozvJoZt9ppYW1pnuQsm0qxZ81pGv7tH7BgiEFNO7ItgrjHpzdhqOd1+i4Dgpn/rZ32dwsWhE3hci3Tip0HTtxdv02nukkEH6mdRfKfE1jbr1uDo4VEdTM0joaZRxk3I0v+TeWcyslymAeEpSx5dNzEIbntX/7BV+zSpmQbwhdyeH/O68AlFmQgCjiqKr2BXmNKo4QaeZR9TZOR9YromfTDoDFMMIQrHp+CDayqDI4dLWwd8+Iwi9D3EVPlFAg/Gyv7qs0zCZjTlRzyBpskMdUd/TZIuq692v6PicvPHEBUFNnNw9i1O3IO034V9FpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.digi-group.com; dmarc=pass action=none
 header.from=cn.digi-group.com; dkim=pass header.d=cn.digi-group.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digiworld.onmicrosoft.com; s=selector2-digiworld-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99ZgweiB9ViK6XVyVH4WxbtBrvv2BVkbv+M6R0/VPq0=;
 b=s1tNPQgrfWuDvSHLt1WuEumaccUP8bAgJ0XHpBqd4lpOzRlE+giFBS9TIp+CSlKOsA/rPd7QPIfMWro0lmoOHGByrAxYhcN7Hj7fj9KpyFvhzU/Drd59ECHZdnuZUTHuDR4hFpaCNzdF4t7Gae4pYpodsSpu5QKVY5qQ5yMLFQE=
Received: from HK0PR06MB3825.apcprd06.prod.outlook.com (2603:1096:203:ad::15)
 by HK0PR06MB2290.apcprd06.prod.outlook.com (2603:1096:203:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Wed, 13 Jan
 2021 08:11:33 +0000
Received: from HK0PR06MB3825.apcprd06.prod.outlook.com
 ([fe80::f5c6:1f35:5fd5:9501]) by HK0PR06MB3825.apcprd06.prod.outlook.com
 ([fe80::f5c6:1f35:5fd5:9501%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 08:11:33 +0000
From:   Jin Chen Xin <cx.jin@cn.digi-group.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Recall: [PATCH] drivers: add new VID/PID for supporting Teraoka
 AD2000
Thread-Topic: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000
Thread-Index: AQHW6YO0y63ZImDip0mOroYDEeLkAA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date:   Wed, 13 Jan 2021 08:11:32 +0000
Message-ID: <HK0PR06MB382565484E019A51BA3BCDA49FA90@HK0PR06MB3825.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cn.digi-group.com;
x-originating-ip: [116.228.41.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ed9fe23-55da-428e-2da1-08d8b79ad6da
x-ms-traffictypediagnostic: HK0PR06MB2290:
x-microsoft-antispam-prvs: <HK0PR06MB2290A0F2F966405A48C664779FA90@HK0PR06MB2290.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOVgh+bzeCsYI4LTBDIXlTNMkpDjbtM+eqq0HXO/RsJu2CuUyIYwSiPKRisLwAq9HsCvQ06B3oLP05JcS1rlZKnQugP8QXd1pakUb7pth7sFVl/4LM/ns8QiN7MCCq9FSvRcMWwBBZjrD/ERCjwnZGj0o9E1roPXOeQn8tEs5t7MbopNnWRm5i1OqsRgw3an0kXv5StKrovUh5GxVj0W09v8QHHVcFGGWiDsWXZD8GohXrFCvPhQBOBAd0Bre8hqdHYA1cneOPPKojOpgnXKmuomCRrv3V+0AFe6PlL3eHt9Rxo00isNtSENvYRzTcjTq5SBe408FQe/8/QfRKhDedQMpy6f4eEfka8HGNM72/TN2DHf/k0RazmFFsKjdMIzxqxGePBg6cqCF/W++JeUuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3825.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(478600001)(6506007)(6916009)(2906002)(4326008)(186003)(7696005)(86362001)(4744005)(54906003)(33656002)(66476007)(83380400001)(9686003)(8936002)(64756008)(316002)(66556008)(8676002)(66946007)(66446008)(52536014)(76116006)(26005)(55016002)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Q3ZQM0dTTWNock9sQU1tUGN6R2Rkdk9mcStTUGZWaHR2cnJCWU40bGpWVk04?=
 =?utf-8?B?TU1sVm1TZEtGU3o3SXEvOTJlckIrMERlM01YZ1NCZVNuL2lGOHFod3JneUJh?=
 =?utf-8?B?TGN0UzVzaTI2aTdiSlZsaFJjU2prVm9jRW1qaWU1bmR5VGFSdndIWWkwMXJQ?=
 =?utf-8?B?UDYvZU1ITnAya1Bvc1NxeVdkcnMvcnNTMUFCeUs4d1NHWDBJMVY0cVplckpk?=
 =?utf-8?B?alU2TGUvTXFuckZhemxpL1ZwZTluM3JWWlVqQVBUbHFQVkg3M3l4blc2TWFC?=
 =?utf-8?B?cjFLTGIyKzJEVnBjSU9JdFlUVjQ1MVNzNzMvRm94QlAyeUxHd1FCa29wYzZY?=
 =?utf-8?B?MW1HQjd2S2s3d2Y2eTdoV3ZncTdWaDZrbUM5dGtadTdteGoyWlZSSnVoYjZm?=
 =?utf-8?B?MVBEb0pOK0M4dCtTRkxiR3hwR3VOZmpHSkkrTDgxZ0dtMjRUYW9NK3dDaVBN?=
 =?utf-8?B?dmpVdUpKcEM4dDZuODZXZitLSW1KK0NzRTl3cForcXgwZ0V4b1Nka05BNjFm?=
 =?utf-8?B?UzUvWWRxL1FkYnphVGhsWWRNVERNK3IzOEQxVCtxSlFyajdqbEZSdHdZWndu?=
 =?utf-8?B?eTBpOC93NjhGaGpvYnp5MFBxT1Q0K2xkekdGdkREcUx1a280MnQ2N080clNM?=
 =?utf-8?B?ZDdwL2dOVHRaYTJDdzJtS29HMEdXYUJKL0VVVEVkU1BJSzlsWGhFcDFYeDZR?=
 =?utf-8?B?ZUlFUDVWZVJVRjZhbjlmUG5hY2lvRTNJeVBZcnhlWmxBcDFoRjByU3VnVkFh?=
 =?utf-8?B?dW5BNkxiM0FjemdaRlJXOVgvdFZ0TTIxT1NZWGdJRGpwREdRMEtyODFITE51?=
 =?utf-8?B?Y3ZWUDEyS2xieWRxSWhja0pORUFyNWxPaThzZzJVUzZVcC9HS0N4ajBFL3dr?=
 =?utf-8?B?OFJNWFUxL2MvamFmQUVPL3VZdlVQYmtwRWdUd2ZFc2dsYlhUUzdISjF0dGMy?=
 =?utf-8?B?QTMyTWZkUzBHNzJOeGhWaUswQ1V0L1pRNTFPVnFhRlMxc2xLcFBiazdPOG5i?=
 =?utf-8?B?bUFhR05yVDgydGRGdXpMZXJQMGFRS0RxV0doWFlkVFQ0TGxOWGI3MnJGcHZ1?=
 =?utf-8?B?ZDYwekJaQVQwZDBxSitjZkoxdkNQTUs3V0RFblFrVjI1NXdYdnJGam4rY3pY?=
 =?utf-8?B?MEl1UE1XaEh3MlV4cXp4blpPWTNLZkdyd3gxTEc0bXpWMHVZS2pTMWYzZnZr?=
 =?utf-8?B?VlpmTFhLZ1Q4SXlzYmpFR0dzMlJicVhEbzlIcEFlRFlWbThTcXJjS1QxdlBS?=
 =?utf-8?B?ejlIWVd2Q1BhR1BzNHBIYS90WlVPWE1pUmNWNy9uZ2ptQlJYZFVZSkRrSytI?=
 =?utf-8?Q?Heb/VZlOBuWi4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cn.digi-group.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3825.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed9fe23-55da-428e-2da1-08d8b79ad6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 08:11:32.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05a6dd31-dbec-4a4f-a8cd-2eada561cecf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbKKpaQKTKESUvmN0Oe3QfvgdDVqtwn54cKDk4I34VcItWjDbSqtTYcShXQv1niNqwrZG1UpA0kJK9OXrvTLR514Td3Yf/qhCuAyCPRYFuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2290
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmluIENoZW4gWGluIHdvdWxkIGxpa2UgdG8gcmVjYWxsIHRoZSBtZXNzYWdlLCAiW1BBVENIXSBk
cml2ZXJzOiBhZGQgbmV3IFZJRC9QSUQgZm9yIHN1cHBvcnRpbmcgVGVyYW9rYSBBRDIwMDAiLg0K
KiBUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgbWVzc2FnZSBpcyBpbnRlbmRlZCBm
b3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbHMgdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQgYW5k
IG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCBhbmQgY29uZmlkZW50
aWFsLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGVtYWlsIGJ5IG1pc3Rha2UsIHBsZWFzZSBk
aXNjYXJkIHRoaXMgZW1haWwgaW1tZWRpYXRlbHkuIERvIG5vdCBkaXNjbG9zZSwgZm9yd2FyZCBv
ciBjb3B5Lg0KKiDkv6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7Yo5YyF5ous5YW25Lu75L2V
6ZmE5Lu277yJ55qE5L+h5oGv77yM5LuF55So5LqO6YKu5Lu25YiX5Ye655qE5o6l5pS26ICF5L2/
55So77yM5bm25LiU5Y+v6IO95YyF5ZCr5pyJ54m56K645ZKM5py65a+G55qE5L+h5oGv44CC5aaC
5p6c5oKo6K+v5pS25Yiw6L+Z5bCB55S15a2Q6YKu5Lu277yM6K+36YCa55+l5Y+R5Lu25Lq677yM
5bm256uL5Y2z5Yig6Zmk5a6D77yM6K+35Yu/6YCP6Zyy44CB6L2s5Y+R5oiW5aSN5Yi244CCDQo=
