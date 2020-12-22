Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48C32E0FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 22:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgLVVHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 16:07:19 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2920 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgLVVHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 16:07:19 -0500
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4D0plh6wJQz57xV;
        Wed, 23 Dec 2020 05:05:52 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 23 Dec 2020 05:06:36 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Wed, 23 Dec 2020 05:06:35 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Mike Galbraith" <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Topic: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Index: AQHW1mZAeBjE5clI7UKUuMSOCQsyuqoBSTyAgAAghwCAAAhXgIAAhndA//+NyICAAIW5IP//jYeAgACME8CAAA+J8P//k2OAABCudWAAAQz+8P//giUA//96TuD//vIJMIACFikA//6/uBA=
Date:   Tue, 22 Dec 2020 21:06:35 +0000
Message-ID: <1d0d4a3576e74d128d7849342a7e9faf@hisilicon.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com>
 <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
 <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
 <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com>
 <CALvZod7EZnEWb_65FjSNdx+-S_4pLHyS5rYiU-D3hFLRMXS6Lw@mail.gmail.com>
 <8cc0e01fd03245a4994f2e0f54b264fa@hisilicon.com>
 <CAM4kBB+xUa8zXSRSuB0z5FCdPNmUpDfcC4Vqu7wzAkf0b+RXqw@mail.gmail.com>
 <f0ca46a830e54f4482fb4f46df9675f5@hisilicon.com>
 <CAM4kBBKD6MAOaBvwC_Wedf_zmzmt-gm=TrAF1Lh7pVbNtcsFZg@mail.gmail.com>
 <4490cb6a7e2243fba374e40652979e46@hisilicon.com>
 <CAM4kBBK=5eBdCjWc5VJXcdr=Z4PV1=ZQ2n8fZmJ6ahJbpUyv2A@mail.gmail.com>
 <08cbef1e43634c4099709be8e99e5d27@hisilicon.com>
 <CAM4kBBJjCYX0DQZ8de9LsFV6L+eF4tZe-NN=jiAz9WLWYrsCsQ@mail.gmail.com>
In-Reply-To: <CAM4kBBJjCYX0DQZ8de9LsFV6L+eF4tZe-NN=jiAz9WLWYrsCsQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.7]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVml0YWx5IFdvb2wgW21h
aWx0bzp2aXRhbHkud29vbEBrb25zdWxrby5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVy
IDIyLCAyMDIwIDEwOjQ0IFBNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25n
LmJhby5odWFAaGlzaWxpY29uLmNvbT4NCj4gQ2M6IFNoYWtlZWwgQnV0dCA8c2hha2VlbGJAZ29v
Z2xlLmNvbT47IE1pbmNoYW4gS2ltIDxtaW5jaGFuQGtlcm5lbC5vcmc+OyBNaWtlDQo+IEdhbGJy
YWl0aCA8ZWZhdWx0QGdteC5kZT47IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBsaW51eC1tbQ0KPiA8bGludXgtbW1Aa3ZhY2sub3JnPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsNCj4gTml0aW5HdXB0YSA8bmd1cHRhQHZmbGFy
ZS5vcmc+OyBTZXJnZXkgU2Vub3poYXRza3kNCj4gPHNlcmdleS5zZW5vemhhdHNreS53b3JrQGdt
YWlsLmNvbT47IEFuZHJldyBNb3J0b24NCj4gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyB0
aWFudGFvIChIKSA8dGlhbnRhbzZAaGlzaWxpY29uLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0genNtYWxsb2M6IGRvIG5vdCB1c2UgYml0X3NwaW5fbG9jaw0KPiANCj4gT24gVHVlLCAyMiBE
ZWMgMjAyMCwgMDM6MTEgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSwNCj4gPHNvbmcuYmFvLmh1
YUBoaXNpbGljb24uY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpDQo+
ID4gPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAyMiwgMjAyMCAzOjAzIFBNDQo+ID4gPiBUbzog
J1ZpdGFseSBXb29sJyA8dml0YWx5Lndvb2xAa29uc3Vsa28uY29tPg0KPiA+ID4gQ2M6IFNoYWtl
ZWwgQnV0dCA8c2hha2VlbGJAZ29vZ2xlLmNvbT47IE1pbmNoYW4gS2ltIDxtaW5jaGFuQGtlcm5l
bC5vcmc+Ow0KPiBNaWtlDQo+ID4gPiBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+OyBMS01MIDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtbW0NCj4gPiA+IDxsaW51eC1tbUBr
dmFjay5vcmc+OyBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXgu
ZGU+Ow0KPiA+ID4gTml0aW5HdXB0YSA8bmd1cHRhQHZmbGFyZS5vcmc+OyBTZXJnZXkgU2Vub3po
YXRza3kNCj4gPiA+IDxzZXJnZXkuc2Vub3poYXRza3kud29ya0BnbWFpbC5jb20+OyBBbmRyZXcg
TW9ydG9uDQo+ID4gPiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IHRpYW50YW8gKEgpIDx0
aWFudGFvNkBoaXNpbGljb24uY29tPg0KPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSF0genNtYWxs
b2M6IGRvIG5vdCB1c2UgYml0X3NwaW5fbG9jaw0KPiA+ID4NCj4gPiA+DQo+ID4gPiA+IEknbSBz
dGlsbCBub3QgY29udmluY2VkLiBXaWxsIGttYXAgd2hhdCwgc3JjPyBBdCB0aGlzIHBvaW50IHNy
YyBtaWdodA0KPiBiZWNvbWUNCj4gPiA+IGp1c3QgYSBib2d1cyBwb2ludGVyLg0KPiA+ID4NCj4g
PiA+IEFzIGxvbmcgYXMgdGhlIG1lbW9yeSBpcyBzdGlsbCB0aGVyZSwgd2UgY2FuIGttYXAgaXQg
YnkgaXRzIHBhZ2Ugc3RydWN0Lg0KPiBCdXQNCj4gPiA+IGlmDQo+ID4gPiBpdCBpcyBub3QgdGhl
cmUgYW55bW9yZSwgd2UgaGF2ZSBubyB3YXkuDQo+ID4gPg0KPiA+ID4gPiBXaHkgY291bGRuJ3Qg
dGhlIG9iamVjdCBoYXZlIGJlZW4gbW92ZWQgc29tZXdoZXJlIGVsc2UgKGR1ZSB0byB0aGUgY29t
cGFjdGlvbg0KPiA+ID4gbWVjaGFuaXNtIGZvciBpbnN0YW5jZSkNCj4gPiA+ID4gYXQgdGhlIHRp
bWUgRE1BIGtpY2tzIGluPw0KPiA+ID4NCj4gPiA+IFNvIHpzX21hcF9vYmplY3QoKSB3aWxsIGd1
YXJhbnRlZSB0aGUgc3JjIHdvbid0IGJlIG1vdmVkIGJ5IGhvbGRpbmcgdGhvc2UNCj4gPiA+IHBy
ZWVtcHRpb24tZGlzYWJsZWQgbG9jaz8NCj4gPiA+IElmIHNvLCBpdCBzZWVtcyB3ZSBoYXZlIHRv
IGRyb3AgdGhlIE1PVkFCTEUgZ2ZwIGluIHpzd2FwIGZvciB6c21hbGxvYyBjYXNlPw0KPiA+ID4N
Cj4gPg0KPiA+IE9yIHdlIGNhbiBkbyBnZXRfcGFnZSgpIHRvIGF2b2lkIHRoZSBtb3ZlbWVudCBv
ZiB0aGUgcGFnZS4NCj4gDQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gZGlzY3VzcyB0aGlzIG1vcmUg
aW4genN3YXAgY29udGV4dCB0aGFuIHpzbWFsbG9jJ3MuDQo+IFNpbmNlIHpzbWFsbG9jIGRvZXMg
bm90IGltcGxlbWVudCByZWNsYWltIGNhbGxiYWNrLCB1c2luZyBpdCBpbiB6c3dhcA0KPiBpcyBh
IGNvcm5lciBjYXNlIGFueXdheS4NCg0KSSBzZWUuIEJ1dCBpdCBzZWVtcyB3ZSBzdGlsbCBuZWVk
IGEgc29sdXRpb24gZm9yIHRoZSBjb21wYXRpYmlsaXR5DQpvZiB6c21hbGxvYyBhbmQgenN3YXA/
IHRoaXMgd2lsbCByZXF1aXJlIGNoYW5nZSBpbiBlaXRoZXIgenNtYWxsb2MNCm9yIHpzd2FwLiAN
Cm9yIGRvIHlvdSB3YW50IHRvIG1ha2UgenN3YXAgZGVwZW5kIG9uICFaU01BTExPQz8NCg0KPiAN
Cj4genN3YXAsIG9uIHRoZSBvdGhlciBoYW5kLCBtYXkgYmUgZGVhbGluZyB3aXRoIHNvbWUgbmV3
IGJhY2tlbmRzIGluDQo+IGZ1dHVyZSB3aGljaCBoYXZlIG1vcmUgY2hhbmNlcyB0byBiZWNvbWUg
bWFpbnN0cmVhbS4gSW1hZ2luZSB0eXBpY2FsDQo+IE5VTUEtbGlrZSBjYXNlcywgaS4gZS4gYSB6
c3dhcCBwb29sIGFsbG9jYXRlZCBpbiBzb21lIGtpbmQgU1JBTSwgb3IgaW4NCj4gdW51c2VkIHZp
ZGVvIG1lbW9yeS4gSW4gc3VjaCBhIGNhc2UgaWYgeW91IHRyeSB0byB1c2UgYSBwb2ludGVyIHRv
IGFuDQo+IGludmFsaWRhdGVkIHpwb29sIG1hcHBpbmcsIHlvdSBhcmUgb24gdGhlIHdheSB0byB0
aHJhc2ggdGhlIHN5c3RlbS4NCj4gU286IG5vIGFzc3VtcHRpb25zIHRoYXQgdGhlIHpzd2FwIHBv
b2wgaXMgaW4gcmVndWxhciBsaW5lYXIgUkFNIHNob3VsZA0KPiBiZSBtYWRlLg0KPiANCj4gflZp
dGFseQ0KDQpUaGFua3MNCkJhcnJ5DQo=
