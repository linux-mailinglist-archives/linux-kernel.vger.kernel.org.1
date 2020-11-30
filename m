Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD45E2C8647
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgK3OMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:12:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:38757 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgK3OMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:12:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-131-r3wjTBqRNMmT53KpPHR2ZQ-1; Mon, 30 Nov 2020 14:10:43 +0000
X-MC-Unique: r3wjTBqRNMmT53KpPHR2ZQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 30 Nov 2020 14:10:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 30 Nov 2020 14:10:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [RFC][PATCH 3/9] sh/mm: Make pmd_t similar to pte_t
Thread-Topic: [RFC][PATCH 3/9] sh/mm: Make pmd_t similar to pte_t
Thread-Index: AQHWxw2MCCB5tf9JcU+k33WObeMi+angtpDw
Date:   Mon, 30 Nov 2020 14:10:42 +0000
Message-ID: <e09e71048eb74d0c8eee68bf1f865d36@AcuMS.aculab.com>
References: <20201130112705.900705277@infradead.org>
 <20201130113602.959570640@infradead.org>
In-Reply-To: <20201130113602.959570640@infradead.org>
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

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gU2VudDogMzAgTm92ZW1iZXIgMjAyMCAxMToyNw0KPiAN
Cj4gSnVzdCBsaWtlIDY0Yml0IHB0ZV90LCBoYXZlIGEgbG93L2hpZ2ggc3BsaXQgaW4gcG1kX3Qu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4NCj4gLS0tDQo+ICBhcmNoL3NoL2luY2x1ZGUvYXNtL3BndGFibGUtM2xldmVs
LmggfCAgIDEwICsrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiAtLS0gYS9hcmNoL3NoL2luY2x1ZGUvYXNtL3BndGFibGUt
M2xldmVsLmgNCj4gKysrIGIvYXJjaC9zaC9pbmNsdWRlL2FzbS9wZ3RhYmxlLTNsZXZlbC5oDQo+
IEBAIC0yOCw5ICsyOCwxNSBAQA0KPiAgI2RlZmluZSBwbWRfRVJST1IoZSkgXA0KPiAgCXByaW50
aygiJXM6JWQ6IGJhZCBwbWQgJTAxNmxseC5cbiIsIF9fRklMRV9fLCBfX0xJTkVfXywgcG1kX3Zh
bChlKSkNCj4gDQo+IC10eXBlZGVmIHN0cnVjdCB7IHVuc2lnbmVkIGxvbmcgbG9uZyBwbWQ7IH0g
cG1kX3Q7DQo+ICt0eXBlZGVmIHN0cnVjdCB7DQo+ICsJc3RydWN0IHsNCj4gKwkJdW5zaWduZWQg
bG9uZyBwbWRfbG93Ow0KPiArCQl1bnNpZ25lZCBsb25nIHBtZF9oaWdoOw0KPiArCX07DQo+ICsJ
dW5zaWduZWQgbG9uZyBsb25nIHBtZDsNCj4gK30gcG1kX3Q7DQoNCldvdWxkIGl0IGJlIGJldHRl
ciB0byB1c2UgdTMyIGFuZCB1NjQ/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

