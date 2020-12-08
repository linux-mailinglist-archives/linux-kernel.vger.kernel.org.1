Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46ED2D2E49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgLHPa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:30:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:62156 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbgLHPa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:30:27 -0500
IronPort-SDR: qZzhVJ/fxRwqL1s2RJGQ8kRr2G+qe8mCA8m7DUp9w1ecW3+njBnRIPqLmO/oIaHAooPhhtFJo/
 tasY78doIKJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="153144356"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="153144356"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 07:29:46 -0800
IronPort-SDR: OBO1HLnRiQahv4WeNDC7lYfTTpQmyfLjUHopoCAvqYVvQ/Gv1yQ2eIt6afr+/2CPZHX2eNl6AA
 vqwzEBxEgp+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="437415330"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2020 07:29:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 07:29:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 07:29:46 -0800
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.1713.004;
 Tue, 8 Dec 2020 07:29:45 -0800
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
Thread-Index: AQHWzXXi1lycwfu5hEyc2e0GCUwWdKnt2IQAgAAAloA=
Date:   Tue, 8 Dec 2020 15:29:45 +0000
Message-ID: <02ba6732cb5e78c0a09840a64b6c422b89f744e5.camel@intel.com>
References: <1607430489-116200-1-git-send-email-zou_wei@huawei.com>
         <194d5a3c2c0f99345454004eb81c08d94181b7d7.camel@intel.com>
         <179b9e9c-5f38-b6e9-2135-636bdb275989@redhat.com>
In-Reply-To: <179b9e9c-5f38-b6e9-2135-636bdb275989@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.1 (3.38.1-1.fc33) 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3608E09304E13F4BBADA042EEF6E6A07@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTA4IGF0IDE2OjI3ICswMTAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIDEyLzgvMjAgNDoyMiBQTSwgUGFuZHJ1dmFkYSwgU3Jpbml2YXMgd3Jv
dGU6DQo+ID4gT24gVHVlLCAyMDIwLTEyLTA4IGF0IDIwOjI4ICswODAwLCBab3UgV2VpIHdyb3Rl
Og0KPiA+ID4gRml4IHRoZSBmb2xsb3dpbmcgc3BhcnNlIHdhcm5pbmdzOg0KPiA+ID4gDQo+ID4g
PiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9zcGVlZF9zZWxlY3RfaWYvaXNzdF9pZl9tbWlv
LmM6MjM6MjQ6DQo+ID4gPiB3YXJuaW5nOiBzeW1ib2wgJ21taW9fcmFuZ2VfZGV2aWRfMCcgd2Fz
IG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0DQo+ID4gPiBiZQ0KPiA+ID4gc3RhdGljPw0KPiA+ID4g
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfc3BlZWRfc2VsZWN0X2lmL2lzc3RfaWZfbW1pby5j
OjI4OjI0Og0KPiA+ID4gd2FybmluZzogc3ltYm9sICdtbWlvX3JhbmdlX2RldmlkXzEnIHdhcyBu
b3QgZGVjbGFyZWQuIFNob3VsZCBpdA0KPiA+ID4gYmUNCj4gPiA+IHN0YXRpYz8NCj4gPiA+IA0K
PiA+IFllc3RlcmRheSBJIHNlbnQgYSBwYXRjaCAiW1BBVENIIHYyIDIvM10gcGxhdGZvcm0veDg2
OiBJU1NUOiBBbGxvdw0KPiA+IGNvbmZpZ3VyYWJsZSBvZmZzZXQgcmFuZ2UiIHRvIGZpeC4NCj4g
DQo+IEFuZCBJIHJlcGxpZWQgdG8gdGhhdCB2MiB3aXRoIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiAi
SSd2ZSBhbHJlYWR5IGFkZGVkIHYxIG9mIHRoZXNlIHRvIHRoZSBmb3ItbmV4dCBicmFuY2ggb2Y6
DQo+IA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9w
ZHg4Ni9wbGF0Zm9ybS1kcml2ZXJzLXg4Ni5naXQvDQo+IA0KPiBQbGVhc2Ugc2VuZCB0aGUgY2hh
bmdlcyBpbiB0aGlzIHYyIGFzIChhKSBmb2xsb3ctdXANCj4gcGF0Y2goZXMpLiINCj4gDQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BsYXRmb3JtLWRyaXZlci14ODYvMmY2NjNkODktMTg0Yi1m
NTJlLTYxNTYtZjQ4NTIwNWYyN2Y1QHJlZGhhdC5jb20vVC8jdA0KPiANCj4gQnV0IEkgZ3Vlc3Mg
eW91IG1heSBub3QgaGF2ZSBzZWVuIHRoaXMgYmVjYXVzZSBJbnRlbCdzIG1haWwtc2VydmVycw0K
PiBzZWVtIHRvIGhhdmUgZ29uZSBjb21wbGV0ZWx5IGZvb2JhciBsYXRlbHkgYW5kIGFyZSBib3Vu
Y2luZyBtb3N0DQo+IG9mIG15IGVtYWlscyBpdCBzZWVtcy4gSSBzdHJvbmdseSBzdWdnZXN0IHRo
YXQgeW91IHN1YnNjcmliZSB0bw0KPiB0aGUgcGxhdGZvcm0tZHJpdmVyLXg4NiBsaXN0cywgc28g
dGhhdCB5b3UgYXQgbGVhc3QgZ2V0IHJlcGxpZXMNCj4gdG8geW91ciBwYXRjaGVzIHRocm91Z2gg
dGhlIGxpc3QuDQo+IA0KPiBTbyBhcmUgdGhlIGNoYW5nZXMgaW4gdGhpcyBwYXRjaCBmcm9tIFpv
dSBXZWkgdGhlIG9ubHkgY2hhbmdlcyBpbiB2Mg0KPiBvZiB5b3VyIElTU1QgY2hhbmdlcz8gSWYg
dGhhdCBpcyB0aGUgY2FzZSB0aGVuIEknbGwganVzdCBtZXJnZQ0KPiBab3UgV2VpJ3MgcGF0Y2gg
YW5kIHRoZW4gd2UncmUgZG9uZS4NCkZpbmUgd2l0aCBtZS4gSnVzdCBtZXJnZSBXZWkncyBwYXRj
aC4NCg0KVGhhbmtzLA0KU3Jpbml2YXMNCg0KDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gSGFucw0K
PiANCj4gDQo+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWm91IFdlaSA8em91X3dlaUBodWF3ZWku
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX3NwZWVk
X3NlbGVjdF9pZi9pc3N0X2lmX21taW8uYyB8IDQNCj4gPiA+ICsrLS0NCj4gPiA+IMKgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4g
ZGlmZiAtLWdpdA0KPiA+ID4gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9zcGVlZF9zZWxl
Y3RfaWYvaXNzdF9pZl9tbWlvLmMNCj4gPiA+IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxf
c3BlZWRfc2VsZWN0X2lmL2lzc3RfaWZfbW1pby5jDQo+ID4gPiBpbmRleCAyOTA2Y2ZlLi5mZjQ5
MDI1IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfc3BlZWRf
c2VsZWN0X2lmL2lzc3RfaWZfbW1pby5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni9pbnRlbF9zcGVlZF9zZWxlY3RfaWYvaXNzdF9pZl9tbWlvLmMNCj4gPiA+IEBAIC0yMCwxMiAr
MjAsMTIgQEAgc3RydWN0IGlzc3RfbW1pb19yYW5nZSB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
aW50IGVuZDsNCj4gPiA+IMKgfTsNCj4gPiA+IMKgDQo+ID4gPiAtc3RydWN0IGlzc3RfbW1pb19y
YW5nZSBtbWlvX3JhbmdlX2RldmlkXzBbXSA9IHsNCj4gPiA+ICtzdGF0aWMgc3RydWN0IGlzc3Rf
bW1pb19yYW5nZSBtbWlvX3JhbmdlX2RldmlkXzBbXSA9IHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqB7MHgwNCwgMHgxNH0sDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgezB4MjAsIDB4RDB9LA0KPiA+
ID4gwqB9Ow0KPiA+ID4gwqANCj4gPiA+IC1zdHJ1Y3QgaXNzdF9tbWlvX3JhbmdlIG1taW9fcmFu
Z2VfZGV2aWRfMVtdID0gew0KPiA+ID4gK3N0YXRpYyBzdHJ1Y3QgaXNzdF9tbWlvX3JhbmdlIG1t
aW9fcmFuZ2VfZGV2aWRfMVtdID0gew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHsweDA0LCAweDE0
fSwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB7MHgyMCwgMHgxMUN9LA0KPiA+ID4gwqB9Ow0KPiA+
IA0KPiANCg0K
