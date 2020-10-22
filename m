Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D0A295E94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898445AbgJVMjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:39:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33701 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898402AbgJVMih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:38:37 -0400
X-UUID: 80a41e5001c44377a63e54b82804e781-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Jha2F1QI7KSVraGo9Mnho2It6P0BwdjzTvDojZsu+f8=;
        b=IshULhF4GQQf3XpUDX7eGGJSwm3LRs5NAAS9Q55b0CvUaDwcJZYePKFHWxGRQvrx0dbF0pRML1v+45CdsiVAS5RdE5wevxQEh4ob/1G4HXqK0qyJWQgxAoPvnQrerAEtpEy2e1yHq1rpQAYjrJ+24roEm+U3ntl7AVQyXsv/zmw=;
X-UUID: 80a41e5001c44377a63e54b82804e781-20201022
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1064626375; Thu, 22 Oct 2020 20:37:56 +0800
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
Subject: [PATCH v4 23/34] clk: mediatek: Add MT8192 imp i2c wrapper w clock support
Date:   Thu, 22 Oct 2020 20:37:16 +0800
Message-ID: <1603370247-30437-24-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBpbXAgaTJjIHdyYXBwZXIgdyBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2Zm
LWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsv
bWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrDQogZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX3cuYyB8IDU5ICsrKysrKysrKysr
KysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltcF9paWNfd3Jh
cF93LmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcgYi9kcml2
ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCBlMTZiOGIyLi44YTlkOWY2IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9jbGsvbWVk
aWF0ZWsvS2NvbmZpZw0KQEAgLTUxNSw2ICs1MTUsMTIgQEAgY29uZmlnIENPTU1PTl9DTEtfTVQ4
MTkyX0lNUF9JSUNfV1JBUF9TDQogCWhlbHANCiAJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBNZWRp
YVRlayBNVDgxOTIgaW1wX2lpY193cmFwX3MgY2xvY2tzLg0KIA0KK2NvbmZpZyBDT01NT05fQ0xL
X01UODE5Ml9JTVBfSUlDX1dSQVBfVw0KKwlib29sICJDbG9jayBkcml2ZXIgZm9yIE1lZGlhVGVr
IE1UODE5MiBpbXBfaWljX3dyYXBfdyINCisJZGVwZW5kcyBvbiBDT01NT05fQ0xLX01UODE5Mg0K
KwloZWxwDQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGltcF9paWNf
d3JhcF93IGNsb2Nrcy4NCisNCiBjb25maWcgQ09NTU9OX0NMS19NVDg1MTYNCiAJYm9vbCAiQ2xv
Y2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDg1MTYiDQogCWRlcGVuZHMgb24gQVJDSF9NRURJQVRF
SyB8fCBDT01QSUxFX1RFU1QNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtl
ZmlsZSBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQppbmRleCA3MTk1MDVkLi4xZDM1
OThhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCisrKyBiL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQpAQCAtNzMsNSArNzMsNiBAQCBvYmotJChDT05G
SUdfQ09NTU9OX0NMS19NVDgxOTJfSU1QX0lJQ19XUkFQX0MpICs9IGNsay1tdDgxOTItaW1wX2lp
Y193cmFwX2Mubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JTVBfSUlDX1dSQVBf
RSkgKz0gY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBfZS5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9D
TEtfTVQ4MTkyX0lNUF9JSUNfV1JBUF9OKSArPSBjbGstbXQ4MTkyLWltcF9paWNfd3JhcF9uLm8N
CiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1QX0lJQ19XUkFQX1MpICs9IGNsay1t
dDgxOTItaW1wX2lpY193cmFwX3Mubw0KK29iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9J
TVBfSUlDX1dSQVBfVykgKz0gY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBfdy5vDQogb2JqLSQoQ09O
RklHX0NPTU1PTl9DTEtfTVQ4NTE2KSArPSBjbGstbXQ4NTE2Lm8NCiBvYmotJChDT05GSUdfQ09N
TU9OX0NMS19NVDg1MTZfQVVEU1lTKSArPSBjbGstbXQ4NTE2LWF1ZC5vDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBfdy5jIGIvZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBfdy5jDQpuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uN2UxMjVlYw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbXBfaWljX3dyYXBfdy5jDQpAQCAtMCwwICsx
LDU5IEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KKy8vDQor
Ly8gQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4NCisvLyBBdXRob3I6IFdlaXlpIEx1
IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQorDQorI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRl
ci5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisNCisjaW5jbHVkZSAi
Y2xrLW10ay5oIg0KKyNpbmNsdWRlICJjbGstZ2F0ZS5oIg0KKw0KKyNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0
ZV9yZWdzIGltcF9paWNfd3JhcF93X2NnX3JlZ3MgPSB7DQorCS5zZXRfb2ZzID0gMHhlMDgsDQor
CS5jbHJfb2ZzID0gMHhlMDQsDQorCS5zdGFfb2ZzID0gMHhlMDAsDQorfTsNCisNCisjZGVmaW5l
IEdBVEVfSU1QX0lJQ19XUkFQX1coX2lkLCBfbmFtZSwgX3BhcmVudCwgX3NoaWZ0KQkJCVwNCisJ
R0FURV9NVEtfRkxBR1MoX2lkLCBfbmFtZSwgX3BhcmVudCwgJmltcF9paWNfd3JhcF93X2NnX3Jl
Z3MsIF9zaGlmdCwJXA0KKwkJJm10a19jbGtfZ2F0ZV9vcHNfc2V0Y2xyLCBDTEtfT1BTX1BBUkVO
VF9FTkFCTEUpDQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBpbXBfaWljX3dyYXBf
d19jbGtzW10gPSB7DQorCUdBVEVfSU1QX0lJQ19XUkFQX1coQ0xLX0lNUF9JSUNfV1JBUF9XX0ky
QzUsICJpbXBfaWljX3dyYXBfd19pMmM1IiwgImluZnJhX2kyYzAiLCAwKSwNCit9Ow0KKw0KK3N0
YXRpYyBpbnQgY2xrX210ODE5Ml9pbXBfaWljX3dyYXBfd19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KK3sNCisJc3RydWN0IGNsa19vbmVjZWxsX2RhdGEgKmNsa19kYXRhOw0K
KwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCisJaW50IHI7
DQorDQorCWNsa19kYXRhID0gbXRrX2FsbG9jX2Nsa19kYXRhKENMS19JTVBfSUlDX1dSQVBfV19O
Ul9DTEspOw0KKwlpZiAoIWNsa19kYXRhKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCXIgPSBt
dGtfY2xrX3JlZ2lzdGVyX2dhdGVzKG5vZGUsIGltcF9paWNfd3JhcF93X2Nsa3MsIEFSUkFZX1NJ
WkUoaW1wX2lpY193cmFwX3dfY2xrcyksDQorCQkJY2xrX2RhdGEpOw0KKwlpZiAocikNCisJCXJl
dHVybiByOw0KKw0KKwlyZXR1cm4gb2ZfY2xrX2FkZF9wcm92aWRlcihub2RlLCBvZl9jbGtfc3Jj
X29uZWNlbGxfZ2V0LCBjbGtfZGF0YSk7DQorfQ0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIG9mX21hdGNoX2Nsa19tdDgxOTJfaW1wX2lpY193cmFwX3dbXSA9IHsNCisJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItaW1wX2lpY193cmFwX3ciLCB9LA0KKwl7fQ0K
K307DQorDQorc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgY2xrX210ODE5Ml9pbXBfaWlj
X3dyYXBfd19kcnYgPSB7DQorCS5wcm9iZSA9IGNsa19tdDgxOTJfaW1wX2lpY193cmFwX3dfcHJv
YmUsDQorCS5kcml2ZXIgPSB7DQorCQkubmFtZSA9ICJjbGstbXQ4MTkyLWltcF9paWNfd3JhcF93
IiwNCisJCS5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX2Nsa19tdDgxOTJfaW1wX2lpY193cmFw
X3csDQorCX0sDQorfTsNCisNCitidWlsdGluX3BsYXRmb3JtX2RyaXZlcihjbGtfbXQ4MTkyX2lt
cF9paWNfd3JhcF93X2Rydik7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

