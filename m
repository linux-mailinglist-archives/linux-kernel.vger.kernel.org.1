Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B532B7502
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgKRDuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:50:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46822 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725613AbgKRDuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:50:13 -0500
X-UUID: 5c27fc8608614bf597ab7e98b18e3bcd-20201118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kF/INCW/2jYXxM9LXFS6EoXUIq77hAmvBpBxqoM7wak=;
        b=WiYeA9PYRytVY6p5c9gU/8YBSAk0bSP68tCA7ideHpQJX5WPJGQJAV1nwvdnM2YZZmcZootKZF0kuntPtpXBeLqS4Eq4KJrQdxnt1C3E8dp7+psTp9XJnR/c655J8VQj1DgONhnvbwukgLtx/jbm1XTexebE1xw55nX2iyWFly8=;
X-UUID: 5c27fc8608614bf597ab7e98b18e3bcd-20201118
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1970448491; Wed, 18 Nov 2020 11:50:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 Nov 2020 11:49:42 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Nov 2020 11:49:43 +0800
Message-ID: <1605671382.23622.8.camel@mtksdaap41>
Subject: Re: [PATCH v5 14/24] clk: mediatek: Add MT8192 imp i2c wrapper
 clock support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Wed, 18 Nov 2020 11:49:42 +0800
In-Reply-To: <1605667293.8636.5.camel@mtksdaap41>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
         <1604887429-29445-15-git-send-email-weiyi.lu@mediatek.com>
         <1605667293.8636.5.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTE4IGF0IDEwOjQxICswODAwLCBZaW5nam9lIENoZW4gd3JvdGU6DQo+
IE9uIE1vbiwgMjAyMC0xMS0wOSBhdCAxMDowMyArMDgwMCwgV2VpeWkgTHUgd3JvdGU6DQo+ID4g
QWRkIE1UODE5MiBpbXAgaTJjIHdyYXBwZXIgY2xvY2sgcHJvdmlkZXINCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgICA2ICsr
DQo+ID4gIGRyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAg
IDEgKw0KPiA+ICBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltcF9paWNfd3JhcC5j
IHwgMTE5ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAx
MjYgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVk
aWF0ZWsvY2xrLW10ODE5Mi1pbXBfaWljX3dyYXAuYw0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZp
Zw0KPiA+IGluZGV4IGViNTQ5ZjguLjhhY2M3ZDYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25m
aWcNCj4gPiBAQCAtNTE1LDYgKzUxNSwxMiBAQCBjb25maWcgQ09NTU9OX0NMS19NVDgxOTJfSU1H
U1lTDQo+ID4gIAloZWxwDQo+ID4gIAkgIFRoaXMgZHJpdmVyIHN1cHBvcnRzIE1lZGlhVGVrIE1U
ODE5MiBpbWdzeXMgYW5kIGltZ3N5czIgY2xvY2tzLg0KPiA+ICANCj4gPiArY29uZmlnIENPTU1P
Tl9DTEtfTVQ4MTkyX0lNUF9JSUNfV1JBUA0KPiA+ICsJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBN
ZWRpYVRlayBNVDgxOTIgaW1wX2lpY193cmFwIg0KPiA+ICsJZGVwZW5kcyBvbiBDT01NT05fQ0xL
X01UODE5Mg0KPiA+ICsJaGVscA0KPiA+ICsJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBNZWRpYVRl
ayBNVDgxOTIgaW1wX2lpY193cmFwIGNsb2Nrcy4NCj4gPiArDQo+ID4gIGNvbmZpZyBDT01NT05f
Q0xLX01UODUxNg0KPiA+ICAJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDg1MTYi
DQo+ID4gIAlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQo+IA0KPiA8
Li4uPg0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNsa19t
dDgxOTJfaW1wX2lpY193cmFwX2RydiA9IHsNCj4gPiArCS5wcm9iZSA9IG10a19jbGtfc2ltcGxl
X3Byb2JlLA0KPiANCj4gR29vZCB0byBoYXZlIHRoaXMgZ2VuZXJpYyBwcm9iZSBmdW5jdGlvbi4g
Tm93IHNldmVyYWwgbXRrIGNsayBkcml2ZXJzDQo+IGFyZSBqdXN0IGEgZmV3IGRhdGEuDQo+IA0K
PiBCdXQgdGhpcyBzZXJpZXMgc3RpbGwgYWRkID4xMCBjb25maWdzIGZvciBtdDgxOTIgY2xvY2sg
ZHJpdmVycy4gV2h5IGRvDQo+IHdlIG5lZWQgc2VwYXJhdGUgY29uZmlncyBmb3IgY2xvY2tzIG9m
IGRpZmZlcmVudCBkb21haW4/IEkgZG9uJ3QgdGhpbmsNCj4gdGhleSBuZWVkIGxvdHMgb2YgcmVz
b3VyY2UuIFdlIHNob3VsZCByZXZpZXcgdGhlIHJhdGlvbmFsZSBhbmQgcmVkdWNlDQo+IHRoZSBu
dW1iZXJzLiANCj4gDQpIaSBKb2UsDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KDQpUaGVyZSBo
YXZlIGJlZW4gc29tZSBkaXNjdXNzaW9ucyBpbiBwYXRjaFsxXSBhcyB0byB3aHkgdGhlIHN1YnN5
c3RlbQ0KY2xvY2tzIGFyZSBub3cgc2VwYXJhdGVkIGJ5IGRpZmZlcmVudCBjb25maWdzLg0KQW5k
IHdlIGRvIG5lZWQgdGhlc2UgY2xvY2tzIHRvIGJlIG9wdGlvbmFsIG9uIHNvbWUgTWVkaWF0VGVr
IFNvQw0KcGxhdGZvcm0uDQoNCkkgdGhvdWdodCBpdCBpdCBub3cgYSByYXRpb25hbGUgbnVtYmVy
IG9mIHN1YnN5c3RlbSBjbG9jayBwcm92aWRlcg0KZHJpdmVycy4gSW4gdGhpcyBzZXJpZXMsIHdl
IGhhdmUgcmVkdWNlZCBmcm9tIDIzIHRvIDEyLg0KDQpbMV0NCmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8xNDYwNjIxNTE0LTY1MTkxLTUt
Z2l0LXNlbmQtZW1haWwtamFtZXNqai5saWFvQG1lZGlhdGVrLmNvbS8NCg0KDQo+IA0KPiBKb2Uu
Qw0KPiANCj4gDQoNCg==

