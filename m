Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDFA2BAAD8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgKTNLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:11:17 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52168 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgKTNLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:11:16 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-288-Y6MrcUSgPimyebEP3mYpQw-1; Fri, 20 Nov 2020 13:11:12 +0000
X-MC-Unique: Y6MrcUSgPimyebEP3mYpQw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 13:11:12 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 13:11:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Waiman Long' <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>
Subject: RE: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Thread-Topic: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Thread-Index: AQHWvqN0O6hwIV/IOUmlkB4qEdd62KnQ/N3Q
Date:   Fri, 20 Nov 2020 13:11:12 +0000
Message-ID: <5fe76531782f4a8492b341d5f381147b@AcuMS.aculab.com>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
 <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
 <ee34bc01-9fef-23ff-ada1-1ec2d39533c9@redhat.com>
In-Reply-To: <ee34bc01-9fef-23ff-ada1-1ec2d39533c9@redhat.com>
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

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMTkgTm92ZW1iZXIgMjAyMCAxODo0MA0KLi4uDQo+
IE15IG93biB0ZXN0aW5nIGFsc28gc2hvdyBub3QgdG9vIG11Y2ggcGVyZm9ybWFuY2UgZGlmZmVy
ZW5jZSB3aGVuDQo+IHJlbW92aW5nIHJlYWRlciBzcGlubmluZyBleGNlcHQgaW4gdGhlIGxpZ2h0
bHkgbG9hZGVkIGNhc2VzLg0KDQpJJ20gY29uZnVzZWQuDQoNCkkgZ290IG1hc3NpdmUgcGVyZm9y
bWFuY2UgaW1wcm92ZW1lbnRzIGZyb20gY2hhbmdpbmcgYSBkcml2ZXINCndlIGhhdmUgdG8gdXNl
IG11dGV4IGluc3RlYWQgb2YgdGhlIG9sZCBzZW1hcGhvcmVzICh0aGUgZHJpdmVyDQp3YXMgd3Jp
dHRlbiBhIGxvbmcgdGltZSBhZ28pLg0KDQpXaGlsZSB0aGVzZSB3ZXJlbid0ICdydycgdGhlIHNh
bWUgaXNzdWUgd2lsbCBhcHBseS4NCg0KVGhlIHByb2JsZW0gd2FzIHRoYXQgdGhlIHNlbWFwaG9y
ZS9tdXRleCB3YXMgdHlwaWNhbGx5IG9ubHkgaGVsZCBvdmVyDQphIGZldyBpbnN0cnVjdGlvbnMg
KGVnIHRvIGFkZCBhbiBpdGVtIHRvIGEgbGlzdCkuDQpCdXQgd2l0aCBzZW1hcGhvcmUgaWYgeW91
IGdvdCBjb250ZW50aW9uIHRoZSBwcm9jZXNzIGFsd2F5cyBzbGVwdC4NCk9UT0ggbXV0ZXggc3Bp
biAnZm9yIGEgd2hpbGUnIGJlZm9yZSBzbGVlcGluZyBzbyB0aGUgY29kZSByYXJlbHkgc2xlcHQu
DQoNClNvIEkgcmVhbGx5IGV4cGVjdCB0aGF0IHJlYWRlcnMgbmVlZCB0byBzcGluIChmb3IgYSB3
aGlsZSkgaWYNCmEgcndzZW0gKGV0YykgaXMgbG9ja2VkIGZvciB3cml0aW5nLg0KDQpDbGVhcmx5
IHlvdSByZWFsbHkgbmVlZCBhIENCVSAoQ3J5c3RhbCBCYWxsIFVuaXQpIHRvIHdvcmsgb3V0DQp3
aGV0aGVyIHRvIHNwaW4gb3Igbm90Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

