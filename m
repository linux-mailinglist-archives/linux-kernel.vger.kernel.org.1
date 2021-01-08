Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770F82EEFC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbhAHJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:39:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:37246 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbhAHJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:39:25 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-193-iPIfgJlFPcSCcD_zFAUJNQ-1; Fri, 08 Jan 2021 09:37:46 +0000
X-MC-Unique: iPIfgJlFPcSCcD_zFAUJNQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 8 Jan 2021 09:37:45 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 8 Jan 2021 09:37:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: RE: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Thread-Topic: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Thread-Index: AQHW5SyQsxcCoz6xzUCV1q8xqWXcS6odd5Wg
Date:   Fri, 8 Jan 2021 09:37:45 +0000
Message-ID: <824461ae2cb642b1b2f82fac140a98da@AcuMS.aculab.com>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
 <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
 <20210107190445.GK3579531@ZenIV.linux.org.uk>
 <CAHk-=whneXU5Sr=iOOrzcqZt6q85zp-8CUSviOwGPj5ePBW4CQ@mail.gmail.com>
In-Reply-To: <CAHk-=whneXU5Sr=iOOrzcqZt6q85zp-8CUSviOwGPj5ePBW4CQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDcgSmFudWFyeSAyMDIxIDE5OjM0DQo+IA0K
PiBPbiBUaHUsIEphbiA3LCAyMDIxIGF0IDExOjA0IEFNIEFsIFZpcm8gPHZpcm9AemVuaXYubGlu
dXgub3JnLnVrPiB3cm90ZToNCj4gPg0KPiA+IEJUVywgY2hhbmdpbmcgJ2V2ZW50JyBmaWVsZCBp
biBwbGFjZSBmcm9tIGFub3RoZXIgdGhyZWFkIGlzIGdvaW5nIHRvDQo+ID4gYmUgaW50ZXJlc3Rp
bmcgLSB5b3UgaGF2ZSB0d28gMTZiaXQgdmFsdWVzIG5leHQgdG8gZWFjaCBvdGhlciBhbmQNCj4g
PiB0d28gQ1BVcyBtb2RpZnlpbmcgdGhvc2Ugd2l0aCBubyBleGNsdXNpb24uICBTb3VuZHMgbGlr
ZSBhIHJlY2lwZQ0KPiA+IGZvciBtYXNzaXZlIHRyb3VibGUuLi4NCj4gDQo+IEl0J3MgcGVyZmVj
dGx5IGZpbmUgb24ganVzdCBhYm91dCBhbnl0aGluZyBlbHNlIHRoYW4gb24gYW4gb3JpZ2luYWwN
Cj4gcHJlLWV2NSBhbHBoYS4NCg0KQXBhcnQgZnJvbSB0aGUgaG9ycmlkIGNvc3Qgb2YgdGhlIGNh
Y2hlLWxpbmUgYm91bmNpbmcuDQoNCj4gVGhlIEMgc3RhbmRhcmQgZXZlbiAtIGZpbmFsbHkgLSBt
YWRlIGl0IGEgcmVxdWlyZW1lbnQgdGhhdCBhY2Nlc3NlcyB0bw0KPiBkaWZmZXJlbnQgbWVtYmVy
cyBjYW4ndCBpbnRyb2R1Y2UgZGF0YSByYWNlcy4NCj4gDQo+IFNvIEkgYWdyZWUgd2l0aCB5b3Ug
dGhhdCBpdCdzIGEgYml0IGFubm95aW5nLCBhbmQgaXQncyBsaWtlbHkgbm90IGV2ZW4NCj4gdmVy
eSBjb21tb24sIGJ1dCBJIGNvdWxkIGVhc2lseSBpbWFnaW5lIG15c2VsZiB3cml0aW5nIGNvZGUg
dGhhdA0KPiBjaGFuZ2VzIGVpdGhlciAnZmQnIG9yICdldmVudHMnIGluIGEgdGhyZWFkZWQgc2Vy
dmVyLg0KPiANCj4gVGhhdCdzIHByZXR0eSBtdWNoIHRoZSB3aG9sZSBwb2ludCBvZiAncG9sbCgp
JyBhZnRlciBhbGwgLSB0aHJlYWRlZA0KPiBzZXJ2ZXJzIHRoYXQgaGF2ZSB0aGF0IGNvbnZlbmll
bnQgYXJyYXkgb2YgcG9sbGFibGUgZmlsZSBkZXNjcmlwdG9ycy4NCg0KSSBlbmRlZCB1cCB1c2lu
ZyBlcG9sbCgpLg0KT25lIHNlcnZlciB0aHJlYWQgZG9lcyB0aGUgZXBvbGwoKSBhbmQgdGhlbiBh
bGwgdGhlIHRocmVhZHMgcHJvY2Vzcw0KdGhlIGVudHJpZXMgdXNpbmcgYXRvbWljX2luY3JlbWVu
dCgpIG9uIHRoZSBhcnJheSBpbmRleC4NCg0KVGhlIGxhY2sgb2Ygc3BpbmxvY2tzIGluIHVzZXJz
cGFjZSByZWFsbHkga2lsbHMgeW91Lg0KSWYgeW91IHVzZSBhIGZ1dGV4IHRvIGNvbnRyb2wgYSBs
aW5rZWQgbGlzdCBhIGhhcmR3YXJlIGludGVycnVwdA0KYW5kIHRoZW4gYWxsIHRoZSBuZXR3b3Jr
IGFuZCByY3Ugc29mdGludCBjYWxsYmFja3MgY2FuIGhhcHBlbg0KaW4gdGhlIGZldyBsb2NrZWQg
aW5zdHJjdXRpb25zLg0KSXQgZG9lc24ndCBtYXR0ZXIgdGhhdCBvbmUgc2VydmVyIHRocmVhZCBp
cyBibG9ja2VkIGZvciB+MW1zLA0KYnV0IGhhdmluZyB0aGVtIGFsbCBibG9ja2VkIGlzIGEgcHJv
YmxlbS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

