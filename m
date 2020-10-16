Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA164290023
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404520AbgJPIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:47:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:21463 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404494AbgJPIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:47:38 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-136-K_Wz6u3eNh-RXs0uWP6L0A-1; Fri, 16 Oct 2020 09:47:33 +0100
X-MC-Unique: K_Wz6u3eNh-RXs0uWP6L0A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 16 Oct 2020 09:47:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 16 Oct 2020 09:47:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'hpa@zytor.com'" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: RE: [PATCH v2] x86/insn, tools/x86: Fix some potential undefined
 behavior.
Thread-Topic: [PATCH v2] x86/insn, tools/x86: Fix some potential undefined
 behavior.
Thread-Index: AQHWozspACmNxqbsZUa1MzTBznNmCKmZ6SSw
Date:   Fri, 16 Oct 2020 08:47:33 +0000
Message-ID: <ba2fdf7e25f3476ca4a48b48065614f0@AcuMS.aculab.com>
References: <20201015161216.1563600-1-irogers@google.com>
 <5E711F64-A9BF-48EC-83A3-3C644D80F848@zytor.com>
In-Reply-To: <5E711F64-A9BF-48EC-83A3-3C644D80F848@zytor.com>
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

RnJvbTogaHBhQHp5dG9yLmNvbQ0KPiBTZW50OiAxNSBPY3RvYmVyIDIwMjAgMjI6MzUNCj4gPkRv
bid0IHBlcmZvcm0gdW5hbGlnbmVkIGxvYWRzIGluIF9fZ2V0X25leHQgYW5kIF9fcGVla19uYnl0
ZV9uZXh0IGFzDQo+ID50aGVzZSBhcmUgZm9ybXMgb2YgdW5kZWZpbmVkIGJlaGF2aW9yLg0KLi4u
DQo+ID4gI2RlZmluZSBfX2dldF9uZXh0KHQsIGluc24pCVwNCj4gPi0JKHsgdCByID0gKih0Kilp
bnNuLT5uZXh0X2J5dGU7IGluc24tPm5leHRfYnl0ZSArPSBzaXplb2YodCk7IHI7IH0pDQo+ID4r
CSh7IHQgcjsgbWVtY3B5KCZyLCBpbnNuLT5uZXh0X2J5dGUsIHNpemVvZih0KSk7IGluc24tPm5l
eHRfYnl0ZSArPSBzaXplb2YodCk7IHI7IH0pDQoNCkludGVyZXN0aW5nIG90aGVyIGlkZWEuDQpD
YW4geW91IGFkZCBhbiAnYWxpZ25lZCgxKScgaW50byB0aGUgJyoodCAqKScgY2FzdD8NCkkgdGhp
bmsgJyoodCBhbGlnbmVkKDEpICopJyBpcyB0aGUgcmlnaHQgY2FzdC4NCihnY2Mgc2VlbXMgdG8g
YWNjZXB0IGl0IGVpdGhlciBzaXplIG9mIHRoZSB0eXBlLikNCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

