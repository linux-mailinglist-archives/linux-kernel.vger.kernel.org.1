Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD12A1794
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgJaNSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:18:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26487 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727322AbgJaNSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:18:37 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-PoE7hCcQP9mtq2Zn8D5T9Q-1; Sat, 31 Oct 2020 13:18:28 +0000
X-MC-Unique: PoE7hCcQP9mtq2Zn8D5T9Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 31 Oct 2020 13:18:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 31 Oct 2020 13:18:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Peter Zijlstra' <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Jesper Dangaard Brouer <brouer@redhat.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH 4/6] perf: Optimize get_recursion_context()
Thread-Topic: [PATCH 4/6] perf: Optimize get_recursion_context()
Thread-Index: AQHWrxDB+hviZpPrkUisLgNdhr09JamxnS3ggAATP3A=
Date:   Sat, 31 Oct 2020 13:18:27 +0000
Message-ID: <383bd862e8604a3096b8fcda4358726e@AcuMS.aculab.com>
References: <20201030151345.540479897@infradead.org>
 <20201030151955.187580298@infradead.org> <20201030181138.215b2b6a@carbon>
 <20201030162248.58e388f0@oasis.local.home>
 <20201030230152.GT2594@hirez.programming.kicks-ass.net>
 <6371740df7704217926315e97294a894@AcuMS.aculab.com>
In-Reply-To: <6371740df7704217926315e97294a894@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDMxIE9jdG9iZXIgMjAyMCAxMjoxMg0KPiANCi4u
Lg0KPiBUaGUgZ2NjIDcuNS4wIEkgaGF2ZSBoYW5keSBwcm9iYWJseSBnZW5lcmF0ZXMgdGhlIGJl
c3QgY29kZSBmb3I6DQo+IA0KPiB1bnNpZ25lZCBjaGFyIHFfMih1bnNpZ25lZCBpbnQgcGMpDQo+
IHsNCj4gICAgICAgICB1bnNpZ25lZCBjaGFyIHJjdHggPSAwOw0KPiANCj4gICAgICAgICByY3R4
ICs9ICEhKHBjICYgKE5NSV9NQVNLKSk7DQo+ICAgICAgICAgcmN0eCArPSAhIShwYyAmIChOTUlf
TUFTSyB8IEhBUkRJUlFfTUFTSykpOw0KPiAgICAgICAgIHJjdHggKz0gISEocGMgJiAoTk1JX01B
U0sgfCBIQVJESVJRX01BU0sgfCBTT0ZUSVJRX09GRlNFVCkpOw0KPiANCj4gICAgICAgICByZXR1
cm4gcmN0eDsNCj4gfQ0KPiANCj4gMDAwMDAwMDAwMDAwMDAwMCA8cV8yPjoNCj4gICAgMDogICBm
NyBjNyAwMCAwMCBmMCAwMCAgICAgICB0ZXN0ICAgJDB4ZjAwMDAwLCVlZGkgICAgICMgY2xvY2sg
MA0KPiAgICA2OiAgIDBmIDk1IGMwICAgICAgICAgICAgICAgIHNldG5lICAlYWwgICAgICAgICAg
ICAgICAgIyBjbG9jayAxDQo+ICAgIDk6ICAgZjcgYzcgMDAgMDAgZmYgMDAgICAgICAgdGVzdCAg
ICQweGZmMDAwMCwlZWRpICAgICAjIGNsb2NrIDANCj4gICAgZjogICAwZiA5NSBjMiAgICAgICAg
ICAgICAgICBzZXRuZSAgJWRsICAgICAgICAgICAgICAgICMgY2xvY2sgMQ0KPiAgIDEyOiAgIDAx
IGMyICAgICAgICAgICAgICAgICAgIGFkZCAgICAlZWF4LCVlZHggICAgICAgICAgIyBjbG9jayAy
DQo+ICAgMTQ6ICAgODEgZTcgMDAgMDEgZmYgMDAgICAgICAgYW5kICAgICQweGZmMDEwMCwlZWRp
DQo+ICAgMWE6ICAgMGYgOTUgYzAgICAgICAgICAgICAgICAgc2V0bmUgICVhbA0KPiAgIDFkOiAg
IDAxIGQwICAgICAgICAgICAgICAgICAgIGFkZCAgICAlZWR4LCVlYXggICAgICAgICAgIyBjbG9j
ayAzDQo+ICAgMWY6ICAgYzMgICAgICAgICAgICAgICAgICAgICAgcmV0cQ0KPiANCj4gSSBkb3Vi
dCB0aGF0IGlzIGJlYXRhYmxlLg0KDQpJIGxpZWQsIHlvdSBzaG91bGQgYmUgYWJsZSB0byBnZXQ6
DQoJdGVzdCAgICQweGZmMDAwMCwlZWRpICAgICAjIGNsb2NrIDANCglzZXRuZSAgJWFsICAgICAg
ICAgICAgICAgICMgY2xvY2sgMQ0KCXRlc3QgICAkMHhmZjAxMDAsJWVkaSAgICAgIyBjbG9jayAw
DQoJc2V0bmUgICVkbCAgICAgICAgICAgICAgICAjIGNsb2NrIDENCglhZGQgICAgJGZmZmZmMDAw
LCVlZGkNCglhZGMgICAgJWRsLCAlYWwgICAgICAgICAgICMgY2xvY2sgMg0KDQpCdXQgSSBzdXNw
ZWN0IGdldHRpbmcgaXQgZnJvbSB0aGUgY29tcGlsZXIgbWlnaHQgYmUgaGFyZCENCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

