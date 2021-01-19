Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388212FAE46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 02:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbhASBRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 20:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732238AbhASBQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 20:16:58 -0500
X-Greylist: delayed 412 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jan 2021 17:16:17 PST
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F07C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 17:16:17 -0800 (PST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4625284487;
        Tue, 19 Jan 2021 14:09:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1611018561;
        bh=3UkdCiKqw6yX2AQKkNKW1k2y9uwHyEC6AuOUDO3Wq/o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=byFBHgLB19ZtX9TXXLuas3RJEmKoA3hmje0x/aZwRmO8mi1VVFskdqUC+4n+Erq7p
         XLpyXP5A2kDdKVmNQtiRd5yBb1KCWtNE8nRuZOCSHRFKnG6QshrxH7tPv3CthibmK2
         kGZsDh9Y5JmxX6lsJqz4DUQzSoKHs0O8sr9n+H+bvYLza93JGQMDdta/RnXeGnYyez
         iy1rB9D3zSH/spiKipwe1AVNUTAeZ1iVyoFko92eC0TwoeFqrLjaKYHFoFjS/zqJbB
         0bDdjouUsIXmurkdvfud597rzQ3Mc1tgACDucsUYU2BOS8Ads0I4Bh73idZ7xwKxvH
         /Aw68FnXW8a+w==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B600631410001>; Tue, 19 Jan 2021 14:09:21 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan 2021 14:09:20 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.010; Tue, 19 Jan 2021 14:09:20 +1300
From:   Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "paul.kocialkowski@bootlin.com" <paul.kocialkowski@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] usb: ohci: Default to per-port over-current
 protection
Thread-Topic: [PATCH v2 1/2] usb: ohci: Default to per-port over-current
 protection
Thread-Index: AQHWh7jkXz/Lqnxlg0WKmLEE3cgsQKoKm8UAgBUW8QCADmNYAA==
Date:   Tue, 19 Jan 2021 01:09:20 +0000
Message-ID: <83ed9f3929bd064b54bb9903cd489adde442e1c7.camel@alliedtelesis.co.nz>
References: <20200910212512.16670-1-hamish.martin@alliedtelesis.co.nz>
         <X+huemxT9XOeDi5E@aptenodytes>
         <20210109212608.GB1136657@rowland.harvard.edu>
In-Reply-To: <20210109212608.GB1136657@rowland.harvard.edu>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:24:5bb:1ce7:342d:f966]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DB8B9A8A0813546881F38C102CB76CE@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTAxLTA5IGF0IDE2OjI2IC0wNTAwLCBBbGFuIFN0ZXJuIHdyb3RlOg0KPiBP
biBTdW4sIERlYyAyNywgMjAyMCBhdCAxMjoyMjozNFBNICswMTAwLCBQYXVsIEtvY2lhbGtvd3Nr
aSB3cm90ZToNCj4gPiBIaSwNCj4gDQo+IFNvcnJ5IGl0IGhhcyB0YWtlbiBzbyBsb25nIHRvIHJl
c3BvbmQgdG8gdGhpcy4gIFRoZSBob2xpZGF5cw0KPiBpbnRlcnZlbmVkLCANCj4gYnV0IHRoYXQn
cyBubyBleGN1c2UuDQpJJ20gc29ycnkgdG9vLCBzYW1lIHJlYXNvbi9ub24tZXhjdXNlLiBUaGFu
a3MgZm9yIHlvdXIgdGhvcm91Z2ggcmVwb3J0DQpvbiB0aGUgaXNzdWUgbXkgY2hhbmdlcyBjYXVz
ZWQgYW5kIHBhc3Mgb24gbXkgYXBvbG9naWVzIHRvIHlvdXIgTW9tIQ0KDQo+IA0KPiA+IE9uIEZy
aSAxMSBTZXAgMjAsIDA5OjI1LCBIYW1pc2ggTWFydGluIHdyb3RlOg0KPiA+ID4gU29tZSBpbnRl
Z3JhdGVkIE9IQ0kgY29udHJvbGxlciBodWJzIGRvIG5vdCBleHBvc2UgYWxsIHBvcnRzIG9mDQo+
ID4gPiB0aGUgaHViDQo+ID4gPiB0byBwaW5zIG9uIHRoZSBTb0MuIEluIHNvbWUgY2FzZXMgdGhl
IHVuY29ubmVjdGVkIHBvcnRzIGdlbmVyYXRlDQo+ID4gPiBzcHVyaW91cyBvdmVyLWN1cnJlbnQg
ZXZlbnRzLiBGb3IgZXhhbXBsZSB0aGUgQnJvYWRjb20NCj4gPiA+IDU2MDYwL1JhbmdlciAyIFNv
Qw0KPiA+ID4gY29udGFpbnMgYSBub21pbmFsbHkgMyBwb3J0IGh1YiBidXQgb25seSB0aGUgZmly
c3QgcG9ydCBpcyB3aXJlZC4NCj4gPiA+IA0KPiA+ID4gRGVmYXVsdCBiZWhhdmlvdXIgZm9yIG9o
Y2ktcGxhdGZvcm0gZHJpdmVyIGlzIHRvIHVzZSBnbG9iYWwgb3Zlci0NCj4gPiA+IGN1cnJlbnQN
Cj4gPiA+IHByb3RlY3Rpb24gbW9kZSAoQUtBICJnYW5nZWQiKS4gVGhpcyBsZWFkcyB0byB0aGUg
c3B1cmlvdXMgb3Zlci0NCj4gPiA+IGN1cnJlbnQNCj4gPiA+IGV2ZW50cyBhZmZlY3RpbmcgYWxs
IHBvcnRzIGluIHRoZSBodWIuDQo+ID4gPiANCj4gPiA+IFdlIG5vdyBhbHRlciB0aGUgZGVmYXVs
dCB0byB1c2UgcGVyLXBvcnQgb3Zlci1jdXJyZW50IHByb3RlY3Rpb24uDQo+ID4gDQo+ID4gVGhp
cyBzcGVjaWZpYyBwYXRjaCBsZWFkIHRvIGJyZWFraW5nIE9IQ0kgb24gbXkgbW9tJ3MgbGFwdG9w
ICh3aG9tDQo+ID4gd2FzIGFib3V0DQo+ID4gdG8gYnV5IGEgbmV3IG9uZSB0aGlua2luZyB0aGUg
aGFyZHdhcmUgaGFkIGZhaWxlZCkuIEkgZ2V0IG5vIE9IQ0kNCj4gPiBpbnRlcnJ1cHQgYXQNCj4g
PiBhbGwgYW5kIG5vIFVTQiAxIGRldmljZSBpcyBldmVyIGRldGVjdGVkLg0KPiA+IA0KPiA+IEkg
aGF2ZW4ndCByZWFsbHkgZm91bmQgYSByZWFzb25hYmxlIGV4cGxhbmF0aW9uIGFib3V0IHdoeSB0
aGF0IGlzLA0KPiA+IGJ1dCBoZXJlDQo+ID4gYXJlIHNvbWUgbm90ZXMgSSB3YXMgYWJsZSB0byBj
b2xsZWN0Og0KPiA+IC0gVGhlIGlzc3VlIHNob3dlZCB1cCBvbiA1LjgsMTggYW5kIDUuOS4xNSwg
d2hpY2ggZG9uJ3QgaW5jbHVkZSB0aGUNCj4gPiBwYXRjaA0KPiA+ICAgZnJvbSB0aGlzIHNlcmll
cyB0aGF0IHNldHMgZGlzdHJ1c3RfZmlybXdhcmUgPSBmYWxzZTsgVGhpcw0KPiA+IHJlc3VsdHMg
aW4gdGhlIE5QUw0KPiA+ICAgYml0IGJlaW5nIHNldCB2aWEgT0hDSV9RVUlSS19IVUJfUE9XRVIu
DQo+ID4gLSBBZGRpbmcgdmFsICY9IH5SSF9BX1BTTTsgKGFzIHdhcyBkb25lIGJlZm9yZSB0aGlz
IGNoYW5nZSkgc29sdmVzDQo+ID4gdGhlIGlzc3VlDQo+ID4gICB3aGljaCBpcyB3ZWlyZCBiZWNh
dXNlIHRoZSBiaXQgaXMgc3VwcG9zZWQgdG8gYmUgaW5hY3RpdmUgd2hlbg0KPiA+IE5QUyBpcyBz
ZXQ7DQo+ID4gLSBTZXR0aW5nIG9oY2lfaGNkLmRpc3RydXN0X2Zpcm13YXJlPTAgaW4gdGhlIGNt
ZGxpbmUgcmVzdWx0cyBpbg0KPiA+IG5vdCBzZXR0aW5nDQo+ID4gICB0aGUgTlBTIGJpdCBhbmQg
YWxzbyBzb2x2ZXMgdGhlIGlzc3VlOw0KPiA+IC0gVGhlIGluaXRpYWwgdmFsdWUgb2YgdGhlIHJl
Z2lzdGVyIGF0IGZ1bmN0aW9uIGVudHJ5IGlzIDB4MTAwMTEwNA0KPiA+IChQU00gYml0DQo+ID4g
ICBpcyBzZXQsIE5QUyBpcyB1bnNldCk7DQo+ID4gLSBUaGUgT0hDSSBjb250cm9sbGVyIGlzIHRo
ZSBmb2xsb3dpbmc6DQo+ID4gMDA6MDMuMCBVU0IgY29udHJvbGxlcjogU2lsaWNvbiBJbnRlZ3Jh
dGVkIFN5c3RlbXMgW1NpU10gVVNCIDEuMQ0KPiA+IENvbnRyb2xsZXIgKHJldiAwZikgKHByb2ct
aWYgMTAgW09IQ0ldKQ0KPiA+IAlTdWJzeXN0ZW06IEFTVVNUZUsgQ29tcHV0ZXIgSW5jLiBEZXZp
Y2UgMWFhNw0KPiANCj4gR3JlYXQgcmVwb3J0aW5nIC0tIHRoYW5rcy4NCj4gDQo+ID4gRG9lcyB0
aGF0IG1ha2UgYW55IHNlbnNlIHRvIHlvdT8NCj4gPiANCj4gPiBJIHJlYWxseSB3b25kZXIgd2hh
dCBhIHByb3BlciBmaXggY291bGQgYmUgYW5kIGhlcmUgYXJlIHNvbWUNCj4gPiBzdWdnZXN0aW9u
czoNCj4gPiAtIEFkZGluZyBhIHNwZWNpZmljIHF1aXJrIHRvIGNsZWFyIHRoZSBQU00gYml0IGZv
ciB0aGlzIGhhcmR3YXJlDQo+ID4gd2hpY2ggc2VlbXMgdG8NCj4gPiAgIGNvbnNpZGVyIHRoZSBi
aXQgcmVnYXJkbGVzcyBvZiBOUFM7DQo+IA0KPiBXZSBkb24ndCBuZWVkIGEgcXVpcmsgZm9yIHRo
aXMuICBUaGVyZSBzaG91bGRuJ3QgYmUgYW55dGhpbmcgd3JvbmcNCj4gd2l0aCANCj4gX2Fsd2F5
c18gY2xlYXJpbmcgUFNNIHdoZW5ldmVyIE5QUyBpcyBzZXQsIHNpbmNlIHRoZSBjb250cm9sbGVy
IGlzIA0KPiBzdXBwb3NlZCB0byBpZ25vcmUgUFNNIHVuZGVyIHRoYXQgY29uZGl0aW9uLg0KPiAN
Cj4gV291bGQgeW91IGxpa2UgdG8gc3VibWl0IGEgcGF0Y2ggZm9yIHRoaXM/DQpZZXMsIEkgdGhp
bmsgdGhhdCBsb29rcyByZWFzb25hYmxlIHRvby4NCg0KPiANCj4gPiAtIEFkZGluZyB0aGUgcGF0
Y2ggdGhhdCBzZXRzIGRpc3RydXN0X2Zpcm13YXJlID0gZmFsc2UgdG8gc3RhYmxlDQo+ID4gYnJh
bmNoZXM7DQo+IA0KPiBUaGF0J3MgY2VydGFpbmx5IHJlYXNvbmFibGUuICBOb2JvZHkgaGFzIHJl
cG9ydGVkIGFueSBwcm9ibGVtcyBjYXVzZWQNCj4gYnkgDQo+IHRoYXQgcGF0Y2gsIHNvIGFkZGlu
ZyBpdCB0byB0aGUgc3RhYmxlIGJyYW5jaGVzIHNob3VsZCBiZSBzYWZlDQo+IGVub3VnaC4NCj4g
DQpZZXMsIHRoYXQgaXMgcHJvYmFibHkgYSBnb29kIGlkZWEuIEkndmUgY2FycmllZCBib3RoIHBh
dGNoZXMgbG9jYWxseQ0KZm9yIG15IHN5c3RlbXMuDQoNCj4gPiBXaGF0IGRvIHlvdSB0aGluaz8N
Cj4gDQo+IFdlIGNvdWxkIGV2ZW4gZG8gYm90aC4gIFRoYXQgd291bGQgaGVscCBpZiwgZm9yIGV4
YW1wbGUsIHNvbWVib2R5IA0KPiBkZWNpZGVkIHRvIHNldCBvaGNpX2hjZC5kaXN0cnVzdF9maXJt
d2FyZT10cnVlIGV4cGxpY2l0bHkuDQpJIHRoaW5rIGJvdGggbWlnaHQgYmUgYmVzdC4NCg0KPiAN
Cj4gR3JlZywgaW4gdGhlIG1lYW50aW1lIGNhbiB3ZSBoYXZlIGNvbW1pdCBjNDAwNWE4ZjY1ZWQg
KCJ1c2I6IG9oY2k6DQo+IE1ha2UgDQo+IGRpc3RydXN0X2Zpcm13YXJlIHBhcmFtIGRlZmF1bHQg
dG8gZmFsc2UiKSBhZGRlZCB0byBhbGwgdGhlIHN0YWJsZSANCj4ga2VybmVscyB3aGljaCBoYXZl
IGJhY2stcG9ydGVkIHZlcnNpb25zIG9mIGNvbW1pdCBiNzdkMmEwYTIyM2I/DQo+IA0KPiBBbGFu
IFN0ZXJuDQpJIHNlY29uZCB0aGF0Lg0KDQpUaGFua3MsDQpIYW1pc2ggTWFydGluDQoNCg==
