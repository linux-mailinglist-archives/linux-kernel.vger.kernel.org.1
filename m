Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4E2BB18E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgKTRhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:37:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:57497 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727880AbgKTRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:37:35 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-253-8k7sJ26IO2eyg2tdgB7Pvg-1; Fri, 20 Nov 2020 17:37:31 +0000
X-MC-Unique: 8k7sJ26IO2eyg2tdgB7Pvg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 17:37:30 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 17:37:30 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Waiman Long' <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>
Subject: RE: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Thread-Topic: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Thread-Index: AQHWvqN0O6hwIV/IOUmlkB4qEdd62KnQ/N3QgABEQACAAAOhsA==
Date:   Fri, 20 Nov 2020 17:37:30 +0000
Message-ID: <8e25d29ffee64b8ab377fd5ebf1c6bb2@AcuMS.aculab.com>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
 <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
 <ee34bc01-9fef-23ff-ada1-1ec2d39533c9@redhat.com>
 <5fe76531782f4a8492b341d5f381147b@AcuMS.aculab.com>
 <68d07068-ff31-26b5-f90d-7ea8b4ee2389@redhat.com>
In-Reply-To: <68d07068-ff31-26b5-f90d-7ea8b4ee2389@redhat.com>
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

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMjAgTm92ZW1iZXIgMjAyMCAxNzowNA0KPiANCj4g
T24gMTEvMjAvMjAgODoxMSBBTSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZyb206IFdhaW1h
biBMb25nDQo+ID4+IFNlbnQ6IDE5IE5vdmVtYmVyIDIwMjAgMTg6NDANCj4gPiAuLi4NCj4gPj4g
TXkgb3duIHRlc3RpbmcgYWxzbyBzaG93IG5vdCB0b28gbXVjaCBwZXJmb3JtYW5jZSBkaWZmZXJl
bmNlIHdoZW4NCj4gPj4gcmVtb3ZpbmcgcmVhZGVyIHNwaW5uaW5nIGV4Y2VwdCBpbiB0aGUgbGln
aHRseSBsb2FkZWQgY2FzZXMuDQo+ID4gSSdtIGNvbmZ1c2VkLg0KPiA+DQo+ID4gSSBnb3QgbWFz
c2l2ZSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMgZnJvbSBjaGFuZ2luZyBhIGRyaXZlcg0KPiA+
IHdlIGhhdmUgdG8gdXNlIG11dGV4IGluc3RlYWQgb2YgdGhlIG9sZCBzZW1hcGhvcmVzICh0aGUg
ZHJpdmVyDQo+ID4gd2FzIHdyaXR0ZW4gYSBsb25nIHRpbWUgYWdvKS4NCj4gPg0KPiA+IFdoaWxl
IHRoZXNlIHdlcmVuJ3QgJ3J3JyB0aGUgc2FtZSBpc3N1ZSB3aWxsIGFwcGx5Lg0KPiA+DQo+ID4g
VGhlIHByb2JsZW0gd2FzIHRoYXQgdGhlIHNlbWFwaG9yZS9tdXRleCB3YXMgdHlwaWNhbGx5IG9u
bHkgaGVsZCBvdmVyDQo+ID4gYSBmZXcgaW5zdHJ1Y3Rpb25zIChlZyB0byBhZGQgYW4gaXRlbSB0
byBhIGxpc3QpLg0KPiA+IEJ1dCB3aXRoIHNlbWFwaG9yZSBpZiB5b3UgZ290IGNvbnRlbnRpb24g
dGhlIHByb2Nlc3MgYWx3YXlzIHNsZXB0Lg0KPiA+IE9UT0ggbXV0ZXggc3BpbiAnZm9yIGEgd2hp
bGUnIGJlZm9yZSBzbGVlcGluZyBzbyB0aGUgY29kZSByYXJlbHkgc2xlcHQuDQo+ID4NCj4gPiBT
byBJIHJlYWxseSBleHBlY3QgdGhhdCByZWFkZXJzIG5lZWQgdG8gc3BpbiAoZm9yIGEgd2hpbGUp
IGlmDQo+ID4gYSByd3NlbSAoZXRjKSBpcyBsb2NrZWQgZm9yIHdyaXRpbmcuDQo+ID4NCj4gPiBD
bGVhcmx5IHlvdSByZWFsbHkgbmVlZCBhIENCVSAoQ3J5c3RhbCBCYWxsIFVuaXQpIHRvIHdvcmsg
b3V0DQo+ID4gd2hldGhlciB0byBzcGluIG9yIG5vdC4NCj4gDQo+IFRoYXQgaXMgdGhlIGhhcmQg
cGFydC4gRm9yIHNob3J0IGNyaXRpY2FsIHNlY3Rpb24gYW5kIG5vdCBtYW55IHJlYWRlcnMNCj4g
YXJvdW5kLCBtYWtpbmcgdGhlIHJlYWRlcnMgc3BpbiB3aWxsIGxpa2VseSBpbXByb3ZlIHBlcmZv
cm1hbmNlLiBPbiB0aGUNCj4gb3RoZXIgaGFuZCwgaWYgdGhlIGNyaXRpY2FsIHNlY3Rpb24gaXMg
bG9uZyB3aXRoIG1hbnkgcmVhZGVycywgbWFrZQ0KPiByZWFkZXJzIHNsZWVwIGFuZCB0aGVuIHdh
a2UgdGhlbSBhbGwgdXAgYXQgb25jZSBjYW4gaGF2ZSBiZXR0ZXINCj4gcGVyZm9ybWFuY2UuIFRo
ZXJlIGlzIG5vIG9uZS1zaXplLWZpdC1hbGwgc29sdXRpb24gaGVyZS4NCg0KRG8gdGhlIHJlYWRl
cnMgYWN0dWFsbHkgYWxsIHdha2UgdXAgYXQgdGhlIHNhbWUgdGltZT8NCnJ3c2VtIG1pZ2h0IGJl
IHNwZWNpYWwsIGJ1dCBpZiBJIGN2X2Jyb2FkY2FzdCBhIHVzZXJzcGFjZSBjdg0KdGhlbiBvbmx5
IG9uZSB0aHJlYWQgaXMgd29rZW4uDQpPbmNlIGl0IHJ1bnMgdGhlIG5leHQgb25lIGlzIHdva2Vu
Lg0KVGhpcyBpcyBob3JyaWQgaWYgeW91IGFjdHVhbGx5IHdhbnQgdGhlbSBhbGwgdG8gcnVuOg0K
LSBJdCB0YWtlcyBhZ2VzIGZvciB0aGUgdGFyZ2V0IGNwdSB0byBjb21lIG91dCBvZiBhIGxvdy1w
b3dlciBzdGF0ZS4NCi0gUlQgcHJvY2Vzc2VzIGRvbid0IGdldCBzY2hlZHVsZWQgaWYgdGhlIGNw
dSB0aGV5IGxhc3QgcmFuIG9uIGlzDQogICdidXN5JyBpbiBrZXJuZWwuDQoNCkkgY2FuJ3Qgc2Vl
IHdoeSB0aGUgbnVtYmVyIG9mIHJlYWRlcnMgaXMgcmVsZXZhbnQuDQpUaGV5IGFyZSBtb3JlIGxp
a2VseSB0byBzdGFydCBpbiAnbG9ja3N0ZXAnIGlmIHRoZXkgc3Bpbi4NCihXaGljaCBJIHRoaW5r
IGlzIHdoYXQgeW91IHNheSBpcyBiZXN0KS4NCg0KWW91IG1heSB3YW50IHBlci1yd3NlbSBvcHRp
b24gb2YgaG93IGxvbmcgdG8gc3Bpbi4NCkFsdGhvdWdoIHRoZXJlIGFyZSBwcm9iYWJseSBvbmx5
IDIgdXNlZnVsIHZhbHVlcyAtIDAgYW5kIGxvdHMuDQoNCkFyZSB0aGVyZSBydyBzcGlubG9ja3M/
DQpUaGV5IGNhbiBiZSBtdWNoIGJldHRlciBpcyB0aGUgY3JpdGljYWwgc2VjdGlvbnMgYXJlIHNo
b3J0Lg0KRXNwZWNpYWxseSBpZiB0aGV5IHJlYWxseSBhcmUgc2hvcnQgYW5kIFJUIGtlcm5lbHMg
ZG9uJ3QNCmJyZWFrIGV2ZXJ5dGhpbmcgbXkgbWFraW5nIHRoZSBzbGVlcC4NCg0KSSB3YXMgZml4
aW5nIHNvbWUgdXNlcnNwYWNlIGNvZGUgdGhhdCBkb2VzIGEgbG90IG9mIGNoYW5uZWxzIG9mDQph
dWRpbyBwcm9jZXNzaW5nLg0KWW91IGNhbid0IGFmZm9yZCB0byB0YWtlIGEgbXV0ZXggYmVjYXVz
ZSBhbiBpbnRlcnJ1cHQgbWlnaHQNCmNvbWUgaW4gd2hpbGUgeW91IGhvbGQgaXQgLSBzdG9wcGlu
ZyBhbGwgdGhlIG90aGVyIHRocmVhZHMNCm9idGFpbmluZyB0aGUgc2FtZSBtdXRleC4NCk9uZSB0
aHJlYWQgc3RvcHBpbmcgaXMgZmluZSwgYnV0IGhhdmluZyBhbGwgdGhlIHRocmVhZHMgc3RvcA0K
bGVhZHMgdG8gcHJvY2Vzc2luZyBvdmVycnVuLg0KU2luY2UgeW91IGNhbid0IGRpc2FibGUgaW50
ZXJydXB0cyBpbiB1c2Vyc3BhY2UgKGZvciBhIHNwaW5sb2NrKQ0KSSBoYWQgdG8gcmVwbGFjZSBs
b2NrZWQgbGlua2VkIGxpc3RzIHdpdGggYXJyYXlzIGluZGV4ZWQgYnkNCmF0b21pYyBjb3VudGVy
cy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

