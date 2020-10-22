Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B61295EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898723AbgJVMn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:43:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44200 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898635AbgJVMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:43:23 -0400
X-UUID: 08f86e02cd254d64bac71d3f10900b64-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=suctow7OnROATkYCQN1YTqk9AdATYyE1DHxLKwC/LTQ=;
        b=EZzCeaMFM9C4/SsoIK6ZpCQK3UviVrb8gTKqfRC4HmmSsgklUb0y//lh9IsiuzGtB+UkkExZ4vokbogCOh7I9gw0UdOhzRarFz61iXKxJmEdwSZHxbcbPlPvuPwcpkN+HQNeaqFKRfzMv4tJxi5f2nRYnQ5DjgF6OnrDTLFkrzE=;
X-UUID: 08f86e02cd254d64bac71d3f10900b64-20201022
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1955283088; Thu, 22 Oct 2020 20:37:56 +0800
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
Subject: [PATCH v4 22/34] clk: mediatek: Add MT8192 imp i2c wrapper s clock support
Date:   Thu, 22 Oct 2020 20:37:15 +0800
Message-ID: <1603370247-30437-23-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBpbXAgaTJjIHdyYXBwZXIgcyBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2Zm
LWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsv
bWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrDQogZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX3MuYyB8IDYxICsrKysrKysrKysr
KysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltcF9paWNfd3Jh
cF9zLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcgYi9kcml2
ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCBjOWQxNjdiLi5lMTZiOGIyIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9jbGsvbWVk
aWF0ZWsvS2NvbmZpZw0KQEAgLTUwOSw2ICs1MDksMTIgQEAgY29uZmlnIENPTU1PTl9DTEtfTVQ4
MTkyX0lNUF9JSUNfV1JBUF9ODQogCWhlbHANCiAJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBNZWRp
YVRlayBNVDgxOTIgaW1wX2lpY193cmFwX24gY2xvY2tzLg0KIA0KK2NvbmZpZyBDT01NT05fQ0xL
X01UODE5Ml9JTVBfSUlDX1dSQVBfUw0KKwlib29sICJDbG9jayBkcml2ZXIgZm9yIE1lZGlhVGVr
IE1UODE5MiBpbXBfaWljX3dyYXBfcyINCisJZGVwZW5kcyBvbiBDT01NT05fQ0xLX01UODE5Mg0K
KwloZWxwDQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGltcF9paWNf
d3JhcF9zIGNsb2Nrcy4NCisNCiBjb25maWcgQ09NTU9OX0NMS19NVDg1MTYNCiAJYm9vbCAiQ2xv
Y2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDg1MTYiDQogCWRlcGVuZHMgb24gQVJDSF9NRURJQVRF
SyB8fCBDT01QSUxFX1RFU1QNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtl
ZmlsZSBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQppbmRleCA5ZDRkMGE3Li43MTk1
MDVkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCisrKyBiL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQpAQCAtNzIsNSArNzIsNiBAQCBvYmotJChDT05G
SUdfQ09NTU9OX0NMS19NVDgxOTJfSU1HU1lTMikgKz0gY2xrLW10ODE5Mi1pbWcyLm8NCiBvYmot
JChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1QX0lJQ19XUkFQX0MpICs9IGNsay1tdDgxOTIt
aW1wX2lpY193cmFwX2Mubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JTVBfSUlD
X1dSQVBfRSkgKz0gY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBfZS5vDQogb2JqLSQoQ09ORklHX0NP
TU1PTl9DTEtfTVQ4MTkyX0lNUF9JSUNfV1JBUF9OKSArPSBjbGstbXQ4MTkyLWltcF9paWNfd3Jh
cF9uLm8NCitvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1QX0lJQ19XUkFQX1MpICs9
IGNsay1tdDgxOTItaW1wX2lpY193cmFwX3Mubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01U
ODUxNikgKz0gY2xrLW10ODUxNi5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2X0FV
RFNZUykgKz0gY2xrLW10ODUxNi1hdWQubw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlh
dGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX3MuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Ns
ay1tdDgxOTItaW1wX2lpY193cmFwX3MuYw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAw
MDAwMDAuLjFmOWM1YWQNCi0tLSAvZGV2L251bGwNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1tdDgxOTItaW1wX2lpY193cmFwX3MuYw0KQEAgLTAsMCArMSw2MSBAQA0KKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCisvLw0KKy8vIENvcHlyaWdodCAoYykg
MjAyMCBNZWRpYVRlayBJbmMuDQorLy8gQXV0aG9yOiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0
ZWsuY29tPg0KKw0KKyNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCisjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorDQorI2luY2x1ZGUgImNsay1tdGsuaCINCisjaW5j
bHVkZSAiY2xrLWdhdGUuaCINCisNCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTky
LWNsay5oPg0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVncyBpbXBfaWljX3dy
YXBfc19jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9IDB4ZTA4LA0KKwkuY2xyX29mcyA9IDB4ZTA0
LA0KKwkuc3RhX29mcyA9IDB4ZTAwLA0KK307DQorDQorI2RlZmluZSBHQVRFX0lNUF9JSUNfV1JB
UF9TKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9zaGlmdCkJCQlcDQorCUdBVEVfTVRLX0ZMQUdTKF9p
ZCwgX25hbWUsIF9wYXJlbnQsICZpbXBfaWljX3dyYXBfc19jZ19yZWdzLCBfc2hpZnQsCVwNCisJ
CSZtdGtfY2xrX2dhdGVfb3BzX3NldGNsciwgQ0xLX09QU19QQVJFTlRfRU5BQkxFKQ0KKw0KK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgaW1wX2lpY193cmFwX3NfY2xrc1tdID0gew0KKwlH
QVRFX0lNUF9JSUNfV1JBUF9TKENMS19JTVBfSUlDX1dSQVBfU19JMkM3LCAiaW1wX2lpY193cmFw
X3NfaTJjNyIsICJpbmZyYV9pMmMwIiwgMCksDQorCUdBVEVfSU1QX0lJQ19XUkFQX1MoQ0xLX0lN
UF9JSUNfV1JBUF9TX0kyQzgsICJpbXBfaWljX3dyYXBfc19pMmM4IiwgImluZnJhX2kyYzAiLCAx
KSwNCisJR0FURV9JTVBfSUlDX1dSQVBfUyhDTEtfSU1QX0lJQ19XUkFQX1NfSTJDOSwgImltcF9p
aWNfd3JhcF9zX2kyYzkiLCAiaW5mcmFfaTJjMCIsIDIpLA0KK307DQorDQorc3RhdGljIGludCBj
bGtfbXQ4MTkyX2ltcF9paWNfd3JhcF9zX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQorew0KKwlzdHJ1Y3QgY2xrX29uZWNlbGxfZGF0YSAqY2xrX2RhdGE7DQorCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KKwlpbnQgcjsNCisNCisJY2xr
X2RhdGEgPSBtdGtfYWxsb2NfY2xrX2RhdGEoQ0xLX0lNUF9JSUNfV1JBUF9TX05SX0NMSyk7DQor
CWlmICghY2xrX2RhdGEpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJciA9IG10a19jbGtfcmVn
aXN0ZXJfZ2F0ZXMobm9kZSwgaW1wX2lpY193cmFwX3NfY2xrcywgQVJSQVlfU0laRShpbXBfaWlj
X3dyYXBfc19jbGtzKSwNCisJCQljbGtfZGF0YSk7DQorCWlmIChyKQ0KKwkJcmV0dXJuIHI7DQor
DQorCXJldHVybiBvZl9jbGtfYWRkX3Byb3ZpZGVyKG5vZGUsIG9mX2Nsa19zcmNfb25lY2VsbF9n
ZXQsIGNsa19kYXRhKTsNCit9DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
b2ZfbWF0Y2hfY2xrX210ODE5Ml9pbXBfaWljX3dyYXBfc1tdID0gew0KKwl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfcyIsIH0sDQorCXt9DQorfTsNCisNCitz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBjbGtfbXQ4MTkyX2ltcF9paWNfd3JhcF9zX2Ry
diA9IHsNCisJLnByb2JlID0gY2xrX210ODE5Ml9pbXBfaWljX3dyYXBfc19wcm9iZSwNCisJLmRy
aXZlciA9IHsNCisJCS5uYW1lID0gImNsay1tdDgxOTItaW1wX2lpY193cmFwX3MiLA0KKwkJLm9m
X21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfY2xrX210ODE5Ml9pbXBfaWljX3dyYXBfcywNCisJfSwN
Cit9Ow0KKw0KK2J1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKGNsa19tdDgxOTJfaW1wX2lpY193cmFw
X3NfZHJ2KTsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

