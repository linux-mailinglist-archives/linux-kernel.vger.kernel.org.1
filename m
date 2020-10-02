Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BAE281D87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgJBVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:19:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49799 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgJBVTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:19:41 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-229-gAtM1axnPm2Psj0YYeljMw-1; Fri, 02 Oct 2020 22:19:33 +0100
X-MC-Unique: gAtM1axnPm2Psj0YYeljMw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 2 Oct 2020 22:19:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 2 Oct 2020 22:19:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Hildenbrand' <david@redhat.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: optionally disable brk()
Thread-Topic: [PATCH] mm: optionally disable brk()
Thread-Index: AQHWmOTMTpq5FewPDUy63nD4f9riL6mE0PCg
Date:   Fri, 2 Oct 2020 21:19:33 +0000
Message-ID: <a6d03b97f74543ef8203c53b2c028fef@AcuMS.aculab.com>
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
In-Reply-To: <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
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

RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQNCj4gU2VudDogMDIgT2N0b2JlciAyMDIwIDE4OjUyDQo+
IA0KPiBPbiAwMi4xMC4yMCAxOToxOSwgVG9waSBNaWV0dGluZW4gd3JvdGU6DQo+ID4gVGhlIGJy
aygpIHN5c3RlbSBjYWxsIGFsbG93cyB0byBjaGFuZ2UgZGF0YSBzZWdtZW50IHNpemUgKGhlYXAp
LiBUaGlzDQo+ID4gaXMgbWFpbmx5IHVzZWQgYnkgZ2xpYmMgZm9yIG1lbW9yeSBhbGxvY2F0aW9u
LCBidXQgaXQgY2FuIHVzZSBtbWFwKCkNCj4gPiBhbmQgdGhhdCByZXN1bHRzIGluIG1vcmUgcmFu
ZG9taXplZCBtZW1vcnkgbWFwcGluZ3Mgc2luY2UgdGhlIGhlYXAgaXMNCj4gPiBhbHdheXMgbG9j
YXRlZCBhdCBmaXhlZCBvZmZzZXQgdG8gcHJvZ3JhbSB3aGlsZSBtbWFwKCllZCBtZW1vcnkgaXMN
Cj4gPiByYW5kb21pemVkLg0KPiANCj4gV2FudCB0byB0YWtlIG1vcmUgVW5peCBvdXQgb2YgTGlu
dXg/DQo+IA0KPiBIb25lc3RseSwgd2h5IGNhcmUgYWJvdXQgZGlzYWJsaW5nPyBVc2VyIHNwYWNl
IGNhbiBoYXBwaWx5IHVzZSBtbWFwKCkgaWYNCj4gaXQgcHJlZmVycy4NCg0KSSBiZXQgc29tZSBv
YnNjdXJlIGFwcGxpY2F0aW9ucyByZWx5IG9uIGl0Lg0KDQpBbHRob3VnaCBob3BlZnVsbHkgbm90
aGluZyBzdGlsbCBkb2VzIGhlYXAgYWxsb2NhdGlvbg0KYnkganVzdCBpbmNyZWFzaW5nIHRoZSBW
QSBhbmQgY2FsbGluZyBicmsoKSBpbiByZXNwb25zZQ0KdG8gU0lHU0VHVi4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

