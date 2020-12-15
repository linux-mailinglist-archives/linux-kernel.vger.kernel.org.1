Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35A2DA76D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 06:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgLOFWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 00:22:25 -0500
Received: from mg.richtek.com ([220.130.44.152]:42996 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgLOFWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 00:22:08 -0500
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(14680:0:AUTH_RELAY)
        (envelope-from <prvs=1616E08E19=cy_huang@richtek.com>); Tue, 15 Dec 2020 13:16:06 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(1671:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Tue, 15 Dec 2020 13:08:30 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Tue, 15 Dec 2020
 13:08:30 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0721.002; Tue, 15 Dec 2020
 13:08:30 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "u0084500@gmail.com" <u0084500@gmail.com>
CC:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Thread-Topic: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Thread-Index: AQHW0f/PhzyfguXN7EejAujRBypYk6n2JCWAgACQZYCAAGIAgA==
Date:   Tue, 15 Dec 2020 05:08:29 +0000
Message-ID: <1608008909.2963.7.camel@richtek.com>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
         <1607704424-16223-2-git-send-email-u0084500@gmail.com>
         <20201214095916.4g47zlueng4wa3hv@holly.lan>
         <CADiBU38wZ+yrfjbggJyY7BHc5-tdV-KWVgWBmZn-q3EY99=PPg@mail.gmail.com>
         <20201214231743.GA2560842@robh.at.kernel.org>
In-Reply-To: <20201214231743.GA2560842@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.19.169]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3346907517D214E948F96E96A839481@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBEZWMgMTQsIDIwMjAgYXQgMTA6NDA6NTVQTSArMDgwMCwgQ2hpWXVhbiBIdWFuZyB3
cm90ZToNCj4NCj4gSGksDQo+DQo+IERhbmllbCBUaG9tcHNvbiA8ZGFuaWVsLnRob21wc29uQGxp
bmFyby5vcmc+IOaWvCAyMDIw5bm0MTLmnIgxNOaXpSDpgLHkuIANCj4g5LiL5Y2INTo1OeWvq+mB
k++8mg0KPiA+DQo+ID4NCj4gPiBIaSBDWQ0KPiA+DQo+ID4gT24gU2F0LCBEZWMgMTIsIDIwMjAg
YXQgMTI6MzM6NDNBTSArMDgwMCwgY3lfaHVhbmcgd3JvdGU6DQo+ID4gPg0KPiA+ID4gRnJvbTog
Q2hpWXVhbiBIdWFuZyA8Y3lfaHVhbmdAcmljaHRlay5jb20+DQo+ID4gPg0KPiA+ID4gQWRkcyBE
VCBiaW5kaW5nIGRvY3VtZW50IGZvciBSaWNodGVrIFJUNDgzMSBiYWNrbGlnaHQuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hpWXVhbiBIdWFuZyA8Y3lfaHVhbmdAcmljaHRlay5jb20+
DQo+ID4gVGhpcyBwYXRjaCBnb3Qga2V5d29yZCBmaWx0ZXJlZCBhbmQgYnJvdWdodCB0byBteSBh
dHRlbnRpb24NCj4gPiBidXQgdGhlIHJlc3Qgb2YgdGhlIHNlcmllcyBkaWQgbm90Lg0KPiA+DQo+
ID4gSWYgaXQgd2FzIGEgYmFja2xpZ2h0IHBhdGNoIHNlcmllcyB5b3UgbmVlZCB0byBzZW5kIGl0
IFRvOiB0aGUNCj4gPiBhbGwgdGhlIGJhY2tsaWdodCBtYWludGFpbmVycy4NCj4gPg0KPiBZZXMs
IEknbSB3YWl0aW5nIGZvciBtZmQgcmV2aWV3aW5nLg0KPiBEdWUgdG8gbWZkIHBhdGNoLCBJIG5l
ZWQgdG8gYWRkIGJhY2tsaWdodCBkdC1iaW5kaW5nIHBhdGNoIHByaW9yIHRvDQo+IGJhY2tsaWdo
dCBzb3VyY2UgY29kZS4NCj4gT3IgYXV0b2J1aWxkIHJvYm90IHdpbGwgc2FpZCBtZmQgZHQtYmlu
ZGluZyBidWlsZCBmYWlsIGZyb20gUm9iLg0KPiBUaGF0J3Mgd2h5IEkgc2VuZCB0aGUgYmFja2xp
Z2h0IGR0LWJpbmRpbmcgcHJpb3IgdG8gdGhlIHNvdXJjZSBjb2RlLg0KPg0KPiBJIHN0aWxsIGhh
dmUgYmFja2xpZ2h0L3JlZ3VsYXRvciBzb3VyY2UgY29kZSBwYXRjaCBhZnRlciBtZmQNCj4gcmV2
aWV3aW5nLg0KPiBEbyB5b3Ugd2FudCBtZSB0byBzZW5kIGFsbCB0aGUgcGF0Y2hlcyB3aXRob3V0
IHdhaXRpbmcgZm9yIG1mZA0KPiByZXZpZXdpbmc/DQpXaGF0IGhhcHBlbmVkIHRvIHRoZSByZWd1
bGF0b3IgcGFydCBvZiB0aGUgYmluZGluZz8gSSBzYWlkIHlvdSBjb3VsZA0KbWVyZ2UgaXQgaW50
byB0aGUgbWZkIHNjaGVtYSwgbm90IGRyb3AgaXQuIEJpbmRpbmdzIHNob3VsZCBiZSBjb21wbGV0
ZQ0Kc28gd2UgZ2V0IGEgZnVsbCBwaWN0dXJlIG9mIGEgZGV2aWNlLg0KDQpZZXMsIEkgcmVtb3Zl
IHRoZSByZWd1bGF0b3IgZHQtYmluZGluZyBhbmQgZGlyZWN0bHkgbWVyZ2UgaW50byBtZmQNCnNj
aGVtYS4gQ291bGQgeW91IGNoZWNrIHRoZSB2NCAzLzMgcGF0Y2g/DQpPciB5b3UganVzdCB3YW50
IG1lIHRvIHJlbW92ZSByZWd1bGF0b3IgZHQtYmluZGluZyBleGFtcGxlIGluIHJlZ3VsYXRvcg0K
ZHQtYmluZGluZyBwYXRjaD8NCg0KU29ycnksIHBsZWFzZSBhbHNvIGxvb3AgbXkgZ21haWwgYWNj
b3VudC4NCkR1ZSB0byBteSBjb21wYW55IG1haWxib3gsIEknbSBub3Qgc3VyZSB3aGV0aGVyIHRo
ZSByZXBseSBmb3JtYXQgaXMNCmNvcnJlY3Qgb3Igbm90Lg0KDQpSb2INCioqKioqKioqKioqKiog
RW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0KDQpUaGUg
aW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBh
bnkgYXR0YWNobWVudHMpIG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2aWxl
Z2VkLCBvciBvdGhlcndpc2UgZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxl
IGxhd3MuIEl0IGlzIGludGVuZGVkIHRvIGJlIGNvbnZleWVkIG9ubHkgdG8gdGhlIGRlc2lnbmF0
ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24sIHBy
aW50aW5nLCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGl0
cyBhdHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3RyaWN0bHkgcHJv
aGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCBy
ZWNpcGllbnQgb2YgdGhpcyBlLW1haWwsIG9yIGJlbGlldmUgdGhhdCB5b3UgaGF2ZSByZWNlaXZl
ZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5kIGFsbCBjb3Bp
ZXMgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZyb20geW91ciBz
eXN0ZW0sIGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwgdG8g
YW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0K
