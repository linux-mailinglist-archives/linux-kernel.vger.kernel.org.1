Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF82B943A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgKSOJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:09:48 -0500
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:65505
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbgKSOJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:09:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKKISBezTAeETEYfUBkQoaBcktePe4TNhj6BjVhm6fej5shEAEIsmTM1pALv6XUfl3hWrypFchbyJm5vCnXTUBdXTgx4TV7/ONa9EpQ+lxjObJ0K656qlk516fRpmcV1oaHtngOU+eDdYTIEIiRSc2bWGedy7kTGyBMwzb1AopbSJh6EekOj8tdZR5GMJssFA+HbSMm4YcaqRr4cJxwDwMBWIRQPrbGa6Cta+oeBb8z324vuCRVFj7vNJtCbyN4DcOYo9w4nmOPrSCl2wYgGUTqNoW3srpv+N2Frzd6CgRahG4snu6WRWPKump/+A7g5zG91n1lwpMjnu4qLueC2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MIfSTF744fxKEWdzYOH1E2UUiuvvVADARbi1k2mtQ0=;
 b=O1A1jhCXMn/4UN213KzK0hD+q6Azj9HCXwE47BBbHSSvE7Iu/F38xp6sNiUAgdePGaTcqGW2cki2C/wBLP/Es/8cCR5ZjC9SB0SLvx3Lhf0OCVx6T0rP7vjOdF8OeAe1f5dzXz5fHkp3QWbzadzl8sdSgOEpZEMXXAbaKh/xir5vfX8jr5BWLvt9UyNHY4Lnr6LlDgXtDDQIM2GKNEPpsa7Jc9cUDkPSlnf2fi+dOgr5wQDrRwEARcWEDFs1jILjwiB1BnvGgmP+Z5GFd7Au35GTCtkdqn/6mHZdRoGLBQ66xSHZJHsUgMd14qDCbPQ4MKdxZt9d7qB/KqferTIIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MIfSTF744fxKEWdzYOH1E2UUiuvvVADARbi1k2mtQ0=;
 b=psSAVBDvLPSEFkCMP/TrWvFF1TWvpCY1Fq5cRoV7iavl8jnNU4WOiYZoVGqP7ARYNwY9sfEX3DdFy04UXeNfxYBoQE2bXW930Ml3aJc1RBGuRqMZpL9/Ten8k8QOKM+AV5VmdUFFmRGbflKM1PRhtLaU50e5UfGsMXgI/nlPIq8=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7879.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 14:09:42 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Thu, 19 Nov 2020
 14:09:42 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Saravana Kannan <saravanak@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH RESEND] driver core: export device_is_bound() to fix build
 failure
Thread-Topic: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Thread-Index: AQHWtVhC0iFw3JVhoky1GSU0i1GD9am95iCAgAGxewCAAAY6gIAAATqAgAAQwoCAAAN9YIAAAygAgAAB+uCAAAn8gIAN9OMwgAAN4wCAAEY+sIAAfGwAgABC/JCAALUbgIAACZgw
Date:   Thu, 19 Nov 2020 14:09:42 +0000
Message-ID: <AM6PR04MB49662EB50652F3BC6FE67C9980E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201109114125.GC1769924@kroah.com>
 <AM6PR04MB4966F12B67C4104247E0E6A180EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109120512.GB1832201@kroah.com>
 <AM6PR04MB49668F60F74B73931C2ABBFD80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109124801.GA1890488@kroah.com>
 <AM6PR04MB4966375933A2644C8A52119D80E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <X7T7TgGGgxx9j2Rl@kroah.com>
 <AM6PR04MB4966360584616AEEFFB9A4A780E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <CAGETcx-zaHa8DXocLsZ==MAZNCtGvuLcvDMLnjHGfd-KOoK+0A@mail.gmail.com>
 <AM6PR04MB4966237C99CCABD85638B22B80E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <X7Zut1JGd+9yET2W@kroah.com>
In-Reply-To: <X7Zut1JGd+9yET2W@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e4ceaeb-0f5f-4d79-82f1-08d88c94c311
x-ms-traffictypediagnostic: AS8PR04MB7879:
x-microsoft-antispam-prvs: <AS8PR04MB7879E933A1BD6561B1F3C24D80E00@AS8PR04MB7879.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BQL4pm2qpoM5yt6N9DcZ0kbBctnIklsfrr+j8Ix5WCAdU23jgncEyxTkpfr9WM231VF8BpHC5bDuHpayacf9zve8x2AfzxoCjb8QRA4RLQb4muU3vOnAJT/YKgfF6IiRPui2jVPyHlblsA1O2APWuiWnWGlBCmIz9TzmSejuy6yeVvU+lFigJivkOlcQD3KJzD1koQmgyQG+iJoCsrH61nD6Yq5utIhqd+Y+YBu3zwPmmrEUF+6aRrNkI+9IZjVlyU6qte5QaxBqm7lH3QvENbdO4sCy3347u9n80gWVwf+QDnGs/45VsXlwY6wKmcc0hjIIWIMET+XYVoC4kFTH8M8z76+Kh1j9/ZX4jUjHmKBZSaIyALnb+raiySY3GIuI7AaGgmX5w9sfcNJ2BGN5kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(966005)(71200400001)(4326008)(33656002)(9686003)(26005)(55016002)(66946007)(76116006)(478600001)(66476007)(66446008)(64756008)(54906003)(52536014)(6916009)(8936002)(66556008)(86362001)(2906002)(186003)(8676002)(7696005)(83380400001)(6506007)(44832011)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QthU/j59vz73+dvo6LqaaxElpdPasqiqQrN5iMB+RPxFDBnUy4qqAKxOUeZyYU+JoXy8PsHCc7/RjfPKmVbLAb+O1wg/ycibY8OaJicrf/YtTUihwEOMaED5TQwgg9HH+h/tATgwEdy2Npf9OXFF5HpF/hgSkIVXdDlWK7x0WFnmK4GDt3vGa+XpviSoNxCHsnaIon9Q231RvoUZtMaKybICXFMDWl6NQzvtPdcXJaaZFnRDePceaqQiYNE2T46+2oEBbdK9dI9BTGMxNkoDczrTyeOivcc0bgPIVVQtu6SUr56bJ4Q7VTpXW8Ewb3v6ZIBGjiSXCAkovCB4+otS4mQ0eZfP/6GwQ4j3KYIAZUaD6C7PJYp4fXowX9htDNwYi3l3KdluuiptluTo1SHfBdsVaXu7aqPfBTzmo9yUGHhyVSym2mOLubG+hcQSV8UhmjIqgKTbihz/I92deXAMtytniG2R89dOKLxiNfjrkxo5qK3RUx3TSd44293sevN1LQFU3u4NmuOPyTTRo1mm0Vp5xFvYUm/NfgSaH7vW9+mC/k0mtFR18SMpYedlpxiEs0Bgc8r6qtTSxcQxF632Fs7pZDzauuBLpbE20xmAvV5EPK6vEQmVWHu3gunRp0p3wbZXF0p9Spj8yAdc8Uy4yg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4ceaeb-0f5f-4d79-82f1-08d88c94c311
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 14:09:42.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQcIGug4ucc8QUtrmNZOXdR7U9UiDQCgJXUSDZ8Bz6nu6kavEpYa82l3odkj5Mi3mgzCGXyVgjYdVz3qowmUUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7879
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTksIDIwMjAgOToxMCBQTQ0KPiANCj4gT24gVGh1
LCBOb3YgMTksIDIwMjAgYXQgMDQ6MTM6MzRBTSArMDAwMCwgQWlzaGVuZyBEb25nIHdyb3RlOg0K
PiA+ID4gTG9uZyBzdG9yeSBzaG9ydCwgZWl0aGVyDQo+ID4gPg0KPiA+ID4gKiBEb24ndCBjYXJl
IGFib3V0IHRoZSBwb3dlciBkb21haW4gaW4geW91ciBjbG9jayBkcml2ZXIuDQo+ID4gPg0KPiA+
ID4gT3IsDQo+ID4gPg0KPiA+ID4gKiBMaXN0IHRoZSBwb3dlciBkb21haW4gaW4gdGhlIGNsb2Nr
IGNvbnRyb2xsZXIncyBEVCBub2RlIGFuZCB0aGVuDQo+ID4gPiB1c2UgdGhlIG5vcm1hbCBBUElz
IHRvIGdldCB0aGUgcG93ZXIgZG9tYWluLiBBbmQgZGVmZXIgbGlrZSBhbnkNCj4gPiA+IG90aGVy
IGRyaXZlciBpZiB5b3UgY2FuJ3QgZ2V0IHRoZSBwb3dlciBkb21haW4uDQo+ID4gPg0KPiA+DQo+
ID4gWWVzLCBJIHVuZGVyc3RhbmQgdGhvc2UgYXJlIGZvciBub3JtYWwgY2FzZXMuIEJ1dCBvdXIg
Y2FzZSBpcyBhIGJpdA0KPiA+IGRpZmZlcmVudCBhbmQgd2UgZG9uJ3Qgd2FudA0KPiA+IGlteF9j
bGtfc2N1KCkgQVBJIHJldHVybiBQUk9CRV9ERUZFUiB3aGljaCBpcyB1bm5lY2Vzc2FyeSBmb3Ig
YSBodW5kcmVkIG9mDQo+IGNsb2Nrcy4NCj4gPiBFdmVuIHdlIHdhbnQgdG8gZGVmZXIgcHJvYmUs
IHdlIHByZWZlciB0byBkZWZlciBpbiBpbXhfY2xrX3NjdV9pbml0KCkgcmF0aGVyDQo+IHRoYW4g
aW4gaW14X2Nsa19zY3UoKS4NCj4gDQo+IFdoYXQgaXMgd3Jvbmcgd2l0aCBQUk9CRV9ERUZFUiwg
dGhhdCBpcyB3aGF0IGl0IGlzIHRoZXJlIGZvci4NCg0KWWVzLCB3ZSBjYW4gdXNlIFBST0JFX0RF
RkVSLCBqdXN0IG5vdCB3YW50IHRvIGRlZmVyIGluIGlteF9jbGtfc2N1X2luaXQoKSB3aGVuIGNy
ZWF0aW5nDQpzdWIgY2xvY2sgZGV2aWNlcy4gSW5zdGVhZCwgd2Ugd2FudCB0byBkZWZlciBhdCB0
aGUgYmVnaW5uaW5nIG9mIGNsb2NrIGRyaXZlciBwcm9iZSB3aGljaA0KY2FuIHNhdmUgdGVucyBv
ZiBkZWZlciBwcm9iZXMgZHVlIHRvIHRoZSBzYW1lIHJlYXNvbnMgdGhhdCBQRCBkcml2ZXIgaXMg
bm90IHJlYWR5Lg0KDQo+IA0KPiA+IE1heWJlIHRoZSB0aGluZ3MgY2FuIGJlIHNpbXBsaWZpZWQg
YXMgYSBzaW1wbGUgcmVxdWlyZW1lbnQ6DQo+ID4gSG93IHVzZXJzIGNhbiBtYWtlIERyaXZlciBB
IChDTEspIHRvIGJlIHByb2JlZCBhZnRlciBEcml2ZXIgQiAoUEQpDQo+ID4gd2l0aG91dCBleHBs
aWNpdCBmaXJtd2FyZSBmdW5jdGlvbiBkZXBlbmRlbmN5IGRlc2NyaXB0aW9uIChlLmcuIHBoYW5k
bGUgaW4NCj4gRFQpPw0KPiA+DQo+ID4gQXMga2VybmVsIGNvcmUgZG9lcyBub3Qgd2FudCB0byBz
dXBwb3J0IGl0LCB0aGVuIHRoZSBsZWZ0IHdheSBtYXkgYmUNCj4gPiBjaGFuZ2Ugc2N1LXBkIGRy
aXZlciBJbmljYWxsIGxldmVsIG9yIHByb3ZpZGUgYSBwcml2YXRlIGNhbGxiYWNrIHRvIHF1ZXJ5
IHRoZQ0KPiByZWFkaW5lc3MuDQo+IA0KPiBObywgZG8gbm90IG1lc3Mgd2l0aCB0aGF0LCBhcyBp
dCB0b3RhbGx5IGJyZWFrcyB3aGVuIHRoaW5ncyBhcmUgYnVpbHQgYXMgYSBtb2R1bGUuDQo+IA0K
DQpDYW4ndCB0aGlzIGJlIGFkZHJlc3NlZCBieSBwcm9wZXIgbW9kdWxlIGRlcGVuZGVuY3k/IEUu
ZyBjbG9jayBtb2R1bGUgZGVwZW5kcw0Kb24gcG93ZXIgZG9tYWluIG1vZHVsZS4gVGhlbiBjbG9j
ayBkcml2ZXIgY2FuIG9ubHkgYmUgbG9hZGVkIGFmdGVyIHBvd2VyIGRvbWFpbi4NCg0KPiBSZWx5
IG9uIHRoZSBkZWZlcnJlZCBwcm9iaW5nLCB0aGF0IGlzIHdoYXQgaXQgd2FzIGRlc2lnbmVkIGZv
ciwgYW5kIGl0IHNob3VsZCBub3QNCj4gdGFrZSB2ZXJ5IGxvbmcgYXQgYWxsLCBhbmQgaXQga2Vl
cHMgeW91IGZyb20gaGF2aW5nIHRvIGRpZyBpbnRvIHRoZSBkcml2ZXIgY29yZSBpbg0KPiB3YXlz
IHRoYXQgbm8gb25lIGVsc2UgaGFzIHRvLg0KPiANCj4gUGxlYXNlIGp1c3QgZml4IHVwIHlvdXIg
RFQgZmlsZSAoc29ycnkgSSBkaWRuJ3Qga25vdyBvcmRlcmluZyB3b3VsZG4ndCBzb2x2ZSB0aGlz
KSwNCj4gYW5kIHlvdSBzaG91bGQgYmUgZmluZS4NCj4gDQoNCk5ldmVyIG1pbmQgYW5kIHRoYW5r
IHlvdSBmb3IgYnJpbmdpbmcgbWUgdG8gdGhlIG5ldyBmZWF0dXJlcyBvZiBmd19kZXZsaW5rIHdo
aWNoDQpJIGJlbGlldmUgaXMgZ29vZCBhbmQgY2FuIGhlbHAgdXMgYSBsb3Qgb24gYm9vdCBvcHRp
bWl6YXRpb24gYW5kIGRyaXZlciBwcm9iZXMuDQpXZSBtYXkgZW5hYmxlIGl0IGluIHRoZSBmdXR1
cmUgYnkgZGVmYXVsdC4NCg0KRm9yIHRoZSBjdXJyZW50IHByb2JsZW0sIHRoZSBkaWZmaWN1bHR5
IGlzIGkgZG9uJ3Qga25vdyBob3cgdG8gZG8gaXQgaW4gc3RhbmRhcmQgd2F5DQphcyB3ZSBjYW4n
dCBhZGQgcG93ZXIgZG9tYWlucyBwcm9wZXJ0eSBpbiBjbG9jay1jb250cm9sbGVyIG5vZGUuDQpU
aGUgcmVhc29uIGlzIGRlc2NyaWJlZCBoZXJlIHRoYXQgY2xvY2stY29udHJvbGxlciAoU0NVIGNs
b2NrIHByb3RvY29sKSBpdHNlbGYgZG9lcyBub3QNCkRlcGVuZHMgb24gcG93ZXIgZG9tYWluLg0K
aHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMva2VybmVsL21zZzM3NDIwNTAuaHRtbA0KDQpz
Y3Ugew0KICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXgtc2N1IjsNCiAgICAgICAgLi4uDQoN
CiAgICAgICAgY2xrOiBjbG9jay1jb250cm9sbGVyIHsNCiAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gImZzbCxpbXg4cXhwLWNsayI7DQogICAgICAgICAgICAgICAgI2Nsb2NrLWNlbGxzID0g
PDI+Ow0KICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmeHRhbDMyayAmeHRhbDI0bT47DQogICAg
ICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAieHRhbF8zMktIeiIsICJ4dGFsXzI0TWh6IjsNCiAg
ICAgICAgfTsNCg0KICAgICAgICBwZDogaW14OHF4LXBkIHsNCiAgICAgICAgICAgICAgICBjb21w
YXRpYmxlID0gImZzbCxpbXg4cXhwLXNjdS1wZCIsICJmc2wsc2N1LXBkIjsNCiAgICAgICAgICAg
ICAgICAjcG93ZXItZG9tYWluLWNlbGxzID0gPDE+Ow0KICAgICAgICB9Ow0KCQkuLi4NCn0NCg0K
UmVnYXJkcw0KQWlzaGVuZw0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=
