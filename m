Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349A129E066
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgJ1WE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:04:56 -0400
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:47759
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbgJ1WBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqdo/apY19Idj11+WTFwvUE07yQu6y8l3c7cvH6xgPWn//Pvk5rjusiMyjbJvxcCbf5vvZIsb61mMeqX/Z6Kax6z6JcQ2YyDylPcbBH0IiBtSmA2LQT95mSSZnnUmlDAs6xBe4xU05/JGxFABEwgJSnwF420rX2yjPcd5gKb8S52E7hBe8FAfE3JKCYkhTNtMLQEJozVQvM7fLMy3Fcv5KISZBIHBMAi+NfTxDpiCxWWcvuQ8r9B001XlU3s9pRtT44x1vo2nBXM8a5uhmO8h5DXgWb6/BOoXSX6IQn5JHLmRvT+Vk5rOrfy8tuai/xaAOq+6JOeF/NrdT4y9hdrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb+XpipCnqaadX6iEykOH178TrYJObh9TA9L2ilQS5s=;
 b=PKCZWRTnA/14n6UTl0rNjT02c0KNVuFuPJOnYmcqbMAw4Gzt47wOb3HTuq+besnoFTZJfdjC4VEsvZ8hXYVjz/crr6HxsSXtoCTx2nPzx9HBW8uKMPJkoG8YD7eWVX/7qYMZxAaKmxL83B8K5f+9gI0kCFErts9TRhXnAq5ZlmN4Qm9ofoId1IKDAgSOwy03X4Qxw7xnDs5XAA1doU6fRFrQW6ToJKn78PT04MC1N/QTBszS1fx2Y4SE9ikeko/hS+5vayoeLapjHU7pXogxgVzA/mpvS8o9PTmAX2F+i0QkhMPVPDeamcvXQSyuATGtZy3zxHMpErvcL9MyCw/lDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb+XpipCnqaadX6iEykOH178TrYJObh9TA9L2ilQS5s=;
 b=p2R0G+MMOmAxfg3sUc6SXZIFFE3uSFD33nPPpcl5fD7X2PYafFzAsugO6wP1HU0DClFNkFtG35ZAe4CtawNQFVfTEF6HqdAVRwE2LuNtTB9ROMa+q91eS+2BxloSLCValXyeSFMx+wFBqLViBwLJETli7bEk31/HuqsSBfGV3nc=
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com (20.182.190.140) by
 DBAPR04MB7416.eurprd04.prod.outlook.com (20.181.181.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Wed, 28 Oct 2020 01:28:33 +0000
Received: from DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::681b:7b29:32bf:d4f]) by DBBPR04MB7930.eurprd04.prod.outlook.com
 ([fe80::681b:7b29:32bf:d4f%7]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 01:28:33 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
CC:     Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
        devicetree <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
Thread-Topic: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
Thread-Index: AQHWqiGtoXq/x0MkwUy9f67NgUFbzamnMtWAgAALGICAAPv6gIAAA9AAgAA/WgCAAX6zAIAAC+WAgAEr4gCAAChOgIAA4L5g
Date:   Wed, 28 Oct 2020 01:28:33 +0000
Message-ID: <DBBPR04MB79308492BEA811389AC289D687170@DBBPR04MB7930.eurprd04.prod.outlook.com>
References: <20201024162016.1003041-1-aford173@gmail.com>
 <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
 <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
 <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175>
 <3dadade8-6e77-e27f-d5a6-307de17a4dd0@denx.de>
 <CAHCN7xLC-gKquDNS3ToQCff=g610PscQE+T4zfO=_05GpLyK4w@mail.gmail.com>
 <20201026145516.shmb55gaeh6u7oru@fsr-ub1664-175>
 <c976125e45e2fe46afbee1735004668677383805.camel@pengutronix.de>
 <20201027093110.jaslelqecwudn22k@fsr-ub1664-175>
 <20201027115525.gxt2oqavqulsqolo@fsr-ub1664-175>
In-Reply-To: <20201027115525.gxt2oqavqulsqolo@fsr-ub1664-175>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bb76533-c087-4880-7afd-08d87ae0c921
x-ms-traffictypediagnostic: DBAPR04MB7416:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB7416B47DCD47CDBEE136A99487170@DBAPR04MB7416.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NdFUIyRmAT3VL8ZAXCkWqH4gXzdvTHZ+yBr/iLmw7YB+B/0ly69+0iDNGKHR5JfjDLoaPoJFDvLOZh6C8m/UkZfaxGD+AhcRTZJ/6noUpRhte64hWdRGXOE11ieEJEKn0p5yq9jogE4EWjeUQjyjYsCOvHgU5HezspKPyI2IcZe5zAvg9hVLgeNoJTWhz2Iad3FMrs8Qf1mo6pAf97FxoUwzCNtliqQ/ftyQ10GvDM7+gijPTvLfwbXgaHRoWeZqMDXapgHa238PSS9BRXmkPLlp2P2RyJHjyYvDcj2qXSaKFTGsoSk0W1YBilLlyzvyW74dCkCp2HupDDCMh49Ef0/2ZCIrAblJAB0PljgwGnmQQEH8P3oF5mfTr/1ITZtftVsLmM1mqtjMfHSHLhg6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7930.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(55016002)(2906002)(9686003)(478600001)(7696005)(15974865002)(5660300002)(54906003)(4326008)(966005)(53546011)(45080400002)(110136005)(52536014)(6506007)(83380400001)(66556008)(26005)(316002)(71200400001)(7416002)(76116006)(186003)(8936002)(86362001)(66946007)(8676002)(64756008)(66476007)(33656002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: aDxcnq//5VzVk7iQBmn9bXgsNdN7/Sec9yIndfQE0zQCw1cJ6NswiAFXR2Il5wnZcm5JSiOGyzv03PMnZ5KSDSC7bWwEVCr1k7tDAO+Gv4IcY2BYXX2PBqG471XABLMEJxFuo31cWf+JaQRn0O3vh/0JzBM4y72iNp+5Gv6ILPkmRfQBGjnwxK55gGkeVpAP4WgwCNkNKuN7z46Vf6MAKgeuYU5ANsmSK8nc87cZuYWw2VowMi/Al8WTPjdiCdyt2o3+/PSPWULeux8bKQ8PIJe5NixLNkb7SgBSkrSFpVQOc3rC+HEjYRCy0JRendMMCGEpyLz8pc4/UZ1rGut9VwwA0+ijkJSVNYN5a8mspU41DR5eoxtor/94mSPUYppEowEPQubNTjqehS3eL6BCF4Z5EvmyPUnhvlTegt/hLpsvI9cFYYsIfPhIeKKn0WoAmsLig90qmguoOJbMzFL/fVTB2JKrgk4ZymSm8R3FglPB9PCk0i86mOazkNICbrS0b+3Jk+JGtShCpemS2PCWFgfhl6ZVRWfuW4eHnLgW6U9T7KJ2fx4zxZU7Wc7Ru3EkjcqcYjkUAH4qrvnNhSNgJOrt/HZ31dfD8/kL9ZeKbxocx3RzGFnuqUm5vnVUpcMXf2DYp/qYGX20BwI/S1leTw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7930.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb76533-c087-4880-7afd-08d87ae0c921
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 01:28:33.7846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwDunVd6Dqc5tKU1XeRwevL/g6xjg7pLXvtbWfTEuvovulI35C6txV2I/Sx5GqFiULt2ew15f7pbKgmnrm974w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7416
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBYmVsIFZlc2EgW21haWx0bzph
YmVsLnZlc2FAbnhwLmNvbV0NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAyNywgMjAyMCA3OjU1
IFBNDQo+IFRvOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IEFk
YW0gRm9yZCA8YWZvcmQxNzNAZ21haWwuY29tPjsgTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+
Ow0KPiBkZXZpY2V0cmVlIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IFNhc2NoYSBIYXVl
cg0KPiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVu
Z3V0cm9uaXguZGU+Ow0KPiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+OyBGYWJpbyBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+Ow0KPiBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1
ZXR0ZUBiYXlsaWJyZS5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47
DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBQZW5ndXRyb25peCBLZXJuZWwg
VGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJu
ZWwub3JnPjsgbGludXgtY2xrDQo+IDxsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnPjsgYXJtLXNv
YyA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1JGQyAwLzNdIGNsazogaW14OiBJbXBsZW1lbnQgYmxrLWN0bCBkcml2ZXIgZm9yIGkuTVg4TU4N
Cj4gDQo+IE9uIDIwLTEwLTI3IDExOjMxOjEwLCBBYmVsIFZlc2Egd3JvdGU6DQo+ID4gT24gMjAt
MTAtMjYgMTY6Mzc6NTEsIEx1Y2FzIFN0YWNoIHdyb3RlOg0KPiA+ID4gQW0gTW9udGFnLCBkZW4g
MjYuMTAuMjAyMCwgMTY6NTUgKzAyMDAgc2NocmllYiBBYmVsIFZlc2E6DQo+ID4gPiA+IE9uIDIw
LTEwLTI1IDExOjA1OjMyLCBBZGFtIEZvcmQgd3JvdGU6DQo+ID4gPiA+ID4gT24gU3VuLCBPY3Qg
MjUsIDIwMjAgYXQgNzoxOSBBTSBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gd3JvdGU6
DQo+ID4gPiA+ID4gPiBPbiAxMC8yNS8yMCAxOjA1IFBNLCBBYmVsIFZlc2Egd3JvdGU6DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gWy4uLl0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4g
VG9nZXRoZXIsIGJvdGggdGhlIEdQQyBhbmQgdGhlIGNsay1ibGsgZHJpdmVyIHNob3VsZCBiZQ0K
PiA+ID4gPiA+ID4gPiA+IGFibGUgdG8gcHVsbCB0aGUgbXVsdGltZWRpYSBibG9jayBvdXQgb2Yg
cmVzZXQuDQo+ID4gPiA+ID4gPiA+ID4gQ3VycmVudGx5LCB0aGUgR1BDIGNhbiBoYW5kbGUgdGhl
IFVTQiBPVEcgYW5kIHRoZSBHUFUsIGJ1dA0KPiA+ID4gPiA+ID4gPiA+IHRoZSBMQ0RJRiBhbmQg
TUlQSSBEU0kgYXBwZWFyIHRvIGJlIGdhdGVkIGJ5IHRoZSBjbG9jaw0KPiA+ID4gPiA+ID4gPiA+
IGJsb2NrDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBNeSBvcmlnaW5hbCBwYXRj
aCBSRkMgZGlkbid0IGluY2x1ZGUgdGhlIGlteDhtbiBub2RlLA0KPiA+ID4gPiA+ID4gPiA+IGJl
Y2F1c2UgaXQgaGFuZ3MsIGJ1dCB0aGUgbm9kZSBJIGFkZGVkIGxvb2tzIGxpa2U6DQo+ID4gPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBtZWRpYV9ibGtfY3RsOiBjbG9jay1jb250cm9sbGVy
QDMyZTI4MDAwIHsNCj4gPiA+ID4gPiA+ID4gPiAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDht
bi1tZWRpYS1ibGstY3RsIiwgInN5c2NvbiI7DQo+ID4gPiA+ID4gPiA+ID4gICAgICByZWcgPSA8
MHgzMmUyODAwMCAweDEwMDA+Ow0KPiA+ID4gPiA+ID4gPiA+ICAgICAgI2Nsb2NrLWNlbGxzID0g
PDE+Ow0KPiA+ID4gPiA+ID4gPiA+ICAgICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+ID4gPiA+
ID4gPiA+IH07DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBJIHdhcyBob3Bpbmcg
eW91IG1pZ2h0IGhhdmUgc29tZSBmZWVkYmFjayBvbiB0aGUgOG1uDQo+ID4gPiA+ID4gPiA+ID4g
Y2xrLWJsayBkcml2ZXIgc2luY2UgeW91IGRpZCB0aGUgOG1wIGNsay1ibGsgZHJpdmUgYW5kDQo+
ID4gPiA+ID4gPiA+ID4gdGhleSBhcHBlYXIgdG8gYmUgdmVyeSBzaW1pbGFyLg0KPiA+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEknbGwgZG8geW91IG9uZSBiZXR0
ZXIgc3RpbGwuIEknbGwgYXBwbHkgdGhlIHBhdGNoIGluIG15DQo+ID4gPiA+ID4gPiA+IHRyZWUg
YW5kIGdpdmUgaXQgYSB0ZXN0IHRvbW9ycm93IG1vcm5pbmcuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBJIGRvIGhhdmUgc29tZSBtb3JlIHVwZGF0ZXMgb24gaG93IHRvIGdldCB0aGUgc3lzdGVtIHRv
IG5vdA0KPiA+ID4gPiA+IGhhbmcsIGFuZCB0byBlbnVtZXJhdGUgbW9yZSBjbG9ja3MuDQo+ID4g
PiA+ID4gTG9va2luZyBhdCBNYXJlaydzIHdvcmsgb24gZW5hYmxpbmcgY2xvY2tzIGluIHRoZSA4
TU0sIGhlIGFkZGVkDQo+ID4gPiA+ID4gYSBwb3dlci1kb21haW4gaW4gZGlzcG1peF9ibGtfY3Rs
IHBvaW50aW5nIHRvIHRoZSBkaXNwbWl4IGluIHRoZSBHUEMuDQo+ID4gPiA+ID4gQnkgZm9yY2lu
ZyB0aGUgR1BDIGRyaXZlciB0byB3cml0ZSAweDFmZmYgIHRvIDMyZTI4MDA0LCAweDdmIHRvDQo+
ID4gPiA+ID4gMzJlMjgwMDAgYW5kIDB4MzAwMDAgdG8gMzJlMjgwMDgsIHRoZSBpLk1YOE1NIGNh
biBicmluZyB0aGUNCj4gPiA+ID4gPiBkaXNwbGF5IGNsb2NrcyBvdXQgb2YgcmVzZXQuDQo+ID4g
PiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gWWVhaCwgdGhhdCBtYWtlcyBzZW5zZS4gQmFzaWNhbGx5
LCBpdCB3YXMgdHJ5aW5nIHRvIGRpc2FibGUgdW51c2VkDQo+ID4gPiA+IGNsb2NrcyAoc2VlIGNs
a19kaXNhYmxlX3VudXNlZCkgYnV0IGluIG9yZGVyIHRvIGRpc2FibGUgdGhlIGNsb2Nrcw0KPiA+
ID4gPiBmcm9tIHRoZSBtZWRpYSBCTEtfQ1RMICh3aGljaCBJIHRoaW5rIHNob3VsZCBiZSByZW5h
bWVkIGluIGRpc3BsYXkNCj4gPiA+ID4gQkxLX0NUTCkgdGhlIFBEIG5lZWQgdG8gYmUgb24uIFNp
bmNlIHlvdSBpbml0aWFsbHkgZGlkbid0IGdpdmUgaXQNCj4gPiA+ID4gYW55IFBELCBpdCB3YXMg
dHJ5aW5nIHRvIGJsaW5kbHkgd3JpdGUvcmVhZCB0aGUgZ2F0ZSBiaXQgYW5kIHRoZXJlZm9yZQ0K
PiBmcmVlemUuDQo+ID4gPiA+DQo+ID4gPiA+ID4gVW5mb3J0dW5hdGVseSwgdGhlIGkuTVg4TU4g
bmVlZHMgdG8gaGF2ZSAweDEwMCB3cml0dGVuIHRvIGJvdGgNCj4gPiA+ID4gPiAzMmUyODAwMCBh
bmQgMzJlMjgwMDQsIGFuZCB0aGUgdmFsdWVzIHdyaXR0ZW4gZm9yIHRoZSA4TU0gYXJlDQo+ID4g
PiA+ID4gbm90IGNvbXBhdGlibGUuDQo+ID4gPiA+ID4gQnkgZm9yY2luZyB0aGUgR1BDIHRvIHdy
aXRlIHRob3NlIHZhbHVlcywgSSBjYW4gZ2V0DQo+ID4gPiA+ID4gbGNkaWZfcGl4ZWxfY2xrIGFu
ZCB0aGUgbWlwaV9kc2lfY2xrcmVmICBhcHBlYXJpbmcgb24gdGhlIE5hbm8uDQo+ID4gPiA+DQo+
ID4gPiA+IEknbSB0cnlpbmcgdG8gbWFrZSBhIGJyYW5jaCB3aXRoIGFsbCB0aGUgcGF0Y2hlcyBm
b3IgYWxsIGkuTVg4TSBzbw0KPiA+ID4gPiBJIGNhbiBrZWVwIHRyYWNrIG9mIGl0IGFsbC4gT24g
dGhpcyBicmFuY2ggSSd2ZSBhbHNvIGFwcGxpZWQgdGhlDQo+ID4gPiA+IGZvbGxvd2luZyBwYXRj
aHNldCBmcm9tIEx1Y2FzIFN0YWNoOg0KPiA+ID4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkYNCj4gPiA+ID4NCj4gd3d3
LnNwaW5pY3MubmV0JTJGbGlzdHMlMkZhcm0ta2VybmVsJTJGbXNnODQzMDA3Lmh0bWwmYW1wO2Rh
dGE9MDQlDQo+ID4gPiA+DQo+IDdDMDElN0NwaW5nLmJhaSU0MG54cC5jb20lN0MwYzU0NjIzMjk0
MzM0YTA0YTAxMjA4ZDg3YTZmMzE2MyU3DQo+IEM2ODYNCj4gPiA+ID4NCj4gZWExZDNiYzJiNGM2
ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzM5Mzk2NTI4MjIxNTAxNCU3Qw0KPiBVbmtu
bw0KPiA+ID4gPg0KPiB3biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1TXpJaUxDSkJUaUk2SWsxaA0KPiBhDQo+ID4gPiA+DQo+IFd3aUxDSlhWQ0k2TW4wJTNE
JTdDMTAwMCZhbXA7c2RhdGE9dkZiQm45NENQc1NoVjcyck9DdGJUY3o1dTANCj4gcWg3QXUNCj4g
PiA+ID4gbzQ0U2IyJTJCaUJsckUlM0QmYW1wO3Jlc2VydmVkPTAgYnV0IEknbSBnZXR0aW5nIHRo
ZSBmb2xvd2luZw0KPiA+ID4gPiBlcnJvcnM6DQo+ID4gPiA+DQo+ID4gPiA+IFsgICAxNi42OTA4
ODVdIGlteC1wZ2MgaW14LXBnYy1kb21haW4uMzogZmFpbGVkIHRvIHBvd2VyIHVwIEFEQjQwMA0K
PiA+ID4gPiBbICAgMTYuNzE2ODM5XSBpbXgtcGdjIGlteC1wZ2MtZG9tYWluLjM6IGZhaWxlZCB0
byBwb3dlciB1cCBBREI0MDANCj4gPiA+ID4gWyAgIDE2LjczMDUwMF0gaW14LXBnYyBpbXgtcGdj
LWRvbWFpbi4zOiBmYWlsZWQgdG8gcG93ZXIgdXAgQURCNDAwDQo+ID4gPiA+DQo+ID4gPiA+IEx1
Y2FzLCBhbnkgdGhvdWdodHM/DQo+ID4gPiA+DQo+ID4gPiA+IE1heWJlIGl0J3Mgc29tZXRoaW5n
IHJlbGF0ZWQgdG8gOE1OLg0KPiA+ID4NCj4gPiA+IFRoZSBBREIgaXMgYXBwYXJlbnRseSBjbG9j
a2VkIGJ5IG9uZSBvZiB0aGUgQkxLX0NUTCBjbG9ja3MsIHNvIHRoZQ0KPiA+ID4gQURCIGhhbmRz
aGFrZSBhY2sgd2lsbCBvbmx5IHdvcmsgd2hlbiB0aGUgQkxLX0NUTCBjbG9ja3MgYXJlDQo+ID4g
PiBlbmFibGVkLiBTbyBJIGd1ZXNzIHRoZSBHUEMgZHJpdmVyIHNob3VsZCBlbmFibGUgdGhvc2Ug
Y2xvY2tzIGFuZA0KPiA+ID4gYXNzZXJ0IHRoZSByZXNldHMgYXQgdGhlIHJpZ2h0IHRpbWUgaW4g
dGhlIHBvd2VyLXVwIHNlcXVlbmNpbmcuDQo+ID4gPiBVbmZvcnR1bmF0ZWx5IHRoaXMgbWVhbnMg
d2UgY2FuJ3QgcHJvcGVybHkgcHV0IHRoZSBCTEtfQ1RMIGRyaXZlciBpbg0KPiA+ID4gdGhlIHBv
d2VyLWRvbWFpbiB3aXRob3V0IGhhdmluZyBhIGN5Y2xpYyBkZXBlbmRlbmN5IGluIHRoZSBEVC4g
SSdtDQo+ID4gPiBzdGlsbCB0aGlua2luZyBhYm91dCBob3cgdG8gc29sdmUgdGhpcyBwcm9wZXJs
eS4NCj4gPiA+DQo+ID4NCj4gPiBJIHJlbWVtYmVyIHdlIGhhZCBzb21ldGhpbmcgc2ltaWxhciBp
biBvdXIgaW50ZXJuYWwgdHJlZSB3aXRoIHRoZQ0KPiA+IGJ1c19ibGtfY2xrIG9uIDhNUCwgd2hp
Y2ggd2FzIGFkZGVkIGJ5IHRoZSBtZWRpYSBCTEtfQ1RMLiBXaGF0IEkgZGlkDQo+ID4gd2FzIHRv
IGp1c3QgZHJvcCB0aGUgcmVnaXN0cmF0aW9uIG9mIHRoYXQgY2xvY2sgZW50aXJlbHkuIE15IHJh
dGlvbmFsZQ0KPiA+IHdhcyB0aGF0IGlmIHRoZSBjbG9jayBpcyBwYXJ0IG9mIHRoZSBCTEtfQ1RM
IGJ1dCBhbHNvIG5lZWRlZCBieSB0aGUNCj4gPiBCTEtfQ1RMIHRvIHdvcmssIEkgY2FuIGxlYXZl
IGl0IGFsb25lICh0aGF0IGlzLCBlbmFibGVkIGJ5IGRlZmF1bHQpDQo+ID4gc2luY2Ugd2hlbiB0
aGUgUEQgd2lsbCBiZSBwb3dlcmVkIG9mZiB0aGUgY2xvY2sgd2lsbCBnYXRlZCB0b28uIEkNCj4g
PiBndWVzcyBhbm90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBtYXJrIGl0IGFzIGNyaXRpY2FsLCB0
aGF0IHdheSwgaXQNCj4gPiB3aWxsIG5ldmVyIGJlIGRpc2FibGVkICh3aWxsIGJlIGxlZnQgYWxv
bmUgYnkgdGhlIGNsa19kaXNhYmxlX3VudXNlZA0KPiA+IHRvbykgYnV0IGF0IHRoZSBzYW1lIHRp
bWUgd2lsbCBiZSB2aXNpYmxlIGluIHRoZSBjbG9jayBoaWVyYXJjaHkuDQo+ID4NCj4gDQo+IERv
IGlnbm9yZSBldnJ5dGhpbmcgSSBzYWlkIGFib3V0IHRoZSBidXNfYmxrX2N0bCwgdGhhdCBkaWQg
d29yayBvbiBvdXIgdHJlZQ0KPiBzaW5jZSB0aGUgd2hvbGUgUEQgcG93ZXIgb24vb2ZmICJtYWdp
YyIgaXMgZG9uZSBpbiBURi1BLg0KPiANCj4gU28gdGhlIHByb2JsZW0sIGFzIEkgdW5kZXJzdGFu
ZCBpdCBub3csIGlzIHRoZSBmYWN0IHRoYXQgdGhlIGJsa19jdGwgZHJpdmVyIHdvbid0DQo+IHBy
b2JlIGJlY2F1c2UgaXQgbmVlZHMgaXRzIFBELCBidXQgdGhlIFBEIGlzIG5vdCByZWdpc3RlcmVk
IGJlY2F1c2UgdGhlDQo+IEFEQjQwMCBjYW4ndCBwb3dlciB1cCBzaW5jZSBpdCBuZWVkcyB0aGUg
YnVzX2Jsa19jdGwgY2xvY2sgZW5hYmxlZCwgY2xvY2sNCj4gd2hpY2ggaXMgcmVnaXN0ZXJlZCBi
eSB0aGUgYmxrX2N0bC4NCg0KMS4gRm9yIHNvbWUgTUlYJ3MgQkxLX0NUTCBHUFJzLCBpdCBjYW4g
b25seSBiZSBhY2Nlc3NlZCB3aGVuIHRoZSBNSVggUEQgaXMgb24NCjIuIGZvciBzb21lIE1JWCdz
IEFEQiBoYW5kc2hha2UsIG5lZWQgdG8gY29uZmlnIHNvbWUgQkxLX0NUTCBjbG9ja19lbiBiaXQg
dG8gZW5hYmxlIHRoZSBNSVggaW50ZXJuYWwgYnVzIGNsb2NrLg0KDQpUaGF0J3Mgd2h5IEkgaGF2
ZSBjb25jZXJuIG9uIGltcGxlbWVudGluZyBzdWNoIE1JWCBHUFIgYXMgY2xvY2sgJiByZXNldCBk
cml2ZXIsIGFuZCBpbXBsZW1lbnRpbmcgR1BDIFBEIGluIGxpbnV4IGtlcm5lbC4NCkl0IHdpbGwg
aW50cm9kdWNlIHNvbWUgY2hpY2tlbi1lZ2cgaXNzdWUgdGhhdCBub3QgZWFzeSB0byBoYW5kbGUg
aW4gbGludXgga2VybmVsLg0KDQoNCkJSDQpKYWNreSBCYWkNCg0KPiANCj4gPiA+IFJlZ2FyZHMs
DQo+ID4gPiBMdWNhcw0KPiA+ID4NCg==
