Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357B52BAF29
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgKTPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:39:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50811 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729380AbgKTPjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:39:21 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-48-2DVZji6aPsmuGTvzOENjVg-1; Fri, 20 Nov 2020 15:39:17 +0000
X-MC-Unique: 2DVZji6aPsmuGTvzOENjVg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 15:39:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 15:39:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Zimmermann' <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <ray.huang@amd.com>, Dave Airlie <airlied@redhat.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Subject: RE: Linux 5.10-rc4; graphics alignment
Thread-Topic: Linux 5.10-rc4; graphics alignment
Thread-Index: Ada/IUdqcU2WLz13TDyBa91ssXd9zQABIUYAAAEibgAAAW3SAAAAkehgAAGiZoAAAIjkIAAB97YAAANWzKA=
Date:   Fri, 20 Nov 2020 15:39:16 +0000
Message-ID: <fd7e7817781a43eb857fceb971502511@AcuMS.aculab.com>
References: <2c474745ae884de3b4ecb8abe2152bfd@AcuMS.aculab.com>
 <fa5c887e-82d8-5347-ff18-85e3628dadbe@suse.de>
 <c01d2d95f1e64be984cff71e7bdf1c84@AcuMS.aculab.com>
 <c9bae016-413f-0db9-c9ee-d6f39d24a6ab@suse.de>
 <fa6346190d0b4936934d1f1359e5b71f@AcuMS.aculab.com>
 <fd66bfcc-072a-ddfb-0d12-af4a5207820d@suse.de>
 <ec3130c3d22a4d4dafe020d30fd224cd@AcuMS.aculab.com>
 <7d42ee6b-d72b-9f4d-21fe-4f5981eb425e@suse.de>
In-Reply-To: <7d42ee6b-d72b-9f4d-21fe-4f5981eb425e@suse.de>
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

RnJvbTogVGhvbWFzIFppbW1lcm1hbm4NCj4gU2VudDogMjAgTm92ZW1iZXIgMjAyMCAxMzo0Mg0K
Li4uDQo+IEkgZGlkIGEgZGlmZiBmcm9tIHY1LjEwLXJjNCB0byBkcm0tdGlwIHRvIGxvb2sgZm9y
IHN1c3BpY2lvdXMgY2hhbmdlcy4NCj4gU29tZSBjYW5kaWRhdGVzIGFyZQ0KPiANCj4gICAgOGUz
Nzg0ZGZlZjhhICgiZHJtL2FzdDogUmVsb2FkIGdhbW1hIExVVCBhZnRlciBjaGFuZ2luZyBwcmlt
YXJ5DQo+IHBsYW5lJ3MgY29sb3IgZm9ybWF0IikNCg0KT2ssIHRoYXQgb25lIGZpeGVzIHRoZSBz
Y3JlZW4gY29sb3VycyAoZXRjKS4NClNvIDhlMzc4NGRmZWY4YSB3YXMgZ29vZCBhbmQgdGhlbiBI
RUFEXiB3YXMgYmFkLg0KDQpJIG1pZ2h0IHRyeSB0byBiaXNlY3QgdGhlIGJyZWFrYWdlLg0KDQpU
aGUgc3RhY2sgc3BsYXQgaXMgZW50aXJlbHkgZGlmZmVyZW50Lg0KSSdsbCB0cnkgdG8gYmlzZWN0
IHRoYXQgb24gTGludXMncyB0cmVlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

