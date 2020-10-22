Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B080295E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898400AbgJVMif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:38:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33670 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898356AbgJVMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:38:14 -0400
X-UUID: da3952ba47c74c5baac2d57773f972bb-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UvmuHyXMIzk6YC53NsSnOcfDqYgzE3L3Z4nQ/Gc4Pdg=;
        b=XeDmU3bopaO6q3bq4MGBvTGTA14Yr445E3kXRhbDw+NnviDRlu1PsJ3kqwFefiT/HPIXSaFdrX2Acc3hfR+3RzfX/VZnRrz6LvRi9UZw1/d/1HvLgwm+Xn0qBPjNneCTVMTnO6J2uOl3w0sGvt/pNo1vOtBVMSccNZoPCdeNSNk=;
X-UUID: da3952ba47c74c5baac2d57773f972bb-20201022
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1018281805; Thu, 22 Oct 2020 20:37:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:56 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 30/34] clk: mediatek: Add MT8192 msdc clock support
Date:   Thu, 22 Oct 2020 20:37:23 +0800
Message-ID: <1603370247-30437-31-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBtc2RjIGNsb2NrIHByb3ZpZGVyDQoNClNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1
IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9LY29u
ZmlnICAgICAgICAgICB8ICA2ICsrKysNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZSAg
ICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLW1zZGMuYyB8
IDU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQs
IDY0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10ODE5Mi1tc2RjLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L0tjb25maWcgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCAwMWE3NmFlLi40
YjhjYWU2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysrIGIv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KQEAgLTU1Nyw2ICs1NTcsMTIgQEAgY29uZmln
IENPTU1PTl9DTEtfTVQ4MTkyX01TRENfVE9QDQogCWhlbHANCiAJICBUaGlzIGRyaXZlciBzdXBw
b3J0cyBNZWRpYVRlayBNVDgxOTIgbXNkY190b3AgY2xvY2tzLg0KIA0KK2NvbmZpZyBDT01NT05f
Q0xLX01UODE5Ml9NU0RDDQorCWJvb2wgIkNsb2NrIGRyaXZlciBmb3IgTWVkaWFUZWsgTVQ4MTky
IG1zZGMiDQorCWRlcGVuZHMgb24gQ09NTU9OX0NMS19NVDgxOTINCisJaGVscA0KKwkgIFRoaXMg
ZHJpdmVyIHN1cHBvcnRzIE1lZGlhVGVrIE1UODE5MiBtc2RjIGNsb2Nrcy4NCisNCiBjb25maWcg
Q09NTU9OX0NMS19NVDg1MTYNCiAJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDg1
MTYiDQogCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL21lZGlhdGVr
L01ha2VmaWxlDQppbmRleCA0YTMwMjY5Li4zMWUxMzRiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxl
DQpAQCAtODAsNSArODAsNiBAQCBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfTURQU1lT
KSArPSBjbGstbXQ4MTkyLW1kcC5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX01G
R0NGRykgKz0gY2xrLW10ODE5Mi1tZmcubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5
Ml9NTVNZUykgKz0gY2xrLW10ODE5Mi1tbS5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4
MTkyX01TRENfVE9QKSArPSBjbGstbXQ4MTkyLW1zZGNfdG9wLm8NCitvYmotJChDT05GSUdfQ09N
TU9OX0NMS19NVDgxOTJfTVNEQykgKz0gY2xrLW10ODE5Mi1tc2RjLm8NCiBvYmotJChDT05GSUdf
Q09NTU9OX0NMS19NVDg1MTYpICs9IGNsay1tdDg1MTYubw0KIG9iai0kKENPTkZJR19DT01NT05f
Q0xLX01UODUxNl9BVURTWVMpICs9IGNsay1tdDg1MTYtYXVkLm8NCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLW1zZGMuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1tdDgxOTItbXNkYy5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4u
OWQyYjE2OA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10
ODE5Mi1tc2RjLmMNCkBAIC0wLDAgKzEsNTcgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vbmx5DQorLy8NCisvLyBDb3B5cmlnaHQgKGMpIDIwMjAgTWVkaWFUZWsgSW5j
Lg0KKy8vIEF1dGhvcjogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCisNCisjaW5j
bHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rl
dmljZS5oPg0KKw0KKyNpbmNsdWRlICJjbGstbXRrLmgiDQorI2luY2x1ZGUgImNsay1nYXRlLmgi
DQorDQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210ODE5Mi1jbGsuaD4NCisNCitzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19nYXRlX3JlZ3MgbXNkY19jZ19yZWdzID0gew0KKwkuc2V0X29m
cyA9IDB4YjQsDQorCS5jbHJfb2ZzID0gMHhiNCwNCisJLnN0YV9vZnMgPSAweGI0LA0KK307DQor
DQorI2RlZmluZSBHQVRFX01TREMoX2lkLCBfbmFtZSwgX3BhcmVudCwgX3NoaWZ0KQlcDQorCUdB
VEVfTVRLKF9pZCwgX25hbWUsIF9wYXJlbnQsICZtc2RjX2NnX3JlZ3MsIF9zaGlmdCwgJm10a19j
bGtfZ2F0ZV9vcHNfbm9fc2V0Y2xyX2ludikNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19n
YXRlIG1zZGNfY2xrc1tdID0gew0KKwlHQVRFX01TREMoQ0xLX01TRENfQVhJX1dSQVAsICJtc2Rj
X2F4aV93cmFwIiwgImF4aV9zZWwiLCAyMiksDQorfTsNCisNCitzdGF0aWMgaW50IGNsa19tdDgx
OTJfbXNkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KK3sNCisJc3RydWN0
IGNsa19vbmVjZWxsX2RhdGEgKmNsa19kYXRhOw0KKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUg
PSBwZGV2LT5kZXYub2Zfbm9kZTsNCisJaW50IHI7DQorDQorCWNsa19kYXRhID0gbXRrX2FsbG9j
X2Nsa19kYXRhKENMS19NU0RDX05SX0NMSyk7DQorCWlmICghY2xrX2RhdGEpDQorCQlyZXR1cm4g
LUVOT01FTTsNCisNCisJciA9IG10a19jbGtfcmVnaXN0ZXJfZ2F0ZXMobm9kZSwgbXNkY19jbGtz
LCBBUlJBWV9TSVpFKG1zZGNfY2xrcyksIGNsa19kYXRhKTsNCisJaWYgKHIpDQorCQlyZXR1cm4g
cjsNCisNCisJcmV0dXJuIG9mX2Nsa19hZGRfcHJvdmlkZXIobm9kZSwgb2ZfY2xrX3NyY19vbmVj
ZWxsX2dldCwgY2xrX2RhdGEpOw0KK30NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTkyX21zZGNbXSA9IHsNCisJeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxOTItbXNkYyIsIH0sDQorCXt9DQorfTsNCisNCitzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBjbGtfbXQ4MTkyX21zZGNfZHJ2ID0gew0KKwkucHJvYmUgPSBjbGtfbXQ4
MTkyX21zZGNfcHJvYmUsDQorCS5kcml2ZXIgPSB7DQorCQkubmFtZSA9ICJjbGstbXQ4MTkyLW1z
ZGMiLA0KKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfY2xrX210ODE5Ml9tc2RjLA0KKwl9
LA0KK307DQorDQorYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIoY2xrX210ODE5Ml9tc2RjX2Rydik7
DQotLSANCjEuOC4xLjEuZGlydHkNCg==

