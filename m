Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641C62B8C68
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgKSHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:32:22 -0500
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:52513
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbgKSHcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:32:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYQq/wR54AOdQueD46ArGdHOhYC5k5SLwJW2dO7OiKbB4jmIxClJ6TePHr/vl2bk7ltNbveHLpFXBcJZHxRYaGWBBsJoAS1kSVqwpyAtYD1cy4gQeE1NNziVWG4RvJNMXbZSW4woyxZn93LehndDrXaqA2xaxYNRe3hFrTf6qNLTAYWpkoLjYIKGe1p+hzsVgGkve0BPqWB2pSGRM3UndhVoRfmlsEQBYHUaNz5exVLlh9368gzE6N9zayCaEvhVS4jpBNMr0aqZXyNnGy250ffcFgpzocD0bzYqj2bFMfXGUr+OMetncQ+7tGXNngQMFg/sO6m4U+OCoSNSG/kEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8IXp7Mx5N1L/uj/XNhfswhGpyvQqdV9oxHVl2X2VG4=;
 b=ROFGx+8JXuE67n7oMF1g4HxOyEVp3X4DZOxDN/lfTKXnWFwhfPAvsIyRnKYeeEgy8l242IR84CDB+nfhP/O+OlzZ8uxIiR3pRKjxyeNI4Zo1Au6lZbKAzsYd5mdBxkPYvW07WPhMLBl99bHsaNtM7Ag8k+Ea3e/uP4WFYhIA8ZXC9RQyFoAhEFhqELnt/TswJPiXecDAPi9GtcTkri5fGEPVpsACP8vyZeL10OHy1uqkIVqb0tqGX5dy/YfNj1y1y7IvS5xXpyG98OIcqsN6l/MQ5xpuzW2W9NAytFmuuA0nB9QsMwNJAVr4YbTUFscEELquX6a/fUweYNrro7D8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8IXp7Mx5N1L/uj/XNhfswhGpyvQqdV9oxHVl2X2VG4=;
 b=IyR09kue2tF9JUO4TmRZreEvEbCtG4+neznLN9miL2idNoDDc6zAiRwqVoX8w+c+1eCeXIMYcRTqgK9dmv7yZb4Fw5vK4bstVrOs4BDY5+8KCU7T6qm3rtlDQqdgXA90CwHL6GjpOmRqVXR/0+fhrfLUniGhVE4r5pN4qan4guw=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7173.eurprd04.prod.outlook.com (2603:10a6:20b:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 07:32:17 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.029; Thu, 19 Nov 2020
 07:32:17 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 4/4] soc: imx8m: change to use platform
 driver
Thread-Topic: [EXT] Re: [PATCH v3 4/4] soc: imx8m: change to use platform
 driver
Thread-Index: AQHWuazE7cJrTeDj7UWc2lslcddiW6nH1qUAgAKJ1SCAAJMOAIACwNdQgAAHSQCAADd8YIAAArUAgAEep9A=
Date:   Thu, 19 Nov 2020 07:32:17 +0000
Message-ID: <AM6PR04MB6053E8B7B16148887482F7A4E2E00@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-4-alice.guo@nxp.com> <20201114164128.GD14989@kozik-lap>
 <AM6PR04MB6053BFD5462C9AC405962095E2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201116161338.GB25108@kozik-lap>
 <AM6PR04MB60534E7BD063455FDA2649C3E2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201118104226.GA23766@kozik-lap>
 <AM6PR04MB6053817F03F3857C68CA833CE2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201118141042.GA34654@kozik-lap>
In-Reply-To: <20201118141042.GA34654@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f37a1aeb-d4e1-4818-5a46-08d88c5d3e60
x-ms-traffictypediagnostic: AM7PR04MB7173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB7173BA9001F7D64E1ADC9CDAE2E00@AM7PR04MB7173.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRizv7cxXfbhOsoPrcSD/lXmEzz5R8YaWr4v0KnRQ3dAkP046gerAlcKhYhuG8AKJQ1yIIY+42s4QY5vB8XcuMc28TduO4Tp0RvCTQz86xhSlRTA7+WCHYmEx8P5ILTzrnSzLNnRG49g6Lcx4/k+zsMefkaUO1YK8CIsIr3K3atceQ1nvuxpYbfwDvStkYWFz6/iHB/I65cFDo8iJ7/Oq37jkmUErf+/3Sar8nMaXNXVC7yQUVr69hWvU5r//Rv5G6qz+u57jyUtUaoIR4axW2htEtFh8RvLsUCGN0ZBrTpqIfL8FKqs6TRGoJ+1sy180mGBNAKkWBvjij4K8Vyw/teUEq+jL4ps9lCOrepkdVe8JI5UhyvNK0jdSMUd4QJfrofWcBIPf6Dt0SWslWX5iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(8936002)(66556008)(8676002)(64756008)(86362001)(186003)(83380400001)(55016002)(478600001)(6506007)(71200400001)(9686003)(44832011)(5660300002)(33656002)(52536014)(26005)(66476007)(316002)(6916009)(66946007)(2906002)(66446008)(7696005)(54906003)(4326008)(76116006)(53546011)(21314003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YdnGkz1Q7LzL+5PZGTSlcYh0QO7imq2qxucEqAS/G984YJ6UZw3XCNYXKqXshByQ1vvniqst0baox8DEydpAXcfzIyV7P62BqulK4iljptTqUTZYNbZ9yAkKyjHmJaUkXniWb8ZsstKnO1aI746dD8n+T7slB8FU1VAJD6CuDwMWYTS0FrPEuRaS9n9Wyye5nujpAWDreALrVoK8qImrImbjXp3375/wt7M7jk22XX+xr+t11/zSGHoUkndWObiGcnBFkYpDQtmmIa0MgUz3q7ya5X6+IEYvvGFsjUuB9+k33zHK5AJv28jr+DsQ8STc3ucp6TsHwBGSwvCrqJVmQKzyDicAiJHwazme9bkwm1Vz9nMfnld3wLlfCbxRC48SpyiP8CF5rqE6232uZF4etiXmWxNDcfh0mkvnN7wlMj8+4+gFk1G/oHhCZjqA+2f7+fCj5c2BbgBmZj11oa5Lhha2KP/W43k/e28z7yPyIYtn9dqQ+d2I/QCZIz/f6IoaBzpd40ZWx6PjLBltk30pIG82RdtmGcAkX6sOQXe4kpKX8NpqQu9QPMkdMfdgtUSYJ1o5q0byrEh4BNQlXDSGeN/znSDnl1IpVbrXnGDgyNFH5uXvn5tgz2+DHR5U/Boz+c0fPn1Aym/QYuRiGZTLB/UBIrkqvhMA40dOVvED/wWXAAYZIV53JrP3jLNdPyAE/HNPeKA2ecmgjuQENR/9yku7rvuSj1mli8exryIN6VNFZ6mlpdg/eKK7qrgtH51Eti6Rr3Eb7cXUvAXKAkyRYv2W8KP46nOtyuezoyJYKa94oAssYwLxrjk36HJ3lX+CIKCXVk1+aTlgG1/tH3dGaB48DRG2P607W1RjRSugR9NGkrIqNG/aoS+9VnP4pilXTCAyKHX58+hlnujeNcvpgg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37a1aeb-d4e1-4818-5a46-08d88c5d3e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 07:32:17.8504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyQcf+sylyiMmaBhyrNpPQky3hAht2CREUbV2WKe6RfPn5WN6hUc9EeLvxbhVD6kuaUm6oTba5UNyD8fHKlArg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTHmnIgxOOaXpSAyMjoxMQ0K
PiBUbzogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVs
Lm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
PjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0
OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MyA0LzRdIHNvYzogaW14OG06IGNoYW5nZSB0byB1c2Ug
cGxhdGZvcm0gZHJpdmVyDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIFdlZCwg
Tm92IDE4LCAyMDIwIGF0IDAyOjA3OjQxUE0gKzAwMDAsIEFsaWNlIEd1byB3cm90ZToNCj4gPg0K
PiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogMjAyMOW5tDEx5pyI
MTjml6UgMTg6NDINCj4gPiA+IFRvOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+
ID4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsNCj4gPiA+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFU
Q0ggdjMgNC80XSBzb2M6IGlteDhtOiBjaGFuZ2UgdG8gdXNlDQo+ID4gPiBwbGF0Zm9ybSBkcml2
ZXINCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPiA+DQo+ID4gPiBPbiBXZWQs
IE5vdiAxOCwgMjAyMCBhdCAxMDoyODo0N0FNICswMDAwLCBBbGljZSBHdW8gd3JvdGU6DQo+ID4g
PiAgPg0KPiA+ID4gPiA+IElmIGl0IGlzIHByb3Blcmx5IGV4cGxhaW5lZCBhbmQgdGhlcmUgaXMg
bm8gb3RoZXIgd2F5IHRoZW4geWVzLA0KPiA+ID4gPiA+IHlvdSBjb3VsZC4gSGVyZSwgZm9yIG9s
ZCBEVEJzLCBJIHdvdWxkIHByZWZlciB0byB1c2UNCj4gPiA+ID4gPiBvZl9wbGF0Zm9ybV9kZXZp
Y2VfY3JlYXRlKCkgYW5kIGJpbmQgdG8gInNvYyIgbm9kZSAoY2hpbGQgb2Ygcm9vdCkuDQo+ID4g
PiA+ID4gVGhpcyB3YXkgeW91IHdvdWxkIGFsd2F5cyBoYXZlIGRldmljZSBhbmQgZXhhY3RseSBv
bmUgZW50cnkNCj4gPiA+ID4gPiBwb2ludCBmb3IgdGhlIHByb2JlLg0KPiA+ID4gPiA+DQo+ID4g
PiA+DQo+ID4gPiA+IHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGlteDhfc29jX2luaXRf
ZHJpdmVyID0gew0KPiA+ID4gPiAgICAgICAucHJvYmUgPSBpbXg4X3NvY19pbml0X3Byb2JlLA0K
PiA+ID4gPiAgICAgICAuZHJpdmVyID0gew0KPiA+ID4gPiAgICAgICAgICAgICAgIC5uYW1lID0g
InNvY0AwIiwNCj4gPiA+ID4gICAgICAgfSwNCj4gPiA+ID4gfTsNCj4gPiA+ID4gQ2FuIEkgdXNl
ICJzb2NAMCIgdG8gbWF0Y2ggdGhpcyBkcml2ZXI/IEl0IHdpbGwgbm90IHVzZQ0KPiA+ID4gPiBv
Zl9wbGF0Zm9ybV9kZXZpY2VfY3JlYXRlKCkuIEl0IHdpbGwgdXNlIG9mX2ZpbmRfcHJvcGVydHko
KSB0bw0KPiA+ID4gPiBkZXRlcm1pbmUgd2hldGhlciBhbmQgbnZtZW0tY2VsbHMgY2FuIGJlIHVz
ZWQuIElmIHRoZXJlIGlzIG5vDQo+ID4gPiA+IG52bWVtLWNlbGxzLA0KPiA+ID4gaXQgd2lsbCB1
c2UgdGhlIG9sZCB3YXksIHdoaWNoIHN1cHBvcnRzIG9sZCBEVEJTLiBUaGVyZSBpcyBubyBuZWVk
DQo+ID4gPiB0byBhZGQgbmV3IGNvbXBhdGlibGUuDQo+ID4gPg0KPiA+ID4gTm8sIHRoZSBzb2NA
MCBpcyBub3QgYSBwcm9wZXIgbmFtZSBmb3IgdGhlIGRyaXZlci4NCj4gPg0KPiA+IEkgaGF2ZSBu
byBnb29kIGlkZWEsIHBsZWFzZSBnaXZlIHN1Z2dlc3Rpb24uIFNob3VsZCBJIHN0aWxsIGFkZCBu
ZXcgY29tcGF0aWJsZT8NCj4gPiBTaG91bGQgSSBzdGlsbCBrZWVwIGRldmljZV9pbml0Y2FsbD8g
SWYgdXNlDQo+ID4gb2ZfcGxhdGZvcm1fZGV2aWNlX2NyZWF0ZSgpLCB3aGljaCBub2RlIHNob3Vs
ZCBJIHVzZT8NCj4gDQo+IEkgbWVudGlvbmVkIG15IGlkZWEgaW4gdGhlIGVtYWlsIGJlZm9yZSAt
IG9mX3BsYXRmb3JtX2RldmljZV9jcmVhdGUoKSB0byBiaW5kDQo+IHRvIHRoZSBzb2Mgbm9kZS4g
VGhpcyB3aWxsIGhhdmUgdG8gYmUgaW4gdGhlIGluaXRjYWxsLCB5b3UgZG9uJ3QgaGF2ZSBhIGNo
b2ljZSB0bw0KPiBhdm9pZCBpdCwgc2luY2UgdGhlcmUgd2FzIG5vIGNvbXBhdGlibGUgYmVmb3Jl
Lg0KPg0KDQoJbm9kZSA9IG9mX2ZpbmRfbm9kZV9ieV9wYXRoKCIvc29jQDAiKTsNCglpZiAoIW5v
ZGUpDQoJCXJldHVybiAtRU5PREVWOw0KDQoJcGRldiA9IG9mX3BsYXRmb3JtX2RldmljZV9jcmVh
dGUobm9kZSwgIlhYWCIsIE5VTEwpOw0KCWlmICghcGRldikNCgkJcmV0dXJuIC1FTk9ERVY7DQoN
CkNhbm5vdCB1c2Ugb2ZfcGxhdGZvcm1fZGV2aWNlX2NyZWF0ZSBiZWNhdXNlICJvZl9ub2RlX3Rl
c3RfYW5kX3NldF9mbGFnKG5wLCBPRl9QT1BVTEFURUQpIiByZXR1cm5zIHRydWUuDQpvZl9wbGF0
Zm9ybV9kZXZpY2VfY3JlYXRlIGlzIHVzZWQgdG8gY3JlYXRlIHBsYXRmb3JtIGRldmljZSwgYnV0
IHNvY0AwIGlzIGNyZWF0ZWQgYnkgY29tbW9uIGNvZGUuIEkgZG9uJ3Qga25vdyBob3cNCnRvIGJp
bmQgdG8gdGhlIHNvYyBub2RlLiBUaGUgd2F5IEkgZGlkIGluIHYzIHNlZW1zIG5vdCBiYWQsIGl0
IGNhbiB3b3JrIGNvcnJlY3RseSBhbmQgc3VwcG9ydCBvbGQgRFRCcy4gQ2FuIEkga2VlcCB0aGlz
IHdheT8NCg0KQmVzdCByZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCg0K
