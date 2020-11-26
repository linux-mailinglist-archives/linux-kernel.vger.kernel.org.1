Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314692C4CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 02:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgKZBfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:35:09 -0500
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:2272
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731378AbgKZBfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:35:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8cVaUDKVtAyY7jxYZ/I/eajiUdzJ5HBzC8WHZwwGWeUxkxkVrmNfQaEtOpOlbWaFXiOKSI3vSxY8meQ8h1hThOHkRXZ/mLfsHHVw4w2tWqIQNG8ZKI6vjxfgOuq9eyhBoLZPmeoD8bfEi27zMoAr6G625lDot7K3vwsVgEGZhAI6j9MQ6bdbQgRorZDtq42x2ZId2ZDOB2Gl67RVdwRpImk+SahFqri/jOYUmELsFHPae4MPBnBjSqfgi48s7ahfQtbBQlvXVCsQiWhsGpzm068ypefj2WrgqyPZrwLll3XcQEeDIIZfVxOU+TtCa0vHshY4AdZQ2VCWOMGAOzSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSXcmxgrKzfrXOw2wCk24gOK8U1Ntb9A548pDbKGZGA=;
 b=iy85uP/FwHoUXWak8vhArb/Bht3kYnNj0WYfmuijyRwNO7Dc0UlxMrFyE4Tkj6N83v9x8Ls1w2Gz99W8iCUCRRZ1toimae8Qlc6c8avQmDghDtKS2ilvgYZloj5N4VoDC84QJ9N5eUI9PIfX82Ely7PpPgE4FXyL3LjDdtfFgF6MWG3RmzPmp5gW2J7heU1wrdhS/QNh99nS8CeAq1dPxEN/XuIkSPe3q9jw8xw9yxZODCIPUNFC6CZBv8zFMfmfSrn0O8ZsBlCwdmjDpJ5/SLoTRV99dOvmSedgLKBCeBIw5pBk6X/pKyyMNLwckBOMoKB2LkuQo1IYMPXCqGUAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSXcmxgrKzfrXOw2wCk24gOK8U1Ntb9A548pDbKGZGA=;
 b=BJe14v0guSW/nlfX1tvYJuedc30ZXriiQUM4kllRmZkDWa3w7riiGwOhUtevXwBTi1CWbWECV9spqQT5CP+ps9nzJCIGSpPATdF7ENt6uFDKIBXbekHpwF9zMZCTZITtH5ym4K/zaXpzoov3o0bfrjLdjckqgPY5cZFv8DaPd1k=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2501.eurprd04.prod.outlook.com (2603:10a6:4:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 26 Nov
 2020 01:35:04 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%5]) with mapi id 15.20.3589.028; Thu, 26 Nov 2020
 01:35:04 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Frank Li <frank.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "irogers@google.com" <irogers@google.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH v2 0/4] perf drivers: Add sysfs identifier file
Thread-Topic: [PATCH v2 0/4] perf drivers: Add sysfs identifier file
Thread-Index: AQHWnVWjNg4bINlMYEy4g+PTHolZWqnZSPEAgAAEiQCAAKAvAA==
Date:   Thu, 26 Nov 2020 01:35:04 +0000
Message-ID: <DB8PR04MB67957DF5D757E4A52DE177BCE6F90@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
 <160631703729.2332128.13220150013299384201.b4-ty@kernel.org>
 <2a24a5c9-fa9f-f402-9b43-29d1f8241a17@huawei.com>
In-Reply-To: <2a24a5c9-fa9f-f402-9b43-29d1f8241a17@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f185238-5ac6-45a2-0bd4-08d891ab8008
x-ms-traffictypediagnostic: DB6PR0401MB2501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2501E73ABEA4CDA0E955EF24E6F90@DB6PR0401MB2501.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AXp2FJqUgzzvaixxnsma5tZ5CUuejd3xy5DgnJ9zV5LAf+op48wzjqeaTs7uYagaAO1f5E7tJPgI87G8MDUniPqBoiSvtPuO4cVPUL4cYsUji+4c7RCN09Q0aiay+n59agYQi+Hw5EYyt0A1nPgxLcUrOAtvFbGZ8aX5jbjDNHM4sbKJjDKpiHRMfbv3Tz/m5fFXjxA3nvSxLZ2/gQ7++el6cG3VAr13NI0qDAlNyTvC/6+0e2fNhyTjuVh8AmofDKH0e/7HqS4YdNklBjk6/ZdgEKHwsPNfmAtXrHoknAvglSqoXM0cwDBn0oBC2hM8qpPe/hENh01IDbGPHZlqFrZRoDy4R91XJyqZ8/vZAiRbckX9eOejO4M4beRtEgEXdd+4n/4BNFSK8qcmqEbOwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(55016002)(8676002)(83380400001)(9686003)(7416002)(33656002)(26005)(2906002)(76116006)(66476007)(66556008)(66946007)(66446008)(45080400002)(64756008)(478600001)(966005)(5660300002)(186003)(52536014)(8936002)(71200400001)(7696005)(53546011)(6506007)(4326008)(86362001)(54906003)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S2ZtdEJOQTI0QnNhcDQvNHNpMlltUDFaUzVIM2FRcnJUMXM3SDVHak1WSVJB?=
 =?utf-8?B?L0tVSGZVenljREdGdEJnTUsyY3A4NUlMRk43QTdhUXJ1dnZSdmpDQzVhTTNw?=
 =?utf-8?B?VW91aHo0Q1J1eGg2VVNYeHpOTEozRHVqdGJYTUFkd3V6bEwxbm4rRkxoL3hN?=
 =?utf-8?B?RVZwZWtkMzVxRlYrc3FCYVBTUEVVL09wNDN6QTkrYlFQY1VlSzg5cExMQ1c0?=
 =?utf-8?B?Z3VleXJYd1ZyaVNuTldROXZuNVhkTHpJVHZtS0pvU0xkYWx6UkpHQUdjcStx?=
 =?utf-8?B?S2FMVUMvQk45WVhRV2s3dllpU2pmd1V0VDZUUXMrTkFuOUN5aXB6Wm5lSzc3?=
 =?utf-8?B?ZFpkekZHL1VwRzB3U3FaZklNZHVxc0NsLytZa2V1VnpRL2ZaZXdkSjFJbGZo?=
 =?utf-8?B?NU5jWEpId0ZGM3JBcVNDQy9zaEZKUXdyWEMrb3F3b0Vxc3o5clRtK3dEK1Qy?=
 =?utf-8?B?c1BBbEpUWnBacnprc3YzK3hvWDBoeW4weTlYTlMyWW9peWEyWm12eStPYjVz?=
 =?utf-8?B?U0VNN3B4aFdoQjdSNFlOSmhhVUJwOVJlODBQNHFrOWhSZTU0OG85MndsNGxQ?=
 =?utf-8?B?RVdnY2JJVFR5aWYzTXQzN2FNS1kvOWFMYnVlSlVIcVhDcERnWWpEWk5VNTlk?=
 =?utf-8?B?NUxZT3EvM0JTVjNseVFTelFtZXcwYmJCdS9oT2l2b0VzTWJMVGJHYTh6Y1Ax?=
 =?utf-8?B?bkpGaDhrT3pqUnhCcnhUZWtxd2pDdkxISUMxWGozYlVSUVFlZ0NKL3VLbDRF?=
 =?utf-8?B?R0FvYm1zblBaNzFISUIvZ3dueEVPSk9GMGpvMmpqamNhVEhySDNSemt5UEhZ?=
 =?utf-8?B?NnplSEd4YXAraXZ2ZlpmbXVodkpiZHNxbWJrNmZIMElzZDNhQWZuTC8zMlYw?=
 =?utf-8?B?UmZBTkhhWWJJMElYdVdyMTBGM2lIazF0bGtCa1RQS0J4OXdGY0lJSmxNblJP?=
 =?utf-8?B?VlhMM0xSSzRxZnU5Q0N0NUtlQmtQUE43bzVHaEpPeFRhSjVDK0lCZVk5TjVa?=
 =?utf-8?B?QVBwblc4MU5yUkF4bTd5SXdnMjlGSDhHbWpnajNCUm40dWZ5UFF3dGVJdnpZ?=
 =?utf-8?B?QWJpUWtPMG13QkJwQUd2V2pvQlpUQWVuQXIvVEQ1V2NsckNQTkp1bFdWM0pH?=
 =?utf-8?B?ZllEdHZlbVZyVVdwajlxN1UvZXpoczFRc3d2cUVla2t4TkorWnZvSnVKdU9X?=
 =?utf-8?B?L3JhV3RiRUpzcUg2NEYzaFlDZmptN2xkWHdRNjYvVFJhdk5BbXlLK044c21L?=
 =?utf-8?B?aHNicDB4cGRZMk9GSTgzSmxkT2hCVzMydlN3WWcrWnlZa2Y5S1JCdVlJdnA4?=
 =?utf-8?Q?Gk1CVVwL61zlE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f185238-5ac6-45a2-0bd4-08d891ab8008
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 01:35:04.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HilOIcBsiT8XkkjHMFAy6tyz+hxqT+4Qp4vMYxYVf7YCckDhrJM2T0FBH9RuljpIRchBAxmzdnnIIKA8tr/mAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2501
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMOW5tDEx5pyIMjbml6UgMDowMA0KPiBUbzog
V2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IEpvYWtpbSBaaGFuZw0KPiA8cWlhbmdxaW5n
LnpoYW5nQG54cC5jb20+OyB6aGFuZ3NoYW9rdW5AaGlzaWxpY29uLmNvbTsNCj4gbWFyay5ydXRs
YW5kQGFybS5jb207IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwu
b3JnDQo+IENjOiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsga2VybmVsLXRlYW1AYW5kcm9pZC5j
b207IGFjbWVAa2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBpcm9nZXJzQGdvb2dsZS5jb207
IGpvbHNhQHJlZGhhdC5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eGFy
bUBodWF3ZWkuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC80XSBwZXJmIGRyaXZlcnM6
IEFkZCBzeXNmcyBpZGVudGlmaWVyIGZpbGUNCj4gDQo+IE9uIDI1LzExLzIwMjAgMTU6NDQsIFdp
bGwgRGVhY29uIHdyb3RlOg0KPiA+IEFwcGxpZWQgdGhlIGhpc2kgYW5kIHNtbXUgcGFydHMgdG8g
d2lsbCAoZm9yLW5leHQvcGVyZiksIHRoYW5rcyENCj4gPg0KPiA+IFsxLzRdIGRyaXZlcnMvcGVy
ZjogaGlzaTogQWRkIGlkZW50aWZpZXIgc3lzZnMgZmlsZQ0KPiA+DQo+ID4gaHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0
Lg0KPiA+DQo+IGtlcm5lbC5vcmclMkZ3aWxsJTJGYyUyRmFjNDUxMWM5MzY0YyZhbXA7ZGF0YT0w
NCU3QzAxJTdDcWlhbmdxaW5nLnoNCj4gaGFuDQo+ID4NCj4gZyU0MG54cC5jb20lN0NiYzJjMGRh
NWI4YzA0Y2FjY2QxNzA4ZDg5MTViNDRmZCU3QzY4NmVhMWQzYmMyYjRjNg0KPiBmYTkyY2QNCj4g
Pg0KPiA5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3NDE5MTY4NDcyNjgxMDcxJTdDVW5rbm93biU3
Q1RXRnBiR1oNCj4gc2IzZDhleUpXSQ0KPiA+DQo+IGpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJs
dU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxDQo+IDAwMCZhDQo+ID4NCj4g
bXA7c2RhdGE9VzJaRnphTVdKZ3BRbmNHNEhGMng4RWFXYzBGa1lKNjlFOHJWYUZpa0pFUSUzRCZh
bXA7cmUNCj4gc2VydmVkPTANCj4gPiBbLi4uXQ0KPiA+IFs0LzRdIHBlcmYvc21tdXYzOiBTdXBw
b3J0IHN5c2ZzIGlkZW50aWZpZXIgZmlsZQ0KPiA+DQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0Lg0KPiA+DQo+
IGtlcm5lbC5vcmclMkZ3aWxsJTJGYyUyRjJjMjU1MjIzMzYyZSZhbXA7ZGF0YT0wNCU3QzAxJTdD
cWlhbmdxaW5nLg0KPiB6aGFuDQo+ID4NCj4gZyU0MG54cC5jb20lN0NiYzJjMGRhNWI4YzA0Y2Fj
Y2QxNzA4ZDg5MTViNDRmZCU3QzY4NmVhMWQzYmMyYjRjNg0KPiBmYTkyY2QNCj4gPg0KPiA5OWM1
YzMwMTYzNSU3QzAlN0MwJTdDNjM3NDE5MTY4NDcyNjgxMDcxJTdDVW5rbm93biU3Q1RXRnBiR1oN
Cj4gc2IzZDhleUpXSQ0KPiA+DQo+IGpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxDQo+IDAwMCZhDQo+ID4NCj4gbXA7c2RhdGE9
bGZtRXIyR085aXlTUnAyNHpXVE9iSGtXQVhFbzNhbjZUeEElMkJ6WHBEbHZrJTNEJmFtcDsNCj4g
cmVzZXJ2ZWQNCj4gPiA9MA0KPiA+DQo+IA0KPiBUaGFua3MuDQo+IA0KPiA+IEkndmUgY29tcGxl
dGVseSBsb3N0IHRyYWNrIG9mIHRoZSBpbXggZGRyIFBNVSwgc28gSSBkcm9wcGVkIHRob3NlDQo+
ID4gcGFydHMgKHBhdGNoIDMvNCBzZWVtZWQgdG8gcmVtb3ZlIGEgY29tcGF0aWJsZSBzdHJpbmcg
ZnJvbSB0aGUgZHJpdmVyPykuDQo+ID4NCj4gDQo+IDIvNCBuZWVkZWQgdG8gYmUgZHJvcHBlZCBh
bnl3YXkuDQo+IA0KPiBASm9ha2ltLCBjYW4geW91IHJlc2VuZCAzLzQ/IEFuZCBJIHRoaW5rIHRo
YXQgd2Ugc2hvdWxkIGtlZXAgdGhlIGV4cGxpY2l0DQo+IHN1cHBvcnQgZm9yICJmc2wsaW14OG0t
ZGRyLXBtdSIgYXMgYSBnb29kIHByYWN0aWNlIGluIGlteF9kZHJfcG11X2R0X2lkc1tdLA0KPiB3
aGlsZSBhbHNvIGFkZGluZyB0aGUgc29jLXNwZWNpZmljIHN1YiBjb21wYXQgc3RyaW5nIHN1cHBv
cnQNCg0KWWVzLCB0aGFua3MgSm9obi4gSSB3aWxsIGZvbGxvdyB1cC4NCg0KQmVzdCBSZWdhcmRz
LA0KSm9ha2ltIFpoYW5nDQo+IEpvaG4NCg0K
