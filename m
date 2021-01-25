Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18545303289
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 04:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbhAYJoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:44:00 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:36608 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbhAYJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611566912; x=1643102912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xaEGsFacHDb/r4sO3oy91AEG6vRM3dfJmvdY2sYAKNY=;
  b=OQEkQotl+EzRHmWf2cHb+TAEaxnRkz+RPz2iz64qi1KgfHoYggGAGJuj
   m7ljmSo5wJvi9T1syG9Wi/EGmTN/ReuoDEyFqCF1vHYrtsLeUL3Rgs7QV
   rCb5f0OcTDLQeseRgtkUhHieDbNjixw6pxxxTmdgt/EcjkMZKbzXrfYYA
   k=;
X-IronPort-AV: E=Sophos;i="5.79,373,1602547200"; 
   d="scan'208";a="81316953"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 25 Jan 2021 09:27:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id 81ED7A1FDB;
        Mon, 25 Jan 2021 09:27:39 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 Jan 2021 09:27:39 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 Jan 2021 09:27:38 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.010;
 Mon, 25 Jan 2021 09:27:38 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/5] Next revision of the L1D flush patches
Thread-Topic: [PATCH v4 0/5] Next revision of the L1D flush patches
Thread-Index: AQHW5bdXPppNxOXjHka1CprAc1FaNKo4LTUA
Date:   Mon, 25 Jan 2021 09:27:38 +0000
Message-ID: <cf89f0389379daaaff0cbce9c5f1550866e55e91.camel@amazon.com>
References: <20210108121056.21940-1-sblbir@amazon.com>
In-Reply-To: <20210108121056.21940-1-sblbir@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.253]
Content-Type: text/plain; charset="utf-8"
Content-ID: <098A3AB79A489547B511103D3DF409CF@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTA4IGF0IDIzOjEwICsxMTAwLCBCYWxiaXIgU2luZ2ggd3JvdGU6DQo+
IEltcGxlbWVudCBhIG1lY2hhbmlzbSB0aGF0IGFsbG93cyB0YXNrcyB0byBjb25kaXRpb25hbGx5
IGZsdXNoDQo+IHRoZWlyIEwxRCBjYWNoZSAobWl0aWdhdGlvbiBtZWNoYW5pc20gc3VnZ2VzdGVk
IGluIFsyXSkuIFRoZSBwcmV2aW91cw0KPiBwb3N0cyBvZiB0aGVzZSBwYXRjaGVzIHdlcmUgc2Vu
dCBmb3IgaW5jbHVzaW9uIChzZWUgWzNdKSBhbmQgd2VyZSBub3QNCj4gaW5jbHVkZWQgZHVlIHRv
IHRoZSBjb25jZXJuIGZvciB0aGUgbmVlZCBmb3IgYWRkaXRpb25hbCBjaGVja3MsDQo+IHRob3Nl
IGNoZWNrcyB3ZXJlOg0KPiANCj4gMS4gSW1wbGVtZW50IHRoaXMgbWVjaGFuaXNtIG9ubHkgZm9y
IENQVXMgYWZmZWN0ZWQgYnkgdGhlIEwxVEYgYnVnDQo+IDIuIERpc2FibGUgdGhlIHNvZnR3YXJl
IGZhbGxiYWNrDQo+IDMuIFByb3ZpZGUgYW4gb3ZlcnJpZGUgdG8gZW5hYmxlIHRoaXMgbWVjaGFu
aXNtDQo+IDQuIEJlIFNNVCBhd2FyZSBpbiB0aGUgaW1wbGVtZW50YXRpb24NCj4gDQo+IFRoZSBw
YXRjaGVzIHN1cHBvcnQgYSB1c2UgY2FzZSB3aGVyZSB0aGUgZW50aXJlIHN5c3RlbSBpcyBub3Qg
aW4NCj4gbm9uIFNNVCBtb2RlLCBidXQgcmF0aGVyIGEgZmV3IENQVXMgY2FuIGhhdmUgdGhlaXIg
U01UIHR1cm5lZCBvZmYNCj4gYW5kIHByb2Nlc3NlcyB0aGF0IHdhbnQgdG8gb3B0LWluIGFyZSBl
eHBlY3RlZCB0byBydW4gb24gbm9uIFNNVA0KPiBjb3Jlcy4gVGhpcyBnaXZlcyB0aGUgYWRtaW5p
c3RyYXRvciBjb21wbGV0ZSBjb250cm9sIG92ZXIgc2V0dGluZw0KPiB1cCB0aGUgbWl0aWdhdGlv
biBmb3IgdGhlIGlzc3VlLiBJbiBhZGRpdGlvbiwgdGhlIGFkbWluaXN0cmF0b3INCj4gaGFzIGEg
Ym9vdCB0aW1lIG92ZXJyaWRlIChsMWRfZmx1c2g9b24pIHRvIHR1cm4gb24gdGhlIG1lY2hhbmlz
bQ0KPiB3aXRob3V0IHdoaWNoIHRoaXMgbWVjaGFuaXNtIHdpbGwgbm90IHdvcmsuDQo+IA0KPiBU
byBpbXBsZW1lbnQgdGhlc2UgZWZmaWNpZW50bHksIGEgbmV3IHBlciBjcHUgdmlldyBvZiB3aGV0
aGVyIHRoZSBjb3JlDQo+IGlzIGluIFNNVCBtb2RlIG9yIG5vdCBpcyBpbXBsZW1lbnRlZCBpbiBw
YXRjaCAxLiBUaGUgY29kZSBpcyByZWZhY3RvcmVkDQo+IGluIHBhdGNoIDIgc28gdGhhdCB0aGUg
ZXhpc3RpbmcgY29kZSBjYW4gYWxsb3cgZm9yIG90aGVyIHNwZWN1bGF0aW9uDQo+IHJlbGF0ZWQg
Y2hlY2tzIHdoZW4gc3dpdGNoaW5nIG1tIGJldHdlZW4gdGFza3MsIHRoaXMgbWVjaGFuaXNtIGhh
cyBub3QNCj4gY2hhbmdlZCBzaW5jZSB0aGUgbGFzdCBwb3N0LiBUaGUgYWJpbGl0eSB0byBmbHVz
aCBMMUQgZm9yIHRhc2tzIGlmIHRoZQ0KPiBUSUZfU1BFQ19MMURfRkxVU0ggYml0IGlzIHNldCBh
bmQgdGhlIHRhc2sgaGFzIGNvbnRleHQgc3dpdGNoZWQgb3V0IG9mIGENCj4gbm9uIFNNVCBjb3Jl
IGlzIHByb3ZpZGVkIGJ5IHBhdGNoIDMuIEhvb2tzIGZvciB0aGUgdXNlciBzcGFjZSBBUEksIGZv
cg0KPiB0aGlzIGZlYXR1cmUgdG8gYmUgaW52b2tlZCB2aWEgcHJjdGwgYXJlIHByb3ZpZGVkIGlu
IHBhdGNoIDQsIGFsb25nIHdpdGgNCj4gdGhlIGNoZWNrcyBkZXNjcmliZWQgYWJvdmUgKDEsIDIs
IGFuZCAzKS4gRG9jdW1lbnRhdGlvbiB1cGRhdGVzIGFyZSBpbg0KPiBwYXRjaCA1LCB3aXRoIHVw
ZGF0ZXMgb24gbDFkX2ZsdXNoLCB0aGUgcHJjdGwgY2hhbmdlcyBhbmQgdXBkYXRlcyB0byB0aGUN
Cj4ga2VybmVsLXBhcmFtZXRlcnMgKGwxZF9mbHVzaF9vdXQpLg0KPiANCj4gVGhlIGNoZWNrcyBm
b3Igb3B0aW5nIGludG8gTDFEIGZsdXNoaW5nIGFyZToNCj4gCWEuIElmIHRoZSBDUFUgaXMgYWZm
ZWN0ZWQgYnkgTDFURg0KPiAgICAgICAgIGIuIEhhcmR3YXJlIEwxRCBmbHVzaCBtZWNoYW5pc20g
aXMgYXZhaWxhYmxlDQo+IA0KPiBBIHRhc2sgcnVubmluZyBvbiBhIGNvcmUgd2l0aCBTTVQgZW5h
YmxlZCBhbmQgb3B0aW5nIGludG8gdGhpcyBmZWF0dXJlIHdpbGwNCj4gcmVjZWl2ZSBhIFNJR0JV
Uy4NCj4gDQo+IFJlZmVyZW5jZXMNCj4gWzFdIGh0dHBzOi8vc29mdHdhcmUuaW50ZWwuY29tL3Nl
Y3VyaXR5LXNvZnR3YXJlLWd1aWRhbmNlL3NvZnR3YXJlLWd1aWRhbmNlL3Nub29wLWFzc2lzdGVk
LWwxLWRhdGEtc2FtcGxpbmcNCj4gWzJdIGh0dHBzOi8vc29mdHdhcmUuaW50ZWwuY29tL3NlY3Vy
aXR5LXNvZnR3YXJlLWd1aWRhbmNlL2luc2lnaHRzL2RlZXAtZGl2ZS1zbm9vcC1hc3Npc3RlZC1s
MS1kYXRhLXNhbXBsaW5nDQo+IFszXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC82LzIvMTE1
MA0KPiBbNF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIwMDcyOTAwMTEwMy42NDUw
LTEtc2JsYmlyQGFtYXpvbi5jb20vDQo+IFs1XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjAxMTE3MjM0OTM0LjI1OTg1LTItc2JsYmlyQGFtYXpvbi5jb20vDQo+IA0KPiBSZXZpZXdl
cnMgZ3VpZGUgdG8gdjQNCj4gLSBUaGUga2V5IHBhdGNoIGluIHRoZSBzZXJpZXMgYW5kIG1vc3Qg
b2YgdGhlIGNoYW5nZXMgdG8gdGhpcw0KPiAgIHJldmlzaW9uIGFyZSB0byBwYXRjaCA0LiBwYXRj
aGVzIDMgYW5kIDUgaGF2ZSBiZWVuIG1vZGlmaWVkDQo+ICAgdG8ga2VlcCB0aGVtIGNvbnNpc3Rl
bnQgd2l0aCB0aGUgY2hhbmdlcyB0byBwYXRjaCA0Lg0KPiANCj4gQ2hhbmdlbG9nIHY0Og0KPiAt
IFVzZSBhIHN0YXRpYyBrZXkgdG8gZW5hYmxlIHRoZSBtZWNoYW5pc20gKHJlbW92ZSBvdmVyaGVh
ZHMpDQo+IC0gQnkgZGVmYXVsdCBoYXZlIHRoZSBtZWNoYW5pc20gdHVybmVkIG9mZiwgc28gdGhl
cmUgYXJlIHR3bw0KPiAgIG9wdC1pbnMgbmVlZGVkLCBvbmUgYnkgdGhlIGFkbWluaXN0cmF0b3Ig
YXQgYm9vdCB0aW1lLCBzZWNvbmQNCj4gICBieSB0aGUgYXBwbGljYXRpb24NCj4gLSBSZW5hbWUg
bDFkX2ZsdXNoX291dC9MMURfRkxVU0hfT1VUIHRvIGwxZF9mbHVzaC9MMURfRkxVU0gNCj4gLSBJ
bXBsZW1lbnQgb3RoZXIgcmV2aWV3IHJlY29tbWVuZGF0aW9ucw0KPiBDaGFuZ2Vsb2cgdjM6DQo+
IC0gSW1wbGVtZW50IHRoZSBTSUdCVVMgbWVjaGFuc2ltDQo+IC0gVXBkYXRlIGFuZCBmaXggdGhl
IGRvY3VtZW50YXRpb24NCj4gDQo+IA0KPiBCYWxiaXIgU2luZ2ggKDUpOg0KPiAgIHg4Ni9zbXA6
IEFkZCBhIHBlci1jcHUgdmlldyBvZiBTTVQgc3RhdGUNCj4gICB4ODYvbW06IFJlZmFjdG9yIGNv
bmRfaWJwYigpIHRvIHN1cHBvcnQgb3RoZXIgdXNlIGNhc2VzDQo+ICAgeDg2L21tOiBPcHRpb25h
bGx5IGZsdXNoIEwxRCBvbiBjb250ZXh0IHN3aXRjaA0KPiAgIHByY3RsOiBIb29rIEwxRCBmbHVz
aGluZyBpbiB2aWEgcHJjdGwNCj4gICBEb2N1bWVudGF0aW9uOiBBZGQgTDFEIGZsdXNoaW5nIERv
Y3VtZW50YXRpb24NCj4gDQo+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2h3LXZ1bG4vaW5k
ZXgucnN0ICAgfCAgMSArDQo+ICAuLi4vYWRtaW4tZ3VpZGUvaHctdnVsbi9sMWRfZmx1c2gucnN0
ICAgICAgICAgfCA3MCArKysrKysrKysrKysrKysNCj4gIC4uLi9hZG1pbi1ndWlkZS9rZXJuZWwt
cGFyYW1ldGVycy50eHQgICAgICAgICB8IDE3ICsrKysNCj4gIERvY3VtZW50YXRpb24vdXNlcnNw
YWNlLWFwaS9zcGVjX2N0cmwucnN0ICAgICB8ICA4ICsrDQo+ICBhcmNoL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArDQo+ICBhcmNoL3g4Ni9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9jYWNoZWZsdXNoLmggICAgICAgICAgICAgfCAgOCArKw0KPiAgYXJjaC94ODYvaW5jbHVkZS9h
c20vbm9zcGVjLWJyYW5jaC5oICAgICAgICAgIHwgIDIgKw0KPiAgYXJjaC94ODYvaW5jbHVkZS9h
c20vcHJvY2Vzc29yLmggICAgICAgICAgICAgIHwgIDIgKw0KPiAgYXJjaC94ODYvaW5jbHVkZS9h
c20vdGhyZWFkX2luZm8uaCAgICAgICAgICAgIHwgIDYgKy0NCj4gIGFyY2gveDg2L2luY2x1ZGUv
YXNtL3RsYmZsdXNoLmggICAgICAgICAgICAgICB8ICAyICstDQo+ICBhcmNoL3g4Ni9rZXJuZWwv
Y3B1L2J1Z3MuYyAgICAgICAgICAgICAgICAgICAgfCA3MSArKysrKysrKysrKysrKysNCj4gIGFy
Y2gveDg2L2tlcm5lbC9zbXBib290LmMgICAgICAgICAgICAgICAgICAgICB8IDEwICsrLQ0KPiAg
YXJjaC94ODYvbW0vdGxiLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgODggKysrKysr
KysrKysrKystLS0tLQ0KPiAgaW5jbHVkZS9saW51eC9zY2hlZC5oICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMTAgKysrDQo+ICBpbmNsdWRlL3VhcGkvbGludXgvcHJjdGwuaCAgICAgICAgICAg
ICAgICAgICAgfCAgMSArDQo+ICAxNiBmaWxlcyBjaGFuZ2VkLCAyNzMgaW5zZXJ0aW9ucygrKSwg
MjggZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9ody12dWxuL2wxZF9mbHVzaC5yc3QNCj4NCg0KUGluZyBvbiBhbnkgcmV2aWV3IGNv
bW1lbnRzPyBTdWdnZXN0ZWQgcmVmYWN0b3Jpbmc/DQoNCkJhbGJpciBTaW5naCANCg==
