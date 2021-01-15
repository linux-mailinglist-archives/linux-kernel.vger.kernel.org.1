Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB72F74CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbhAOJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:00:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:50595 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbhAOJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:00:58 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-139-FeaFWBfuMK2JfgETPBPa6Q-1; Fri, 15 Jan 2021 08:59:19 +0000
X-MC-Unique: FeaFWBfuMK2JfgETPBPa6Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 15 Jan 2021 08:59:18 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 15 Jan 2021 08:59:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'William Breathitt Gray' <vilhelm.gray@gmail.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Alex Elder" <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        "Koen Vandeputte" <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: RE: Old platforms: bring out your dead
Thread-Topic: Old platforms: bring out your dead
Thread-Index: AQHW5tIZDj0fPDkXL0CUBZoouVVmHKoiLtzAgAWtpoeAAIxn4A==
Date:   Fri, 15 Jan 2021 08:59:18 +0000
Message-ID: <adf785e6ef444ce59cda1b049fc1b2ff@AcuMS.aculab.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
 <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
 <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
 <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
 <CAHp75Ve3QqLqe2sQhNgdrDfKm2uSwXFwMr5_GgGf3tiuCp2DBQ@mail.gmail.com>
 <CAHp75VceqwbfQ=z34K=soKu4-qvLVEtobFg1sO4jukRcT7BXBg@mail.gmail.com>
 <6437080014a3a9af63f2c50b620f389c1f104e91.camel@petrovitsch.priv.at>
 <YADgsq8p/4TNLPIM@shinobu>
In-Reply-To: <YADgsq8p/4TNLPIM@shinobu>
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

RnJvbTogV2lsbGlhbSBCcmVhdGhpdHQgR3JheQ0KPiBTZW50OiAxNSBKYW51YXJ5IDIwMjEgMDA6
MjQNCi4uLg0KPiBUaGF0J3MgcGFydCBvZiB0aGUgQmF5IFRyYWlsIGdlbmVyYXRpb24gaXNuJ3Qg
aXQ/IEFyZSB0aG9zZSBwcm9jZXNzb3JzDQo+IHN0aWxsIG1hbnVmYWN0dXJlZD8gTXkgd29ycnkg
aXMgdGhhdCBhbHRob3VnaCB0aGVyZSBhcmUgYm9hcmRzIHN0aWxsIGluDQo+IHByb2R1Y3Rpb24s
IHRoZXkgbWlnaHQgYmUgc2ltcGx5IHVzaW5nIHVwIGFuIG9sZCBzdG9jayBvZiBwYXJ0cy4gVGhl
DQo+IHF1ZXN0aW9uIGJlY29tZXMgd2hldGhlciB0aGVzZSB3aWxsIHN0aWxsIGJlIHByb2R1Y2Vk
IGluIHRoZSBuZWFyDQo+IGZ1dHVyZSwgb3Igd2hldGhlciB0aGUgY29tcGFuaWVzIGFyZSBqdXN0
IHVzaW5nIHVwIHRoZSByZXN0IG9mIHRoZWlyDQo+IHN1cHBseS4NCg0KVGhlICdzdG9jayBvZiBw
YXJ0cycgbWlnaHQgZ28gYmFjayBhcyBmYXIgYXMgZXRjaGVkIHdhZmVycyB0aGF0DQpoYXZlbid0
IGJlZW4gY3V0IHVwLi4uLg0KRXZlbiB0aGVuIGl0IG1heSB0YWtlIGEgbW9kZXJhdGUgZGVtYW5k
IHRvIGdldCB0aGVtIHByb2Nlc3NlZC4NCg0KV2UncmUgaGF2ZSB0byByZWRlc2lnbiBhIGJvYXJk
IHRvIHVzZSBhIGNvbXBsZXRlbHkgZGlmZmVyZW50DQpwYXJ0IGJlY2F1c2UgdGhlIG9uZSB3ZSB3
ZXJlIHVzaW5nIGhhcyBnb25lIGVuZC1vZi1saWZlLg0KDQpIb3BlZnVsbHkgdGhlIHJlcGxhY2Vt
ZW50IHdpbGwgYmUgbWFkZSBmb3IgYSB3aGlsZS4NClRoZSBkYXRhc2hlZXQgZm9yIHRoYXQgcGFy
dCBpcyAxMiB5ZWFycyBvbGQuDQoNClRoZSBkZXNpZ25zIGZvciBib3RoIGFyZSBwcm9iYWJseSBv
dmVyIDIwIHllYXJzIG9sZC4NClRoZSBURE0gRTEvVDEgaW50ZXJmYWNlIGlzIGFib3V0IDUwLg0K
QnV0IGl0IGlzIHN0aWxsIHVzZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

