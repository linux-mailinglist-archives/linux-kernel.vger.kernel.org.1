Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FBE2B8EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgKSJbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:31:03 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:21517 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbgKSJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:31:02 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-220--Y-lcYUAMEG_EoAlzMORdQ-1; Thu, 19 Nov 2020 09:30:57 +0000
X-MC-Unique: -Y-lcYUAMEG_EoAlzMORdQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 19 Nov 2020 09:30:56 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 19 Nov 2020 09:30:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Airlie' <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <ray.huang@amd.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Subject: RE: Linux 5.10-rc4
Thread-Topic: Linux 5.10-rc4
Thread-Index: AQHWu7P6i7HOJgcGCEellKywj802qKnNzjYQgAB+qGeAACacEIAAOFJJgACIcRA=
Date:   Thu, 19 Nov 2020 09:30:56 +0000
Message-ID: <886a1e597e784b42a0fd490b85aa4936@AcuMS.aculab.com>
References: <CAHk-=wjFfAktnadOPb_iV5nKh=V5Am1sG-gciYveswRtuEkrLQ@mail.gmail.com>
 <692820a49ded436591b5fe3a18c68a5e@AcuMS.aculab.com>
 <CAHk-=wgQY7k_3NVCbaSmiJyLiAV_1TgwLk-d4QRMHMWqM5Oo_w@mail.gmail.com>
 <0a10da3d-085f-c7a7-0053-dc1e9ea871ed@suse.de>
 <f7be660da595411ab60aaa4b76008769@AcuMS.aculab.com>
 <CAKMK7uFZhVqEzjfHszQ=1KeoRecXSDa0+tdH_rT8yENY9zasyQ@mail.gmail.com>
 <CAPM=9tw7_BU1_mUVa8ZeqsXfsN_cODsTzTAXiQkDGT+i1v0JaQ@mail.gmail.com>
 <CAPM=9twMArmaJ9rqxDzhZh+dwgVuTdAXrtzFK+TpSe_9xSKDOA@mail.gmail.com>
In-Reply-To: <CAPM=9twMArmaJ9rqxDzhZh+dwgVuTdAXrtzFK+TpSe_9xSKDOA@mail.gmail.com>
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

RnJvbTogRGF2ZSBBaXJsaWUNCj4gU2VudDogMTkgTm92ZW1iZXIgMjAyMCAwMToxNg0KPiANCj4g
T24gVGh1LCAxOSBOb3YgMjAyMCBhdCAwODoyNSwgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAZ21haWwu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgMTkgTm92IDIwMjAgYXQgMDg6MTUsIERhbmll
bCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9u
IFdlZCwgTm92IDE4LCAyMDIwIGF0IDExOjAxIFBNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBUaG9tYXMgWmltbWVy
bWFubg0KPiA+ID4gPiA+IFNlbnQ6IDE4IE5vdmVtYmVyIDIwMjAgMTk6MzcNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEhpDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbSAxOC4xMS4yMCB1bSAxOToxMCBz
Y2hyaWViIExpbnVzIFRvcnZhbGRzOg0KPiA+ID4gPiA+ID4gT24gV2VkLCBOb3YgMTgsIDIwMjAg
YXQgNDoxMiBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3VsYWIuY29tPiB3cm90ZToN
Cj4gPiA+ID4gPiA+Pg0KPiA+ID4gPiA+ID4+IEkndmUgZ290IHRoZSAnc3BsYXQnIGJlbG93IGR1
cmluZyBib290Lg0KPiA+ID4gPiA+ID4+IFRoaXMgaXMgYW4gOC1jb3JlIEMyNzU4IEF0b20gY3B1
IHVzaW5nIHRoZSBvbi1ib2FyZC9jcHUgZ3JhcGhpY3MuDQo+ID4gPiA+ID4gPj4gVXNlciBzcGFj
ZSBpcyBVYnVudHUgMjAuMDQuDQo+ID4gPiA+ID4gPj4NCj4gPiA+ID4gPiA+PiBBZGRpdGlvbmFs
bHkgdGhlIFggZGlzcGxheSBoYXMgYWxsIHRoZSBjb2xvdXJzIGFuZCBhbGlnbm1lbnQgc2xpZ2h0
bHkNCj4gPiA+ID4gPiA+PiBtZXNzZWQgdXAuDQo+ID4gPiA+ID4gPj4gNS45LjAgd2FzIG9rLg0K
PiA+ID4gPiA+ID4+IEknbSBqdXN0IGd1ZXNzaW5nIHRoZSB0d28gaXNzdWVzIGFyZSByZWxhdGVk
Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNvdW5kcyBsaWtlbHkuICBCdXQgaXQgd291bGQg
YmUgbG92ZWx5IGlmIHlvdSBjb3VsZCBiaXNlY3Qgd2hlbg0KPiA+ID4gPiA+ID4gZXhhY3RseSB0
aGUgcHJvYmxlbShzKSBzdGFydGVkIHRvIGJvdGggdmVyaWZ5IHRoYXQsIGFuZCBqdXN0IHRvDQo+
ID4gPiA+ID4gPiBwaW5wb2ludCB0aGUgZXhhY3QgY2hhbmdlLi4NCj4gPiA+ID4NCj4gPiA+ID4g
SSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHdoYXQgJ2dpdCBiaXNlY3QnIGRpZC4NCj4gPiA+ID4g
SSB3YXMgYmlzZWN0aW5nIGJldHdlZW4gdjUuOSBhbmQgdjUuMTAtcmMxIGJ1dCBpdCBzdWRkZW5s
eSBzdGFydGVkDQo+ID4gPiA+IGdlbmVyYXRpbmcgdjUuOS4wLXJjNSsga2VybmVscy4NCj4gPiA+
DQo+ID4gPiBXZSBxdWV1ZSB1cCBwYXRjaGVzIGZvciAtcmMxIHdheSBiZWZvcmUgdGhlIHByZXZp
b3VzIGtlcm5lbCBpcw0KPiA+ID4gcmVsZWFzZWQsIHNvIHRoaXMgaXMgbm9ybWFsLg0KPiA+ID4N
Cj4gPiA+ID4gVGhlIGlkZW50aWZpZWQgY29tbWl0IHdhcyAxM2E4ZjQ2ZDgwMyBkcm0vdHRtOiBt
b3ZlIGdob3N0IG9iamVjdCBjcmVhdGVkLg0KPiA+ID4gPiAocmV0eXBlZCAtIGhvcGUgaXQgaXMg
cmlnaHQpLg0KPiA+ID4gPiBCdXQgdGhlIGRpZmYgdG8gdGhhdCBsYXN0ICdnb29kJyBjb21taXQg
aXMgbWFzc2l2ZS4NCj4gPiA+DQo+ID4gPiBZZWFoIHRoYXQncyBhbHNvIG5vcm1hbCBmb3Igbm9u
LWxpbmVhciBoaXN0b3J5LiBJZiB5b3Ugd2FudCB0bw0KPiA+ID4gZG91YmxlLWNoZWNrLCByZS10
ZXN0IHRoZSBwYXJlbnQgb2YgdGhhdCBjb21taXQgKHdoaWNoIGlzIDJlZTQ3NmY3N2ZmZQ0KPiA+
ID4gKCJkcm0vdHRtOiBhZGQgYSBzaW1wbGUgYXNzaWduIG1lbSB0byBibyB3cmFwcGVyIikpLCB3
aGljaCBzaG91bGQNCj4gPiA+IHdvcmssIGFuZCB0aGVuIHRoZSBiYWQgY29tbWl0Lg0KPiA+ID4N
Cj4gPiA+IEFsc28gaXMgdGhpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdCBmb3IgYm90aCB0aGUgc3Bs
YXQgYW5kIHRoZSBzY3JlZW4NCj4gPiA+IGNvcnJ1cHRpb24gaXNzdWVzPw0KPiA+ID4NCj4gPiA+
ID4gU28gSSBkb24ndCBrbm93IGlmIHRoYXQgaXMgYW55d2hlcmUgbmVhciByaWdodC4NCj4gPiA+
DQo+ID4gPiBUaG9tYXMgZ3Vlc3NlZCBpdCBjb3VsZCBiZSBhIHR0bSBjaGFuZ2UsIHlvdSBoaXQg
b25lLCBhbmQgaXQgbG9va3MNCj4gPiA+IGxpa2UgaXQgY291bGQgYmUgdGhlIGN1bHByaXQuIE5v
dyBJIGd1ZXNzIGl0J3MgdXAgdG8gRGF2ZS4gQWxzbyBhZGRpbmcNCj4gPiA+IENocmlzdGlhbiwg
aW4gY2FzZSBoZSBoYXMgYW4gaWRlYS4NCj4gPg0KPiA+IEknZCBiZSBtaWxkbHkgc3VycHJpc2Vk
IGlmIGl0J3MgdGhhdCBjb21taXQsIHNpbmNlIGl0IGp1c3QgcmVmYWN0b3JzDQo+ID4gd2hhdCBs
b29rcyB0byBtZSB0byBiZSB0d28gaWRlbnRpY2FsIGNvZGUgcGllY2VzIGludG8gb25lIGluc3Rh
bmNlDQo+ID4gKHdpdGhpbiB0aGUgc2NvcGUgb2YgbWUgc2NyZXdpbmcgdGhhdCB1cCwgYnV0IHJl
YWRpbmcgaXQgSSBjYW4ndCBzZWUNCj4gPiBpdCkuDQo+ID4NCj4gPiBJJ2xsIGRpZyBpbnRvIHRo
aXMgdG9kYXkuDQo+IA0KPiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gv
NDAxNTU5Lw0KPiANCj4gc2hvdWxkIGZpeCBpdC4NCg0KTm9wZSwgYW5kIHByb2JhYmx5IG5vdCBy
ZWxldmFudC4NCnBsX2ZsYWdzIGlzIDIgb3IgMyBhbmQgaXQgaXMgdGVzdGluZyBmb3IgNC4NCg0K
VGhlIG9sZGVzdCBrZXJuZWwgZG9lc24ndCBnZW5lcmF0ZSB0aGUgJ3NwbGF0JyBlaXRoZXIuDQpK
dXN0IHRoZSBmKmNrZWQgdXAgZGlzcGxheSBvdXRwdXQuDQoNCkknbGwgcHV0IGEgc2NyZWVuc2hv
dCAocGhvdG8pIGludG8gYW5vdGhlciBlbWFpbC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

