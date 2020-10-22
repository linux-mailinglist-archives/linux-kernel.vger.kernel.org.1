Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E94F295EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898729AbgJVMn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:43:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44187 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898274AbgJVMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:43:18 -0400
X-UUID: 2728acab323243e088c8faa689d6ada4-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SobSyCMICvJmmCK/vcOnM/ocufBHhNkzxEUiJKbmfYA=;
        b=b3Ml7RvJTEwvXpYQXutIRtweGjNBnkxYkjo6y9JUX3lv3Yi5jd0zRCV7+115EOy40QzGDY6lxifaDp25c8LJcbfbG5np5gbre0TORW7hgwxx4jiNQohRSLps5uq5W4uaQZKwdx8WiO2/IvFgFBhmNnbNbe3+TAfTLjVIR1YnTQA=;
X-UUID: 2728acab323243e088c8faa689d6ada4-20201022
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 597526833; Thu, 22 Oct 2020 20:37:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:55 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 20/34] clk: mediatek: Add MT8192 imp i2c wrapper e clock support
Date:   Thu, 22 Oct 2020 20:37:13 +0800
Message-ID: <1603370247-30437-21-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1603370247-30437-1-git-send-email-weiyi.lu@mediatek.com>
References: <1603370247-30437-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIE1UODE5MiBpbXAgaTJjIHdyYXBwZXIgZSBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2Zm
LWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsv
bWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrDQogZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX2UuYyB8IDU5ICsrKysrKysrKysr
KysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltcF9paWNfd3Jh
cF9lLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcgYi9kcml2
ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCBhMGViNzZkLi41YzI5OGVlIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9jbGsvbWVk
aWF0ZWsvS2NvbmZpZw0KQEAgLTQ5Nyw2ICs0OTcsMTIgQEAgY29uZmlnIENPTU1PTl9DTEtfTVQ4
MTkyX0lNUF9JSUNfV1JBUF9DDQogCWhlbHANCiAJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBNZWRp
YVRlayBNVDgxOTIgaW1wX2lpY193cmFwX2MgY2xvY2tzLg0KIA0KK2NvbmZpZyBDT01NT05fQ0xL
X01UODE5Ml9JTVBfSUlDX1dSQVBfRQ0KKwlib29sICJDbG9jayBkcml2ZXIgZm9yIE1lZGlhVGVr
IE1UODE5MiBpbXBfaWljX3dyYXBfZSINCisJZGVwZW5kcyBvbiBDT01NT05fQ0xLX01UODE5Mg0K
KwloZWxwDQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGltcF9paWNf
d3JhcF9lIGNsb2Nrcy4NCisNCiBjb25maWcgQ09NTU9OX0NMS19NVDg1MTYNCiAJYm9vbCAiQ2xv
Y2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDg1MTYiDQogCWRlcGVuZHMgb24gQVJDSF9NRURJQVRF
SyB8fCBDT01QSUxFX1RFU1QNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtl
ZmlsZSBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQppbmRleCA4YWFjODIxLi4zYWFl
NzVlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCisrKyBiL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQpAQCAtNzAsNSArNzAsNiBAQCBvYmotJChDT05G
SUdfQ09NTU9OX0NMS19NVDgxOTJfQ0FNU1lTX1JBV0MpICs9IGNsay1tdDgxOTItY2FtX3Jhd2Mu
bw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JTUdTWVMpICs9IGNsay1tdDgxOTIt
aW1nLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1HU1lTMikgKz0gY2xrLW10
ODE5Mi1pbWcyLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1QX0lJQ19XUkFQ
X0MpICs9IGNsay1tdDgxOTItaW1wX2lpY193cmFwX2Mubw0KK29iai0kKENPTkZJR19DT01NT05f
Q0xLX01UODE5Ml9JTVBfSUlDX1dSQVBfRSkgKz0gY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBfZS5v
DQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2KSArPSBjbGstbXQ4NTE2Lm8NCiBvYmot
JChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTZfQVVEU1lTKSArPSBjbGstbXQ4NTE2LWF1ZC5vDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBf
ZS5jIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBfZS5jDQpu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uODQwNDNhNWMNCi0tLSAvZGV2L251
bGwNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX2Uu
Yw0KQEAgLTAsMCArMSw1OSBAQA0KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9ubHkNCisvLw0KKy8vIENvcHlyaWdodCAoYykgMjAyMCBNZWRpYVRlayBJbmMuDQorLy8gQXV0
aG9yOiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KKw0KKyNpbmNsdWRlIDxsaW51
eC9jbGstcHJvdmlkZXIuaD4NCisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQor
DQorI2luY2x1ZGUgImNsay1tdGsuaCINCisjaW5jbHVkZSAiY2xrLWdhdGUuaCINCisNCisjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTkyLWNsay5oPg0KKw0KK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2dhdGVfcmVncyBpbXBfaWljX3dyYXBfZV9jZ19yZWdzID0gew0KKwkuc2V0X29m
cyA9IDB4ZTA4LA0KKwkuY2xyX29mcyA9IDB4ZTA0LA0KKwkuc3RhX29mcyA9IDB4ZTAwLA0KK307
DQorDQorI2RlZmluZSBHQVRFX0lNUF9JSUNfV1JBUF9FKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9z
aGlmdCkJCQlcDQorCUdBVEVfTVRLX0ZMQUdTKF9pZCwgX25hbWUsIF9wYXJlbnQsICZpbXBfaWlj
X3dyYXBfZV9jZ19yZWdzLCBfc2hpZnQsCVwNCisJCSZtdGtfY2xrX2dhdGVfb3BzX3NldGNsciwg
Q0xLX09QU19QQVJFTlRfRU5BQkxFKQ0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUg
aW1wX2lpY193cmFwX2VfY2xrc1tdID0gew0KKwlHQVRFX0lNUF9JSUNfV1JBUF9FKENMS19JTVBf
SUlDX1dSQVBfRV9JMkMzLCAiaW1wX2lpY193cmFwX2VfaTJjMyIsICJpbmZyYV9pMmMwIiwgMCks
DQorfTsNCisNCitzdGF0aWMgaW50IGNsa19tdDgxOTJfaW1wX2lpY193cmFwX2VfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCit7DQorCXN0cnVjdCBjbGtfb25lY2VsbF9kYXRh
ICpjbGtfZGF0YTsNCisJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25v
ZGU7DQorCWludCByOw0KKw0KKwljbGtfZGF0YSA9IG10a19hbGxvY19jbGtfZGF0YShDTEtfSU1Q
X0lJQ19XUkFQX0VfTlJfQ0xLKTsNCisJaWYgKCFjbGtfZGF0YSkNCisJCXJldHVybiAtRU5PTUVN
Ow0KKw0KKwlyID0gbXRrX2Nsa19yZWdpc3Rlcl9nYXRlcyhub2RlLCBpbXBfaWljX3dyYXBfZV9j
bGtzLCBBUlJBWV9TSVpFKGltcF9paWNfd3JhcF9lX2Nsa3MpLA0KKwkJCWNsa19kYXRhKTsNCisJ
aWYgKHIpDQorCQlyZXR1cm4gcjsNCisNCisJcmV0dXJuIG9mX2Nsa19hZGRfcHJvdmlkZXIobm9k
ZSwgb2ZfY2xrX3NyY19vbmVjZWxsX2dldCwgY2xrX2RhdGEpOw0KK30NCisNCitzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTkyX2ltcF9paWNfd3JhcF9l
W10gPSB7DQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWltcF9paWNfd3JhcF9l
IiwgfSwNCisJe30NCit9Ow0KKw0KK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNsa19t
dDgxOTJfaW1wX2lpY193cmFwX2VfZHJ2ID0gew0KKwkucHJvYmUgPSBjbGtfbXQ4MTkyX2ltcF9p
aWNfd3JhcF9lX3Byb2JlLA0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUgPSAiY2xrLW10ODE5Mi1p
bXBfaWljX3dyYXBfZSIsDQorCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9jbGtfbXQ4MTky
X2ltcF9paWNfd3JhcF9lLA0KKwl9LA0KK307DQorDQorYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIo
Y2xrX210ODE5Ml9pbXBfaWljX3dyYXBfZV9kcnYpOw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

