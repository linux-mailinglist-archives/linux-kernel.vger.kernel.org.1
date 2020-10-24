Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119D8297D5C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762169AbgJXQWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:22:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38980 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1762161AbgJXQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:22:46 -0400
X-UUID: d35c856461e14079aaa60df79081567a-20201025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=clO7x/VOL80tb0fdj/oUgJ/S8826gq/72f6K4BLeZc8=;
        b=sdiKsUzLPhVCy/zztNbQ1pmzh5iRJ3jpC1dx6qyvpEKtRcuyePMXz5+UN4qvhdeqyE/UIYze4RMh2zDInWTJXYt7Cz4dgx7sYQv/tVLBgF+s/9GLcOWnGC9013IBOhH7kFj64xhMuerh0gESrP6ZjavGQogSKq5p2ld/PDoRXIE=;
X-UUID: d35c856461e14079aaa60df79081567a-20201025
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1383216541; Sun, 25 Oct 2020 00:22:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 25 Oct 2020 00:22:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 25 Oct 2020 00:22:34 +0800
Message-ID: <1603556556.28119.4.camel@mtksdaap41>
Subject: Re: [PATCH v4 19/34] clk: mediatek: Add MT8192 imp i2c wrapper c
 clock support
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sun, 25 Oct 2020 00:22:36 +0800
In-Reply-To: <1603370247-30437-20-git-send-email-weiyi.lu@mediatek.com>
References: <1603370247-30437-1-git-send-email-weiyi.lu@mediatek.com>
         <1603370247-30437-20-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEwLTIyIGF0IDIwOjM3ICswODAwLCBXZWl5aSBMdSB3cm90ZToNCj4gQWRk
IE1UODE5MiBpbXAgaTJjIHdyYXBwZXIgYyBjbG9jayBwcm92aWRlcg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2Nsay9tZWRpYXRlay9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAgNiArKysNCj4gIGRy
aXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4g
IGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX2MuYyB8IDYyICsr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2OSBpbnNlcnRpb25z
KCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5
Mi1pbXBfaWljX3dyYXBfYy5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0
ZWsvS2NvbmZpZyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCj4gaW5kZXggOTliMDE2
OC4uYTBlYjc2ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0K
PiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQo+IEBAIC00OTEsNiArNDkxLDEy
IEBAIGNvbmZpZyBDT01NT05fQ0xLX01UODE5Ml9JTUdTWVMyDQo+ICAJaGVscA0KPiAgCSAgVGhp
cyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGltZ3N5czIgY2xvY2tzLg0KPiAgDQo+
ICtjb25maWcgQ09NTU9OX0NMS19NVDgxOTJfSU1QX0lJQ19XUkFQX0MNCj4gKwlib29sICJDbG9j
ayBkcml2ZXIgZm9yIE1lZGlhVGVrIE1UODE5MiBpbXBfaWljX3dyYXBfYyINCj4gKwlkZXBlbmRz
IG9uIENPTU1PTl9DTEtfTVQ4MTkyDQo+ICsJaGVscA0KPiArCSAgVGhpcyBkcml2ZXIgc3VwcG9y
dHMgTWVkaWFUZWsgTVQ4MTkyIGltcF9paWNfd3JhcF9jIGNsb2Nrcy4NCj4gKw0KPiAgY29uZmln
IENPTU1PTl9DTEtfTVQ4NTE2DQo+ICAJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBN
VDg1MTYiDQo+ICAJZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENPTVBJTEVfVEVTVA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUgYi9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9NYWtlZmlsZQ0KPiBpbmRleCAwMTJhMDFhLi44YWFjODIxIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL2Nsay9tZWRp
YXRlay9NYWtlZmlsZQ0KPiBAQCAtNjksNSArNjksNiBAQCBvYmotJChDT05GSUdfQ09NTU9OX0NM
S19NVDgxOTJfQ0FNU1lTX1JBV0IpICs9IGNsay1tdDgxOTItY2FtX3Jhd2Iubw0KPiAgb2JqLSQo
Q09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZU19SQVdDKSArPSBjbGstbXQ4MTkyLWNhbV9y
YXdjLm8NCj4gIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JTUdTWVMpICs9IGNsay1t
dDgxOTItaW1nLm8NCj4gIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JTUdTWVMyKSAr
PSBjbGstbXQ4MTkyLWltZzIubw0KPiArb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0lN
UF9JSUNfV1JBUF9DKSArPSBjbGstbXQ4MTkyLWltcF9paWNfd3JhcF9jLm8NCj4gIG9iai0kKENP
TkZJR19DT01NT05fQ0xLX01UODUxNikgKz0gY2xrLW10ODUxNi5vDQo+ICBvYmotJChDT05GSUdf
Q09NTU9OX0NMS19NVDg1MTZfQVVEU1lTKSArPSBjbGstbXQ4NTE2LWF1ZC5vDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltcF9paWNfd3JhcF9jLmMgYi9k
cml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltcF9paWNfd3JhcF9jLmMNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uZTdhMDAzMw0KPiAtLS0gL2Rldi9udWxs
DQo+ICsrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX2Mu
Yw0KPiBAQCAtMCwwICsxLDYyIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5DQo+ICsvLw0KPiArLy8gQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4N
Cj4gKy8vIEF1dGhvcjogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCj4gKw0KPiAr
I2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KPiArDQo+ICsjaW5jbHVkZSAiY2xrLW10ay5oIg0KPiArI2luY2x1ZGUg
ImNsay1nYXRlLmgiDQo+ICsNCj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxOTIt
Y2xrLmg+DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVncyBpbXBfaWlj
X3dyYXBfY19jZ19yZWdzID0gew0KPiArCS5zZXRfb2ZzID0gMHhlMDgsDQo+ICsJLmNscl9vZnMg
PSAweGUwNCwNCj4gKwkuc3RhX29mcyA9IDB4ZTAwLA0KPiArfTsNCj4gKw0KPiArI2RlZmluZSBH
QVRFX0lNUF9JSUNfV1JBUF9DKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9zaGlmdCkJCQlcDQo+ICsJ
R0FURV9NVEtfRkxBR1MoX2lkLCBfbmFtZSwgX3BhcmVudCwgJmltcF9paWNfd3JhcF9jX2NnX3Jl
Z3MsIF9zaGlmdCwJXA0KPiArCQkmbXRrX2Nsa19nYXRlX29wc19zZXRjbHIsIENMS19PUFNfUEFS
RU5UX0VOQUJMRSkNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBpbXBfaWlj
X3dyYXBfY19jbGtzW10gPSB7DQo+ICsJR0FURV9JTVBfSUlDX1dSQVBfQyhDTEtfSU1QX0lJQ19X
UkFQX0NfSTJDMTAsICJpbXBfaWljX3dyYXBfY19pMmMxMCIsICJpbmZyYV9pMmMwIiwgMCksDQo+
ICsJR0FURV9JTVBfSUlDX1dSQVBfQyhDTEtfSU1QX0lJQ19XUkFQX0NfSTJDMTEsICJpbXBfaWlj
X3dyYXBfY19pMmMxMSIsICJpbmZyYV9pMmMwIiwgMSksDQo+ICsJR0FURV9JTVBfSUlDX1dSQVBf
QyhDTEtfSU1QX0lJQ19XUkFQX0NfSTJDMTIsICJpbXBfaWljX3dyYXBfY19pMmMxMiIsICJpbmZy
YV9pMmMwIiwgMiksDQo+ICsJR0FURV9JTVBfSUlDX1dSQVBfQyhDTEtfSU1QX0lJQ19XUkFQX0Nf
STJDMTMsICJpbXBfaWljX3dyYXBfY19pMmMxMyIsICJpbmZyYV9pMmMwIiwgMyksDQo+ICt9Ow0K
PiArDQo+ICtzdGF0aWMgaW50IGNsa19tdDgxOTJfaW1wX2lpY193cmFwX2NfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgY2xrX29uZWNlbGxfZGF0
YSAqY2xrX2RhdGE7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9m
X25vZGU7DQo+ICsJaW50IHI7DQo+ICsNCj4gKwljbGtfZGF0YSA9IG10a19hbGxvY19jbGtfZGF0
YShDTEtfSU1QX0lJQ19XUkFQX0NfTlJfQ0xLKTsNCj4gKwlpZiAoIWNsa19kYXRhKQ0KPiArCQly
ZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCXIgPSBtdGtfY2xrX3JlZ2lzdGVyX2dhdGVzKG5vZGUs
IGltcF9paWNfd3JhcF9jX2Nsa3MsIEFSUkFZX1NJWkUoaW1wX2lpY193cmFwX2NfY2xrcyksDQo+
ICsJCQljbGtfZGF0YSk7DQo+ICsJaWYgKHIpDQo+ICsJCXJldHVybiByOw0KPiArDQo+ICsJcmV0
dXJuIG9mX2Nsa19hZGRfcHJvdmlkZXIobm9kZSwgb2ZfY2xrX3NyY19vbmVjZWxsX2dldCwgY2xr
X2RhdGEpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBv
Zl9tYXRjaF9jbGtfbXQ4MTkyX2ltcF9paWNfd3JhcF9jW10gPSB7DQo+ICsJeyAuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxOTItaW1wX2lpY193cmFwX2MiLCB9LA0KPiArCXt9DQo+ICt9Ow0K
DQpJdCBzZWVtcyB0aGVzZSBtdDgxOTItaW1wX2lpY193cmFwXyogZHJpdmVycyBhcmUgdmVyeSBz
aW1pbGFyLg0KSSB0aGluayBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8gdXNlIDEgc2luZ2xlIGRyaXZl
ciB0byBwcm92aWRlIHRoZW0sIGllOg0KDQorc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgb2ZfbWF0Y2hfY2xrX210ODE5Ml9pbXBfaWljX3dyYXBbXSA9IHsNCisJeyAuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxOTItaW1wX2lpY193cmFwX2MiLCBpbXBfaWljX3dyYXBfY19jbGtz
fSwNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItaW1wX2lpY193cmFwX2UiLCBp
bXBfaWljX3dyYXBfZV9jbGtzfSwNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTIt
aW1wX2lpY193cmFwX24iLCBpbXBfaWljX3dyYXBfbl9jbGtzfSwNCi4uLi4NCisJe30NCit9Ow0K
DQpNYXliZSBvdGhlciBjbGsgZHJpdmVycyBjYW4gYmUgbWVyZ2VkIHRvIHRoZSBzYW1lIGRyaXZl
cmwuDQoNCkpvZS5DDQoNCg==

