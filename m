Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E352CF702
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 23:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgLDWmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 17:42:24 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:37410 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDWmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1607121743; x=1638657743;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=6hs//QrCHK+YcsZyMw98VFZ/lzLh1j36/CtcngXJqIs=;
  b=tPgnsQlvWNRjV7vN28MRw6tQ/vAfn5cErjbaE9jpmkEcSvPp6OI5X3Mo
   49hBumLgBfoIZeM2eBs8pb6apYAUQdG/OW7eC/BIcPaM7JU4knP/OH3fM
   PF+AxidRkY1n1JSyyaxMpFDGQ399miEu4cR0nrMemK0ERjsT75YXboMs/
   0=;
X-IronPort-AV: E=Sophos;i="5.78,393,1599523200"; 
   d="scan'208";a="70689492"
Subject: Re: [PATCH v3 3/5] x86/mm: Optionally flush L1D on context switch
Thread-Topic: [PATCH v3 3/5] x86/mm: Optionally flush L1D on context switch
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 04 Dec 2020 22:41:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id B12E2A2024;
        Fri,  4 Dec 2020 22:41:32 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 4 Dec 2020 22:41:31 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 4 Dec 2020 22:41:31 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Fri, 4 Dec 2020 22:41:31 +0000
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
Thread-Index: AQHWxIrq8Jio7utIHE6rhTXabR6UW6nnfa6AgAAWZwA=
Date:   Fri, 4 Dec 2020 22:41:31 +0000
Message-ID: <2f66f668210388ab8d80060c605a1c8634e9a1c9.camel@amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com>
         <20201127065938.8200-4-sblbir@amazon.com>
         <87lfed9sje.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87lfed9sje.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.229]
Content-Type: text/plain; charset="utf-8"
Content-ID: <36053285E9825343ADFC6B9131CDF2FB@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDIyOjIxICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+IA0KPiANCj4gDQo+IE9uIEZyaSwgTm92IDI3IDIwMjAgYXQgMTc6NTksIEJhbGJpciBTaW5n
aCB3cm90ZToNCj4gPiANCj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIEZsdXNoIG9ubHkgaWYg
U01UIGlzIGRpc2FibGVkIGFzIHBlciB0aGUgY29udHJhY3QsIHdoaWNoIGlzIGNoZWNrZWQNCj4g
PiArICAgICAgKiB3aGVuIHRoZSBmZWF0dXJlIGlzIGVuYWJsZWQuDQo+ID4gKyAgICAgICovDQo+
ID4gKyAgICAgaWYgKHNjaGVkX3NtdF9hY3RpdmUoKSAmJiAhdGhpc19jcHVfcmVhZChjcHVfaW5m
by5zbXRfYWN0aXZlKSAmJg0KPiA+ICsgICAgICAgICAgICAgKHByZXZfbW0gJiBMQVNUX1VTRVJf
TU1fTDFEX0ZMVVNIKSkNCj4gPiArICAgICAgICAgICAgIGwxZF9mbHVzaF9odygpOw0KPiANCj4g
U28gaWYgU01UIGlzIGNvbXBsZXRlbHkgZGlzYWJsZWQgdGhlbiBubyBmbHVzaD8gU2hvdWxkbid0
IHRoZSBsb2dpYyBiZToNCj4gDQo+ICAgICBpZiAoKCFzY2hlZF9zbXRfYWN0aXZlKCkgfHwgIXRo
aXNfY3B1X3JlYWQoY3B1X2luZm8uc210X2FjdGl2ZSkgJiYNCj4gICAgICAgICAgKHByZXZfbW0g
JiBMQVNUX1VTRVJfTU1fTDFEX0ZMVVNIKSkNCj4gDQo+IEhtbT8NCj4gDQo+IEJ1dCB0aGF0J3Mg
YmFkLCBiZWNhdXNlIGl0J3MgbG90J3Mgb2YgY29uZGl0aW9ucyB0byBldmFsdWF0ZSBmb3IgZXZl
cnkNCj4gc3dpdGNoX21tIHdoZXJlIG1vc3Qgb2YgdGhlbSBhcmUgbm90IGludGVyZXN0ZWQgaW4g
aXQgYXQgYWxsLg0KPiANCj4gTGV0IG1lIHJlYWQgdGhyb3VnaCB0aGUgcmVzdCBvZiB0aGUgcGls
ZS4NCj4NCg0KDQpXZSBkb24ndCBuZWVkIHRoaXMgYW55bW9yZSB3aXRoIHRoZSBuZXcgY2hlY2tz
IGZvciBwcmVlbXB0aW5nIGtpbGxpbmcNCm9mIHRoZSB0YXNrLCBzbyBpdCBjYW4gYmUgcmVtb3Zl
ZA0KDQpCYWxiaXIgDQo=
