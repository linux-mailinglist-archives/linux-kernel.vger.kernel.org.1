Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7CF2AAEF0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgKICER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:04:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57267 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729095AbgKICEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:04:07 -0500
X-UUID: 8279a0476c9545e9b3e879d6cad7e9de-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fL4Il9NDkMsjf2pTBSUPfzqjgGFsajL5unq6O46tb+8=;
        b=Ax+uEP96Cvz5+pvAbpaA+7OlFST28eDNJLrtC1FC4bDyH7FgT7yheC4iv9B5akPF9yodwKtq6WpNbxItEJ5TdeEAxSD+L05R3WHOzLeWfMs34slKPdCRi2KuiZoMknnN+D95UfwPNdWC7+bMqqcM2bHI13JwgTS6Yu7486MAwwk=;
X-UUID: 8279a0476c9545e9b3e879d6cad7e9de-20201109
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 795914125; Mon, 09 Nov 2020 10:03:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:03:55 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v5 22/24] clk: mediatek: Add MT8192 vencsys clock support
Date:   Mon, 9 Nov 2020 10:03:47 +0800
Message-ID: <1604887429-29445-23-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIE1UODE5MiB2ZW5jc3lzIGNsb2NrIHByb3ZpZGVyDQoNClNpZ25lZC1vZmYtYnk6IFdlaXlp
IEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9L
Y29uZmlnICAgICAgICAgICB8ICA2ICsrKysNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmls
ZSAgICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLXZlbmMu
YyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5n
ZWQsIDYwIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVk
aWF0ZWsvY2xrLW10ODE5Mi12ZW5jLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlh
dGVrL0tjb25maWcgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCA2MzNlODA2
Li42YTZhYzQxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysr
IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KQEAgLTU2Myw2ICs1NjMsMTIgQEAgY29u
ZmlnIENPTU1PTl9DTEtfTVQ4MTkyX1ZERUNTWVMNCiAJaGVscA0KIAkgIFRoaXMgZHJpdmVyIHN1
cHBvcnRzIE1lZGlhVGVrIE1UODE5MiB2ZGVjc3lzIGFuZCB2ZGVjc3lzX3NvYyBjbG9ja3MuDQog
DQorY29uZmlnIENPTU1PTl9DTEtfTVQ4MTkyX1ZFTkNTWVMNCisJYm9vbCAiQ2xvY2sgZHJpdmVy
IGZvciBNZWRpYVRlayBNVDgxOTIgdmVuY3N5cyINCisJZGVwZW5kcyBvbiBDT01NT05fQ0xLX01U
ODE5Mg0KKwloZWxwDQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIHZl
bmNzeXMgY2xvY2tzLg0KKw0KIGNvbmZpZyBDT01NT05fQ0xLX01UODUxNg0KIAlib29sICJDbG9j
ayBkcml2ZXIgZm9yIE1lZGlhVGVrIE1UODUxNiINCiAJZGVwZW5kcyBvbiBBUkNIX01FRElBVEVL
IHx8IENPTVBJTEVfVEVTVA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2Vm
aWxlIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCmluZGV4IDg4N2RkNmIuLjE1YmMw
NDUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KKysrIGIvZHJp
dmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCkBAIC03OSw1ICs3OSw2IEBAIG9iai0kKENPTkZJ
R19DT01NT05fQ0xLX01UODE5Ml9NTVNZUykgKz0gY2xrLW10ODE5Mi1tbS5vDQogb2JqLSQoQ09O
RklHX0NPTU1PTl9DTEtfTVQ4MTkyX01TREMpICs9IGNsay1tdDgxOTItbXNkYy5vDQogb2JqLSQo
Q09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX1NDUF9BRFNQKSArPSBjbGstbXQ4MTkyLXNjcF9hZHNw
Lm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfVkRFQ1NZUykgKz0gY2xrLW10ODE5
Mi12ZGVjLm8NCitvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfVkVOQ1NZUykgKz0gY2xr
LW10ODE5Mi12ZW5jLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTYpICs9IGNsay1t
dDg1MTYubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODUxNl9BVURTWVMpICs9IGNsay1t
dDg1MTYtYXVkLm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTky
LXZlbmMuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItdmVuYy5jDQpuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uY2UyMjBjNQ0KLS0tIC9kZXYvbnVsbA0KKysr
IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi12ZW5jLmMNCkBAIC0wLDAgKzEsNTMg
QEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQorLy8NCisvLyBD
b3B5cmlnaHQgKGMpIDIwMjAgTWVkaWFUZWsgSW5jLg0KKy8vIEF1dGhvcjogV2VpeWkgTHUgPHdl
aXlpLmx1QG1lZGlhdGVrLmNvbT4NCisNCisjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+
DQorI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9y
bV9kZXZpY2UuaD4NCisNCisjaW5jbHVkZSAiY2xrLW10ay5oIg0KKyNpbmNsdWRlICJjbGstZ2F0
ZS5oIg0KKw0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQorDQor
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZV9yZWdzIHZlbmNfY2dfcmVncyA9IHsNCisJLnNl
dF9vZnMgPSAweDQsDQorCS5jbHJfb2ZzID0gMHg4LA0KKwkuc3RhX29mcyA9IDB4MCwNCit9Ow0K
Kw0KKyNkZWZpbmUgR0FURV9WRU5DKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9zaGlmdCkJXA0KKwlH
QVRFX01USyhfaWQsIF9uYW1lLCBfcGFyZW50LCAmdmVuY19jZ19yZWdzLCBfc2hpZnQsICZtdGtf
Y2xrX2dhdGVfb3BzX3NldGNscl9pbnYpDQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0
ZSB2ZW5jX2Nsa3NbXSA9IHsNCisJR0FURV9WRU5DKENMS19WRU5DX1NFVDBfTEFSQiwgInZlbmNf
c2V0MF9sYXJiIiwgInZlbmNfc2VsIiwgMCksDQorCUdBVEVfVkVOQyhDTEtfVkVOQ19TRVQxX1ZF
TkMsICJ2ZW5jX3NldDFfdmVuYyIsICJ2ZW5jX3NlbCIsIDQpLA0KKwlHQVRFX1ZFTkMoQ0xLX1ZF
TkNfU0VUMl9KUEdFTkMsICJ2ZW5jX3NldDJfanBnZW5jIiwgInZlbmNfc2VsIiwgOCksDQorCUdB
VEVfVkVOQyhDTEtfVkVOQ19TRVQ1X0dBTFMsICJ2ZW5jX3NldDVfZ2FscyIsICJ2ZW5jX3NlbCIs
IDI4KSwNCit9Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Nsa19kZXNjIHZlbmNfZGVz
YyA9IHsNCisJLmNsa3MgPSB2ZW5jX2Nsa3MsDQorCS5udW1fY2xrcyA9IEFSUkFZX1NJWkUodmVu
Y19jbGtzKSwNCit9Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG9mX21h
dGNoX2Nsa19tdDgxOTJfdmVuY1tdID0gew0KKwl7DQorCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTItdmVuY3N5cyIsDQorCQkuZGF0YSA9ICZ2ZW5jX2Rlc2MsDQorCX0sIHsNCisJCS8q
IHNlbnRpbmVsICovDQorCX0NCit9Ow0KKw0KK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVy
IGNsa19tdDgxOTJfdmVuY19kcnYgPSB7DQorCS5wcm9iZSA9IG10a19jbGtfc2ltcGxlX3Byb2Jl
LA0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUgPSAiY2xrLW10ODE5Mi12ZW5jIiwNCisJCS5vZl9t
YXRjaF90YWJsZSA9IG9mX21hdGNoX2Nsa19tdDgxOTJfdmVuYywNCisJfSwNCit9Ow0KKw0KK2J1
aWx0aW5fcGxhdGZvcm1fZHJpdmVyKGNsa19tdDgxOTJfdmVuY19kcnYpOw0KLS0gDQoxLjguMS4x
LmRpcnR5DQo=

