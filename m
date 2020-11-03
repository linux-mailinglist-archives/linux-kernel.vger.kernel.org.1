Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9192D2A58D7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgKCV67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:58:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:37989 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729828AbgKCV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:57:37 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-115-YO2xIxE2MmCfRz5cXdSJ4A-1; Tue, 03 Nov 2020 21:57:32 +0000
X-MC-Unique: YO2xIxE2MmCfRz5cXdSJ4A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 3 Nov 2020 21:57:32 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 3 Nov 2020 21:57:32 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tong Zhang' <ztong0001@gmail.com>
CC:     Anders Larsen <al@alarsen.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] qnx4: qnx4_block_map error handling
Thread-Topic: [PATCH v3] qnx4: qnx4_block_map error handling
Thread-Index: AQHWsW4xl10PEzYX6kyh1cQHa4gGXqm2Oy4QgAAzHACAAIaM4A==
Date:   Tue, 3 Nov 2020 21:57:32 +0000
Message-ID: <2e1ec234135349c58993097b84ea10b2@AcuMS.aculab.com>
References: <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
 <20201102231420.1833852-1-ztong0001@gmail.com>
 <7d978bf40c5845e8b89a740250ba958a@AcuMS.aculab.com>
 <CAA5qM4C+UGB_SXW5OeWKPtNkXyVCfwwB_ct9wps0Lj6VhvTawg@mail.gmail.com>
In-Reply-To: <CAA5qM4C+UGB_SXW5OeWKPtNkXyVCfwwB_ct9wps0Lj6VhvTawg@mail.gmail.com>
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

RnJvbTogVG9uZyBaaGFuZw0KPiBTZW50OiAwMyBOb3ZlbWJlciAyMDIwIDEzOjUzDQouLi4NCj4g
PiBBbHNvICdibGtudW0nIGlzIG9ubHkgJ3Vuc2lnbmVkIGxvbmcnIHNvIH4wdWxsIGlzIHdyb25n
Lg0KPiA+IEl0IGNhbiBiZSB3b3J0aCBpbmplY3RpbmcgYW4gZXJyb3IgYW5kIGNoZWNraW5nIHRo
ZSBlcnJvcg0KPiA+IHByb3BhZ2F0aW9uIHdvcmtzLg0KPiA+DQo+ID4gV2hhdCBpcyB0aGUgYWN0
dWFsIG1heGltdW0gZmlsZSBzaXplPw0KDQo+IFRoZSBtYXhpbXVtIGZpbGUgc2l6ZSBpcyAyR0It
MSwgYnV0IGZyb20gbXkgdW5kZXJzdGFuZGluZw0KPiBxbng0X2Jsb2NrX21hcCgpIHJldHVybnMg
YSBwaHlzaWNhbCBibG9jayBudW1iZXIuDQo+IFRoZSBtYXggZGlzayBzaXplIHN1cHBvcnRlZCBp
cyAyKio2NCBieXRlcywgaG93ZXZlcg0KPiBpdCBpcyBsaW1pdGVkIHRvIHVuc2lnbmVkIGxvbmcg
KDIqKjMyKQ0KPiAtLSBzbyBJIGFtIGFjdHVhbGx5IHZlcnkgaGVzaXRhbnQgdG8gZW5jb2RlIGFu
IGVycm9yIGNvZGUgaW4gdGhlIHJldHVybiB2YWx1ZQ0KPiB3aXRob3V0IGNoYW5naW5nIHRoZSBm
dW5jdGlvbiByZXR1cm4gdHlwZSwgd2hpY2ggd2lsbCBpbnRyb2R1Y2UgbW9yZQ0KPiBjaGFuZ2Vz
IEkgZG9uJ3QgbGlrZS4NCj4gVGhlIG9yaWdpbmFsIC1FSU8gaW4gcW54NF9ibG9ja19tYXAoKSBp
cyBhbHNvIGRvZGd5IGJ0dy4NCg0KWW91J3ZlIHB1dCB5b3VyIGhhbmQgaW50byBhIGJhZyBvZiB3
b3Jtcy4uLg0KDQpMb29rcyBsaWtlIGEgbG9hZCBvZiB0aGUgJ2xvbmcnIG5lZWQgdG8gYmUgNjRi
aXQuDQoNCkknbSBhY3R1YWxseSBzdXJwcmlzZWQgaG93IG9mdGVuICdsb25nJyBhcHBlYXJzIGlu
IHRoZQ0KbGludXgga2VybmVsLg0KSSBkb24ndCBiZWxpZXZlIHRoZXJlIHdhcyBldmVyIGEgMTZi
aXQgdmVyc2lvbiAoZWcgMjg2KQ0Kd2hlcmUgJ2xvbmcnIHdhcyAzMmJpdC4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

