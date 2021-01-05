Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0E2EB3E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbhAEUHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:07:16 -0500
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56]:46524
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbhAEUHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:07:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7VHR06VxdcbaoVUaa9iSpYD+cygSKc3CxLbPr/6OhSXdy3JV0kBxZCLBfHFk/Yv6f/ipDVVrnB6WubgWykDBL4zEa74LOLQJ691iCWL26Iif76L2ZkG1gnfVY9XsZiLAvaerCZnEwyohIg/h1qpnMPlMrovLb8MaQu5t+jmBVtOm/oDmHu79klJuuajRLXK9g5zR/fR6linAAOvCVZ5QG5h3x5LLZG+a5DruaWYITy6XSfCzLQIDlAH/69iuIUDxe8De/Sa+lesHqBmveGlo0MFq5FclkK2RybEdXKMOe6y8D9L9vfjS3REb1Wx1WSaZloP87rDvv18H+zHvWjhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3pvTGZB/TSjIpzud38OHV2SWAuL7C6NcKhPE+gHDhc=;
 b=M6XJAlkYyoR/Lb6fPbRQNkDh3eUMY0BDEhcDsFAieXqUKfUCs9DVp1260y9JG14K6fS0d2grp8U8Drew4J3n3mF4oYAc/FUL9XbqXq2b3Jh7DiH+2fIJE8KQq/X5qO32C71i63drJzsn1kzWkiLVgUiEM0l6irg1GWefksFCLvV3QPNtTKpFFGwc6A4j6/Ima8tZvF43nigwhH6iRwJb7CH76pxcnGxKX3zg8LIzlSFIWXEbOVkVr8tkyA6z+gt6in8987s1OpUTry1AOjd3PIj7a6NPZTIvCi8tegxbnaYH6DoUbRiji1u5Bura/vyIk4yiM8OGw3hBli/a1hyq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3pvTGZB/TSjIpzud38OHV2SWAuL7C6NcKhPE+gHDhc=;
 b=l+ZfP4BQ5TeZeJvHb4xJtWgJxyzGzpkdnrzgHviQ4fwsSiBcwXvlLASYoDj80edM6R3Ma4UAf93upu/wVoDQPsJNB2/q6s44TuF307cFTKkZ7He2T0tN5hIxTWuSiBuUPgeafJbVjcteyt5SZCxV9wbw46KBLBo6d6RaCIUtyfM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4198.namprd05.prod.outlook.com (2603:10b6:a02:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4; Tue, 5 Jan
 2021 20:06:22 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7%6]) with mapi id 15.20.3742.006; Tue, 5 Jan 2021
 20:06:22 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
CC:     Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Topic: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Index: AQHW4pRwZnSKvT4iE02cPjpfTbkFJKoX2VMAgAAC64CAAAyGAIAABYKAgAAGJYCAAAb4gIABZVoAgAAFh4CAAAtMgIAABb+A
Date:   Tue, 5 Jan 2021 20:06:22 +0000
Message-ID: <91523A61-1AF8-48F9-8650-D313032E550C@vmware.com>
References: <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
 <X/N4aqRgyxffhMSs@redhat.com>
 <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
 <X/OCMalFYnDdGnch@redhat.com>
 <2844ACC1-8908-494C-B411-3C69B27A1730@vmware.com>
 <X/SzzjREaoR9u7Ua@redhat.com>
 <BABCB1DE-C41E-4C3E-90D1-5893585FB68A@vmware.com>
 <X/TB6ztitnESl3qZ@redhat.com>
In-Reply-To: <X/TB6ztitnESl3qZ@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83983c78-8afd-4031-d9e5-08d8b1b55f85
x-ms-traffictypediagnostic: BYAPR05MB4198:
x-microsoft-antispam-prvs: <BYAPR05MB41987A011053C0437F1279EED0D10@BYAPR05MB4198.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzHTJiA3OX8m+wJjDmH8CD/Ef3xNRELHZH6lCIfUIYYQGl86N4IUY+cYuK+nv+y1+AQ4Pe71KVZNhzwNyKFPdEDipYcn/MztPm+AlcYPKj2aRb/kUAJ+ctLZ07sN2K2mKZz3jxaD4uzG5Q3CIRQzQYoFrMONzbjSLMSMy5UIzvVTBt+9VBTkzhlCP7fduIAMEqcHqj0QXxHQciJcoO5Lq8z7oiMYfU717J8e4DYaEeeOGmUhIKYtWR5iesP9bPge0yOtjxq8gdyIU08CsUC7Hbfaa582Bofhs/SDYH2wv6OwxfSYNB4DTRqiyEuBAAUVXymQbNagmr6B0Hlg3qvKT+lv1JcCe6P2WwxwkI8c/sGaXuvbILPT7Xh8vipS18X9TL7ychrbDClrqtL1MFa9r0Nl2z0XEtwNvp+JoQcl3U5BFygmGAee+z/xkeBMeudK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(33656002)(66946007)(66446008)(54906003)(64756008)(66556008)(36756003)(76116006)(66476007)(2616005)(6486002)(316002)(83380400001)(8676002)(478600001)(8936002)(86362001)(6916009)(7416002)(6506007)(6512007)(2906002)(53546011)(26005)(5660300002)(71200400001)(4326008)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NWJPRE5ieHlzSXpOWTB5UUlYQnI2Slg4Y25kMzNWQzdGcmZRK1F1ZlRObHFy?=
 =?utf-8?B?elZGRTNKOG9FUHNLbC9lNXhVM0pDQkpVYVF1bTU0TzBtRzJvbDNYR1dGakty?=
 =?utf-8?B?UHMwSFhuZGNxbnM0cnBVTndnNnYzS2hYaGJhN25ET2tleUZHTVBDelU0dkdD?=
 =?utf-8?B?ZDNyTGFSekh4bmxDSXNzMjhSdXdKYi80cU5zMldKQ214MVFRUlpPVzRwS2VI?=
 =?utf-8?B?eDg4YUNBaEV5MkR1YkFuTEt1OHJXVG5RZ2UwbmJZUmpvRityTjhSeEh1ZU55?=
 =?utf-8?B?YUxCazg1bzlyUGttR3prSmlpaEVHaHVvamtjNUVjVXU4Wk52WlFHOXplWEx2?=
 =?utf-8?B?RjZKelMrZnMzMEFvSTE4d290c1ByYXpHQS9mYWVFaVF5eE1INExqT0pzUExs?=
 =?utf-8?B?WnNIVnZ4a1VzY2VtVXVCUDZadXJDZDFKSEFzbnpyODVlRjV1b2FWMzk3dHg1?=
 =?utf-8?B?eFJnbzd0UUJMMWJTL2NiSFJXM2ZxWnVLSzJOM3pCMW9sYmo0WU92T1pjSUpM?=
 =?utf-8?B?bDRRN1RlNk1JNE1hZ0F3NXpsMmRNZUxMVGs4c2NocDduaDRSK0F2NXlScFhJ?=
 =?utf-8?B?NnpmZzAvcXZROHZPVmpkTlJjdE44Y3BOZG9MVUJzTHRZcFNRbjhPYXV1QjFy?=
 =?utf-8?B?TFVmRW1sdHAwTElhcVorSEN5MnhueENoWlRoejRaOEt2V1hpZGN0b1pLZGRh?=
 =?utf-8?B?RzZrQ3hGa0x1cWRtbUxzbjNJZ3BFU2lCby91TTZXTFI2NnNaeUQ1VlRLSmdL?=
 =?utf-8?B?T1Nuc0NsNGJTTjlOeEVSN0lhYTAvZkVmOEhYWnFvWml6VDI0cFlHTnRJa0E3?=
 =?utf-8?B?YXdlU2JobXh1dWVwVzFhWFNnWlRocWdZSlRmNkNrbE5Pb0h3cnJlSXFPTjM4?=
 =?utf-8?B?a0dlSExnTVJoOXVxTWQ5L2ZHUmdRMlR5Uk1rUjVZWG5aaDJKOFI5cTlzN0lE?=
 =?utf-8?B?bEE4VFJmSlRlbnVha0R1ZHVIQW9vM2k2b04rUUZha2U0d3FyZjM1dFBzaW8x?=
 =?utf-8?B?SUdweHdWNnU5ZDlxeDZHbCtRWmdqUkoySHFobi84NEpHTkRZOHcrb010TVpL?=
 =?utf-8?B?SVdQazhiNk4wZGx3R2habUY4ZExoRG9GcjAyWHgvUEVLY1VhOXJyRTUvTlVl?=
 =?utf-8?B?RDIzTUJBTlBFZ2NZdmZ2VUlXMWl3RFEwbXRBNEJZdGNRNzF0Y0Z3VTRoSkRU?=
 =?utf-8?B?ZUFDOTVzWFhSRjZvWnd3THlaREpVcXRkOWJxQXVIZjRnaCtOS29sTWJvNkUy?=
 =?utf-8?B?cXQ2cStYdkl4NW8vUXZGY1d1dHZjRjhHb2VzLzFPWTlpSzk1ZnkxeWZqU2JT?=
 =?utf-8?Q?pajoJSLFliu1DHLbt0+C+T/kb5WacYLHE8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E69E0B183CC7494BBCED06E2E598E6CF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83983c78-8afd-4031-d9e5-08d8b1b55f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 20:06:22.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHVtchwizhvp28nuOoFOVp9J7+PVFQxtJ2rV3PwFZ/qGIBhfSUeC2cAkmDU2TeuwqrtVyFrtOe5pWKKMHGPoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4198
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gNSwgMjAyMSwgYXQgMTE6NDUgQU0sIEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdl
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKYW4gMDUsIDIwMjEgYXQgMDc6MDU6
MjJQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+PiBPbiBKYW4gNSwgMjAyMSwgYXQgMTA6
NDUgQU0sIEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdlQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+
IEkganVzdCBkb24ndCBsaWtlIHRvIHNsb3cgZG93biBhIGZlYXR1cmUgcmVxdWlyZWQgaW4gdGhl
IGZ1dHVyZSBmb3INCj4+PiBpbXBsZW1lbnRpbmcgcG9zdGNvcHkgbGl2ZSBzbmFwc2hvdHRpbmcg
b3Igb3RoZXIgc25hcHNob3RzIHRvIHVzZXJsYW5kDQo+Pj4gcHJvY2Vzc2VzIChmb3IgdGhlIG5v
bi1LVk0gY2FzZSwgYWxzbyB1bnByaXZpbGVnZWQgYnkgZGVmYXVsdCBpZiB1c2luZw0KPj4+IGJv
dW5jZSBidWZmZXJzIHRvIGZlZWQgdGhlIHN5c2NhbGxzKSB0aGF0IGNhbiBiZSB1c2VkIGJ5IG9w
ZW4gc291cmNlDQo+Pj4gaHlwZXJ2aXNvcnMgdG8gYmVhdCBwcm9wcmlldGFyeSBoeXBlcnZpc29y
cyBsaWtlIHZtd2FyZS4NCj4+IA0KPj4gT3VjaCwgdGhhdOKAmXMgdW5jYWxsZWQgZm9yLiBJIGFt
IHN1cmUgdGhhdCB5b3UgdW5kZXJzdGFuZCB0aGF0IEkgaGF2ZSBubw0KPj4gaGlkZGVuIGFnZW5k
YSBhbmQgd2UgYWxsIGhhdmUgdGhlIHNhbWUgZ29hbC4NCj4gDQo+IEVobSBJIG5ldmVyIHNhaWQg
eW91IGhhZCBhbiBoaWRkZW4gYWdlbmRhLCBzbyBJJ20gbm90IGV4YWN0bHkgd2h5DQo+IHlvdSdy
ZSBhY2N1c2luZyBtZSBvZiBzb21ldGhpbmcgSSBuZXZlciBzYWlkLg0KPiANCj4gSSBtZXJlbHkg
cG9pbnRlZCBvdXQgb25lIHJlbGV2YW50IGp1c3RpZmljYXRpb24gZm9yIGluY3JlYXNpbmcga2Vy
bmVsDQo+IGNvbXBsZXhpdHkgaGVyZSBieSBub3Qgc2xvd2luZyBkb3duIGNsZWFyX3JlZnMgbG9u
Z3N0YW5kaW5nIE8oTikNCj4gY2xlYXJfcmVmcy9zb2Z0ZGlydHkgZmVhdHVyZSBhbmQgdGhlIHJl
Y2VudCB1ZmZkLXdwIE8oMSkgZmVhdHVyZSwgaXMNCj4gdG8gYmUgbW9yZSBjb21wZXRpdGl2ZSB3
aXRoIHByb3ByaWV0YXJ5IHNvZnR3YXJlIHNvbHV0aW9ucywgc2luY2UNCj4gYXQgbGVhc3QgZm9y
IHVmZmQtd3AsIHBvc3Rjb3B5IGxpdmUgc25hcHNob3R0aW5nIHRoYXQgdGhlICMxIHVzZQ0KPiBj
YXNlLg0KPiANCj4gSSBuZXZlciBxdWVzdGlvbmVkIHlvdXIgY29udHJpYnV0aW9uIG9yIHlvdXIg
cHJlZmVyZW5jZSwgdG8gYmUgZXZlbg0KPiBtb3JlIGV4cGxpY2l0LCBpdCBuZXZlciBjcm9zc2Vk
IG15IG1pbmQgdGhhdCB5b3UgaGF2ZSBhbiBoaWRkZW4NCj4gYWdlbmRhLg0KPiANCj4gSG93ZXZl
ciBzaW5jZSBldmVyeW9uZSBhbHJlYWR5IGFja2VkIHlvdXIgcGF0Y2hlcyBhbmQgSSdtIG5vdCBv
ayB3aXRoDQo+IHlvdXIgcGF0Y2hlcyBiZWNhdXNlIHRoZXkgd2lsbCBnaXZlIGEgaGl0IHRvIEtW
TSBwb3N0Y29weSBsaXZlDQo+IHNuYXBzaG90dGluZyBhbmQgb3RoZXIgY29udGFpbmVyIGNsZWFy
X3JlZnMgdXNlcnMsIEkgaGF2ZSB0byBqdXN0aWZ5DQo+IHdoeSBJIE5BSyB5b3VyIHBhdGNoZXMg
YW5kIHJlbWFpbmluZyBjb21wZXRpdGl2ZSB3aXRoIHByb3ByaWV0YXJ5DQo+IGh5cGVydmlzb3Jz
IGlzIG9uZSBvZiB0aGVtLCBzbyBJIGRvbid0IHNlZSB3aGF0IGlzIHdyb25nIHRvIHN0YXRlIGEN
Cj4gdGFuZ2libGUgZW5kIGdvYWwgaGVyZS4NCg0KSSBmdWxseSB1bmRlcnN0YW5kIHlvdXIgb2Jq
ZWN0aW9uIHRvIG15IHBhdGNoZXMgYW5kIGl0IGlzIGEgdmFsaWQNCm9iamVjdGlvbiwgd2hpY2gg
SSB3aWxsIGFkZHJlc3MuDQoNCkkganVzdCB0aG91Z2h0IHRoYXQgdGhlcmUgbWlnaHQgYmUgc29t
ZSBpbnNpbnVhdGlvbiwgYXMgeW91IG1lbnRpb25lZCBWTXdhcmUNCmJ5IG5hbWUuIE15IHJlc3Bv
bnNlIHdhcyBoYWxmLWpva2luZ2x5IGFuZCBzaG91bGQgaGF2ZSBoYWQgYSBzbWlsZXkgdG8NCnBy
ZXZlbnQgeW91IGZyb20gd2FzdGluZyB5b3VyIHRpbWUgb24gdGhlIGV4cGxhbmF0aW9uLg0KDQo=
