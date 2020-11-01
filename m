Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8E2A1DFB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 13:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKAMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 07:48:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43533 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726517AbgKAMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 07:48:57 -0500
X-UUID: 69f47044e82d4752891d4837a83b40bd-20201101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=T9oJMU+t5XPbuAxFuLhwzMivW8NW/dhCpaqdCmT8708=;
        b=Fnz8Ke7XxjTi77ldcKJPeWhtz4HcVfqiWf+O0hSPJuZ7LgELIxqzHhmzbqmqtybejW6ijtxO00xqnBvLG46/G7TtrSX7tiofuEc32Kkr2R7B0Oqu+xTHxnCFJtmpWxIgBFF5IwMi3sym18ICKZS0H5xx06L66pKWoCnEk+OQG5U=;
X-UUID: 69f47044e82d4752891d4837a83b40bd-20201101
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1434475514; Sun, 01 Nov 2020 20:48:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 1 Nov 2020 20:48:50 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 1 Nov 2020 20:48:51 +0800
Message-ID: <1604234932.13617.0.camel@mtkswgap22>
Subject: Re: [PATCH v2 3/4] arm: mm: introduce L_PTE_SPECIAL
From:   Miles Chen <miles.chen@mediatek.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <steve.capper@linaro.org>,
        Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 1 Nov 2020 20:48:52 +0800
In-Reply-To: <20201027091151.GK1551@shell.armlinux.org.uk>
References: <20201023091437.8225-1-miles.chen@mediatek.com>
         <20201023091437.8225-4-miles.chen@mediatek.com>
         <20201023100810.GY1551@shell.armlinux.org.uk>
         <1603784712.12492.5.camel@mtkswgap22>
         <20201027091151.GK1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTEwLTI3IGF0IDA5OjExICswMDAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4gd3JvdGU6DQo+IE9uIFR1ZSwgT2N0IDI3LCAyMDIwIGF0IDAzOjQ1OjEyUE0gKzA4
MDAsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDIwLTEwLTIzIGF0IDExOjA4ICsw
MTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggYWRtaW4gd3JvdGU6DQo+ID4gPiBPbiBGcmks
IE9jdCAyMywgMjAyMCBhdCAwNToxNDozNlBNICswODAwLCBNaWxlcyBDaGVuIHdyb3RlOg0KPiA+
ID4gPiBGcm9tOiBNaW5jaGFuIEtpbSA8bWluY2hhbkBrZXJuZWwub3JnPg0KPiA+ID4gPiANCj4g
PiA+ID4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIExfUFRFX1NQRUNJQUwgYW5kIHB0ZSBmdW5jdGlv
bnMgZm9yIHN1cHBvcnRpbmcNCj4gPiA+ID4gZ2V0X3VzZXJfcGFnZXNfZmFzdC4NCj4gPiA+ID4g
DQo+ID4gPiA+IENjOiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gPiA+
ID4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+ID4gPiA+
IENjOiBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4NCj4gPiA+ID4gQ2M6IFN0ZXZl
IENhcHBlciA8c3RldmUuY2FwcGVyQGxpbmFyby5vcmc+DQo+ID4gPiA+IENjOiBNaW5jaGFuIEtp
bSA8bWluY2hhbkBrZXJuZWwub3JnPg0KPiA+ID4gPiBDYzogU3VyZW4gQmFnaGRhc2FyeWFuIDxz
dXJlbmJAZ29vZ2xlLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWluY2hhbiBLaW0gPG1p
bmNoYW5Aa2VybmVsLm9yZz4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8bWls
ZXMuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgYXJjaC9hcm0vS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsrLS0NCj4gPiA+ID4gIGFyY2gvYXJtL2lu
Y2x1ZGUvYXNtL3BndGFibGUtMmxldmVsLmggfCAgMSArDQo+ID4gPiA+ICBhcmNoL2FybS9pbmNs
dWRlL2FzbS9wZ3RhYmxlLTNsZXZlbC5oIHwgIDYgLS0tLS0tDQo+ID4gPiA+ICBhcmNoL2FybS9p
bmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+ID4gPiAg
NCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+ID4g
PiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL0tjb25maWcgYi9hcmNoL2FybS9LY29u
ZmlnDQo+ID4gPiA+IGluZGV4IGMxOGZhOWQzODJiNy4uMWY3NTg2NGI3YzdhIDEwMDY0NA0KPiA+
ID4gPiAtLS0gYS9hcmNoL2FybS9LY29uZmlnDQo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtL0tjb25m
aWcNCj4gPiA+ID4gQEAgLTEzLDcgKzEzLDcgQEAgY29uZmlnIEFSTQ0KPiA+ID4gPiAgCXNlbGVj
dCBBUkNIX0hBU19LQ09WDQo+ID4gPiA+ICAJc2VsZWN0IEFSQ0hfSEFTX01FTUJBUlJJRVJfU1lO
Q19DT1JFDQo+ID4gPiA+ICAJc2VsZWN0IEFSQ0hfSEFTX05PTl9PVkVSTEFQUElOR19BRERSRVNT
X1NQQUNFDQo+ID4gPiA+IC0Jc2VsZWN0IEFSQ0hfSEFTX1BURV9TUEVDSUFMIGlmIEFSTV9MUEFF
DQo+ID4gPiA+ICsJc2VsZWN0IEFSQ0hfSEFTX1BURV9TUEVDSUFMIGlmIChBUk1fTFBBRSB8fCBD
UFVfVjcgfHwgQ1BVX1Y2IHx8IENQVVY2SykNCj4gPiA+ID4gIAlzZWxlY3QgQVJDSF9IQVNfUEhZ
U19UT19ETUENCj4gPiA+ID4gIAlzZWxlY3QgQVJDSF9IQVNfU0VUVVBfRE1BX09QUw0KPiA+ID4g
PiAgCXNlbGVjdCBBUkNIX0hBU19TRVRfTUVNT1JZDQo+ID4gPiA+IEBAIC04Miw3ICs4Miw3IEBA
IGNvbmZpZyBBUk0NCj4gPiA+ID4gIAlzZWxlY3QgSEFWRV9EWU5BTUlDX0ZUUkFDRV9XSVRIX1JF
R1MgaWYgSEFWRV9EWU5BTUlDX0ZUUkFDRQ0KPiA+ID4gPiAgCXNlbGVjdCBIQVZFX0VGRklDSUVO
VF9VTkFMSUdORURfQUNDRVNTIGlmIChDUFVfVjYgfHwgQ1BVX1Y2SyB8fCBDUFVfVjcpICYmIE1N
VQ0KPiA+ID4gPiAgCXNlbGVjdCBIQVZFX0VYSVRfVEhSRUFEDQo+ID4gPiA+IC0Jc2VsZWN0IEhB
VkVfRkFTVF9HVVAgaWYgQVJNX0xQQUUNCj4gPiA+ID4gKwlzZWxlY3QgSEFWRV9GQVNUX0dVUCBp
ZiAoQVJNX0xQQUUgfHwgQ1BVX1Y3IHx8IENQVV9WNiB8fCBDUFVWNkspDQo+ID4gPiA+ICAJc2Vs
ZWN0IEhBVkVfRlRSQUNFX01DT1VOVF9SRUNPUkQgaWYgIVhJUF9LRVJORUwNCj4gPiA+ID4gIAlz
ZWxlY3QgSEFWRV9GVU5DVElPTl9HUkFQSF9UUkFDRVIgaWYgIVRIVU1CMl9LRVJORUwgJiYgIUND
X0lTX0NMQU5HDQo+ID4gPiA+ICAJc2VsZWN0IEhBVkVfRlVOQ1RJT05fVFJBQ0VSIGlmICFYSVBf
S0VSTkVMDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxl
LTJsZXZlbC5oIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vcGd0YWJsZS0ybGV2ZWwuaA0KPiA+ID4g
PiBpbmRleCBjZGNkNTVjY2EzN2QuLjM4NWU3YTMyMzk0ZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
YXJjaC9hcm0vaW5jbHVkZS9hc20vcGd0YWJsZS0ybGV2ZWwuaA0KPiA+ID4gPiArKysgYi9hcmNo
L2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oDQo+ID4gPiA+IEBAIC0xMTcsNiArMTE3
LDcgQEANCj4gPiA+ID4gICNkZWZpbmUgTF9QVEVfVkFMSUQJCShfQVQocHRldmFsX3QsIDEpIDw8
IDApCQkvKiBWYWxpZCAqLw0KPiA+ID4gPiAgI2RlZmluZSBMX1BURV9QUkVTRU5UCQkoX0FUKHB0
ZXZhbF90LCAxKSA8PCAwKQ0KPiA+ID4gPiAgI2RlZmluZSBMX1BURV9ZT1VORwkJKF9BVChwdGV2
YWxfdCwgMSkgPDwgMSkNCj4gPiA+ID4gKyNkZWZpbmUgTF9QVEVfU1BFQ0lBTAkJKF9BVChwdGV2
YWxfdCwgMSkgPDwgNSkNCj4gPiA+IA0KPiA+ID4gSG93IGRvZXMgdGhpcyB3b3JrPyAgQml0cyAy
IHRocm91Z2ggNSBhcmUgYWxyZWFkeSBpbiB1c2UgZm9yIHRoZSBtZW1vcnkNCj4gPiA+IHR5cGUu
DQo+ID4gPiANCj4gPiA+IFJlcHVycG9zaW5nIHRoaXMgYml0IG1lYW5zIHRoYXQgTF9QVEVfTVRf
REVWX05PTlNIQVJFRCwNCj4gPiA+IExfUFRFX01UX0RFVl9XQywgTF9QVEVfTVRfREVWX0NBQ0hF
RCBhbmQgTF9QVEVfTVRfVkVDVE9SUyBjbGFzaCB3aXRoDQo+ID4gPiBpdC4NCj4gPiANCj4gPiBU
aGFua3MgZm9yIHRoZSBjb21tZW50Lg0KPiA+IFRoZSBpZGVhIGlzIHRvIHJlLW9yZGVyIHRoZSBt
ZW1vcnkgdHlwZSB0YWJsZSBpbiBbMV0gKHBhdGNoIHYyLzQpIGFuZA0KPiA+IHVzZSBiaXQgNSBm
b3IgTF9QVEVfU1BFQ0lBTC4NCj4gDQo+IFRoYW5rcywgSSBrbm93IHdoYXQgeW91IGFyZSB0cnlp
bmcgdG8gYWNoaWV2ZS4gSSBkb24ndCB0aGluayBpdCdzDQo+IHBvc3NpYmxlIHdpdGhvdXQgYnJl
YWtpbmcgdGhlIGtlcm5lbCBvbiBzb21lIENQVXMgYW5kIGNvbmZpZ3VyYXRpb25zLg0KPiANCkdv
dCBpdC4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KDQpNaWxlcw0K

