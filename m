Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A761D2B7E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKRNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:22:36 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:47884 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbgKRNWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:22:35 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-111-eBeRGmPRPnygMD5X2l45bA-1; Wed, 18 Nov 2020 13:22:29 +0000
X-MC-Unique: eBeRGmPRPnygMD5X2l45bA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 18 Nov 2020 13:22:28 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 18 Nov 2020 13:22:28 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexandre Chartre' <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jan.setjeeilers@oracle.com" <jan.setjeeilers@oracle.com>,
        "junaids@google.com" <junaids@google.com>,
        "oweisse@google.com" <oweisse@google.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "graf@amazon.de" <graf@amazon.de>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "kuzuno@gmail.com" <kuzuno@gmail.com>
Subject: RE: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
Thread-Topic: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
Thread-Index: AQHWvX4bZBmKPgi/bUuugBhHF1Bzu6nNnuFAgAARogCAACju4A==
Date:   Wed, 18 Nov 2020 13:22:28 +0000
Message-ID: <5c93e47e106c42659b2004e8de604d61@AcuMS.aculab.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
 <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
 <20201117212608.GS5719@zn.tnic>
 <b63ec614-8a49-728d-aa61-76339378183f@oracle.com>
 <ce8d862f498042d1bd7a6e8a071f06bf@AcuMS.aculab.com>
 <0bedae59-5397-9cae-3c2a-66bc376f5616@oracle.com>
In-Reply-To: <0bedae59-5397-9cae-3c2a-66bc376f5616@oracle.com>
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

RnJvbTogQWxleGFuZHJlIENoYXJ0cmUNCj4gU2VudDogMTggTm92ZW1iZXIgMjAyMCAxMDozMA0K
Li4uDQo+IENvcnJlY3QsIHRoaXMgUkZDIGlzIG5vdCBjaGFuZ2luZyB0aGUgb3ZlcmhlYWQuIEhv
d2V2ZXIsIGl0IGlzIGEgc3RlcCBmb3J3YXJkDQo+IGZvciBiZWluZyBhYmxlIHRvIGV4ZWN1dGUg
c29tZSBzZWxlY3RlZCBzeXNjYWxscyBvciBpbnRlcnJ1cHQgaGFuZGxlcnMgd2l0aG91dA0KPiBz
d2l0Y2hpbmcgdG8gdGhlIGtlcm5lbCBwYWdlLXRhYmxlLiBUaGUgbmV4dCBzdGVwIHdvdWxkIGJl
IHRvIGlkZW50aWZ5IGFuZCBhZGQNCj4gdGhlIG5lY2Vzc2FyeSBtYXBwaW5nIHRvIHRoZSB1c2Vy
IHBhZ2UtdGFibGUgc28gdGhhdCBzcGVjaWZpZWQgc3lzY2FsbHMgY2FuIGJlDQo+IGV4ZWN1dGVk
IHdpdGhvdXQgc3dpdGNoaW5nIHRoZSBwYWdlLXRhYmxlLg0KDQpSZW1lbWJlciB0aGF0IHdpdGhv
dXQgUFRJIHVzZXIgc3BhY2UgY2FuIHJlYWQgYWxsIGtlcm5lbCBtZW1vcnkuDQooSSdtIG5vdCAx
MDAlIHN1cmUgeW91IGNhbiBmb3JjZSBhIGNhY2hlLWxpbmUgcmVhZC4pDQpJdCBpc24ndCBldmVu
IHRoYXQgc2xvdy4NCihFdmVuIEkgY2FuIHVuZGVyc3RhbmQgaG93IGl0IHdvcmtzLikNCg0KU28g
aWYgeW91IGFyZSB3b3JyaWVkIGFib3V0IHVzZXIgc3BhY2UgZG9pbmcgdGhhdCB5b3UgY2FuJ3Qg
cmVhbGx5DQpydW4gYW55dGhpbmcgb24gdGhlIHVzZXIgcGFnZSB0YWJsZXMuDQoNClN5c3RlbSBj
YWxscyBsaWtlIGdldHBpZCgpIGFyZSBpcnJlbGV2YW50IC0gdGhleSBhcmVuJ3QgdXNlZCAobXVj
aCkuDQpFdmVuIHRoZSB0aW1lIG9mIGRheSBvbmVzIGFyZSBpbXBsZW1lbnRlZCBpbiB0aGUgVkRT
TyB3aXRob3V0IGENCmNvbnRleHQgc3dpdGNoLg0KDQpTbyB0aGUgb3ZlcmhlYWRzIGNvbWUgZnJv
bSBvdGhlciBzeXN0ZW0gY2FsbHMgdGhhdCAnZG8gd29yaycNCndpdGhvdXQgYWN0dWFsbHkgc2xl
ZXBpbmcuDQpJJ20gZ3Vlc3NpbmcgdGhpbmdzIGxpa2UgcmVhZCwgd3JpdGUsIHNlbmRtc2csIHJl
Y3Ztc2cuDQoNClRoZSBvbmx5IGludGVyZXN0aW5nIHN5c3RlbSBjYWxsIEkgY2FuIHRoaW5rIG9m
IGlzIGZ1dGV4Lg0KQXMgd2VsbCBhcyBhbGwgdGhlIGNhbGxzIHRoYXQgcmV0dXJuIGltbWVkaWF0
ZWx5IGJlY2F1c2UgdGhlDQptdXRleCBoYXMgYmVlbiByZWxlYXNlZCB3aGlsZSBlbnRlcmluZyB0
aGUga2VybmVsLCBJIHN1c3BlY3QNCnRoYXQgYmVpbmcgcHJlLWVtcHRlZCBieSBhIGRpZmZlcmVu
dCB0aHJlYWQgKG9mIHRoZSBzYW1lIHByb2Nlc3MpDQpkb2Vzbid0IGFjdHVhbGx5IG5lZWQgQ1Iz
IHJlbG9hZGluZyAod2l0aG91dCBQVEkpLg0KDQpJIGFsc28gc3VzcGVjdCB0aGF0IGl0IGlzbid0
IGp1c3QgdGhlIENSMyByZWxvYWQgdGhhdCBjb3N0cy4NClRoZXJlIGNvdWxkIChkZXBlbmRpbmcg
b24gdGhlIGNwdSkgYmUgYXNzb2NpYXRlZCBUTEIgYW5kL29yIGNhY2hlDQppbnZhbGlkYXRpb25z
IHRoYXQgaGF2ZSBhIG11Y2ggbGFyZ2VyIGVmZmVjdCBvbiBwcm9ncmFtcyB3aXRoDQpsYXJnZSB3
b3JraW5nIHNldHMgdGhhbiBvbiBzaW1wbGUgYmVuY2htYXJrIHByb2dyYW1zLg0KDQpOb3cgYml0
cyBvZiBkYXRhIHRoYXQgeW91IGFyZSAnbW9yZSB3b3JyaWVkIGFib3V0JyBjb3VsZCBiZSBrZXB0
DQppbiBwaHlzaWNhbCBtZW1vcnkgdGhhdCBpc24ndCBub3JtYWxseSBtYXBwZWQgKG9yIHJlZmVy
ZW5jZWQgYnkNCmEgVExCKSBhbmQgb25seSBtYXBwZWQgd2hlbiBuZWVkZWQuDQpCdXQgdGhhdCBk
b2Vzbid0IGhlbHAgdGhlIGdlbmVyYWwgY2FzZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

