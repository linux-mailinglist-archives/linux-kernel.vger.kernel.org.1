Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D092DF5CB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 16:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgLTPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 10:08:51 -0500
Received: from mail-eopbgr80127.outbound.protection.outlook.com ([40.107.8.127]:40789
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbgLTPIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 10:08:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cmf8yR9P2aArYbkrQiloe2/sQmKLBLwAx7XA9A8J93nDmicM8FhTrYhsgDpRzq5hQeCkBcGQWXNgzZsvglwsdIUMUMz2KegAodyQj19Ca4gZlo/uPdVRWaVZK/HJY058mUFIbbCF8cr5MFdCi1oojQg/dFf0xkPvKsUyNRv1E6yrVhwIPtQko8DESnex3MXY7bqr7kZaWYSFvEjUHHPv++7jW+ObthwjAusnUtqsWVSmEr6SSL5RgJ3YW+QMGpYxgum+PZp4r6/+vN87stZT3hxKfld5tUxsmQMjc1mVPh5CezHjDVIo2VTEg0L5z5x3KzpLT0BHmd8aQQDDYE0gVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLlkerezhXVnu7URcUV/Pwpz7ZLot/3yHJb6bD2N8UI=;
 b=RZkPOUDWrY3jh+8UMFfZ3BEHGzcNFGILbv2Phf21KQbCKAdgZYaalOOtEBVEqmeyref1DAg07Tq0FL31stko59yL17Xm8xA4Iaeu2gSxop989tL7Jb8NI/0uyl2y/q601Bjc4qSaPnky6apaeBrfQyCdnMOzyXyrLoA1qlf8dn0Dhoj5NIzvJrZfx+Cv5FP2Esc6QMtrsRjKkslqsvkx+MnixJ1LW/5v7LWNJy1DUy7ldwu4UwLVoODJdhxOMEkmRUmnZ3Mt8otB7FHTDuzydOVwNs0NIiePBNQKalfdJ5xmqLKyKDs2B59MmyucvFpjk9xBEeScbjEE+NpvuAq0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLlkerezhXVnu7URcUV/Pwpz7ZLot/3yHJb6bD2N8UI=;
 b=ZLSP4RROJCaPL23qAkFl236GFJtYn226gzYOxdSH9LX3JUaINltj3nGz3eIgbLZCFKFfjSlVDKDSKVmWtQJuRFgccXcKxz4s/cHUvKg2tOX/rdIg39DJ/vK8LIp49qobGQT/+Eed/e09JCUX1Yw7HMH/afklM4XjFSOInTV/bFU=
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com (2603:10a6:20b:37::25)
 by AM6PR06MB4692.eurprd06.prod.outlook.com (2603:10a6:20b:58::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Sun, 20 Dec
 2020 15:07:58 +0000
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::b073:9747:410c:12c6]) by AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::b073:9747:410c:12c6%6]) with mapi id 15.20.3676.033; Sun, 20 Dec 2020
 15:07:57 +0000
From:   ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        "soc@kernel.org" <soc@kernel.org>
Subject: RE: [PATCH 0/2] drop unused POWER_AVS option for ARM/ARM64 config
Thread-Topic: [PATCH 0/2] drop unused POWER_AVS option for ARM/ARM64 config
Thread-Index: AQHWxwvPy9duOhNVsEeWqGLmfybe2qoAMVNA
Date:   Sun, 20 Dec 2020 15:07:57 +0000
Message-ID: <AM6PR06MB469153A8A3A1FCB576E9E215A6C10@AM6PR06MB4691.eurprd06.prod.outlook.com>
References: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
In-Reply-To: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=leica-geosystems.com;
x-originating-ip: [146.185.2.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10e9a89d-0365-47d7-349c-08d8a4f908df
x-ms-traffictypediagnostic: AM6PR06MB4692:
x-microsoft-antispam-prvs: <AM6PR06MB469220E987CB21DEF93CA422A6C10@AM6PR06MB4692.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZyPdi2hgjSrGqtzrWd2nKKX8RG55ASRDB8zBzrmk9MdxyVn7Lem8n3es+mKlcEkSz4mExNwmsnwX+k09xFTNERJ174+smZfFt8yqSzxkjZnPZ8ggZbAZGJFhvbUOUFSLc1SwLAgyoJ069amWp4oqsly8CqpzL6SUH2g8dPwGEBiY0oXLF10qP9JClvzv/bShcjxy4VwSvBOKPfCQBhHgVohDQLBm247jNMIfYnONZbxq3v8HaqQVwl7Tz9J9oBz0BI/05qMZCSCbEkpUNPbyzLbXtvosxYjYA6u2FbYiNEwXrJwawsmwHrZ2qGRwLjcKyv0bxTL/1LOTDLDTNNCKto+Elm/avVt7JAe3xcwkC1qZXnUbkn/wim5Dnsni28u7wJDuGj/Iw6oRO/sj5AEw54XbrHramCmlKvgW+uIJmmlkxJc386NUMBFpmOteZ4I4ovmOgN3MC2qauRk3y4NSTv72YQb9eknBd3CeICGBJ826HklzmW6XRZDFoUxC2bDFlFm48ldjIs8vDA7fefqtSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4691.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(83380400001)(921005)(8676002)(9686003)(76116006)(110136005)(316002)(478600001)(966005)(26005)(66556008)(66476007)(186003)(53546011)(2906002)(55016002)(64756008)(52536014)(6506007)(66946007)(33656002)(7416002)(86362001)(71200400001)(5660300002)(66446008)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZExjdWs0dThocTFML1B1bFo3NnQ3MjQxYkVYdEEwemttenVYNnp1eTBrdklQ?=
 =?utf-8?B?UTBMM2VrNTVGK0FJZW0xSThLejNXdHZPeENiNDBZMTZ0Z1JQbUxFWHlhSUpq?=
 =?utf-8?B?VWsyMWNLL01md3RuanNPd3NwdnVaTVhjUHBrQWRNaFhIWm93SGJReVhqRFpp?=
 =?utf-8?B?RGwrdlllSjlCaHV4U1JENmh5RFNoY1BjZ1BtRW5UOTNXZ01wc1BEeTRwTkt2?=
 =?utf-8?B?VzVneHBJTEZjcDNBTDc3UkZta1hVR1g1VGowMkNJSWlyaWNvcjVXQTBOUDJN?=
 =?utf-8?B?aVFzWWFxRi9FSklPMHRaaUMrZEd3T2VzUzI0MWYrK1J2anAvaE5VdERLWWZk?=
 =?utf-8?B?SjR5WHRaeDI4T0pnTVpQbURSbE5sY2phMGVrbHRkV2d3UzlOcEMvaVgvM2F2?=
 =?utf-8?B?cjczbXowbDF3YnNBbmF3K1FyRTFZY2pjb3U0bHg3cDBBSjQ4MTJlRUg0WFdl?=
 =?utf-8?B?UjVFeUV1V3hIdGM0MFFGTnhoU3FOTDB1bGR0WmZZcVVGS01IQWgyalNUZmwz?=
 =?utf-8?B?Vnd5bjRZOGR0OCt6NlZNOTRHRTQ1TmtOZFpLWTZoZmkySzk5WjlZYUtKaWc0?=
 =?utf-8?B?clRNdTBzVGRSVDB1NEtYVXZlYnBEdEpxYWc1Wm9sTlFmbGM3STJ2eXJGWGx0?=
 =?utf-8?B?cngyMEljbVFhSVNaKzVIeTRoclkvSnl5WGYxUFpCUUNpNU14enR3RjRxWUg0?=
 =?utf-8?B?bDhOYkJldyt0OFovdVc0ZmNVL3dYTFJpVk1Wbm5yNEhqTml1WGNYMG9naTVW?=
 =?utf-8?B?SUlmenVKMXhJNElaaVVvUkdtZStlYjNyU1FpNXlWMmM0aG1QMTIrTk50cWpV?=
 =?utf-8?B?ZG5VUzg0K3JQc0hJMlVTTWRLWVpuMWFVSklMTHZnS0p3ZnJ3RE9uelVvazFO?=
 =?utf-8?B?WDl1N0tSZmVTWWV5cEdPTTI5eTRDQktKYWZ2T2ZHNmFtOENBalVsUUdTWnVq?=
 =?utf-8?B?MFBWUnBDTkR5U2dSbFdNb1Z0RTBia051alE2YjlvSzdtb1ZTRjFYMTFIaE03?=
 =?utf-8?B?MUIwM2FCbTNTazBDQ09XUDFhNGJtaEJIUHZHZGZLZUR1MXByMW5hcVFaenZa?=
 =?utf-8?B?OTFjNjA2ZmV3TEtITkE1NmZON3hpSnhEMjRmZVdCNFA0NThVcU4yOU9qMHZC?=
 =?utf-8?B?ZSttc3BwaysrUm9rS3lHeXFNRHJEREgxeGE5TWRtbTUvQ1RvMG5FS2Z5amRO?=
 =?utf-8?B?VEZtVEpyWDBqdXM4QmFtNWplNDN0bUQyc2NFOFhySkZXZnYzR2hnWmt6VVRv?=
 =?utf-8?B?UEVhbmc3MnJnK0JMVENvZ3JmVjEzc1ZZZW9qZVFzL0lwTmt3UDA0dXZsdTQw?=
 =?utf-8?Q?q0cnRj7XRqLxM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4691.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e9a89d-0365-47d7-349c-08d8a4f908df
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2020 15:07:57.4033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pf/UUpKOuZgCpm3j0DDL8rl+glpLPjJmz2IM3XoVsDAcR0l0U8HEVrBJ727C3SbcMMuATm7WigGhDlhnP9+KJoRhPt29Z9YGyzGXwods+xA2tXmCLgsnl/ODOY0Chi4o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4692
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQXJuZCwNCg0KQSB3aGlsZSBhZ28sIEkndmUgc3VibWl0dGVkIHRoaXMgc2VyaWVzIHRv
IGNsZWFuLXVwIHRoZSB1bnVzZWQgUE9XRVJfQVZTIGNvbmZpZyBvcHRpb24sIGFuZA0KSXQgbG9v
a3MgbGlrZSBpdCBkaWQgbm90IGxhbmQgaW4gYW55b25lJ3MgdHJlZSB1bnRpbCBub3cuDQoNClNp
bWlsYXIgcGF0Y2ggdG8gY2xlYW4tdXAgdGhlIHNhbWUgb3B0aW9uIGluIG9tYXAycGx1c19kZWZj
b25maWcgaGFzIGJlZW4gYWxyZWFkeSBwaWNrZWQgdXANCmJ5IFRvbnkgTGluZGdyZW4gYW5kIGlz
IGFscmVhZHkgcHJlc2VudCBpbiB0aGUgbGludXgtbmV4dCB0cmVlLCBjb21taXQgMDQzNzE0MWI0
ZTIyICgiQVJNOg0KY29uZmlnczogZHJvcCB1bnVzZWQgQkFDS0xJR0hUX0dFTkVSSUMgb3B0aW9u
IikuDQoNClNlcmllcyBoYXMgYmVlbiBhbHJlYWR5IHJldmlld2VkIGJ5IEtyenlzenRvZiBhbmQg
TmlzaGFudGgsIGJ1dCBub2JvZHkgc2VlbXMgdG8gcGljayBpdCB1cCBmdXJ0aGVyLg0KDQpTaW5j
ZSBhdCB0aGUgdGltZSBvZiBzZW5kaW5nIHRoaXMgc2VyaWVzLCBJIHdhcyBub3QgYXdhcmUgdGhh
dCBBUk0gU09DIGxpc3Qgc2hvdWxkIGFsc28gYmUgaW5jbHVkZWQNCihzYW1lIHRoaW5nIGFzIGZv
ciBCQUNLTElHSFRfR0VORVJJQyBzZXJpZXMgWzFdKSwgSSB3YW50ZWQgdG8gYXNrIHlvdSBpZiB5
b3UgY2FuIHRha2UgY2FyZSBvZiB0aGlzDQpzZXJpZXMgZnVydGhlciBhcyBpdCBkb2VzIHRvdWNo
IHRoZSBtdWx0aSBjb25maWcgZm9yIGFybTMyIGFuZCBhYXJjaDY0Lg0KDQpPciBzaG91bGQgSSBy
ZS1zZW5kIHRoZSBzZXJpZXMgd2l0aCBjb2xsZWN0ZWQgdGFncyBhbmQgaW5jbHVkZSBBUk0gU09D
IGxpc3QgKHNhbWUgYXMgSSBkaWQgZm9yIA0KQkFDS0xJR0hUX0dFTkVSSUMgWzFdKT8NCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaSElaSElLSU4gQW5kcmV5IDxhbmRy
ZXkuemhpemhpa2luQGxlaWNhLWdlb3N5c3RlbXMuY29tPg0KPiBTZW50OiBNb25kYXksIE5vdmVt
YmVyIDMwLCAyMDIwIDEyOjI3IFBNDQo+IFRvOiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2ls
bEBrZXJuZWwub3JnOyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsNCj4gc2hhd25ndW9Aa2Vy
bmVsLm9yZzsgbGVveWFuZy5saUBueHAuY29tOyB2a291bEBrZXJuZWwub3JnOw0KPiBnZWVydCty
ZW5lc2FzQGdsaWRlci5iZTsgQW5zb24uSHVhbmdAbnhwLmNvbTsgbWljaGFlbEB3YWxsZS5jYzsN
Cj4ga3J6a0BrZXJuZWwub3JnOyBvbG9mQGxpeG9tLm5ldDsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
WkhJWkhJS0lOIEFuZHJleSA8YW5kcmV5LnpoaXpoaWtpbkBsZWljYS1nZW9zeXN0ZW1zLmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIIDAvMl0gZHJvcCB1bnVzZWQgUE9XRVJfQVZTIG9wdGlvbiBmb3Ig
QVJNL0FSTTY0IGNvbmZpZw0KPiANCj4gVGhpcyBzZXJpZXMgY2xlYW5zIHVwIGtlcm5lbCBjb25m
aWcgZmlsZXMsIHJlbW92aW5nIHRoZSB1bnVzZWQgUE9XRVJfQVZTDQo+IG9wdGlvbi4NCj4gDQo+
IEl0IGhhcyBiZWVuIHJlbW92ZWQgaW4gY29tbWl0IDc4NWI1YmI0MWIwYSAoIlBNOiBBVlM6IERy
b3AgdGhlIGF2cw0KPiBkaXJlY3RvcnkgYW5kIHRoZSBjb3JyZXNwb25kaW5nIEtjb25maWciKSwg
ZnJvbSB0aGUgdHJlZSBhbmQNCj4gdGhlcmVmb3JlIHNob3VsZCBiZSByZW1vdmVkIGZyb3JtIGRl
ZmF1bHQgY29uZmlnIGZpbGVzIGRlbGl2ZXJlZCBmb3IgQVJNDQo+IGFuZCBBUk02NCBidWlsZHMu
DQo+IA0KPiBBbmRyZXkgWmhpemhpa2luICgyKToNCj4gICBhcm02NDogZGVmY29uZmlnOiBkcm9w
IHVudXNlZCBQT1dFUl9BVlMgb3B0aW9uDQo+ICAgQVJNOiBtdWx0aV92N19kZWZjb25maWc6IGRy
b3AgdW51c2VkIFBPV0VSX0FWUyBvcHRpb24NCj4gDQo+ICBhcmNoL2FybS9jb25maWdzL211bHRp
X3Y3X2RlZmNvbmZpZyB8IDEgLQ0KPiAgYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAg
ICAgfCAxIC0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+
IDIuMTcuMQ0KDQpMaW5rOiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1r
ZXJuZWwvMjAyMDEyMDEyMjI5MjIuMzE4My0xLWFuZHJleS56aGl6aGlraW5AbGVpY2EtZ2Vvc3lz
dGVtcy5jb20vDQoNCi0tIEFuZHJleQ0KDQo=
