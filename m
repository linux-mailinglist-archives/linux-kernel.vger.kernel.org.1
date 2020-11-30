Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7F2C8616
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgK3OAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:00:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:37174 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbgK3OAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:00:07 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-257-Da_tl-CCM4WJR7Sm0K_v9w-1; Mon, 30 Nov 2020 13:58:27 +0000
X-MC-Unique: Da_tl-CCM4WJR7Sm0K_v9w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 30 Nov 2020 13:58:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 30 Nov 2020 13:58:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ard Biesheuvel' <ardb@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Antony Yu <swpenim@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with
 clang
Thread-Topic: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with
 clang
Thread-Index: AQHWxwWF86gtz18fiEuAAH79g1ETlKngstAQ
Date:   Mon, 30 Nov 2020 13:58:27 +0000
Message-ID: <ca83a5acdf514169b2fde3ec12ea59fd@AcuMS.aculab.com>
References: <20201123073634.6854-1-swpenim@gmail.com>
 <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
 <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com>
 <20201130102122.GT1551@shell.armlinux.org.uk>
 <CAMj1kXHuERnB01sNrpY9w3C0ECOry7jCK=A2H0D4-_cBXbOmcw@mail.gmail.com>
In-Reply-To: <CAMj1kXHuERnB01sNrpY9w3C0ECOry7jCK=A2H0D4-_cBXbOmcw@mail.gmail.com>
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

PiBBbmQgYWN0dWFsbHksIHRoZSBzYW1lIGFwcGxpZXMgb24gQkUsIGJ1dCB0aGUgb3RoZXIgd2F5
IGFyb3VuZC4gU28gd2UNCj4gc2hvdWxkIG1hcmsgX194bCBhcyBhbiBvdXRwdXQgcmVnaXN0ZXIg
YXMgd2VsbCwgYXMgX194bCB3aWxsIGFzc3VtZQ0KPiB0aGUgcmlnaHQgdmFsdWUgZGVwZW5kaW5n
IG9uIHRoZSBlbmRpYW5uZXNzLg0KDQpXaHkgbm90IHVzZSAiK3IiIHRvIGluZGljYXRlIHRoYW4g
YW4gJ291dHB1dCcgcGFyYW1ldGVyIGlzIGFsc28NCnVzZWQgYXMgYW4gaW5wdXQuDQoNClJhdGhl
ciBjbGVhbmVyIHRoYW4gc3BlY2lmeWluZyB0aGUgc2FtZSBDIHZhcmlhYmxlIGFzIGJvdGgNCmlu
cHV0IGFuZCBvdXRwdXQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

