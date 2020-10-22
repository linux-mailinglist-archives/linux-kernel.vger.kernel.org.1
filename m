Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CFC295EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898457AbgJVMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:39:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33701 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898380AbgJVMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:38:24 -0400
X-UUID: d4a881c48cb34228aeb4ec197787a272-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Rd/rgu71cjk7BJg3fJ7fmfL9SL7aLAs1L3NOIrXhYCY=;
        b=ohlgz9mzruJr4w4xNIoIGEWOnp3icxIpp18/FG/zfPlM8oSnuDQg3kjAK8ZpYFM0ejE6x5kDeXuQGCPgFKK0oqA/vgRNy7rT+6CltN4KF0P/P2eFFAwbpjMlAb4xzGOABdiTc+a6nYJegmw0Sutc/6O1V3yGJDJk7Jaw7cTk4z0=;
X-UUID: d4a881c48cb34228aeb4ec197787a272-20201022
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 733902154; Thu, 22 Oct 2020 20:37:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v4 25/34] clk: mediatek: Add MT8192 ipesys clock support
Date:   Thu, 22 Oct 2020 20:37:18 +0800
Message-ID: <1603370247-30437-26-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBpcGVzeXMgY2xvY2sgcHJvdmlkZXINCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkg
THUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL0tj
b25maWcgICAgICAgICAgfCAgNiArKysrDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUg
ICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWlwZS5jIHwg
NjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQs
IDcxIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10ODE5Mi1pcGUuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
S2NvbmZpZyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCmluZGV4IDAzN2Y3NGYyLi5k
Zjc1YTA5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysrIGIv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KQEAgLTUyNyw2ICs1MjcsMTIgQEAgY29uZmln
IENPTU1PTl9DTEtfTVQ4MTkyX0lNUF9JSUNfV1JBUF9XUw0KIAloZWxwDQogCSAgVGhpcyBkcml2
ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGltcF9paWNfd3JhcF93cyBjbG9ja3MuDQogDQor
Y29uZmlnIENPTU1PTl9DTEtfTVQ4MTkyX0lQRVNZUw0KKwlib29sICJDbG9jayBkcml2ZXIgZm9y
IE1lZGlhVGVrIE1UODE5MiBpcGVzeXMiDQorCWRlcGVuZHMgb24gQ09NTU9OX0NMS19NVDgxOTIN
CisJaGVscA0KKwkgIFRoaXMgZHJpdmVyIHN1cHBvcnRzIE1lZGlhVGVrIE1UODE5MiBpcGVzeXMg
Y2xvY2tzLg0KKw0KIGNvbmZpZyBDT01NT05fQ0xLX01UODUxNg0KIAlib29sICJDbG9jayBkcml2
ZXIgZm9yIE1lZGlhVGVrIE1UODUxNiINCiAJZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENP
TVBJTEVfVEVTVA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlIGIv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCmluZGV4IDRmYWE5YWQuLjVmZTIxZjkgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KKysrIGIvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUNCkBAIC03NSw1ICs3NSw2IEBAIG9iai0kKENPTkZJR19DT01N
T05fQ0xLX01UODE5Ml9JTVBfSUlDX1dSQVBfTikgKz0gY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBf
bi5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0lNUF9JSUNfV1JBUF9TKSArPSBj
bGstbXQ4MTkyLWltcF9paWNfd3JhcF9zLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgx
OTJfSU1QX0lJQ19XUkFQX1cpICs9IGNsay1tdDgxOTItaW1wX2lpY193cmFwX3cubw0KIG9iai0k
KENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JTVBfSUlDX1dSQVBfV1MpICs9IGNsay1tdDgxOTIt
aW1wX2lpY193cmFwX3dzLm8NCitvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSVBFU1lT
KSArPSBjbGstbXQ4MTkyLWlwZS5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2KSAr
PSBjbGstbXQ4NTE2Lm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTZfQVVEU1lTKSAr
PSBjbGstbXQ4NTE2LWF1ZC5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LW10ODE5Mi1pcGUuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaXBlLmMNCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi4zMDRkY2E0DQotLS0gL2Rldi9udWxs
DQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWlwZS5jDQpAQCAtMCwwICsx
LDY0IEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KKy8vDQor
Ly8gQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4NCisvLyBBdXRob3I6IFdlaXlpIEx1
IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQorDQorI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRl
ci5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisNCisjaW5jbHVkZSAi
Y2xrLW10ay5oIg0KKyNpbmNsdWRlICJjbGstZ2F0ZS5oIg0KKw0KKyNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0
ZV9yZWdzIGlwZV9jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9IDB4NCwNCisJLmNscl9vZnMgPSAw
eDgsDQorCS5zdGFfb2ZzID0gMHgwLA0KK307DQorDQorI2RlZmluZSBHQVRFX0lQRShfaWQsIF9u
YW1lLCBfcGFyZW50LCBfc2hpZnQpCVwNCisJR0FURV9NVEsoX2lkLCBfbmFtZSwgX3BhcmVudCwg
JmlwZV9jZ19yZWdzLCBfc2hpZnQsICZtdGtfY2xrX2dhdGVfb3BzX3NldGNscikNCisNCitzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19nYXRlIGlwZV9jbGtzW10gPSB7DQorCUdBVEVfSVBFKENMS19J
UEVfTEFSQjE5LCAiaXBlX2xhcmIxOSIsICJpcGVfc2VsIiwgMCksDQorCUdBVEVfSVBFKENMS19J
UEVfTEFSQjIwLCAiaXBlX2xhcmIyMCIsICJpcGVfc2VsIiwgMSksDQorCUdBVEVfSVBFKENMS19J
UEVfU01JX1NVQkNPTSwgImlwZV9zbWlfc3ViY29tIiwgImlwZV9zZWwiLCAyKSwNCisJR0FURV9J
UEUoQ0xLX0lQRV9GRCwgImlwZV9mZCIsICJpcGVfc2VsIiwgMyksDQorCUdBVEVfSVBFKENMS19J
UEVfRkUsICJpcGVfZmUiLCAiaXBlX3NlbCIsIDQpLA0KKwlHQVRFX0lQRShDTEtfSVBFX1JTQywg
ImlwZV9yc2MiLCAiaXBlX3NlbCIsIDUpLA0KKwlHQVRFX0lQRShDTEtfSVBFX0RQRSwgImlwZV9k
cGUiLCAiaXBlX3NlbCIsIDYpLA0KKwlHQVRFX0lQRShDTEtfSVBFX0dBTFMsICJpcGVfZ2FscyIs
ICJpcGVfc2VsIiwgOCksDQorfTsNCisNCitzdGF0aWMgaW50IGNsa19tdDgxOTJfaXBlX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQorew0KKwlzdHJ1Y3QgY2xrX29uZWNlbGxf
ZGF0YSAqY2xrX2RhdGE7DQorCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IHBkZXYtPmRldi5v
Zl9ub2RlOw0KKwlpbnQgcjsNCisNCisJY2xrX2RhdGEgPSBtdGtfYWxsb2NfY2xrX2RhdGEoQ0xL
X0lQRV9OUl9DTEspOw0KKwlpZiAoIWNsa19kYXRhKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQor
CXIgPSBtdGtfY2xrX3JlZ2lzdGVyX2dhdGVzKG5vZGUsIGlwZV9jbGtzLCBBUlJBWV9TSVpFKGlw
ZV9jbGtzKSwgY2xrX2RhdGEpOw0KKwlpZiAocikNCisJCXJldHVybiByOw0KKw0KKwlyZXR1cm4g
b2ZfY2xrX2FkZF9wcm92aWRlcihub2RlLCBvZl9jbGtfc3JjX29uZWNlbGxfZ2V0LCBjbGtfZGF0
YSk7DQorfQ0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG9mX21hdGNoX2Ns
a19tdDgxOTJfaXBlW10gPSB7DQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWlw
ZXN5cyIsIH0sDQorCXt9DQorfTsNCisNCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBj
bGtfbXQ4MTkyX2lwZV9kcnYgPSB7DQorCS5wcm9iZSA9IGNsa19tdDgxOTJfaXBlX3Byb2JlLA0K
KwkuZHJpdmVyID0gew0KKwkJLm5hbWUgPSAiY2xrLW10ODE5Mi1pcGUiLA0KKwkJLm9mX21hdGNo
X3RhYmxlID0gb2ZfbWF0Y2hfY2xrX210ODE5Ml9pcGUsDQorCX0sDQorfTsNCisNCitidWlsdGlu
X3BsYXRmb3JtX2RyaXZlcihjbGtfbXQ4MTkyX2lwZV9kcnYpOw0KLS0gDQoxLjguMS4xLmRpcnR5
DQo=

