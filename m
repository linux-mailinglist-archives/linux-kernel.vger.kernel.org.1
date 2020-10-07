Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EEC286833
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgJGTYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:24:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:32207 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgJGTYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:24:42 -0400
IronPort-SDR: tDyrU7U75mfKPhjmxC85Rc3MajOtYhk9SpLH2g0JnB1OiyRAKe4aKUwxH9VKVicI48w2wX2IL5
 /m9vaFNl3Ajg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="161655064"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="161655064"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 11:50:01 -0700
IronPort-SDR: 7RKU4VJvSnzh5FnxL9EOGyi7kDMW7aLBr1K+QfsdxGwtGYyzsxirl3jqBQkWOlwU2icRJ/SE2L
 UOM+9hroVSRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="343017228"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 07 Oct 2020 11:49:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 11:49:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 11:49:51 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 7 Oct 2020 11:49:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>
CC:     "Song, Youquan" <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/6] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Thread-Topic: [PATCH v3 4/6] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Thread-Index: AQHWnCT17+9Ws/dhkkin3XtBvwzdU6mMQ0IAgAA1M7A=
Date:   Wed, 7 Oct 2020 18:49:51 +0000
Message-ID: <c0791688c58f434ca9e413630504d22d@intel.com>
References: <20201005163130.GD21151@zn.tnic>
 <20201006210910.21062-1-tony.luck@intel.com>
 <20201006210910.21062-5-tony.luck@intel.com>
 <c994091cdc9d42718769f584b7d4a134@AcuMS.aculab.com>
In-Reply-To: <c994091cdc9d42718769f584b7d4a134@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gTWFjaGluZSBjaGVja3MgYXJlIG1vcmUgc2VyaW91cy4gSnVzdCBnaXZlIHVwIGF0IHRoZSBw
b2ludCB3aGVyZSB0aGUNCj4+IG1haW4gY29weSBsb29wIHRyaWdnZXJlZCB0aGUgI01DIGFuZCBy
ZXR1cm4gZnJvbSB0aGUgY29weSBjb2RlIGFzIGlmDQo+PiB0aGUgY29weSBzdWNjZWVkZWQuIFRo
ZSBtYWNoaW5lIGNoZWNrIGhhbmRsZXIgd2lsbCB1c2UgdGFza193b3JrX2FkZCgpIHRvDQo+PiBt
YWtlIHN1cmUgdGhhdCB0aGUgdGFzayBpcyBzZW50IGEgU0lHQlVTLg0KPg0KPiBJc24ndCB0aGF0
IGp1c3QgcGxhaW4gd3Jvbmc/DQoNCkl0IGlzbid0IHByZXR0eS4gSSdtIG5vdCBzdXJlIGhvdyB3
cm9uZyBpdCBpcy4NCg0KPiBJZiBjb3B5IGlzIHJlcG9ydGVkIGFzIHN1Y2NlZWRpbmcgdGhlIGtl
cm5lbCBjb2RlIHdpbGwgdXNlIHRoZSAnb2xkJw0KPiBkYXRhIHRoYXQgaXMgaW4gdGhlIGJ1ZmZl
ciBhcyBpZiBpdCBoYWQgYmVlbiByZWFkIGZyb20gdXNlcnNwYWNlLg0KPiBUaGlzIGNvdWxkIGVu
ZCB1cCB3aXRoIGtlcm5lbCBzdGFjayBkYXRhIGJlaW5nIHdyaXR0ZW4gdG8gYSBmaWxlLg0KDQpJ
IHJhbiBhIHRlc3Qgd2l0aDoNCg0KCXdyaXRlKGZkLCBidWYsIDUxMikNCg0KV2l0aCBwb2lzb24g
aW5qZWN0ZWQgaW50byBidWZbMjU2XSB0byBmb3JjZSBhIG1hY2hpbmUgY2hlY2sgbWlkLWNvcHku
DQoNClRoZSBzaXplIG9mIHRoZSBmaWxlIGRpZCBnZXQgaW5jcmVtZW50ZWQgYnkgNTEyIHJhdGhl
ciB0aGFuIDI1Ni4gV2hpY2ggaXNuJ3QgZ29vZC4NCg0KVGhlIGRhdGEgaW4gdGhlIGZpbGUgdXAg
dG8gdGhlIDI1NiBieXRlIG1hcmsgd2FzIHRoZSB1c2VyIGRhdGEgZnJvbSBidWZbMCAuLi4gMjU1
XS4NCg0KVGhlIGRhdGEgaW4gdGhlIGZpbGUgcGFzdCBvZmZzZXQgMjU2IHdhcyBhbGwgemVyb2Vz
LiBJIHN1c3BlY3QgdGhhdCBpc24ndCBieSBjaGFuY2UuDQpUaGUga2VybmVsIGhhcyB0byBkZWZl
bmQgYWdhaW5zdCBhIHVzZXIgd3JpdGluZyBhIHBhcnRpYWwgcGFnZSBhbmQgdXNpbmcgbW1hcCgy
KQ0Kb24gdGhlIHNhbWUgZmlsZSB0byBwZWVrIGF0IGRhdGEgcGFzdCBFT0YgYW5kIHVwIHRvIHRo
ZSBuZXh0IFBBR0VfU0laRSBib3VuZGFyeS4NClNvIEkgdGhpbmsgaXQgbXVzdCB6ZXJvIG5ldyBw
YWdlcyBhbGxvY2F0ZWQgaW4gcGFnZSBjYWNoZSBhcyB0aGV5IGFyZSBhbGxvY2F0ZWQgdG8NCmEg
ZmlsZS4NCg0KPiBFdmVuIHplcm9pbmcgdGhlIHJlc3Qgb2YgdGhlIGtlcm5lbCBidWZmZXIgaXMg
d3JvbmcuDQoNCkl0IHdvdWxkbid0IGhlbHAvY2hhbmdlIGFueXRoaW5nLg0KDQo+IElJUkMgdGhl
IGNvZGUgdG8gdHJ5IHRvIG1heGltaXNlIHRoZSBjb3B5IGhhcyBiZWVuIHJlbW92ZWQuDQo+IFNv
IHRoZSAnc2xvdycgcmV0cnkgd29udCBoYXBwZW4gYW55IG1vcmUuDQoNCldoaWNoIGNvZGUgaGFz
IGJlZW4gcmVtb3ZlZCAoYW5kIHdoZW4gLi4uIFRJUCwgYW5kIG15IHRlc3RpbmcsIGlzIGJhc2Vk
IG9uIDUuOS1yYzEpDQoNCi1Ub255DQoNCg==
