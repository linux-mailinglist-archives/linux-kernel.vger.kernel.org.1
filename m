Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9E32835C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJEMZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:25:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41047 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbgJEMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:25:26 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-249-yGCLicPjONOAJwxBgcxibQ-1; Mon, 05 Oct 2020 13:25:22 +0100
X-MC-Unique: yGCLicPjONOAJwxBgcxibQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 5 Oct 2020 13:25:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 5 Oct 2020 13:25:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Hildenbrand' <david@redhat.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        Michal Hocko <mhocko@suse.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: optionally disable brk()
Thread-Topic: [PATCH] mm: optionally disable brk()
Thread-Index: AQHWmv2jTpq5FewPDUy63nD4f9riL6mI3SWA////ggCAABHqwA==
Date:   Mon, 5 Oct 2020 12:25:21 +0000
Message-ID: <23ca06acdfb44b76892857f9e9871241@AcuMS.aculab.com>
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
 <888e62e0-3979-207b-c516-ddfc6b9f3345@redhat.com>
 <4d325e3e-3139-eded-6781-435fb04fb915@gmail.com>
 <9dc586f4-38f0-7956-0ab6-bd7921491606@redhat.com>
 <5fb32353b1964299809fce0c7579a092@AcuMS.aculab.com>
 <b6baf73e-35fd-fe12-bb5f-b9b4e334ae83@redhat.com>
In-Reply-To: <b6baf73e-35fd-fe12-bb5f-b9b4e334ae83@redhat.com>
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

RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQNCj4gU2VudDogMDUgT2N0b2JlciAyMDIwIDEzOjE5DQo+
IA0KPiBPbiAwNS4xMC4yMCAxMzoyMSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZyb206IERh
dmlkIEhpbGRlbmJyYW5kDQo+ID4+IFNlbnQ6IDA1IE9jdG9iZXIgMjAyMCAxMDo1NQ0KPiA+IC4u
Lg0KPiA+Pj4gSWYgaGFyZGVuaW5nIGFuZCBjb21wYXRpYmlsaXR5IGFyZSBzZWVuIGFzIHRyYWRl
b2ZmcywgcGVyaGFwcyB0aGVyZQ0KPiA+Pj4gY291bGQgYmUgYSB0b3AgbGV2ZWwgY29uZmlnIGNo
b2ljZSAoQ09ORklHX0hBUkRFTklOR19UUkFERU9GRikgZm9yIHRoaXMuDQo+ID4+PiBJdCB3b3Vs
ZCBoYXZlIG9wdGlvbnMNCj4gPj4+IC0gImNvbXBhdGliaWxpdHkiIChkZWZhdWx0KSB0byBnZWFy
IHF1ZXN0aW9ucyBmb3IgbWF4aW11bSBjb21wYXRpYmlsaXR5LA0KPiA+Pj4gZGVzZWxlY3Rpbmcg
YW55IGhhcmRlbmluZyBvcHRpb25zIHdoaWNoIHJlZHVjZSBjb21wYXRpYmlsaXR5DQo+ID4+PiAt
ICJoYXJkZW5pbmciIHRvIGdlYXIgcXVlc3Rpb25zIGZvciBtYXhpbXVtIGhhcmRlbmluZywgZGVz
ZWxlY3RpbmcgYW55DQo+ID4+PiBjb21wYXRpYmlsaXR5IG9wdGlvbnMgd2hpY2ggcmVkdWNlIGhh
cmRlbmluZw0KPiA+Pj4gLSAibm9uZS9tYW51YWwiOiBhc2sgYWxsIHF1ZXN0aW9ucyBsaWtlIGJl
Zm9yZQ0KPiA+Pg0KPiA+PiBJIHRoaW5rIHRoZSBnZW5lcmFsIGRpcmVjdGlvbiBpcyB0byBhdm9p
ZCBhbiBleHBsb2Rpbmcgc2V0IG9mIGNvbmZpZw0KPiA+PiBvcHRpb25zLiBTbyBpZiB0aGVyZSBp
c24ndCBhICpyZWFsKiBkZW1hbmQsIEkgZ3Vlc3MgZ2x1aW5nIHRoaXMgdG8gYQ0KPiA+PiBzaW5n
bGUgb3B0aW9uICgiQ09ORklHX1NFQ1VSSVRZX0hBUkRFTklORyIpIG1pZ2h0IGJlIGdvb2QgZW5v
dWdoLg0KPiA+DQo+ID4gV291bGRuJ3QgdGhhdCBiZSBiZXR0ZXIgYWNoaWV2ZWQgYnkgcnVuLXRp
bWUgY2xvYmJlcmluZw0KPiA+IG9mIHRoZSBzeXNjYWxsIHZlY3RvcnM/DQo+IA0KPiBZb3UgbWVh
biB2aWEgc29tZXRoaW5nIGxpa2UgYSBib290IHBhcmFtZXRlcj8gUG9zc2libHkgeWVzLg0KDQpJ
IHdhcyB0aGlua2luZyBvZiBsYXRlci4NClNvbWUga2luZCBvZiByZXN0cmljdGVkIHN5c3RlbSBt
aWdodCB3YW50IHRoZSAnY2xvYmJlcicNCm1vdW50KCkgYWZ0ZXIgZXZlcnl0aGluZyBpcyBydW5u
aW5nLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

