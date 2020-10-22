Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E69295EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898699AbgJVMnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:43:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44187 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2506264AbgJVMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:43:34 -0400
X-UUID: 20c367e7615b4fe39430ebc0420fb5fc-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZMPcWi0+CUwGocrX5m4/D3sGTbKA+NU7kJfSH85Yv6w=;
        b=ZFsiy4K4/9hCaqHyIi7B5pR82yUhQjpahX4AHmqO3uyWAty4AdV6bGbDVxT5Uy1vPOIz7VF6mOrokRnncB3IvQqNDL5xHAxqAH+pUiSb0RcYEDaZ0SS032QnSpFrJ2Ji7FY0oDAQjjp1NWxvTKKfDgzgi6xPXlobWNS6GR/ooQs=;
X-UUID: 20c367e7615b4fe39430ebc0420fb5fc-20201022
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1647622374; Thu, 22 Oct 2020 20:37:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:53 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 18/34] clk: mediatek: Add MT8192 imgsys2 clock support
Date:   Thu, 22 Oct 2020 20:37:11 +0800
Message-ID: <1603370247-30437-19-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBpbWdzeXMyIGNsb2NrIHByb3ZpZGVyDQoNClNpZ25lZC1vZmYtYnk6IFdlaXlp
IEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9L
Y29uZmlnICAgICAgICAgICB8ICA2ICsrKysNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmls
ZSAgICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltZzIu
YyB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5n
ZWQsIDY5IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVk
aWF0ZWsvY2xrLW10ODE5Mi1pbWcyLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlh
dGVrL0tjb25maWcgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCBhZmQwMjhi
Li45OWIwMTY4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysr
IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KQEAgLTQ4NSw2ICs0ODUsMTIgQEAgY29u
ZmlnIENPTU1PTl9DTEtfTVQ4MTkyX0lNR1NZUw0KIAloZWxwDQogCSAgVGhpcyBkcml2ZXIgc3Vw
cG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGltZ3N5cyBjbG9ja3MuDQogDQorY29uZmlnIENPTU1PTl9D
TEtfTVQ4MTkyX0lNR1NZUzINCisJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDgx
OTIgaW1nc3lzMiINCisJZGVwZW5kcyBvbiBDT01NT05fQ0xLX01UODE5Mg0KKwloZWxwDQorCSAg
VGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGltZ3N5czIgY2xvY2tzLg0KKw0K
IGNvbmZpZyBDT01NT05fQ0xLX01UODUxNg0KIAlib29sICJDbG9jayBkcml2ZXIgZm9yIE1lZGlh
VGVrIE1UODUxNiINCiAJZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENPTVBJTEVfVEVTVA0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlIGIvZHJpdmVycy9jbGsv
bWVkaWF0ZWsvTWFrZWZpbGUNCmluZGV4IDFmODdiZWMuLjAxMmEwMWEgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
TWFrZWZpbGUNCkBAIC02OCw1ICs2OCw2IEBAIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5
Ml9DQU1TWVNfUkFXQSkgKz0gY2xrLW10ODE5Mi1jYW1fcmF3YS5vDQogb2JqLSQoQ09ORklHX0NP
TU1PTl9DTEtfTVQ4MTkyX0NBTVNZU19SQVdCKSArPSBjbGstbXQ4MTkyLWNhbV9yYXdiLm8NCiBv
YmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfQ0FNU1lTX1JBV0MpICs9IGNsay1tdDgxOTIt
Y2FtX3Jhd2Mubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JTUdTWVMpICs9IGNs
ay1tdDgxOTItaW1nLm8NCitvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1HU1lTMikg
Kz0gY2xrLW10ODE5Mi1pbWcyLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTYpICs9
IGNsay1tdDg1MTYubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODUxNl9BVURTWVMpICs9
IGNsay1tdDg1MTYtYXVkLm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGst
bXQ4MTkyLWltZzIuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1nMi5jDQpu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uNzZmOWUzMg0KLS0tIC9kZXYvbnVs
bA0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbWcyLmMNCkBAIC0wLDAg
KzEsNjIgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQorLy8N
CisvLyBDb3B5cmlnaHQgKGMpIDIwMjAgTWVkaWFUZWsgSW5jLg0KKy8vIEF1dGhvcjogV2VpeWkg
THUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCisNCisjaW5jbHVkZSA8bGludXgvY2xrLXByb3Zp
ZGVyLmg+DQorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKw0KKyNpbmNsdWRl
ICJjbGstbXRrLmgiDQorI2luY2x1ZGUgImNsay1nYXRlLmgiDQorDQorI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL2Nsb2NrL210ODE5Mi1jbGsuaD4NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19n
YXRlX3JlZ3MgaW1nMl9jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9IDB4NCwNCisJLmNscl9vZnMg
PSAweDgsDQorCS5zdGFfb2ZzID0gMHgwLA0KK307DQorDQorI2RlZmluZSBHQVRFX0lNRzIoX2lk
LCBfbmFtZSwgX3BhcmVudCwgX3NoaWZ0KQlcDQorCUdBVEVfTVRLKF9pZCwgX25hbWUsIF9wYXJl
bnQsICZpbWcyX2NnX3JlZ3MsIF9zaGlmdCwgJm10a19jbGtfZ2F0ZV9vcHNfc2V0Y2xyKQ0KKw0K
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgaW1nMl9jbGtzW10gPSB7DQorCUdBVEVfSU1H
MihDTEtfSU1HMl9MQVJCMTEsICJpbWcyX2xhcmIxMSIsICJpbWcxX3NlbCIsIDApLA0KKwlHQVRF
X0lNRzIoQ0xLX0lNRzJfTEFSQjEyLCAiaW1nMl9sYXJiMTIiLCAiaW1nMV9zZWwiLCAxKSwNCisJ
R0FURV9JTUcyKENMS19JTUcyX01GQiwgImltZzJfbWZiIiwgImltZzFfc2VsIiwgNiksDQorCUdB
VEVfSU1HMihDTEtfSU1HMl9XUEUsICJpbWcyX3dwZSIsICJpbWcxX3NlbCIsIDcpLA0KKwlHQVRF
X0lNRzIoQ0xLX0lNRzJfTVNTLCAiaW1nMl9tc3MiLCAiaW1nMV9zZWwiLCA4KSwNCisJR0FURV9J
TUcyKENMS19JTUcyX0dBTFMsICJpbWcyX2dhbHMiLCAiaW1nMV9zZWwiLCAxMiksDQorfTsNCisN
CitzdGF0aWMgaW50IGNsa19tdDgxOTJfaW1nMl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KK3sNCisJc3RydWN0IGNsa19vbmVjZWxsX2RhdGEgKmNsa19kYXRhOw0KKwlzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCisJaW50IHI7DQorDQor
CWNsa19kYXRhID0gbXRrX2FsbG9jX2Nsa19kYXRhKENMS19JTUcyX05SX0NMSyk7DQorCWlmICgh
Y2xrX2RhdGEpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJciA9IG10a19jbGtfcmVnaXN0ZXJf
Z2F0ZXMobm9kZSwgaW1nMl9jbGtzLCBBUlJBWV9TSVpFKGltZzJfY2xrcyksIGNsa19kYXRhKTsN
CisJaWYgKHIpDQorCQlyZXR1cm4gcjsNCisNCisJcmV0dXJuIG9mX2Nsa19hZGRfcHJvdmlkZXIo
bm9kZSwgb2ZfY2xrX3NyY19vbmVjZWxsX2dldCwgY2xrX2RhdGEpOw0KK30NCisNCitzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTkyX2ltZzJbXSA9IHsN
CisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItaW1nc3lzMiIsIH0sDQorCXt9DQor
fTsNCisNCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBjbGtfbXQ4MTkyX2ltZzJfZHJ2
ID0gew0KKwkucHJvYmUgPSBjbGtfbXQ4MTkyX2ltZzJfcHJvYmUsDQorCS5kcml2ZXIgPSB7DQor
CQkubmFtZSA9ICJjbGstbXQ4MTkyLWltZzIiLA0KKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0
Y2hfY2xrX210ODE5Ml9pbWcyLA0KKwl9LA0KK307DQorDQorYnVpbHRpbl9wbGF0Zm9ybV9kcml2
ZXIoY2xrX210ODE5Ml9pbWcyX2Rydik7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

