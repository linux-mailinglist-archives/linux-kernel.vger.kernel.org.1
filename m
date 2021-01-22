Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6B62FFEA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbhAVIst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:48:49 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:5887 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbhAVIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:47:54 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2021 03:47:52 EST
IronPort-SDR: PjNQOwFQ7W2pGZ3kFzeWPIEwS3/hhIBZ9j5NDQ3uAKUJDMCWS7nmdVVXJ/oLHDqQ7jyg7biyf4
 8RdxPDNvQHalW8+M2zJAac37oFFder1an8c22bIY/L7/gDWWLu7IzlYFRpZbmmgHsADpDoIKKo
 L7gM0O8BsbTzZANIg5SV8DjwunhR1Le4VgPzRpaHy8ngMMtcV9t0uI/HG8EC5/YN7GjYM1oxtV
 MApSDY4zBk/lUi85YDCuh+3JDpJvZzJQT+7+e6LWA5OM8AUpf8wsYQaKoNTLsU0NwtpgLiz7az
 0pc=
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="24882845"
X-IronPort-AV: E=Sophos;i="5.79,366,1602514800"; 
   d="scan'208";a="24882845"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:37:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYiwvv0Rvsihz37NOP/Sqj9hYwV5svWrnWxxjCqT43nrTLxZ/5QceU8rMOOicFyeOaXnxarzYbx1q+Fmo96SASlGysCnVhN7t4Yq9mAI7zsGisEo2GZfApRpNTtr/ZWfGfThzOWL3Lep/eSjo/XnX9IdVdRG4VGbX+qEWmaLAwYB36tjwYfvaV30h8zkxTW/oJBIAgmG7yzRb4A4aBnUY+o+DN3k2RnFtKmQVqoCttZmnPPBkCW0Hqc6cyJpVBZDqTlZIeElhPhdNo+PAXwbld83GHiHw7Iml1in1SIREKMcnV7QzOMSg0IHWvU+NsmpsYwas1bKcGlG2x82mIsYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8g1pigL/VUUNvDT7SXR4gVM5K0JCNbFoymnl+9mRmo=;
 b=gP93ByaMesNUWJcITneG/vZbS/MrMEf8bNjQvM+ByqySKaOrzmf25UyjwAdAbM+kd+4ZOTPhLys/7Q8KMg5XI868LBrSCjd+7jLwte8GxwCNhUAbeLELkEFiFcPvV+slnLUlL599zuwifEcGHYhUNmvEHs3ZoVUpZSHq61qHYiB4Y2QS7V6fYetr9TdaFHMlD7yUAHdCO1wBuXNsOt7vEcW/B6blAivfsgzAVY2GlBfa/ZqfBplfREgcjrh/SYhQEE83HuGUcmQFBmr8Eh1qcvt/S9JvIawxQ0bO2FwinXVcv+nzrFAe5Cep1OS9/vsst0PHTHJaByDIMiXiY0OrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8g1pigL/VUUNvDT7SXR4gVM5K0JCNbFoymnl+9mRmo=;
 b=hKGEA2bR2Zg2WNi5H8G1ZbsWalDNPp8xuJiJx6Nf3dmjHEOwenztXZXCbixJqgjdUVXLF2ZELzTEHpI83QA9VNR/EyAauaq+SPbljUWeBVJqYSO38PgKjA2PyccMQ/cpYqiWpyoSdoCDVL7dAptPk3Xo+NjMaspGuehBuT991KY=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB3496.jpnprd01.prod.outlook.com (2603:1096:604:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 08:37:12 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 08:37:12 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
Thread-Topic: [PATCH v2 3/3] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
Thread-Index: AQHW7+ShaO8SfWqmV0W2c0KaDfSTBaoyWX8AgADbuSA=
Date:   Fri, 22 Jan 2021 08:37:11 +0000
Message-ID: <OSBPR01MB4600A7B761F965C443D92DCFF7A00@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
 <20210121105425.2695843-4-nakamura.shun@jp.fujitsu.com>
 <a0f7c814-5c56-4e17-1198-a611d19f57d5@huawei.com>
In-Reply-To: <a0f7c814-5c56-4e17-1198-a611d19f57d5@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 9a0af97bf94340abbf49af54959ef156
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10597f8c-0323-4526-ff45-08d8beb0e9de
x-ms-traffictypediagnostic: OSBPR01MB3496:
x-microsoft-antispam-prvs: <OSBPR01MB3496A373D2A70BF8177DFE89F7A00@OSBPR01MB3496.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLtp/01eTV29nmmx5nKsykpbZcqp1Ec3acw3jwiZyAVMc9mjKEGqWJPZtldQpVu7EIJB9BSKI20cPT8A0eEUaCIgVMLWTLfU5JU/Ko+OGv7H6bsray/wX4DqaBQuERCRLcqvs+pZSRjN0AeV/Qu0CFx8zu0vtVR+Zdp4vInMUhs/ck+1IeZ315SufwHFWwqy+CudX/zH/zv5tDkXkXBdDJw2nzRZ5E2jeDJi4TkpwniL7j9iAgJv3pLzZ+jfsKxOyy5SDqIOpUqqZ+8tLCLxb9b+TNECyBBnXfWvVtbe9J9kIGfrYzD0bax8ACHeaO9RD6t39xdF1TwicIkKHLzf4iEYKg42h0ZE3YICafN0ES4IQ8pBY7Pzt1j7nv/ZR3ySoVDg0RFQbdt9MaApRthdTUgdwHos7+mRT4bV2B9SseQPgd/Y8lxQxc95f1b41onTSrzIVimCE2FXnlDzq9SgEayJfRnnbUS8JbuV9SLM2oOtG48BqQ68nqevyamMT4+rkUGrwi3KvyhM0rLYrVL1/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(966005)(66446008)(66556008)(66476007)(66946007)(52536014)(478600001)(5660300002)(316002)(4326008)(54906003)(76116006)(64756008)(53546011)(71200400001)(86362001)(9686003)(55016002)(26005)(186003)(6916009)(7696005)(83380400001)(6506007)(2906002)(85182001)(33656002)(8676002)(8936002)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QnhyakJWNEUzOThGQitmaG9PWGhHUDZkaFZFaGM3eklhdWluN2VKWUt0bHdT?=
 =?utf-8?B?RVQ1Vjl6YUdlWVBjZjZqTm1NWXNvd05aTFRFOFlYQ2hYQnM4VjRTWDNjTTRD?=
 =?utf-8?B?OHBqenMrRUtkbzhUdmZsejZkTWZ1NmJqa0xPZS9jSXA3eGFsQVJJZXQrdGpR?=
 =?utf-8?B?U1NZZXZjSkViNG5hcmNJa3I1dGxBamo5Q2NrWS9GUldMS1NPbGxFSUk2QmFB?=
 =?utf-8?B?ZWFoelc3dXg0d3d0Q1NiaFBJU1BQUGNHWnJ1M0hIb1JZOWsxSjg5YW54ZEF3?=
 =?utf-8?B?Qis2dUFyYjREeWJteVdmVVM0Z1FDRFFMYU9IcFdOMy9Nb2hRY2VaT0wzTzFF?=
 =?utf-8?B?S245Wk95TEJoMW05cU9wNXlkSTRCbVpuc25XNW5SMjN0WXhnVFhYeXhpNDFU?=
 =?utf-8?B?eE14UERYSlBHVk5nVCs1Wm43cVUrQ2o5aHh4L01veUl6VjBNR3NoOXljVnhC?=
 =?utf-8?B?UEwvYkxHLzI0cStmamNlZ3dLQWV0OGhmdkNwalN5V01wWmMyZFova1lwUGZx?=
 =?utf-8?B?czQyWlg0bmZpVEhRYlpYWkVwNVRwT3hLbnVqczZ5SFpmRzlZa0x5RWhmYWpq?=
 =?utf-8?B?V0pLa1crSHphWjllSlRpR1dEYUdjNW04ejd4TmVxZEI0TUIwbmVQSXNST0s1?=
 =?utf-8?B?RW5PNDlsZFZhUS8rc2c3amJGeGxtaEQvYXUyL2JxUFlYSGZNWWl6MzFJdGpl?=
 =?utf-8?B?dFVsNmtBNGZKQzhEUzhyZlpkQ1F2cVJuaVdoVzVQdFp6MGhWaVNzVEpCY2Vh?=
 =?utf-8?B?YnN2RTZESERndzhmeFJYenZjNmYvdXp4UGtHblpySGJmS3o1Q0VsNlVIT1gy?=
 =?utf-8?B?bDM4c29ycFZwY2I2RitwbGNrYkdwUVA3ZGhpUURrR1I4N0tuNU1IeEljZmIw?=
 =?utf-8?B?RWJ0ZmNGRWFlMEFVRlVtRE5GVEl4b3B5RFRBOGludmdidHFBTUZXTEx2cFJr?=
 =?utf-8?B?dlhoMFBUMWsyMytkWC9pQXdJZW1ERFExQTNKazZzTzM0Y1RNV2JKSTczeHlX?=
 =?utf-8?B?b2lkdnhOZ3VpaSt1V3ZsUks2blB2MGV6a2dmSnRUc2hERFNjTVdkRmwxYXNu?=
 =?utf-8?B?d0I0OFcxd2hHcnZ6eitnQ1A2ekhGKzIrVEJVOG5jQUhvMW5pSktrUG5qSU05?=
 =?utf-8?B?enFNc0VJc1J1T3dhMnBwRC9KYnZqaWpxWUVyWWVkLzd5MTJveVJkRk5Ib3VQ?=
 =?utf-8?B?Q3loaFl6MVpFSkxaUnQyRThJd3pwK0tHbXMzM3hNK25meVZlNk1FRjlIMXZp?=
 =?utf-8?B?akVTTnBJNUo2eEVDbWVBY2kwRTRha0NuN0FjdXl0dmZOQnhMTnk4a0VNZjYr?=
 =?utf-8?Q?FpfudQnM9mPLQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10597f8c-0323-4526-ff45-08d8beb0e9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 08:37:11.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ss5Cr0bN9doOwxaIW/YLieKLpZWJbjbRw3vqtUgAybhf2JD1MoxXdhoRgMVu6AhUX7N0okVL3W/xtS6a5/DrERvSy6LPBdtR9C0tXFZtxLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3496
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9obg0KDQo+IEkgdGhpbmsgdGhhdCB3ZSBuZWVkIHRvIHRoZSBzYW1lIGhlcmUgYXMgdGhl
IElNUERFRiByZWNvbW1lbmRlZCBldmVudHMgLSBhZGQgYQ0KPiBjb21tb24gSlNPTiB0byByZWR1
Y2UgdGhlIGR1cGxpY2F0aW9uLg0KPiANCj4gSSBoYWQgZG9uZSB3b3JrIG9uIHRoaXMgZm9yIGN1
cnJlbnQgQ1BVcywgYnV0IG5ldmVyIGdvdCBpdCBmaW5pc2hlZC4gTGV0IG1lIGNoZWNrDQo+IHRo
ZSBzdGF0dXMuDQoNCklmIHlvdSBsZXQgbWUga25vdyB0aGUgcmVzdWx0LCBJIHdpbGwgcmVzZW5k
IHRoZSBwYXRjaCBhY2NvcmRpbmcgdG8gdGhlIHBvbGljeS4NCg0KQmVzdCBSZWdhcmRzDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBHYXJyeSA8am9obi5nYXJy
eUBodWF3ZWkuY29tPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMjIsIDIwMjEgMjo0MSBBTQ0K
PiBUbzogTmFrYW11cmEsIFNodW5zdWtlL+S4readkSDkv4rku4sgPG5ha2FtdXJhLnNodW5AZnVq
aXRzdS5jb20+DQo+IENjOiB3aWxsQGtlcm5lbC5vcmc7IG1hdGhpZXUucG9pcmllckBsaW5hcm8u
b3JnOyBsZW8ueWFuQGxpbmFyby5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDMvM10gcGVyZiB2ZW5kb3IgZXZlbnRzOiBBZGQgRnVqaXRzdSBBNjRGWCBWMS4yIHBt
dQ0KPiBldmVudA0KPiANCj4gT24gMjEvMDEvMjAyMSAxMDo1NCwgU2h1bnN1a2UgTmFrYW11cmEg
d3JvdGU6DQo+ID4gKyAgew0KPiA+ICsgICAgIlB1YmxpY0Rlc2NyaXB0aW9uIjogIlRoaXMgZXZl
bnQgY291bnRzIGVhY2ggY29ycmVjdGlvbiB0byB0aGUgcHJlZGljdGVkDQo+IHByb2dyYW0gZmxv
dyB0aGF0IG9jY3VycyBiZWNhdXNlIG9mIGEgbWlzcHJlZGljdGlvbiBmcm9tLCBvciBubyBwcmVk
aWN0aW9uIGZyb20sDQo+IHRoZSBicmFuY2ggcHJlZGljdGlvbiByZXNvdXJjZXMgYW5kIHRoYXQg
cmVsYXRlcyB0byBpbnN0cnVjdGlvbnMgdGhhdCB0aGUgYnJhbmNoDQo+IHByZWRpY3Rpb24gcmVz
b3VyY2VzIGFyZSBjYXBhYmxlIG9mIHByZWRpY3RpbmcuIiwNCj4gPiArICAgICJFdmVudENvZGUi
OiAiMHgxMCIsDQo+ID4gKyAgICAiRXZlbnROYW1lIjogIkJSX01JU19QUkVEIiwNCj4gDQo+IEkg
dGhpbmsgdGhhdCB3ZSBuZWVkIHRvIHRoZSBzYW1lIGhlcmUgYXMgdGhlIElNUERFRiByZWNvbW1l
bmRlZCBldmVudHMgLSBhZGQgYQ0KPiBjb21tb24gSlNPTiB0byByZWR1Y2UgdGhlIGR1cGxpY2F0
aW9uLg0KPiANCj4gSSBoYWQgZG9uZSB3b3JrIG9uIHRoaXMgZm9yIGN1cnJlbnQgQ1BVcywgYnV0
IG5ldmVyIGdvdCBpdCBmaW5pc2hlZC4gTGV0IG1lIGNoZWNrDQo+IHRoZSBzdGF0dXMuDQo+IA0K
PiBDaGVlcnMsDQo+IEpvaG4NCj4gDQo+IFBzLCBhcm0gaGF2ZSBwdXQgSlNPTnMgaGVyZSBmb3Ig
dGhlaXIgY29yZXM6DQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20vQVJNLXNvZnR3YXJlL2RhdGEv
dHJlZS9tYXN0ZXIvcG11DQo+IA0KPiBCdXQgdW5mb3J0dW5hdGVseSB0aGUgc2NoZW1hIGRvZXMg
bm90IHN1aXQgcGVyZi4NCj4gDQo+IEkgcmFpc2VkIGFuIGlzc3VlLCBidXQgbm8gcmVzcG9uc2Uu
DQo+IA0KPiBJJ20ganVzdCB3b25kZXJpbmcgaWYgeW91IGhhbmQgY29waWVkIHRoZSBKU09OIGRh
dGEuDQo+IA0KPiANCj4gPiArICAgICJCcmllZkRlc2NyaXB0aW9uIjogIlRoaXMgZXZlbnQgY291
bnRzIGVhY2ggY29ycmVjdGlvbiB0byB0aGUgcHJlZGljdGVkDQo+IHByb2dyYW0gZmxvdyB0aGF0
IG9jY3VycyBiZWNhdXNlIG9mIGEgbWlzcHJlZGljdGlvbiBmcm9tLCBvciBubyBwcmVkaWN0aW9u
IGZyb20sDQo+IHRoZSBicmFuY2ggcHJlZGljdGlvbiByZXNvdXJjZXMgYW5kIHRoYXQgcmVsYXRl
cyB0byBpbnN0cnVjdGlvbnMgdGhhdCB0aGUgYnJhbmNoDQo+IHByZWRpY3Rpb24gcmVzb3VyY2Vz
IGFyZSBjYXBhYmxlIG9mIHByZWRpY3RpbmcuIg0KPiA+ICsgIH0sDQoNCg==
