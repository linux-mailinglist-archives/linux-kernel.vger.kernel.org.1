Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967772B7F17
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKROHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:07:48 -0500
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:15151
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbgKROHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:07:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB+qIlA6QmDxq9PR9ulyLvURis6lIUINmUfzJ2iDOWu/kajyCwkbKYCZjaZBJaxk5LQ69wAT4+lRUL2MS1YwrjC4LwDtxtSA/+/Hfzkt59GTuK8cZbIF7W3iSjkhS4LbDcczlzxsSYGOSb7pP/4piEKDx/wwBWqScXQfj/SUwc37NZRaYqVHetyJQqAa7kQ0oxKC6xf0X8R6mK7Jcf1AButXWYxNVr8L3v9pHrVauaVAz6LNqgWKWcrxUqvS7xDVoJXD3oVBFy9jcvgX+t7+8OrmeXM+etjBn1v4Hvpr6VnWh8H0+V39RytAqOzDkiUPuE6oS1iLDzNO3T+kKoTq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwbMAgN9+ODmMjhSNM+VnGU0TZ9IpLEoqccxTWlA7nE=;
 b=R4iMriegTE0lWSP7DmY7sdbhFHZ+AjTvYv+tPk4LRzfkwo4M4HQIkfua/Hhzrypw6Ld/VR1lxrreSfLvP3BxI+xSFbcnbbuEmOhONMlfZeNz1NjIVhXPPF5k8kfZtGlhwumyGExkyLgXQBAq+9dmCrotMLLxrdO2UJsz9zck/BIf2ir8EQmJz1atnXVerFrRrFfiMYNsK5ajIkDpuu8ezEm94TT/WZWfKYdALN7SC3oXlq0qp6XUzgiHU0jy7SQklwZXldRIa6VTZCZdSbxN53sn9bJ/qpm2mKrJ4hX1UZA2+rQ3OFtvwXEMflMN+semO55umoQ9uIY8qReURllMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwbMAgN9+ODmMjhSNM+VnGU0TZ9IpLEoqccxTWlA7nE=;
 b=mCqNsKNxI9lPfmsYl58JqOmCcDI8MB4FLwdfeQnXyD9SfPsZ2C+uVbJ2fGRBeyw/gTh3ZgwwKsTZR6eOG0q/xF+Fv3/o1d41jFHqPTlg/IynLROM8xtU0YnNuRXeKhfcxTIP4+NEFfrkeYCiK2Yo8BSHaSdEOpCVz6xc06A5BF4=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM5PR0402MB2755.eurprd04.prod.outlook.com (2603:10a6:203:98::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 14:07:41 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.029; Wed, 18 Nov 2020
 14:07:41 +0000
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
Thread-Index: AQHWuazE7cJrTeDj7UWc2lslcddiW6nH1qUAgAKJ1SCAAJMOAIACwNdQgAAHSQCAADd8YA==
Date:   Wed, 18 Nov 2020 14:07:41 +0000
Message-ID: <AM6PR04MB6053817F03F3857C68CA833CE2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-4-alice.guo@nxp.com> <20201114164128.GD14989@kozik-lap>
 <AM6PR04MB6053BFD5462C9AC405962095E2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201116161338.GB25108@kozik-lap>
 <AM6PR04MB60534E7BD063455FDA2649C3E2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201118104226.GA23766@kozik-lap>
In-Reply-To: <20201118104226.GA23766@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1072c98f-4301-41b3-1649-08d88bcb5089
x-ms-traffictypediagnostic: AM5PR0402MB2755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR0402MB2755B4D8E3277A72CF559A3BE2E10@AM5PR0402MB2755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OfOauyXeNC8wNmBngih0oQSmsKL3ovaTeKUM42TQK8M6RqRkKOY4GJFT7om9/96cW1bgT4IjSig/r8xPujLbt5H9W7o31BNowpFzADaAge+zbJRLDU0j1kPsT8gSC5TAOT4r6qwExSccOefsOlkggrNXksCkcHuUgdjHs7PCu2igFhUjCFunRHbBWZVRskNJViYnL8o1EuM26GHlPSfMZ9RIL+eodtD7bkUrAIESXJzRZdeSnCFHHQd64mtHOXZZql217pYfbM3HorAu9AVTrcGRElYL1zAXkpPhos1iv6c+dyXtZ+2CXfJx/v2xbfyBS3NfqGeHrBe83tTe/9erDAXwR1l6LibWVPrV6o6QFX+MyR97/hcPvHWJQLD6p7+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(376002)(346002)(366004)(71200400001)(6916009)(83380400001)(8936002)(86362001)(4326008)(76116006)(316002)(33656002)(52536014)(44832011)(54906003)(8676002)(64756008)(2906002)(5660300002)(66446008)(66476007)(66946007)(66556008)(478600001)(186003)(7696005)(53546011)(6506007)(9686003)(26005)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bIiq7dUvJ4ze4RlF5dmmB5X0uyGIeqOtZoLHBGF6FnM5uQAtLckPv2edi26WZ67kUoaVWv2KbiHMbLXQmSJoqm5z483Kp7noIwBKmGjNiSbm8scrBNzrt6wYYm4Xes8ELU8FLl6515Ws/3/rH/Q+gIPajzVjf+oZxNSNGS0bvIwBaBJS7pSlPa3GBesT6YbkzWuY6ejcaPtrK3gu43IeMIO4tiFZhdGAhqJTZnmjXObcAv9e6/Bk/d/X08eiNQph64DP9FEgNGAJbDXqw3xIx9JAIy+a1gb9V2Jm4lfcjwS6Yp/fDDbZtV+r73o77T5uwBaz0v2y85ZqDsiLoif6sqhHeiEatG3D4J2ZLtd8mwaIXmBi94lr58uGN3E4XrqqM72LWwBjnZ38RxeRfR+cbxJ12Sl5mcfAeDJoo4zc/jyUaByV2eY9rSHDiVOOK9NT2vfKml0AQMUK/mMpid1AcNuhLNMyxJkkDIPMag2qpLcXpB9fLNwya3HHzqMGnb579x3dDzT3A4PIPSoa2tJzAKhrTw87qghbGXX2dAkuCcytA27g3NRFctRHDzbB+saXjSApKxDF7sWUqQwYJu5cA3BA20JbptLS1A7lnFgSQEzfjWmz0iRZcKKN1JIDKD3HFzwy1vz1ti1UR617Hzn7ow4BopOwu9BXGFyiKa/b4ReEaKmjolOXjLDuLnhIRuV7P73r9BRVCFkzrY3TbEHYxsRbWumSq1Gxdsavnf/A+0usbW7O54EFIiR+2nviCsLERITUUrdSM2nP4xUdVwkaXyfRJLdt4DSzTvOUi81xjvHdXnGK9DggLf02Kc7PXJAuldrSsnkFwJgJUjq2Xl9Z7NR653NqtkVm7SRkC62qIs/Y7WiRLSUphubNUoGCpx0h/4T9TkodzmPDQ9au8H8RjA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1072c98f-4301-41b3-1649-08d88bcb5089
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 14:07:41.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQyDTkHHRjJFEeLBdr5OM1P4v29EJtcr2w2NIfk5nPGJ/al/jLf3Vt8t/LBVUq0ASABWhFzIEtmE2OuJtKNNSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2755
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTHmnIgxOOaXpSAxODo0Mg0K
PiBUbzogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVs
Lm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
PjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0
OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MyA0LzRdIHNvYzogaW14OG06IGNoYW5nZSB0byB1c2Ug
cGxhdGZvcm0NCj4gZHJpdmVyDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIFdl
ZCwgTm92IDE4LCAyMDIwIGF0IDEwOjI4OjQ3QU0gKzAwMDAsIEFsaWNlIEd1byB3cm90ZToNCj4g
ID4NCj4gPiA+IElmIGl0IGlzIHByb3Blcmx5IGV4cGxhaW5lZCBhbmQgdGhlcmUgaXMgbm8gb3Ro
ZXIgd2F5IHRoZW4geWVzLCB5b3UNCj4gPiA+IGNvdWxkLiBIZXJlLCBmb3Igb2xkIERUQnMsIEkg
d291bGQgcHJlZmVyIHRvIHVzZQ0KPiA+ID4gb2ZfcGxhdGZvcm1fZGV2aWNlX2NyZWF0ZSgpIGFu
ZCBiaW5kIHRvICJzb2MiIG5vZGUgKGNoaWxkIG9mIHJvb3QpLg0KPiA+ID4gVGhpcyB3YXkgeW91
IHdvdWxkIGFsd2F5cyBoYXZlIGRldmljZSBhbmQgZXhhY3RseSBvbmUgZW50cnkgcG9pbnQNCj4g
PiA+IGZvciB0aGUgcHJvYmUuDQo+ID4gPg0KPiA+DQo+ID4gc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kcml2ZXIgaW14OF9zb2NfaW5pdF9kcml2ZXIgPSB7DQo+ID4gICAgICAgLnByb2JlID0gaW14
OF9zb2NfaW5pdF9wcm9iZSwNCj4gPiAgICAgICAuZHJpdmVyID0gew0KPiA+ICAgICAgICAgICAg
ICAgLm5hbWUgPSAic29jQDAiLA0KPiA+ICAgICAgIH0sDQo+ID4gfTsNCj4gPiBDYW4gSSB1c2Ug
InNvY0AwIiB0byBtYXRjaCB0aGlzIGRyaXZlcj8gSXQgd2lsbCBub3QgdXNlDQo+ID4gb2ZfcGxh
dGZvcm1fZGV2aWNlX2NyZWF0ZSgpLiBJdCB3aWxsIHVzZSBvZl9maW5kX3Byb3BlcnR5KCkgdG8N
Cj4gPiBkZXRlcm1pbmUgd2hldGhlciBhbmQgbnZtZW0tY2VsbHMgY2FuIGJlIHVzZWQuIElmIHRo
ZXJlIGlzIG5vIG52bWVtLWNlbGxzLA0KPiBpdCB3aWxsIHVzZSB0aGUgb2xkIHdheSwgd2hpY2gg
c3VwcG9ydHMgb2xkIERUQlMuIFRoZXJlIGlzIG5vIG5lZWQgdG8gYWRkIG5ldw0KPiBjb21wYXRp
YmxlLg0KPiANCj4gTm8sIHRoZSBzb2NAMCBpcyBub3QgYSBwcm9wZXIgbmFtZSBmb3IgdGhlIGRy
aXZlci4NCg0KSSBoYXZlIG5vIGdvb2QgaWRlYSwgcGxlYXNlIGdpdmUgc3VnZ2VzdGlvbi4gU2hv
dWxkIEkgc3RpbGwgYWRkIG5ldyBjb21wYXRpYmxlPw0KU2hvdWxkIEkgc3RpbGwga2VlcCBkZXZp
Y2VfaW5pdGNhbGw/IElmIHVzZSBvZl9wbGF0Zm9ybV9kZXZpY2VfY3JlYXRlKCksIHdoaWNoDQpu
b2RlIHNob3VsZCBJIHVzZT8NCg0KQmVzdCByZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
