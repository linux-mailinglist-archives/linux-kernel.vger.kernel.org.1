Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE12F20C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404258AbhAKU02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:26:28 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2942 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404024AbhAKU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:26:26 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DF4ty2w9Wz5Fvm;
        Tue, 12 Jan 2021 04:24:42 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 12 Jan 2021 04:25:42 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 12 Jan 2021 04:25:41 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Tue, 12 Jan 2021 04:25:41 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        "Russell King - ARM Linux" <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "Jamie Iles" <jamie@jamieiles.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
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
        "xuwei (O)" <xuwei5@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: RE: Old platforms: bring out your dead
Thread-Topic: Old platforms: bring out your dead
Thread-Index: AQHW5hFdvTAk6UyjnUeMOtyxbp6MCKoi4XvQ
Date:   Mon, 11 Jan 2021 20:25:41 +0000
Message-ID: <c969392572604b98bcb3be44048c3165@hisilicon.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.73]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiBb
bWFpbHRvOmFybmRAa2VybmVsLm9yZ10NCj4gU2VudDogU2F0dXJkYXksIEphbnVhcnkgOSwgMjAy
MSAxMTo1NSBBTQ0KPiBUbzogTGludXggQVJNIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZw0KPiBMaXN0IDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPg0KPiBDYzogS3J6eXN6dG9mIEFkYW1za2kgPGtyenlzenRvZi5hZGFtc2tp
QG5va2lhLmNvbT47IE9sZWtzaWogUmVtcGVsDQo+IDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT47
IEJhcnVjaCBTaWFjaCA8YmFydWNoQHRrb3MuY28uaWw+OyBSdXNzZWxsIEtpbmcgLQ0KPiBBUk0g
TGludXggPGxpbnV4QGFybWxpbnV4Lm9yZy51az47IERhbmllbCBUYW5nIDxkdC50YW5nckBnbWFp
bC5jb20+OyBVd2UNCj4gS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4
LmRlPjsgSmFtaWUgSWxlcw0KPiA8amFtaWVAamFtaWVpbGVzLmNvbT47IFNvbmcgQmFvIEh1YSAo
QmFycnkgU29uZykgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPjsNCj4gVmlyZXNoIEt1bWFy
IDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47IExpbnVzIFdhbGxlaWoNCj4gPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz47IEpvbmFzIEplbnNlbiA8am9uYXMuamVuc2VuQGdtYWlsLmNvbT47IE1h
cmMNCj4gR29uemFsZXogPG1hcmMudy5nb256YWxlekBmcmVlLmZyPjsgSGFydGxleSBTd2VldGVu
DQo+IDxoc3dlZXRlbkB2aXNpb25lbmdyYXZlcnMuY29tPjsgTHVib21pciBSaW50ZWwgPGxrdW5k
cmFrQHYzLnNrPjsgTmVpbA0KPiBBcm1zdHJvbmcgPG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPjsg
U2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgQWxleA0KPiBFbGRlciA8ZWxkZXJAbGlu
YXJvLm9yZz47IEFsZXhhbmRlciBTaGl5YW4gPHNoY193b3JrQG1haWwucnU+OyBLb2VuIFZhbmRl
cHV0dGUNCj4gPGtvZW4udmFuZGVwdXR0ZUBuY2VudHJpYy5jb20+OyBIYW5zIFVsbGkgS3JvbGwg
PHVsbGkua3JvbGxAZ29vZ2xlbWFpbC5jb20+Ow0KPiBWbGFkaW1pciBaYXBvbHNraXkgPHZ6QG1s
ZWlhLmNvbT47IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBTdGV2ZW4NCj4gUm9zdGVk
dCA8cm9zdGVkdEBnb29kbWlzLm9yZz47IFlvc2hpbm9yaSBTYXRvIDx5c2F0b0B1c2Vycy5zb3Vy
Y2Vmb3JnZS5qcD47DQo+IE1hcmsgU2FsdGVyIDxtc2FsdGVyQHJlZGhhdC5jb20+OyBNaWNoYWVs
IEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+OyBHZWVydA0KPiBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgVGhvbWFzIEJvZ2VuZG9lcmZlcg0KPiA8dHNib2dlbmRA
YWxwaGEuZnJhbmtlbi5kZT4NCj4gU3ViamVjdDogT2xkIHBsYXRmb3JtczogYnJpbmcgb3V0IHlv
dXIgZGVhZA0KPiANCj4gQWZ0ZXIgdjUuMTAgd2FzIG9mZmljaWFsbHkgZGVjbGFyZWQgYW4gTFRT
IGtlcm5lbCwgSSBoYWQgYSBsb29rIGFyb3VuZA0KPiB0aGUgQXJtIHBsYXRmb3JtcyB0aGF0IGxv
b2sgbGlrZSB0aGV5IGhhdmUgbm90IHNlZW4gYW55IHBhdGNoZXMgZnJvbQ0KPiB0aGVpciBtYWlu
dGFpbmVycyBvciB1c2VycyB0aGF0IGFyZSBhY3R1YWxseSBydW5uaW5nIHRoZSBoYXJkd2FyZSBm
b3INCj4gYXQgbGVhc3QgZml2ZSB5ZWFycyAoMjAxNSBvciBlYXJsaWVyKS4gSSBtYWRlIHNvbWUg
c3RhdGlzdGljcyBhbmQgbGlzdHMNCj4gZm9yIG15IGx3bi5uZXQgYXJ0aWNsZSBsYXN0IHllYXIg
WzFdLCBzbyBJJ2QgdGhvdWdodCBJJ2Qgc2hhcmUgYSBzdW1tYXJ5DQo+IGhlcmUgZm9yIGRpc2N1
c3Npb24gYWJvdXQgd2hhdCB3ZSBzaG91bGQgcmVtb3ZlLiBBcyBJIGZvdW5kIHRocmVlDQo+IHll
YXJzIGFnbyB3aGVuIEkgcmVtb3ZlZCBzZXZlcmFsIENQVSBhcmNoaXRlY3R1cmVzLCBpdCBtYWtl
cyBzZW5zZQ0KPiB0byBkbyB0aGlzIGluIGJ1bGssIHRvIHNpbXBsaWZ5IGEgc2NyaXB0ZWQgc2Vh
cmNoIGZvciBkZXZpY2UgZHJpdmVycywgaGVhZGVyDQo+IGZpbGVzIGFuZCBLY29uZmlnIG9wdGlv
bnMgdGhhdCBiZWNvbWUgdW51c2VkIGluIHRoZSBwcm9jZXNzLg0KPiANCj4gVGhpcyBpcyBwcm9i
YWJseSBhIG1peCBvZiBwbGF0Zm9ybXMgdGhhdCBhcmUgY29tcGxldGVseSB1bnVzZWQgYW5kDQo+
IHRob3NlIHRoYXQganVzdCB3b3JrLCBidXQgSSBoYXZlIG5vIGdvb2Qgd2F5IG9mIGtub3dpbmcg
d2hpY2ggb25lDQo+IGl0IGlzLiBXaXRob3V0IGhlYXJpbmcgYmFjayBhYm91dCB0aGVzZSwgSSdk
IHByb3Bvc2UgcmVtb3ZpbmcgYWxsIG9mDQo+IHRoZXNlOg0KPiANCj4gKiBhc205MjYwIC0tIGFk
ZGVkIGluIDIwMTQsIG5vIG5vdGFibGUgY2hhbmdlcyBhZnRlciAyMDE1DQo+ICogYXh4aWEgLS0g
YWRkZWQgaW4gMjAxNCwgbm8gbm90YWJsZSBjaGFuZ2VzIGFmdGVyIDIwMTUNCj4gKiBiY20va29u
YSAtLSBhZGRlZCBpbiAyMDEzLCBubyBub3RhYmxlIGNoYW5nZXMgYWZ0ZXIgMjAxNA0KPiAqIGRp
Z2ljb2xvciAtLSBhZGRlZCBpbiAyMDE0LCBubyBub3RhYmxlIGNoYW5nZXMgYWZ0ZXIgMjAxNQ0K
PiAqIGRvdmUgLS0gYWRkZWQgaW4gMjAwOSwgb2Jzb2xldGVkIGJ5IG1hY2gtbXZlYnUgaW4gMjAx
NQ0KPiAqIGVmbTMyIC0tIGFkZGVkIGluIDIwMTEsIGZpcnN0IENvcnRleC1NLCBubyBub3RhYmxl
IGNoYW5nZXMgYWZ0ZXIgMjAxMw0KPiAqIG5zcGlyZSAtLSBhZGRlZCBpbiAyMDEzLCBubyBub3Rh
YmxlIGNoYW5nZXMgYWZ0ZXIgMjAxNQ0KPiAqIHBpY294Y2VsbCAtLSBhZGRlZCBpbiAyMDExLCBh
bHJlYWR5IHF1ZXVlZCBmb3IgcmVtb3ZhbA0KPiAqIHByaW1hMiAtLSBhZGRlZCBpbiAyMDExMSwg
bm8gbm90YWJsZSBjaGFuZ2VzIHNpbmNlIDIwMTUNCg0KSGkgQXJuZCwNCkkgZ290IGNvbmZpcm1h
dGlvbiBmcm9tIFF1YWxjb21tIGd1eXMgdGhhdCB0aGVyZSBpcyBubyBwbGFuDQp0byBtYWludGFp
biBwcmltYTIgaW4gbWFpbmxpbmUgYW55IG1vcmUuDQpQbGVhc2UgZmVlbCBmcmVlIHRvIHJlbW92
ZSB0aGUgY29kZS4gSWYgeW91IG5lZWQgbXkgaGVscCwNClBsZWFzZSBsZXQgbWUga25vdy4NCg0K
PiAqIHNwZWFyIC0tIGFkZGVkIGluIDIwMTAsIG5vIG5vdGFibGUgY2hhbmdlcyBzaW5jZSAyMDE1
DQo+ICogdGFuZ28gLS0gYWRkZWQgaW4gMjAxNSwgc3BvcmFkaWMgY2hhbmdlcyB1bnRpbCAyMDE3
LCBidXQgYWJhbmRvbmVkDQo+ICogdTMwMCAtLSBhZGRlZCBpbiAyMDA5LCBubyBub3RhYmxlIGNo
YW5nZXMgc2luY2UgMjAxMw0KPiAqIHZ0ODUwMCAtLSBhZGRlZCBpbiAyMDEwLCBubyBub3RhYmxl
IGNoYW5nZXMgc2luY2UgMjAxNA0KPiAqIHp4IC0tYWRkZWQgaW4gMjAxNSBmb3IgYm90aCAzMiwg
MjAxNyBmb3IgNjQgYml0LCBubyBub3RhYmxlIGNoYW5nZXMNCj4gDQoNClRoYW5rcw0KQmFycnkN
Cg0K
