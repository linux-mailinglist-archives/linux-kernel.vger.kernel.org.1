Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C789928CC55
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbgJMLM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:12:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:59340 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727457AbgJMLM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:12:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-59-t8cDFw9jPqqR0wly0Oe9Jg-1; Tue, 13 Oct 2020 12:12:54 +0100
X-MC-Unique: t8cDFw9jPqqR0wly0Oe9Jg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 13 Oct 2020 12:12:54 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 13 Oct 2020 12:12:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'harshal chaudhari' <harshalchau04@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH] char: ppdev: check if ioctl argument is present and valid
Thread-Topic: [PATCH] char: ppdev: check if ioctl argument is present and
 valid
Thread-Index: AQHWoT91EN0LvzjofE2muVvqxptK+6mVYKwQ
Date:   Tue, 13 Oct 2020 11:12:54 +0000
Message-ID: <0eb6f48d05624c8abaf00ae1bd4d88a9@AcuMS.aculab.com>
References: <20201008182713.2764-1-harshalchau04@gmail.com>
 <20201009045734.GA112189@kroah.com>
 <CADVatmONWsfsj4-WKhNAcXjKXbUrgyD6UpK+ML6TNpqtp8be9A@mail.gmail.com>
 <CADVatmOf18xUEvjWFzenut=KsHtoEZ5OSZF1oCqFJsbkx_Mb9g@mail.gmail.com>
 <CAFEvwukbxCY4wffd_1jLo+vjfXfBC4sFDpJ1vY4wfT+=yFA--w@mail.gmail.com>
In-Reply-To: <CAFEvwukbxCY4wffd_1jLo+vjfXfBC4sFDpJ1vY4wfT+=yFA--w@mail.gmail.com>
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

RnJvbTogaGFyc2hhbCBjaGF1ZGhhcmkNCj4gU2VudDogMTMgT2N0b2JlciAyMDIwIDEwOjAxDQo+
IA0KPiBPbiBTYXQsIE9jdCAxMCwgMjAyMCBhdCAyOjQxIFBNIFN1ZGlwIE11a2hlcmplZQ0KPiA8
c3VkaXBtLm11a2hlcmplZUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gU2F0LCBPY3Qg
MTAsIDIwMjAgYXQgMTowOCBBTSBTdWRpcCBNdWtoZXJqZWUNCj4gPiA8c3VkaXBtLm11a2hlcmpl
ZUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgT2N0IDksIDIwMjAgYXQg
NTo1NyBBTSBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4g
PiA+DQo+ID4gPiA+IE9uIFRodSwgT2N0IDA4LCAyMDIwIGF0IDExOjU3OjEzUE0gKzA1MzAsIEhh
cnNoYWwgQ2hhdWRoYXJpIHdyb3RlOg0KPiA+ID4gPiA+IENoZWNraW5nIHRoZSBhcmd1bWVudCBw
YXNzZWQgdG8gdGhlIGlvY3RsIGlzIHZhbGlkDQo+ID4gPiA+ID4gb3Igbm90LiBpZiBub3QgdGhl
biByZXR1cm4gLUVJTlZBTC4NCj4gPiA+ID4NCj4gPiA+ID4gQWxvbmcgdGhlIHRoZSBjb21tZW50
cyB0aGF0IEFybmQgbWFkZSwgdGhpcyBpcyBub3QgdGhlIGNvcnJlY3QgdmFsdWUgdG8NCj4gPiA+
ID4gYmUgcmV0dXJuaW5nIGZyb20gYW4gaW9jdGwgd2hlbiB5b3UgZG9uJ3QgcGFzcyBpbiB0aGUg
Y29ycmVjdCBjb21tYW5kLg0KPiANCj4gVGhhbmtzIEdyZWcgZm9yIHRoZSBjb21tZW50LiBpIGFt
IGNoZWNraW5nIHdpdGggdmFsdWUNCj4gLUVGQVVMVCBub3csIGkgd2lsbCBnZXQgYmFjayB0byB5
b3Ugd2l0aCBjaGFuZ2VzIGFzIGNvbnNpZGVyYXRpb24NCj4gb2YgQXJuZCBjb21tZW50cy4NCj4g
DQo+ID4gPiA+IEFuZCBpdCBkb2Vzbid0IG1hdGNoIHdoYXQgeW91ciBwYXRjaCBzYXlzLCBwbGVh
c2UgYmUgY29uc2lzdGVudC4NCj4gDQo+IEkganVzdCB3YW50IHRvIHBlcmZvcm0gdGhlIEFyZ3Vt
ZW50IGNoZWNrIGhlcmUgb25seS4gIGJhY2sgdGhlbiBpDQo+IHdhcyB0cnlpbmcgd2l0aCBhY2Nl
c3Nfb2soKSBhcyB3ZWxsLCBidXQgYWNjZXNzX29rKCkgcmV0dXJuIHN1Y2Nlc3MNCj4gZXZlbiBp
ZiBpIHBhc3NlZCBhIE5VTEwgcG9pbnRlci4gc28gdGhhdCdzIHdoeSBpIHJlbW92ZWQgaXQgZnJv
bSBoZXJlLg0KDQpXaHkgYm90aGVyLg0KWW91IGhhdmUgdG8gY2hlY2sgdGhlIGNvcHlfZnJvbV91
c2VyKCkgd2hhdGV2ZXIgZWxzZSB5b3UgbWlnaHQgaGF2ZQ0KY2hlY2tlZCBlYXJsaWVkLg0KU28g
d2h5IG9wdGltaXNlIGZvciB0aGUgZXJyb3IgY2FzZSB0aGF0IG5ldmVyIGhhcHBlbnMuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

