Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3E2B7B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKRKXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:23:49 -0500
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:32091
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgKRKXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:23:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khO2ATC7wRQIgEA5i44qEYF1ipFJ3IC6RKCh0vtthbFQKTB+58w76nJHp1FlaolNIow8prgtjD8pV0sth9d6tQE3x77aodtfkSeK0vkI+/yRinZzWJOdobH3eoYbwVgK12WoHwjX+1DnVArFnGa8IXFx3PKkrjE2+WJXPYnhK4TlRkzBUfO14wWYtYaO0F4q1dQwFWjky2w/WKzXdZUGc7Xbn4PIhfGvMsakEo6MpkA3NK1iSo6QbhhzBxVp+t3IN+Oa74mQKx1xm1XV1yRfcf8p1xmMxP668H/tUqlG9Z4RYlk1pMwNsmf1qvBgvttVlcUAwARfDNbBf5D8zibgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJtVO5HJGcJV/IjAJ4INc49lLtRgxktCyeGNPXZRsoc=;
 b=Uc6NlBKgSi8jlecvIgbe8AmF/TknJWd6/oQX7fBq2GsFsGNDytDiBdX6tRI+9gMEUPyOpfbMTGyz6o+K/1vH486Wllq9vcLsK2XUR5/5LxWiYq7ucjZNme+vpfKEDsYCXf0ZflRKkHbg4sTpG8Z5AJpuxilvbGsqT8ASrb07HnPN2gocPLa8eU7Y1SyeHiq29dV1T/sSGyHDVeHKZAZpOKnfWJLDenLVhmVRc8CP/eONGUFyeRPaz9rgGLusbvxxbjZxnVdVfc9JLMEz9DDrlJVKQG/T6JTVT1OBzUecCTvP0sgOJWLw/O3IEUdPJOJnV/S5IBpTg/K6z4vkbmWdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJtVO5HJGcJV/IjAJ4INc49lLtRgxktCyeGNPXZRsoc=;
 b=IYeHHA6ioynOwfqHuLQ2vqO3rdePaQclPSeIbGdjC8qSRC6oczgA6OFh6RHN/P+v1hKl+h8bpudq5YjZeXEwFLmz9+8HvGVCJDiVpsX0/LGvcubaOdQeQNhiuKP4ET+yzAkFx9ls5yWk70HQP4exgXGL244tvXJ4fMj0tfDZaB4=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5415.eurprd04.prod.outlook.com (2603:10a6:20b:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 10:23:42 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Wed, 18 Nov 2020
 10:23:42 +0000
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
Thread-Index: AQHWtVhC0iFw3JVhoky1GSU0i1GD9am95iCAgAGxewCAAAY6gIAAATqAgAAQwoCAAAN9YIAAAygAgAAB+uCAAAn8gIAN9OMw
Date:   Wed, 18 Nov 2020 10:23:42 +0000
Message-ID: <AM6PR04MB4966375933A2644C8A52119D80E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
 <20201108082317.GA40741@kroah.com>
 <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com>
 <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109114125.GC1769924@kroah.com>
 <AM6PR04MB4966F12B67C4104247E0E6A180EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109120512.GB1832201@kroah.com>
 <AM6PR04MB49668F60F74B73931C2ABBFD80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109124801.GA1890488@kroah.com>
In-Reply-To: <20201109124801.GA1890488@kroah.com>
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
x-ms-office365-filtering-correlation-id: e5442392-aff9-4728-65fa-08d88bac0624
x-ms-traffictypediagnostic: AM6PR04MB5415:
x-microsoft-antispam-prvs: <AM6PR04MB5415B3AD7C60DD517CBE217280E10@AM6PR04MB5415.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uz/8AsOY1uBg5JxJSqi7r6qJlI93dFk1k4ld/5reYKtj4ogRyvERvmlb4xe5zJnXHAqIhj3vo+FZLsm0EgI5l0+j10nQB10tJu1R8KTSNHy0zr4XKI2D7sJzu08mEj/ycoJcAl07u5NIGEvHPV5Rs37KzAqBXC/72yOf/j0e94rrHxCij3b+hU/ZNXgokyPZc/M1SeubnsYqH2ZbLFEvy3S/mf+Tcz2E8IE/FxlK34mBPganb1oMD9k7EHIpa7dsrzGnixLuTvxb8KVrpRS71IAhk2eZLcuvzPokeYFEyeCKbmcJw2D7TdY5uD5evqsg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(52536014)(71200400001)(54906003)(44832011)(8676002)(316002)(83380400001)(66446008)(5660300002)(8936002)(76116006)(66556008)(64756008)(66946007)(4326008)(66476007)(9686003)(6916009)(2906002)(53546011)(55016002)(26005)(478600001)(6506007)(86362001)(33656002)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vACuDTPokGCmy85UH8YAsHuzs4MuITlE6L5gzFoMnhQ5lj3z2rMpKvpH15G4vpExJYv8JJ/vMEOTImN5aVNG+37dS5UXCERe19HzUPNp35cpq3sLMw5WtgcHYy1gJ1fYI+eaL7Xvhlp130pyxI/2m0rCHJKIS2RYpKocXmYCdIvQINUytnag15ad1C5DC0hAbh8/3bY4HySr1okFg8xjEeuoattL9EQfdtRoqvVWxTecwWw5bhP48bg2eQfaS81DPvkVSXzoYHkGgtySQGUel7i4RDr/31++nRRzWxMyo9Gu+MKylw5CKCoNg+7ay+j0L/o/PbrGVNg+cASqH3xuahmcKNTc3z2OzaObLiH2ESQZp9jmVVxbuOT1QJTqAVZNwE5ntFWUSgA6Z81nMwFCiSS5s1zpJ4BIA/8mQDZZ6kkkr0KtCYWt3+wDK+jgRd1xOPdfgHwfw63Icy+wSQ+IBcYNjHUTePKvcSvGHVvyuxzrbG8YFU4ABNPnok+wgd1KYspMf2P+8EUw55QcYbE59VqqNz/qEToXRiWTz/TORgbdoXZtNgngZ1T2qUjbalBT8IWz9QyeSM0Ntd8lX4eVwhfRsM1/J4P1KBqgRQFq9WmheOS2CsRqg4OAZhxpYH5TPm5cB/qp+L0ggHYLAU5jqg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5442392-aff9-4728-65fa-08d88bac0624
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 10:23:42.5700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76cffegmz53ylQzAysK1a7nQpmty5ijFDrkwApCGqEGCkFqfYhfy5V2ZDbezR/7gL/E0o6O6dXxowaAMGp/spQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5415
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDksIDIwMjAgODo0OCBQTQ0KPiAN
Cj4gT24gTW9uLCBOb3YgMDksIDIwMjAgYXQgMTI6MjY6NTVQTSArMDAwMCwgQWlzaGVuZyBEb25n
IHdyb3RlOg0KPiA+ID4gRnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgOSwgMjAyMCA4OjA1IFBN
DQo+ID4gPg0KPiA+ID4gT24gTW9uLCBOb3YgMDksIDIwMjAgYXQgMTE6NTU6NDZBTSArMDAwMCwg
QWlzaGVuZyBEb25nIHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiA+ID4gU2VudDogTW9uZGF5LCBOb3Zl
bWJlciA5LCAyMDIwIDc6NDEgUE0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIE1vbiwgTm92IDA5
LCAyMDIwIGF0IDEwOjU3OjA1QU0gKzAwMDAsIEFpc2hlbmcgRG9uZyB3cm90ZToNCj4gPiA+ID4g
PiA+IEhpIEdyZWcsDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBGcm9tOiBHcmVnIEtyb2Fo
LUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+ID4gPiA+ID4gPiBTZW50
OiBNb25kYXksIE5vdmVtYmVyIDksIDIwMjAgNjozNyBQTQ0KPiA+ID4gPiA+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIFJFU0VORF0gZHJpdmVyIGNvcmU6IGV4cG9ydA0KPiA+ID4gPiA+ID4gPiBk
ZXZpY2VfaXNfYm91bmQoKSB0byBmaXggYnVpbGQgZmFpbHVyZQ0KPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiBPbiBNb24sIE5vdiAwOSwgMjAyMCBhdCAxMDoxNDo0NkFNICswMDAwLCBTdWRp
cCBNdWtoZXJqZWUNCj4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gSGkgR3JlZywNCj4gPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IE9uIFN1biwgTm92IDgsIDIwMjAgYXQgODoyMyBBTSBH
cmVnIEtyb2FoLUhhcnRtYW4NCj4gPiA+ID4gPiA+ID4gPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IE9uIFNh
dCwgTm92IDA3LCAyMDIwIGF0IDEwOjQ3OjI3UE0gKzAwMDAsIFN1ZGlwIE11a2hlcmplZQ0KPiB3
cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gV2hlbiBDT05GSUdfTVhDX0NMS19TQ1UgaXMgY29u
ZmlndXJlZCBhcyAnbScgdGhlIGJ1aWxkDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGZhaWxzIGFzIGl0
IGlzIHVuYWJsZSB0byBmaW5kIGRldmljZV9pc19ib3VuZCgpLiBUaGUgZXJyb3IgYmVpbmc6DQo+
ID4gPiA+ID4gPiA+ID4gPiA+IEVSUk9SOiBtb2Rwb3N0OiAiZGV2aWNlX2lzX2JvdW5kIg0KPiA+
ID4gW2RyaXZlcnMvY2xrL2lteC9jbGstaW14LXNjdS5rb10NCj4gPiA+ID4gPiA+ID4gPiA+ID4g
ICAgICAgdW5kZWZpbmVkIQ0KPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4g
PiBFeHBvcnQgdGhlIHN5bWJvbCBzbyB0aGF0IHRoZSBtb2R1bGUgZmluZHMgaXQuDQo+ID4gPiA+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IEZpeGVzOiA3N2Q4ZjMwNjhjNjMgKCJj
bGs6IGlteDogc2N1OiBhZGQgdHdvIGNlbGxzDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGJpbmRpbmcN
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gc3VwcG9ydCIpDQo+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFN1ZGlwIE11a2hlcmplZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA8c3VkaXBtLm11
a2hlcmplZUBnbWFpbC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiByZXNlbmRpbmcgd2l0aCB0aGUgRml4ZXM6IHRh
Zy4NCj4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvYmFz
ZS9kZC5jIHwgMSArDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYmFzZS9kZC5jIGIvZHJpdmVycy9iYXNlL2RkLmMNCj4gPiA+ID4gPiA+
ID4gPiA+ID4gaW5kZXggMTQ4ZTgxOTY5ZTA0Li5hNzk2YTU3ZTVlZmIgMTAwNjQ0DQo+ID4gPiA+
ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvYmFzZS9kZC5jDQo+ID4gPiA+ID4gPiA+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvYmFzZS9kZC5jDQo+ID4gPiA+ID4gPiA+ID4gPiA+IEBAIC0zNTMsNiAr
MzUzLDcgQEAgYm9vbCBkZXZpY2VfaXNfYm91bmQoc3RydWN0IGRldmljZQ0KPiA+ID4gPiA+ID4g
PiA+ID4gPiAqZGV2KQ0KPiA+ID4gew0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICByZXR1cm4g
ZGV2LT5wICYmDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGtsaXN0X25vZGVfYXR0YWNoZWQoJmRldi0+
cC0+a25vZGVfZHJpdmVyKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+ID4g
PiA+ID4gK0VYUE9SVF9TWU1CT0woZGV2aWNlX2lzX2JvdW5kKTsNCj4gPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gPiBFWFBPUlRfU1lNQk9MX0dQTCgpIHBsZWFzZSwgbGlrZSBhbGwg
dGhlIG90aGVyIGV4cG9ydHMgaW4gdGhpcw0KPiBmaWxlLg0KPiA+ID4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gPiA+IEFsc28sIHdhaXQsIG5vLCBkb24ndCBjYWxsIHRoaXMsIGFyZSB5b3Ug
c3VyZSB5b3UgYXJlDQo+ID4gPiA+ID4gPiA+ID4gPiBjYWxsaW5nIGl0IGluIGEgcmFjZS1mcmVl
IHdheT8gIEFuZCB3aGF0IGJyYW5jaC90cmVlIGlzDQo+ID4gPiA+ID4gPiA+ID4gPiB0aGUgYWJv
dmUNCj4gPiA+IGNvbW1pdCBpbj8NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEkg
aGF2ZSBub3QgY2hlY2tlZCBmdWxseSBidXQgc2luY2UgaXQgaXMgYmVpbmcgY2FsbGVkIGZyb20N
Cj4gPiA+ID4gPiA+ID4gPiBwcm9iZSgpIEkgYXNzdW1lIHRoZSBsb2NrIHdpbGwgYmUgaGVsZCBh
dCB0aGF0IHRpbWUuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IHByb2JlKCkgc2hvdWxk
IG5ldmVyIGNhbGwgdGhpcyBmdW5jdGlvbiBhcyBpdCBtYWtlcyBubyBzZW5zZQ0KPiA+ID4gPiA+
ID4gPiBhdCBhbGwgYXQgdGhhdCBwb2ludCBpbiB0aW1lLiAgVGhlIGRyaXZlciBzaG91bGQgYmUg
Zml4ZWQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gV291bGQgeW91IHN1Z2dlc3QgaWYgYW55
IG90aGVyIEFQSSB3ZSBjYW4gdXNlIHRvIGFsbG93IHRoZQ0KPiA+ID4gPiA+ID4gZHJpdmVyIHRv
IGtub3cgd2hldGhlciBhbm90aGVyIGRldmljZSBoYXMgYmVlbiBwcm9iZWQ/DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBUaGVyZSBpcyBub25lLCBzb3JyeSwgYXMgdGhhdCBqdXN0IG9wZW5zIHVwIHdh
eSB0b28gbWFueSBwcm9ibGVtcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRm9yIGlteCBzY3Ug
ZHJpdmVyIGluIHF1ZXN0aW9uLCBpdCBoYXMgYSBzcGVjaWFsIHJlcXVpcmVtZW50DQo+ID4gPiA+
ID4gPiB0aGF0IGl0IGRlcGVuZHMgb24gc2N1IHBvd2VyIGRvbWFpbiBkcml2ZXIuIEhvd2V2ZXIs
IHRoZXJlJ3JlDQo+ID4gPiA+ID4gPiBhIGh1Z2UgbnVtYmVyDQo+ID4gPiA+ID4gPiAoMjAwKykg
b2YgcG93ZXIgZG9tYWlucyBmb3IgZWFjaCBkZXZpY2UgY2xvY2ssIHdlIGNhbid0IGRlZmluZQ0K
PiA+ID4gPiA+ID4gdGhlbSBhbGwgaW4gRFQNCj4gPiA+ID4gPiBmb3IgYSBzaW5nbGUgY2xvY2sg
Y29udHJvbGxlciBub2RlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoYXQncyB3aHkgd2Ug
d2FudGVkIHRvIHVzZSBkZXZpY2VfaXNfYm91bmQoKSBiZWZvcmUgdG8gY2hlY2sNCj4gPiA+ID4g
PiA+IGlmIHNjdSBwb3dlciBkb21haW4gaXMgcmVhZHkgb3Igbm90IHRvIHN1cHBvcnQgZGVmZXIg
cHJvYmUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBVc2UgdGhlIGRldmljZSBsaW5rIGZ1bmN0aW9u
YWxpdHkgZm9yIHRoaXMgdHlwZSBvZiB0aGluZywgdGhhdA0KPiA+ID4gPiA+IGlzIHdoYXQgaXQg
d2FzIGNyZWF0ZWQgZm9yLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcyBmb3Ig
dGhlIHN1Z2dlc3Rpb24uIEkgd2lsbCBjaGVjayBpdCBob3cgdG8gdXNlLg0KPiA+ID4gPiBCVFcs
IEkgd29uZGVyIGlmIGRldl9kcml2ZXJfc3RyaW5nKCkgY291bGQgYmUgYW4gb3B0aW9uYWwgc29s
dXRpb24NCj4gPiA+ID4gd2hpY2ggc2VlbXMgYSBtb3JlIHNpbXBsZSB3YXk/DQo+ID4gPg0KPiA+
ID4gQWxzbywgaG93IGRvIHlvdSByZWFsbHkga25vdyB5b3UgZXZlbiBoYXZlIGEgdmFsaWQgcG9p
bnRlciB0byB0aGF0DQo+ID4gPiBvdGhlciBkZXZpY2Ugc3RydWN0dXJlPyAgSG93IGFyZSB5b3Ug
Z2V0dGluZyBhY2Nlc3MgdG8gdGhhdD8NCj4gPiA+DQo+ID4NCj4gPiBUaGUgcm91Z2ggaWRlYSBp
cyBhcyBmb2xsb3dzLiBOb3Qgc3VyZSBpZiB0aG9zZSBBUElzIGFyZSBzYWZlIGVub3VnaA0KPiA+
IGFzIHRoZXJlJ3JlIG1hbnkgdXNlcnMgSW4ga2VybmVsLg0KPiA+DQo+ID4gcGRfbnAgPSBvZl9m
aW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiZnNsLHNjdS1wZCIpOyBwZF9kZXYgPQ0K
PiA+IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUocGRfbnApOyBpZiAoIXBkX2RldiB8fA0KPiA+ICFk
ZXZfZHJpdmVyX3N0cmluZygmcGRfZGV2LT5kZXYpIHx8DQo+ID4gICAgc3RyY21wKGRldl9kcml2
ZXJfc3RyaW5nKCZwZF9kZXYtPmRldiksICJpbXgtc2N1LXBkIikpIHsNCj4gPiAgICAgICAgIG9m
X25vZGVfcHV0KHBkX25wKTsNCj4gPiAgICAgICAgIHJldHVybiAtRVBST0JFX0RFRkVSOw0KPiA+
IH0NCj4gDQo+IEljaywgYWdhaW4sIG5vLCBkb24ndCBkbyB0aGF0LCB5b3UgY2FuIG5vdCBndWFy
YW50ZWUgIm5hbWVzIiBvZiBkZXZpY2VzDQo+IGFueXdoZXJlIGluIHRoZSBzeXN0ZW0sIHNvcnJ5
Lg0KDQpJIHRyaWVkIHRvIHVuZGVyc3RhbmQgaG93IHRvIHVzZSBkZXZsaW5rIGZvciB0aGlzIGNh
c2UgYnkgZGl2aW5nIGRlZXAgaW50byB0aGUgZGV2bGluayBjb2RlLA0KaG93ZXZlciwgaXQgbG9v
a2VkIHRvIG1lIHRoZXJlJ3JlIGEgZmV3IGxpbWl0YXRpb25zIG9uIHRoZSBjdXJyZW50IGRldmxp
bmsgdXNhZ2UuDQpXZSBjYW4ndCBjcmVhdGUgZHJpdmVyIHByZXNlbmNlIGRlcGVuZGVuY3kgbGlu
ayBpbiBjb25zdW1lcidzIHByb2JlIGZ1bmN0aW9uDQp3aGlsZSB0aGUgc3VwcGxpZXIgZHJpdmVy
IGlzIHN0aWxsIG5vdCBwcm9iZWQgb3IgZXZlbiBub3QgY3JlYXRlZCB5ZXQuDQood2UncmUgdGhl
IGxhdGVyIGNhc2UgdGhhdCBzdXBwbGllciBkZXZpY2Ugc2N1LXBkIG1heSBiZSBjcmVhdGVkIGFm
dGVyIHNjdS1jbGsgZGV2aWNlKS4NCg0KVGhlIGtlcm5lbCBkb2MgRG9jdW1lbnRhdGlvbi9kcml2
ZXItYXBpL2RldmljZV9saW5rLnJzdCBhbHNvIG1lbnRpb25lZCB0aGlzIGxpbWl0YXRpb24gYW5k
DQp0aGUgc3VnZ2VzdGVkIHNvbHV0aW9uIGlzOg0KIlRoZSBvbnVzIGlzIHRodXMgb24gdGhlIGNv
bnN1bWVyIHRvIGNoZWNrIHByZXNlbmNlIG9mIHRoZSBzdXBwbGllciBhZnRlciBhZGRpbmcgdGhl
IGxpbmssDQphbmQgZGVmZXIgcHJvYmluZyBvbiBub24tcHJlc2VuY2UuIg0KDQpUaGVuIHRoZSBx
dWVzdGlvbiBpcyAsIGJhY2sgYWdhaW4sICwgaG93IHRvIGNoZWNrIHRoZSBwcmVzZW5zZSBvZiBv
dGhlciBkZXZpY2UgZHJpdmVyIGlmIHdlIGNhbid0DQp1c2UgZGV2aWNlX2lzX2JvdW5kKCkgQVBJ
IGluIG1vZHVsZT8NCg0KVGhlIGRldl9kcml2ZXJfc3RyaW5nKCkgc2VlbXMgYmUgYSBxdWljayBh
bmQgZGlydHkgc29sdXRpb24gZm9yIHRoZSB0aGlzIGJ1aWxkIGJyZWFrIGlzc3VlIGFzDQp0aGUg
ZHJpdmVyIG5hbWUgaXMgbGVzcyBwb3NzaWJsZSB0byBiZSBjaGFuZ2VkIGFuZCB1bmRlciBjb250
cm9sLg0KDQpIb3cgd291bGQgeW91IHN1Z2dlc3QgZm9yIGN1cnJlbnQgc2l0dWF0aW9uPw0KDQpS
ZWdhcmRzDQpBaXNoZW5nDQoNCj4gDQo+IGdyZWcgay1oDQo=
