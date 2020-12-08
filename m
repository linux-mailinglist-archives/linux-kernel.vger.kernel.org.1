Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D615B2D26B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgLHI6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:58:46 -0500
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:56038
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbgLHI6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:58:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5cHaGkj73GSImVudIauTs9M/JrX7uMwxE+nM/nryAp5T1SEOm7VkDzK64sdg1F7yH8wYsnQJVsaZ+md/IpOQNSi2KNa/PqrL2s5MZvedjJeqAfTvagHnuTMkyTqVfBcfbOJ/sRNgz2qE6K7cEGA5O8BZjW34gzBsRUZ3GPvu4nk8yKKemrCUQ7oGJfbSItVftk0lMNON3LGaAUUPuNT8ymTcANV+kV7S5YoApomiZsVfMyrjYzVOSSsBCf+QrYvyMDfdMfgVTf5Nt+32BgRNDRh74GgKb+M9sngyEqYBXGhkzt4cQMVjKaIov7hJknKT2pwvSB7uz2GqJmVaibYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLTP4bPLwKbZzAK5vfrbKsbciq7ZBtRnoDL3Q0XK/ik=;
 b=ZeDhBOhT5rginU2U4xbq/jU4eJEOjXQMXYoEnhuNVpkOE+EKz38M3PFMImK5LKZt49QfRYyJjtnAm7opbEvpPIKPel3zE+8P38ISs0lSyqYEApII0HQKCphwEeGWVz6xqUbSw0z1BmqjiMTiLsY3d01a6eJnEoSDtZkqS7qazGwrFLtWeN+UE2B9zh/Rd+Vk4o69YNi6+ZmiVVOS1VdX5pzWxZ7flx5j7PFDFniq0wIsfxPFuUz+FJY1gEjj5jjsbGfoPMXhvTO/H7ph5vw0TcwWwjFInQEB4PFPo2MvW0fKTt2sLC8ogJjsYNv94MnVfupvpZr6C9M2OdOxF37NGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLTP4bPLwKbZzAK5vfrbKsbciq7ZBtRnoDL3Q0XK/ik=;
 b=YFjVvdmuIH+xQ0ebVgOdEubKr4B02/Mym6xucQ4SY5Anhz4nayfCd2Cb3h5bIunr/lLfdJfd6z6hyYxtU0wYSaNVFG5A7JGGRgsfJJepGHhQC3MDUhI8rK2o0Qo1DouVxeWP0HzyiTOcv83ytdT7k3mZvAP57mRDeQc/mfRejQA=
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 (2603:10a6:803:11::14) by VI1PR04MB4560.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 08:57:49 +0000
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::4b3:7c0c:654c:7a61]) by VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::4b3:7c0c:654c:7a61%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 08:57:49 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
Thread-Topic: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
Thread-Index: AdbNP0ZCvzhLlXphQrCQw6k9XxC+yw==
Date:   Tue, 8 Dec 2020 08:57:49 +0000
Message-ID: <VI1PR0402MB334257A91BBAFE48C7AACD56E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54773e15-4179-4cb9-2062-08d89b5756cf
x-ms-traffictypediagnostic: VI1PR04MB4560:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB456007AC2070E3ABFFD9D436E3CD0@VI1PR04MB4560.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eT+xxk0IdZ8J07g/sp7BqJelhQZuR6PBG8YPfXveBvMbfrf1HzBKfiR3jcE0LZu5/UsFKJELbrPe+9YcJDS3Pw/AIRyOvgrK7rey5vyuZ3MdY4Kur9ZM5ULDmJ96HknRGBNbbk8x1PYrOPOMXlioNGJs5lqYODqCRijC1i17L+MVzT4jwhsPd2KI464HLM0tD66EJsUKGE4SuoxdaA26DvSZ0ECz52UjjnwOET+Lhgl5580C3tsqvD+Uud5nIcHGmD/uoZU9ODqakn7c9exx8UqRkfCGygkPl8OdzQbafJ7d5sc0XvGXSI5eCWZXb5D1Qe51/V15/4KYD1Ii8ifPfGACFpReK/W9vZmreQ8gG4hfNDks/oIXb4asLSSLkrCy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(66476007)(71200400001)(64756008)(76116006)(83380400001)(6506007)(66556008)(4326008)(66946007)(86362001)(66446008)(508600001)(54906003)(2906002)(9686003)(33656002)(6916009)(8936002)(26005)(5660300002)(186003)(52536014)(55016002)(8676002)(7696005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bzJJS1hOWTdiM1M1anBveVhkelZiNGJ3YzJlYzJUN0k0dVdUWWFXV0k3MGVq?=
 =?utf-8?B?VVBtd3pHY3NDeW5wbzhsN0t1a1EyYzZIUmxUUnJRVHFJWWpxNTRZZWxnSTI3?=
 =?utf-8?B?N1lpMFB2STArUTY2cWg1LzRPYkpkVG14NGtOYUQ0emQ2THJhaFYveXovdlBI?=
 =?utf-8?B?VC9sTlBkZldCa3MxS3hzK3hxTTFObHpnMmNQYTdkN2RrVnU1bFYvVkpYTjFt?=
 =?utf-8?B?M3NuMEdsT1BZbStBRmxJM0JMOUkwV0piQ1BHeERkR1pRVTE0dnM0bDdCNE5E?=
 =?utf-8?B?MCtIQnpDNXNhcU9lZGtFVDNYL1JEZmF6NldtSXRoL1MvYlA3OUxCUk9tSEk4?=
 =?utf-8?B?MFVzNmFvSkZ6OWtJUDVPNHdoWUZldGYyRk96OXV1NExicVpmbVpOREVMTFpI?=
 =?utf-8?B?Z1RSL1dTRlBtc1dDc0w4MVVXdy9aejJtU1Y5dUdnZGZzcFM4bCtlVEc2eWZJ?=
 =?utf-8?B?dzFTa2lVays3R1k4NWVOQ012VWJWT2toVVVnVVpyN2dUNVcwYURaNThlN1Ns?=
 =?utf-8?B?eUNwQ1FLWFk0NnJEL3B2MzF6bUtLTmtqam5JWkJidzVyV3YrUThpM1NPS01L?=
 =?utf-8?B?K1hsa3hFVGlnS21wRVcyaS8rcGx4Q0hlUzhEbG9ub3Q4bFhzMlFScTJXSnpK?=
 =?utf-8?B?RlRRNmRjME1KTFlrcTZNTXYvTWdUV2MxNFQ1dTJnMksvRlJzNWRObkNLbmQz?=
 =?utf-8?B?eC8wMG5FZDJ1MWlMK2hNNlZKOUIxbG43VW9HNitRdE1iZXhXRE5Sb3JxTFFL?=
 =?utf-8?B?cUxkYTBZNUpBcmhvbHJRTFRXVmFGSEliM2o0OThkWXcyQkF3WHBtT2hvOVpN?=
 =?utf-8?B?VDlSMWxrYmxrWmV4elZPZGRuYzlqd0luMWo3WFppN0hsa3g3UDN5NHNKVGZy?=
 =?utf-8?B?eVFXV3dQSW1RNGxRWm5vbUd1MXlISXlRdDR1V2ZSdjhxM1hBWnF3MVJzVjRK?=
 =?utf-8?B?NjM1QUNQQ3lYbzM3VEJRY0d6NUR5MEMvR0FaZi91YStWOG9vSkRBalp2VHNB?=
 =?utf-8?B?M0NlNWZVK09FZWg2cmNKNmkyQ0pQdHN2SmZhMStKQ1drYm5aTHREamdEK2U1?=
 =?utf-8?B?Y0k0NTAzOVNFeEpTVkJiSjNOSTAyOTRjaGV0VndtcFEvTUlMSjByTmEzazdS?=
 =?utf-8?B?aXJ1VkZ4bHkzNVFRS1ZhUytjWG5wdUJPemtKUThTYm5KbklwNHdEbHdIc0xL?=
 =?utf-8?B?YWpVUVU0bzFvK0dSYW4xRlNCemdiVXBlVkQ3cVh3NHE0eE5JQytEVGM0RWVN?=
 =?utf-8?B?RmZSUUYyZDE5T2pSdmFueUJYdFNVWEFKZXVMRzhkUkpmZWtwemlROEMzZU1n?=
 =?utf-8?Q?cMo93mhT/kOMk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54773e15-4179-4cb9-2062-08d89b5756cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 08:57:49.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hk0s3rUz7R3CUCkGs2laaW99pLSgkykyR93otK683K5UaW3EjCT12/vo1fK93byrYOzMBKkw3s7WQbLrDwEcfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4560
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIERlYyAwOCwgMjAyMCBhdCAwODo0NDo1MUFNICswMDAwLCBTLmouIFdhbmcgd3Jv
dGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gTW9uLCBEZWMgMDcsIDIwMjAgYXQgMDI6
MjE6NDBQTSArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiB3cm90ZToNCj4gPiA+ID4gPiA+
ID4gT24gTW9uLCBEZWMgMDcsIDIwMjAgYXQgMDI6NTM6MjRQTSArMDgwMCwgU2hlbmdqaXUgV2Fu
ZyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBFcnJvciBsb2c6DQo+ID4gPiA+ID4gPiA+ID4gc3lz
ZnM6IGNhbm5vdCBjcmVhdGUgZHVwbGljYXRlIGZpbGVuYW1lDQo+ID4gPiA+ID4gPiAnL2J1cy9w
bGF0Zm9ybS9kZXZpY2VzLzMwMDAwMDAwLmJ1cycNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+IFRoZSBzcGJhIGJ1cyBuYW1lIGlzIGR1cGxpY2F0ZSB3aXRoIGFpcHMgYnVzIG5hbWUu
DQo+ID4gPiA+ID4gPiA+ID4gUmVmaW5lIHNwYmEgYnVzIG5hbWUgdG8gZml4IHRoaXMgaXNzdWUu
DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBGaXhlczogOTcwNDA2ZWFlZjNhICgi
YXJtNjQ6IGR0czogaW14OG1uOiBFbmFibGUNCj4gPiA+ID4gPiA+ID4gPiBBc3luY2hyb25vdXMg
U2FtcGxlIFJhdGUgQ29udmVydGVyIikNCj4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGVuZ2ppdSBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+ID4gPiA+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5k
dHNpIHwgMiArLQ0KPiA+ID4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaQ0KPiA+ID4g
PiA+ID4gPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4g
PiA+ID4gPiA+ID4gPiBpbmRleCBmZDY2OWMwZjNmZTUuLjMwNzYyZWI0ZjBhNyAxMDA2NDQNCj4g
PiA+ID4gPiA+ID4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4u
ZHRzaQ0KPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbi5kdHNpDQo+ID4gPiA+ID4gPiA+ID4gQEAgLTI0Niw3ICsyNDYsNyBAQCBhaXBzMTog
YnVzQDMwMDAwMDAwIHsNCj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICNzaXpl
LWNlbGxzID0gPDE+Ow0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgcmFuZ2Vz
Ow0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICBz
cGJhOiBidXNAMzAwMDAwMDAgew0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
c3BiYTogc3BiYS1idXNAMzAwMDAwMDAgew0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBU
aGUgcHJvcGVyIG5vZGUgbmFtZSBpcyAiYnVzIiBzbyBiYXNpY2FsbHkgeW91IGludHJvZHVjZQ0K
PiA+ID4gPiA+ID4gPiB3cm9uZyBuYW1lIHRvIG90aGVyIHByb2JsZW0uICBJbnRyb2R1Y2luZyB3
cm9uZyBuYW1lcyBhdA0KPiA+ID4gPiA+ID4gPiBsZWFzdCByZXF1aXJlcyBhDQo+ID4gPiBjb21t
ZW50Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkganVzdCBub3RpY2VkIHRoYXQgbXkgbWVz
c2FnZSB3YXMgYmFyZWx5IHVuZGVyc3RhbmRhYmxlLi4uIHNvDQo+ID4gPiA+ID4gPiBsZXQgbWUN
Cj4gPiA+IGZpeCBpdDoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGUgcHJvcGVyIG5vZGUg
bmFtZSBpcyAiYnVzIiBzbyBiYXNpY2FsbHkgeW91IGludHJvZHVjZSB3cm9uZw0KPiA+ID4gPiA+
ID4gbmFtZSB0byBfZml4XyBvdGhlciBwcm9ibGVtLiAgSW50cm9kdWNpbmcgd3JvbmcgbmFtZXMg
YXQgbGVhc3QNCj4gPiA+IHJlcXVpcmVzIGEgY29tbWVudC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+IEhvd2V2ZXIgdGhlIGFjdHVhbCBwcm9ibGVtIGhlcmUgaXMgbm90IGluIG5vZGUgbmFt
ZXMgYnV0IGluDQo+ID4gPiBhZGRyZXNzZXM6DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ICAgICAgIGFpcHMxOiBidXNAMzAwMDAwMDAgew0KPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
IHNwYmE6IGJ1c0AzMDAwMDAwMCB7DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFlvdSBo
YXZlIHRvIGRldmljZXMgd2l0aCB0aGUgc2FtZSB1bml0IGFkZHJlc3MuIEhvdyBkbyB5b3UNCj4g
PiA+ID4gPiA+ID4gc2hhcmUgdGhlIGFkZHJlc3Mgc3BhY2U/DQo+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+IEkgdGhpbmsgdGhpcyBzaG91bGQgYmUgcmF0aGVyIGZpeGVkLg0KPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IEFuZCBhZ2FpbiwgaHVuZ3J5IGtleWJvYXJkIGF0ZSBhIGxldHRlciwg
c286DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gWW91IGhhdmUgX3R3b18gZGV2aWNlcyB3aXRo
IHRoZSBzYW1lIHVuaXQgYWRkcmVzcy4gSG93IGRvIHlvdQ0KPiA+ID4gPiA+ID4gc2hhcmUgdGhl
IGFkZHJlc3Mgc3BhY2U/DQo+ID4gPiA+ID4gPiBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIHJhdGhl
ciBmaXhlZC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBzcGJhIGlzIHRoZSBm
aXJzdCBibG9jayBvZiBhaXBzMSBzcGFjZSwgc28gaXQgaGFzIHNhbWUgc3RhcnQNCj4gPiA+ID4g
PiBhZGRyZXNzIGFzIGFpcHMxLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgcmVmZXJlbmNlIG1hbnVh
bCBkZXNjcmliZXMgaXQgIlJlc2VydmVkIGZvciBTRE1BMiBpbnRlcm5hbA0KPiA+ID4gPiBtZW1v
cnkiLCBzbyBpbmRlZWQgaXQgaXMgZmlyc3QgYWRkcmVzcyBidXQgZG9lcyBpdCBoYXZlIHRvIGJl
IG1hcHBlZD8NCj4gPiA+ID4gQW55d2F5LCB3aHkgZG9uJ3QgeW91IHVzZSByYW5nZXMgdG8gcmVt
b3ZlIHRoZSBjb25mbGljdD8NCj4gPiA+DQo+ID4gPiBUaGUgSU8gYWRkcmVzcyBzcGFjZSByZW1h
cHBpbmcgY291bGQgYmUgYSBzb2x1dGlvbiBidXQgdGhlcmUgaXMNCj4gPiA+IGFub3RoZXIgcHJv
YmxlbSAtIHRoZSBoYXJkd2FyZSByZXByZXNlbnRhdGlvbiBpbiBEVCBkb2VzIG5vdCBtYXRjaA0K
PiA+ID4gd2hhdCByZWZlcmVuY2UgbWFudWFsIGlzIHNheWluZy4NCj4gPiA+DQo+ID4gPiBUaGUg
QUlQUyBidXMgQDMwMDAwMDAwIGhhcyBzZXZlcmFsIElQczoNCj4gPiA+ICAtIFNBSTJAMzAwMjAw
MDANCj4gPiA+ICAtIC4uLg0KPiA+ID4gIC0gR1BJTzFAMzAyMDAwMDANCj4gPiA+DQo+ID4gPiBI
b3dldmVyIGluIERUUyB5b3Ugd2lsbCBmaW5kIGFkZGl0aW9uYWwgU1BCQSBidXMgZm9yIDMwMDAw
MDAwIC0NCj4gMzAwYzAwMDAuDQo+ID4gPiBJdCdzIG5vdCByZWFsbHkgdGhlIFNETUEsIGFzIFNE
TUEgaXMgYXQgZGlmZmVyZW50IGFkZHJlc3MuIEl0IGlzDQo+ID4gPiByYXRoZXIgYW4gYWRkcmVz
cyBzcGFjZSB3aGljaCBTRE1BIHNob3VsZCBtYXAuLi4gYnV0IGl0IGlzIG5vdCBhIGJ1cw0KPiB3
aXRoIGNoaWxkcmVuLg0KPiA+ID4gQWRkaW5nIHNwYmEtYnVzQDMwMDAwMDAwIHdpdGggaXRzIGNo
aWxkcmVuIGRvZXMgbm90IGxvb2sgbGlrZQ0KPiA+ID4gY29ycmVjdCByZXByZXNlbnRhdGlvbiBv
ZiBIVyBpbiBEVFMuDQo+ID4gPg0KPiA+DQo+ID4gSW4gdGhlIFJNLCBpdCBzYXlzIEFJUFMtMSAo
c19iXzEsIHZpYSBTUEJBKSBHbG9iLiBNb2R1bGUgRW5hYmxlLg0KPiA+IFJhbmdlIGlzICgzMDAw
MDAwMCAtIDMwMEZGRkZGKQ0KPiANCj4gTm8sIEFJUFMtMSBpcyB0aWxsIDMwM0ZfRkZGRi4NCg0K
WWVzLCAgQUlQU0EtMSBpcyB0aWxsIDMwM0ZfRkZGRiwgIGJ1dCBpdCBpcyBkaXZpZGVkIHRvIDIg
cGFydHMuDQooMzAwMDAwMDAgLSAzMDBGRkZGRikgaXMgdGhlIGZpcnN0IHBhcnQuIA0KDQpQbGVh
c2UgZ28gdG8gdGFibGUgMi0zIEFJUFMxIG1lbW9yeSBtYXAgaW4gUk0uICBJbiB0aGUgInJlZ2lv
biIgY29sdW1uLA0KVGhlcmUgaXMgIiBBSVBTLTEgKHNfYl8xLCB2aWEgU1BCQSkgR2xvYi4gTW9k
dWxlIEVuYWJsZSIuIEl0IG1lYW5zDQpUaGlzIHBhcnQgaXMgY29ubmVjdCB0byBTUEJBIGJ1cy4N
Cg0KQmVzdCByZWdhcmRzDQpXYW5nIFNoZW5naml1DQo=
