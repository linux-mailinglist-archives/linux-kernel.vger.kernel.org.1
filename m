Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF02FE735
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbhAUKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:11:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:25266 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728866AbhAUKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:10:12 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-189-BXRXaqkPN2KtFxGAXuKLPQ-1; Thu, 21 Jan 2021 10:08:33 +0000
X-MC-Unique: BXRXaqkPN2KtFxGAXuKLPQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 21 Jan 2021 10:08:31 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 21 Jan 2021 10:08:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: Splicing to/from a tty
Thread-Topic: Splicing to/from a tty
Thread-Index: AQHW75FXm/V94rBWlE2o2nAONgRsB6ox2eiQ
Date:   Thu, 21 Jan 2021 10:08:30 +0000
Message-ID: <5ce6fe95ee9c4e0f9699a8dc48ec7eab@AcuMS.aculab.com>
References: <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca> <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca>
 <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
 <20210120231439.GE740243@zeniv-ca>
 <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
 <20210121003835.GF740243@zeniv-ca>
 <CAHk-=whWGwcZXpqDFv-j2fcChtT1jE0ZMFCmQHp3BrSkp+XZ6A@mail.gmail.com>
In-Reply-To: <CAHk-=whWGwcZXpqDFv-j2fcChtT1jE0ZMFCmQHp3BrSkp+XZ6A@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjEgSmFudWFyeSAyMDIxIDAxOjA0DQo+IE9u
IFdlZCwgSmFuIDIwLCAyMDIxIGF0IDQ6MzggUE0gQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5v
cmcudWs+IHdyb3RlOg0KPiA+DQo+ID4gT0suLi4gIEkgd29uZGVyIGhvdyBtYW55IGRlYnVnZnMg
d3JpdGFibGUgZmlsZXMgYWxsb3cgcHdyaXRlKCkgd2l0aA0KPiA+IEJTIHJlc3VsdHMuLi4NCj4g
DQo+IEkgaG9wZSBzb21lIG9mIHRoZW0gY2hlY2sgZm9yICJwb3MgPT0gMCIgd2hlbiB0aGV5IHN0
YXJ0IHBhcnNpbmcgaW50ZWdlcnMuDQo+IA0KPiBCdXQgaG9uZXN0bHksIEkgZG9uJ3QgdGhpbmsg
aXQncyBhIGJpZyBkZWFsLiBXZSd2ZSBoYWQgdGhlc2UgdGhpbmdzDQo+IHRoYXQganVzdCBiYXNp
Y2FsbHkgYXNzdW1lIHRoYXQgd2hlbmV2ZXIgeW91IHdyaXRlLCB0aGUgb2Zmc2V0IGp1c3QNCj4g
ZG9lc24ndCBtYXR0ZXIgYXQgYWxsLCBhbmQgYXMgbG9uZyBhcyBzb21lIG51bWJlciBjb21lcyBp
biBvbmUgc2luZ2xlDQo+IHdyaXRlIGNhbGwsIHdlIGFjY2VwdCBpdC4NCj4gDQo+IEJlY2F1c2Ug
ZXZlbiBpZiB5b3UgZW5kIHVwIGRvaW5nIHNvbWV0aGluZyBsaWtlIGp1c3QNCj4gDQo+ICAgIGVj
aG8gJFNPTUVUSElORyA+IC9zeXMveHl6L2FiYw0KPiANCj4gYW5kIHRoYXQgIiRTT01FVEhJTkci
IGNvdWxkIGJlIGRvbmUgbXVsdGlwbGUgd3JpdGVzLCBpbiBwcmFjdGljZSBpdA0KPiBhbGwgd29y
a3Mgb3V0IGp1c3QgZmluZSBhbmQgaXQgbmV2ZXIgcmVhbGx5IGlzLiBZb3UgYWxtb3N0IGhhdmUg
dG8gdHJ5DQo+IHRvIHNjcmV3IHVwIHdpdGggc29tZXRoaW5nIGxpa2UNCj4gDQo+ICAgKGVjaG8g
LW4gMzsgZWNobyAtbiA0KSA+IC9zeXMveHl6L2FiYw0KPiANCj4gdG8gYWN0dWFsbHkgc2VlIHR3
byB3cml0ZXMgb2YgIjMiIGFuZCAiNCIgaW5zdGVhZCBvZiBvbmUgd3JpdGUgd2l0aA0KPiAiMzQi
LiBBbmQgaG9uZXN0bHksIGlmIHNvbWVib2R5IGRvZXMgc29tZXRoaW5nIGxpa2UgdGhhdCwgZG8g
d2UgcmVhbGx5DQo+IGNhcmU/IFRoZXkgbWlnaHQgZ2V0IDMsIHRoZXkgbWlnaHQgZ2V0IDQsIGFu
ZCB0aGV5IG1pZ2h0IGdldCAzNC4gVGhleQ0KPiBnZXQgd2hhdCB0aGV5IGRlc2VydmUuDQoNCk9y
IHdvcnNlOg0KCWVjaG8gYWJjID4vc3lzL3h5ei9hYmMNCgllY2hvIHggfCBkZCBicz0xIGNvdW50
PTIgb3NlZWs9MSBjb252PW5vdHJ1bmMgb2Y9L3N5cy94eXovYWJjDQp3aGljaCAoaWYgSSBnb3Qg
dGhlIGRkIGNvbW1hbmQgcmlnaHQpIHdvdWxkIGdlbmVyYXRlICJheGMiIG9uIGEgcmVhbCBmaWxl
Lg0KDQpPVE9IIG11bHRpcGxlIHNob3J0IHJlYWRzIGFyZSBxdWl0ZSBsaWtlbHkuDQpCZXN0IG5v
dCBkb25lIG9uIGEgY291bnRlci4uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

