Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB34A2CF70D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 23:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgLDWpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 17:45:24 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:11141 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgLDWpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1607121924; x=1638657924;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=3il6FjeKs2rcTJCknFi2c/qsb/C2u0m4UBCDycL616w=;
  b=peHrPywVKg0PZx4YLMxmOOpPhiZ2X0lLLsBImK4whea0w+TsOO3UMaT7
   5D1oFMPqCjuRf5V6DwjWrkqhqJ+XmfIkd8+bn9rPnP0wEhu0IW5KPKTYU
   MLkeUc2yIgoxuiv1Md9dAjrVrnw+1hnC+N9gmLl/c9+asr83CBAs8Olkj
   I=;
X-IronPort-AV: E=Sophos;i="5.78,393,1599523200"; 
   d="scan'208";a="93632381"
Subject: Re: [PATCH v3 1/5] x86/mm: change l1d flush runtime prctl behaviour
Thread-Topic: [PATCH v3 1/5] x86/mm: change l1d flush runtime prctl behaviour
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 04 Dec 2020 22:44:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 318BEA068E;
        Fri,  4 Dec 2020 22:44:31 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 4 Dec 2020 22:44:31 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 4 Dec 2020 22:44:31 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Fri, 4 Dec 2020 22:44:31 +0000
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
Thread-Index: AQHWxIrmGqN19GOE6EeQuf3n0mKQb6nnef0AgAAaxYA=
Date:   Fri, 4 Dec 2020 22:44:31 +0000
Message-ID: <648c2e023a6be09e331eece1a741b573c3fab98a.camel@amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com>
         <20201127065938.8200-2-sblbir@amazon.com>
         <87r1o59t5f.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87r1o59t5f.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F15BFFB3CC0BDE44966908F9568DF676@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDIyOjA3ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+IA0KPiANCj4gDQo+IE9uIEZyaSwgTm92IDI3IDIwMjAgYXQgMTc6NTksIEJhbGJpciBTaW5n
aCB3cm90ZToNCj4gDQo+ID4gRGV0ZWN0aW9uIG9mIHRhc2sgYWZmaW5pdGllcyBhdCBBUEkgb3B0
LWluIHRpbWUgaXMgbm90IHRoZSBiZXN0DQo+ID4gYXBwcm9hY2gsIHRoZSBhcHByb2FjaCBpcyB0
byBraWxsIHRoZSB0YXNrIGlmIGl0IHJ1bnMgb24gYQ0KPiA+IFNNVCBlbmFibGUgY29yZS4gVGhp
cyBpcyBiZXR0ZXIgdGhhbiBub3QgZmx1c2hpbmcgdGhlIEwxRCBjYWNoZQ0KPiA+IHdoZW4gdGhl
IHRhc2sgc3dpdGNoZXMgZnJvbSBhIG5vbi1TTVQgY29yZSB0byBhbiBTTVQgZW5hYmxlZCBjb3Jl
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhbGJpciBTaW5naCA8c2JsYmlyQGFtYXpvbi5j
b20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oIHwgIDIg
KysNCj4gPiAgYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYyAgICAgICAgfCAxMSArKysrKysrKysr
LQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IFN1YmplY3QsIGNoYW5nZWxvZyBtYXRjaCBidXQgcGF0Y2ggY29udGVudCBub3Qgc28g
bXVjaCA6KQ0KPiANCg0KVGhlIGNoYW5nZWxvZyBqdW1wZWQgYmV0d2VlbiAxLzMgb2YgbXkgZml4
dXAgYW5kIDEvNSBvZiBteQ0KbmV3IHBvc3QgOikNCg0KVGhlIGNvcnJlY3QgY2hhbmdlbG9nIGlz
IGJlbG93LCB3aGljaCBJIHNoYWxsIGZpeA0KDQp4ODYvc21wOiBBZGQgYSBwZXItY3B1IHZpZXcg
b2YgU01UIHN0YXRlDQoNCkEgbmV3IGZpZWxkIHNtdF9hY3RpdmUgaW4gY3B1aW5mb194ODYgaWRl
bnRpZmllcyBpZiB0aGUgY3VycmVudCBjb3JlL2NwdQ0KaXMgaW4gU01UIG1vZGUgb3Igbm90LiBU
aGlzIGNhbiBiZSB2ZXJ5IGhlbHBmdWwgaWYgdGhlIHN5c3RlbSBoYXMgc29tZQ0Kb2YgaXRzIGNv
cmVzIHdpdGggdGhyZWFkcyBvZmZsaW5lZCBhbmQgY2FuIGJlIHVzZWQgZm9yIGNhc2VzIHdoZXJl
DQphY3Rpb24gaXMgdGFrZW4gYmFzZWQgb24gdGhlIHN0YXRlIG9mIFNNVC4gVGhlIGZvbGxvdyB1
cCBwYXRjaGVzIHVzZQ0KdGhpcyBmZWF0dXJlLg0KDQpTdWdnZXN0ZWQtYnk6IFRob21hcyBHbGVp
eG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KU2lnbmVkLW9mZi1ieTogQmFsYmlyIFNpbmdoIDxz
YmxiaXJAYW1hem9uLmNvbT4NClNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPg0KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIwMDcyOTAw
MTEwMy42NDUwLTItc2JsYmlyQGFtYXpvbi5jb20NCi0tLQ0K
