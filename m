Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ACC2DDF36
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 08:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgLRHqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 02:46:35 -0500
Received: from mail-am6eur05on2085.outbound.protection.outlook.com ([40.107.22.85]:14216
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbgLRHqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 02:46:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJPJsWsm73vvA+40x/5QtcxUETQnq2kU4hSwyAQ1eFi3q0GIpBtxuhxw1THxlt6u5asrFdIOIQ1i6bxY15VlvGSCyIF5Bc1RMFgsT1rsGvlyeL0x+rMM9Cy16QBCaC7bzfNEbGpBWGOEjUQZcvg+QaOM8ZQL5VqBSpl6GkGm4m2/qhaifTagiYwWMP3nrxDO//Ziq/AFtkhitkA59AoH0TWn2Qp7bxKfp5OeWzWfBZ23uW121iTQCPU1mXLjd4loUYcf4W6es97YQq/NaOHwg7qf49xRxMjkkm9jJ0laF75knZR6bPmtHp/zKxwxhJDr6hWUspTQ0WGx31kAMOZcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oSG8FTXX8sGPGz88eG+DjweAu58LjZqrHhM6g4o30M=;
 b=KAM6EDkZvf2tvIuOLqxSdYtnclcKIZP+pEduYBFJ7TfZ5SE/v0oWsuzqx+4p0tqKKzxpHvT2UzfrWMaz3Pm9rfowbTFOJ6Q5dVgwlVvBSnLfCuySJZXsrgf0dlw8wXU+8rLYJ94FaLy+Es/icxvOnXLaI2tcqAtCBptQOscCUmDsOBFlPMPg5PAIdoAQZPZLbNPQbGURsOyu5lB9q6aNSI0n8HRUQdLJ+W3e2JAeF+zjTDsg4VGwl9p5Gf3lYD0Mcg0i44cAtsvJ/bSBYzLBIWhbK4wXJS53B/XOAQn+4WHEek5I0GchEOXzuV+Wfc/r6R3UROiUaJx3UY05zbkS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oSG8FTXX8sGPGz88eG+DjweAu58LjZqrHhM6g4o30M=;
 b=mKT9NtB4HF7VY6otWd7soaRrfdM5gGAZNS+q4Le3j/23IUnwbXAZuNZKCwW8bJ2ktsyBsvb21VsEemf6okkf0oshT4EAIoIvCckRCsdE0yRPU7wTZr2lCKowWAE6KOI6mhWHVjOHeizYpTrID8IkQ6W93vkVfjU3Y9DG7LEMwho=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.25; Fri, 18 Dec
 2020 07:45:45 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 07:45:45 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Topic: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Index: AQHW0r2T16pUmRKNaE+vcoTiMv9Y1qn4nWAAgAPfXlA=
Date:   Fri, 18 Dec 2020 07:45:44 +0000
Message-ID: <AM6PR04MB605376762692D977F497DFB4E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201215083551.6067-1-alice.guo@oss.nxp.com>
 <20201215203238.GA118912@robh.at.kernel.org>
In-Reply-To: <20201215203238.GA118912@robh.at.kernel.org>
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
x-ms-office365-filtering-correlation-id: 5611d1f8-cd78-4055-08a6-08d8a328edb3
x-ms-traffictypediagnostic: AS8PR04MB7688:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB768890E2718EA49A8B5481DCA3C30@AS8PR04MB7688.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vTLseKDseULFZigb7IVOeNyl3RTTLBuBgKWtviePD5tG+WLcSTkBYbTc8dBFmvN1U7ryuh93a/jt+0IoPX86NL4OdH6HjC1Aw0L9Sqdwis9GQqBq5k4MCeI6QbE7Dmxki7OBQPXdu0WeWEZmLSjNutudtP7plEXqMC/AyoXXTyiO4P1ojjJkFyxClDGu1cE7KQiWtUlwauEi9ceIODiMAuou7hbc0VJ+BQUB2rLrSPYCKbYkVLBpOcxuWX63Xn5ejfeN8f+l9l6qJyhb2/1hiH7Rei8u35lP2HBQO+fVoViVi7E2H5KnHvLnqR+5wQZnwNNNJOB/urWSer/GDAdqtZl/E0mIh+J9P7AJC6DPqE83pgLvStU1zjs/k9XMWmbURtKwgTx8/TNZblnKao4WfuHat2r9deBCOjqz9r4gL1Z33t7pojnQmYYDB27Vmx2b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(186003)(53546011)(55016002)(54906003)(26005)(33656002)(83380400001)(76116006)(110136005)(7696005)(8936002)(52536014)(966005)(2906002)(6506007)(5660300002)(316002)(66946007)(8676002)(9686003)(64756008)(71200400001)(66476007)(4326008)(86362001)(66556008)(66446008)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?TlhnYU9IbjMzUVI2cjNBTUMvQ08vZDNmSjY5ZE5yV2UzTlFzNTB2T2draWt6?=
 =?gb2312?B?Z1pyOHZCc1RNV28yRFliUmZNSlAvb1RCSEphQ1UyU01UNTM2b2JKYlliUm5N?=
 =?gb2312?B?ME0rOWk4VFltWjZQSzc3WkpqMVVJZlpkbnRGOVZKbVo3ZWZxQk5qdU1UcDdm?=
 =?gb2312?B?WHBZamRrdnRyQ3JPU29zd1hUS3FFUGN1eWlIMnEvWEpkQlJ6YmtSczNDRWhr?=
 =?gb2312?B?S0ZIVEVXcEYzVEh0VFhpby91R0dPSmRYMGg1aThOclJVWlZ0RGRRQmxrY29k?=
 =?gb2312?B?Qkp2aDViYjlyN2tPMlJrSXh1aHVxRExIb2hiRW9LSmI0RkF4Mkt3cEtDbEo2?=
 =?gb2312?B?VndqMW1LZGRQc1VKek9FRG5yNnZDaW5zRktNUVVJRWpiM3NDL1VpU0ZRUDFU?=
 =?gb2312?B?MUlWSmUzV1lEYmh5M3FvNGlKZThDN0VQbHdqQm1WLzBBcG9ITitMaTF0V0o3?=
 =?gb2312?B?NjE2WFEwY3J5T1F5aHFPeEFaNFRSa3V5SFRtbDRid29vUE5DU1pNelp1RVVV?=
 =?gb2312?B?cVpBZmVxVUYxbXBWSzJlWGwzaStLcUtaa3QvbElNNnpKZnZkS0tYVGxsaktm?=
 =?gb2312?B?SG5SQmxvcVg5ZG1meHJ0cWR1aVc4NXRVeW4zTDlocS82OGFRMDhkNXBXQjc5?=
 =?gb2312?B?cTJ2eVdiTkM0OUNiczZmWTYyRko3UCsvYVNnaFgwbjUrU2V1bkpWbEJWVDda?=
 =?gb2312?B?QnBLRFhHSVl1ZkI5bFNMc0V6bDkvZWR3dFNXMjdzazU4aWdMaHZ5TS9aMEVI?=
 =?gb2312?B?TmFuMHQxRnhFSmYydGxLOUJkU09jVXcvZ1pBWkV5TEFmTE5PR0xUM2VHc1Vj?=
 =?gb2312?B?ckJjeWFlM2tMaW9lYVNZc1FSU2N1TEI4WW5XQzNyZWFleE5JMW1yYjhxUHpW?=
 =?gb2312?B?M0NBRmswMjEwZVJZUzFuSXlMSWNab3Q3dmc1Sk56NFpiOFVKZjZjNkl1dlJT?=
 =?gb2312?B?b3NMd09JTzF4VWt2dGJlcjBRbVJic1BFU1FqWlVjYjN4bDV6dlVOYkJDcGZw?=
 =?gb2312?B?MDVYVWp6akpxKzhneTZacDYzaG5nelRKMUZlcUF1cDZvWHNzaFVzK29zem9n?=
 =?gb2312?B?S2MzbGQvZDNXeEIxUUVkRGZpSGNHQ29kbFRNT0lNNTl0T0d6WGFBZThCK01O?=
 =?gb2312?B?WklEUEZjb2tYZWZFNmJDUEFUMVBFVnA1dzZiK0lEU1RmbE5vanR5YldQenUv?=
 =?gb2312?B?YnhTOTAydjl5QlRGTFVKTG1zc2xFOEhzMDlORVZxZFNvaFQ4OTFaTTFkelJr?=
 =?gb2312?B?MXduR2dCcjFUWWhPMmNQenFxWWVXeTBXV0V0dmpNaXRlNmVVU2E3Zm1nTElW?=
 =?gb2312?Q?N548ybeXhADV8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5611d1f8-cd78-4055-08a6-08d8a328edb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 07:45:45.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEX/xA9aq+itVNzP6Oe4lSiUAOuaLirS1CEMBUf24x7dGhm3vns8ESs14+XnhP3yGyNZ8J54uKTQBRcz9wx9nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyMMTqMTLUwjE2yNUgNDozMw0KPiBUbzogQWxpY2Ug
R3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IENjOiBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZl
c3RldmFtQGdtYWlsLmNvbTsga3J6a0BrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDEvNF0gZHQtYmluZGluZ3M6IHNvYzogaW14OG06IGFk
ZCBEVCBCaW5kaW5nIGRvYyBmb3Igc29jDQo+IHVuaXF1ZSBJRA0KPiANCj4gT24gVHVlLCBEZWMg
MTUsIDIwMjAgYXQgMDQ6MzU6NDhQTSArMDgwMCwgQWxpY2UgR3VvIChPU1MpIHdyb3RlOg0KPiA+
IEZyb206IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4NCj4gPiBBZGQgRFQgQmlu
ZGluZyBkb2MgZm9yIHRoZSBVbmlxdWUgSUQgb2YgaS5NWCA4TSBzZXJpZXMuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+
DQo+ID4gQ2hhbmdlcyBmb3Igdjc6DQo+ID4gIC0gY2hhbmdlIHRvIGEgc2VwYXJhdGUgc2NoZW1h
IGZpbGUNCj4gPiBDaGFuZ2VzIGZvciB2NjoNCj4gPiAgLSBub25lDQo+ID4gQ2hhbmdlcyBmb3Ig
djU6DQo+ID4gIC0gY29ycmVjdCB0aGUgZXJyb3Igb2YgdXNpbmcgYWxsT2YNCj4gPiBDaGFuZ2Vz
IGZvciB2NDoNCj4gPiAgLSB1c2UgYWxsT2YgdG8gbGltaXQgbmV3IHZlcnNpb24gRFRTIGZpbGVz
IGZvciBpLk1YOE0gdG8gaW5jbHVkZQ0KPiA+ICAgICJmc2wsaW14OG0qLXNvYyIsIG52bWVtLWNl
bGxzIGFuZCBudm1lbS1jZWxscy1uYW1lcyBDaGFuZ2VzIGZvciB2MzoNCj4gPiAgLSBwdXQgaXQg
aW50byBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQo+ID4g
IC0gbW9kaWZ5IHRoZSBkZXNjcmlwdGlvbiBvZiBudm1lbS1jZWxscw0KPiA+ICAtIHVzZSAibWFr
ZSBBUkNIPWFybTY0IGR0YnNfY2hlY2siIHRvIG1ha2Ugc3VyZSBpdCBpcyByaWdodCBDaGFuZ2Vz
DQo+ID4gZm9yIHYyOg0KPiA+ICAtIHJlbW92ZSB0aGUgc3ViamVjdCBwcmVmaXggIkxGLTI1NzEt
MSINCj4gPg0KPiA+ICAuLi4vYmluZGluZ3Mvc29jL2lteC9pbXg4bS1zb2MueWFtbCAgICAgICAg
ICAgfCA1NA0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1NCBp
bnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2lteDhtLXNvYy55YW1sDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9pbXgvaW14OG0t
c29jLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14
L2lteDhtLXNvYy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAw
MDAwMDAwMDAuLmEyZjdkYzBjOWIzNQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2lteC9pbXg4bS1zb2MueWFtbA0KPiA+
IEBAIC0wLDAgKzEsNTQgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0y
LjAgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL2lteC9pbXg4bS1zb2MueWFtbCMNCj4gPiArJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4g
Kw0KPiA+ICt0aXRsZTogTlhQIGkuTVg4TSBTZXJpZXMgU29DDQo+ID4gKw0KPiA+ICttYWludGFp
bmVyczoNCj4gPiArICAtIEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gKw0KPiA+
ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIE5YUCBpLk1YOE0gc2VyaWVzIFNvQ3MgY29udGFpbiBm
dXNlIGVudHJpZXMgZnJvbSB3aGljaCBTb0MgVW5pcXVlDQo+ID4gK0lEIGNhbiBiZQ0KPiA+ICsg
IG9idGFpbmVkLg0KPiA+ICsNCj4gPiArc2VsZWN0Og0KPiA+ICsgIHByb3BlcnRpZXM6DQo+ID4g
KyAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICBjb250YWluczoNCj4gPiArICAgICAgICBlbnVt
Og0KPiA+ICsgICAgICAgICAgLSBmc2wsaW14OG1tDQo+ID4gKyAgICAgICAgICAtIGZzbCxpbXg4
bW4NCj4gPiArICAgICAgICAgIC0gZnNsLGlteDhtcA0KPiA+ICsgICAgICAgICAgLSBmc2wsaW14
OG1xDQo+ID4gKyAgcmVxdWlyZWQ6DQo+ID4gKyAgICAtIGNvbXBhdGlibGUNCj4gPiArDQo+ID4g
K3Byb3BlcnRpZXM6DQo+ID4gKyAgc29jOg0KPiA+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4gKyAg
ICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgIGl0ZW1z
Og0KPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gZnNsLGlteDht
bS1zb2MNCj4gPiArICAgICAgICAgICAgICAtIGZzbCxpbXg4bW4tc29jDQo+ID4gKyAgICAgICAg
ICAgICAgLSBmc2wsaW14OG1wLXNvYw0KPiA+ICsgICAgICAgICAgICAgIC0gZnNsLGlteDhtcS1z
b2MNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMNCj4gPiArDQo+ID4gKyAgICAg
IG52bWVtLWNlbGxzOg0KPiA+ICsgICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgICAgICAgZGVz
Y3JpcHRpb246IFBoYW5kbGUgdG8gdGhlIFNPQyBVbmlxdWUgSUQgcHJvdmlkZWQgYnkgYSBudm1l
bQ0KPiA+ICsgbm9kZQ0KPiA+ICsNCj4gPiArICAgICAgbnZtZW0tY2VsbHMtbmFtZXM6DQo+ID4g
KyAgICAgICAgY29uc3Q6IHNvY191bmlxdWVfaWQNCj4gPiArDQo+ID4gKyAgICByZXF1aXJlZDoN
Cj4gPiArICAgICAgLSBjb21wYXRpYmxlDQo+ID4gKyAgICAgIC0gbnZtZW0tY2VsbHMNCj4gPiAr
ICAgICAgLSBudm1lbS1jZWxsLW5hbWVzDQo+IA0KPiBBbnl0aGluZyBlbHNlIHNob3VsZCBiZSBh
IG5vZGUsIHNvOg0KPiANCj4gICAgICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOg0KPiAgICAgICAg
ICB0eXBlOiBvYmplY3QNCg0KSGksIFJvYg0KVGhhbmsgeW91IGZvciB5b3VyIGFkdmljZS4gV2hl
biBJIGFkZCAiYWRkaXRpb25hbFByb3BlcnRpZXM6IHR5cGU6IG9iamVjdCIsDQp1c2UgbWFrZSBB
UkNIPWFybTY0IGR0YnNfY2hlY2sgRFRfU0NIRU1BX0ZJTEVTPURvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb2MvaW14L2lteDhtLXNvYy55YW1sLCBhbmQgdGhlbjoNCmxpbnV4LW5l
eHQvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWJlYWNvbi1raXQuZHQueWFt
bDogLzogI3NpemUtY2VsbHM6IFtbMl1dIGlzIG5vdCBvZiB0eXBlICdvYmplY3QnDQogICAgICAg
IEZyb20gc2NoZW1hOiAvaG9tZS9ueGY1NTEwNC92aXJ0dWFsaXphdGlvbi91cHN0cmVhbS9saW51
eC1uZXh0L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2lteDhtLXNv
Yy55YW1sDQouLi4NCnNvIEkgdGhpbmsgSSBzaG91bGQgcmVtYWluIGl0IHVuY2hhbmdlZCBpbiB2
OC4NCkFsaWNlDQoNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQo+ID4g
Ky4uLg0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
