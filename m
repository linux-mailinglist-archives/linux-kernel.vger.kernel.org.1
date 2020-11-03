Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8FF2A4AD5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgKCQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:10:48 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:59683 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1604419848; x=1635955848;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=zTPDYdidNpsJUUpkE9GN1mubpnYBq2FW8t9MBgfgivw=;
  b=ZltQsqJvhyyO3Yo9p5q+TzK781tXaY/VCsDZf2qgqFCiY2TwDjNX2OVm
   gtk5fVHwiDh7y9dBjQyBa7oiD3EjcF7UeWtpEoVvHFkr6yeTl8QEodd51
   w9FygN7wQPUQWwE3x7+FPruSfBCng1ESVqTft36XtwjLw2IBgKqTBM0d8
   M=;
X-IronPort-AV: E=Sophos;i="5.77,448,1596499200"; 
   d="scan'208";a="90193583"
Subject: Re: [x86/ioapic] b643128b91: Kernel panic - not syncing: timer doesn't work
 through Interrupt-remapped IO-APIC
Thread-Topic: [x86/ioapic] b643128b91: Kernel panic - not syncing: timer doesn't work
 through Interrupt-remapped IO-APIC
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-e69428c4.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 03 Nov 2020 16:10:25 +0000
Received: from EX13MTAUEE001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-e69428c4.us-east-1.amazon.com (Postfix) with ESMTPS id EDE9CC1FFC;
        Tue,  3 Nov 2020 16:10:23 +0000 (UTC)
Received: from EX13D08UEE002.ant.amazon.com (10.43.62.92) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Nov 2020 16:10:23 +0000
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13D08UEE002.ant.amazon.com (10.43.62.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Nov 2020 16:10:23 +0000
Received: from EX13D08UEE001.ant.amazon.com ([10.43.62.126]) by
 EX13D08UEE001.ant.amazon.com ([10.43.62.126]) with mapi id 15.00.1497.006;
 Tue, 3 Nov 2020 16:10:23 +0000
From:   "Woodhouse, David" <dwmw@amazon.co.uk>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "oliver.sang@intel.com" <oliver.sang@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>, "x86@kernel.org" <x86@kernel.org>
Thread-Index: AQHWsexDmAkdJp6GaE23nmBsr3EqOam2hmSAgAANa4A=
Date:   Tue, 3 Nov 2020 16:10:23 +0000
Message-ID: <b79375495beb782aabcf4b9e57d6ebd000edcf47.camel@amazon.co.uk>
References: <20201103143130.GA5804@xsang-OptiPlex-9020>
         <871rha31p0.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rha31p0.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E18D48305B798040ADDAA852E638144E@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTAzIGF0IDE2OjIyICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IEhpIQ0KPiANCj4gT24gVHVlLCBOb3YgMDMgMjAyMCBhdCAyMjozMSwgbGtwIHdyb3RlOg0K
PiA+IEZZSSwgd2Ugbm90aWNlZCB0aGUgZm9sbG93aW5nIGNvbW1pdCAoYnVpbHQgd2l0aCBnY2Mt
OSk6DQo+ID4gDQo+ID4gY29tbWl0OiBiNjQzMTI4YjkxN2NhOGYxYzhiMWUxNGFmNjRlYmRjODEx
NDdiMmQxICgieDg2L2lvYXBpYzogVXNlDQo+ID4gaXJxX2ZpbmRfbWF0Y2hpbmdfZndzcGVjKCkg
dG8gZmluZCByZW1hcHBpbmcgaXJxZG9tYWluIikNCj4gPiANCj4gPiBbICAgIDMuMTQ4ODE5XSAu
LlRJTUVSOiB2ZWN0b3I9MHgzMCBhcGljMT0wIHBpbjE9MiBhcGljMj0tMSBwaW4yPS0xDQo+ID4g
WyAgICAzLjE1NDgyNV0gRE1BUjogRFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJlZyAyDQo+
ID4gWyAgICAzLjE1OTcwMV0gRE1BUjogW0lOVFItUkVNQVBdIFJlcXVlc3QgZGV2aWNlIFtmMDox
Zi43XSBmYXVsdA0KPiA+IGluZGV4IDAgW2ZhdWx0IHJlYXNvbiAzN10gQmxvY2tlZCBhIGNvbXBh
dGliaWxpdHkgZm9ybWF0IGludGVycnVwdA0KPiA+IHJlcXVlc3QNCj4gPiBbICAgIDMuMTczODcw
XSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogdGltZXIgZG9lc24ndCB3b3JrDQo+ID4gdGhy
b3VnaCBJbnRlcnJ1cHQtcmVtYXBwZWQgSU8tQVBJQw0KPiA+IFsgICAgMy4xODIzODFdIENQVTog
MCBQSUQ6IDAgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDUuMTAuMC0NCj4gPiByYzEtMDAw
MjktZ2I2NDMxMjhiOTE3YyAjMQ0KPiA+IFsgICAgMy4xOTAzNzBdIEhhcmR3YXJlIG5hbWU6IFN1
cGVybWljcm8gU1lTLTUwMThELUZONFQvWDEwU0RWLThDLQ0KPiA+IFRMTjRGLCBCSU9TIDEuMSAw
My8wMi8yMDE2DQo+ID4gWyAgICAzLjE5ODUzNF0gQ2FsbCBUcmFjZToNCj4gPiBbICAgIDMuMjAw
OTgzXSAgZHVtcF9zdGFjaysweDU3LzB4NmENCj4gPiBbICAgIDMuMjA0Mjk4XSAgcGFuaWMrMHgx
MDIvMHgyZDINCj4gPiBbICAgIDMuMjA3MzQ5XSAgcGFuaWNfaWZfaXJxX3JlbWFwLmNvbGQrMHg1
LzB4NQ0KPiA+IFsgICAgMy4yMTE2MTNdICBjaGVja190aW1lcisweDFmNi8weDY5NA0KPiA+IFsg
ICAgMy4yMTUxODRdICA/IHByaW50aysweDU4LzB4NmYNCj4gPiBbICAgIDMuMjE4MzIwXSAgc2V0
dXBfSU9fQVBJQysweDE3Yi8weDFjMw0KPiA+IFsgICAgMy4yMjIwNjddICB4ODZfbGF0ZV90aW1l
X2luaXQrMHgyMC8weDMwDQo+ID4gWyAgICAzLjIyNjA3N10gIHN0YXJ0X2tlcm5lbCsweDQwYy8w
eDRjNw0KPiA+IFsgICAgMy4yMjk3MzRdICBzZWNvbmRhcnlfc3RhcnR1cF82NF9ub192ZXJpZnkr
MHhiOC8weGJiDQo+IA0KPiBJdCdzIG5vdCByZXByb2R1Y2luZyBoZXJlLiBDYW4geW91IHBsZWFz
ZSByZWRvIHRoZSB0ZXN0IHdpdGgNCj4gYXBpYz12ZXJib3NlIG9uIHRoZSBrZXJuZWwgY29tbWFu
ZCBsaW5lIGFuZCBwcm92aWRlIHRoZSBmdWxsIGRtZXNnDQo+IG91dHB1dD8NCg0KQWgsIGl0IGFs
cmVhZHkgaGFkIGFwaWM9ZGVidWc7IHNvcnJ5LiBJIHdhcyBsb29raW5nIGZvciB0aGUgSVJURSBz
ZXR1cA0KbWVzc2FnZXMsIHdoaWNoIGNsZWFybHkgYXJlbid0IHRoZXJlIHdoaWNoIGlzIHdoeSBp
dCB3YXMgZ2VuZXJhdGluZw0KY29tcGF0aWJpbGl0eSBmb3JtYXQgaW50ZXJydXB0cy4NCg0KSXQn
cyBwcm9iYWJseSB0aGlzLiBXaWxsIHRyeSBoYXJkZXIgdG8gcmVwcm9kdWNlIHRvIGNvbmZpcm0u
Li4NCg0KLS0tIGEvYXJjaC94ODYva2VybmVsL2FwaWMvaW9fYXBpYy5jDQorKysgYi9hcmNoL3g4
Ni9rZXJuZWwvYXBpYy9pb19hcGljLmMNCkBAIC0yMzM1LDcgKzIzMzUsNyBAQCBzdGF0aWMgaW50
IG1wX2lycWRvbWFpbl9jcmVhdGUoaW50IGlvYXBpYykNCiAgICAgICAgaWYgKGNmZy0+ZGV2KSB7
DQogICAgICAgICAgICAgICAgZm4gPSBvZl9ub2RlX3RvX2Z3bm9kZShjZmctPmRldik7DQogICAg
ICAgIH0gZWxzZSB7DQotICAgICAgICAgICAgICAgZm4gPSBpcnFfZG9tYWluX2FsbG9jX25hbWVk
X2lkX2Z3bm9kZSgiSU8tQVBJQyIsIGlvYXBpYyk7DQorICAgICAgICAgICAgICAgZm4gPSBpcnFf
ZG9tYWluX2FsbG9jX25hbWVkX2lkX2Z3bm9kZSgiSU8tQVBJQyIsIG1wY19pb2FwaWNfaWQoaW9h
cGljKSk7DQogICAgICAgICAgICAgICAgaWYgKCFmbikNCiAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtRU5PTUVNOw0KICAgICAgICB9DQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudHJl
IChMb25kb24pIEx0ZC4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kIGFuZCBXYWxlcyB3aXRoIHJlZ2lz
dHJhdGlvbiBudW1iZXIgMDQ1NDMyMzIgd2l0aCBpdHMgcmVnaXN0ZXJlZCBvZmZpY2UgYXQgMSBQ
cmluY2lwYWwgUGxhY2UsIFdvcnNoaXAgU3RyZWV0LCBMb25kb24gRUMyQSAyRkEsIFVuaXRlZCBL
aW5nZG9tLgoKCg==

