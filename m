Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835692C20EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgKXJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:12:18 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53139 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728826AbgKXJMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:12:17 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-62--NW9eR5TMCq62nAf3IBhNg-1; Tue, 24 Nov 2020 09:12:12 +0000
X-MC-Unique: -NW9eR5TMCq62nAf3IBhNg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Nov 2020 09:12:12 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Nov 2020 09:12:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chao Yu' <yuchao0@huawei.com>,
        'Sahitya Tummala' <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] f2fs: change to use rwsem for cp_mutex
Thread-Topic: [PATCH] f2fs: change to use rwsem for cp_mutex
Thread-Index: AQHWwVm8Sokw4eOdHU6M1bsTH5HkTqnV8p0QgACp5gCAAGGJ4A==
Date:   Tue, 24 Nov 2020 09:12:12 +0000
Message-ID: <effbe4f5edaf4d45a64d12c65e0dc6b0@AcuMS.aculab.com>
References: <1606109312-1944-1-git-send-email-stummala@codeaurora.org>
 <7f5213fb9b334d1290f019ab8ed6ee71@AcuMS.aculab.com>
 <a1b9a134-97a8-6fb7-2fdc-d4de91dff849@huawei.com>
In-Reply-To: <a1b9a134-97a8-6fb7-2fdc-d4de91dff849@huawei.com>
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

RnJvbTogQ2hhbyBZdQ0KPiBTZW50OiAyNCBOb3ZlbWJlciAyMDIwIDAzOjEyDQo+IA0KPiBPbiAy
MDIwLzExLzI0IDE6MDUsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBTYWhpdHlhIFR1
bW1hbGENCj4gPj4gU2VudDogMjMgTm92ZW1iZXIgMjAyMCAwNToyOQ0KPiA+Pg0KPiA+PiBVc2Ug
cndzZW0gdG8gZW5zdXJlIHNlcmlhbGl6YXRpb24gb2YgdGhlIGNhbGxlcnMgYW5kIHRvIGF2b2lk
DQo+ID4+IHN0YXJ2YXRpb24gb2YgaGlnaCBwcmlvcml0eSB0YXNrcywgd2hlbiB0aGUgc3lzdGVt
IGlzIHVuZGVyDQo+ID4+IGhlYXZ5IElPIHdvcmtsb2FkLg0KPiA+DQo+ID4gSSBjYW4ndCBzZWUg
YW55IHJlYWQgbG9jayByZXF1ZXN0cy4NCj4gPg0KPiA+IFNvIHdoeSB0aGUgY2hhbmdlPw0KPiAN
Cj4gSGkgRGF2aWQsDQo+IA0KPiBZb3UgY2FuIGNoZWNrIHRoZSBjb250ZXh0IG9mIHRoaXMgcGF0
Y2ggaW4gYmVsb3cgbGluazoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWYy
ZnMtZGV2ZWwvOGUwOTQwMjFiOTU4ZjlmZTAxZGYxMTgzYTI2Nzc4ODJAY29kZWF1cm9yYS5vcmcv
VC8jdA0KPiANCj4gQlRXLCB0aGUgcm9vdCBjYXVzZSBoZXJlIGlzIHRoYXQgbXV0ZXggbG9jayB3
b24ndCBzZXJpYWxpemUgY2FsbGVycywgc28gdGhlcmUNCj4gY291bGQgYmUgcG90ZW50aWFsIHN0
YXJ2YXRpb24gcHJvYmxlbSB3aGVuIHRoaXMgbG9jayBpcyBhbHdheXMgZ3JhYmJlZCBieSBoaWdo
DQo+IHByaW9yaXR5IHRhc2tzLg0KDQpUaGF0IGRvZXNuJ3Qgc2VlbSByaWdodC4NCg0KSWYgSSBy
ZWFkIHRoZSBhYm92ZSBjb3JyZWN0bHkgaXQgd2FzIGhpZ2ggcHJpb3JpdHkgdGFza3MgdGhhdCB3
ZXJlDQpiZWluZyAnc3RhcnZlZCcgcHJlY2lzZWx5IGJlY2F1c2UgbXV0ZXggbG9jayBzZXJpYWxp
emVzIHdha2Vycy4NCg0KSWYgeW91IGhhdmUgYSBsb2NrIHRoYXQgaXMgY29udGVuZGVkIHNvIG11
Y2ggdGhhdCBpdCBpcyBoZWxkIDEwMCUNCm9mIHRoZSB0aW1lIHlvdSBuZWVkIGEgZGlmZmVyZW50
IGxvY2tpbmcgc3RyYXRlZ3kuDQoNCklJUkMgbXV0ZXggbG9ja3MgYXJlICd0aWNrZXQnIGxvY2tz
IHNvIHRoYXQgb25seSBvbmUgdGhyZWFkIGlzIHdva2VuDQplYWNoIHRpbWUgdGhlIG11dGV4IGlz
IHJlbGVhc2VkLCBhbmQgdGhleSBhcmUgd29rZW4gaW4gdGhlIG9yZGVyDQp0aGV5IHdlbnQgdG8g
c2xlZXAuDQoNCldoaWxlIHRoaXMgYmVoYXZpb3VyIG1pZ2h0IG5vdCBiZSB0aGUgb25lIHlvdSB3
YW50LCByZWx5aW5nIG9uDQpyd3NlbSAod2hpY2ggbWlnaHQgaGFwcGVuIGN1cnJlbnRseSB0byB3
b3JrIGRpZmZlcmVudGx5KSBkb2Vzbid0DQpzZWVtIHRoZSBjb3JyZWN0IGxvbmcgdGVybSBmaXgu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

