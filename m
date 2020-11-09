Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4A2AB79A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgKILzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:55:54 -0500
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:5166
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbgKILzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:55:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk7G36qyHIWq9eIIhuEYnkuympz0vJIrLUiQQtNGKDmoobeaRfj5h1FWaTpZ6WfHABeOfDzfwIyngruptpBeCZ9dzB+lRhPtqIrMwnXhXTGI+TA+XWfqyCTBvP2LeS5X5t0+62R+6C+5Hdd5H8xaNAU9hjvTsisOop1IM5c3819ZWMTv2FS8TT3N9absgh7Mrp4ZUfH/UiSgCJiEA+GiPTcsY+hUITxOVJHlxmPlv2fqV5ApQkqQLjp8jo+ICITExDC2F6ZxMXSdubhUBwD9pooEq4ZrMTePTVKNpIMiaHWeTGK31BHfKt3Pr4FWzMpl0XuiSg5nNTyjNrSeWY5DAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwPE1C/UhAh5YJ9uAsYR30pi78hd+2TWYbfAfEXIB3M=;
 b=azGgTBuwpIhpzvIes5tQTuGnFuMW2Q1P7rWzjivZDysCjHC0vqNxtUPzmmKsE2l38/ql11dzpVbxLz1F9VfHYiW3Dd4mqyyOb9qFxNM1dqq27s91wVDYsc8F09wDWNCGhSciKKo2ODuI3J4sGO/A8LaH7w8LyIGFarxGavjwBOF1E7gDa9q6S0T/+cdmTsCm//siBLZCCUYY+fw+50yQhd1dX9HwAC37beuOpONjWRi+SwoSP1AYLmeyiarHhcItGaMM840/hu0X4QgMx0eIQsmqdNvSFmCvgLKcf/BdjsbNmQW2Y+BTHHNhqbDNNW/1LhAcjifdyKH4mCu2tO4xng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwPE1C/UhAh5YJ9uAsYR30pi78hd+2TWYbfAfEXIB3M=;
 b=VWkiw8t1Kp8NbNvw01QtVpOEsgTMIKLNR4dPc5rKsQyuARDObgiMzwpOUwrYoWuJQFMkOMWg6Vn5v2gJI0sajievI3flWef1fMl8IcoTeSXallioglaOb7u76a6sGZrQGIsxBCcEVcqsY3dxguKpQAWWNhaShm8Y/r6rlYcXzvs=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB7015.eurprd04.prod.outlook.com (2603:10a6:20b:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 11:55:46 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 11:55:46 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH RESEND] driver core: export device_is_bound() to fix build
 failure
Thread-Topic: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Thread-Index: AQHWtVhC0iFw3JVhoky1GSU0i1GD9am95iCAgAGxewCAAAY6gIAAATqAgAAQwoCAAAN9YA==
Date:   Mon, 9 Nov 2020 11:55:46 +0000
Message-ID: <AM6PR04MB4966F12B67C4104247E0E6A180EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
 <20201108082317.GA40741@kroah.com>
 <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com>
 <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109114125.GC1769924@kroah.com>
In-Reply-To: <20201109114125.GC1769924@kroah.com>
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
x-ms-office365-filtering-correlation-id: 327bef69-034c-445a-150e-08d884a664ef
x-ms-traffictypediagnostic: AM7PR04MB7015:
x-microsoft-antispam-prvs: <AM7PR04MB70150C89F632640BBE8D7B8780EA0@AM7PR04MB7015.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xFztqyTKYGTIR16qGdcGByz4sjJ0koWgWP/l6yVg0m0s3K/4dC5owXyCdrsQ5XKfOV13OmUmwTK5uKZSH+V5kj67LvpAFqjUWlWnGl+3lc1mzyY62mZAJ/sbwj+IZQKca//cZ8+MguFgST7E9nqbM8GaRiE21/RHjrnADe7r+E8KrqHzfhUXQpB//ItUpxqnPA6G42+cy5he4Nj4tjYWINw9FzWi3CeyDiGDhsdVPRYhMBFUu8SeldAsDNz4wlL1ofHVXKY4n6NCKQX3H/1bz9ZEm6DHTaA21p+lfb9E6YwxYgno0ckYbgNq5pwyrzPP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(86362001)(316002)(478600001)(66946007)(44832011)(83380400001)(33656002)(76116006)(66476007)(8676002)(64756008)(66556008)(66446008)(6916009)(7696005)(6506007)(53546011)(54906003)(71200400001)(4326008)(2906002)(55016002)(8936002)(52536014)(26005)(9686003)(186003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1W1C5oIEMLtw/92Q6tRxaW8CXn+pEdYZepLY01AA97h0AvbvU9Q3sFmaWpkWJqKnCb5wa6rz+EIeyF+o263gAJVZfdrosVj3bgvrl3W2H1UxO0AjnMFqyLsp1SD/nPe2ArHTjfAFmqgU5nQhfGjyNoVpUnZjvMk/324+Vt4z00s+Hs4Ey4VeqbwCfwV4uzkCs3SH7MEI2NFvNfVhXI+0L3Kw36/keBWGLM+T7R5O+u+scEYJI0E6wA2ryj8tgsSAkrm0/1zWsvVi7XTXVlbY+sKqHtMFbz+YV768ZmN0Jv44PiHVg5WDcBEvrnAjya+dKbqxWHdfkDl4NG6QfGAw9TBhe0o9uTknqRotc3wJPA9J/ittuJV4feV8sMHwztQrWYem0HnEZ/eGDTGAtgkjprkaJPqOkP3enoDt3qQJY/1HlXLQEe2DvpP7npLb4xs4bfr5MDOmPHJKtiDs4TExpRA46Taw2k+iPS37zlbNUQWsXK8HMXoJKulkk0FKwQQAirepcYcvmv3/egVYuO9AfmTAGGJyKltKyLE+YFCc+wCgGBV3wlJFn2HVrnurRE9slWZuBkwfJpdu7YNr6K3CITd82pigPTBAydK+v/ZGD451R8YfJnJJAJ7W6R91EZj5Y+EDCDgqkZjoihnjBtSOnQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327bef69-034c-445a-150e-08d884a664ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 11:55:46.5023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXJ/aw0IFTfVjH8fxIM7FvRwXOzPKDreu/PY2aPOCC8DEowl597yP7koEmJD+asgR6D4zC0YMm/mKj2nylK/ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7015
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDksIDIwMjAgNzo0MSBQTQ0KPiANCj4gT24gTW9uLCBO
b3YgMDksIDIwMjAgYXQgMTA6NTc6MDVBTSArMDAwMCwgQWlzaGVuZyBEb25nIHdyb3RlOg0KPiA+
IEhpIEdyZWcsDQo+ID4NCj4gPiA+IEZyb206IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDksIDIwMjAg
NjozNyBQTQ0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBSRVNFTkRdIGRyaXZlciBjb3JlOiBl
eHBvcnQgZGV2aWNlX2lzX2JvdW5kKCkgdG8NCj4gPiA+IGZpeCBidWlsZCBmYWlsdXJlDQo+ID4g
Pg0KPiA+ID4gT24gTW9uLCBOb3YgMDksIDIwMjAgYXQgMTA6MTQ6NDZBTSArMDAwMCwgU3VkaXAg
TXVraGVyamVlIHdyb3RlOg0KPiA+ID4gPiBIaSBHcmVnLA0KPiA+ID4gPg0KPiA+ID4gPiBPbiBT
dW4sIE5vdiA4LCAyMDIwIGF0IDg6MjMgQU0gR3JlZyBLcm9haC1IYXJ0bWFuDQo+ID4gPiA+IDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBP
biBTYXQsIE5vdiAwNywgMjAyMCBhdCAxMDo0NzoyN1BNICswMDAwLCBTdWRpcCBNdWtoZXJqZWUg
d3JvdGU6DQo+ID4gPiA+ID4gPiBXaGVuIENPTkZJR19NWENfQ0xLX1NDVSBpcyBjb25maWd1cmVk
IGFzICdtJyB0aGUgYnVpbGQgZmFpbHMNCj4gPiA+ID4gPiA+IGFzIGl0IGlzIHVuYWJsZSB0byBm
aW5kIGRldmljZV9pc19ib3VuZCgpLiBUaGUgZXJyb3IgYmVpbmc6DQo+ID4gPiA+ID4gPiBFUlJP
UjogbW9kcG9zdDogImRldmljZV9pc19ib3VuZCIgW2RyaXZlcnMvY2xrL2lteC9jbGstaW14LXNj
dS5rb10NCj4gPiA+ID4gPiA+ICAgICAgIHVuZGVmaW5lZCENCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBFeHBvcnQgdGhlIHN5bWJvbCBzbyB0aGF0IHRoZSBtb2R1bGUgZmluZHMgaXQuDQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gRml4ZXM6IDc3ZDhmMzA2OGM2MyAoImNsazogaW14OiBzY3U6
IGFkZCB0d28gY2VsbHMgYmluZGluZw0KPiA+ID4gPiA+ID4gc3VwcG9ydCIpDQo+ID4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBTdWRpcCBNdWtoZXJqZWUgPHN1ZGlwbS5tdWtoZXJqZWVAZ21haWwu
Y29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gcmVzZW5kaW5n
IHdpdGggdGhlIEZpeGVzOiB0YWcuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIGRyaXZlcnMv
YmFzZS9kZC5jIHwgMSArDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9k
ZC5jIGIvZHJpdmVycy9iYXNlL2RkLmMgaW5kZXgNCj4gPiA+ID4gPiA+IDE0OGU4MTk2OWUwNC4u
YTc5NmE1N2U1ZWZiIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9iYXNlL2RkLmMN
Cj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvYmFzZS9kZC5jDQo+ID4gPiA+ID4gPiBAQCAtMzUz
LDYgKzM1Myw3IEBAIGJvb2wgZGV2aWNlX2lzX2JvdW5kKHN0cnVjdCBkZXZpY2UgKmRldikgIHsN
Cj4gPiA+ID4gPiA+ICAgICAgIHJldHVybiBkZXYtPnAgJiYNCj4gPiA+ID4gPiA+IGtsaXN0X25v
ZGVfYXR0YWNoZWQoJmRldi0+cC0+a25vZGVfZHJpdmVyKTsNCj4gPiA+ID4gPiA+ICB9DQo+ID4g
PiA+ID4gPiArRVhQT1JUX1NZTUJPTChkZXZpY2VfaXNfYm91bmQpOw0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gRVhQT1JUX1NZTUJPTF9HUEwoKSBwbGVhc2UsIGxpa2UgYWxsIHRoZSBvdGhlciBleHBv
cnRzIGluIHRoaXMgZmlsZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFsc28sIHdhaXQsIG5vLCBk
b24ndCBjYWxsIHRoaXMsIGFyZSB5b3Ugc3VyZSB5b3UgYXJlIGNhbGxpbmcgaXQNCj4gPiA+ID4g
PiBpbiBhIHJhY2UtZnJlZSB3YXk/ICBBbmQgd2hhdCBicmFuY2gvdHJlZSBpcyB0aGUgYWJvdmUg
Y29tbWl0IGluPw0KPiA+ID4gPg0KPiA+ID4gPiBJIGhhdmUgbm90IGNoZWNrZWQgZnVsbHkgYnV0
IHNpbmNlIGl0IGlzIGJlaW5nIGNhbGxlZCBmcm9tIHByb2JlKCkNCj4gPiA+ID4gSSBhc3N1bWUg
dGhlIGxvY2sgd2lsbCBiZSBoZWxkIGF0IHRoYXQgdGltZS4NCj4gPiA+DQo+ID4gPiBwcm9iZSgp
IHNob3VsZCBuZXZlciBjYWxsIHRoaXMgZnVuY3Rpb24gYXMgaXQgbWFrZXMgbm8gc2Vuc2UgYXQg
YWxsDQo+ID4gPiBhdCB0aGF0IHBvaW50IGluIHRpbWUuICBUaGUgZHJpdmVyIHNob3VsZCBiZSBm
aXhlZC4NCj4gPg0KPiA+IFdvdWxkIHlvdSBzdWdnZXN0IGlmIGFueSBvdGhlciBBUEkgd2UgY2Fu
IHVzZSB0byBhbGxvdyB0aGUgZHJpdmVyIHRvDQo+ID4ga25vdyB3aGV0aGVyIGFub3RoZXIgZGV2
aWNlIGhhcyBiZWVuIHByb2JlZD8NCj4gDQo+IFRoZXJlIGlzIG5vbmUsIHNvcnJ5LCBhcyB0aGF0
IGp1c3Qgb3BlbnMgdXAgd2F5IHRvbyBtYW55IHByb2JsZW1zLg0KPiANCj4gPiBGb3IgaW14IHNj
dSBkcml2ZXIgaW4gcXVlc3Rpb24sIGl0IGhhcyBhIHNwZWNpYWwgcmVxdWlyZW1lbnQgdGhhdCBp
dA0KPiA+IGRlcGVuZHMgb24gc2N1IHBvd2VyIGRvbWFpbiBkcml2ZXIuIEhvd2V2ZXIsIHRoZXJl
J3JlIGEgaHVnZSBudW1iZXINCj4gPiAoMjAwKykgb2YgcG93ZXIgZG9tYWlucyBmb3IgZWFjaCBk
ZXZpY2UgY2xvY2ssIHdlIGNhbid0IGRlZmluZSB0aGVtIGFsbCBpbiBEVA0KPiBmb3IgYSBzaW5n
bGUgY2xvY2sgY29udHJvbGxlciBub2RlLg0KPiA+DQo+ID4gVGhhdCdzIHdoeSB3ZSB3YW50ZWQg
dG8gdXNlIGRldmljZV9pc19ib3VuZCgpIGJlZm9yZSB0byBjaGVjayBpZiBzY3UNCj4gPiBwb3dl
ciBkb21haW4gaXMgcmVhZHkgb3Igbm90IHRvIHN1cHBvcnQgZGVmZXIgcHJvYmUuDQo+IA0KPiBV
c2UgdGhlIGRldmljZSBsaW5rIGZ1bmN0aW9uYWxpdHkgZm9yIHRoaXMgdHlwZSBvZiB0aGluZywg
dGhhdCBpcyB3aGF0IGl0IHdhcyBjcmVhdGVkDQo+IGZvci4NCj4gDQoNClRoYW5rcyBmb3IgdGhl
IHN1Z2dlc3Rpb24uIEkgd2lsbCBjaGVjayBpdCBob3cgdG8gdXNlLg0KQlRXLCBJIHdvbmRlciBp
ZiBkZXZfZHJpdmVyX3N0cmluZygpIGNvdWxkIGJlIGFuIG9wdGlvbmFsIHNvbHV0aW9uIHdoaWNo
IHNlZW1zIGEgbW9yZQ0Kc2ltcGxlIHdheT8NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+IHRoYW5r
cywNCj4gDQo+IGdyZWcgay1oDQo=
