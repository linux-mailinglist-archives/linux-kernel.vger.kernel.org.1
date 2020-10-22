Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90427295E95
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898462AbgJVMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:39:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33670 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898396AbgJVMid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:38:33 -0400
X-UUID: 7af3a97575e44bf9886dba8bd02d6f94-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vPhNG+HyyTcfkCD5hPQ1WNKP0Kj3+DkOb2QHAyPFxaU=;
        b=Lg05ChVG1hjo+5sseD3LdtZCscuaB1BKuDApvog6ks8Ls6J8bDDBmbRzckKEkdK5fT2aq4Q2Nfw5ft3aANI5B2ATyKH0Pbc6wfcoAdaiMmjvG0Z0LfREMbZBE25QisxnfaAf3IeeQ9eNdx5kly3zXypcz4P3J/pu9Jbn8ho8jYE=;
X-UUID: 7af3a97575e44bf9886dba8bd02d6f94-20201022
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 222321369; Thu, 22 Oct 2020 20:37:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:54 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 19/34] clk: mediatek: Add MT8192 imp i2c wrapper c clock support
Date:   Thu, 22 Oct 2020 20:37:12 +0800
Message-ID: <1603370247-30437-20-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBpbXAgaTJjIHdyYXBwZXIgYyBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2Zm
LWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsv
bWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrDQogZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX2MuYyB8IDYyICsrKysrKysrKysr
KysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltcF9paWNfd3Jh
cF9jLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcgYi9kcml2
ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCA5OWIwMTY4Li5hMGViNzZkIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9jbGsvbWVk
aWF0ZWsvS2NvbmZpZw0KQEAgLTQ5MSw2ICs0OTEsMTIgQEAgY29uZmlnIENPTU1PTl9DTEtfTVQ4
MTkyX0lNR1NZUzINCiAJaGVscA0KIAkgIFRoaXMgZHJpdmVyIHN1cHBvcnRzIE1lZGlhVGVrIE1U
ODE5MiBpbWdzeXMyIGNsb2Nrcy4NCiANCitjb25maWcgQ09NTU9OX0NMS19NVDgxOTJfSU1QX0lJ
Q19XUkFQX0MNCisJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDgxOTIgaW1wX2lp
Y193cmFwX2MiDQorCWRlcGVuZHMgb24gQ09NTU9OX0NMS19NVDgxOTINCisJaGVscA0KKwkgIFRo
aXMgZHJpdmVyIHN1cHBvcnRzIE1lZGlhVGVrIE1UODE5MiBpbXBfaWljX3dyYXBfYyBjbG9ja3Mu
DQorDQogY29uZmlnIENPTU1PTl9DTEtfTVQ4NTE2DQogCWJvb2wgIkNsb2NrIGRyaXZlciBmb3Ig
TWVkaWFUZWsgTVQ4NTE2Ig0KIAlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9U
RVNUDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUgYi9kcml2ZXJz
L2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KaW5kZXggMDEyYTAxYS4uOGFhYzgyMSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQorKysgYi9kcml2ZXJzL2Nsay9tZWRp
YXRlay9NYWtlZmlsZQ0KQEAgLTY5LDUgKzY5LDYgQEAgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtf
TVQ4MTkyX0NBTVNZU19SQVdCKSArPSBjbGstbXQ4MTkyLWNhbV9yYXdiLm8NCiBvYmotJChDT05G
SUdfQ09NTU9OX0NMS19NVDgxOTJfQ0FNU1lTX1JBV0MpICs9IGNsay1tdDgxOTItY2FtX3Jhd2Mu
bw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JTUdTWVMpICs9IGNsay1tdDgxOTIt
aW1nLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1HU1lTMikgKz0gY2xrLW10
ODE5Mi1pbWcyLm8NCitvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1QX0lJQ19XUkFQ
X0MpICs9IGNsay1tdDgxOTItaW1wX2lpY193cmFwX2Mubw0KIG9iai0kKENPTkZJR19DT01NT05f
Q0xLX01UODUxNikgKz0gY2xrLW10ODUxNi5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4
NTE2X0FVRFNZUykgKz0gY2xrLW10ODUxNi1hdWQubw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX2MuYyBiL2RyaXZlcnMvY2xrL21lZGlh
dGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX2MuYw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmlu
ZGV4IDAwMDAwMDAuLmU3YTAwMzMNCi0tLSAvZGV2L251bGwNCisrKyBiL2RyaXZlcnMvY2xrL21l
ZGlhdGVrL2Nsay1tdDgxOTItaW1wX2lpY193cmFwX2MuYw0KQEAgLTAsMCArMSw2MiBAQA0KKy8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCisvLw0KKy8vIENvcHlyaWdo
dCAoYykgMjAyMCBNZWRpYVRlayBJbmMuDQorLy8gQXV0aG9yOiBXZWl5aSBMdSA8d2VpeWkubHVA
bWVkaWF0ZWsuY29tPg0KKw0KKyNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCisjaW5j
bHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorDQorI2luY2x1ZGUgImNsay1tdGsuaCIN
CisjaW5jbHVkZSAiY2xrLWdhdGUuaCINCisNCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2sv
bXQ4MTkyLWNsay5oPg0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVncyBpbXBf
aWljX3dyYXBfY19jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9IDB4ZTA4LA0KKwkuY2xyX29mcyA9
IDB4ZTA0LA0KKwkuc3RhX29mcyA9IDB4ZTAwLA0KK307DQorDQorI2RlZmluZSBHQVRFX0lNUF9J
SUNfV1JBUF9DKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9zaGlmdCkJCQlcDQorCUdBVEVfTVRLX0ZM
QUdTKF9pZCwgX25hbWUsIF9wYXJlbnQsICZpbXBfaWljX3dyYXBfY19jZ19yZWdzLCBfc2hpZnQs
CVwNCisJCSZtdGtfY2xrX2dhdGVfb3BzX3NldGNsciwgQ0xLX09QU19QQVJFTlRfRU5BQkxFKQ0K
Kw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgaW1wX2lpY193cmFwX2NfY2xrc1tdID0g
ew0KKwlHQVRFX0lNUF9JSUNfV1JBUF9DKENMS19JTVBfSUlDX1dSQVBfQ19JMkMxMCwgImltcF9p
aWNfd3JhcF9jX2kyYzEwIiwgImluZnJhX2kyYzAiLCAwKSwNCisJR0FURV9JTVBfSUlDX1dSQVBf
QyhDTEtfSU1QX0lJQ19XUkFQX0NfSTJDMTEsICJpbXBfaWljX3dyYXBfY19pMmMxMSIsICJpbmZy
YV9pMmMwIiwgMSksDQorCUdBVEVfSU1QX0lJQ19XUkFQX0MoQ0xLX0lNUF9JSUNfV1JBUF9DX0ky
QzEyLCAiaW1wX2lpY193cmFwX2NfaTJjMTIiLCAiaW5mcmFfaTJjMCIsIDIpLA0KKwlHQVRFX0lN
UF9JSUNfV1JBUF9DKENMS19JTVBfSUlDX1dSQVBfQ19JMkMxMywgImltcF9paWNfd3JhcF9jX2ky
YzEzIiwgImluZnJhX2kyYzAiLCAzKSwNCit9Ow0KKw0KK3N0YXRpYyBpbnQgY2xrX210ODE5Ml9p
bXBfaWljX3dyYXBfY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KK3sNCisJ
c3RydWN0IGNsa19vbmVjZWxsX2RhdGEgKmNsa19kYXRhOw0KKwlzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCisJaW50IHI7DQorDQorCWNsa19kYXRhID0gbXRr
X2FsbG9jX2Nsa19kYXRhKENMS19JTVBfSUlDX1dSQVBfQ19OUl9DTEspOw0KKwlpZiAoIWNsa19k
YXRhKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCXIgPSBtdGtfY2xrX3JlZ2lzdGVyX2dhdGVz
KG5vZGUsIGltcF9paWNfd3JhcF9jX2Nsa3MsIEFSUkFZX1NJWkUoaW1wX2lpY193cmFwX2NfY2xr
cyksDQorCQkJY2xrX2RhdGEpOw0KKwlpZiAocikNCisJCXJldHVybiByOw0KKw0KKwlyZXR1cm4g
b2ZfY2xrX2FkZF9wcm92aWRlcihub2RlLCBvZl9jbGtfc3JjX29uZWNlbGxfZ2V0LCBjbGtfZGF0
YSk7DQorfQ0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG9mX21hdGNoX2Ns
a19tdDgxOTJfaW1wX2lpY193cmFwX2NbXSA9IHsNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTItaW1wX2lpY193cmFwX2MiLCB9LA0KKwl7fQ0KK307DQorDQorc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kcml2ZXIgY2xrX210ODE5Ml9pbXBfaWljX3dyYXBfY19kcnYgPSB7DQorCS5w
cm9iZSA9IGNsa19tdDgxOTJfaW1wX2lpY193cmFwX2NfcHJvYmUsDQorCS5kcml2ZXIgPSB7DQor
CQkubmFtZSA9ICJjbGstbXQ4MTkyLWltcF9paWNfd3JhcF9jIiwNCisJCS5vZl9tYXRjaF90YWJs
ZSA9IG9mX21hdGNoX2Nsa19tdDgxOTJfaW1wX2lpY193cmFwX2MsDQorCX0sDQorfTsNCisNCiti
dWlsdGluX3BsYXRmb3JtX2RyaXZlcihjbGtfbXQ4MTkyX2ltcF9paWNfd3JhcF9jX2Rydik7DQot
LSANCjEuOC4xLjEuZGlydHkNCg==

