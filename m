Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B899E270ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 17:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgISPPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 11:15:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:23203 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbgISPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 11:15:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-119-zyhv7N-1MGiIdxBhVxCBPA-1; Sat, 19 Sep 2020 16:15:09 +0100
X-MC-Unique: zyhv7N-1MGiIdxBhVxCBPA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 19 Sep 2020 16:15:08 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 19 Sep 2020 16:15:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [GIT PULL] percpu fix for v5.9-rc6
Thread-Topic: [GIT PULL] percpu fix for v5.9-rc6
Thread-Index: AQHWjgyny/sE3fQBqEK1/ezS5qKpfKlwETuA
Date:   Sat, 19 Sep 2020 15:15:08 +0000
Message-ID: <776bcc3e3814433a8ed2c2027a2cf7c1@AcuMS.aculab.com>
References: <20200918162305.GB25599@embeddedor>
 <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor>
 <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org>
 <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan>
 <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
 <20200918210050.GA2953017@rani.riverdale.lan>
 <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
 <20200918223957.GA2964553@rani.riverdale.lan>
In-Reply-To: <20200918223957.GA2964553@rani.riverdale.lan>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJ2aW5kIFNhbmthcg0KPiBTZW50OiAxOCBTZXB0ZW1iZXIgMjAyMCAyMzo0MA0KLi4N
Cj4gT3VjaCwgb2Zmc2V0b2YoKSBhbmQgc2l6ZW9mKCkgd2lsbCBnaXZlIGRpZmZlcmVudCByZXN1
bHRzIGluIHRoZQ0KPiBwcmVzZW5jZSBvZiBhbGlnbm1lbnQgcGFkZGluZy4NCj4gDQo+IGh0dHBz
Oi8vZ29kYm9sdC5vcmcvei9ycW54VEsNCj4gDQo+IEkgdGhpbmssIGdyZXBwaW5nIGF0IHJhbmRv
bSwgdGhhdCBhdCBsZWFzdCBzdHJ1Y3Qgc2NzaV92cGQgaXMgbGlrZSB0aGlzLA0KPiBzaXplIGlz
IDI0IGJ1dCBkYXRhW10gc3RhcnRzIGF0IG9mZnNldCAyMC4NCj4gDQo+IAlzdHJ1Y3Qgc2NzaV92
cGQgew0KPiAJCXN0cnVjdCByY3VfaGVhZAlyY3U7DQo+IAkJaW50CQlsZW47DQo+IAkJdW5zaWdu
ZWQgY2hhcglkYXRhW107DQo+IAl9Ow0KDQpGb3IgYW5vdGhlciBzdGFuZGFyZHMgJ2JyYWluLWZh
cnQnIGNvbnNpZGVyOg0KCXggPSBtYWxsb2Mob2Zmc2V0b2Yoc3RydWN0IHNjc2lfdnBkLCBkYXRh
W2NvdW50XSkpOw0KDQpTaW5jZSBvZmZzZXRvZigpIGlzIGRlZmluZWQgdG8gcmV0dXJuIGEgY29t
cGlsZS10aW1lIGNvbnN0YW50DQooaGkgTWljcm9zb2Z0KSB0aGlzIGlzIGlsbGVnYWwgdW5sZXNz
ICdjb3VudCcgaXMgYWxzbyBhDQpjb21waWxlLXRpbWUgY29uc3RhbnQuDQooSXQgb3VnaHQgdG8g
YmUgZGVmaW5lZCB0byBiZSBjb25zdGFudCBpZiB0aGUgZmllbGQgaXMgY29uc3RhbnQuKQ0KDQpJ
ZiBjb3VudCA8IDQgdGhlbiAqeCA9ICp5IHdpbGwgYWxzbyB3cml0ZSBwYXN0IHRoZSBlbmQgb2Yg
eC4NClN1Y2ggc3RydWN0dXJlIGFzc2lnbm1lbnRzIHNob3VsZCBiZSBjb21waWxlLXRpbWUgZXJy
b3JzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

