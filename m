Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545A82DE037
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 10:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbgLRJFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 04:05:54 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:44906
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728210AbgLRJFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:05:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqi2Uxfo51hDpDpJOyiT6ZzD22Y3OkN8jOzf0y0yRaqYrshNxWMFwgjFjFiUKkU2KcYdbVJRzSwbNINKL4a4yOCqwG7zIQI251TU3jxN2idKgSxMgpzILiJ0aSFSX6tcwh8iw2Csst/W+yNE20SGXqF0fE01PgjckfBJqVoTkI8MmVEW7aU71qdeQqRN/2wtxdGLFYPkkkrXutO6NrdAL+Oku/pCmrtE66UvBqYWGrdBwz/JpU3e9LzoDoiT3cK/I01r1pcfggfcmSpK+gGi5SF5Ra/KKdllfmd0eycc0znOPRk0PLzK2LNVgDjVQbRWgcGPwLrF67HgI0EE9GIFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHyBtAAAlA0RYFNNg78riFcJ/+MO0OtJSHEKVXNRdPA=;
 b=hIWKLb7aVFeFxjNip2PJ05FOa1YDnyl1f8LSRpdkzbZ7D4TnU63yA6i4AiKu9iVfY2DJDWeM87R8zRCMQ8tP7jqDgWl1/w7dDbN9Ffuu458bEUoWWLvOuA3MwTckPfpQkBkfWBIPSo25cFkv6AzPkLC8vAPBzcucWgM0K8aU4hzN3jXcZqcTfihZAcsIm43Kpd8OiuLSGNb0outMd1haeBZlXbKyGlas7+4N5fAuItguz9GX0CrfB92myTU/YO9ZVz2fkze4k0SgrIOuKrHDW6ZBuEAAhK8ThG1F3yOz3TnK1iB744Y1OCmT+XwdmvverbxzNmqOG+ve4Fvu7M3/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHyBtAAAlA0RYFNNg78riFcJ/+MO0OtJSHEKVXNRdPA=;
 b=bMI/p6tt7anH6HFsKOzzuAjc63GnlEbidfXx2KwtTH3DEuZuqU+90Kl3pgEkKb7nCTtGzL06y+4mee8+Hxn6G/FMn+5er7L+0gASvLqpR0rHhairDXktXjWQYrqw753MGVNulOL/wfCR1FYaaebi+xfStAY2y3RrQj2I2fZYAvA=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4918.eurprd04.prod.outlook.com (2603:10a6:20b:6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Fri, 18 Dec
 2020 09:05:00 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 09:05:00 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Topic: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Index: AQHW1RkPpji9TbVGY0Ki90hKbr4yE6n8jAGAgAADNXA=
Date:   Fri, 18 Dec 2020 09:05:00 +0000
Message-ID: <AM6PR04MB6053A65F794B316659CDE638E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
 <20201218085223.GA17306@kozik-lap>
In-Reply-To: <20201218085223.GA17306@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd757308-a990-42a8-c246-08d8a333ffcb
x-ms-traffictypediagnostic: AM6PR04MB4918:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4918FCA8724E3C877BC31108A3C30@AM6PR04MB4918.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGPyEtj40WjcwnHH/ShsnmsHA3H/+5GLWxXqcNVPbIhNBa8Ro8eVLg1IFKU6VPxxU4lCTr9go3YIoArpU3naTKrKc0SPnY/lgPvmzqFpRlay1tDA2IQuWTWJ92N/hXFivY/TZQJHK6Um56uzUJEyStiOGRbAMtS6HGHQfziXiw/gBX1q7uDbh3uKfuUxPHaZXp2iQVlNIbpTP1tAtTGnNJnKiRn6r36SFM6QMhI7agvLbpzQ3mzoVr26KDlwVSjPIemQy1erK7YobQu8QXFQnL5ezktGXavRK9zYSKwHBbOhbw0lKeBHGGyUNoylm7flygB/EBWz60GI2xTtdUqW+XdcShC37F/YrzxoUQvmLAYPAQctuA8IcDBAIrcgGhWX9V6AgbXrk/NoH/nfplkaq5IDFInAnyoBA9fN5rsZOhImqg9m3aD2s15Ih1hpad+8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(71200400001)(966005)(7696005)(66946007)(64756008)(4326008)(66446008)(8676002)(2906002)(110136005)(76116006)(86362001)(9686003)(8936002)(55016002)(66476007)(83380400001)(52536014)(5660300002)(478600001)(26005)(53546011)(6506007)(316002)(186003)(33656002)(54906003)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dzhBM3VDeTEyajJhQ0RZMFIwZG1qRERXWWtyRHVZWWxJVklVSWszVEJlK2Ew?=
 =?utf-8?B?MzVKUG9zb2dva2NUY21tMHdBZmtEUmJYeG5VM2FCOHRRM3Z2cWl6OE14akVW?=
 =?utf-8?B?WUtxTE0yZXF0bXlhSHFpcGJoblRORENZYmpNNzdIZ2pZcWxXKy9tTzRQTG1s?=
 =?utf-8?B?ZzFTdTQzOGtOQlJWRFJiWWlPLzFzRnVFZ3F6MmN5czI2d0VyWndlSEtWeDY0?=
 =?utf-8?B?YUZBQmlHdXk3SVA1OGhvMGpEWnlYa3U3MU1FM203VUU4ZkZ1b25TWHh1V0h1?=
 =?utf-8?B?Ykt2ektzN0JUVmRFdFRJeldtYm8xVGxKd0NyK2dEVXVtOGg3WmdKKzIyTk9x?=
 =?utf-8?B?OFp5MWRWYllGVTdyekVyeitPUE9iYmNWaVNGaDdlV2JYdHhOazJQWEVYMm8r?=
 =?utf-8?B?M0Y3R09MdDZ0ZkpNL3E2eklNSWdiMS9NMVlSTkUvSU4zdFhFL1FRNFNwOUpk?=
 =?utf-8?B?SHgxM0xyYmNJb3BqWkxFb1lQN2ZEVVoxazJYeU5PSWRYRk5EbkNENC9YNlVv?=
 =?utf-8?B?MUE5M0p0TmNmT2MzTng0Y1MwSkE4QmgwME9FeXJpU210R1VxN0xieDZNOHlG?=
 =?utf-8?B?ZEU4ZkFnR2Q1ZE02RDFzSG1pR245Ryt0cTNldXJad1hZbjFHQWhzbHF5UWFG?=
 =?utf-8?B?dkFCS3NkRStWa1BqTS9scnZqdHhYUWJTUmorbStYa1NXWGNMZ2IrYVYxN05o?=
 =?utf-8?B?WjhPanRIZEtmcUtBZDgxM2NxR2NhOW1oaWw2Rk9pd21LVzdBc09Da1gycjQz?=
 =?utf-8?B?TkRzVmptWkpTZ0ZLekJMWnEyK2pSMXY1aGs4K1FUY1NRV3YrSVZBQjRxa04r?=
 =?utf-8?B?TE9QUGVwanZBdEhnL3doNlQ0Z0t2WU1NYWk0UTV3NGxDOEI5VEtXR0owSUlJ?=
 =?utf-8?B?UTBLRk5QczF5ay9rMlZzKzc2dXNmMzhoN3JGSldIRkNmOE5EME00cER6SzFT?=
 =?utf-8?B?UVAwN2ZHc21Nem5JbG5ObzlDcXNhVUEwcmg0c2YvUCtkc0szclNSUnlxeUZo?=
 =?utf-8?B?WEJUSXpBV0VDcStnTjk3ekUvWjNxc0pGU3I4elJXd3VIc0pKcEkvNjQyWDE5?=
 =?utf-8?B?UUFhU1d1T2laZXhwUklRTkJwYlhBVENXTCt3bG51OVdNRVZzMUJlMHlET0RD?=
 =?utf-8?B?RzJqY1dYTE00R0pCL0t6WFdVandsSlQvcXk3K3ZGTjNvc1FPSmRiQTNIbk44?=
 =?utf-8?B?a3NnVnFjMnhMcE1TTFRHWTNrM2tpdFhoVHIzbm4wcTBmci9ZN285TC9UUkZv?=
 =?utf-8?B?Ukt1SjNvSk1xNnROKzFCdHIwcVJOMFg3b0ZNeHVoNzNXQkRmeHFobXh6VGVq?=
 =?utf-8?Q?2QhFdMGD8FqbU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd757308-a990-42a8-c246-08d8a333ffcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 09:05:00.2268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsjMQ3EOiLgjhjVnULT9tAOWYBRJMMXGzm8Oa6zb+bW+3eyC52RJH7iza1EwTzgnI1lbYRLkVKjALT4gS9kEUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4918
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTLmnIgxOOaXpSAxNjo1Mg0K
PiBUbzogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IENjOiByb2Jo
K2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDEvNF0gZHQtYmluZGluZ3M6
IHNvYzogaW14OG06IGFkZCBEVCBCaW5kaW5nIGRvYyBmb3Igc29jDQo+IHVuaXF1ZSBJRA0KPiAN
Cj4gT24gRnJpLCBEZWMgMTgsIDIwMjAgYXQgMDQ6Mzc6MjNQTSArMDgwMCwgQWxpY2UgR3VvIChP
U1MpIHdyb3RlOg0KPiA+IEZyb206IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4N
Cj4gPiBBZGQgRFQgQmluZGluZyBkb2MgZm9yIHRoZSBVbmlxdWUgSUQgb2YgaS5NWCA4TSBzZXJp
ZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+DQo+ID4gQ2hhbmdlcyBmb3Igdjg6DQo+ID4gIC0gbWF0Y2ggc29jIG5v
ZGUgd2l0aCByZWd1bGFyIGV4cHJlc3Npb24gQ2hhbmdlcyBmb3Igdjc6DQo+ID4gIC0gY2hhbmdl
IHRvIGEgc2VwYXJhdGUgc2NoZW1hIGZpbGUNCj4gPiBDaGFuZ2VzIGZvciB2NjoNCj4gPiAgLSBu
b25lDQo+ID4gQ2hhbmdlcyBmb3IgdjU6DQo+ID4gIC0gY29ycmVjdCB0aGUgZXJyb3Igb2YgdXNp
bmcgYWxsT2YNCj4gPiBDaGFuZ2VzIGZvciB2NDoNCj4gPiAgLSB1c2UgYWxsT2YgdG8gbGltaXQg
bmV3IHZlcnNpb24gRFRTIGZpbGVzIGZvciBpLk1YOE0gdG8gaW5jbHVkZQ0KPiA+ICAgICJmc2ws
aW14OG0qLXNvYyIsIG52bWVtLWNlbGxzIGFuZCBudm1lbS1jZWxscy1uYW1lcyBDaGFuZ2VzIGZv
ciB2MzoNCj4gPiAgLSBwdXQgaXQgaW50byBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2ZzbC55YW1sDQo+ID4gIC0gbW9kaWZ5IHRoZSBkZXNjcmlwdGlvbiBvZiBudm1lbS1j
ZWxscw0KPiA+ICAtIHVzZSAibWFrZSBBUkNIPWFybTY0IGR0YnNfY2hlY2siIHRvIG1ha2Ugc3Vy
ZSBpdCBpcyByaWdodCBDaGFuZ2VzDQo+ID4gZm9yIHYyOg0KPiA+ICAtIHJlbW92ZSB0aGUgc3Vi
amVjdCBwcmVmaXggIkxGLTI1NzEtMSINCj4gPg0KPiA+ICAuLi4vYmluZGluZ3Mvc29jL2lteC9p
bXg4bS1zb2MueWFtbCAgICAgICAgICAgfCA1NA0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2lteDhtLXNv
Yy55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvYy9pbXgvaW14OG0tc29jLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb2MvaW14L2lteDhtLXNvYy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmYwYjBmYzdiM2FjNg0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2lt
eC9pbXg4bS1zb2MueWFtbA0KPiA+IEBAIC0wLDAgKzEsNTQgQEANCj4gPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiAr
LS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL2lteC9pbXg4
bS1zb2MueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2No
ZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogTlhQIGkuTVg4TSBTZXJpZXMgU29D
DQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEFsaWNlIEd1byA8YWxpY2UuZ3Vv
QG54cC5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIE5YUCBpLk1YOE0g
c2VyaWVzIFNvQ3MgY29udGFpbiBmdXNlIGVudHJpZXMgZnJvbSB3aGljaCBTb0MgVW5pcXVlDQo+
ID4gK0lEIGNhbiBiZQ0KPiA+ICsgIG9idGFpbmVkLg0KPiA+ICsNCj4gPiArc2VsZWN0Og0KPiA+
ICsgIHByb3BlcnRpZXM6DQo+ID4gKyAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICBjb250YWlu
czoNCj4gPiArICAgICAgICBlbnVtOg0KPiA+ICsgICAgICAgICAgLSBmc2wsaW14OG1tDQo+ID4g
KyAgICAgICAgICAtIGZzbCxpbXg4bW4NCj4gPiArICAgICAgICAgIC0gZnNsLGlteDhtcA0KPiA+
ICsgICAgICAgICAgLSBmc2wsaW14OG1xDQo+ID4gKyAgcmVxdWlyZWQ6DQo+ID4gKyAgICAtIGNv
bXBhdGlibGUNCj4gPiArDQo+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICsgICJec29jQFsw
LTlhLWZdKyQiOg0KPiANCj4gVGhhbmtzLCBub3cgaXQgd29ya3MuDQo+IA0KPiA+ICsgICAgdHlw
ZTogb2JqZWN0DQo+ID4gKyAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICBjb21wYXRpYmxlOg0K
PiA+ICsgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAg
ICAgICAgIC0gZnNsLGlteDhtbS1zb2MNCj4gPiArICAgICAgICAgICAgICAtIGZzbCxpbXg4bW4t
c29jDQo+ID4gKyAgICAgICAgICAgICAgLSBmc2wsaW14OG1wLXNvYw0KPiA+ICsgICAgICAgICAg
ICAgIC0gZnNsLGlteDhtcS1zb2MNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMN
Cj4gPiArDQo+ID4gKyAgICAgIG52bWVtLWNlbGxzOg0KPiA+ICsgICAgICAgIG1heEl0ZW1zOiAx
DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IFBoYW5kbGUgdG8gdGhlIFNPQyBVbmlxdWUgSUQg
cHJvdmlkZWQgYnkgYSBudm1lbQ0KPiA+ICsgbm9kZQ0KPiA+ICsNCj4gPiArICAgICAgbnZtZW0t
Y2VsbHMtbmFtZXM6DQo+ID4gKyAgICAgICAgY29uc3Q6IHNvY191bmlxdWVfaWQNCj4gPiArDQo+
ID4gKyAgICByZXF1aXJlZDoNCj4gPiArICAgICAgLSBjb21wYXRpYmxlDQo+ID4gKyAgICAgIC0g
bnZtZW0tY2VsbHMNCj4gPiArICAgICAgLSBudm1lbS1jZWxsLW5hbWVzDQo+ID4gKw0KPiA+ICth
ZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZQ0KPiANCj4gRG9uJ3QgbGVhdmUgY29tbWVudHMgdW5y
ZXNvbHZlZCAob3IgcmVzb2x2ZSB0aGVtIGFnYWluc3QgcmV2aWV3IHdpdGhvdXQNCj4gZGlzY3Vz
c2lvbikuIFJvYiBhc2tlZCBmb3IgY2hhbmdpbmcgaXQuIFRoZSBzYW1lIGFzIHdpdGggYWxsIHNj
aGVtYXMgLSB5b3UgbmVlZA0KPiB0byBkZXNjcmliZSB0aGUgbWlzc2luZyBwcm9wZXJ0aWVzLg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KSGksDQpUaGFuayB5b3UgZm9yIHlv
dXIgYWR2aWNlLiBJIHJlcGxpZWQgdG8gaGltIGFuZCBsZXQgaGltIGtub3cgSSByZW1haW5lZCBo
ZXJlIHVuY2hhbmdlZC4gVGhlcmUgd2lsbCBiZSBlcnJvcnMgYWNjb3JkaW5nIHRvIGhpcyBzdWdn
ZXN0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZQ0KDQo=
