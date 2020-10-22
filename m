Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9848C295E91
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898423AbgJVMiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:38:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33701 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898371AbgJVMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:38:18 -0400
X-UUID: cfd677bbec4c428a81e3bbca7655171e-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qSUcANkAhDa/we0e4fJU+cUCoF6peimefUK8ZGX7+SM=;
        b=scgzDBPOz1d2Ak3MGqT8G4R5GiKDfTnO8wb+7mTikYnGpGb2SzuwAQFtsuv3wu2aj81iwJQM1AjSIHrkIUGRizEBTt2dIbKrR9V9I2AzqDD3PtDzMzXynDOizl7ZenFNRkRqyS/sD+vq4pcKHmV97e8lhYWtfEpHWSSH/RDnEO4=;
X-UUID: cfd677bbec4c428a81e3bbca7655171e-20201022
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 220904012; Thu, 22 Oct 2020 20:37:56 +0800
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
Subject: [PATCH v4 21/34] clk: mediatek: Add MT8192 imp i2c wrapper n clock support
Date:   Thu, 22 Oct 2020 20:37:14 +0800
Message-ID: <1603370247-30437-22-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBpbXAgaTJjIHdyYXBwZXIgbiBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2Zm
LWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsv
bWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrDQogZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX24uYyB8IDYwICsrKysrKysrKysr
KysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltcF9paWNfd3Jh
cF9uLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcgYi9kcml2
ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCA1YzI5OGVlLi5jOWQxNjdiIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9jbGsvbWVk
aWF0ZWsvS2NvbmZpZw0KQEAgLTUwMyw2ICs1MDMsMTIgQEAgY29uZmlnIENPTU1PTl9DTEtfTVQ4
MTkyX0lNUF9JSUNfV1JBUF9FDQogCWhlbHANCiAJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBNZWRp
YVRlayBNVDgxOTIgaW1wX2lpY193cmFwX2UgY2xvY2tzLg0KIA0KK2NvbmZpZyBDT01NT05fQ0xL
X01UODE5Ml9JTVBfSUlDX1dSQVBfTg0KKwlib29sICJDbG9jayBkcml2ZXIgZm9yIE1lZGlhVGVr
IE1UODE5MiBpbXBfaWljX3dyYXBfbiINCisJZGVwZW5kcyBvbiBDT01NT05fQ0xLX01UODE5Mg0K
KwloZWxwDQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGltcF9paWNf
d3JhcF9uIGNsb2Nrcy4NCisNCiBjb25maWcgQ09NTU9OX0NMS19NVDg1MTYNCiAJYm9vbCAiQ2xv
Y2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDg1MTYiDQogCWRlcGVuZHMgb24gQVJDSF9NRURJQVRF
SyB8fCBDT01QSUxFX1RFU1QNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtl
ZmlsZSBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQppbmRleCAzYWFlNzVlLi45ZDRk
MGE3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCisrKyBiL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQpAQCAtNzEsNSArNzEsNiBAQCBvYmotJChDT05G
SUdfQ09NTU9OX0NMS19NVDgxOTJfSU1HU1lTKSArPSBjbGstbXQ4MTkyLWltZy5vDQogb2JqLSQo
Q09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0lNR1NZUzIpICs9IGNsay1tdDgxOTItaW1nMi5vDQog
b2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0lNUF9JSUNfV1JBUF9DKSArPSBjbGstbXQ4
MTkyLWltcF9paWNfd3JhcF9jLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1Q
X0lJQ19XUkFQX0UpICs9IGNsay1tdDgxOTItaW1wX2lpY193cmFwX2Uubw0KK29iai0kKENPTkZJ
R19DT01NT05fQ0xLX01UODE5Ml9JTVBfSUlDX1dSQVBfTikgKz0gY2xrLW10ODE5Mi1pbXBfaWlj
X3dyYXBfbi5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2KSArPSBjbGstbXQ4NTE2
Lm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTZfQVVEU1lTKSArPSBjbGstbXQ4NTE2
LWF1ZC5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbXBf
aWljX3dyYXBfbi5jIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbXBfaWljX3dy
YXBfbi5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uYmM1ZWNmYw0KLS0t
IC9kZXYvbnVsbA0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbXBfaWlj
X3dyYXBfbi5jDQpAQCAtMCwwICsxLDYwIEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb25seQ0KKy8vDQorLy8gQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4N
CisvLyBBdXRob3I6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQorDQorI2luY2x1
ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZp
Y2UuaD4NCisNCisjaW5jbHVkZSAiY2xrLW10ay5oIg0KKyNpbmNsdWRlICJjbGstZ2F0ZS5oIg0K
Kw0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQorDQorc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZV9yZWdzIGltcF9paWNfd3JhcF9uX2NnX3JlZ3MgPSB7DQor
CS5zZXRfb2ZzID0gMHhlMDgsDQorCS5jbHJfb2ZzID0gMHhlMDQsDQorCS5zdGFfb2ZzID0gMHhl
MDAsDQorfTsNCisNCisjZGVmaW5lIEdBVEVfSU1QX0lJQ19XUkFQX04oX2lkLCBfbmFtZSwgX3Bh
cmVudCwgX3NoaWZ0KQkJCVwNCisJR0FURV9NVEtfRkxBR1MoX2lkLCBfbmFtZSwgX3BhcmVudCwg
JmltcF9paWNfd3JhcF9uX2NnX3JlZ3MsIF9zaGlmdCwJXA0KKwkJJm10a19jbGtfZ2F0ZV9vcHNf
c2V0Y2xyLCBDTEtfT1BTX1BBUkVOVF9FTkFCTEUpDQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZ2F0ZSBpbXBfaWljX3dyYXBfbl9jbGtzW10gPSB7DQorCUdBVEVfSU1QX0lJQ19XUkFQX04o
Q0xLX0lNUF9JSUNfV1JBUF9OX0kyQzAsICJpbXBfaWljX3dyYXBfbl9pMmMwIiwgImluZnJhX2ky
YzAiLCAwKSwNCisJR0FURV9JTVBfSUlDX1dSQVBfTihDTEtfSU1QX0lJQ19XUkFQX05fSTJDNiwg
ImltcF9paWNfd3JhcF9uX2kyYzYiLCAiaW5mcmFfaTJjMCIsIDEpLA0KK307DQorDQorc3RhdGlj
IGludCBjbGtfbXQ4MTkyX2ltcF9paWNfd3JhcF9uX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQorew0KKwlzdHJ1Y3QgY2xrX29uZWNlbGxfZGF0YSAqY2xrX2RhdGE7DQorCXN0
cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KKwlpbnQgcjsNCisN
CisJY2xrX2RhdGEgPSBtdGtfYWxsb2NfY2xrX2RhdGEoQ0xLX0lNUF9JSUNfV1JBUF9OX05SX0NM
Syk7DQorCWlmICghY2xrX2RhdGEpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJciA9IG10a19j
bGtfcmVnaXN0ZXJfZ2F0ZXMobm9kZSwgaW1wX2lpY193cmFwX25fY2xrcywgQVJSQVlfU0laRShp
bXBfaWljX3dyYXBfbl9jbGtzKSwNCisJCQljbGtfZGF0YSk7DQorCWlmIChyKQ0KKwkJcmV0dXJu
IHI7DQorDQorCXJldHVybiBvZl9jbGtfYWRkX3Byb3ZpZGVyKG5vZGUsIG9mX2Nsa19zcmNfb25l
Y2VsbF9nZXQsIGNsa19kYXRhKTsNCit9DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgb2ZfbWF0Y2hfY2xrX210ODE5Ml9pbXBfaWljX3dyYXBfbltdID0gew0KKwl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfbiIsIH0sDQorCXt9DQorfTsN
CisNCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBjbGtfbXQ4MTkyX2ltcF9paWNfd3Jh
cF9uX2RydiA9IHsNCisJLnByb2JlID0gY2xrX210ODE5Ml9pbXBfaWljX3dyYXBfbl9wcm9iZSwN
CisJLmRyaXZlciA9IHsNCisJCS5uYW1lID0gImNsay1tdDgxOTItaW1wX2lpY193cmFwX24iLA0K
KwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfY2xrX210ODE5Ml9pbXBfaWljX3dyYXBfbiwN
CisJfSwNCit9Ow0KKw0KK2J1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKGNsa19tdDgxOTJfaW1wX2lp
Y193cmFwX25fZHJ2KTsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

