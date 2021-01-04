Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD82E9B52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbhADQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:48:04 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:26655 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbhADQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:48:03 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-235-IL2iOTcMOBSlpA7savvPuA-1; Mon, 04 Jan 2021 16:46:24 +0000
X-MC-Unique: IL2iOTcMOBSlpA7savvPuA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 4 Jan 2021 16:46:24 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 4 Jan 2021 16:46:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     X86 ML <x86@kernel.org>
Subject: RE: in_compat_syscall() on x86
Thread-Topic: in_compat_syscall() on x86
Thread-Index: Adbikf8I52+Fp/HYSH2MXxqk00t/OgAJxC1g
Date:   Mon, 4 Jan 2021 16:46:24 +0000
Message-ID: <cb9ca8138c664b8bacb26521e9a604fc@AcuMS.aculab.com>
References: <e817cfdc2df3433bb7fb357db89d4d48@AcuMS.aculab.com>
In-Reply-To: <e817cfdc2df3433bb7fb357db89d4d48@AcuMS.aculab.com>
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

Q29weSB4ODZAa2VybmVsLm9yZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QEFDVUxBQi5DT00+DQo+IFNlbnQ6IDA0IEph
bnVhcnkgMjAyMSAxMjoxNw0KPiBUbzogQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+
OyBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogaW5fY29tcGF0X3N5c2NhbGwoKSBvbiB4ODYNCj4gDQo+IE9uIHg4
NiBpbl9jb21wYXRfc3lzY2FsbCgpIGlzIGRlZmluZWQgYXM6DQo+ICAgICBpbl9pYTMyX3N5c2Nh
bGwoKSB8fCBpbl94MzJfc3lzY2FsbCgpDQo+IA0KPiBOb3cgaW5faWEzMl9zeXNjYWxsKCkgaXMg
YSBzaW1wbGUgY2hlY2sgb2YgdGhlIFRTX0NPTVBBVCBmbGFnLg0KPiBIb3dldmVyIGluX3gzMl9z
eXNjYWxsKCkgaXMgYSBob3JyaWQgYmVhc3QgdGhhdCBoYXMgdG8gaW5kaXJlY3QNCj4gdGhyb3Vn
aCB0byB0aGUgb3JpZ2luYWwgJWVheCB2YWx1ZSAoaWUgdGhlIHN5c2NhbGwgbnVtYmVyKSBhbmQN
Cj4gY2hlY2sgZm9yIGEgYml0IHRoZXJlLg0KPiANCj4gU28gb24gYSBrZXJuZWwgd2l0aCB4MzIg
c3VwcG9ydCAocHJvYmFibHkgbW9zdCBkaXN0cm8ga2VybmVscykNCj4gdGhlIGluX2NvbXBhdF9z
eXNjYWxsKCkgY2hlY2sgaXMgcmF0aGVyIG1vcmUgZXhwZW5zaXZlIHRoYW4NCj4gb25lIG1pZ2h0
IGV4cGVjdC4NCj4gDQo+IEl0IHdvdWxkIGJlIG11Y2sgYmV0dGVyIGlmIGJvdGggY2hlY2tzIGNv
dWxkIGJlIGRvbmUgdG9nZXRoZXIuDQo+IEkgdGhpbmsgdGhpcyB3b3VsZCByZXF1aXJlIHRoZSBz
eXNjYWxsIGVudHJ5IGNvZGUgdG8gc2V0IGENCj4gdmFsdWUgaW4gYm90aCB0aGUgNjRiaXQgYW5k
IHgzMiBlbnRyeSBwYXRocy4NCj4gKENhbiBhIHByb2Nlc3MgbWFrZSBib3RoIDY0Yml0IGFuZCB4
MzIgc3lzdGVtIGNhbGxzPykNCj4gDQo+IFRvIGRvIHRoaXMgc2Vuc2libGUgKHByb2JhYmx5KSBy
ZXF1aXJlcyBhIGJ5dGUgYmUgYWxsb2NhdGVkDQo+IHRvIGhvbGQgdGhlIHN5c2NhbGwgdHlwZSAt
IHJhdGhlciB0aGFuIHVzaW5nIGZsYWcgYml0cw0KPiBpbiB0aGUgJ3N0YXR1cycgZmllbGQuDQo+
IA0KPiBBcGFydCBmcm9tIHRoZSBzeXNjYWxsIGVudHJ5LCB0aGUgZXhlYyBjb2RlIHNlZW1zIHRv
IGNoYW5nZQ0KPiB0aGUgc3lzY2FsbCB0eXBlIHRvIHRoYXQgb2YgdGhlIGJpbmFyeSBiZWluZyBl
eGVjdXRlZC4NCj4gSSBkaWRuJ3Qgc3BvdCBhbnl0aGluZyBlbHNlIHRoYXQgY2hhbmdlcyB0aGUg
ZmllbGRzLg0KPiANCj4gQnV0IEkgZmFpbGVkIHRvIGZpbmQgdGhlIGZ1bGwgbGlzdCBvZiBhbGxv
Y2F0ZWQgYml0cyBmb3INCj4gdGhlICdzdGF0dXMnIGZpZWxkLg0KPiANCj4gCURhdmlkDQo+IA0K
PiAtDQo+IFJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KPiBSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

