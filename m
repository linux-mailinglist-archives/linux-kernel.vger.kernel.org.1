Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2D2F8EA0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 19:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbhAPSWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 13:22:09 -0500
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:44993
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbhAPSWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 13:22:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvHopnYt7pmbZ+ekP+35ktNmqUQNTvjI1uGJS9mhArn6g0AGPT9yijhOJN1YpsPQeCFpYSbvGOifiwFbisXwC19ir2J3CiJwfEViLA8crFVcvLqVHHAvWxmppyQpKSYLwhtQT4VCFd4BWtOElBgHk0s6JBI71WsneqV9BqjFo30BfzJsKtHBu1hzt0b+AkNdnj1r0htBjYAiJHuTLGQO9NLsvMyo+GYSqVO2nMzdLNfFH/ef3X33glF8hzUUfts2fRhfrb+tn9h0AMCaGe/ZRJfM7zKWIpE0r1+hSPr1Q/zE0qRBM9ENNHCT636kG9CGjvYX1jp+flxzintx4xdu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQu51c49WerplicBFnhWpvKmg4Pd1AD5pmRt29EI+E0=;
 b=lLIo9LlPPzBdY2H+Kw4BgHzhh2UE3zfidpdzt0MBXUC5pBHt+w3fSm1/SbOn4sJ9P2T2tI9a4SMg/Q9zGVOmaJ9QG0G+ly/YI+NsAyuKZXFJFmkMdpONQGGT/aJiOapCBffvgVo/xLBaEHu+0joipPS4gM7zWEjJ8J8yJnYEyXYbOGmsZCEy5mdR54IconX5qr69fYVCaNPnkD0oFXt3T92XvX0Ar2uI9jc4jy8MzAPExFxG5YlUMPsAYy0UrIOPPSVvdIjWURzDPiZGwSGqQKKpJzu6eVO7xlduV7aDlCUN1Ac/LkpdEzCGGwaU0ZbnTqZlDDnVff6ASC4MvRq6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQu51c49WerplicBFnhWpvKmg4Pd1AD5pmRt29EI+E0=;
 b=A8hx2UZTW2UKn1QZi2TodnQzNFxfkLi1/9wbwoKiJOYnVd0s/2wkfl2FAce3LMm+Z5HkUh6lFKNL1dcAuTId0C45utzPpyAak+hq7G17oIiErwk1fH72wJ4X5a8JimaKV+QghV4uiO6biCyZlhvwEnxfeEddpWfgJ1mXWI5fk30=
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 (2603:10b6:910:45::21) by CY4PR10MB1607.namprd10.prod.outlook.com
 (2603:10b6:910:e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Sat, 16 Jan
 2021 18:21:14 +0000
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7]) by CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7%7]) with mapi id 15.20.3742.012; Sat, 16 Jan 2021
 18:21:14 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: loadkeys --mktable fi >
 /usr/src/linux/drivers/tty/vt/defkeymap.c_shipped OOPSes the kernel 5.4.89
Thread-Topic: loadkeys --mktable fi >
 /usr/src/linux/drivers/tty/vt/defkeymap.c_shipped OOPSes the kernel 5.4.89
Thread-Index: AQHW7BuIgaO8dxc0RkmaNZ8xN1Ya6KoqkISA
Date:   Sat, 16 Jan 2021 18:21:13 +0000
Message-ID: <857faaa3c7def518e0eb087aa2074b0322176e4f.camel@infinera.com>
References: <8176b7a170604460aa5e695370c821364390dd6f.camel@infinera.com>
In-Reply-To: <8176b7a170604460aa5e695370c821364390dd6f.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eb27534-9bfd-4271-0078-08d8ba4b8241
x-ms-traffictypediagnostic: CY4PR10MB1607:
x-microsoft-antispam-prvs: <CY4PR10MB1607FDEE46EA3B0BC0FD9153F4A60@CY4PR10MB1607.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+O0HWJB8T4yxNuuAYreC3pcbrDvXkto7vdI1vyJPGTZYadOb1iR5VAoJe/ClcS+04ptIYugk4K4Pz4ydBc80IrhwJRNIoxmsdKH86x3wKJTtjHJUxvrxwbFUP7YLstanudUWvLrtNoMI2PDJZELqhKmgnUaH1l63KYwx7l2PL3h2kLcWEME6T1pSbPrZlhMUuGbDfKONQpZbePbkVkFX+xxQbxjZNnyuxpNNqigx9EL3bTI4JyD1jk5tdO7A/cufgDw++MOhAGAID8h56qjnPEYxpOkO6ZI1r1bp58jVQrwF9zdhg0dH04iBIwcmUxTkKts22ku0Q561Zu2SznAJmE0m3zJHMK78I1Ql0bguHwaZku81fohrJv2chwmy2ApSUImTRuaJnKLKRiZwdKJat0eU0J0bbkq0qUQYRR/wkj34YFQPiX3Pp1SleMcjpNS0TkDho9TORkOWc97o3T0iSVD50k700HUczuAS/lOnVK5/mD+qID8LMTNBqULz2a/zbq3MwjTSEosm2mUsTCypg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(136003)(376002)(396003)(71200400001)(478600001)(86362001)(6512007)(2616005)(83380400001)(6916009)(316002)(6506007)(5660300002)(76116006)(64756008)(66446008)(6486002)(66556008)(66476007)(91956017)(66946007)(36756003)(8936002)(8676002)(186003)(4744005)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Mm9TbGdkaTRPLzhmbEJlQjlwMGlWRXlJTVFqNHNVL2huSzFKalJISHZCUU16?=
 =?utf-8?B?eVFuWk1zUnMvU3R1RkdyY1FQczArTnBMZTE5TmpSK0hhQVI4NllNYTZ0ZGhU?=
 =?utf-8?B?alFKcWdYbEhHSDl2SlhpcGlyYW1RTklOcWpTS2xpRDQveU5ubWdlN3pWZDV6?=
 =?utf-8?B?T3E0V3M4U0t1UTVac3JXZi9hemcwRCtzMy95WWxUM3JKOHYrTjJsMExIY1Y1?=
 =?utf-8?B?b1N3a3lKWVpGMGRNS293czdRRjVLVGtIdUFvMWJQVk0vVVlhZ1J5WEdqUGcy?=
 =?utf-8?B?SFliVE9iTXIzb1I2Z3dWSVV5OFEzTXgwNStDZk5ZbzRsWWMwelhNQnpLSVQr?=
 =?utf-8?B?aXBaZ2ZHa09yRlhUU3NMcGlnWXNPRDB0NXdjY2J5WHFOY2dtNTRCL0RUSVNR?=
 =?utf-8?B?K0xmRUdZQjArQkxCZHdpV0xUZVNnN21XU3FKUVgvcXhrTHlnZEcybFJGRm1Y?=
 =?utf-8?B?enIxdFhESjZFeFVZOHJLTlNyNFRKaGZBcWdXUGpha1ZDY1RtcUdnN2xnSHZq?=
 =?utf-8?B?bjBLOGRJYVIxOGlDNzBrSWFhZENjQytJSEpvZ0xRalJQaGo0anZjQWg3UW4r?=
 =?utf-8?B?aDQzQ1hvQk9tL1lJdEhHdDFqbXdvd0dDTXJJTTBpOEt3QlZaMytNL0RzNkc5?=
 =?utf-8?B?Q0lodkZBQm95cFowMzcrcnJENDVSY2YrUFV5S0ZaSUVVa05XaDRIZVRmeHpS?=
 =?utf-8?B?VkZBQWRtK3JTS21FbG9teHZaSWNLOFdRM3JWWVB6c25Bdm1CSk9IaCtIRnRO?=
 =?utf-8?B?eWREL3piUDNPYnpZd3ZPeVQrZldDSUhURGdTYnZqeWMvNldXNERUejJhM3FB?=
 =?utf-8?B?OTZJUDU3MWt1bWxCMDlscmR3S0lSN0ZzWTNwZ3IvMHQrMXYyMEl6alAraGZ3?=
 =?utf-8?B?eVZRb1AxOWNwTWQzd2Rqd2xNRENFMlIyMDlJZjdwN05nMnlld1hMUVZIUkIw?=
 =?utf-8?B?ZFc4MmMvTTJ0bnY1T2dISlExUjBWN2dnWE9vVDlqaElzWGpJNlRzSys5YmJJ?=
 =?utf-8?B?ZXRyOHM3RDJ6c1ZiaSsxMTZzbXJtR0V2aTFmczJUbTE4SjhWQURxY09pS0Vw?=
 =?utf-8?B?aVdLS242MTVqeHFYQmErUEdVM1N0Z085NmtmSDBTVEZKUTBGdTF3UlRZeE5O?=
 =?utf-8?B?Z2JHZXpnL0o2MTMwY1c3WmM3M091K3duRWdTeVJrWVFyQU9iS2FrOWlqNDc4?=
 =?utf-8?B?ZDkwOVhxM3B2aWUzNmEvNisrU3BVT1l1SlNadjdXeTZ3UVpZOTM2b0E2RzlT?=
 =?utf-8?B?aFhYbDNYcUN3QW53emRrSWgybHN1WkEyWnBnRVJ3Zmp5aHNMN08vUThNd1J3?=
 =?utf-8?Q?kpWKaWG8M7C4PDFcGExMYKQL6HHV9H4GRT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8B0AF925AFAE0489612FDD7485438AE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb27534-9bfd-4271-0078-08d8ba4b8241
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2021 18:21:13.6480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUEV0M9RkzAYB3znAssEKz9h9PaB8FeLBB2DClYdnxcu9egzF81b7Qvr9kbUjK5PXBkWRaXs2Hop1oeYPM18DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1607
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTAxLTE2IGF0IDE2OjIzICswMTAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Og0KPiBCdWlsZGluZyBhIGtlcm5lbCBhbmQgaGF2aW5nIHRoZSBkZWZhdWx0IGtleW1hcCByZXBs
YWNlZCB3aXRoDQo+IMKgwqBsb2Fka2V5cyAtLW1rdGFibGUgZmkgPiAvdXNyL3NyYy9saW51eC9k
cml2ZXJzL3R0eS92dC9kZWZrZXltYXAuY19zaGlwcGVkDQo+IG1ha2VzIHRoZSBrZXJuZWwgT09Q
UyBkdXJpbmcgc3RhcnR1cC4NCj4gVGhlIE9PUFMgc2Nyb2xscyBhd2F5IGFuZCBJIGNhbiBvbmx5
IHNlZSBhIGZldyByZWdpc3RlcnMuDQo+IA0KPiBUaGUgT09QUyBzZWVtcyB0byBoYXBwZW4gd2hl
biBydW5uaW5nIHRoZSBsb2Fka2V5cyBjb21tYW5kLg0KPiBXb3JraW5nIGtlcm5lbCBpcyA1LjQu
ODANCj4gDQo+IMKgSm9ja2UNCg0KQWZ0ZXIgZG93bmdyYWRpbmcga2JkIHRvIDIuMy4wIGFuZCB0
aGVuIHVwZ3JhZGluZyB0byAyLjQuMCBhZ2FpbiB0aGUgcHJvYmxlbSBkaXNhcHBlYXJlZC4NClZl
cnkgb2RkLg0KDQogIEpvY2tlIA0K
