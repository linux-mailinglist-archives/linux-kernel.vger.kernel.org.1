Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E135E297EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 23:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764620AbgJXVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 17:22:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:30515 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1764298AbgJXVWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 17:22:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-188-shKdvF7EPDC_vaSvWm_dYQ-1; Sat, 24 Oct 2020 22:22:20 +0100
X-MC-Unique: shKdvF7EPDC_vaSvWm_dYQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 24 Oct 2020 22:22:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 24 Oct 2020 22:22:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        harshal chaudhari <harshalchau04@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] char: ppdev: check if ioctl argument is present and valid
Thread-Topic: [PATCH] char: ppdev: check if ioctl argument is present and
 valid
Thread-Index: AQHWoT91EN0LvzjofE2muVvqxptK+6mVYKwQgBHSmAmAACBxgA==
Date:   Sat, 24 Oct 2020 21:22:20 +0000
Message-ID: <4b1b1656d0be452a80f2f81f98e79e24@AcuMS.aculab.com>
References: <20201008182713.2764-1-harshalchau04@gmail.com>
 <20201009045734.GA112189@kroah.com>
 <CADVatmONWsfsj4-WKhNAcXjKXbUrgyD6UpK+ML6TNpqtp8be9A@mail.gmail.com>
 <CADVatmOf18xUEvjWFzenut=KsHtoEZ5OSZF1oCqFJsbkx_Mb9g@mail.gmail.com>
 <CAFEvwukbxCY4wffd_1jLo+vjfXfBC4sFDpJ1vY4wfT+=yFA--w@mail.gmail.com>
 <0eb6f48d05624c8abaf00ae1bd4d88a9@AcuMS.aculab.com>
 <CAFEvwu=76mPtXSEgpwSoRC0rC0tkU5BiEx1X5O2VwVSPJ7m4Rw@mail.gmail.com>
 <CAK8P3a0y5MjP7AXOpmqc7xpGFCSvTGWHPT_eev5OpJJGVcRVdA@mail.gmail.com>
In-Reply-To: <CAK8P3a0y5MjP7AXOpmqc7xpGFCSvTGWHPT_eev5OpJJGVcRVdA@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAyNCBPY3RvYmVyIDIwMjAgMjA6MjENCj4gVG86
IGhhcnNoYWwgY2hhdWRoYXJpIDxoYXJzaGFsY2hhdTA0QGdtYWlsLmNvbT4NCj4gQ2M6IERhdmlk
IExhaWdodCA8RGF2aWQuTGFpZ2h0QEFDVUxBQi5DT00+OyBHcmVnIEtIIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz47IFN1ZGlwIE11a2hlcmplZQ0KPiA8c3VkaXBtLm11a2hlcmplZUBnbWFp
bC5jb20+OyBsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGNoYXI6IHBwZGV2OiBjaGVjayBpZiBpb2N0bCBhcmd1bWVudCBp
cyBwcmVzZW50IGFuZCB2YWxpZA0KPiANCj4gT24gU2F0LCBPY3QgMjQsIDIwMjAgYXQgNTo1NCBQ
TSBoYXJzaGFsIGNoYXVkaGFyaQ0KPiA8aGFyc2hhbGNoYXUwNEBnbWFpbC5jb20+IHdyb3RlOg0K
PiA+IE9uIFR1ZSwgT2N0IDEzLCAyMDIwIGF0IDQ6NDIgUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5M
YWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFNvIEkgYW0gYSBsaXR0bGUgYml0IGNv
bmZ1c2VkIGFib3V0IHRoaXMgY2hlY2sgd2hldGhlciBpdCdzIHJlcXVpcmVkIG9yIG5vdA0KPiA+
IFBsZWFzZSBjb3VsZCB5b3UgcG9pbnQgbWUgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbj8NCj4gPg0K
PiA+IEluIGFueSBjYXNlLCB0aGFua3MgZm9yIHlvdXIgaGVscCAuLi4NCj4gPg0KPiA+IEhlcmUg
aXMgYSBkcml2ZXIgc291cmNlIGxvY2F0ZWQgaW46IGxpbnV4L2RyaXZlcnMvbWlzYy94aWxpbnhf
c2RmZWMuYw0KPiA+DQo+ID4gc3RhdGljIGxvbmcgeHNkZmVjX2Rldl9pb2N0bChzdHJ1Y3QgZmls
ZSAqZnB0ciwgdW5zaWduZWQgaW50IGNtZCwNCj4gPiB1bnNpZ25lZCBsb25nIGRhdGEpDQo+ID4g
ew0KPiA+IHN0cnVjdCB4c2RmZWNfZGV2ICp4c2RmZWM7DQo+ID4gdm9pZCBfX3VzZXIgKmFyZyA9
IE5VTEw7DQo+ID4gaW50IHJ2YWwgPSAtRUlOVkFMOw0KPiA+DQo+ID4gaWYgKF9JT0NfVFlQRShj
bWQpICE9IFhTREZFQ19NQUdJQykNCj4gPiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT1RUWTsN
Cj4gPg0KPiA+IC8qIGNoZWNrIGlmIGlvY3RsIGFyZ3VtZW50IGlzIHByZXNlbnQgYW5kIHZhbGlk
ICovDQo+ID4gaWYgKF9JT0NfRElSKGNtZCkgIT0gX0lPQ19OT05FKQ0KPiA+IHsNCj4gPiAgICAg
ICAgIGFyZyA9ICh2b2lkIF9fdXNlciAqKWRhdGE7DQo+ID4gICAgICAgICBpZiAoIWFyZykNCj4g
PiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJ2YWw7DQo+ID4gfQ0KPiA+DQo+IA0KPiBBbGwg
b2YgdGhpcyBjYW4gYmUgcmVtb3ZlZCwgYW5kIHJlcGxhY2VkIHdpdGggdW5jb25kaXRpb25hbA0K
PiANCj4gICAgICB2b2lkIF9fdXNlciAqYXJnID0gKHZvaWQgX191c2VyICopZGF0YTsNCj4gICAg
ICBpbnQgcnZhbDsNCj4gDQo+IHdpdGggYW4gInJ2YWwgPSAtRU5PVFRZIiBhZGRlZCBpbiB0aGUg
J2RlZmF1bHQnIGNhc2UuIFRoaXMgd2lsbA0KPiBtYWtlIGl0IGJlaGF2ZSBtb3JlIGxpa2Ugb3Ro
ZXIgZHJpdmVycywgcmV0dXJuaW5nIC1FTk9UVFkgZm9yDQo+IGFueSB1bmtub3duIGlvY3RsIGNv
bW1hbmQsIGFuZCByZXR1cm5pbmcgLUVGQVVMVCBmb3IgYWxsDQo+IGludmFsaWQgcG9pbnRlcnMs
IGluY2x1ZGluZyBOVUxMLg0KDQpZZXAsIHRoZSB0aGluZyB0byByZW1lbWJlciBpcyB0aGF0IGV2
ZW4gaWYgeW91IGFjdHVhbGx5DQp2ZXJpZmllZCB0aGF0IHRoZSB1c2VyIGJ1ZmZlciBjb3VsZCBi
ZSBhY2Nlc3NlZCBvbiBlbnRyeQ0KdG8gdGhlIGlvY3RsIGNvZGUgYW5vdGhlciBhcHBsaWNhdGlv
biB0aHJlYWQgY291bGQgdW5tYXANCnRoZSBtZW1vcnkgYXJlYSBiZWZvcmUgeW91IGRvIGEgbGF0
ZXIgYWNjZXNzLg0KDQpXaGF0IHlvdSBtYXkgd2FudCB0byBkbyBpcyBjb3B5IHRoZSB1c2VyIGJ1
ZmZlciBpbnRvIGENCmtlcm5lbCBidWZmZXIgYXQgdGhlIHRvcCBvZiB0aGUgaW9jdGwgY29kZSBh
bmQgd3JpdGUgaXQNCmJhY2sgYXQgdGhlIGJvdHRvbS4NCkJ1dCBkbyBtYWtlIGFic29sdXRlbHkg
c3VyZSB5b3UgZG9uJ3Qgb3ZlcmZsb3cgdGhlIGtlcm5lbA0KYnVmZmVyIG9mIGFjY2VzcyBiZXlv
bmQgaXRzIGVuZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

