Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB72834D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgJELVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:21:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33921 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgJELVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:21:41 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-238-7mZ020ZhOLWxcHxA0cpIlg-1; Mon, 05 Oct 2020 12:21:38 +0100
X-MC-Unique: 7mZ020ZhOLWxcHxA0cpIlg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 5 Oct 2020 12:21:37 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 5 Oct 2020 12:21:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Hildenbrand' <david@redhat.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        Michal Hocko <mhocko@suse.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: optionally disable brk()
Thread-Topic: [PATCH] mm: optionally disable brk()
Thread-Index: AQHWmv2jTpq5FewPDUy63nD4f9riL6mI3SWA
Date:   Mon, 5 Oct 2020 11:21:37 +0000
Message-ID: <5fb32353b1964299809fce0c7579a092@AcuMS.aculab.com>
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
 <888e62e0-3979-207b-c516-ddfc6b9f3345@redhat.com>
 <4d325e3e-3139-eded-6781-435fb04fb915@gmail.com>
 <9dc586f4-38f0-7956-0ab6-bd7921491606@redhat.com>
In-Reply-To: <9dc586f4-38f0-7956-0ab6-bd7921491606@redhat.com>
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

RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQNCj4gU2VudDogMDUgT2N0b2JlciAyMDIwIDEwOjU1DQou
Li4NCj4gPiBJZiBoYXJkZW5pbmcgYW5kIGNvbXBhdGliaWxpdHkgYXJlIHNlZW4gYXMgdHJhZGVv
ZmZzLCBwZXJoYXBzIHRoZXJlDQo+ID4gY291bGQgYmUgYSB0b3AgbGV2ZWwgY29uZmlnIGNob2lj
ZSAoQ09ORklHX0hBUkRFTklOR19UUkFERU9GRikgZm9yIHRoaXMuDQo+ID4gSXQgd291bGQgaGF2
ZSBvcHRpb25zDQo+ID4gLSAiY29tcGF0aWJpbGl0eSIgKGRlZmF1bHQpIHRvIGdlYXIgcXVlc3Rp
b25zIGZvciBtYXhpbXVtIGNvbXBhdGliaWxpdHksDQo+ID4gZGVzZWxlY3RpbmcgYW55IGhhcmRl
bmluZyBvcHRpb25zIHdoaWNoIHJlZHVjZSBjb21wYXRpYmlsaXR5DQo+ID4gLSAiaGFyZGVuaW5n
IiB0byBnZWFyIHF1ZXN0aW9ucyBmb3IgbWF4aW11bSBoYXJkZW5pbmcsIGRlc2VsZWN0aW5nIGFu
eQ0KPiA+IGNvbXBhdGliaWxpdHkgb3B0aW9ucyB3aGljaCByZWR1Y2UgaGFyZGVuaW5nDQo+ID4g
LSAibm9uZS9tYW51YWwiOiBhc2sgYWxsIHF1ZXN0aW9ucyBsaWtlIGJlZm9yZQ0KPiANCj4gSSB0
aGluayB0aGUgZ2VuZXJhbCBkaXJlY3Rpb24gaXMgdG8gYXZvaWQgYW4gZXhwbG9kaW5nIHNldCBv
ZiBjb25maWcNCj4gb3B0aW9ucy4gU28gaWYgdGhlcmUgaXNuJ3QgYSAqcmVhbCogZGVtYW5kLCBJ
IGd1ZXNzIGdsdWluZyB0aGlzIHRvIGENCj4gc2luZ2xlIG9wdGlvbiAoIkNPTkZJR19TRUNVUklU
WV9IQVJERU5JTkciKSBtaWdodCBiZSBnb29kIGVub3VnaC4NCg0KV291bGRuJ3QgdGhhdCBiZSBi
ZXR0ZXIgYWNoaWV2ZWQgYnkgcnVuLXRpbWUgY2xvYmJlcmluZw0Kb2YgdGhlIHN5c2NhbGwgdmVj
dG9ycz8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

