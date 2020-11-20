Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48942BA697
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgKTJwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:52:44 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35346 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgKTJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:52:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-54-k6fxjDNiMd2_mdNhwQm0xA-1; Fri, 20 Nov 2020 09:52:39 +0000
X-MC-Unique: k6fxjDNiMd2_mdNhwQm0xA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 09:52:38 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 09:52:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Zimmermann' <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <ray.huang@amd.com>, Dave Airlie <airlied@redhat.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Subject: RE: Linux 5.10-rc4; graphics alignment
Thread-Topic: Linux 5.10-rc4; graphics alignment
Thread-Index: Ada/IUdqcU2WLz13TDyBa91ssXd9zQ==
Date:   Fri, 20 Nov 2020 09:52:38 +0000
Message-ID: <2c474745ae884de3b4ecb8abe2152bfd@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBEYXZpZA0KPiANCj4gQW0gMTguMTEuMjAgdW0gMjM6MDEgc2NocmllYiBEYXZpZCBMYWln
aHQ6DQouLi4NCj4gRGlkIHlvdSB0cnkgRGFuaWVsJ3Mgc3VnZ2VzdGlvbiBvZiB0ZXN0aW5nIHdp
dGggdGhlIGRpcmVjdCBwYXJlbnQgY29tbWl0Pw0KKEkgd2FzIG9uIGhvbGlkYXkgeWVzdGVyZGF5
IGFuZCBkaWRuJ3Qgd2FudCB0byBzcGVuZCBhIHN1bm55DQphZnRlcm5vb24gZG9pbmcgYmlzZWN0
cy4pDQoNCkkndmUganVzdCBkb25lIHRoYXQgYW5kIGl0IGlzIGJhZC4NCg0KSXMgdGhlcmUgYW55
IHdheSB0byBiaXNlY3QgdGhyb3VnaCB0aGUgcGFydHMgb2YgdGhlDQpkcm0gbWVyZ2UgcGF0Y2gg
aW50byB2NS4xMC1yYzEgPw0KDQpUaGF0IG91Z2h0IHRvIGJlIHF1aWNrZXIgKGFuZCBsZXNzIGVy
cm9yIHByb25lKSB0aGFuDQp0aGUgYmlzZWN0IGJ1aWxkcyBJIHdhcyBkb2luZy4NCg0KTm90ZSB0
aGF0IHRoZSBzdGFjayAnc3BsYXQnIGlzIGR1ZSB0byBhIGxhdGVyIGNoYW5nZS4NCkl0IGlzIHNl
cGFyYXRlIGZyb20gdGhlIGJyb2tlbiBwaXhlbCBhbGlnbm1lbnQuDQoNCkkgYWN0dWFsbHkgc2F3
IHRoZSB2Z2EgdGV4dCBnbyAnZnVubnknIHdoaWxlIHRoZSBib290DQp3YXMgb3V0cHV0dGluZyBh
bGwgdGhlIFtPS10gbWVzc2FnZXMgKGZyb20gc3lzdGVtZD8pDQpiZWZvcmUgdGhlIGdyYXBoaWMg
bG9naW4gc3RvbGUgdHR5MSAoYmxvb2R5IHN0dXBpZA0KdG8gdXNlIHR0eTEpLg0KDQpJIGRvbid0
IG5lZWQgdG8gdXNlIHRoZSBmYWlsaW5nIHN5c3RlbSB0b2RheSwgSSdsbA0KaGF2ZSBhbm90aGVy
IGdvIGF0IGlzb2xhdGluZyB0aGUgZmFpbHVyZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

