Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9009B2F6856
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbhANRwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:52:50 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49348 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbhANRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:52:49 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9A00840660;
        Thu, 14 Jan 2021 17:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1610646709; bh=bp3TEd4ezresERKVRPtKd99/oMoLsRvoKgwcJ3hQ6vs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PLqV2jKNCnaU3OH+KPvMjTIXklmu1inAQSQMEdGIrhlJO/of1F1MvcRm+0FVE2SrJ
         O/qu/71shr4O4oiOFvkPOp/Uv4FMQAqrmT2gRRo/SiQg+ZPKlgjz4azc8BHOjc8ymf
         DozXEzWbiuKou7LH/X9ydMcLTWLTYOFpSnB1rU93o9S90B9G4qT5En7TtrghG30Tae
         yyhhpbWOcMBJ05CSnYgQOiOcog8ELEdxV1U6I3B/uUVtSSN49PiNe4EKDNcE1Sa64Z
         gjsvMEs8X6tH8eJsYYRzbuztvp1ab0U+JMWpjPz0yNTaeMX30AFgBOlSrdMvqL8O71
         AkKMDM6anSrCw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 11202A005E;
        Thu, 14 Jan 2021 17:51:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4CDD04009D;
        Thu, 14 Jan 2021 17:51:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vv64Uzq9";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxPv+2s/7ziU5sdAu0pkOaEIPdguruzMqZDdKwiiz3roTcFE9Dg6mECszphK8cvBA2m0sjKEIoVC16t+6NisF4GMgond1HzfBmTzeToyGIjNXMJ5suqNcEaGqqtZs9qmjuynZGCPn7x1PPCK8clhFBx7JDc59weKFI6yYy0rEsrPxtdpW+wU9YfjKwCsZ0HtdPnwa+89VvSiTt2OM10CzctpSc+cjVaF+8KIcesAhysqa/gXSKwE41wMJBdUikLnfXJ3Ek1wOEGthU5/X4zcJGMldlya9uLTFQYsChFEHipO7frak8gdNwEpxy//Hkv9Wcz601LQDeRPT3RL0orhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp3TEd4ezresERKVRPtKd99/oMoLsRvoKgwcJ3hQ6vs=;
 b=GGry112KIBRJUQIrJCQ5POY18DPozXEGCS8WSG418eP6tR0J1xB1CpRGaT0fc5yCnMytWttzerx53n22z/E/BW/n8vnUHDjPwue6XPFY3WSU2n9PTXVcDbVeZR2nwMwPYUyn3CYOWaXhHxo8q5z4ylVFeiDiYvI8hAxDIaYO2Oa+p25Df5w4pjRiHCGBn2fkB1Uj1OskU7BmeDwjxIESCu2lSphquZYjmHLik3x4+Bvx7vjHQxnpp3JmIeijC7/1npun+od+XvjefS/agtllqEWJO9vxDXfWFoqSVBUA2jW9OPDkxRo3LqobslYS0iO/gZ2wCrjP9aFXbqCrflBlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp3TEd4ezresERKVRPtKd99/oMoLsRvoKgwcJ3hQ6vs=;
 b=vv64Uzq9AKJy0s2d82+q07HCrTQuIp84hlVlUBYyRk7lOpJ35+sD7GTgeFb0Yi5gPBvXaDuLj6o0IOwaAzWKCv9MybOeKlo2CEaeSljZzQQGaxgSyFpkzQgIeWpGrE4abP/c7GRrBheW59vlR4HxyMs+fPzzbua7tMnzM2kmk4k=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3938.namprd12.prod.outlook.com (2603:10b6:a03:1af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 17:51:44 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981%6]) with mapi id 15.20.3763.009; Thu, 14 Jan 2021
 17:51:44 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "anmar.oueja@linaro.org" <anmar.oueja@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/18] arch: arc: Remove CONFIG_OPROFILE support
Thread-Topic: [PATCH 03/18] arch: arc: Remove CONFIG_OPROFILE support
Thread-Index: AQHW6mlotr+A3oQG8UiqEMDd75ryJaonZwOA
Date:   Thu, 14 Jan 2021 17:51:44 +0000
Message-ID: <16e1ec02-e6da-b49d-ee21-c98660605cf8@synopsys.com>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <906d9d40746bb1b60823a288d00820cb50d29138.1610622251.git.viresh.kumar@linaro.org>
In-Reply-To: <906d9d40746bb1b60823a288d00820cb50d29138.1610622251.git.viresh.kumar@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c33db4fa-50fe-4119-cf27-08d8b8b50e6e
x-ms-traffictypediagnostic: BY5PR12MB3938:
x-microsoft-antispam-prvs: <BY5PR12MB393869FA9E9ECA3DC595AF10B6A80@BY5PR12MB3938.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +DhvgWN6sV9fSG6af5oS6iZae1caYXvPGBx19rDM8WwolH4mBj485IuErwo3ORYlimsQwuIAH1nCeEq/ZAaipmjxlnQ3yN9jBVGnH+eNdUyqrHxmVma328RRgMrawsu9KR49O1Uddrijnf+ZujWWLUajRYtj9xgWTGKds8oEICajuwvXTGkmgSTpORXBREh72Ha4fiI6SNwo81gaOvc5W747WOi1/WxQQRksF/Mp6+WoCf8nyul7ccIBCFr8X5k9BbOqOlpdi8JyvbxJ59hYaiQDyPgDAJ389jqCMt9jW233xKXTpMVvaYl38029XuQCFGAaYAGqbQhrGUqmvQZ2q26v/LTaEux1Ble8wRcjwuDb1Kmw8HTF1MgvIomtcEklwK+ZAtMfR1SdiP6fxCjReEVzUPAyVhjZtQwArypSVarm8yYcOmk1XK2rMGxOTgMrV7ArBzAJugCyULmuB0Xp2WbtBtZlTf1P5WFJMJ2m7JSn7upCZGyTCBoYvoDihypyJbJbOZ7cKobqyHDWkJKADCiUpB7V5K5K+GI8fx8T5MSfIe/B94nx2mx1GG4lQuW+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(186003)(478600001)(64756008)(53546011)(7416002)(6506007)(76116006)(66476007)(316002)(66446008)(8676002)(66556008)(110136005)(4326008)(86362001)(31686004)(6512007)(6486002)(83380400001)(2616005)(5660300002)(8936002)(26005)(36756003)(66946007)(2906002)(71200400001)(54906003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VDNlV3d5Z3VYU2pMb2xJZno0LzhURUtoK2lVOWhyL2ZvK2ptYTJEQmxZczNN?=
 =?utf-8?B?UjdLN1h6bndBL3NDV2JRNXQrWHdpakVmbVoyNXB0RUJXbEZ1UnN3YWFmTkpx?=
 =?utf-8?B?dzFSZHkybTNWc3NXZGZranN3Z0s1cFlCZDMza0JjL3piNFQxY0k2L0ljR3lR?=
 =?utf-8?B?ZWRQbm1sUFVWRnBQMjF0UWdoNXp0Q0pLMURQdkFDdHRZTERRM29RKzZrMDJ5?=
 =?utf-8?B?eGYvODkxYXlDcVZNOExTeTV3VGlUK2ZCQkN1SUJxTERsNVlyU2tEdGZTY2hJ?=
 =?utf-8?B?ZVNrdktyVXFNMEVHa0V5SCtnN0o1aGRZdVo4YkMwSXhHdHhsdWJwemd0MXVl?=
 =?utf-8?B?cDZMMHVFM0Y4dlRPZTFmdHdIWUlrcUYzZ3RhcU14NXFmNXBOMTNuSmRoeG5j?=
 =?utf-8?B?N0lmYjVpSkpOVWppZ0hWVVY2eXZWbkVCY1JtUTd1dEtPMmxJbXlLVStEVnVp?=
 =?utf-8?B?dWxXR1RjNXFibFVzUlNJbXVkNFpGbUxDcnd0RS9tYVRFeVlUNWxRREpCckE4?=
 =?utf-8?B?RWFXRVM1bzlnQUlZNUFuQ0I2OXhlWUVzaTQyZGdkQmFlUXh5bVU2NWNIQ3VL?=
 =?utf-8?B?SFNyN1ZuVkxaaFFGd3Q1eG1rdVI5U2VoRUIrOTdUN3dtWHpYWnlRNjgya2dD?=
 =?utf-8?B?NFYzZWhJNTQ1WmFBVmttUDBsNFRRa2NxSmRPVFNKVmdCd3F1YVZlekppMDZB?=
 =?utf-8?B?OFlHUHU4STlmaC9qUTI2N3Q1WlVOZzUwMllJa0Vud2xiRDJ2dGc1d0tXODNh?=
 =?utf-8?B?YStwZVNweHhsdXh3QnBUQXJhQWR4dmI3L3o1b0xXY25UT3BsZDFUUzVLb1pv?=
 =?utf-8?B?d01EWHI2V3RRSkRyeDVPZXdLZHFBZWV1dGVTYW0vTnpNVHVHV1BLd0hnQW52?=
 =?utf-8?B?RVFvK1UzazhuTThJVWVKek51R04yRU5qQWdVcEo5SVBDKzNKd2tRdFpmbStl?=
 =?utf-8?B?QUlWU2xYL1k4SU1wOUpzUTZiQ0xjVzlxMWQvUTRycXd2a212aTVFdUxGNElC?=
 =?utf-8?B?L2xLc01yRkxmV2JpUmpzQ24wUXJUem03VUE4UHdMTzl3b1Y4MW9sa2t2N0VS?=
 =?utf-8?B?d1owTXBGaVJnWkNYSG9KdTdEYk9GZlhMZkpnQU9kZHI1OWlxVzcwZWVXRUJ3?=
 =?utf-8?B?TlREYk9tWFlucWNhNEMzMmVsZHRhUlRxMFc3cllXV1FzVS91TjN2WWtsRzY5?=
 =?utf-8?B?SHNicUNyeFpUU29GeTVoMGRKd2xhQ3NHSVdyQUNrL3AyRlRlTHFqS2JCQm1r?=
 =?utf-8?B?WXQ0WFVaY2MydjhBTVZwSm54VVpMUFZ1bG52R1RBZTNselgwV1lUUEhmNVZv?=
 =?utf-8?Q?XEqghdENDhwdU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0D7618E4D2D2C498895ABF6B765E8CF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33db4fa-50fe-4119-cf27-08d8b8b50e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 17:51:44.3029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdQNd6RNtn+aKD53koscM2Hibozsolw+J9bNlwSAt0MkfNcAfqZb+/15Ul+RS2hik+SP6L01enf3LtSLD4TpCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3938
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xNC8yMSAzOjM1IEFNLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+IFRoZSAib3Byb2ZpbGUi
IHVzZXItc3BhY2UgdG9vbHMgZG9uJ3QgdXNlIHRoZSBrZXJuZWwgT1BST0ZJTEUgc3VwcG9ydA0K
PiBhbnkgbW9yZSwgYW5kIGhhdmVuJ3QgaW4gYSBsb25nIHRpbWUuIFVzZXItc3BhY2UgaGFzIGJl
ZW4gY29udmVydGVkIHRvDQo+IHRoZSBwZXJmIGludGVyZmFjZXMuDQo+DQo+IFJlbW92ZSB0aGUg
b2xkIG9wcm9maWxlJ3MgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHN1cHBvcnQuDQo+DQo+IFN1Z2dl
c3RlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPg0KPiBTdWdnZXN0
ZWQtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4g
U2lnbmVkLW9mZi1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCg0K
QWNrZWQtYnk6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4NCg0KSSBwcmVzdW1l
IHRoaXMgZG9lc24ndCBuZWVkIHRvIGdvIHRocm91Z2ggQVJDIHRyZWUuDQoNCi1WaW5lZXQNCg0K
PiAtLS0NCj4gICBhcmNoL2FyYy9LY29uZmlnICAgICAgICAgICB8ICAxIC0NCj4gICBhcmNoL2Fy
Yy9NYWtlZmlsZSAgICAgICAgICB8ICAyIC0tDQo+ICAgYXJjaC9hcmMvb3Byb2ZpbGUvTWFrZWZp
bGUgfCAxMCAtLS0tLS0tLS0tDQo+ICAgYXJjaC9hcmMvb3Byb2ZpbGUvY29tbW9uLmMgfCAyMyAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMzYgZGVsZXRpb25z
KC0pDQo+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJjL29wcm9maWxlL01ha2VmaWxlDQo+
ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJjL29wcm9maWxlL2NvbW1vbi5jDQo+DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FyYy9LY29uZmlnIGIvYXJjaC9hcmMvS2NvbmZpZw0KPiBpbmRleCBi
NTVjYTc3ZjYxOWIuLmJjOGQ2YWVjZmJiZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcmMvS2NvbmZp
Zw0KPiArKysgYi9hcmNoL2FyYy9LY29uZmlnDQo+IEBAIC0zNyw3ICszNyw2IEBAIGNvbmZpZyBB
UkMNCj4gICAJc2VsZWN0IEhBVkVfS1BST0JFUw0KPiAgIAlzZWxlY3QgSEFWRV9LUkVUUFJPQkVT
DQo+ICAgCXNlbGVjdCBIQVZFX01PRF9BUkNIX1NQRUNJRklDDQo+IC0Jc2VsZWN0IEhBVkVfT1BS
T0ZJTEUNCj4gICAJc2VsZWN0IEhBVkVfUEVSRl9FVkVOVFMNCj4gICAJc2VsZWN0IEhBTkRMRV9E
T01BSU5fSVJRDQo+ICAgCXNlbGVjdCBJUlFfRE9NQUlODQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
Yy9NYWtlZmlsZSBiL2FyY2gvYXJjL01ha2VmaWxlDQo+IGluZGV4IDU3OGJkYmJiMGZhNy4uNDM5
MmM5YzE4OWM0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9NYWtlZmlsZQ0KPiArKysgYi9hcmNo
L2FyYy9NYWtlZmlsZQ0KPiBAQCAtOTYsOCArOTYsNiBAQCBjb3JlLSQoQ09ORklHX0FSQ19QTEFU
X1RCMTBYKQkrPSBhcmNoL2FyYy9wbGF0LXRiMTB4Lw0KPiAgIGNvcmUtJChDT05GSUdfQVJDX1BM
QVRfQVhTMTBYKQkrPSBhcmNoL2FyYy9wbGF0LWF4czEweC8NCj4gICBjb3JlLSQoQ09ORklHX0FS
Q19TT0NfSFNESykJKz0gYXJjaC9hcmMvcGxhdC1oc2RrLw0KPiAgIA0KPiAtZHJpdmVycy0kKENP
TkZJR19PUFJPRklMRSkJKz0gYXJjaC9hcmMvb3Byb2ZpbGUvDQo+IC0NCj4gICBsaWJzLXkJCSs9
IGFyY2gvYXJjL2xpYi8gJChMSUJHQ0MpDQo+ICAgDQo+ICAgYm9vdAkJOj0gYXJjaC9hcmMvYm9v
dA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvb3Byb2ZpbGUvTWFrZWZpbGUgYi9hcmNoL2FyYy9v
cHJvZmlsZS9NYWtlZmlsZQ0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggNjk4
MzY3YmI0MWQwLi4wMDAwMDAwMDAwMDANCj4gLS0tIGEvYXJjaC9hcmMvb3Byb2ZpbGUvTWFrZWZp
bGUNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSwxMCArMCwwIEBADQo+IC0jIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+IC1vYmotJChDT05GSUdfT1BST0ZJTEUpICs9IG9wcm9m
aWxlLm8NCj4gLQ0KPiAtRFJJVkVSX09CSlMgPSAkKGFkZHByZWZpeCAuLi8uLi8uLi9kcml2ZXJz
L29wcm9maWxlLywgXA0KPiAtCQlvcHJvZi5vIGNwdV9idWZmZXIubyBidWZmZXJfc3luYy5vIFwN
Cj4gLQkJZXZlbnRfYnVmZmVyLm8gb3Byb2ZpbGVfZmlsZXMubyBcDQo+IC0JCW9wcm9maWxlZnMu
byBvcHJvZmlsZV9zdGF0cy5vIFwNCj4gLQkJdGltZXJfaW50Lm8gKQ0KPiAtDQo+IC1vcHJvZmls
ZS15CTo9ICQoRFJJVkVSX09CSlMpIGNvbW1vbi5vDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9v
cHJvZmlsZS9jb21tb24uYyBiL2FyY2gvYXJjL29wcm9maWxlL2NvbW1vbi5jDQo+IGRlbGV0ZWQg
ZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCA4NmJmNTg5OTUzM2IuLjAwMDAwMDAwMDAwMA0KPiAt
LS0gYS9hcmNoL2FyYy9vcHJvZmlsZS9jb21tb24uYw0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0x
LDIzICswLDAgQEANCj4gLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkN
Cj4gLS8qDQo+IC0gKiBDb3B5cmlnaHQgKEMpIDIwMDQsIDIwMDctMjAxMCwgMjAxMS0yMDEyIFN5
bm9wc3lzLCBJbmMuICh3d3cuc3lub3BzeXMuY29tKQ0KPiAtICoNCj4gLSAqIEJhc2VkIG9uIG9y
aWcgY29kZSBmcm9tIEBhdXRob3IgSm9obiBMZXZvbiA8bGV2b25AbW92ZW1lbnRhcmlhbi5vcmc+
DQo+IC0gKi8NCj4gLQ0KPiAtI2luY2x1ZGUgPGxpbnV4L29wcm9maWxlLmg+DQo+IC0jaW5jbHVk
ZSA8bGludXgvcGVyZl9ldmVudC5oPg0KPiAtDQo+IC1pbnQgX19pbml0IG9wcm9maWxlX2FyY2hf
aW5pdChzdHJ1Y3Qgb3Byb2ZpbGVfb3BlcmF0aW9ucyAqb3BzKQ0KPiAtew0KPiAtCS8qDQo+IC0J
ICogQSBmYWlsdXJlIGhlcmUsIGZvcmNlcyBvcHJvZmlsZSBjb3JlIHRvIHN3aXRjaCB0byBUaW1l
ciBiYXNlZCBQQw0KPiAtCSAqIHNhbXBsaW5nLCB3aGljaCB3aWxsIGhhcHBlbiBpZiBzYXkgcGVy
ZiBpcyBub3QgZW5hYmxlZC9hdmFpbGFibGUNCj4gLQkgKi8NCj4gLQlyZXR1cm4gb3Byb2ZpbGVf
cGVyZl9pbml0KG9wcyk7DQo+IC19DQo+IC0NCj4gLXZvaWQgb3Byb2ZpbGVfYXJjaF9leGl0KHZv
aWQpDQo+IC17DQo+IC0Jb3Byb2ZpbGVfcGVyZl9leGl0KCk7DQo+IC19DQoNCg==
