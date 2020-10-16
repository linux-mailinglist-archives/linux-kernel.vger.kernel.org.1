Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7397F28FFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404996AbgJPINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:13:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41618 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404939AbgJPINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:13:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-25-NRrZ346XOLelYSsRdn014w-1; Fri, 16 Oct 2020 09:13:45 +0100
X-MC-Unique: NRrZ346XOLelYSsRdn014w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 16 Oct 2020 09:13:44 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 16 Oct 2020 09:13:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Nathan Chancellor" <natechancellor@gmail.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] compiler.h: Clarify comment about the need for
 barrier_data()
Thread-Topic: [PATCH] compiler.h: Clarify comment about the need for
 barrier_data()
Thread-Index: AQHWox7rJ5hC7vlNqk+GpAb0LFktmKmZJEvQgAACJICAALXFQA==
Date:   Fri, 16 Oct 2020 08:13:44 +0000
Message-ID: <407e91d1d36d48faa8bbdfe4f51033ad@AcuMS.aculab.com>
References: <CAKwvOdkLvxeYeBh7Kx0gw7JPktPH8A4DomJTidUqA0jRQTR0FA@mail.gmail.com>
 <20201015181340.653004-1-nivedita@alum.mit.edu>
 <72958fd25e33490181b0df9413ec08b4@AcuMS.aculab.com>
 <20201015220123.GA919128@rani.riverdale.lan>
In-Reply-To: <20201015220123.GA919128@rani.riverdale.lan>
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

RnJvbTogQXJ2aW5kIFNhbmthcg0KPiBTZW50OiAxNSBPY3RvYmVyIDIwMjAgMjM6MDENCiwsLA0K
PiBJIHRoaW5rIGl0J3MgaGVscGZ1bCB0byBoYXZlIHRoZSBtb3JlIGRldGFpbGVkIGV4cGxhbmF0
aW9uIGFib3V0DQo+IHJlZ2lzdGVyIHZhcmlhYmxlcyAtLSBhdCBmaXJzdCBnbGFuY2UsIGl0J3Mg
YSBiaXQgbXlzdGlmeWluZyBhcyB0byB3aHkNCj4gdGhlIGNvbXBpbGVyIHdvdWxkIHRoaW5rIHRo
YXQgdGhlIGFzbSBjYW4ndCBhY2Nlc3MgdGhlIHN0YWNrLiBTcGlsbGluZw0KPiByZWdpc3RlcnMg
dG8gdGhlIHN0YWNrIGlzIGFjdHVhbGx5IGFuIHVuZGVzaXJhYmxlIHNpZGUtZWZmZWN0IG9mIHRo
ZQ0KPiB3b3JrYXJvdW5kLg0KDQpUaGF0IGlzIHRoZSB2ZXJ5IGJpdCB0aGF0IGp1c3QgY29uZnVz
ZXMgdGhpbmdzLg0KVGhlIGRhdGEgdGhlIG1lbXplcm9fZXhwbGljdGl0KCkgaXMgdHJ5aW5nIHRv
IGNsZWFyIGlzIChwcm9iYWJseSkNCm9uLXN0YWNrIGFscmVhZHkgLSBpdCB3b24ndCBiZSBpbiBy
ZWdpc3RlcnMuDQoNCklmIGl0IHdlcmUgaW4gcmVnaXN0ZXJzIHlvdSB3b3VsZG4ndCBuZWVkIHRo
ZSBtZW1zZXQoKS4NCg0KQWN0dWFsbHkgSSBzdXNwZWN0IHRoYXQgdGhlIG1lbXNldCgpIGlzIGlu
bGluZWQgc28gdGhhdCBpcw0KanVzdCBhc3NpZ25zIHplcm9zIHRvIGFsbCB0aGUgdmFyaWFibGVz
Lg0KVGhpcyB3aWxsIGJlIGRvbmUgdXNpbmcgJ3ZpcnR1YWwgcmVnaXN0ZXJzJyB0aGF0IGNhY2hl
IHRoZQ0Kb24tc3RhY2sgdmFsdWUuDQpZb3UgdGhlbiBuZWVkIHRvIGRvIHNvbWV0aGluZyB0byBm
b3JjZSB0aGUgaW5zdHJ1Y3Rpb25zIHRvIGZsdXNoDQp0aGUgJ3ZpcnR1YWwgcmVnaXN0ZXJzJyBi
YWNrIHRvIHN0YWNrIHRvIGJlIGdlbmVyYXRlZC4NCg0KVGhlIGZ1bmRhbWVudGFsIHRoaW5nIGlz
IHRoYXQgdGhlIGFkZHJlc3Mgb2YgYSBsb2NhbCAoYXV0byEpDQp2YXJpYWJsZSBtdXN0IGJlIHZp
c2libGUgdG8gdGhlIGFzbSBzdGF0ZW1lbnQgZm9yIHRoZSBjb21waWxlcg0KdG8gbWFrZSB0aGUg
Y29udGVudHMgb2YgdGhvc2UgdmFyaWFibGVzIHZpc2libGUuDQoNCkkgZXZlbiBzdXNwZWN0IHlv
dSBtYXkgbmVlZCB0byBwYXNzIHRoZSBhZGRyZXNzIG9mIHRoZSBzdHJ1Y3R1cmUNCih0byBiZSB6
ZXJvZWQpIHRvIGFuIGFzbSBibG9jayBhdCB0aGUgdG9wIG9mIHRoZSBmdW5jdGlvbiBhcyB3ZWxs
Lg0KT3RoZXJ3aXNlIHRoZSBjb21waWxlciBjb3VsZCBjaGFuZ2UgdGhlIHN0YWNrIG9mZnNldHMg
d2hlcmUgdGhlDQpzdHJ1Y3R1cmUgaXMgc3RvcmVkLg0KQnV0IEkgZG9uJ3QgdGhpbmsgY29tcGls
ZXJzIGRvIHRoYXQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

