Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FA92D7137
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391964AbgLKIIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:08:30 -0500
Received: from smtp.h3c.com ([60.191.123.50]:47544 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387443AbgLKIIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:08:06 -0500
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 0BB6A2V6076745
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 14:10:02 +0800 (GMT-8)
        (envelope-from gao.yanB@h3c.com)
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam02-ex.h3c.com with ESMTP id 0BB697wM073602;
        Fri, 11 Dec 2020 14:09:07 +0800 (GMT-8)
        (envelope-from gao.yanB@h3c.com)
Received: from DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 11 Dec 2020 14:09:09 +0800
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([fe80::81d1:43f5:5563:4c58])
 by DAG2EX08-IDC.srv.huawei-3com.com ([fe80::81d1:43f5:5563:4c58%10]) with
 mapi id 15.01.2106.002; Fri, 11 Dec 2020 14:09:09 +0800
From:   Gaoyan <gao.yanB@h3c.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianxianting <tian.xianting@h3c.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIFt2Ml0gdHR5OiBQcm90ZWN0IGRpc2NfZGF0YSBp?=
 =?utf-8?B?biBuX3R0eV9jbG9zZSBhbmQgbl90dHlfZmx1c2hfYnVmZmVy?=
Thread-Topic: [PATCH] [v2] tty: Protect disc_data in n_tty_close and
 n_tty_flush_buffer
Thread-Index: AQHWzp15rcbAW2mlAUelugKRa08EAKnvVhAAgAHvFMA=
Date:   Fri, 11 Dec 2020 06:09:09 +0000
Message-ID: <b47fb47ba70d42978c73436370ae44bb@h3c.com>
References: <20201210022507.30729-1-gao.yanB@h3c.com>
 <X9G+bJSGQc6QIxLR@kroah.com>
In-Reply-To: <X9G+bJSGQc6QIxLR@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.161.27]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0BB697wM073602
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyBLSO+8mg0KCUkgdHJ5IHRvIHJlcHJvZHVjZSB0aGlzIHByb2JsZW0gaW4gdGVzdGlu
ZywgYnV0IGl0IGlzIGRpZmZpY3VsdCB0byBoYXBwZW4gYWdhaW4uIEl0IGlzIGhhcmQgdG8gZ3Jh
c3AgdGhlIHRpbWluZw0KdGhhdCBuX3R0eV9mbHVzaF9idWZmZXIgYWNjZXNzZXMgdGhlIGRpc2Nf
ZGF0YSB3aGljaCB3YXMganVzdCBzZXQgdG8gTlVMTCBieSBuX3R0eV9jbG9zZS4NCg0KVGhhbmtz
DQpHYW8gWWFuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogR3JlZyBLSCBb
bWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnXSANCuWPkemAgeaXtumXtDogMjAyMOW5
tDEy5pyIMTDml6UgMTQ6MjINCuaUtuS7tuS6ujogZ2FveWFuIChSRCkgPGdhby55YW5CQGgzYy5j
b20+DQrmioTpgIE6IGppcmlzbGFieUBrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyB0aWFueGlhbnRpbmcgKFJEKSA8dGlhbi54aWFudGluZ0BoM2MuY29tPg0K5Li76aKY
OiBSZTogW1BBVENIXSBbdjJdIHR0eTogUHJvdGVjdCBkaXNjX2RhdGEgaW4gbl90dHlfY2xvc2Ug
YW5kIG5fdHR5X2ZsdXNoX2J1ZmZlcg0KDQpPbiBUaHUsIERlYyAxMCwgMjAyMCBhdCAxMDoyNTow
N0FNICswODAwLCBZYW4uR2FvIHdyb3RlOg0KPiBuX3R0eV9mbHVzaF9idWZmZXIgY2FuIGhhcHBl
biBpbiBwYXJhbGxlbCB3aXRoIG5fdHR5X2Nsb3NlIHRoYXQgdGhlDQo+IHR0eS0+ZGlzY19kYXRh
IHdpbGwgYmUgc2V0IHRvIE5VTEwuIG5fdHR5X2ZsdXNoX2J1ZmZlciBhY2Nlc3NlcyANCj4gdHR5
LT5kaXNjX2RhdGEsIHNvIHdlIG11c3QgcHJldmVudCBuX3R0eV9jbG9zZSBjbGVhciB0dHktPmRp
c2NfZGF0YQ0KPiB3aGlsZSBuX3R0eV9mbHVzaF9idWZmZXIgIGhhcyBhIG5vbi1OVUxMIHZpZXcg
b2YgdHR5LT5kaXNjX2RhdGEuDQo+IA0KPiBTbyB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IGFj
Y2Vzc2VzIHRvIGRpc2NfZGF0YSBhcmUgYXRvbWljIHVzaW5nDQo+IHR0eS0+dGVybWlvc19yd3Nl
bS4NCj4gDQo+IFRoZXJlIGlzIGFuIGV4YW1wbGUgSSBtZWV0Og0KPiBXaGVuIG5fdHR5X2ZsdXNo
X2J1ZmZlciBhY2Nlc3NlcyB0dHkgc3RydWN0LCB0aGUgZGlzY19kYXRhIGlzIHJpZ2h0Lg0KPiBI
b3dldmVyLCB0aGVuIHJlc2V0X2J1ZmZlcl9mbGFncyBhY2Nlc3NlcyB0dHktPmRpc2NfZGF0YSwg
ZGlzY19kYXRhIA0KPiBiZWNvbWUgTlVMTCwgU28ga2VybmVsIGNyYXNoIHdoZW4gYWNjZXNzZXMg
dHR5LT5kaXNjX2RhdGEtPnJlYWxfdGFpbC4NCj4gSSBndWVzcyB0aGVyZSBjb3VsZCBiZSBhbm90
aGVyIHRocmVhZCBjaGFuZ2UgdHR5LT5kaXNjX2RhdGEgdG8gTlVMTCwgDQo+IGFuZCBkdXJpbmcg
Tl9UVFkgbGluZSBkaXNjaXBsaW5lLCBuX3R0eV9jbG9zZSB3aWxsIHNldCB0dHktPmRpc2NfZGF0
YSANCj4gdG8gYmUgTlVMTC4gU28gdXNlIHR0eS0+dGVybWlvc19yd3NlbSB0byBwcm90ZWN0IGRp
c2NfZGF0YSBiZXR3ZWVuIA0KPiBjbG9zZSBhbmQgZmx1c2hfYnVmZmVyLg0KPiANCj4gSVA6IHJl
c2V0X2J1ZmZlcl9mbGFncysweDkvMHhmMA0KPiBQR0QgMCBQNEQgMA0KPiBPb3BzOiAwMDAyIFsj
MV0gU01QDQo+IENQVTogMjMgUElEOiAyMDg3NjI2IENvbW06IChhZ2V0dHkpIEtkdW1wOiBsb2Fk
ZWQgVGFpbnRlZDogRyBIYXJkd2FyZSANCj4gbmFtZTogVU5JU0lOU0lHSFQgWDMwMzZQLUczL1NU
MDFNMkM3UywgQklPUyAyLjAwLjEzIDAxLzExLzIwMTkNCj4gdGFzazogZmZmZjljNGU5ZGE3MWU4
MCB0YXNrLnN0YWNrOiBmZmZmYjMwY2ZlODk4MDAwDQo+IFJJUDogMDAxMDpyZXNldF9idWZmZXJf
ZmxhZ3MrMHg5LzB4ZjANCj4gUlNQOiAwMDE4OmZmZmZiMzBjZmU4OWJjYTggRUZMQUdTOiAwMDAx
MDI0Ng0KPiBSQVg6IGZmZmY5YzRlOWRhNzFlODAgUkJYOiBmZmZmOWMzNjhkMWJhYzAwIFJDWDog
MDAwMDAwMDAwMDAwMDAwMA0KPiBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmOWM0ZWEx
N2I1MGYwIFJESTogMDAwMDAwMDAwMDAwMDAwMA0KPiBSQlA6IGZmZmZiMzBjZmU4OWJjYzggUjA4
OiAwMDAwMDAwMDAwMDAwMTAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMQ0KPiBSMTA6IDAwMDAwMDAw
MDAwMDAwMDEgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogZmZmZjljMzY4ZDFiYWNjMA0KPiBS
MTM6IGZmZmY5YzIwY2ZkMTg0MjggUjE0OiBmZmZmOWM0ZWExN2I1MGYwIFIxNTogZmZmZjljMzY4
ZDFiYWMwMA0KPiBGUzogIDAwMDA3ZjlmYmJlOTc5NDAoMDAwMCkgR1M6ZmZmZjljMzc1Yzc0MDAw
MCgwMDAwKQ0KPiBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+IENTOiAgMDAxMCBEUzogMDAwMCBF
UzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gQ1IyOiAwMDAwMDAwMDAwMDAyMjYwIENS
MzogMDAwMDAwMmY3MjIzMzAwMyBDUjQ6IDAwMDAwMDAwMDA3NjA2ZTANCj4gRFIwOiAwMDAwMDAw
MDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDANCj4g
RFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAw
MDAwMDA0MDANCj4gUEtSVTogNTU1NTU1NTQNCj4gQ2FsbCBUcmFjZToNCj4gPyBuX3R0eV9mbHVz
aF9idWZmZXIrMHgyYS8weDYwDQo+IHR0eV9idWZmZXJfZmx1c2grMHg3Ni8weDkwDQo+IHR0eV9s
ZGlzY19mbHVzaCsweDIyLzB4NDANCj4gdnRfaW9jdGwrMHg1YTcvMHgxMGIwDQo+ID8gbl90dHlf
aW9jdGxfaGVscGVyKzB4MjcvMHgxMTANCj4gdHR5X2lvY3RsKzB4ZWYvMHg4YzANCj4gZG9fdmZz
X2lvY3RsKzB4YTcvMHg1ZTANCj4gPyBfX2F1ZGl0X3N5c2NhbGxfZW50cnkrMHhhZi8weDEwMA0K
PiA/IHN5c2NhbGxfdHJhY2VfZW50ZXIrMHgxZDAvMHgyYjANCj4gU3lTX2lvY3RsKzB4NzkvMHg5
MA0KPiBkb19zeXNjYWxsXzY0KzB4NmMvMHgxYjANCj4gZW50cnlfU1lTQ0FMTDY0X3Nsb3dfcGF0
aCsweDI1LzB4MjUNCj4gDQo+IG5fdHR5X2ZsdXNoX2J1ZmZlcgkJCS0tLT50dHktPmRpc2NfZGF0
YSBpcyBPSw0KPiAJLT5yZXNldF9idWZmZXJfZmxhZ3MJCSAtLT50dHktPmRpc2NfZGF0YSBpcyBO
VUxMDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW4uR2FvIDxnYW8ueWFuQkBoM2MuY29tPg0KPiBS
ZXZpZXdlZC1ieTogWGlhbnRpbmcgVGlhbiA8dGlhbi54aWFudGluZ0BoM2MuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvdHR5L25fdHR5LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvbl90dHkuYyBiL2RyaXZl
cnMvdHR5L25fdHR5LmMgaW5kZXggDQo+IDdlNWUzNjMxNS4uZTc4MTI0Y2UxIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3R0eS9uX3R0eS5jDQo+ICsrKyBiL2RyaXZlcnMvdHR5L25fdHR5LmMNCj4g
QEAgLTE4OTIsOCArMTg5MiwxMCBAQCBzdGF0aWMgdm9pZCBuX3R0eV9jbG9zZShzdHJ1Y3QgdHR5
X3N0cnVjdCAqdHR5KQ0KPiAgCWlmICh0dHktPmxpbmspDQo+ICAJCW5fdHR5X3BhY2tldF9tb2Rl
X2ZsdXNoKHR0eSk7DQo+ICANCj4gKwlkb3duX3dyaXRlKCZ0dHktPnRlcm1pb3NfcndzZW0pOw0K
PiAgCXZmcmVlKGxkYXRhKTsNCj4gIAl0dHktPmRpc2NfZGF0YSA9IE5VTEw7DQo+ICsJdXBfd3Jp
dGUoJnR0eS0+dGVybWlvc19yd3NlbSk7DQo+ICB9DQo+ICANCj4gIC8qKg0KDQpTbyBkb2VzIHRo
aXMgc29sdmUgeW91ciBwcm9ibGVtIGluIHRlc3Rpbmc/ICBEbyB5b3UgaGF2ZSBhIHJlcHJvZHVj
ZXIgZm9yIHRoaXMgcHJvYmxlbT8NCg0KdGhhbmtzLA0KDQpncmVnIGstaA0K
