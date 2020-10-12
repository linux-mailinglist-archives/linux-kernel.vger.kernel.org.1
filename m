Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127FC28B0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgJLI6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:58:22 -0400
Received: from mail-db8eur05on2053.outbound.protection.outlook.com ([40.107.20.53]:52256
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727484AbgJLI6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWxvd6yN/IStxWAV8bAw8jPiDfFADR3+nzsfoEafqylfm0Hk/MqRQaBkhmgYOVKu2JTd7Ov9hLKyNsJpnx3x1gsW2rQ4T28YMMQspOF85md+4swtqmCEqn3pV/rQFGFFBP55wTk7wV8uJR9LVbH/PySbWxgCwS9LGwEY/IKhoVPlmx1CcVSecCDzpFBvCHhjEXANpW3y0jl6IsB+skiqr5DnqBL1nNkEMatVvk0W9/sfJjwQjKbNRrxUist7/Mbm1K00r/O/4EtKUGCkv64Xaa8oYXdaSJNFwaMK2xzQRLC0+e+GGZ9SMh/vn6MT/yb2wc4mC6DB/Ks+pKiVGQXC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCtaugLesvBQ/GukWCv87WiYe6x4Dwq7L8CydNPvUWk=;
 b=j0CmUK4MI1iPLqozeavk8a26qIHJP+BZXUzLoUsNeun5pV2MZHy/AFQ1C7I84ruSskuQM6sXwz9NunPRLzCVTXDouqVo9ryt8a5dwUKpIKnBdu2EK1XF9pYOBssl+v4v2GivlbkRo/1NmB+EUxn0V2U7vercRBBDtMJ4pglevZq1a9mnENg4h4FLRhu/H44Lr9akqSM5JX+F8g3dW4/HfymWj5UmECm7DZf1I2li224hTGA9cnajMfEWQLWxH1EWCsPRHyyAIFc/N0uLc+7Bx4KQ04m7FxpGXi4dV+ieLtAEZYqCq8AqA/5rRFV9stOgQsts0HXRQpd88dbcTE7gGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCtaugLesvBQ/GukWCv87WiYe6x4Dwq7L8CydNPvUWk=;
 b=sii6pDVKOQLSqRIvFkSGkpdV8tn+Ao2zQRutCieBzV+iteqV0Z2Tzn2spc27i3UL7VcV0kfYDJ0hmyNVrZbbhzhAk00cJp6ZMM9dqnAspD+ZouGkkDGWZDR06BmERgGACNQaLXeFXGa2fKPuDjNeOJoc3eHxOgcYsm+MOvElJWo=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VI1PR04MB6189.eurprd04.prod.outlook.com (2603:10a6:803:fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Mon, 12 Oct
 2020 08:58:17 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::acd3:d354:3f34:3af7]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::acd3:d354:3f34:3af7%4]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 08:58:17 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        ChiYuan Huang <u0084500@gmail.com>
CC:     Jun Li <lijun.kernel@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>
Subject: RE: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
Thread-Topic: [PATCH] usb: typec: tcpm: Fix if vbus before cc,
 hard_reset_count not reset issue
Thread-Index: AQHWnAEP61hqDMcgWUCo9++n9QPVoamK1ygAgAEVuICAAt0qsIAAqiyAgAETjtCAALg8AIACc0cg
Date:   Mon, 12 Oct 2020 08:58:17 +0000
Message-ID: <VE1PR04MB6528165DAECBCD18083AEDDE89070@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net>
 <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com>
 <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com>
 <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
 <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
 <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
 <CADiBU392ZL6AHf6Dns61KXFVuvwh6grfnJjXmcFE4Ma2gjK6EA@mail.gmail.com>
 <VE1PR04MB6528CF55BE68A8DCF4B7904689080@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <CADiBU38-jX=4sbQ9aFoA=Xr6S7cFbfQy8tpdohoZdpaY-AK-Vw@mail.gmail.com>
 <VE1PR04MB652891569AB48A1C90A22C6389090@VE1PR04MB6528.eurprd04.prod.outlook.com>
 <25503f4e-58d1-8c11-9e5e-ea570b529d09@roeck-us.net>
In-Reply-To: <25503f4e-58d1-8c11-9e5e-ea570b529d09@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.64.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 361a8666-f405-4a97-db30-08d86e8cf616
x-ms-traffictypediagnostic: VI1PR04MB6189:
x-microsoft-antispam-prvs: <VI1PR04MB618980EB59130D3CD66A2F6989070@VI1PR04MB6189.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsp9J/2yM9DHHPdICSjhfw6hO0mYk+gb7kTa6ulJ8rFMWp03FuavQWyDbC6aBYeSEtorK61yLMENlUQO2QydmKG6XGDW8Q87bnmCOFecedO+6/fzVPe7wPDg7swOX3iv1rOBpcjwd56U9cmK14cBkSbEBbnrDKQLhxCe40WzkHJQOdfIjZQGnUJ1gYpTj8I223ZoQc/hEIbRhaU5fhYoKbOsTdgTzDXjDSiu5K1rkg6mbmNPaXOitRm/fhVB85n2iy9he7ZRblC/OzCiZFg7g+aI2TDuhVQfP684XfPtQ7I1oalhT0SbXnYRUXiy006jw/Vw+lBg2rx/quQH8pnlzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(8936002)(9686003)(66946007)(86362001)(66556008)(71200400001)(64756008)(66446008)(66476007)(186003)(54906003)(76116006)(316002)(110136005)(478600001)(53546011)(6506007)(44832011)(8676002)(52536014)(7696005)(55016002)(33656002)(4326008)(5660300002)(26005)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5bZmGKLjVcmmpO9b/ydlEfUiCUbqneBzyNgk/yQjMy/09vdFansFihrAcP+wFqHtkxNBBE8NWAkZLA3oFuPqRrIldpd/G5jo7AUVZhGSTDhIPI1V9X7Q+gvajtJzvxXaYYWcQ3UKRbsfKfjUXJsezB/KOr3wXuUgXOCQ60A//+8rS4EZZwkm1+zNbZHCGCRnK3Cu9utWCLPUU8hT2+9OttQ+HQeopl6aM0vhg6RY0qPXKgSZVMptY891tWD9A8rT95+9utkizSjMONBp9Qz6KAX3itzJWxC3Vuf8Lg14DSjxSzVJD0UfaDMG8hXoTUWaiWxiDFF9X4hSp5pihf//rruhWtWA+lP6KhdttM5lSWcw/b1R4KGeNJkWVeRmaLHU/xv4U+69zuXqQf6HRY3IvjxMpOs6N/sEmjyYGRnokbHF3Of3UhonDUovpqu5PfwatmCsZK7l5ejGFWC7BAsMbZPkT/9yAvyNgaxCz5WqciY2nZoP68LgEZ3RFH2mbWC+g4qRSvYgyi+chLfa/wOxu1mgw1Jdy95x7KwV+077u7ve5YRbaKopiOcu0n/MnCFNIZUrWrvxgVWDcSrcACbmO5tlfS8lMI5tuNbIXnMunPIEW5pnHHy3TtfivZ7315DunwuWBs8JZckiAHZQtJ0lqw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6528.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361a8666-f405-4a97-db30-08d86e8cf616
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 08:58:17.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Sg9fCKFYCLeLdq11aln3AbLE0NIPayP1AhHx1rIts9S9mTLjklSaMG4leUA0uxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6189
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IFN1
bmRheSwgT2N0b2JlciAxMSwgMjAyMCAzOjMyIEFNDQo+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAu
Y29tPjsgQ2hpWXVhbiBIdWFuZyA8dTAwODQ1MDBAZ21haWwuY29tPg0KPiBDYzogSnVuIExpIDxs
aWp1bi5rZXJuZWxAZ21haWwuY29tPjsgR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+Ow0KPiBIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+
OyBMaW51eCBVU0IgTGlzdA0KPiA8bGludXgtdXNiQHZnZXIua2VybmVsLm9yZz47IGxrbWwgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBjeV9odWFuZyA8Y3lfaHVhbmdAcmljaHRl
ay5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogdHlwZWM6IHRjcG06IEZpeCBpZiB2
YnVzIGJlZm9yZSBjYywgaGFyZF9yZXNldF9jb3VudA0KPiBub3QgcmVzZXQgaXNzdWUNCj4gDQo+
IE9uIDEwLzEwLzIwIDQ6MjEgQU0sIEp1biBMaSB3cm90ZToNCg0KLi4uDQoNCj4gPj4NCj4gPj4g
TGlrZSBJIG1lbnRpb25lZCBiZWZvcmUsIHdoYXRldmVyIHRoZSBjb25kaXRpb24gaXMsIGhhcmRf
cmVzZXRfY291bnQNCj4gPj4gbXVzdCBiZSByZXNldCB0byB6ZXJvIGR1cmluZyB0Y3BtX2RldGFj
aC4NCj4gPg0KPiA+IFRoaXMgbWF5IG5vdCBiZSBzbyBjb3JyZWN0IGFzIHlvdSBzYWlkLCBJIHRo
aW5rIEd1ZW50ZXIncyBjb25jZXJuIGlzIHZhbGlkLg0KPiA+DQo+ID4gdGNwbV9kZXRhY2goKSBp
cyBub3QgKm9ubHkqIGJlIGNhbGxlZCBpbiBjYXNlcyBvZiAqcGh5c2ljYWwqIGRldGFjaA0KPiA+
IGxpa2UgdGhlIGZ1bmN0aW9uIG5hbWUgc3VnZ2VzdHMuDQo+ID4NCj4gPiBUaGUgY3VycmVudCBw
cm9wb3NhbHMgbWF5ICp3cm9uZ2x5KiByZXNldCB0aGlzIGNvdW50ZXIuDQo+ID4NCj4gPiBMZXQg
bWUgZ2l2ZSBhbiBleGFtcGxlOg0KPiA+DQo+ID4gSEFSRF9SRVNFVF9TRU5EIC0+IEhBUkRfUkVT
RVRfU1RBUlQgLT4gU05LX0hBUkRfUkVTRVRfU0lOS19PRkYgLT4NCj4gPiBTTktfSEFSRF9SRVNF
VF9XQUlUX1ZCVVMgLT4gU05LX1VOQVRUQUNIRUQoaW4gY2FzZSBvZiBWQlVTIGRvZXNuJ3QNCj4g
PiBjb21lIGJhY2sgaW4gZXhwZWN0ZWQgZHVyYXRpb24pDQo+ID4gLT4gY2FsbCB0byB0Y3BtX2Rl
dGFjaCgpDQo+ID4NCj4gPiBJbiB0aGlzIHNlcXVlbmNlLCBkb2VzIHRoZSBzaW5rIG5lZWQga2Vl
cCB0aGUgY291bnRlcj8gRnJvbSB0aGUgUEQNCj4gPiBzcGVjLCBJIHRoaW5rIHRoZSBhbnN3ZXIg
aXMgeWVzLCBzaW5rIG5lZWQgdGhpcyBjb3VudGVyIHRvIGp1ZGdlIGlmDQo+ID4gbmVlZCBkbyBo
YXJkIHJlc2V0IGFnYWluIG9yIGVycm9yIHJlY292ZXJ5IG9uIGxhdGVyIHRyeSwgc2VlOg0KPiA+
DQo+ID4gRmlndXJlIDgtNjcgU2luayBQb3J0IFN0YXRlIERpYWdyYW0NCj4gPg0KPiA+IFRoZSBk
aWZmZXJlbmNlIGJldHdlZW4geW91ciBjYXNlIGFuZCBteSBleGFtcGxlLCBpcyB5b3VyIGNhc2Ug
bmV2ZXINCj4gPiB0dXJuIG9mZiB2YnVzLCBzbyB3aWxsIG5vdCBnbyB0byBTTktfVU5BVFRBQ0hF
RCwgc28gd2lsbCBub3QgY2FsbCB0bw0KPiA+IHRjcG1fZGV0YWNoKCkgYWZ0ZXIgZmlyc3QgaGFy
ZCByZXNldC4NCj4gPg0KPiA+IFNvDQo+ID4gCWlmICh0Y3BtX3BvcnRfaXNfZGlzY29ubmVjdGVk
KHBvcnQpKQ0KPiA+IAkJcG9ydC0+aGFyZF9yZXNldF9jb3VudCA9IDA7DQo+ID4NCj4gPiBzaG91
bGQga2VlcCBhcyBpdCBpcywgdGhlIGNvdW50ZXIgY2FuIG9ubHkgYmUgY2xlYXJlZCBpZiB0aGVy
ZSBpcw0KPiA+IHJlYWxseSBwaHlzaWNhbCBkaXNjb25uZWN0IGJ5ICpwYXJ0bmVyKi4NCj4gPg0K
PiA+IEJ1dCBjdXJyZW50IHRjcG0gY29kZSBtYXkgaGF2ZSBzb21lIHByb2JsZW0gb24ga2VlcGlu
ZyBsb2NhbCBDQyBzdGF0ZQ0KPiA+IGlmIHRoZXJlIGlzIGhhcmQgcmVzZXQgb24tZ29pbmcocG9y
dC0+aGFyZF9yZXNldF9jb3VudCA+IDApLCBiZWNhdXNlDQo+ID4gdGhlIGN1cnJlbnQgaGFuZGxp
bmcgb2YgU05LX1VOQVRUQUNIRUQgbWF5IGNhdXNlIGRpc2Nvbm5lY3Rpb24NCj4gPiBnZW5lcmF0
ZWQgYnkgKmxvY2FsKihwYXJ0bmVyIGFjdHVhbGx5IGtlZXBzIGl0cyBDQyksIGUuZy4gcmVzZXQN
Cj4gPiBwb2xhcml0eSBhbmQgZG8gZHJwX3RvZ2dsaW5nLCB0aGlzIHNob3VsZCBiZSBmaXhlZCwg
YnV0IHRoaXMgaXMNCj4gPiBhbm90aGVyIHBhdGNoLCBJIGNhbiB0cnkgdG8gZG8gdGhpcyBsYXRl
ci4NCj4gPg0KPiA+IEJhY2sgdG8geW91ciBwcm9ibGVtLCBJIHRoaW5rIHRoZSBpc3N1ZSBpcywg
YXQgdGhlIGZpcnN0IHRjcG1fZGV0YWNoKCkNCj4gPiB0aGUgY2MgZGlzY29ubmVjdCBldmVudCBo
YXNuJ3QgaGFwcGVuLCBzbyB0aGUgcmVzZXQgY291bnRlciBpcyBsZWZ0DQo+ID4gdGhlcmUgYnV0
IHRoZSBwb3J0LT5hdHRhY2hlZCBpcyBjbGVhcmVkLCB0aGVuIHRoZSBmb2xsb3dpbmcocmVhbA0K
PiA+IGRpc2Nvbm5lY3QpDQo+ID4gdGNwbV9kZXRhY2goKSB3aWxsIGp1c3QgcmV0dXJuIGRpcmVj
dGx5IGR1ZSB0byBwb3J0LT5hdHRhY2hlZCBpcyBmYWxzZS4NCj4gPg0KPiA+IFNvIEkgZ3Vlc3Mg
dGhpcyB3aWxsIHJlc29sdmUgeW91ciBwcm9ibGVtOg0KPiA+DQo+ID4gQEAgLTI4ODUsNiArMjg4
NSw5IEBAIHN0YXRpYyB2b2lkIHRjcG1fcmVzZXRfcG9ydChzdHJ1Y3QgdGNwbV9wb3J0DQo+ID4g
KnBvcnQpDQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgdGNwbV9kZXRhY2goc3RydWN0IHRjcG1fcG9y
dCAqcG9ydCkgIHsNCj4gPiArICAgICAgIGlmICh0Y3BtX3BvcnRfaXNfZGlzY29ubmVjdGVkKHBv
cnQpKQ0KPiA+ICsgICAgICAgICAgICAgICBwb3J0LT5oYXJkX3Jlc2V0X2NvdW50ID0gMDsNCj4g
PiArDQo+ID4gICAgICAgICBpZiAoIXBvcnQtPmF0dGFjaGVkKQ0KPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm47DQo+ID4NCj4gPiBAQCAtMjg5Myw5ICsyODk2LDYgQEAgc3RhdGljIHZvaWQgdGNw
bV9kZXRhY2goc3RydWN0IHRjcG1fcG9ydCAqcG9ydCkNCj4gPiAgICAgICAgICAgICAgICAgcG9y
dC0+dGNwYy0+c2V0X2Jpc3RfZGF0YShwb3J0LT50Y3BjLCBmYWxzZSk7DQo+ID4gICAgICAgICB9
DQo+ID4NCj4gPiAtICAgICAgIGlmICh0Y3BtX3BvcnRfaXNfZGlzY29ubmVjdGVkKHBvcnQpKQ0K
PiA+IC0gICAgICAgICAgICAgICBwb3J0LT5oYXJkX3Jlc2V0X2NvdW50ID0gMDsNCj4gPiAtDQo+
ID4gICAgICAgICB0Y3BtX3Jlc2V0X3BvcnQocG9ydCk7DQo+ID4gIH0NCj4gPg0KPiA+DQo+ID4g
Q29tcGFyZWQgd2l0aCBjdXJyZW50IGNvZGUncyBjb25kaXRpb246DQo+ID4gICAgMyBzdGF0aWMg
Ym9vbCB0Y3BtX3BvcnRfaXNfZGlzY29ubmVjdGVkKHN0cnVjdCB0Y3BtX3BvcnQgKnBvcnQpDQo+
ID4gICAgNCB7DQo+ID4gICAgNSAgICAgICAgIHJldHVybiAoIXBvcnQtPmF0dGFjaGVkICYmIHBv
cnQtPmNjMSA9PSBUWVBFQ19DQ19PUEVOICYmDQo+ID4gICAgNiAgICAgICAgICAgICAgICAgcG9y
dC0+Y2MyID09IFRZUEVDX0NDX09QRU4pIHx8DQo+ID4gICAgNyAgICAgICAgICAgICAgICAocG9y
dC0+YXR0YWNoZWQgJiYgKChwb3J0LT5wb2xhcml0eSA9PQ0KPiBUWVBFQ19QT0xBUklUWV9DQzEg
JiYNCj4gPiAgICA4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvcnQtPmNj
MSA9PSBUWVBFQ19DQ19PUEVOKSB8fA0KPiA+ICAgIDkgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAocG9ydC0+cG9sYXJpdHkgPT0NCj4gVFlQRUNfUE9MQVJJVFlfQ0MyICYmDQo+
ID4gICAxMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0LT5jYzIgPT0g
VFlQRUNfQ0NfT1BFTikpKTsNCj4gPiAgIDExIH0NCj4gPg0KPiA+IE15IGFib3ZlIGNoYW5nZSBp
cyBvbmx5IGFkZGluZyBhbm90aGVyIGNvbmRpdGlvbiB0byBjbGVhciB0aGUgcmVzZXQgY291bnRl
cjoNCj4gPiAoIXBvcnQtPmF0dGFjaGVkICYmIHBvcnQtPmNjMSA9PSBUWVBFQ19DQ19PUEVOICYm
IHBvcnQtPmNjMiA9PQ0KPiA+IFRZUEVDX0NDX09QRU4pDQo+ID4NCj4gPiBUaGlzIGNvbmRpdGlv
biBpcyBjbG9zZSB0byBHdWVudGVyJ3Mgc3VnZ2VzdGlvbiBpbiB0aGlzIHRocmVhZDoNCj4gPg0K
PiA+IC0gICAgICAgaWYgKHRjcG1fcG9ydF9pc19kaXNjb25uZWN0ZWQocG9ydCkpDQo+ID4gKyAg
ICAgICBpZiAodGNwbV9wb3J0X2lzX2Rpc2Nvbm5lY3RlZChwb3J0KSB8fA0KPiA+ICsgICAgICAg
ICAgICh0Y3BtX2NjX2lzX29wZW4ocG9ydC0+Y2MxKSAmJg0KPiA+ICsgdGNwbV9jY19pc19vcGVu
KHBvcnQtPmNjMikpKQ0KPiA+DQo+ID4gSGkgR3VlbnRlciwgYW55IGNvbW1lbnRzIG9uIHRoaXM/
DQo+ID4NCj4gDQo+IFRoYXQgbWFrZXMgc2Vuc2UsIGFuZCBJIHdvdWxkIGFncmVlIHRvIHRoZSBj
aGFuZ2UgeW91IHN1Z2dlc3QgYWJvdmUuDQoNClRoYW5rcy4NCg0KTGkgSnVuDQo+IA0KPiBHdWVu
dGVyDQo+IA0KPiA+IFRoYW5rcw0KPiA+IExpIEp1bg0KPiA+DQo+ID4+DQo+ID4+IEJ1dCByZWZl
ciB0byBHdWVudGVyJ3MgbWFpbCwgIGhlIHByZWZlciB0byBuYXJyb3cgZG93biB0aGUgY29uZGl0
aW9uDQo+ID4+IHRvIHJlc2V0IHRoaXMgY291bnRlci4NCj4gPj4NCj4gPj4gSSB0aGluayB0aGUg
b3JpZ2luYWwgdGhvdWdodCBpcyBpbXBvcnRhbnQgd2h5IHRvIHB1dCB0aGlzIGxpbmUgdGhlcmUu
DQo+ID4+DQo+ID4+IEhpLCBHdWVudGVyOg0KPiA+PiAgICBGcm9tIHRoZSBkaXNjdXNzaW9uLCB3
ZSByZWFsbHkgbmVlZCB0byBrbm93IHdoeSB5b3UgcHV0IHRoZSByZXNldA0KPiA+PiBsaW5lIGJl
bG93IHBvcnQgYXR0YWNoZWQgaXMgZmFsc2UgYW5kIGFsc28gbWFrZSBzb21lIGp1ZGdlbWVudC4N
Cj4gPj4gSSB0aGluayB0aGVyZSBtYXkgYmUgb21lIGNvbmRpdGlvbiB0aGF0IHdlIGRvbid0IGNv
bnNpZGVyZWQuDQo+ID4NCj4gPiBUaGlzIGNvbmRpdGlvbiB3YXMgYWRkZWQgYXQgZmlyc3QgcGxh
Y2UsIEkgdGhpbmsgbXkgYWJvdmUNCj4gPj4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+Pj4+Pj4NCj4g
Pj4+Pj4+Pj4gR3VlbnRlcg0KDQo=
