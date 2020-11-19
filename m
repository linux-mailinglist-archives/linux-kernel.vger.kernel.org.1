Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E102B95FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgKSPUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:20:30 -0500
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:38146
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726791AbgKSPU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:20:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMZMREPsKktjDYjUhW+GmyCZr71nZitOtI+K6bJ7EaVgY0yBzLHWummOSqfDxZW/LzzujJ2JFVa8cx9EuzDkm4uzCS2ZX+VaL/ihofE5j0H7J/xYMTe0SV0KMmAEL4G+DPcX/2MAbva7gcU9JBXV3MbpX5wYgwNLBfA0JLXm9CcJRCZ3q7hhuspgWGo1DgifnTqNwkt57SvQ9dZNAF5uVMagbJH+PUFk5Lyvb9odIP4LPYUz1/2uBFXYZUkOpsWd/98VS28CpYXJLPuv/WXP0egibJzpqRHcAnzTEE0jor8M5cwQD+bRgCiaVxgBo+48buDCskI6DYHeaC6+aIQYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svu2vnWs8h6GTGIO6NW0U9fvFp2TThtFFw0eqIscaRk=;
 b=feeXpdZmPyD13vp533SBEKLPn5twuab86/eda1e3iSKROWGn44FSVnIeuGEERjl2mJT8fm74EkacbkYyaclJt9flRDzVq5VkFy0r4Xsb7HLkOLtMg+viOEVW/7ynPDxv0Jw3VQMSIaMinXO1f9hI4eKGxb3RGMcynb7Ea2ICaijy0y9beNsoJKOJmbMgio0GEkjuxatZTucxjtn/IX/s6jthKQcMo50nd+cebm9KunVBVC4YYlBGcOoYPGh5QB2YpNcn2ehDiF4wff2+DBM21i52qh4HOW3VGOReWrtWk1Ng3vpSc+p/EEGLV8E9dhPPb6qFwhfQBKK7hj/mpUHaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svu2vnWs8h6GTGIO6NW0U9fvFp2TThtFFw0eqIscaRk=;
 b=kFbmx64m5xaWV3z5VMx/fl+MDNRCpn/x6YSSxt6ZxjbCfBLHdzL2fUduDInU1BE1bQenYCIyYlMTRvEaxOOtq4DsAorfgpqGCFWsIfoy7Kwst9otE5auXpAshnhIWuWs4vI14a0U1oczHQ3h6O0S00hQUUVI+wF+SCZG/ImqnEU=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3559.eurprd04.prod.outlook.com (2603:10a6:209:12::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 15:20:25 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Thu, 19 Nov 2020
 15:20:25 +0000
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
Thread-Index: AQHWtVhC0iFw3JVhoky1GSU0i1GD9am95iCAgAGxewCAAAY6gIAAATqAgAAQwoCAAAN9YIAAAygAgAAB+uCAAAn8gIAN9OMwgAAN4wCAAEY+sIAAfGwAgABC/JCAALUbgIAACZgwgAALeACAAAcn0A==
Date:   Thu, 19 Nov 2020 15:20:25 +0000
Message-ID: <AM6PR04MB4966EFA169A7C29456ACD44680E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201109120512.GB1832201@kroah.com>
 <AM6PR04MB49668F60F74B73931C2ABBFD80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109124801.GA1890488@kroah.com>
 <AM6PR04MB4966375933A2644C8A52119D80E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <X7T7TgGGgxx9j2Rl@kroah.com>
 <AM6PR04MB4966360584616AEEFFB9A4A780E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <CAGETcx-zaHa8DXocLsZ==MAZNCtGvuLcvDMLnjHGfd-KOoK+0A@mail.gmail.com>
 <AM6PR04MB4966237C99CCABD85638B22B80E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <X7Zut1JGd+9yET2W@kroah.com>
 <AM6PR04MB49662EB50652F3BC6FE67C9980E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <X7aAYlgx0ZvUELlX@kroah.com>
In-Reply-To: <X7aAYlgx0ZvUELlX@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [180.171.84.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86231446-437c-4289-bc5f-08d88c9ea3f4
x-ms-traffictypediagnostic: AM6PR0402MB3559:
x-microsoft-antispam-prvs: <AM6PR0402MB35596D7EDE83E2A5D6CC2CB680E00@AM6PR0402MB3559.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Qkq2hYSG1iIi8yPHPnKRhawJ93GZ3UrZkjk3YkDhSA8Gi0wPX1U/UMmoiMOCqALOroZW0AK+HLd6q/AvQXMB5+0HIEKo+/po3dl4X+4fXekQCf7BNu2dIukM2QEm8+ww/c3GfkkxH2VxWSME9nlmYFnx/wpxjoyyBpK5IEg1Ai8xvVuiRXcvNwDwBDjjejW4JGb33pAFcjMQJXPCRNrv7Vo92dMjoToS277CI4WB8QsxZHp46suGopeivouKJ4buOrUXljDD5TXpLEBXFCsMjRB+fvj0XjtCnt7vF2pWDpNResI/Efl65+jEcZnZwgwqMp2cU0GgAt0R6m4ahMpP13SPg68kntU6SOfdfkXmGuxhhZ/ZBoEoi/sW+GhAi5VbMKKLJdnuTwOb85e9HnnUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(66476007)(66446008)(44832011)(86362001)(64756008)(966005)(66556008)(52536014)(66946007)(9686003)(55016002)(2906002)(6916009)(8936002)(71200400001)(478600001)(7696005)(6506007)(4326008)(76116006)(26005)(5660300002)(8676002)(316002)(83380400001)(54906003)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cAnqrqU+9hivm56u4gnJ5OHxK2ZbdBgT73amWQky20NfZVyKwv+r2QvLI4PEQPGqHUkr/Dy4usesKyT2Lj3vdvBfYzo8DZ0RbbS3IpGgF0gOiXPeEA0w7E9fiSYIojUoxCHsthP/2aNpOJ5/F/furVNQ6lfC72e0ByB1D9nn1Lzz2nlm24p0qrNNXPF8qlPMJQOnEsptxNgOwKkpr6m4UQhy9UXrC8LIQkZqZGh8p5I7XSiBaEXfirX+Qq2otshZxtZ2Sg0ci3YVOmAqmGvSKeJEZt8S/xXll/Q2sbCMcyyy0CAk8OabyxhKgPzyNy+tOOE4+i+T3vOeWoYPFwIWyC9n3KGHugCdGiu17VLWERYlALwmksm/9X4QkQ7ptCW00yN+SRma6sBoZGgAJs1zRk6Gm/w5fxZXg0qTg25QiriwTVhy2Fy3Ad5x7ocVsNJLRMHRps+rHKmlPIV8tm6NDxLJhyCIfKQe2WSmih9J7jBkjvloM8qwxyA0rm2H0QBs2ZHRzrNrKzNhoTMBpZE3L31utZXkjdJBc6mD93MkW7zJGY1esGHiG8EAmdyU1bFUCfeHhZjkorxjRzp7hJoED0HZgeQNfo/xgWlvanbnvuY7IT3nQfZryqnBccDlgGXahddsJPjdwB0WPwsAWGf6EA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86231446-437c-4289-bc5f-08d88c9ea3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 15:20:25.5692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJVFo70KXIaileCz1Ye8k9cRl0wSmywNaZsYGsem/5zfhoHReFAR755zM2xgebtMsZxzMwpzth9BrP1CXZ9HwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3559
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTksIDIwMjAgMTA6MjYgUE0NCj4gDQo+IE9uIFRo
dSwgTm92IDE5LCAyMDIwIGF0IDAyOjA5OjQyUE0gKzAwMDAsIEFpc2hlbmcgRG9uZyB3cm90ZToN
Cj4gPiA+IEZyb206IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTksIDIwMjAgOToxMCBQTQ0KPiA+
ID4NCj4gPiA+IE9uIFRodSwgTm92IDE5LCAyMDIwIGF0IDA0OjEzOjM0QU0gKzAwMDAsIEFpc2hl
bmcgRG9uZyB3cm90ZToNCj4gPiA+ID4gPiBMb25nIHN0b3J5IHNob3J0LCBlaXRoZXINCj4gPiA+
ID4gPg0KPiA+ID4gPiA+ICogRG9uJ3QgY2FyZSBhYm91dCB0aGUgcG93ZXIgZG9tYWluIGluIHlv
dXIgY2xvY2sgZHJpdmVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT3IsDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiAqIExpc3QgdGhlIHBvd2VyIGRvbWFpbiBpbiB0aGUgY2xvY2sgY29udHJvbGxlcidz
IERUIG5vZGUgYW5kDQo+ID4gPiA+ID4gdGhlbiB1c2UgdGhlIG5vcm1hbCBBUElzIHRvIGdldCB0
aGUgcG93ZXIgZG9tYWluLiBBbmQgZGVmZXIgbGlrZQ0KPiA+ID4gPiA+IGFueSBvdGhlciBkcml2
ZXIgaWYgeW91IGNhbid0IGdldCB0aGUgcG93ZXIgZG9tYWluLg0KPiA+ID4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IFllcywgSSB1bmRlcnN0YW5kIHRob3NlIGFyZSBmb3Igbm9ybWFsIGNhc2VzLiBC
dXQgb3VyIGNhc2UgaXMgYQ0KPiA+ID4gPiBiaXQgZGlmZmVyZW50IGFuZCB3ZSBkb24ndCB3YW50
DQo+ID4gPiA+IGlteF9jbGtfc2N1KCkgQVBJIHJldHVybiBQUk9CRV9ERUZFUiB3aGljaCBpcyB1
bm5lY2Vzc2FyeSBmb3IgYQ0KPiA+ID4gPiBodW5kcmVkIG9mDQo+ID4gPiBjbG9ja3MuDQo+ID4g
PiA+IEV2ZW4gd2Ugd2FudCB0byBkZWZlciBwcm9iZSwgd2UgcHJlZmVyIHRvIGRlZmVyIGluDQo+
ID4gPiA+IGlteF9jbGtfc2N1X2luaXQoKSByYXRoZXINCj4gPiA+IHRoYW4gaW4gaW14X2Nsa19z
Y3UoKS4NCj4gPiA+DQo+ID4gPiBXaGF0IGlzIHdyb25nIHdpdGggUFJPQkVfREVGRVIsIHRoYXQg
aXMgd2hhdCBpdCBpcyB0aGVyZSBmb3IuDQo+ID4NCj4gPiBZZXMsIHdlIGNhbiB1c2UgUFJPQkVf
REVGRVIsIGp1c3Qgbm90IHdhbnQgdG8gZGVmZXIgaW4NCj4gPiBpbXhfY2xrX3NjdV9pbml0KCkg
d2hlbiBjcmVhdGluZyBzdWIgY2xvY2sgZGV2aWNlcy4gSW5zdGVhZCwgd2Ugd2FudA0KPiA+IHRv
IGRlZmVyIGF0IHRoZSBiZWdpbm5pbmcgb2YgY2xvY2sgZHJpdmVyIHByb2JlIHdoaWNoIGNhbiBz
YXZlIHRlbnMgb2YgZGVmZXINCj4gcHJvYmVzIGR1ZSB0byB0aGUgc2FtZSByZWFzb25zIHRoYXQg
UEQgZHJpdmVyIGlzIG5vdCByZWFkeS4NCj4gDQo+IFRoZXJlJ3Mgbm90aGluZyB3cm9uZyB3aXRo
IGRlZmVycmluZyB0aGF0IG1hbnkgdGltZXMgdW50aWwgeW91ciBwcm9wZXIgZHJpdmVyIGlzDQo+
IGxvYWRlZCwgd2hhdCBkb2VzIGl0IGNvc3QgeW91IHRvIGRvIHNvPw0KDQpPbmUgcHJvYmxlbSBp
cyB0aGF0IGN1cnJlbnQgaW14OHF4cC1jbGsgZHJpdmVyIGFsbG93cyBzdWIgY2xvY2tzIHJlZ2lz
dGVyIG9wdGlvbmFsbHkgZmFpbC4NClRoYXQncyBhbHNvIHRoZSByZWFzb24gd2UgZG9uJ3Qgd2Fu
dCBkZWZlciBwcm9iZSBkdXJpbmcgcmVnaXN0ZXIgc3ViIGNsb2Nrcy4NCg0Kc3RhdGljIGludCBp
bXg4cXhwX2Nsa19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0Kew0KCWNsa3Nb
SU1YX0xTSU9fUFdNMF9DTEtdCQk9IGlteF9jbGtfc2N1KCJwd20wX2NsayIsIElNWF9TQ19SX1BX
TV8wLCBJTVhfU0NfUE1fQ0xLX1BFUiwgY2xrX2NlbGxzKTsNCgljbGtzW0lNWF9MU0lPX1BXTTFf
Q0xLXQkJPSBpbXhfY2xrX3NjdSgicHdtMV9jbGsiLCBJTVhfU0NfUl9QV01fMSwgSU1YX1NDX1BN
X0NMS19QRVIsIGNsa19jZWxscykNCgkuLi4uDQoJcmV0dXJuIG9mX2Nsa19hZGRfaHdfcHJvdmlk
ZXIoY2NtX25vZGUsIGlteF9zY3Vfb2ZfY2xrX3NyY19nZXQsIGlteF9zY3VfY2xrcyk7DQp9DQoN
Cj4gDQo+ID4gPiA+IE1heWJlIHRoZSB0aGluZ3MgY2FuIGJlIHNpbXBsaWZpZWQgYXMgYSBzaW1w
bGUgcmVxdWlyZW1lbnQ6DQo+ID4gPiA+IEhvdyB1c2VycyBjYW4gbWFrZSBEcml2ZXIgQSAoQ0xL
KSB0byBiZSBwcm9iZWQgYWZ0ZXIgRHJpdmVyIEIgKFBEKQ0KPiA+ID4gPiB3aXRob3V0IGV4cGxp
Y2l0IGZpcm13YXJlIGZ1bmN0aW9uIGRlcGVuZGVuY3kgZGVzY3JpcHRpb24gKGUuZy4NCj4gPiA+
ID4gcGhhbmRsZSBpbg0KPiA+ID4gRFQpPw0KPiA+ID4gPg0KPiA+ID4gPiBBcyBrZXJuZWwgY29y
ZSBkb2VzIG5vdCB3YW50IHRvIHN1cHBvcnQgaXQsIHRoZW4gdGhlIGxlZnQgd2F5IG1heQ0KPiA+
ID4gPiBiZSBjaGFuZ2Ugc2N1LXBkIGRyaXZlciBJbmljYWxsIGxldmVsIG9yIHByb3ZpZGUgYSBw
cml2YXRlDQo+ID4gPiA+IGNhbGxiYWNrIHRvIHF1ZXJ5IHRoZQ0KPiA+ID4gcmVhZGluZXNzLg0K
PiA+ID4NCj4gPiA+IE5vLCBkbyBub3QgbWVzcyB3aXRoIHRoYXQsIGFzIGl0IHRvdGFsbHkgYnJl
YWtzIHdoZW4gdGhpbmdzIGFyZSBidWlsdCBhcyBhDQo+IG1vZHVsZS4NCj4gPiA+DQo+ID4NCj4g
PiBDYW4ndCB0aGlzIGJlIGFkZHJlc3NlZCBieSBwcm9wZXIgbW9kdWxlIGRlcGVuZGVuY3k/IEUu
ZyBjbG9jayBtb2R1bGUNCj4gPiBkZXBlbmRzIG9uIHBvd2VyIGRvbWFpbiBtb2R1bGUuIFRoZW4g
Y2xvY2sgZHJpdmVyIGNhbiBvbmx5IGJlIGxvYWRlZCBhZnRlcg0KPiBwb3dlciBkb21haW4uDQo+
IA0KPiBTdXJlLCBpZiB5b3UgY2FuIGRvIHRoYXQsIG1ha2UgeW91ciBtb2R1bGVzIGxvYWQgcHJv
cGVybHkgYnkgc3ltYm9sDQo+IGRlcGVuZGVuY3kgYW5kIGFsbCBzaG91bGQgYmUgZmluZS4gIEhh
dmUgeW91IGRvbmUgdGhhdD8NCg0KU3RpbGwgbm8uIEkgcGxhbm5lZCB0byBkbyB0aGF0IGluIGFu
b3RoZXIgc2VwYXJhdGUgcGF0Y2gNClRoZSByb3VnaCBpZGVhIG1heSBiZToNCkluIFBEIGRyaXZl
ciwgZXhwb3J0IGFuIEFQSSBsaWtlOg0KQm9vbCBpbXhfc2N1X3BkX2lzX2luaXRpbGl6ZWQodm9p
ZCk7DQoNCkluIFNDVSBjbG9jayBkcml2ZXI6DQpJZiAoIWlteF9zY3VfcGRfaXNfaW5pdGlhbGl6
ZWQoKSkNCglyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCg0KQlRXIEkndmUgYWxyZWFkeSBzZW50IG91
dCBhIHBhdGNoIHRvIHJlbW92ZSB0aGUgY2FsbGluZyBvZiBkZXZpY2VfaXNfYm91bmQoKSBpbiBv
cmRlciB0byBmaXgNCnRoZSBidWlsZCBicmVhayBmaXJzdC4NCmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1jbGsvcGF0Y2gvMjAyMDExMTkxMTQzMDIuMjYyNjMtMS1h
aXNoZW5nLmRvbmdAbnhwLmNvbS8NCkl0J3Mgb2theSB0byByZW1vdmUgaXQgZmlyc3QgYXMgRFQg
cGF0Y2ggdXNpbmcgdGhpcyBjb2RlIHN0aWxsIG5vdCBtZXJnZWQgaW4gbWFpbmxpbmUuDQoNClJl
Z2FyZHMNCkFpc2hlbmcNCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
