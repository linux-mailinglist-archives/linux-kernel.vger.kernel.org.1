Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1092FCF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbhATLf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:35:58 -0500
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:21571
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732954AbhATKUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:20:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQzYqrLci1PUwaW0w8uARPvHJW5ZJEheFLgONwiw0yqGcsaEi606/zUR8/P7kfNDN1EPecugx9UBemC1Nr4JqV3hBz/qhiF/qr9fQFoQUQyAqCqMhJIFF4135J4HuuGIJYMckvKJFZl9rOnv0ca3kGKqCmfW/5VWH+poC7/EepZkBd8x54GlFLv/8W5b5FS9s4pfFkrchhDDIiE0e+O8ONyEWARI/WZADIGWv1xHdgF23Q2rv2uCsiq//Fm6ieSzzeRt4SQFP1iXmvA/T2clTObp6TjmFw80h3czezGm4d+jdYSjiTmJtAuikLEK9bFFff7TQKRtGCXJmwUQ+JsmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+By0ln0kZ6RDKK5u48UYz4jFNYrzp3GsyYKOR8X+qw=;
 b=KQIPga95PT+hQDIVilOqeehdkYZ3LoTAeF6gVDVC2GgtYWPbGIaQGsTANoeroWjYL+tOhIODk3uSBiCaD5OfgErpGNK7dJIXAgpn9ClLollhXIvamIP6elVGVD0XZWaVk0aDLmBotXpXGP9UryI9CEC/eVgMWLLHmC8XqUtDtny9WNxmOhT6JUckRY78o9yyl8GRyGM/SZS79FV9zJaB6oryaXFV0yzVWuZ6L/8KJnQScZ+qNMhPFp6ZbQ/MJHLasdYCTFIy4UvdaMr9ysNwZcSIWBRMh0aGCf9yx9KkA6BYS+ivDbUDejRc7rb6DlMYeEAERAMi8isfJPSTkVLc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+By0ln0kZ6RDKK5u48UYz4jFNYrzp3GsyYKOR8X+qw=;
 b=L5mBWOQXnnyE5wp2igT8cTWocR9qfN4DX7MccTzP80dEdpueK++5vTE3ssPhb6dLmzdX55tLe0gC2AIEaHsXeAegcs/LXlSAZ3XDwI+IfopZIwLspBsYns6DuWPJ1TB83qpAw3fTkC1Snyp7LyBMz0yuZIXfcT27bM6Wpq7+xUQ=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7205.eurprd04.prod.outlook.com (2603:10a6:10:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 10:19:52 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 10:19:52 +0000
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
Thread-Index: AQHW7ksGebtibLbnaUWJ/YJe+SCr+aouwcUwgABWSgCAAB2ugIAAwm9ggABE8wCAABChoA==
Date:   Wed, 20 Jan 2021 10:19:51 +0000
Message-ID: <DB8PR04MB6795E408A826A37FF022303FE6A20@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
 <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
 <DB8PR04MB67951BF5DBE4524CB13BAAE4E6A20@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <c3d8d635-33ab-8d7e-6efc-6a589aebeb52@huawei.com>
In-Reply-To: <c3d8d635-33ab-8d7e-6efc-6a589aebeb52@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2743cb3d-0da7-4768-0892-08d8bd2cecb0
x-ms-traffictypediagnostic: DBAPR04MB7205:
x-microsoft-antispam-prvs: <DBAPR04MB7205297A1D91371908166D20E6A20@DBAPR04MB7205.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: INUyVmrLlMYINu8yx/ouw1Hnxv4m+xwvlu/SRMTJWpd6jlsxLe507EOZ20YijjjtqIdJksBo0wsUAVuehX8rbhG+16AU192z29/aBw3NurOyEzGZkdnNQ7L+kf4BlO/xoPOxDR+eKiZU7Z6ALiQfrQpncEqT46fG0xv7jA00Ce53RHPnayUjJpF2SGv2YWs89JGCA4jwOkUIqHX4+9dBA3TQDz8UigHDTFjTRRCXcdL7mIILp147Ma1vdgWv7rLSup3A2LT5QOpwxT+/Z2QXayZDBOEee4BmyDy1VCfnOuJUFBl7QjJ9cqkY3BdXGOzdRAhbWl13QnhY+1IX0pbBTVJs3u65I4Y1sG0isvOKHeH8+nheurTbl6RUfdpC4P9des01JCaLtgih92CUHWfsk33c3djGyMLJ+iDxWv9keb7RUw3YFQhG2fFMCTQD98iD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39850400004)(396003)(346002)(66556008)(66446008)(64756008)(54906003)(66476007)(33656002)(83380400001)(66946007)(55016002)(8936002)(8676002)(7416002)(26005)(4326008)(52536014)(6506007)(76116006)(110136005)(53546011)(86362001)(71200400001)(316002)(921005)(2906002)(19627235002)(9686003)(7696005)(478600001)(5660300002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OHVaSmZsOXp1SHQrb0RKRk40WktweHk4RTFXeFdzUHFwZnFKcWp0QWZRckZm?=
 =?utf-8?B?emFOb2xGMnM2TVltOGRkZUxuNnQ3K2hLbFNuOEpMRFNQSXpJdHh6aU1BWlZF?=
 =?utf-8?B?YzdUYS9Id2lkdTdHUkpMcTMxd3hUdFFqeXFlNmJFY0FZMjdNMTdGZHpUdUU5?=
 =?utf-8?B?aFhsaEFiU2EzTXRtUzNEZFdRMTdzTnlpUTh2ZVlFL1FpKzdiVzhMYUdrY3B3?=
 =?utf-8?B?eW5QeTFCd2ZyWnJiM01nei82dlZEbGJkRDlMMnV3V3dldTBHMitBNEFhQ1ll?=
 =?utf-8?B?OGY1aldGU0J3Z1lhci9nT04rUlJpa0NidlhGajdOUEtsY0F2UDl6NG5PdGhI?=
 =?utf-8?B?YUc5aU1KRDJHdDh1SG9yN2pTYmpPRWZ4em5jbExlS2VtU1VKbDQ0SVN0bFdl?=
 =?utf-8?B?amtGTStEcEhUQnNKeXljMEo0T2YzazhMSFNOTTUvUmxIdUNSaG5iZTVJVGpJ?=
 =?utf-8?B?L2ZPdGxuV0w4TVVMbExqUU5jcTBadmIycnF2MHBYb3QxOEl6Rkt1Zzd5K0xC?=
 =?utf-8?B?OThMVEo2U2c0VlRVZHVNQ21rUXNXMDRhR0M4Ymx5ZmROKzBHMUxKYkJndTBE?=
 =?utf-8?B?UTJDS3MyZmFVMVJQNksyL3hhTHVYQVM5K09NSEYzZHRJcCtpeGFkTXlzQUZW?=
 =?utf-8?B?Ky8rZG1wUFkvUGtBb1loMHZRL1kxSERmbEduY29EQWRNS2JLWStuaytzNmk0?=
 =?utf-8?B?T2FUS240VGxXTm1PUkRnMXFpcWVVS1BYb2VFWDczd1pPVXJGL1Mza3lmbUhh?=
 =?utf-8?B?UGhncWdxR3ExZ2N3ODRIZjJUd1Q3ekJheHNQUkhwWmJxL0tyVExIbVFDb3Jt?=
 =?utf-8?B?dEVuTzNlK0hhcWNVZkdSNmxnMWVFMk9FcWtFcStoMFFleitmeGJ4ajJrRjJ2?=
 =?utf-8?B?ZSszQkthcnVxL25TOElhd2RmVFJCV0VCRnBURzdiMEZNVjVQYUpBRTR4RnU1?=
 =?utf-8?B?OFVkNnVmc0FMOFZiUkdlYUxYdVJ4YW8wcUFJeFk4UkxWcHdyaHhabzNPL0N3?=
 =?utf-8?B?dzJLeEU3SWtzbjVWYW45NGh3U1ZwRU40QldTZDFLUjM0a1VISGFjTjhub25x?=
 =?utf-8?B?K1NoUHVpS0o5OG5VVi9oWWJtZ2VkUWNJYXViYVJoUGlOMCt3OWZNS1JMQkpP?=
 =?utf-8?B?bHJMbkl6eTltR1FwNGlkY1FMeTgzVXVLVk14K1MzS0s1eFhseUVxQ1pva3dq?=
 =?utf-8?B?RkEvdXdKS0thMjVid2M4RU1SQkJZWXBzUkZOZDFwK085V0MxL3BZN3hwZEZC?=
 =?utf-8?B?cFFGU281WHpCNG40d1h1MW9pZXEra2pKRVczYWx4T1lNSXoxbXZxbWVvVTBm?=
 =?utf-8?Q?R+Ta7noNtwsss=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2743cb3d-0da7-4768-0892-08d8bd2cecb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 10:19:51.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18Tyh1B4VWHkKtVkrgCoPzXKVUk8mVncJ02CBZNAtFA6IOMMuNwXmDhT0tdnLSvOj1aTcoPMLuVeauN1jg+0Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7205
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaG4gR2FycnkgPGpvaG4u
Z2FycnlAaHVhd2VpLmNvbT4NCj4gU2VudDogMjAyMeW5tDHmnIgyMOaXpSAxNzoxNg0KPiBUbzog
Sm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IHBldGVyekBpbmZyYWRlYWQu
b3JnOw0KPiBtaW5nb0ByZWRoYXQuY29tOyBhY21lQGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBh
cm0uY29tOw0KPiBhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tOyBqb2xzYUByZWRo
YXQuY29tOw0KPiBuYW1oeXVuZ0BrZXJuZWwub3JnOyBpcm9nZXJzQGdvb2dsZS5jb207IGtqYWlu
QGxpbnV4LmlibS5jb20NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
YXJtQG9wZW5ldWxlci5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcGVyZiBtZXRyaWNncm91
cDogRml4IHN5c3RlbSBQTVUgbWV0cmljcw0KPiANCj4gT24gMjAvMDEvMjAyMSAwNToxNSwgSm9h
a2ltIFpoYW5nIHdyb3RlOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4NCj4gPj4gU2VudDog
MjAyMeW5tDHmnIgyMOaXpSAxOjMzDQo+ID4+IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56
aGFuZ0BueHAuY29tPjsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7DQo+ID4+IG1pbmdvQHJlZGhhdC5j
b207IGFjbWVAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+ID4+IGFsZXhhbmRl
ci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb207IGpvbHNhQHJlZGhhdC5jb207DQo+ID4+IG5hbWh5
dW5nQGtlcm5lbC5vcmc7IGlyb2dlcnNAZ29vZ2xlLmNvbTsga2phaW5AbGludXguaWJtLmNvbQ0K
PiA+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXhhcm1Ab3BlbmV1bGVy
Lm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBwZXJmIG1ldHJpY2dyb3VwOiBGaXggc3lz
dGVtIFBNVSBtZXRyaWNzDQo+ID4+DQo+ID4+IE9uIDE5LzAxLzIwMjEgMTU6NDcsIEpvaG4gR2Fy
cnkgd3JvdGU6DQo+ID4+PiBPbiAxOS8wMS8yMDIxIDEwOjU2LCBKb2FraW0gWmhhbmcgd3JvdGU6
DQo+ID4+Pj4gSXQgc2VlbXMgaGF2ZSBvdGhlciBpc3N1ZSBjb21wYXJlZCB0byA1LjEwIGtlcm5l
bCBhZnRlciBzd2l0Y2hpbmcNCj4gPj4+PiB0byB0aGlzIGZyYW1ld29yaywgYmVsb3cgbWV0cmlj
IGNhbid0IHdvcmsuDQo+ID4+Pj4gIk1ldHJpY0V4cHIiOiAiKCggaW14OF9kZHIwQHJlYWRcXC1j
eWNsZXNAICsNCj4gPj4+PiBpbXg4X2RkcjBAd3JpdGVcXC1jeWNsZXNADQo+ID4+Pj4gKSAqIDQg
KiA0IC8gZHVyYXRpb25fdGltZSkgLyAoNzUwICogMTAwMDAwMCAqIDQgKiA0KSINCj4gPj4+PiBB
ZnRlciBjaGFuZ2UgdG86DQo+ID4+Pj4gIk1ldHJpY0V4cHIiOiAiKCggaW14OG1tX2Rkci5yZWFk
X2N5Y2xlcyArIGlteDhtbV9kZHIud3JpdGVfY3ljbGVzDQo+ID4+Pj4gKQ0KPiA+Pj4+ICoNCj4g
Pj4+PiA0ICogNCAvIGR1cmF0aW9uX3RpbWUpIC8gKDc1MCAqIDEwMDAwMDAgKiA0ICogNCkiLA0K
PiA+Pj4NCj4gPj4+IEl0IHNlZW1zIHRoYXQgYW55IG1ldHJpYyB3aGljaCBpbmNsdWRlcyAiZHVy
YXRpb25fdGltZSIgaXMgYnJva2VuLA0KPiA+Pj4gZXZlbiBvbiB4ODY6DQo+ID4+Pg0KPiA+Pj4g
am9obkBsb2NhbGhvc3Q6fi9hY21lL3Rvb2xzL3BlcmY+IHN1ZG8gLi9wZXJmIHN0YXQgLXYgLU0N
Cj4gPj4+IEwxRF9DYWNoZV9GaWxsX0JXIHNsZWVwIDEgVXNpbmcgQ1BVSUQgR2VudWluZUludGVs
LTYtM0QtNCBtZXRyaWMNCj4gPj4+IGV4cHINCj4gPj4+IDY0ICogbDFkLnJlcGxhY2VtZW50IC8g
MTAwMDAwMDAwMCAvIGR1cmF0aW9uX3RpbWUgZm9yDQo+ID4+PiBMMURfQ2FjaGVfRmlsbF9CVyBm
b3VuZCBldmVudCBkdXJhdGlvbl90aW1lIGZvdW5kIGV2ZW50DQo+ID4+PiBsMWQucmVwbGFjZW1l
bnQgYWRkaW5nIHtsMWQucmVwbGFjZW1lbnR9OlcsZHVyYXRpb25fdGltZQ0KPiA+Pj4gbDFkLnJl
cGxhY2VtZW50IC0+IGNwdS91bWFzaz0weDEsKG51bGwpPTB4MWU4NDgzLGV2ZW50PTB4NTEvDQo+
ID4+PiBTZWdtZW50YXRpb24gZmF1bHQNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gU2VlbXMgdG8gYmUg
ZnJvbSBteSBjb21taXQgYzIzMzdkNjcxOTkgKCJwZXJmIG1ldHJpY2dyb3VwOiBGaXgNCj4gPj4+
IG1ldHJpY3MgdXNpbmcgYWxpYXNlcyBjb3ZlcmluZyBtdWx0aXBsZSBQTVVzIikNCj4gPj4+DQo+
ID4+PiBJJ2xsIGxvb2sgdG8gZml4IGl0IG5vdy4NCj4gPj4+DQo+ID4+DQo+ID4+IFBsZWFzZSB0
cnkgdGhpczoNCj4gPj4NCj4gPj4gICBGcm9tIDIzODBmMWVmMDI1MGU2ODE4YjNkYmM3YmZmNGE4
Njg4MTA4NzVlMmEgTW9uIFNlcCAxNw0KPiAwMDowMDowMA0KPiA+PiAyMDAxDQo+ID4+IEZyb206
IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT4NCj4gPj4gRGF0ZTogVHVlLCAxOSBK
YW4gMjAyMSAxNzoyOTo1NCArMDAwMA0KPiA+PiBTdWJqZWN0OiBbUEFUQ0hdIHBlcmYgbWV0cmlj
Z3JvdXA6IEZpeCBtZXRyaWMgc3VwcG9ydCBmb3INCj4gPj4gZHVyYXRpb25fdGltZQ0KPiA+Pg0K
PiA+PiBGb3IgYSBtZXRyaWMgdXNpbmcgZHVyYXRpb25fdGltZSwgdGhlIHN0cmNtcCgpIGNoZWNr
IHdoZW4gZmluZGluZw0KPiA+PiBpZGVudGljYWwgZXZlbnRzIGluIG1ldHJpY19ldmVudHNbXSBp
cyBicm9rZW4sIGFzIGl0IGRvZXMgbm90DQo+ID4+IGNvbnNpZGVyIHRoYXQgdGhlIGV2ZW50IHBt
dV9uYW1lIGlzIE5VTEwgLSBpdCB3b3VsZCBiZSBmb3IgZHVyYXRpb25fdGltZS4NCj4gPj4NCj4g
Pj4gQXMgc3VjaCwgYWRkIGEgTlVMTCBjaGVjayBoZXJlIGZvciBldmVudCBwbXVfbmFtZS4NCj4g
Pj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29t
Pg0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL21ldHJpY2dyb3VwLmMN
Cj4gPj4gYi90b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuYyBpbmRleCBlZTk0ZDNlOGRkNjUu
LjI3N2FkZmY4MDE3Zg0KPiA+PiAxMDA2NDQNCj4gPj4gLS0tIGEvdG9vbHMvcGVyZi91dGlsL21l
dHJpY2dyb3VwLmMNCj4gPj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL21ldHJpY2dyb3VwLmMNCj4g
Pj4gQEAgLTI4MCw2ICsyODAsOCBAQCBzdGF0aWMgc3RydWN0IGV2c2VsICpmaW5kX2V2c2VsX2dy
b3VwKHN0cnVjdA0KPiA+PiBldmxpc3QgKnBlcmZfZXZsaXN0LA0KPiA+PiAgICAJCQkgKi8NCj4g
Pj4gICAgCQkJaWYgKCFoYXNfY29uc3RyYWludCAmJg0KPiA+PiAgICAJCQkgICAgZXYtPmxlYWRl
ciAhPSBtZXRyaWNfZXZlbnRzW2ldLT5sZWFkZXIgJiYNCj4gPj4gKwkJCSAgICBldi0+bGVhZGVy
LT5wbXVfbmFtZSAmJg0KPiA+PiArCQkJICAgIG1ldHJpY19ldmVudHNbaV0tPmxlYWRlci0+cG11
X25hbWUgJiYNCj4gPj4gICAgCQkJICAgICFzdHJjbXAoZXYtPmxlYWRlci0+cG11X25hbWUsDQo+
ID4+ICAgIAkJCQkgICAgbWV0cmljX2V2ZW50c1tpXS0+bGVhZGVyLT5wbXVfbmFtZSkpDQo+ID4+
ICAgIAkJCQlicmVhazsNCj4gPj4gLS0NCj4gPj4gMi4yNi4yDQo+ID4+DQo+ID4+DQo+ID4NCj4g
PiBGb3IgdGhpcyBwYXRjaDogVGVzdGVkLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFu
Z0BueHAuY29tPg0KPiA+DQo+ID4gSGkgSm9obiwgSm9sc2EsDQo+ID4NCj4gPiBJcyB0aGVyZSBh
bnkgd2F5IHRvIGF2b2lkIGJyZWFraW5nIGV4aXN0IG1ldHJpYyBleHByZXNzaW9ucz8gSWYgbm90
LCBpdCB3aWxsDQo+IGFsd2F5cyBoYXBwZW5lZCBhZnRlciBtZXRyaWNncm91cCBjaGFuZ2VzLg0K
PiA+DQo+IA0KPiBUaGV5IGFyZSBub3Qgbm9ybWFsbHkgYnJva2VuIGxpa2UgdGhhdC4gTm9ybWFs
bHkgd2UgdGVzdCBiZWZvcmVoYW5kLCBidXQgdGhlc2UNCj4gY2FzZXMgd2VyZSBtaXNzZWQgaGVy
ZSBieSBtZS4gSG93ZXZlciBpZiB5b3Ugd2VyZSB0ZXN0aW5nIHRoZW0gcHJldmlvdXNseSwNCj4g
dGhlbiBpdCB3b3VsZCBiZSBleHBlY3RlZCB0aGF0IHlvdSBoYWQgdGVzdGVkIHRoZW0gYWdhaW4g
Zm9yIHRoZSBmaW5hbCBwYXRjaHNldA0KPiB3aGljaCB3YXMgbWVyZ2VkLg0KDQoNClllcywgSm9o
biwgc29ycnkuIEkgaGF2ZSBub3QgZGlkIHRoZSBmdWxseSB0ZXN0IGJlZm9yZSwgdGhpcyBjb3Vs
ZCBiZSBhdm9pZGVkLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gQW55d2F5LCB3
ZSBjYW4gbG9vayB0byBhZGQgbWV0cmljIHRlc3RzIGZvciB0aGVzZS4NCj4gDQo+IEBBcm5hbGRv
LCBJIHdpbGwgc2VuZCBzZXBhcmF0ZSBmb3JtYWwgcGF0Y2ggZm9yIHRoaXMgdG9kYXkuDQo+IA0K
PiBUaGFua3MsDQo+IEpvaG4NCg0K
