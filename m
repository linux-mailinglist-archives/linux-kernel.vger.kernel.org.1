Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6A22A7C90
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgKELFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:05:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:36963 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729922AbgKELFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:05:00 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-274-4IrfFHVJNbmzEx_V1Cbj9g-1; Thu, 05 Nov 2020 11:04:55 +0000
X-MC-Unique: 4IrfFHVJNbmzEx_V1Cbj9g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 5 Nov 2020 11:04:55 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 5 Nov 2020 11:04:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiri Slaby' <jirislaby@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "paulkf@microgate.com" <paulkf@microgate.com>
Subject: RE: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
Thread-Topic: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
Thread-Index: AQHWs1OOseTjfttl5U67c83KY45gVqm5Xxyw
Date:   Thu, 5 Nov 2020 11:04:54 +0000
Message-ID: <6515b9ff5a9343f5a713e337f41450cc@AcuMS.aculab.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
 <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
In-Reply-To: <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
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

PiA+PiBBbmQgdGhlIGxvb3AgY2FuIGJlIHR1cm5lZCBpbnRvIG5kZWxheToNCj4gPj4NCj4gPj4g
ICAgICAgICAgLyoNCj4gPj4gICAgICAgICAgICogRm9yY2UgYXQgbGVhc3QgMTcwbnMgZGVsYXkg
YmVmb3JlIGNsZWFyaW5nDQo+ID4+ICAgICAgICAgICAqIHJlc2V0IGJpdC4gRWFjaCByZWFkIGZy
b20gTENSIHRha2VzIGF0IGxlYXN0DQo+ID4+ICAgICAgICAgICAqIDMwbnMgc28gMTAgdGltZXMg
Zm9yIDMwMG5zIHRvIGJlIHNhZmUuDQo+ID4+ICAgICAgICAgICAqLw0KPiA+PiAgICAgICAgICBm
b3IoaT0wO2k8MTA7aSsrKQ0KPiA+PiAgICAgICAgICAgICAgICAgIHJlYWR2YWwgPSAqTWlzY0N0
cmw7DQo+ID4NCj4gPiBBZ2Fpbiwgc2luY2UgSSBjYW4ndCB0ZXN0IHRoaXMsIEkgZG8gbm90IHdh
bnQgdGhpcyBwYXRjaCB0byBjb250YWluDQo+ID4gYW55IGZ1bmN0aW9uYWwgY2hhbmdlcy4gIEFG
QUlDLCB0aGUgMTAgcmVnaXN0ZXIgcmVhZHMgbXVzdCBzdGlsbA0KPiA+IGhhcHBlbiBhZnRlciB0
aGlzIHBhdGNoIGlzIGFwcGxpZWQuDQoNCllvdSBjYW4ndCB1c2UgbmRlbGF5KCk7IHRoZSB3cml0
ZXMgY2FuIGdldCBwb3N0ZWQgc28gY2FuIGFwcGVhcg0KbXVjaCBjbG9zZXIgdG9nZXRoZXIgYnkg
dGhlIHRpbWUgdGhleSBnZXQgdG8gdGhlIGFjdHVhbCBoYXJkd2FyZS4NCk11bHRpcGxlIHZvbGF0
aWxlIHJlYWRzIGRvbid0IG5lZWQgYSB0YXJnZXQgdmFyaWFibGUuDQooU2hvdWxkbid0IHRoZXkg
YWxzbyByZWFsIHJlYWRsKCk/KQ0KDQpEZWxldGluZyB0aGUgZHJpdmVyIHdvcmtzLi4uDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

