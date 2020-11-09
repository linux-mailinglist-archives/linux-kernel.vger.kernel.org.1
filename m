Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CEC2AAF19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgKICKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:10:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58255 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728006AbgKICJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:09:14 -0500
X-UUID: d43a04b304b24b8789901b41d8e1da0f-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/VG/R55jbk5NViG8x3pD6qv4f1prIELEzpN61JMk3aE=;
        b=db3yJkfn6Og8wv3bFZXT56vOaIwuufLktUhok2tvhTMjjZc8DXTtoEtvmf+YaTZZNjepGpXXfWukKXjzZtWDpf/A1N35GMsRwnCCdIWI0iDqCTrmUIlaxaL8M2rqacN2MEW5GOpGqdKVJ4zT097e9rWY8UVuankzYr5Y2iaKp3I=;
X-UUID: d43a04b304b24b8789901b41d8e1da0f-20201109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 172767300; Mon, 09 Nov 2020 10:03:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:03:53 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v5 15/24] clk: mediatek: Add MT8192 ipesys clock support
Date:   Mon, 9 Nov 2020 10:03:40 +0800
Message-ID: <1604887429-29445-16-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBpcGVzeXMgY2xvY2sgcHJvdmlkZXINCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkg
THUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL0tj
b25maWcgICAgICAgICAgfCAgNiArKysrDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUg
ICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWlwZS5jIHwg
NTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQs
IDY0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10ODE5Mi1pcGUuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
S2NvbmZpZyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCmluZGV4IDhhY2M3ZDYuLmM2
YmM2MTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQorKysgYi9k
cml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQpAQCAtNTIxLDYgKzUyMSwxMiBAQCBjb25maWcg
Q09NTU9OX0NMS19NVDgxOTJfSU1QX0lJQ19XUkFQDQogCWhlbHANCiAJICBUaGlzIGRyaXZlciBz
dXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgaW1wX2lpY193cmFwIGNsb2Nrcy4NCiANCitjb25maWcg
Q09NTU9OX0NMS19NVDgxOTJfSVBFU1lTDQorCWJvb2wgIkNsb2NrIGRyaXZlciBmb3IgTWVkaWFU
ZWsgTVQ4MTkyIGlwZXN5cyINCisJZGVwZW5kcyBvbiBDT01NT05fQ0xLX01UODE5Mg0KKwloZWxw
DQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGlwZXN5cyBjbG9ja3Mu
DQorDQogY29uZmlnIENPTU1PTl9DTEtfTVQ4NTE2DQogCWJvb2wgIkNsb2NrIGRyaXZlciBmb3Ig
TWVkaWFUZWsgTVQ4NTE2Ig0KIAlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9U
RVNUDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUgYi9kcml2ZXJz
L2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KaW5kZXggMzc5ODE2Mi4uMzNkYzk3NCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQorKysgYi9kcml2ZXJzL2Nsay9tZWRp
YXRlay9NYWtlZmlsZQ0KQEAgLTcyLDUgKzcyLDYgQEAgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtf
TVQ4MTkyX0FVRFNZUykgKz0gY2xrLW10ODE5Mi1hdWQubw0KIG9iai0kKENPTkZJR19DT01NT05f
Q0xLX01UODE5Ml9DQU1TWVMpICs9IGNsay1tdDgxOTItY2FtLm8NCiBvYmotJChDT05GSUdfQ09N
TU9OX0NMS19NVDgxOTJfSU1HU1lTKSArPSBjbGstbXQ4MTkyLWltZy5vDQogb2JqLSQoQ09ORklH
X0NPTU1PTl9DTEtfTVQ4MTkyX0lNUF9JSUNfV1JBUCkgKz0gY2xrLW10ODE5Mi1pbXBfaWljX3dy
YXAubw0KK29iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JUEVTWVMpICs9IGNsay1tdDgx
OTItaXBlLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTYpICs9IGNsay1tdDg1MTYu
bw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODUxNl9BVURTWVMpICs9IGNsay1tdDg1MTYt
YXVkLm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWlwZS5j
IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pcGUuYw0KbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCmluZGV4IDAwMDAwMDAuLjIxOGU2ODgNCi0tLSAvZGV2L251bGwNCisrKyBiL2RyaXZl
cnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaXBlLmMNCkBAIC0wLDAgKzEsNTcgQEANCisvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQorLy8NCisvLyBDb3B5cmlnaHQg
KGMpIDIwMjAgTWVkaWFUZWsgSW5jLg0KKy8vIEF1dGhvcjogV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4NCisNCisjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQorI2luY2x1
ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4NCisNCisjaW5jbHVkZSAiY2xrLW10ay5oIg0KKyNpbmNsdWRlICJjbGstZ2F0ZS5oIg0KKw0K
KyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQorDQorc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfZ2F0ZV9yZWdzIGlwZV9jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9IDB4
NCwNCisJLmNscl9vZnMgPSAweDgsDQorCS5zdGFfb2ZzID0gMHgwLA0KK307DQorDQorI2RlZmlu
ZSBHQVRFX0lQRShfaWQsIF9uYW1lLCBfcGFyZW50LCBfc2hpZnQpCVwNCisJR0FURV9NVEsoX2lk
LCBfbmFtZSwgX3BhcmVudCwgJmlwZV9jZ19yZWdzLCBfc2hpZnQsICZtdGtfY2xrX2dhdGVfb3Bz
X3NldGNscikNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19nYXRlIGlwZV9jbGtzW10gPSB7
DQorCUdBVEVfSVBFKENMS19JUEVfTEFSQjE5LCAiaXBlX2xhcmIxOSIsICJpcGVfc2VsIiwgMCks
DQorCUdBVEVfSVBFKENMS19JUEVfTEFSQjIwLCAiaXBlX2xhcmIyMCIsICJpcGVfc2VsIiwgMSks
DQorCUdBVEVfSVBFKENMS19JUEVfU01JX1NVQkNPTSwgImlwZV9zbWlfc3ViY29tIiwgImlwZV9z
ZWwiLCAyKSwNCisJR0FURV9JUEUoQ0xLX0lQRV9GRCwgImlwZV9mZCIsICJpcGVfc2VsIiwgMyks
DQorCUdBVEVfSVBFKENMS19JUEVfRkUsICJpcGVfZmUiLCAiaXBlX3NlbCIsIDQpLA0KKwlHQVRF
X0lQRShDTEtfSVBFX1JTQywgImlwZV9yc2MiLCAiaXBlX3NlbCIsIDUpLA0KKwlHQVRFX0lQRShD
TEtfSVBFX0RQRSwgImlwZV9kcGUiLCAiaXBlX3NlbCIsIDYpLA0KKwlHQVRFX0lQRShDTEtfSVBF
X0dBTFMsICJpcGVfZ2FscyIsICJpcGVfc2VsIiwgOCksDQorfTsNCisNCitzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19jbGtfZGVzYyBpcGVfZGVzYyA9IHsNCisJLmNsa3MgPSBpcGVfY2xrcywNCisJ
Lm51bV9jbGtzID0gQVJSQVlfU0laRShpcGVfY2xrcyksDQorfTsNCisNCitzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTkyX2lwZVtdID0gew0KKwl7DQor
CQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItaXBlc3lzIiwNCisJCS5kYXRhID0gJmlw
ZV9kZXNjLA0KKwl9LCB7DQorCQkvKiBzZW50aW5lbCAqLw0KKwl9DQorfTsNCisNCitzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RyaXZlciBjbGtfbXQ4MTkyX2lwZV9kcnYgPSB7DQorCS5wcm9iZSA9
IG10a19jbGtfc2ltcGxlX3Byb2JlLA0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUgPSAiY2xrLW10
ODE5Mi1pcGUiLA0KKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfY2xrX210ODE5Ml9pcGUs
DQorCX0sDQorfTsNCisNCitidWlsdGluX3BsYXRmb3JtX2RyaXZlcihjbGtfbXQ4MTkyX2lwZV9k
cnYpOw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

