Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2FE2ABDD3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgKINuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:50:44 -0500
Received: from mail-dm6nam12on2091.outbound.protection.outlook.com ([40.107.243.91]:14688
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbgKINuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:50:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex5AK7W5Vaw1lLhQM0PjLcPu7co3jyagAcjlMBfs7fAAwqy2jYJ2+gpVmFncu5Tvd13D98JWEhNkH5mzjpL6g07yPZiZEaHOfukUoCaOvJlHE7agoPTWbB6WlGCbX79xbmUPjNfrBh73hxwHpLhwQW5jHtQJvjzADfFmBqHJxiXJLWtszdEQN1ZFkFJafn6oUvMIJE6kla1qgagosIlmUmzs73dNnwhS9mN5E/Exy+HwVGnivyYT56/C3UTazEQn8CrYE3ydOwWtPPx/t+BCrXquIefewct2wa7dZi8G4eThCqPGz33/RqO2TljXltvKcMaFo5wR4SsB+IYMVO0uGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5R+OqaUeihmHqO6WeNPWXRrrFgcNq340wTsChhuhBs=;
 b=lcq66uJvdUa5/qeM4AYI4TL6r16e9TYkHuJgtgyc6ZDh4pT67ycg5ijQW//DktMvtlWeSXgw0mOp8zfImjXsuF1D2SoR+c+PANHOlLLuW7ngMbU5FxZR6gybOoTCHBi3j9aZ3gqCtoPi8pUYT167LSNPvAOzwWd/zkg9toeJvA79EJbefZCDG2HnhHRNiOFcHVtQAkXVrlm+iOnTuP8Su0k+WK0Mkmt7V79lst2TnXOHbYvN9lPHX/vkGWNl+s2cucIi+/CWvNTON/dwCzRLFxRS0bAmfHg5wcTNpBYffXqoBN7iMl1QEhEMxPxlFOGqVd9wbDB/rGwm5wbDzaNWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5R+OqaUeihmHqO6WeNPWXRrrFgcNq340wTsChhuhBs=;
 b=ePUbZztsXDf7DiHCJ94L9/pC8jltksEg27z8t6HmJC10/iAZwSKXojHhGrhF3NJ9vevIKD381+A6qWxf0Mh/kvBC2BjMpTg+JeSYAwlEUYj3EqE6M4zvqy3CEHqmDmzeAVyPcFlJTGcU/RjQQExLWcFLf6adjTmIz75SD3ZEgAE=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB4088.namprd13.prod.outlook.com (2603:10b6:208:262::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Mon, 9 Nov
 2020 13:50:40 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Mon, 9 Nov 2020
 13:50:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Thread-Topic: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Thread-Index: AQHWtkPENGqm3GxOSkGvPzbAsELwtqm/cEoAgABhygA=
Date:   Mon, 9 Nov 2020 13:50:40 +0000
Message-ID: <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
         <20201109080038.GY2594@hirez.programming.kicks-ass.net>
In-Reply-To: <20201109080038.GY2594@hirez.programming.kicks-ass.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98fd60b2-99e9-439c-5205-08d884b6720c
x-ms-traffictypediagnostic: MN2PR13MB4088:
x-microsoft-antispam-prvs: <MN2PR13MB40886BD82BBB2879D7BB9D90B8EA0@MN2PR13MB4088.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vS3huW0KobJUbV/KOBJkrkcU619L2kWRuIDbleqHvYFipuywd+JhfYW3wMnLvnB2aqBkoyzUrEZ9iDFYM7c43FsNMKYAxu5b+WMJrUpwf0DoJznxkyvZLqdgFUfrikd1W86eBayZYsQ5Te7BsXD+6wcYAK//T7JQQXtYXOU9TDVWxO8VgT8EXFDF9D712dsrmjbilY0g7oAtBYjPEMPNCNu5O2qP7iA/YiSXOLGBE/DXCLVqiU+AveaKpqTOKyi9mBJ5Lj94LECQ8wgaIEpY9ta0yzNqD7QwtjLuE53jWS782wpudmHOdugML3p5rXqxqrYlwHiMMpcFkW0ZIp9tBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(39830400003)(396003)(2616005)(64756008)(66446008)(110136005)(6512007)(6486002)(5660300002)(6506007)(26005)(2906002)(54906003)(8936002)(186003)(36756003)(91956017)(4326008)(66476007)(76116006)(8676002)(66946007)(316002)(86362001)(478600001)(71200400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hmDs3mvAHxXvdXY5nhmXoM7heaThj0Tqg0KlOYhXDZ6rHWkRiReVlsmhjC0yZcWndrKW05MGvmHfNHPTKhrq/TGHPPA8KRBy2sDUg6Tvfmp8Zr0z3wdqm0oKMdfUpeEJ9h0AXr1VtJc5pOQxcn6HizAiAUb13L9ZrUZPbLCU+MBrjUKhaFlIyFanUvIfLiWjNO0pMsdaMBu0HJ8sYY7sZ+BnZSSrNGWajS2mOy4wBJFBSFUkUBGCT2ZRw+0dKivXso43L27LXPUZcRngpGJH1j0lV3lSuLkxKWHj96rUWn9zLYHpyILTIKNqB5TETD4NrSOGljLA0MgW9nqRHD+z/ySX1OupmbGPHWatwz44xC8CmFMjoBShXVcuJ4lTagLjReP4JaXXCEL5Xeu6b2pF1lmC6rpch1Pc9OaNrUJqr0W26JuyzF76vKucmQh50EeCcbjUcDYmcWQ7mGtyUES9GBZQdaVy/fZrCRgYqkYBrukRLa4s138ny7Liz1eXVVH7YL6iX5sDFqong0jdV+ZcVhTf5W75UYGIxTnehR46DHVFojgktbDvM5n/bxhqm/wKcAdqZ1989ucl66y/g6s/HHMYGS43RH3IFbLemKHoZ77CuudgsWcTPaiU48nSlp+RLJ0xPL44EFKpKmOJJZS2Bg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B3B2E4D1EA4C6469EE717EC4E176A4C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fd60b2-99e9-439c-5205-08d884b6720c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 13:50:40.3736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8d/ikA3sT6s5b315kBuF0wEwjjNZeTBm9WerdJ04eEgs3La8imO6R8o0i2oNfODiWKhqyiF/8xN923pLUcXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTA5IGF0IDA5OjAwICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gTW9uLCBOb3YgMDksIDIwMjAgYXQgMDE6NTQ6NTlQTSArMTEwMCwgTmVpbEJyb3duIHdy
b3RlOg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVkLmggYi9pbmNsdWRlL2xp
bnV4L3NjaGVkLmgNCj4gPiBpbmRleCA0NDE4ZjVjYjgzMjQuLjcyODg3MDk2NWRmMSAxMDA2NDQN
Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L3NjaGVkLmgNCj4gPiBAQCAtMTc4NCw3ICsxNzg0LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50DQo+
ID4gdGVzdF90c2tfbmVlZF9yZXNjaGVkKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKQ0KPiA+IMKg
I2lmbmRlZiBDT05GSUdfUFJFRU1QVElPTg0KPiA+IMKgZXh0ZXJuIGludCBfY29uZF9yZXNjaGVk
KHZvaWQpOw0KPiA+IMKgI2Vsc2UNCj4gPiAtc3RhdGljIGlubGluZSBpbnQgX2NvbmRfcmVzY2hl
ZCh2b2lkKSB7IHJldHVybiAwOyB9DQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IF9jb25kX3Jlc2No
ZWQodm9pZCkNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChjdXJyZW50LT5mbGFncyAm
IFBGX1dRX1dPUktFUikNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd29ya3F1
ZXVlX2NvbmRfcmVzY2hlZCgpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPiA+ICt9
DQo+ID4gwqAjZW5kaWYNCj4gPiDCoA0KPiA+IMKgI2RlZmluZSBjb25kX3Jlc2NoZWQoKSAoe8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPiANCj4gPiBkaWZm
IC0tZ2l0IGEva2VybmVsL3NjaGVkL2NvcmUuYyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMNCj4gPiBp
bmRleCA5YTJmYmY5OGZkNmYuLjViMmUzODU2N2EwYyAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwv
c2NoZWQvY29yZS5jDQo+ID4gKysrIGIva2VybmVsL3NjaGVkL2NvcmUuYw0KPiA+IEBAIC01NjIw
LDYgKzU2MjAsOCBAQCBTWVNDQUxMX0RFRklORTAoc2NoZWRfeWllbGQpDQo+ID4gwqAjaWZuZGVm
IENPTkZJR19QUkVFTVBUSU9ODQo+ID4gwqBpbnQgX19zY2hlZCBfY29uZF9yZXNjaGVkKHZvaWQp
DQo+ID4gwqB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGN1cnJlbnQtPmZsYWdzICYgUEZfV1Ff
V09SS0VSKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3b3JrcXVldWVfY29u
ZF9yZXNjaGVkKCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChzaG91bGRfcmVzY2hlZCgwKSkg
ew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJlZW1wdF9zY2hlZHVsZV9j
b21tb24oKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAxOw0K
PiANCj4gDQo+IE11Y2ggaGF0ZSBmb3IgdGhpcy4uIDovIGNvbmRfcmVzY2hlZCgpIHNob3VsZCBi
ZSBhIE5PUCBvbiAhUFJFRU1QVA0KPiBhbmQNCj4geW91IHdyZWNrIHRoYXQuIEFsc28sIHlvdSBj
YWxsIGludG8gdGhhdCB3b3JrcXVldWVfY29uZF9yZXNjaGVkKCkNCj4gdW5jb25kaXRpb25hbGx5
LCBldmVuIHdoZW4gaXQgd291bGRuJ3QgaGF2ZSByZXNjaGVkdWxlZCwgd2hpY2ggc2VlbXMNCj4g
dmVyeSB3cm9uZyB0b28uDQo+IA0KPiBPbiB0b3Agb2YgYWxsIHRoYXQsIHlvdSdyZSBhZGRpbmcg
YW4gZXh0cmEgbG9hZCB0byB0aGUgZnVuY2lvbiA6Lw0KPiANCj4gQXQgc29tZSBwb2luZSBQYXVs
IHRyaWVkIHRvIGZyb2IgY29uZF9yZXNjaGVkKCkgZm9yIFJDVSBhbmQgcmFuIGludG8NCj4gYWxs
DQo+IHNvcnRzIG9mIHBlcmZvcm1hbmNlIGlzc3VlcywgSSdtIHRoaW5raW5nIHRoaXMgd2lsbCB0
b28uDQo+IA0KPiANCj4gR29pbmcgYnkgeW91ciBqdXN0aWZpY2F0aW9uIGZvciBhbGwgdGhpczoN
Cj4gDQo+ID4gSSB0aGluayB0aGF0IG9uY2UgYSB3b3JrZXIgY2FsbHMgY29uZF9yZXNjaGVkKCks
IGl0IHNob3VsZCBiZQ0KPiA+IHRyZWF0ZWQgYXMNCj4gPiB0aG91Z2ggaXQgd2FzIHJ1biBmcm9t
IGEgV1FfQ1BVX0lOVEVOU0lWRSBxdWV1ZSwgYmVjYXVzZSBvbmx5IGNwdS0NCj4gPiBpbnRlbnNp
dmUNCj4gPiB0YXNrcyBuZWVkIHRvIGNhbGwgY29uZF9yZXNjaGVkKCkuwqAgVGhpcyB3b3VsZCBh
bGxvdyBvdGhlciB3b3JrZXJzDQo+ID4gdG8gYmUNCj4gPiBzY2hlZHVsZWQuDQo+IA0KPiBJJ20g
dGhpbmtpbmcgdGhlIHJlYWwgcHJvYmxlbSBpcyB0aGF0IHlvdSdyZSBhYnVzaW5nIHdvcmtxdWV1
ZXMuIEp1c3QNCj4gZG9uJ3Qgc3R1ZmYgc28gbXVjaCB3b3JrIGludG8gaXQgdGhhdCB0aGlzIGJl
Y29tZXMgYSBwcm9ibGVtLiBPcg0KPiByYXRoZXIsDQo+IGlmIHlvdSBkbywgZG9uJ3QgbGllIHRv
IGl0IGFib3V0IGl0Lg0KDQpJZiB3ZSBjYW4ndCB1c2Ugd29ya3F1ZXVlcyB0byBjYWxsIGlwdXRf
ZmluYWwoKSBvbiBhbiBpbm9kZSwgdGhlbiB3aGF0DQppcyB0aGUgcG9pbnQgb2YgaGF2aW5nIHRo
ZW0gYXQgYWxsPw0KDQpOZWlsJ3MgdXNlIGNhc2UgaXMgc2ltcGx5IGEgZmlsZSB0aGF0IGhhcyBt
YW5hZ2VkIHRvIGFjY3VtdWxhdGUgYQ0Kc2VyaW91c2x5IGxhcmdlIHBhZ2UgY2FjaGUsIGFuZCBp
cyB0aGVyZWZvcmUgdGFraW5nIGEgbG9uZyB0aW1lIHRvDQpjb21wbGV0ZSB0aGUgY2FsbCB0byB0
cnVuY2F0ZV9pbm9kZV9wYWdlc19maW5hbCgpLiBBcmUgeW91IHNheWluZyB3ZQ0KaGF2ZSB0byBh
bGxvY2F0ZSBhIGRlZGljYXRlZCB0aHJlYWQgZm9yIGV2ZXJ5IGNhc2Ugd2hlcmUgdGhpcyBoYXBw
ZW5zPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
