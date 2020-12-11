Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB91B2D7665
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436742AbgLKNR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:17:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:59311 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404965AbgLKNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:17:17 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-71-G4OXXiUXNteVUDUfFdiAaA-1; Fri, 11 Dec 2020 13:15:39 +0000
X-MC-Unique: G4OXXiUXNteVUDUfFdiAaA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 11 Dec 2020 13:15:38 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 11 Dec 2020 13:15:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Lee Jones' <lee.jones@linaro.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: bikeshed: [PATCH -next] mfd: rave-sp: convert comma to semicolon
Thread-Topic: bikeshed: [PATCH -next] mfd: rave-sp: convert comma to semicolon
Thread-Index: AdbPrprvUTsF4VOLTpOnxS9AV5J8lAAEHBqAAAAIz8A=
Date:   Fri, 11 Dec 2020 13:15:38 +0000
Message-ID: <10351cc41c244d9a8cfa6a8fb8f502c3@AcuMS.aculab.com>
References: <7416de308a9b41d3ac881210ab114159@AcuMS.aculab.com>
 <20201211131049.GE5029@dell>
In-Reply-To: <20201211131049.GE5029@dell>
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

RnJvbTogTGVlIEpvbmVzDQo+IFNlbnQ6IDExIERlY2VtYmVyIDIwMjAgMTM6MTENCi4uLg0KPiA+
IE5vd3Qgd3Jvbmcgd2l0aCBjb21tYXMuDQo+IA0KPiBXZWxsIHlvdSBsZWFybiBzb21ldGhpbmcg
bmV3IGV2ZXJ5IGRheSENCj4gDQo+ID4gV2h5IG5vdCBnbyB0aGUgb3RoZXIgd2F5Lg0KPiA+IENv
bnZlcnQgYWxtb3N0IGFsbCB0aGUgOyB0byAsIGFuZCBkZWxldGUgbW9zdCBvZiB0aGUgeyB9IGlu
DQo+ID4gaWYgYW5kIGZvciBzdGF0ZW1lbnRzIChldGMpLg0KPiANCj4gU29ycnksIEkgZG9uJ3Qg
dW5kZXJzdGFuZC4gIFBsZWFzZSBlbGFib3JhdGUvcHJvdmlkZSBhbiBleGFtcGxlLg0KDQpZb3Ug
Y2FuIChsYXJnZWx5KSByZXBsYWNlOg0KCWlmICguLi4pIHsNCgkJeHh4Ow0KCQl5eXk7DQoJfQ0K
CXp6ejsNCldpdGgNCglpZiAoLi4uKQ0KCQl4eHgsDQoJCXl5eTsNCgl6eno7DQoNClNhdmVzIGEg
dmVydGljYWwgbGluZS4uLi4NCllvdSBtYXkgbmVlZCB0byByZXBsYWNlIHNvbWUgJ2lmJyBieSA/
OiB0byBhdm9pZCB0aGUgdGVybWluYXRpbmcgOw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

