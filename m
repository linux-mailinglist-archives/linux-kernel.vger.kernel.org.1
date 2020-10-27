Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D776129A5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508031AbgJ0Hpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:45:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54011 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388325AbgJ0Hph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:45:37 -0400
X-UUID: 80b86bca34ee481a8807d484fdf9e79d-20201027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aGt6QInp83VuseH7EJv5vbzqb7DasMCsQr38Kz5cgVA=;
        b=R7cJRV9eyeUuH1jt+Xwoc9i9vYGTsPhsGmst7AzAUfnPSAqVHLm+jNXw0wX1v5mVCRFp4Hr9jfjrIl6xSjBij37rnJkIZgLpjRXQIjx5XH3W+WoHUTWJLWZPXgslmlOXHTpOFb0tP4wK0tFUPh7I0Q0yT10JAEyFPb/7VwbLRkQ=;
X-UUID: 80b86bca34ee481a8807d484fdf9e79d-20201027
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1386385475; Tue, 27 Oct 2020 15:45:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Oct 2020 15:45:11 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Oct 2020 15:45:11 +0800
Message-ID: <1603784712.12492.5.camel@mtkswgap22>
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
Date:   Tue, 27 Oct 2020 15:45:12 +0800
In-Reply-To: <20201023100810.GY1551@shell.armlinux.org.uk>
References: <20201023091437.8225-1-miles.chen@mediatek.com>
         <20201023091437.8225-4-miles.chen@mediatek.com>
         <20201023100810.GY1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDExOjA4ICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4gd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDIzLCAyMDIwIGF0IDA1OjE0OjM2UE0gKzA4
MDAsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4gRnJvbTogTWluY2hhbiBLaW0gPG1pbmNoYW5Aa2Vy
bmVsLm9yZz4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgTF9QVEVfU1BFQ0lBTCBh
bmQgcHRlIGZ1bmN0aW9ucyBmb3Igc3VwcG9ydGluZw0KPiA+IGdldF91c2VyX3BhZ2VzX2Zhc3Qu
DQo+ID4gDQo+ID4gQ2M6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPg0KPiA+
IENjOiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KPiA+IENjOiBX
aWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4NCj4gPiBDYzogU3RldmUgQ2FwcGVyIDxz
dGV2ZS5jYXBwZXJAbGluYXJvLm9yZz4NCj4gPiBDYzogTWluY2hhbiBLaW0gPG1pbmNoYW5Aa2Vy
bmVsLm9yZz4NCj4gPiBDYzogU3VyZW4gQmFnaGRhc2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5jaGFuIEtpbSA8bWluY2hhbkBrZXJuZWwub3JnPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL2FybS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKyst
LQ0KPiA+ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oIHwgIDEgKw0KPiA+
ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLTNsZXZlbC5oIHwgIDYgLS0tLS0tDQo+ID4g
IGFyY2gvYXJtL2luY2x1ZGUvYXNtL3BndGFibGUuaCAgICAgICAgfCAxMyArKysrKysrKysrKysr
DQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vS2NvbmZpZyBiL2FyY2gvYXJtL0tjb25m
aWcNCj4gPiBpbmRleCBjMThmYTlkMzgyYjcuLjFmNzU4NjRiN2M3YSAxMDA2NDQNCj4gPiAtLS0g
YS9hcmNoL2FybS9LY29uZmlnDQo+ID4gKysrIGIvYXJjaC9hcm0vS2NvbmZpZw0KPiA+IEBAIC0x
Myw3ICsxMyw3IEBAIGNvbmZpZyBBUk0NCj4gPiAgCXNlbGVjdCBBUkNIX0hBU19LQ09WDQo+ID4g
IAlzZWxlY3QgQVJDSF9IQVNfTUVNQkFSUklFUl9TWU5DX0NPUkUNCj4gPiAgCXNlbGVjdCBBUkNI
X0hBU19OT05fT1ZFUkxBUFBJTkdfQUREUkVTU19TUEFDRQ0KPiA+IC0Jc2VsZWN0IEFSQ0hfSEFT
X1BURV9TUEVDSUFMIGlmIEFSTV9MUEFFDQo+ID4gKwlzZWxlY3QgQVJDSF9IQVNfUFRFX1NQRUNJ
QUwgaWYgKEFSTV9MUEFFIHx8IENQVV9WNyB8fCBDUFVfVjYgfHwgQ1BVVjZLKQ0KPiA+ICAJc2Vs
ZWN0IEFSQ0hfSEFTX1BIWVNfVE9fRE1BDQo+ID4gIAlzZWxlY3QgQVJDSF9IQVNfU0VUVVBfRE1B
X09QUw0KPiA+ICAJc2VsZWN0IEFSQ0hfSEFTX1NFVF9NRU1PUlkNCj4gPiBAQCAtODIsNyArODIs
NyBAQCBjb25maWcgQVJNDQo+ID4gIAlzZWxlY3QgSEFWRV9EWU5BTUlDX0ZUUkFDRV9XSVRIX1JF
R1MgaWYgSEFWRV9EWU5BTUlDX0ZUUkFDRQ0KPiA+ICAJc2VsZWN0IEhBVkVfRUZGSUNJRU5UX1VO
QUxJR05FRF9BQ0NFU1MgaWYgKENQVV9WNiB8fCBDUFVfVjZLIHx8IENQVV9WNykgJiYgTU1VDQo+
ID4gIAlzZWxlY3QgSEFWRV9FWElUX1RIUkVBRA0KPiA+IC0Jc2VsZWN0IEhBVkVfRkFTVF9HVVAg
aWYgQVJNX0xQQUUNCj4gPiArCXNlbGVjdCBIQVZFX0ZBU1RfR1VQIGlmIChBUk1fTFBBRSB8fCBD
UFVfVjcgfHwgQ1BVX1Y2IHx8IENQVVY2SykNCj4gPiAgCXNlbGVjdCBIQVZFX0ZUUkFDRV9NQ09V
TlRfUkVDT1JEIGlmICFYSVBfS0VSTkVMDQo+ID4gIAlzZWxlY3QgSEFWRV9GVU5DVElPTl9HUkFQ
SF9UUkFDRVIgaWYgIVRIVU1CMl9LRVJORUwgJiYgIUNDX0lTX0NMQU5HDQo+ID4gIAlzZWxlY3Qg
SEFWRV9GVU5DVElPTl9UUkFDRVIgaWYgIVhJUF9LRVJORUwNCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vaW5jbHVkZS9hc20vcGd0YWJsZS0ybGV2ZWwuaCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNt
L3BndGFibGUtMmxldmVsLmgNCj4gPiBpbmRleCBjZGNkNTVjY2EzN2QuLjM4NWU3YTMyMzk0ZSAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oDQo+
ID4gKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vcGd0YWJsZS0ybGV2ZWwuaA0KPiA+IEBAIC0x
MTcsNiArMTE3LDcgQEANCj4gPiAgI2RlZmluZSBMX1BURV9WQUxJRAkJKF9BVChwdGV2YWxfdCwg
MSkgPDwgMCkJCS8qIFZhbGlkICovDQo+ID4gICNkZWZpbmUgTF9QVEVfUFJFU0VOVAkJKF9BVChw
dGV2YWxfdCwgMSkgPDwgMCkNCj4gPiAgI2RlZmluZSBMX1BURV9ZT1VORwkJKF9BVChwdGV2YWxf
dCwgMSkgPDwgMSkNCj4gPiArI2RlZmluZSBMX1BURV9TUEVDSUFMCQkoX0FUKHB0ZXZhbF90LCAx
KSA8PCA1KQ0KPiANCj4gSG93IGRvZXMgdGhpcyB3b3JrPyAgQml0cyAyIHRocm91Z2ggNSBhcmUg
YWxyZWFkeSBpbiB1c2UgZm9yIHRoZSBtZW1vcnkNCj4gdHlwZS4NCj4gDQo+IFJlcHVycG9zaW5n
IHRoaXMgYml0IG1lYW5zIHRoYXQgTF9QVEVfTVRfREVWX05PTlNIQVJFRCwNCj4gTF9QVEVfTVRf
REVWX1dDLCBMX1BURV9NVF9ERVZfQ0FDSEVEIGFuZCBMX1BURV9NVF9WRUNUT1JTIGNsYXNoIHdp
dGgNCj4gaXQuDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuDQpUaGUgaWRlYSBpcyB0byByZS1v
cmRlciB0aGUgbWVtb3J5IHR5cGUgdGFibGUgaW4gWzFdIChwYXRjaCB2Mi80KSBhbmQNCnVzZSBi
aXQgNSBmb3IgTF9QVEVfU1BFQ0lBTC4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Bh
dGNod29yay9wYXRjaC8xMzIzODkzLw0KDQoNCk1pbGVzDQo=

