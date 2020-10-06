Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CE284F19
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJFPh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:37:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:38611 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgJFPh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:37:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-182-jtRrFDBRMKOCrR0JP0rL5Q-1; Tue, 06 Oct 2020 16:37:24 +0100
X-MC-Unique: jtRrFDBRMKOCrR0JP0rL5Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 6 Oct 2020 16:37:24 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 6 Oct 2020 16:37:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Clifton' <nickc@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC:     "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: RE: Control Dependencies vs C Compilers
Thread-Topic: Control Dependencies vs C Compilers
Thread-Index: AQHWm9Z2gJDHxIOMJkCFRnXrafG7EamKgJsQgAAvGJKAAASM8A==
Date:   Tue, 6 Oct 2020 15:37:24 +0000
Message-ID: <1dabfd1939f348198678121f94d6c9b2@AcuMS.aculab.com>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <3dfe7daed3c44f46a6989b6513ad7bb0@AcuMS.aculab.com>
 <20201006133115.GT2628@hirez.programming.kicks-ass.net>
 <20201006142324.GB416765@rowland.harvard.edu>
 <20201006144302.GY2628@hirez.programming.kicks-ass.net>
 <47bfda8f-304e-5283-c6d6-0753037b0b2c@redhat.com>
In-Reply-To: <47bfda8f-304e-5283-c6d6-0753037b0b2c@redhat.com>
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

PiAgIE15IHN1Z2dlc3Rpb24gYXMgYW4gYWx0ZXJuYXRpdmUgaXMgdG8gdXNlIGFzc2VtYmxlciBp
bnN0ZWFkLg0KPiAgIFRoYXQgd2F5IHlvdSBjYW4gZ3VhcmFudGVlIHRoYXQgeW91IGdldCB0aGUg
aW5zdHJ1Y3Rpb25zIHlvdQ0KPiAgIHdhbnQgaW4gdGhlIG9yZGVyIHRoYXQgeW91IHdhbnQgdGhl
bS4gIEl0IHNob3VsZCBiZSBmYWlybHkNCj4gICBzdHJhaWdodGZvcndhcmQgdG8gY3JlYXRlIGEg
bWFjcm8gb3IgaW5saW5lIGZ1bmN0aW9uIHRoYXQNCj4gICBjb250YWlucyB0aGUgbmVjZXNzYXJ5
IGNvZGUgYW5kIHRoaXMgY2FuIGJlIGRvbmUgb25jZSBhbmQNCj4gICB0aGVuIHVzZWQgd2hlcmV2
ZXIgdGhlIGZ1bmN0aW9uYWxpdHkgaXMgcmVxdWlyZWQuDQoNCkMgZXhpc3RzIGJlY2F1c2UgSyZS
IGdvdCBmZWQgdXAgb2Ygd3JpdGluZyBwZHAtMTEgYXNzZW1ibGVyLg0KQ29tcGFyZWQgdG8gc29t
ZSBtb2Rlcm4gb25lcyBpdCBpcyBuaWNlIGFuZCBlYXN5IHRvIHdyaXRlDQooSSdtIG9sZCBlbm91
Z2ggdG8gaGF2ZSB1c2VkIHBkcC0xMS4pDQoNCllvdSBjYW4ndCBwdXQgY29udHJvbCBkZXBlbmRl
bmNpZXMgaW5zaWRlIEMgYXNtIHN0YXRlbWVudHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

