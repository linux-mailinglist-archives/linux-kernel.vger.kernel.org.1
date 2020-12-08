Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8992D2E18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgLHPWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:22:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:45503 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbgLHPWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:22:47 -0500
IronPort-SDR: epdtQP32HAMrnaDBik3cKDiiPyAPAv9tiIhLfr+hOMLZ/YDgjMaNVkFBD3vYbtxr9/KwqDuQ+Y
 EXV8d04QlslA==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="173143611"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="173143611"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 07:22:06 -0800
IronPort-SDR: y5nw9Tc3jMQGZcq5o6QLTDHd90SYx4twMJ64d3nKoQ+fOFzvsfMULiHImqkL1/i5Ea2Fzv+kv9
 DDRAacyVFmfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="407657274"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 08 Dec 2020 07:22:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 07:22:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 07:22:05 -0800
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.1713.004;
 Tue, 8 Dec 2020 07:22:05 -0800
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] platform/x86: ISST: Mark mmio_range_devid_0 and
 mmio_range_devid_1 with static keyword
Thread-Topic: [PATCH -next] platform/x86: ISST: Mark mmio_range_devid_0 and
 mmio_range_devid_1 with static keyword
Thread-Index: AQHWzXXi1lycwfu5hEyc2e0GCUwWdA==
Date:   Tue, 8 Dec 2020 15:22:04 +0000
Message-ID: <194d5a3c2c0f99345454004eb81c08d94181b7d7.camel@intel.com>
References: <1607430489-116200-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1607430489-116200-1-git-send-email-zou_wei@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.1 (3.38.1-1.fc33) 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E7951488161AB4CBDD929FE1CDE8E0F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTA4IGF0IDIwOjI4ICswODAwLCBab3UgV2VpIHdyb3RlOg0KPiBGaXgg
dGhlIGZvbGxvd2luZyBzcGFyc2Ugd2FybmluZ3M6DQo+IA0KPiBkcml2ZXJzL3BsYXRmb3JtL3g4
Ni9pbnRlbF9zcGVlZF9zZWxlY3RfaWYvaXNzdF9pZl9tbWlvLmM6MjM6MjQ6DQo+IHdhcm5pbmc6
IHN5bWJvbCAnbW1pb19yYW5nZV9kZXZpZF8wJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQg
YmUNCj4gc3RhdGljPw0KPiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9zcGVlZF9zZWxlY3Rf
aWYvaXNzdF9pZl9tbWlvLmM6Mjg6MjQ6DQo+IHdhcm5pbmc6IHN5bWJvbCAnbW1pb19yYW5nZV9k
ZXZpZF8xJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUNCj4gc3RhdGljPw0KPiANClll
c3RlcmRheSBJIHNlbnQgYSBwYXRjaCAiW1BBVENIIHYyIDIvM10gcGxhdGZvcm0veDg2OiBJU1NU
OiBBbGxvdw0KY29uZmlndXJhYmxlIG9mZnNldCByYW5nZSIgdG8gZml4Lg0KDQpUaGFua3MsDQpT
cmluaXZhcw0KDQo+IFNpZ25lZC1vZmYtYnk6IFpvdSBXZWkgPHpvdV93ZWlAaHVhd2VpLmNvbT4N
Cj4gLS0tDQo+IMKgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfc3BlZWRfc2VsZWN0X2lmL2lz
c3RfaWZfbW1pby5jIHwgNCArKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9pbnRlbF9zcGVlZF9zZWxlY3RfaWYvaXNzdF9pZl9tbWlvLmMNCj4gYi9kcml2ZXJzL3Bs
YXRmb3JtL3g4Ni9pbnRlbF9zcGVlZF9zZWxlY3RfaWYvaXNzdF9pZl9tbWlvLmMNCj4gaW5kZXgg
MjkwNmNmZS4uZmY0OTAyNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50
ZWxfc3BlZWRfc2VsZWN0X2lmL2lzc3RfaWZfbW1pby5jDQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZv
cm0veDg2L2ludGVsX3NwZWVkX3NlbGVjdF9pZi9pc3N0X2lmX21taW8uYw0KPiBAQCAtMjAsMTIg
KzIwLDEyIEBAIHN0cnVjdCBpc3N0X21taW9fcmFuZ2Ugew0KPiDCoMKgwqDCoMKgwqDCoMKgaW50
IGVuZDsNCj4gwqB9Ow0KPiDCoA0KPiAtc3RydWN0IGlzc3RfbW1pb19yYW5nZSBtbWlvX3Jhbmdl
X2RldmlkXzBbXSA9IHsNCj4gK3N0YXRpYyBzdHJ1Y3QgaXNzdF9tbWlvX3JhbmdlIG1taW9fcmFu
Z2VfZGV2aWRfMFtdID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgezB4MDQsIDB4MTR9LA0KPiDCoMKg
wqDCoMKgwqDCoMKgezB4MjAsIDB4RDB9LA0KPiDCoH07DQo+IMKgDQo+IC1zdHJ1Y3QgaXNzdF9t
bWlvX3JhbmdlIG1taW9fcmFuZ2VfZGV2aWRfMVtdID0gew0KPiArc3RhdGljIHN0cnVjdCBpc3N0
X21taW9fcmFuZ2UgbW1pb19yYW5nZV9kZXZpZF8xW10gPSB7DQo+IMKgwqDCoMKgwqDCoMKgwqB7
MHgwNCwgMHgxNH0sDQo+IMKgwqDCoMKgwqDCoMKgwqB7MHgyMCwgMHgxMUN9LA0KPiDCoH07DQoN
Cg==
