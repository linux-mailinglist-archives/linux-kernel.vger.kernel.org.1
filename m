Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E6D2B53C3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgKPVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:24:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59196 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgKPVYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:24:43 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-276-nv8oSO4WPDGtvfEl8EI8Uw-1; Mon, 16 Nov 2020 21:24:38 +0000
X-MC-Unique: nv8oSO4WPDGtvfEl8EI8Uw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Nov 2020 21:24:37 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Nov 2020 21:24:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexandre Chartre' <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "jan.setjeeilers@oracle.com" <jan.setjeeilers@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        "oweisse@google.com" <oweisse@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "kuzuno@gmail.com" <kuzuno@gmail.com>
Subject: RE: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of
 trampoline stack
Thread-Topic: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of
 trampoline stack
Thread-Index: AQHWvEQuYUP+foyKVkmjeD/qxWNSTKnLRB5w
Date:   Mon, 16 Nov 2020 21:24:37 +0000
Message-ID: <985e90259d654d7c9eb74398c5d927ee@AcuMS.aculab.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-13-alexandre.chartre@oracle.com>
 <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com>
 <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com>
In-Reply-To: <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com>
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

RnJvbTogQWxleGFuZHJlIENoYXJ0cmUNCj4gU2VudDogMTYgTm92ZW1iZXIgMjAyMCAxODoxMA0K
PiANCj4gT24gMTEvMTYvMjAgNTo1NyBQTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOg0KPiA+IE9u
IE1vbiwgTm92IDE2LCAyMDIwIGF0IDY6NDcgQU0gQWxleGFuZHJlIENoYXJ0cmUNCj4gPiA8YWxl
eGFuZHJlLmNoYXJ0cmVAb3JhY2xlLmNvbT4gd3JvdGU6DQo+ID4+DQo+ID4+IFdoZW4gZW50ZXJp
bmcgdGhlIGtlcm5lbCBmcm9tIHVzZXJsYW5kLCB1c2UgdGhlIHBlci10YXNrIFBUSSBzdGFjaw0K
PiA+PiBpbnN0ZWFkIG9mIHRoZSBwZXItY3B1IHRyYW1wb2xpbmUgc3RhY2suIExpa2UgdGhlIHRy
YW1wb2xpbmUgc3RhY2ssDQo+ID4+IHRoZSBQVEkgc3RhY2sgaXMgbWFwcGVkIGJvdGggaW4gdGhl
IGtlcm5lbCBhbmQgaW4gdGhlIHVzZXIgcGFnZS10YWJsZS4NCj4gPj4gVXNpbmcgYSBwZXItdGFz
ayBzdGFjayB3aGljaCBpcyBtYXBwZWQgaW50byB0aGUga2VybmVsIGFuZCB0aGUgdXNlcg0KPiA+
PiBwYWdlLXRhYmxlIGluc3RlYWQgb2YgYSBwZXItY3B1IHN0YWNrIHdpbGwgYWxsb3cgZXhlY3V0
aW5nIG1vcmUgY29kZQ0KPiA+PiBiZWZvcmUgc3dpdGNoaW5nIHRvIHRoZSBrZXJuZWwgc3RhY2sg
YW5kIHRvIHRoZSBrZXJuZWwgcGFnZS10YWJsZS4NCj4gPg0KPiA+IFdoeT8NCj4gDQo+IFdoZW4g
ZXhlY3V0aW5nIG1vcmUgY29kZSBpbiB0aGUga2VybmVsLCB3ZSBhcmUgbGlrZWx5IHRvIHJlYWNo
IGEgcG9pbnQNCj4gd2hlcmUgd2UgbmVlZCB0byBzbGVlcCB3aGlsZSB3ZSBhcmUgdXNpbmcgdGhl
IHVzZXIgcGFnZS10YWJsZSwgc28gd2UgbmVlZA0KPiB0byBiZSB1c2luZyBhIHBlci10aHJlYWQg
c3RhY2suDQoNCklzbid0IHRoYXQgZ29pbmcgdG8gYWxsb2NhdGUgYSBsb3QgbW9yZSBrZXJuZWwg
bWVtb3J5Pw0KDQpJU1RSIHNvbWUgdGhvdWdodHMgYWJvdXQgdXNpbmcgZHluYW1pY2FsbHkgYWxs
b2NhdGVkIGtlcm5lbA0Kc3RhY2tzIHdoZW4gKGF0IGxlYXN0IHNvbWUpIHdha2V1cHMgYXJlIGRv
bmUgYnkgZGlyZWN0bHkNCnJlc3RhcnRpbmcgdGhlIHN5c3RlbSBjYWxsIC0gc28gdGhhdCB0aGUg
c2xlZXBpbmcgdGhyZWFkDQpkb2Vzbid0IGV2ZW4gbmVlZCBhIGtlcm5lbCBzdGFjay4NCihJIGNh
bid0IHJlbWVtYmVyIGlmIHRoYXQgd2FzIGxpbnV4IG9yIG9uZSBvZiB0aGUgQlNEcykNCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

