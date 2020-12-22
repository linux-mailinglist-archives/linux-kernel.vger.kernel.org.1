Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35B2E07F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLVJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:21:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:28169 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLVJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:21:52 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-38-Z7fxBD-GO2SfkPVjEoYDtg-1; Tue, 22 Dec 2020 09:20:13 +0000
X-MC-Unique: Z7fxBD-GO2SfkPVjEoYDtg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 22 Dec 2020 09:20:12 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 22 Dec 2020 09:20:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Song Bao Hua (Barry Song)'" <song.bao.hua@hisilicon.com>,
        Shakeel Butt <shakeelb@google.com>
CC:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Topic: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Index: AQHW1mZAeBjE5clI7UKUuMSOCQsyuqoBSTyAgAAghwCAAAhXgIAAhndA//+NyICAAIW5IP//l0EAgACHqyCAAK0zQA==
Date:   Tue, 22 Dec 2020 09:20:12 +0000
Message-ID: <0777a34e3e9246fe83e693ba07405d28@AcuMS.aculab.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com>
 <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
 <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
 <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com>
 <CALvZod7EZnEWb_65FjSNdx+-S_4pLHyS5rYiU-D3hFLRMXS6Lw@mail.gmail.com>
 <8cc0e01fd03245a4994f2e0f54b264fa@hisilicon.com>
 <CALvZod7rj4X3M5o5agCzzSKkuLhb8z0Q+41sqNN2bcJLa=z5vA@mail.gmail.com>
 <8f17abe06057498dba9413f706b86207@hisilicon.com>
In-Reply-To: <8f17abe06057498dba9413f706b86207@hisilicon.com>
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

RnJvbTogU29uZyBCYW8gSHVhDQo+IFNlbnQ6IDIxIERlY2VtYmVyIDIwMjAgMjM6MDINCi4uLg0K
PiA+IEZvciBkZWNvbXByZXNzaW9uLCBJIHdvdWxkIGxpa2UgYXMgbG93IGxhdGVuY3kgYXMgcG9z
c2libGUgd2hpY2ggSQ0KPiA+IHRoaW5rIGlzIG9ubHkgcG9zc2libGUgYnkgZG9pbmcgZGVjb21w
cmVzc2lvbiBvbiBhIGNwdSBzeW5jaHJvbm91c2x5Lg0KPiANCj4gT25lIHBvc3NpYmlsaXR5IGlz
IHRoYXQgd2UgY2hhbmdlIEhXIGFjY2VsZXJhdG9yIGRyaXZlciB0byBiZSBzeW5jDQo+IHBvbGxp
bmcgZm9yIGRlY29tcHJlc3Npb24uIEJ1dCB0aGlzIHN0aWxsIGRlcGVuZHMgb24gYXN5bmMgYXBp
IGFzDQo+IHRoaXMgaXMgdGhlIGZyYW1ld29yayBub3dhZGF5cywgdGhlIGRpZmZlcmVuY2Ugd291
bGQgYmUgdGhlIGRyaXZlcg0KPiB3b24ndCByZWFsbHkgYmxvY2suIGNyeXB0b193YWl0X3JlcSgp
IHdpbGwgcmV0dXJuIHdpdGhvdXQgYWN0dWFsDQo+IHNsZWVwLg0KDQpIb3cgbG9uZyBkb2VzIHRo
ZSBIVyBhY2NlbGVyYXRlZCBjb21wcmVzcy9kZWNvbXByZXNzIG5lZWQgdG8gYmUgYmVmb3JlDQpp
dCBpcyBhY3R1YWxseSB3b3J0aCBzbGVlcGluZyB0aGUgcHJvY2Vzcz8NCldoaWxlIHRoZSBIVyB2
ZXJzaW9uIG1pZ2h0IGJlIGZhc3RlciB0aGFuIHRoZSBTVyBvbmUsIGl0IG1heSBub3QgYmUNCmVu
b3VnaCBmYXN0ZXIgdG8gYWxsb3cgZm9yIHRoZSBoYXJkd2FyZSBpbnRlcnJ1cHQgYW5kIHByb2Nl
c3Mgc2xlZXAuDQpTbyBpdCBtYXkgYmUgd29ydGgganVzdCBzcGlubmluZyAocG9sbGluZyB0aGUg
aGFyZHdhcmUgcmVnaXN0ZXIpDQp1bnRpbCB0aGUgcmVxdWVzdCBjb21wbGV0ZXMuDQoNCklmIGRl
Y29tcHJlc3MgYXJlIGRvbmUgdGhhdCB3YXksIGJ1dCBjb21wcmVzcyBsZWZ0IGFzeW5jLCB0aGVu
DQp0aGUgZGVjb21wcmVzcyBtaWdodCBuZWVkIHRvIGZhbGxiYWNrIHRvIFNXIGlmIHRoZSBIVyBp
cyBidXN5Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

