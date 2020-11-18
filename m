Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD32B7A65
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKRJaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:30:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:38820 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgKRJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:30:08 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-9-KSofn2n5Plu9KHYZHoEQkw-1;
 Wed, 18 Nov 2020 09:30:02 +0000
X-MC-Unique: KSofn2n5Plu9KHYZHoEQkw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 18 Nov 2020 09:30:01 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 18 Nov 2020 09:30:01 +0000
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
Thread-Index: AQHWvX4bZBmKPgi/bUuugBhHF1Bzu6nNnuFA
Date:   Wed, 18 Nov 2020 09:30:01 +0000
Message-ID: <ce8d862f498042d1bd7a6e8a071f06bf@AcuMS.aculab.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
 <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
 <20201117212608.GS5719@zn.tnic>
 <b63ec614-8a49-728d-aa61-76339378183f@oracle.com>
In-Reply-To: <b63ec614-8a49-728d-aa61-76339378183f@oracle.com>
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

RnJvbTogQWxleGFuZHJlIENoYXJ0cmUNCj4gU2VudDogMTggTm92ZW1iZXIgMjAyMCAwNzo0Mg0K
PiANCj4gDQo+IE9uIDExLzE3LzIwIDEwOjI2IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+
ID4gT24gVHVlLCBOb3YgMTcsIDIwMjAgYXQgMDc6MTI6MDdQTSArMDEwMCwgQWxleGFuZHJlIENo
YXJ0cmUgd3JvdGU6DQo+ID4+IFNvbWUgYmVuY2htYXJrcyBhcmUgYXZhaWxhYmxlLCBpbiBwYXJ0
aWN1bGFyIGZyb20gcGhvcm9uaXg6DQo+ID4NCj4gPiBXaGF0IEkgd2FzIGV4cGVjdGluZyB3YXMg
YmVuY2htYXJrcyAqeW91KiBoYXZlIHJ1biB3aGljaCBzaG93IHRoYXQNCj4gPiBwZXJmIHBlbmFs
dHksIG5vdCBzb21ldGhpbmcgb25lIGNhbiBmaW5kIHF1aWNrbHkgb24gdGhlIGludGVybmV0IGFu
ZA0KPiA+IHNvbWV0aGluZyBvbmUgY2Fubm90IGFsd2F5cyByZXByb2R1Y2UgaGVyLS9oaW1zZWxm
Lg0KPiA+DQo+ID4gWW91IGRvIGtub3cgdGhhdCBwcmVzZW50aW5nIGNvbnZpbmNpbmcgbnVtYmVy
cyB3aXRoIGEgcGF0Y2hzZXQgZ3JlYXRseQ0KPiA+IGltcHJvdmVzIGl0cyBjaGFuY2VzIG9mIGdl
dHRpbmcgaXQgdXBzdHJlYW1lZCwgcmlnaHQ/DQo+ID4NCj4gDQo+IFdlbGwsIGl0IGxvb2tzIGxp
a2UgSSB3cm9uZ2Z1bGx5IGFzc3VtZSB0aGF0IEtQVEkgd2FzIGEgd2VsbCBrbm93biBwZXJmb3Jt
YW5jZQ0KPiBvdmVyaGVhZCBzaW5jZSBpdCB3YXMgaW50cm9kdWNlZCAoYmVjYXVzZSBpdCBhZGRz
IGV4dHJhIHBhZ2UtdGFibGUgc3dpdGNoZXMpLA0KPiBidXQgeW91IGFyZSByaWdodCBJIHNob3Vs
ZCBiZSBwcmVzZW50aW5nIG15IG93biBudW1iZXJzLg0KDQpJSVJDIHRoZSBwZW5hbHR5IGNvbWVz
IGZyb20gdGhlIHBhZ2UgdGFibGUgc3dpdGNoLg0KRG9pbmcgaXQgYXQgYSBkaWZmZXJlbnQgdGlt
ZSBpcyB1bmxpa2VseSB0byBtYWtlIG11Y2ggZGlmZmVyZW5jZS4NCg0KRm9yIHNvbWUgd29ya2xv
YWRzIHRoZSBwZW5hbHR5IGlzIG1hc3NpdmUgLSBnZXR0aW5nIG9uIGZvciA1MCUuDQpXZSBhcmUg
c3RpbGwgdXNpbmcgb2xkIGtlcm5lbHMgb24gQVdTLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

