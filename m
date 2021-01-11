Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8102F0F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbhAKJwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:52:23 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29749 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbhAKJwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:52:23 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-130-p4Z2xdyEOkONhoHpFP1zFw-1; Mon, 11 Jan 2021 09:50:44 +0000
X-MC-Unique: p4Z2xdyEOkONhoHpFP1zFw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 Jan 2021 09:50:41 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 Jan 2021 09:50:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>, Willy Tarreau <w@1wt.eu>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "Jamie Iles" <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        "Alexander Shiyan" <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: RE: Old platforms: bring out your dead
Thread-Topic: Old platforms: bring out your dead
Thread-Index: AQHW5tIZDj0fPDkXL0CUBZoouVVmHKoiLtzA
Date:   Mon, 11 Jan 2021 09:50:41 +0000
Message-ID: <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
 <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
In-Reply-To: <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwOSBKYW51YXJ5IDIwMjEgMjE6NTMNCj4gDQo+
IE9uIFNhdCwgSmFuIDksIDIwMjEgYXQgNjo1NiBBTSBXaWxseSBUYXJyZWF1IDx3QDF3dC5ldT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIEphbiAwOCwgMjAyMSBhdCAxMTo1NTowNlBNICswMTAw
LCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiA+ID4gKiA4MDQ4NlNYL0RYOiA4MDM4NiBDUFVzIHdl
cmUgZHJvcHBlZCBpbiAyMDEyLCBhbmQgdGhlcmUgYXJlDQo+ID4gPiAgIGluZGljYXRpb25zIHRo
YXQgNDg2IGhhdmUgbm8gdXNlcnMgZWl0aGVyIG9uIHJlY2VudCBrZXJuZWxzLg0KPiA+ID4gICBU
aGVyZSBpcyBzdGlsbCB0aGUgVm9ydGV4ODYgZmFtaWx5IG9mIFNvQ3MsIGFuZCB0aGUgb2xkZXN0
IG9mIHRob3NlIHdlcmUNCj4gPiA+ICAgNDg2U1gtY2xhc3MsIGJ1dCBhbGwgdGhlIG1vZGVybiBv
bmVzIGFyZSA1ODYtY2xhc3MuDQo+ID4NCj4gPiBUaGVzZSBhbHNvIGFyZSB0aGUgbGFzdCBnZW5l
cmF0aW9uIG9mIGZhbmxlc3MgeDg2IGJvYXJkcyB3aXRoIDEwMCUgY29tcGF0aWJsZQ0KPiA+IGNv
bnRyb2xsZXJzLCB0aGF0IHNvbWUgcGVvcGxlIGhhdmUgcHJvYmFibHkga2VwdCBhcm91bmQgYmVj
YXVzZSB0aGVzZSBkb24ndA0KPiA+IGFnZSBtdWNoIGFuZCBoYXZlIHBsZW50eSBvZiBjb25uZWN0
aXZpdHkuIEkndmUgdXNlZCBhbiBvbGQgb25lIGEgZmV3IHRpbWVzDQo+ID4gdG8gcGx1ZyBpbiBh
biBvbGQgZmxvcHB5IGRyaXZlLCBJU0EgU0NTSSBjb250cm9sbGVycyB0byBhY2Nlc3MgYW4gb2xk
IHRhcGUNCj4gPiBkcml2ZSBhbmQgYSBmZXcgc3VjaCB0aGluZ3MuIFRoYXQgZG9lc24ndCBtZWFu
IHRoYXQgaXQncyBhIGdvb2QganVzdGlmaWNhdGlvbg0KPiA+IG5vdCB0byByZW1vdmUgdGhlbSwg
d2hhdCBJIHJhdGhlciBtZWFuIGlzIHRoYXQgKmlmKiB0aGVyZSBpcyBubyBiZW5lZml0DQo+ID4g
aW4gZHJvcHBpbmcgdGhlbSBtYXliZSB3ZSBjYW4ga2VlcCB0aGVtLiBPbiB0aGUgb3RoZXIgaGFu
ZCwgZ29vZCBsdWNrIGZvcg0KPiA+IHJ1bm5pbmcgYSBtb2Rlcm4gT1Mgb24gdGhlc2UsIHdoZW4g
MTZNQi0zMk1CIFJBTSB3YXMgYWJvdXQgdGhlIG1heGltdW0gdGhhdA0KPiA+IHdhcyBjb21tb25s
eSBmb3VuZCBieSB0aGVuICh0aG91Z2ggaWYgcGVvcGxlIGtlcHQgdGhlbSBhcm91bmQgdGhhdCdz
IHByb2JhYmx5DQo+ID4gYmVjYXVzZSB0aGV5IHdlcmUgd2VsbCBlcXVpcHBlZCwgbGlrZSB0aGF0
IDY0TUIgMzg2RFggSSdtIGhhdmluZyA6LSkpLg0KPiANCj4gSSB0aGluayB0aGVyZSB3ZXJlIDQ4
NnMgd2l0aCB1cCB0byAyNTZNQiwgd2hpY2ggd291bGQgc3RpbGwgcXVhbGlmeSBhcyBiYXJlbHkN
Cj4gdXNhYmxlIGZvciBhIG1pbmltYWwgZGVza3RvcCwgb3IgYXMgY29tZm9ydGFibGUgZm9yIGEg
ZGVlcGx5IGVtYmVkZGVkDQo+IHN5c3RlbS4gVGhlIG1haW4gbGltaXQgd2FzIGFwcGFyZW50bHkg
dGhlIGNhY2hlYWJsZSBSQU0sIHdoaWNoIGlzIGxpbWl0ZWQNCj4gYnkgdGhlIGFtb3VudCBvZiBM
MiBjYWNoZSAtLSB5b3UgbmVlZGVkIGEgcmFyZSAxTUIgb2YgZXh0ZXJuYWwgTDItY2FjaGUgdG8N
Cj4gaGF2ZSAyNTZNQiBvZiBjYWNoZWQgUkFNLCB3aGlsZSBtb3JlIGNvbW1vbiAyNTZLQiBvZiBj
YWNoZSB3b3VsZA0KPiBiZSBnb29kIGZvciA2NE1CLiBWb3J0ZXg4NlNYIGhhcyBubyBGUFUgb3Ig
TDIgY2FjaGUgYXQgYWxsLCBidXQgc3VwcG9ydHMNCj4gMjU2TUIgb2YgRERSMi4NCg0KVGhlcmUg
YXJlIGFsc28gc29tZSBuZXdlciAod2VsbCBsZXNzIHRoYW4gMzAgeWVhciBvbGQpIGNwdXMgdGhh
dCBhcmUNCmJhc2ljYWxseSA0ODYgYnV0IGhhdmUgYSBmZXcgZXh0cmEgaW5zdHJ1Y3Rpb25zIC0g
cHJvYmFibHkganVzdCBjcHVpZA0KYW5kIChJSVJDKSByZHRzYy4NCkRlc2lnbmVkIGZvciBsb3cg
cG93ZXIgZW1iZWRkZWQgdXNlIHRoZXkgd29uJ3QgZXZlciBoYXZlIGJlZW4gc3VpdGFibGUNCmZv
ciBhIGRlc2t0b3AgLSBidXQgYXJlIHByb2JhYmx5IGZhc3QgZW5vdWdoIGZvciBzb21lIHVzZXMu
DQpJJ20gbm90IHN1cmUgaG93IG11Y2gga2VlcGluZyA0ODYgc3VwcG9ydCBhY3R1YWxseSBjb3N0
cywgMzg2IHdhcyBhDQpQSVRBIC0gYnV0IHRoZSA0ODYgZml4ZWQgbW9zdCBvZiB0aG9zZSBpc3N1
ZXMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

