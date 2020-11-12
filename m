Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB8F2B01E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKLJS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:18:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42017 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgKLJS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:18:26 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-158-m1HELxZiPqWeLTpHkzyMew-1; Thu, 12 Nov 2020 09:18:22 +0000
X-MC-Unique: m1HELxZiPqWeLTpHkzyMew-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Nov 2020 09:18:21 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Nov 2020 09:18:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [for-next][PATCH 12/17] fgraph: Make overruns 4 bytes in graph
 stack structure
Thread-Topic: [for-next][PATCH 12/17] fgraph: Make overruns 4 bytes in graph
 stack structure
Thread-Index: AQHWuJR2c5B6TfjjKUaXE5SkSnLH0KnEN84Q
Date:   Thu, 12 Nov 2020 09:18:21 +0000
Message-ID: <aabe0dd1fd7b46aaaadb2b34912b6718@AcuMS.aculab.com>
References: <20201112003244.764326960@goodmis.org>
 <20201112003334.906341178@goodmis.org>
In-Reply-To: <20201112003334.906341178@goodmis.org>
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

RnJvbTogU3RldmVuIFJvc3RlZHQNCj4gU2VudDogMTIgTm92ZW1iZXIgMjAyMCAwMDozMw0KPiAN
Cj4gSW5zcGVjdGluZyB0aGUgZGF0YSBzdHJ1Y3R1cmVzIG9mIHRoZSBmdW5jdGlvbiBncmFwaCB0
cmFjZXIsIEkgZm91bmQgdGhhdA0KPiB0aGUgb3ZlcnJ1biB2YWx1ZSBpcyB1bnNpZ25lZCBsb25n
LCB3aGljaCBpcyA4IGJ5dGVzIG9uIGEgNjQgYml0IG1hY2hpbmUsDQo+IGFuZCBub3Qgb25seSB0
aGF0LCB0aGUgZGVwdGggaXMgYW4gaW50ICg0IGJ5dGVzKS4gVGhlIG92ZXJydW4gY2FuIGJlIHNp
bXBseQ0KPiBhbiB1bnNpZ25lZCBpbnQgKDQgYnl0ZXMpIGFuZCBwYWNrIHRoZSBmdHJhY2VfZ3Jh
cGhfcmV0IHN0cnVjdHVyZSBiZXR0ZXIuDQo+IA0KPiBUaGUgZGVwdGggaXMgbW92ZWQgdXAgbmV4
dCB0byB0aGUgZnVuYywgYXMgaXQgaXMgdXNlZCBtb3JlIG9mdGVuIHdpdGggZnVuYywNCj4gYW5k
IGltcHJvdmVzIGNhY2hlIGxvY2FsaXR5Lg0KLi4uDQo+ICB9IF9fcGFja2VkOw0KDQpEb2VzIHRo
aXMgbWFueSBhbnkvbXVjaCBkaWZmZXJlbmNlIGdpdmVuIHRoYXQgdGhlIHN0cnVjdHVyZSBpcw0K
bWFya2VkIF9fcGFja2VkPw0KDQpPVE9IIHRoZSBfX3BhY2tlZCB3aWxsIChwcm9iYWJseSkga2ls
bCBwZXJmb3JtYW5jZSBvbiBzeXN0ZW1zDQp0aGF0IGRvbid0IHN1cHBvcnQgbWlzLWFsaWduZWQg
YWNjZXNzZXMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

