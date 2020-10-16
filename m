Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7987D28FFED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390657AbgJPIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:24:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:31779 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390417AbgJPIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:24:43 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-273-i6wHZgkwOuCyd54uBSAOqg-1; Fri, 16 Oct 2020 09:24:39 +0100
X-MC-Unique: i6wHZgkwOuCyd54uBSAOqg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 16 Oct 2020 09:24:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 16 Oct 2020 09:24:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ian Rogers' <irogers@google.com>, "hpa@zytor.com" <hpa@zytor.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: RE: [PATCH v2] x86/insn, tools/x86: Fix some potential undefined
 behavior.
Thread-Topic: [PATCH v2] x86/insn, tools/x86: Fix some potential undefined
 behavior.
Thread-Index: AQHWozzR0vhHSt8IyUOTNiEuTh8IJamZ40Kw
Date:   Fri, 16 Oct 2020 08:24:38 +0000
Message-ID: <699073ad09bf4882861003a5da6d6b3c@AcuMS.aculab.com>
References: <20201015161216.1563600-1-irogers@google.com>
 <5E711F64-A9BF-48EC-83A3-3C644D80F848@zytor.com>
 <CAP-5=fXRBLwui9wdDvqrB0p4TaWVSth4cuH+2TwXTq5TtgL_NQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXRBLwui9wdDvqrB0p4TaWVSth4cuH+2TwXTq5TtgL_NQ@mail.gmail.com>
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

RnJvbTogSWFuIFJvZ2Vycw0KPiBTZW50OiAxNSBPY3RvYmVyIDIwMjAgMjI6NDcNCi4uLg0KPiBU
aGUgZGVjb2RlciBpcyBhIHNoYXJlZCBjb2RlIGFuZCB1c2luZyB1bmFsaWduZWQgbWFjcm9zIG1h
a2VzIGxpZmUNCj4gaGFyZCBmb3IgdGhlIG90aGVyIHVzZXJzIG9mIHRoZSBjb2RlLiBNZW1jcHkg
aXMgdGhlICJzdGFuZGFyZCINCj4gd29ya2Fyb3VuZCBmb3IgdGhpcyBraW5kIG9mIHVuZGVmaW5l
ZCBiZWhhdmlvci4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9lNDI2OWNiMi1kOGU2
LWRhMjYtNmFmZC1hOWRmNzJkNGJlMzZAaW50ZWwuY29tLw0KDQpZb3UgY2FuJ3QgYWx3YXlzIHVz
ZSBtZW1jcHkoKSB0byBjb3B5IHVuYWxpZ25lZCBkYXRhLg0KSWYgdGhlIGNvbXBpbGVyIGNhbiBm
aW5kIGFueSByZWFzb24gd2h5IHRoZSBtaXNhbGlnbmVkIGFkZHJlc3MNCnNob3VsZCBiZSBhbGln
bmVkIChlZyBiZWNhdXNlIGl0J3MgdHlwZSBwcmlvciB0byBzb21lIGNhc3RzDQpyZXF1aXJlcyBh
bGlnbm1lbnQpIGl0IHdpbGwgdXNlIHdvcmQtc2l6ZWQgYWNjZXNzZXMgdGhhdCB3aWxsIGZhdWx0
Lg0KDQpOb3cgaW4gdGhpcyBzcGVjaWZpYyBjb2RlIHRoZSBwb2ludGVycyBhcmUgcHJvYmFibHkg
YWxsICdjaGFyIConDQpzbyBoYXZlIGFsaWdubWVudCAxIC0gc28gbWVtY3B5KCkgd2lsbCBEVFJU
Lg0KDQpCdXQgaXQgbWF5IGdlbmVyYXRlIGFuIGV4cGVuc2l2ZSBmdW5jdGlvbiBjYWxsLg0KDQpU
aGVyZSBhcmUgJ3JlYWQgdW5hbGlnbmVkIDMyYml0JyAoZXRjKSBtYWNyb3Mgb3V0IHRoZXJlLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

