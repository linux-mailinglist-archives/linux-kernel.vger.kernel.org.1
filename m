Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FDF2E7893
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgL3MiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:38:25 -0500
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:57024
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbgL3MiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:38:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN+4fWJmLG35iq+u44C28uueJX0+WsBHmD3tSMdzV35P9o78rclC7Jiib+RIG77L71j0WPN4c1olEYhZ4L43ekFuOReOF537YU/R04+BWDmMtNvadKyHDULhvrw/U/a96ajng0F3WfiXm+YzdBWTasFwobjDxR/nEfGQ+j9QMC/C7D0uhD49VqgMd69QNWN41mIYtCcibvxbr9o8gWz1uMFmzx5yVXIYse1fCXMwLvg0nfBaontBA+rBmIWW1U46DGi0Dxw7gvIDRhIWnWuBlBOCe0FapHn2e4aCL4/rqStpZXWXWf5TsinwmeqOSs0R2+bRV8EY6+KLvTzczoEerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG9TH/bScGYKHawObP/HfOkkIp/+3j34E3MNfHSUi7s=;
 b=GteBEQhjO4eJoTJlJyGuF8LiFVU8boKtjDWc4AsCuq1i5qmOVFBFlmXwOQVxfJSCGUViSjAx4foISCkNYZITkw/Dc+8N/RKLjdjr+10ZEZHny8/52nns6kKXPtnfELpscaaTAezHd/YeBJDzsbOYRgJvpKuPpbntJjJxlgyAdW/P1sqxtqfvC84CnqMal2nTNwROpJitC/1YfNDkemDVu279BoMDRIhC9Ha7BUKW8uceKt1mTlLCgBY+8YNYu/QOIUri5MXd4O48M2gbDaA3S9Z5NHYtkdClEzhS2w1asRp4P9Q3qZNc3w1gk4D4jSZUBk5ZvyGE0dtzRYwtWopSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG9TH/bScGYKHawObP/HfOkkIp/+3j34E3MNfHSUi7s=;
 b=e/jVjGZ+Dfr5rZpz778S8hXZrN82ylNsau45gEVGFrdSFQst9doERs1p+QyqeeczgdmjVzMr6x57NrrGSaAu88zJGYt0icCvnaAH+PAD4RQj84ptdoTDRJxQRswoontC31Kr+huzmOT74lOMOrsxABy/rd01DcH6I8jQYoVEdN8=
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Wed, 30 Dec
 2020 12:37:35 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%5]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 12:37:35 +0000
From:   "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: RE: [PATCH v3] regmap: debugfs: Fix a memory leak when calling
 regmap_attach_dev
Thread-Topic: [PATCH v3] regmap: debugfs: Fix a memory leak when calling
 regmap_attach_dev
Thread-Index: AQHW3dCA5Vibwi8iDkqbAod4oyZ3B6oPZl4AgAAD4UCAACEyAIAACI0g
Date:   Wed, 30 Dec 2020 12:37:35 +0000
Message-ID: <PH0PR11MB507731B129639CED3B8C753595D70@PH0PR11MB5077.namprd11.prod.outlook.com>
References: <20201229105046.41984-1-xiaolei.wang@windriver.com>
 <d516efdd-7e66-13fe-3798-cdea5ff012dc@web.de>
 <PH0PR11MB5077EC74C0A81ABF8F082BC795D70@PH0PR11MB5077.namprd11.prod.outlook.com>
 <d463ff8b-306d-6f40-9115-1595d69edc95@web.de>
In-Reply-To: <d463ff8b-306d-6f40-9115-1595d69edc95@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [192.103.52.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c20558-3561-4dd3-4b9f-08d8acbfaf95
x-ms-traffictypediagnostic: PH0PR11MB4950:
x-microsoft-antispam-prvs: <PH0PR11MB4950E5FA9B77FE514622CC9A95D70@PH0PR11MB4950.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6b/HjxbmMqBUVOS0TOSyMkwubVyrQxXtM9jXlLWt3TVzUhzzIXfMf/AptTxygpAKUR2MBVACIH9XVjHRCOp4Y9ERKzGSZOKHfaAH522OuKAl5uCNIojsBuE1zJkA5Hd66KXOlLlKBloNru+RAko3pcbXT0EAPz+4sgoNA0MS2csajXJTRgaaOBd/PjJ8A1QeMUIi4onggKoBzaFMmqjiUGY2dAfmWtNpUQNtp9c1fcoM00L5xpdbQYWdLMmaQgpTfVfK2bENg36RUoEXEku9IxJX9BYbbSTf05pvCDsnTVm0Y31WixzbOuc5smVMCpHtAp4HiHGx+Q2okpxKtseS8qpsUAKX5zP3X1saVLXLfLqyG74JOE50hZ+XMQNlfVBJcUjn3kFnyDscUL5v/h7WdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39840400004)(396003)(186003)(8676002)(52536014)(64756008)(55016002)(33656002)(66556008)(76116006)(316002)(7696005)(83380400001)(66446008)(26005)(86362001)(71200400001)(66946007)(4326008)(9686003)(478600001)(5660300002)(8936002)(66476007)(110136005)(53546011)(2906002)(6506007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Tmx1SFRiaEV2enZJenlVUHo0cC9kUlppaXJ6L3pGNFZsbmRnWFVlekQySUxa?=
 =?utf-8?B?UEVtZHdjNkY2QlpxSWRSNG9RQnVJUzI2UUtqZy82VGVvb1NGdVhvc245M2gv?=
 =?utf-8?B?NkoxOEo3aXBWZnJIOXFwL1R3RzJZY0FKTWJURVBJSzlyQTY2SllMV29PeHZq?=
 =?utf-8?B?Q2xhYWZUclZydk4rUGxva3Qvc0VQVU9aVVJWck4yVWhOenF2Q1ZTMDQ1TWZO?=
 =?utf-8?B?R0pvSnJUdEp3NWFUQ0QvakhWcFJ6bU1SZStFelVsNzhUWm5RV3VrbGZOUHlt?=
 =?utf-8?B?TStpZ214S0VPZWZJOTFqVmFsT2tabG91eXRnSWFaWGNpOFNSL0hyTWRVZkpK?=
 =?utf-8?B?K1hZV2pEandMT3RGYTdXWDBUOVRDUHM4Q2ZrUmI4UFN5YzNXVjNZQjNQb1Nw?=
 =?utf-8?B?Y0xaeHZSNUgvbXozNDR3Qi9oQ0Rrc3RGbUxxVDl4aVc4eGxYSERQN3VYMHBm?=
 =?utf-8?B?Ulh5Z21WM0NsZTZRSFVnWnVtbGRoY0RsS3d6N3BwT0J6UWNuS2JibENFYVZi?=
 =?utf-8?B?WUtGZW81cE10Wjd6YlBVY3dERU8wVCtnUUlCcVhDOEtNQk1xWk9UZ1VYZWVz?=
 =?utf-8?B?R3dSSEZpd1pDc3lsZ3dmYi9lUVZaTEpXRFVObFRwRjVlUk11YWk4TzBQYnpV?=
 =?utf-8?B?a2NseDF6NUtGK0Nmdm9CZFJiTkRWTXV0VkpOYTcyU2oyT0paUUlJSkI4eGpq?=
 =?utf-8?B?WGlSN1QzRUpXV1Y2UGh4VzQ1bkJUSitJeFJpcnF6cFBKd0dzMzhkaVIxZUZW?=
 =?utf-8?B?c2d2UThNOUNrczZMRUt4V3h2WldIZWIzTmthTXluNm9XNFhLaSt5MHpEWWZk?=
 =?utf-8?B?SkJmNlByeUltZUx6dEtDV2d4VnZ2SHFIWGVZa0I5dHBKeUZMVWgva002UnZN?=
 =?utf-8?B?U0dGNUpNWXFTWVlpQVBVVTJkOWJlTnJWOUNIVjJqS0poKzFKd0lhSGtUYlM5?=
 =?utf-8?B?aTJoOHhFOUpwdDZPc05uUWpUVWdINm5IdzNiK0lmVUZmazZHMXdTajVkcG12?=
 =?utf-8?B?M2hPQ1VqY0lBRlRvT0h5TTQ4ZXhJODFTWHlnRzV2YlEvV1NJNktRUUd4NEIr?=
 =?utf-8?B?ZmhQQ1NUbmhWWmpsNFZjQlMyVGkxWXNwSm8vZFhKZG1teDQ3ZkRjSTB3Qisx?=
 =?utf-8?B?NTh6Z3Brb1c5QkVQYzJCZENrSnAwWEpVdjdXSENMOS9SNTNlOWdKZTB6U004?=
 =?utf-8?B?c05jbnRyamVrT2VwdDJ0Rlppb2VFb21OcHlyVDBYU1V1VWZsWUdYakpTMTRm?=
 =?utf-8?B?R0FCbk1sMzErQ09PNjFsTEhTdzdRTHFHMFg5WlYyYkwwMkl5SzNXdHVtNysz?=
 =?utf-8?Q?Vyh4ISZIQ4/x8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c20558-3561-4dd3-4b9f-08d8acbfaf95
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 12:37:35.5969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZcAK8PxV7TyA/QeHctpOlOo1KYy15wCwjwB9YhneVB49E/O6lA9wvPYx3x76bmthqaA25+8Mg0MfWBah48K89eT6PpnCr0H3seGkoMSK2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFya3VzDQoNCj4gVGhhbmsgeW91IHZlcnkgbXVjaCwgdmVyeSBnb29kIHN1Z2dlc3Rpb24s
DQoNCj4gVGhhbmtzIGZvciBhbm90aGVyIHBvc2l0aXZlIGZlZWRiYWNrLg0KDQoNCj4gZG8gSSBu
ZWVkIHRvIHJlLXNlbmQgYSBwYXRjaCB0byBmaXggdGhpcyBwcm9ibGVtLCBvciBtb2RpZnkgdGhl
IHByZXZpb3VzIHBhdGNoIGFuZCBzZW5kIGl0IGFnYWluPw0KDQo+IFBsZWFzZSBjb252aW5jZSB0
aGUgaW52b2x2ZWQgY29udHJpYnV0b3JzIHRvIGludGVncmF0ZSBhIGNvcnJlY3RlZCBwYXRjaCB2
ZXJzaW9uLg0KDQpEbyB5b3UgbWVhbiB0aGF0IEkgc2hvdWxkIGNvcnJlY3QgdGhlIG9yaWdpbmFs
IHBhdGNoIGFuZCBleHBsYWluIG15IGNoYW5nZXMgYW5kIHNlbmQgaXQgb3V0Pw0KDQo+ICogQmV0
dGVyIGluZGVudGF0aW9uLg0KDQoqIOKApg0KPj4gKwkJaWYgKCFtYXAtPmRlYnVnZnNfbmFtZSkN
Cj4+ICsJCQlrZnJlZShtYXAtPmRlYnVnZnNfbmFtZSk7DQoNCj4gIFdvdWxkIHRoaXMgcXVlc3Rp
b25hYmxlIG51bGwgcG9pbnRlciBjaGVjayByZXN1bHQgaW4gYSBtZW1vcnkgbGVhaz8NCg0KaWYg
KCFtYXAtPmRlYnVnZnNfbmFtZSkNCglrZnJlZShtYXAtPmRlYnVnZnNfbmFtZSk7DQoNClRoaXMg
bnVsbCBwb2ludGVyIGNoZWNrIGlzIG5vdCBpbiB0aGUgbWVtb3J5IGxlYWsNCg0KVGhhbmtzDQp4
aWFvbGVpDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWFya3VzIEVsZnJpbmcg
PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4gDQpTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDMwLCAy
MDIwIDg6MDIgUE0NClRvOiBXYW5nLCBYaWFvbGVpIDxYaWFvbGVpLldhbmdAd2luZHJpdmVyLmNv
bT47IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcNCkNjOiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBEYXZpZCBMZWNobmVyIDxkYXZpZEBsZWNobm9sb2d5LmNvbT47IEdyZWcg
S3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBNYXJrIEJyb3duIDxi
cm9vbmllQGtlcm5lbC5vcmc+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+
OyBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2FsbEBsaXA2LmZyPg0KU3ViamVjdDogUmU6IFtQQVRD
SCB2M10gcmVnbWFwOiBkZWJ1Z2ZzOiBGaXggYSBtZW1vcnkgbGVhayB3aGVuIGNhbGxpbmcgcmVn
bWFwX2F0dGFjaF9kZXYNCg0KPiBUaGFuayB5b3UgdmVyeSBtdWNoLCB2ZXJ5IGdvb2Qgc3VnZ2Vz
dGlvbiwNCg0KVGhhbmtzIGZvciBhbm90aGVyIHBvc2l0aXZlIGZlZWRiYWNrLg0KDQoNCj4gZG8g
SSBuZWVkIHRvIHJlLXNlbmQgYSBwYXRjaCB0byBmaXggdGhpcyBwcm9ibGVtLCBvciBtb2RpZnkg
dGhlIHByZXZpb3VzIHBhdGNoIGFuZCBzZW5kIGl0IGFnYWluPw0KDQpQbGVhc2UgY29udmluY2Ug
dGhlIGludm9sdmVkIGNvbnRyaWJ1dG9ycyB0byBpbnRlZ3JhdGUgYSBjb3JyZWN0ZWQgcGF0Y2gg
dmVyc2lvbi4NCg0KKiBCZXR0ZXIgaW5kZW50YXRpb24uDQoNCiog4oCmDQo+PiArCQlpZiAoIW1h
cC0+ZGVidWdmc19uYW1lKQ0KPj4gKwkJCWtmcmVlKG1hcC0+ZGVidWdmc19uYW1lKTsNCg0KICBX
b3VsZCB0aGlzIHF1ZXN0aW9uYWJsZSBudWxsIHBvaW50ZXIgY2hlY2sgcmVzdWx0IGluIGEgbWVt
b3J5IGxlYWs/DQoNClJlZ2FyZHMsDQpNYXJrdXMNCg==
