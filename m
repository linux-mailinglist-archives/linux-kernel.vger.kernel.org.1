Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997DC2EA47A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 05:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbhAEEeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 23:34:21 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:39969
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbhAEEeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 23:34:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEsbhb29cW1Fg0ch2e79GegKYr1tMTosg5Ky7o8EwjafRFeZcg4qeEjXVd2O9tQNXLqetUQE6DeNLWPA70O9aEHC0JyM6otUaK3hrA2evFFnZRDE6rkaPa8Atn/tRJcwS4DO5wYq7VMloMrwUaQwxzW1ejv1xghfLFAkRuDMOcgeUbPNQsxFH8s7vBWgIqTZ6fXOGpBUxedeM5m9buN4iQiWJm/hcpToDEoR3hxSu2DZhZ5c5cE5j85pI8Fyq3C0WCXTEA8PdynPAof2JTrdWM2d6i04x8umk9gpbemETu3f+EWvdRqZ/5tPX2+fKNTa/N/fM7245HpN0++GUVrd9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFY66y90B7A0s9pdjdtxjjNdKnbLEy5k7o/bVXkXtPk=;
 b=HQ8VfmGBJt7WUByuRS/9jRdKDqRwpvqORVnqpZNO4tr3V4utqmX3S4GRxp8A919V69WjsEn3fpqVwFeKvNbpiJr/6GyB6rpMSlm+2kQG9rVAx6NZSkyTe4C8+36FSA7o6fsuRed9sa0dOKlx5LxQgP4tFHURo2SLHzClY/EdY64huNpqpSuwTPfuOax9QCq3gOEykZj7lVfaniLeiRL129+5gspaFndncamJThF+033pRkyE2s6mqdQaXDsve/KC+Sq+CBjfcV0OcH+KuwUevSVcjadcAEsVpvgHZSKXhcePBOdnUsryefuqkcv90Y7gQQ32mc2274v6OnCToxCm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFY66y90B7A0s9pdjdtxjjNdKnbLEy5k7o/bVXkXtPk=;
 b=kQizUjW3xZwgg70aCpHcqCHDi+5UWIkYxMe+vZg4BAE2/4oKsz69mwrd5Msr/aueNYS0dbqqr1sMSR/xox4SP4P3Jap5gzbVSE4WA/eq1FxJW5iKU+tmeRGsfEV6X8AmFg9vmOD4VFavOdd9CJVSyUw+DzaJB4gZi1ROTdOHTU8=
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by BYAPR11MB3831.namprd11.prod.outlook.com (2603:10b6:a03:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 04:33:06 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 04:33:06 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Jim Quinlan <jim2101024@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Hao, Kexin" <Kexin.Hao@windriver.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] drivers core: Free dma_range_map when driver probe failed
Thread-Topic: [PATCH] drivers core: Free dma_range_map when driver probe
 failed
Thread-Index: AQHW2oL5W9lS+4iZLUqXFPSPPCIdYaoXrz0EgADSigA=
Date:   Tue, 5 Jan 2021 04:33:05 +0000
Message-ID: <SJ0PR11MB5072362B1C8DD994CEC9F54AF1D10@SJ0PR11MB5072.namprd11.prod.outlook.com>
References: <20201225055812.2177-1-Meng.Li@windriver.com>
 <CA+-6iNw1pixdamS1HSPiifrppWp=qsOmxVu6NYhDHr61pC6Gkw@mail.gmail.com>
 <CANCKTBtMcDQkAAyTY_k3h6Mh8MxQkKiav1=wpyODDChpDwzFug@mail.gmail.com>
In-Reply-To: <CANCKTBtMcDQkAAyTY_k3h6Mh8MxQkKiav1=wpyODDChpDwzFug@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3aab06ee-8af2-41cc-145e-08d8b132ff2e
x-ms-traffictypediagnostic: BYAPR11MB3831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3831308EC0E56CE31C8CFD6FF1D10@BYAPR11MB3831.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zR30sV1jw0qHDO1l2jem3RzG/1UG9QjPKnZYMK1RhfeuHHPWgkGIaPbhe9C7H1grkTGAxBa65On7r9JrxG6LXnJNj5EEqK3ANnACHL8wCAD2KDUg46RkGvVDKMuUun4sS3a2PBcSXTYcNxLSLESvZ0BSJp+zV2BVsMq6MGASDNoEJu4a8ZwIStVsJJNeqfrbTYEMT6/ZMwAr46mbtQw0ZghgGr0oy/OH4ufFcislOf+t6LsiX3PA86JbUUzf2D3MmYXUdYTBekOQSBs6fxe2jJ/hvLWyPz21t//4A0tPhlYYCVRIHcYNFg8Nm5eQGXB83pXJqZ+iUrzRRurF7to4E4SyaAOoKvmIGc+VwR3g3KGIWMy6ZV0FpVhPJgHUlCipH5Ok1qJR78xuHpBsRqI5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(346002)(136003)(396003)(2906002)(5660300002)(9686003)(8936002)(76116006)(186003)(66476007)(53546011)(66556008)(66446008)(64756008)(478600001)(4326008)(26005)(6506007)(83380400001)(52536014)(66946007)(71200400001)(54906003)(316002)(8676002)(110136005)(33656002)(55016002)(86362001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WmN2ZVV3OE4xeTZOYitiU05KYkN0UDZxeVdUWkVnaTVlQ0VWSXVoS1FMejhB?=
 =?utf-8?B?bENwQW55WEhqL2lJbmRTV2RsTVFJS0IrN0dGUy9xelZJVzRSbXFtc1pybE1n?=
 =?utf-8?B?MVNxSjBjRE5FQnIwei93SUtZTE44SkhpekRFNWxhdHpIRlE0c28vTEhzLzgz?=
 =?utf-8?B?Z0tSWXMvR0FqV1dnbzNqTC9UMFJ2OXB5Tk9pR0EzSCt2dEpjclNhb0ljYWJP?=
 =?utf-8?B?Snp6c1pnNU5TM1ZxcUV5eW1jMHk5b0ZOQ1ZOcG0xbjJYbFUxUlJJQ21UZzVy?=
 =?utf-8?B?Y2VHR3pEaDFlR1crRm9DQmlMTkp2V1ZDd2krNmt3dHJaWStqU0xwbmh5Sy9q?=
 =?utf-8?B?STZSTytPaStnZFM2UGVpZTFHeWlrZlhWaXBGTU9EdHpueE11R1JpcExTYWl4?=
 =?utf-8?B?OTV0M0NGdGVXNWx6cE5WbjRyYXl1cjFFSTMzNVBVRm1xZ0ltSUoyUlBnRzBZ?=
 =?utf-8?B?Y0RNazdtTXhHNEdaNkR6NkczcitsaWFUUVoxeU9jVUcyNzRGTTZEY3ZEd0cv?=
 =?utf-8?B?bVFUZ2hLNm95UGl4VmNEYkUxN3NzVm1pMHpYV2d4VXBrVjMxV2pZbVJvK3hC?=
 =?utf-8?B?ZlF6Smx0elg3T2NvczJ1b3IzaG9xTCtpaEZVaUlwK1c0Nk1wVVRoRGFPandZ?=
 =?utf-8?B?UTlRNzB6SjhsditMdHJGR2VFRXhqK09yZmV6ejhTYWo0NmVlOXo3a0k1djVD?=
 =?utf-8?B?cWJwNktmdEVpejVqbTFuek5UR3VNTTJEanJkaTd3WHNEMEV1Rk5FTjZ0MnZ4?=
 =?utf-8?B?QTlGdHNkdVJ4ekx1b0VralhwYmNBb0owUVlURjFQWHhWWUtWdFZTaG53cFpN?=
 =?utf-8?B?Wk1CQi9uMllxbUVoR2JCY2EzUzlqc29NWUNYSi81RUdYZmVZRUluY0xyL1BU?=
 =?utf-8?B?c3hnTHBHbktRbG8xalRiUVUrNnB0TkYxWHExYXFFNWI5SDBkWFdrcE9rdC9v?=
 =?utf-8?B?RS9yQTI0Z1RBa1VmdnhWQ1krZEpWQ254SlRCcSsyYS9vVTJNYk9VS1N6WDBr?=
 =?utf-8?B?Wk9MRlYrMXJuVmJNYnVVNTRVRFJEajhEZVUyNGhVQ1hvVXJRZGRJZVI3RytK?=
 =?utf-8?B?M3VVdnZiOTA0dzFTZ2JhUnFzV1NXdzRmTFNTU1J5R1VraTIzcUdiWDdoM3Qz?=
 =?utf-8?B?dVBocUNWZGx0bitzY1JaVlc2aWtWMEZnNHg1R2xUb1pRTDlHcmd0K2h2OE5T?=
 =?utf-8?B?dGJDc0NSWVgzSWg1aTQ3NU90enVsQjRiN1FOOEtscHh2MWhkSk1LRmViZ2pU?=
 =?utf-8?B?Rmp3T2NlbGZ5VlhqZmxjOCtHbDJIL2FXbVNjTm9Bd1hITTZHT0VPcW9aa2hG?=
 =?utf-8?Q?5JTpgQlxnIECA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aab06ee-8af2-41cc-145e-08d8b132ff2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 04:33:05.9431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dmj6ih+myGXYU0AJU+h95Lj2gYEOoMx5x1xGmF3zXRDve+nBskVAqOdDbwJxKwVxucYGbqCKyGxh3G8C2yo9RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3831
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmltIFF1aW5sYW4gPGpp
bTIxMDEwMjRAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgNCwgMjAyMSAxMTo1
NiBQTQ0KPiBUbzogSmltIFF1aW5sYW4gPGphbWVzLnF1aW5sYW5AYnJvYWRjb20uY29tPjsgTGks
IE1lbmcNCj4gPE1lbmcuTGlAd2luZHJpdmVyLmNvbT47IG9wZW4gbGlzdCA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyByYWZhZWxAa2VybmVsLm9yZzsNCj4gSGFvLCBLZXhpbiA8S2V4aW4u
SGFvQHdpbmRyaXZlci5jb20+OyBKaW0gUXVpbmxhbg0KPiA8amltMjEwMTAyNEBnbWFpbC5jb20+
OyBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJpdmVycyBjb3JlOiBGcmVlIGRtYV9yYW5nZV9tYXAgd2hlbiBkcml2ZXIgcHJvYmUNCj4gZmFp
bGVkDQo+IA0KPiA+IFN1YmplY3Q6IFtQQVRDSF0gZHJpdmVycyBjb3JlOiBGcmVlIGRtYV9yYW5n
ZV9tYXAgd2hlbiBkcml2ZXIgcHJvYmUNCj4gPiBmYWlsZWQNCj4gPg0KPiA+IFRoZXJlIHdpbGwg
YmUgbWVtb3J5IGxlYWsgaWYgZHJpdmVyIHByb2JlIGZhaWxlZC4gVHJhY2UgYXMgYmVsb3c6DQo+
ID4gICBiYWNrdHJhY2U6DQo+ID4gICAgIFs8MDAwMDAwMDAyNDE1MjU4Zj5dIGttZW1sZWFrX2Fs
bG9jKzB4M2MvMHg1MA0KPiA+ICAgICBbPDAwMDAwMDAwZjQ0N2ViZTQ+XSBfX2ttYWxsb2MrMHgy
MDgvMHg1MzANCj4gPiAgICAgWzwwMDAwMDAwMDQ4YmM3YjNhPl0gb2ZfZG1hX2dldF9yYW5nZSsw
eGU0LzB4MWIwDQo+ID4gICAgIFs8MDAwMDAwMDA0MWUzOTA2NT5dIG9mX2RtYV9jb25maWd1cmVf
aWQrMHg1OC8weDI3Yw0KPiA+ICAgICBbPDAwMDAwMDAwNjM1Njg2NmE+XSBwbGF0Zm9ybV9kbWFf
Y29uZmlndXJlKzB4MmMvMHg0MA0KPiA+ICAgICAuLi4uLi4NCj4gPiAgICAgWzwwMDAwMDAwMDBh
ZmNmOWI1Pl0gcmV0X2Zyb21fZm9yaysweDEwLzB4M2MNCj4gPg0KPiA+IFRoaXMgaXNzdWUgaXMg
aW50cm9kdWNlZCBieSBjb21taXQgZTBkMDcyNzgyYzczKCJkbWEtbWFwcGluZzoNCj4gPiBpbnRy
b2R1Y2UgRE1BIHJhbmdlIG1hcCwgc3VwcGxhbnRpbmcgZG1hX3Bmbl9vZmZzZXQgIikuIEl0IGRv
ZXNuJ3QNCj4gPiBmcmVlIGRtYV9yYW5nZV9tYXAgd2hlbiBkcml2ZXIgcHJvYmUgZmFpbGVkIGFu
ZCBjYXVzZSBhYm92ZSBtZW1vcnkNCj4gPiBsZWFrLiBTbywgYWRkIGNvZGUgdG8gZnJlZSBpdCBp
biBlcnJvciBwYXRoLg0KPiA+DQo+ID4gRml4ZXM6IGUwZDA3Mjc4MmM3MygiZG1hLW1hcHBpbmc6
IGludHJvZHVjZSBETUEgcmFuZ2UgbWFwLA0KPiBzdXBwbGFudGluZw0KPiA+IGRtYV9wZm5fb2Zm
c2V0ICIpDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNZW5nIExpIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
YmFzZS9kZC5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9kZC5jIGIvZHJpdmVycy9iYXNlL2RkLmMg
aW5kZXgNCj4gPiAxNDhlODE5NjllMDQuLjhlNDg3MWFhMzRiYyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2Jhc2UvZGQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmFzZS9kZC5jDQo+ID4gQEAgLTYx
Miw2ICs2MTIsNyBAQCBzdGF0aWMgaW50IHJlYWxseV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdA0KPiA+IGRldmljZV9kcml2ZXIgKmRydikNCj4gPiAgICAgICAgIGVsc2UgaWYgKGRy
di0+cmVtb3ZlKQ0KPiA+ICAgICAgICAgICAgICAgICBkcnYtPnJlbW92ZShkZXYpOw0KPiA+ICBw
cm9iZV9mYWlsZWQ6DQo+ID4gKyAgICAgICBrZnJlZShkZXYtPmRtYV9yYW5nZV9tYXApOw0KPiA+
ICAgICAgICAgaWYgKGRldi0+YnVzKQ0KPiA+ICAgICAgICAgICAgICAgICBibG9ja2luZ19ub3Rp
Zmllcl9jYWxsX2NoYWluKCZkZXYtPmJ1cy0+cC0+YnVzX25vdGlmaWVyLA0KPiA+DQo+ID4gQlVT
X05PVElGWV9EUklWRVJfTk9UX0JPVU5ELCBkZXYpOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4N
Cj4gPiAtLQ0KPiANCj4gSGkgTWVuZywNCj4gDQo+IFNvcnJ5IGZvciB0aGUgZGVsYXkgLS0gSSB3
YXMgb24gdmFjYXRpb24uICBJIGFncmVlIHdpdGggeW91IC0tIHRoYW5rcy4NCj4gSG93ZXZlciwg
bm90ZSB0aGF0IGluIGZ1bmN0aW9uICBkZXZpY2VfcmVsZWFzZSgpICBpbiBkcml2ZXJzL2Jhc2Uv
Y29yZS5jDQo+IHRoZXJlIGlzIHRoaXMgbGluZToNCj4gDQo+IGtmcmVlKGRldi0+ZG1hX3Jhbmdl
X21hcCk7DQo+IA0KPiBXb24ndCB0aGlzIGFsc28gYmUgY2FsbGVkICBpZiBhbGwgb2YgdGhlIGFw
cHJvcHJpYXRlIGRyaXZlcnMnIHByb2JlcyBmYWlsIGZvciB0aGlzDQo+IGRldmljZSwgZWZmZWN0
aW5nIGEgZG91YmxlIGtmcmVlPyAgUGVyaGFwcyB5b3VyIHBhdGNoIGNvdWxkIGFsc28gc2V0ICJk
ZXYtDQo+ID5kbWFfcmFuZ2VfbWFwIiB0byBOVUxMIGFmdGVyIGNhbGxpbmcga2ZyZWUoKT8NCj4g
DQoNCkhpIEppbSwNCg0KUGxlYXNlIGRpc2NhcmQgbXkgcHJldmlvdXMgcmVwbHksIGJlY2F1c2Ug
SSBoYWQgYSBtaXN1bmRlcnN0YW5kIGFib3V0IHdoYXQgeW91IHN1Z2dlc3RlZC4NCkkgYWdyZWUg
d2l0aCB5b3UgdG90YWwsIGFuZCBJIHdpbGwgc2V0IGRtYV9yYW5nZV9tYXAgYXMgTlVMTCBpbiBy
ZWFsbHlfcHJvYmUoKSBmdW5jdGlvbiB3aGVuIGRyaXZlciBwcm9iZSBmYWlsZWQuDQpJIHdpbGwg
c2VudCBWMiBwYXRjaC4NCg0KVGhhbmtzLA0KTGltZW5nDQoNCj4gVGhhbmtzIG11Y2gsDQo+IEpp
bSBRdWlubGFuDQo+IEJyb2FkY29tIFNUQg0K
