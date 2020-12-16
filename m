Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8230B2DBEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgLPKsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:48:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:44651 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbgLPKsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:48:10 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-67-gwAtZaUrOoSmidhCQASlBA-1; Wed, 16 Dec 2020 10:46:30 +0000
X-MC-Unique: gwAtZaUrOoSmidhCQASlBA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 16 Dec 2020 10:46:31 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 16 Dec 2020 10:46:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: New objtool warning..
Thread-Topic: New objtool warning..
Thread-Index: AQHW02c7Acg2sePkwUO0NIL6ZTUF/an5igcA
Date:   Wed, 16 Dec 2020 10:46:31 +0000
Message-ID: <6c4054c4fa3a4f6ab381411ffc9a8f01@AcuMS.aculab.com>
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
 <20201216044918.jdmi32dz75uboybv@treble>
In-Reply-To: <20201216044918.jdmi32dz75uboybv@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMTYgRGVjZW1iZXIgMjAyMCAwNDo0OQ0KPiAN
Cj4gT24gVHVlLCBEZWMgMTUsIDIwMjAgYXQgMDg6MjI6MjNQTSAtMDgwMCwgTGludXMgVG9ydmFs
ZHMgd3JvdGU6DQo+ID4gSSBvbmx5IHNlZSB0aGlzIG9uIG15IGxhcHRvcCwgYnV0IHRoYXQncyBw
cm9iYWJseSBiZWNhdXNlIG15IGRlc2t0b3ANCj4gPiBpcyBidWlsdCB1c2luZyBjbGFuZy4gU28g
aXQncyBhIGdjYyBjb2RlIGdlbmVyYXRpb24gaW50ZXJhY3Rpb24sIEkNCj4gPiBzdXNwZWN0Li4N
Cj4gPg0KPiA+IEFueXdheSwgdGhlIG5ldyB3YXJuaW5nIGlzDQo+ID4NCj4gPiAgICAgZHJpdmVy
cy9ncHUvZHJtL2RybV9lZGlkLm86IHdhcm5pbmc6IG9ianRvb2w6IGRvX2N2dF9tb2RlKCkgZmFs
bHMNCj4gPiB0aHJvdWdoIHRvIG5leHQgZnVuY3Rpb24gZHJtX21vZGVfZGV0YWlsZWQuaXNyYS4w
KCkNCj4gPg0KPiA+IGFuZCBnb29nbGluZyBhcm91bmQgYSBiaXQgSSBzZWUgdGhhdCAwZGF5IGVu
ZGVkIHVwIHJlcG9ydGluZyBpdCBvbiB0aGUNCj4gPiBsaW51eC1uZXh0IGxpc3RzLCBhbmQgYmxh
bWVzIGNvbW1pdCA5OTFmY2I3N2Y0OTAgKCJkcm0vZWRpZDogRml4DQo+ID4gdW5pbml0aWFsaXpl
ZCB2YXJpYWJsZSBpbiBkcm1fY3Z0X21vZGVzKCkiKS4NCj4gPg0KPiA+IFRoYXQgcHJlc3VtYWJs
eSB0aGVuIG1ha2VzIGdjYyBnZW5lcmF0ZSB0aGF0IG9kZCBjb2RlLg0KPiA+DQo+ID4gVGhhdCAi
dW5yZWFjaGFibGUoKSIgaXMgYmVjYXVzZSB0aGUgY29tcGlsZXIgaXNuJ3Qgc21hcnQgZW5vdWdo
IHRvIHNlZQ0KPiA+IHRoYXQgeWVzLCB0aGVyZSByZWFsbHkgYXJlIGNhc2Ugc3RhdGVtZW50cyBm
b3IgZXZlcnkgc2luZ2xlIHBvc3NpYmxlDQo+ID4gY2FzZS4gT2ggd2VsbC4gTWF5YmUgdGhlIGNv
ZGUgc2hvdWxkIGp1c3QgbWFrZSBvbmUgb2YgdGhlIHBvc3NpYmxlDQo+ID4gY2FzZXMgYWxzbyBi
ZSB0aGUgImRlZmF1bHQ6IiBjYXNlLCBhbmQgdGhhdCBtaWdodCBmaXggaXQuDQo+ID4NCj4gPiBC
dXQgbWF5YmUgdGhpcyBpcyB3b3J0aCBsb29raW5nIGludG8gZm9yIG9ianRvb2wgdG9vPw0KPiA+
DQo+ID4gQW55d2F5LCBJIHNlZSBpdCB3aXRoIGdjYy0xMC4yLjEgYXMgcGVyIGN1cnJlbnQgRjMy
LiBIb2xsZXIgaWYgeW91DQo+ID4gY2FuJ3QgcmVwcm9kdWNlIGl0LCBJIGNhbiBzZW5kIHRoZSBv
YmplY3QgZmlsZSBhcm91bmQuDQo+IA0KPiBJIGNhbid0IHJlY3JlYXRlIHdpdGggbXkgY29tcGls
ZXIsIGJ1dCBJIHRoaW5rIEkndmUgc2VlbiBvbmUgbGlrZSB0aGlzDQo+IGJlZm9yZS4gIEkgc3Vz
cGVjdCBzL3VucmVhY2hhYmxlKCkvQlVHKCkvIHdvdWxkIGZpeCBpdD8NCg0KVGhlbiBhIHNtYXJ0
KGVyKSBjb21waWxlciB3aWxsIHJlcG9ydCB0aGF0IHRoZSBCVUcoKSBpcyB1bnJlYWNoYWJsZS4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

