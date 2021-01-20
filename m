Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4322FCAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 06:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbhATFUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 00:20:10 -0500
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:63396
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727425AbhATFP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 00:15:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYNtlS6tSagV2DqmrZMLKHjqXnLp/vk3GiCb0iADEosSpWWjYg4yPRcF+xGfnxMxCUfJtDjJZBLpWk0LpGFykEOapkZRwUm2yJzDHh4Ly4E94l+kGpxdjBTkijLepuHtYOLWQGZYpSzMgGAxLPH7AyCO3rp58sv8/1L04HtvUJ/gBDrd/01SQUWO/jBDbGjdYlXTd6lJky6d6cY24n750o+tjm/iib1EDL7z971tYp85qswSlHq5hKnkvTigaO/B1yw8UnrxYf7AX1L1M66fjLip3ZHNb6a4lZHc7ylBElgk0gevD2bxxx00Rt2NX2AjO9qgJj5CNfZ5t6dYADOktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4xFDc0SIFHS3BDZHRYK0bebcYMolWPoXgkgKHgKnIs=;
 b=aqEaxu6fYOgeqGrTIwZO0MwogDK75/V+HfjhbitaLidnAya/UotWOaMoouAFm99HvL8nP4ERSLZBwYH70Jkb8EelAW+Xy3A7l3Qc+zZEGEZ+FjZ3izpjlP3DvCx0TBlM2LtMfv45h1qttgGelEhVKQB5QqaR5spXsaIpAv5vbrue9ECmv9JDGIw/yS0ETAL2MZ2SWM5KhRdiA5FP/d013eYbZ5ikHjGbE08n+ZWa27AQHZoQDXisN2wLZ7ZgtWUCIsdpNpYxON7FenLtgCGMQLcnGfjqUFnXKuBxCtjuEDiAZd3Bgg44JZ8t42eOOgMduUoxHb4DGFq6MLPFEYOLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4xFDc0SIFHS3BDZHRYK0bebcYMolWPoXgkgKHgKnIs=;
 b=jwuhu2UNAVulrxIHZIclWrAAiR4DwN5Pclu0sPVv6mpQieUI7JObedGchT6NNR+AGctrMzmO16dzvx/esgFE/M8A9T+g8ryrElwK25envV32JBYjwpHtUPnorM2Ujsk0vidzS2KAZuEcqK9o3w7OL7Ehpj4Cfv87nAW/KszxorI=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5132.eurprd04.prod.outlook.com (2603:10a6:10:15::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 05:15:06 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 05:15:06 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH] perf metricgroup: Fix system PMU metrics
Thread-Topic: [PATCH] perf metricgroup: Fix system PMU metrics
Thread-Index: AQHW7ksGebtibLbnaUWJ/YJe+SCr+aouwcUwgABWSgCAAB2ugIAAwm9g
Date:   Wed, 20 Jan 2021 05:15:06 +0000
Message-ID: <DB8PR04MB67951BF5DBE4524CB13BAAE4E6A20@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
 <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
In-Reply-To: <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d34863f-9606-442b-8f5b-08d8bd0259ca
x-ms-traffictypediagnostic: DB7PR04MB5132:
x-microsoft-antispam-prvs: <DB7PR04MB5132CE18744D0B11B86B9559E6A20@DB7PR04MB5132.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qqC9n02JUV4DgjwAhMUbwy/sch4uGBglKCTIUeFzpfhcHM2YUVgtPsoRplxuSl8Eb0kSLwhkbbtH+d9y7W5erxVGDOLGYvbB+5lcFeTlaFjLhgIJvIFQm6yeeaL3q0WivL6mADJMYQiPmuS3pIEMm9SZ3ahsoXcpIr6ZXiaR5KQfNbow6ovMpOtJkxsE5ks4tmkKr1LBud8pYMBg9UgrUCUemUQUH8bRctoDguU4aKupbwdd+fDQt4eGS/T112h+oHRvKd6sqae34QsXy4dHMh80faNknDJ8TVMlevmOfEAo9PUjLk2kFZfVuySOVOYT1XgOd1NJBhvlPLKcz4cXTDNNyltAxywxyoMZna6X7lFy7tSqNIQVnPvab62zsIvoMmxd3jgBHvzIA4+NchM3MB8fZORm2sir6fogVgTewSnaM3rCj6bvTn58Z/K7Y+Jm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(9686003)(66476007)(55016002)(316002)(921005)(478600001)(76116006)(110136005)(7416002)(71200400001)(5660300002)(8936002)(6506007)(33656002)(186003)(66556008)(4326008)(8676002)(52536014)(54906003)(26005)(86362001)(66446008)(7696005)(83380400001)(64756008)(2906002)(19627235002)(53546011)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OG9GQnRMTWhocSs0dFZHdkkzaUVicjdtQitMbGxKRXVacWdhOEoyYzY1SkRo?=
 =?utf-8?B?ajZaOXJaWTVIVnRzdzFzQkJhcUNwOE9aMnJPRDV4dlkrY0wrajg1eXhUMVBp?=
 =?utf-8?B?YmxDOHh0bUlyeVFUVEdxT2QzMmJhaHp3SEMrOXlET29ES09vcndnMlB1czVX?=
 =?utf-8?B?bjVEblU1QkpOazI2WnVYSTgxZ0pkM0dkZ29LUm5sd3U5c2RiaWU5b1I3MUh5?=
 =?utf-8?B?cTRYNUoxd1hJSGdIUEpuSy9OU2thclRkTisxMDc0WTU0eVcyQzZ2d1RiUDUy?=
 =?utf-8?B?UEljdFRpU1JJQ2E5SGtCOEl3bC9nakNNUkxwdDNCenNTSWg2TUJabUtlRXh1?=
 =?utf-8?B?V29ZT0E2VXNLVFlXR2pkelFyOXlZT3Y2Z0tiV3VrUVQwYzkzakdoeGtwK0tQ?=
 =?utf-8?B?RENuYTFJRUQwelJ0SmNQSGp1bk5Wb2U0RjBUakFXOXNIYXREdmpRcEJPak5G?=
 =?utf-8?B?VUoreG1MdmpLOExzRHpJd2ZSc1A3MlFKQWJEUndFdytVRHpEN2tDbVc1TXNq?=
 =?utf-8?B?T0lya0RFK0lyWTR6ZlFsS2x5SXNETjBLYko1bEJITlZXRTlxbk1GdzBrS2xJ?=
 =?utf-8?B?dERPRnluQlVWV3l6Q1dZMUNnSWJGWDNxNThJY2duUjg4R25Ua2R1TU9tb2RZ?=
 =?utf-8?B?amx1aFV6aHVBUEFRRTQyTXdxb2ZSYk9UUGk0aFdvT3V5MHhiVG1BNFBoYkF6?=
 =?utf-8?B?Sk13bDJXM2VpMzNzRnFjdURzQnlQVzZOcHdRc3cvTzlXQWxNbmJUdzIyYlJt?=
 =?utf-8?B?YmVyaU53TFpLNnNac05zbkZ2RWJzUW44ZDBoQWFaZXBQT2F5ZlVQZ0pNVkhP?=
 =?utf-8?B?V3BqTGZrUDFqWHZJQzNSQ0hRN0Z0em0reW1DOTFaMEk3M2wvcStqd0I3SFFL?=
 =?utf-8?B?dWZlK0hRL0M5cm1MVzhlbGNIdEVOU2h6bHo5eEQ3YUJiaWZCU29GbERDd3E1?=
 =?utf-8?B?ZGRmL0hOK0VYY0xlVWRSWWRyM3UyK2I4aDhtQnRuSnBCbkRReVQwVjBERjgr?=
 =?utf-8?B?L0tJdmQ5ejNITTNBUkdva3daVVhyQWZnSkpHLzRvK2NQUlZoVjgrVlgyUkFy?=
 =?utf-8?B?ZUptN0xpcURvSXpra1JKbXR3Q0hHUGZ1WFhQM0VCY0RxUFc4ZGZ0UE1qQWRI?=
 =?utf-8?B?UUFHMnkvSmxrUTUrL3A3Z2dDbGNoTFpSUEh2cnZRcXNDN1d5VWlKeHM5VDRP?=
 =?utf-8?B?WVo5eFRYTkcyaUw2dUJqR2s5MVFrdDczc0xGSnIvK1NmSm1QTW9KVXFyMU5y?=
 =?utf-8?B?S1Zra1paczkybEQ3a1FGNnVPZFQ0TnpkZ0dJVkVieGs5TS9FTnVJbXZTdTR1?=
 =?utf-8?Q?K1vy6eQcjquQ8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d34863f-9606-442b-8f5b-08d8bd0259ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 05:15:06.5512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJoizH7wMUdATNB0NiVU9FDMIMq0Y3ZGs3XAYjdWI3t18Rq3FK67Le7OdsE5O6B7I32rzrHhHV6TYB2Uobw70g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMeW5tDHmnIgyMOaXpSAxOjMzDQo+IFRvOiBK
b2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgcGV0ZXJ6QGluZnJhZGVhZC5v
cmc7DQo+IG1pbmdvQHJlZGhhdC5jb207IGFjbWVAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFy
bS5jb207DQo+IGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb207IGpvbHNhQHJlZGhh
dC5jb207DQo+IG5hbWh5dW5nQGtlcm5lbC5vcmc7IGlyb2dlcnNAZ29vZ2xlLmNvbTsga2phaW5A
bGludXguaWJtLmNvbQ0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXhh
cm1Ab3BlbmV1bGVyLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwZXJmIG1ldHJpY2dyb3Vw
OiBGaXggc3lzdGVtIFBNVSBtZXRyaWNzDQo+IA0KPiBPbiAxOS8wMS8yMDIxIDE1OjQ3LCBKb2hu
IEdhcnJ5IHdyb3RlOg0KPiA+IE9uIDE5LzAxLzIwMjEgMTA6NTYsIEpvYWtpbSBaaGFuZyB3cm90
ZToNCj4gPj4gSXQgc2VlbXMgaGF2ZSBvdGhlciBpc3N1ZSBjb21wYXJlZCB0byA1LjEwIGtlcm5l
bCBhZnRlciBzd2l0Y2hpbmcgdG8NCj4gPj4gdGhpcyBmcmFtZXdvcmssIGJlbG93IG1ldHJpYyBj
YW4ndCB3b3JrLg0KPiA+PiAiTWV0cmljRXhwciI6ICIoKCBpbXg4X2RkcjBAcmVhZFxcLWN5Y2xl
c0AgKw0KPiA+PiBpbXg4X2RkcjBAd3JpdGVcXC1jeWNsZXNADQo+ID4+ICkgKiA0ICogNCAvIGR1
cmF0aW9uX3RpbWUpIC8gKDc1MCAqIDEwMDAwMDAgKiA0ICogNCkiDQo+ID4+IEFmdGVyIGNoYW5n
ZSB0bzoNCj4gPj4gIk1ldHJpY0V4cHIiOiAiKCggaW14OG1tX2Rkci5yZWFkX2N5Y2xlcyArIGlt
eDhtbV9kZHIud3JpdGVfY3ljbGVzICkNCj4gPj4gKg0KPiA+PiA0ICogNCAvIGR1cmF0aW9uX3Rp
bWUpIC8gKDc1MCAqIDEwMDAwMDAgKiA0ICogNCkiLA0KPiA+DQo+ID4gSXQgc2VlbXMgdGhhdCBh
bnkgbWV0cmljIHdoaWNoIGluY2x1ZGVzICJkdXJhdGlvbl90aW1lIiBpcyBicm9rZW4sDQo+ID4g
ZXZlbiBvbiB4ODY6DQo+ID4NCj4gPiBqb2huQGxvY2FsaG9zdDp+L2FjbWUvdG9vbHMvcGVyZj4g
c3VkbyAuL3BlcmYgc3RhdCAtdiAtTQ0KPiA+IEwxRF9DYWNoZV9GaWxsX0JXIHNsZWVwIDEgVXNp
bmcgQ1BVSUQgR2VudWluZUludGVsLTYtM0QtNCBtZXRyaWMgZXhwcg0KPiA+IDY0ICogbDFkLnJl
cGxhY2VtZW50IC8gMTAwMDAwMDAwMCAvIGR1cmF0aW9uX3RpbWUgZm9yDQo+ID4gTDFEX0NhY2hl
X0ZpbGxfQlcgZm91bmQgZXZlbnQgZHVyYXRpb25fdGltZSBmb3VuZCBldmVudA0KPiA+IGwxZC5y
ZXBsYWNlbWVudCBhZGRpbmcge2wxZC5yZXBsYWNlbWVudH06VyxkdXJhdGlvbl90aW1lDQo+ID4g
bDFkLnJlcGxhY2VtZW50IC0+IGNwdS91bWFzaz0weDEsKG51bGwpPTB4MWU4NDgzLGV2ZW50PTB4
NTEvDQo+ID4gU2VnbWVudGF0aW9uIGZhdWx0DQo+ID4NCj4gPg0KPiA+IFNlZW1zIHRvIGJlIGZy
b20gbXkgY29tbWl0IGMyMzM3ZDY3MTk5ICgicGVyZiBtZXRyaWNncm91cDogRml4IG1ldHJpY3MN
Cj4gPiB1c2luZyBhbGlhc2VzIGNvdmVyaW5nIG11bHRpcGxlIFBNVXMiKQ0KPiA+DQo+ID4gSSds
bCBsb29rIHRvIGZpeCBpdCBub3cuDQo+ID4NCj4gDQo+IFBsZWFzZSB0cnkgdGhpczoNCj4gDQo+
ICBGcm9tIDIzODBmMWVmMDI1MGU2ODE4YjNkYmM3YmZmNGE4Njg4MTA4NzVlMmEgTW9uIFNlcCAx
NyAwMDowMDowMA0KPiAyMDAxDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2Vp
LmNvbT4NCj4gRGF0ZTogVHVlLCAxOSBKYW4gMjAyMSAxNzoyOTo1NCArMDAwMA0KPiBTdWJqZWN0
OiBbUEFUQ0hdIHBlcmYgbWV0cmljZ3JvdXA6IEZpeCBtZXRyaWMgc3VwcG9ydCBmb3IgZHVyYXRp
b25fdGltZQ0KPiANCj4gRm9yIGEgbWV0cmljIHVzaW5nIGR1cmF0aW9uX3RpbWUsIHRoZSBzdHJj
bXAoKSBjaGVjayB3aGVuIGZpbmRpbmcgaWRlbnRpY2FsDQo+IGV2ZW50cyBpbiBtZXRyaWNfZXZl
bnRzW10gaXMgYnJva2VuLCBhcyBpdCBkb2VzIG5vdCBjb25zaWRlciB0aGF0IHRoZQ0KPiBldmVu
dCBwbXVfbmFtZSBpcyBOVUxMIC0gaXQgd291bGQgYmUgZm9yIGR1cmF0aW9uX3RpbWUuDQo+IA0K
PiBBcyBzdWNoLCBhZGQgYSBOVUxMIGNoZWNrIGhlcmUgZm9yIGV2ZW50IHBtdV9uYW1lLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29tPg0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9tZXRyaWNncm91cC5jIGIvdG9vbHMvcGVy
Zi91dGlsL21ldHJpY2dyb3VwLmMNCj4gaW5kZXggZWU5NGQzZThkZDY1Li4yNzdhZGZmODAxN2Yg
MTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9tZXRyaWNncm91cC5jDQo+ICsrKyBiL3Rv
b2xzL3BlcmYvdXRpbC9tZXRyaWNncm91cC5jDQo+IEBAIC0yODAsNiArMjgwLDggQEAgc3RhdGlj
IHN0cnVjdCBldnNlbCAqZmluZF9ldnNlbF9ncm91cChzdHJ1Y3QgZXZsaXN0DQo+ICpwZXJmX2V2
bGlzdCwNCj4gICAJCQkgKi8NCj4gICAJCQlpZiAoIWhhc19jb25zdHJhaW50ICYmDQo+ICAgCQkJ
ICAgIGV2LT5sZWFkZXIgIT0gbWV0cmljX2V2ZW50c1tpXS0+bGVhZGVyICYmDQo+ICsJCQkgICAg
ZXYtPmxlYWRlci0+cG11X25hbWUgJiYNCj4gKwkJCSAgICBtZXRyaWNfZXZlbnRzW2ldLT5sZWFk
ZXItPnBtdV9uYW1lICYmDQo+ICAgCQkJICAgICFzdHJjbXAoZXYtPmxlYWRlci0+cG11X25hbWUs
DQo+ICAgCQkJCSAgICBtZXRyaWNfZXZlbnRzW2ldLT5sZWFkZXItPnBtdV9uYW1lKSkNCj4gICAJ
CQkJYnJlYWs7DQo+IC0tDQo+IDIuMjYuMg0KPiANCj4gDQoNCkZvciB0aGlzIHBhdGNoOiBUZXN0
ZWQtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQoNCkhpIEpvaG4s
IEpvbHNhLA0KDQpJcyB0aGVyZSBhbnkgd2F5IHRvIGF2b2lkIGJyZWFraW5nIGV4aXN0IG1ldHJp
YyBleHByZXNzaW9ucz8gSWYgbm90LCBpdCB3aWxsIGFsd2F5cyBoYXBwZW5lZCBhZnRlciBtZXRy
aWNncm91cCBjaGFuZ2VzLg0KDQpJIHJlY2FsbCB0aGF0IEpvbHNhIG1lbnRpb25lZCBpdCBiZWZv
cmUsIGJ1dCBJIGRvbuKAmXQgcmVtZW1iZXIgaXQgdmVyeSBjbGVhcmx5Lg0KDQpUaGFua3MgYSBs
b3QgZm9yIEpvaG4ncyBidWcgZml4Lg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg==
