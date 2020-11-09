Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63602AAF05
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgKICJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:09:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58255 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729170AbgKICJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:09:32 -0500
X-UUID: 726fb34b39564789a85a898fda471bf3-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uBdJBOGJxWj2moBFh8n/KpIwH0ve1GHQH2eVZtORZy0=;
        b=kdlSGEg5M+U7oi7uAQtIyDqvfJwI2eXkk+hfHaobS4onvcFd3AS7utVavhCBlaVwQ8e7eDsbi9yjWwVndpVTBfVj0Kev9S6d+5DOuY7w9D43vY7T9uhWuDfL1BjILT5i0e5oH8/dGKY8dq3CxksfZOpcLmr8vw4lBPrjUmLHYxI=;
X-UUID: 726fb34b39564789a85a898fda471bf3-20201109
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 253466357; Mon, 09 Nov 2020 10:04:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:03:54 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v5 17/24] clk: mediatek: Add MT8192 mfgcfg clock support
Date:   Mon, 9 Nov 2020 10:03:42 +0800
Message-ID: <1604887429-29445-18-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 844058F88B8BD5591EAC1C3B923A91A42A35FF37517570B362519A39CEA625DD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIE1UODE5MiBtZmdjZmcgY2xvY2sgcHJvdmlkZXINCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkg
THUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL0tj
b25maWcgICAgICAgICAgfCAgNiArKysrKw0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxl
ICAgICAgICAgfCAgMSArDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1tZmcuYyB8
IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2Vk
LCA1NyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL21lZGlh
dGVrL2Nsay1tdDgxOTItbWZnLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L0tjb25maWcgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCBhMGEyZWZhOS4u
M2RiODY3MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCisrKyBi
L2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCkBAIC01MzMsNiArNTMzLDEyIEBAIGNvbmZp
ZyBDT01NT05fQ0xLX01UODE5Ml9NRFBTWVMNCiAJaGVscA0KIAkgIFRoaXMgZHJpdmVyIHN1cHBv
cnRzIE1lZGlhVGVrIE1UODE5MiBtZHBzeXMgY2xvY2tzLg0KIA0KK2NvbmZpZyBDT01NT05fQ0xL
X01UODE5Ml9NRkdDRkcNCisJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDgxOTIg
bWZnY2ZnIg0KKwlkZXBlbmRzIG9uIENPTU1PTl9DTEtfTVQ4MTkyDQorCWhlbHANCisJICBUaGlz
IGRyaXZlciBzdXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgbWZnY2ZnIGNsb2Nrcy4NCisNCiBjb25m
aWcgQ09NTU9OX0NMS19NVDg1MTYNCiAJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBN
VDg1MTYiDQogCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL21lZGlh
dGVrL01ha2VmaWxlDQppbmRleCA3YjI1OGNiLi4wMjQ4NDFhIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2Vm
aWxlDQpAQCAtNzQsNSArNzQsNiBAQCBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1H
U1lTKSArPSBjbGstbXQ4MTkyLWltZy5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTky
X0lNUF9JSUNfV1JBUCkgKz0gY2xrLW10ODE5Mi1pbXBfaWljX3dyYXAubw0KIG9iai0kKENPTkZJ
R19DT01NT05fQ0xLX01UODE5Ml9JUEVTWVMpICs9IGNsay1tdDgxOTItaXBlLm8NCiBvYmotJChD
T05GSUdfQ09NTU9OX0NMS19NVDgxOTJfTURQU1lTKSArPSBjbGstbXQ4MTkyLW1kcC5vDQorb2Jq
LSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX01GR0NGRykgKz0gY2xrLW10ODE5Mi1tZmcubw0K
IG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODUxNikgKz0gY2xrLW10ODUxNi5vDQogb2JqLSQo
Q09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2X0FVRFNZUykgKz0gY2xrLW10ODUxNi1hdWQubw0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItbWZnLmMgYi9kcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLW1mZy5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5k
ZXggMDAwMDAwMC4uNTEwYmU5OA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvZHJpdmVycy9jbGsvbWVk
aWF0ZWsvY2xrLW10ODE5Mi1tZmcuYw0KQEAgLTAsMCArMSw1MCBAQA0KKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCisvLw0KKy8vIENvcHlyaWdodCAoYykgMjAyMCBN
ZWRpYVRlayBJbmMuDQorLy8gQXV0aG9yOiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29t
Pg0KKw0KKyNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCisjaW5jbHVkZSA8bGludXgv
b2ZfZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKw0KKyNp
bmNsdWRlICJjbGstbXRrLmgiDQorI2luY2x1ZGUgImNsay1nYXRlLmgiDQorDQorI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2Nsb2NrL210ODE5Mi1jbGsuaD4NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19nYXRlX3JlZ3MgbWZnX2NnX3JlZ3MgPSB7DQorCS5zZXRfb2ZzID0gMHg0LA0KKwkuY2xy
X29mcyA9IDB4OCwNCisJLnN0YV9vZnMgPSAweDAsDQorfTsNCisNCisjZGVmaW5lIEdBVEVfTUZH
KF9pZCwgX25hbWUsIF9wYXJlbnQsIF9zaGlmdCkJXA0KKwlHQVRFX01USyhfaWQsIF9uYW1lLCBf
cGFyZW50LCAmbWZnX2NnX3JlZ3MsIF9zaGlmdCwgJm10a19jbGtfZ2F0ZV9vcHNfc2V0Y2xyKQ0K
Kw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgbWZnX2Nsa3NbXSA9IHsNCisJR0FURV9N
RkcoQ0xLX01GR19CRzNELCAibWZnX2JnM2QiLCAibWZnX3BsbF9zZWwiLCAwKSwNCit9Ow0KKw0K
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Nsa19kZXNjIG1mZ19kZXNjID0gew0KKwkuY2xrcyA9
IG1mZ19jbGtzLA0KKwkubnVtX2Nsa3MgPSBBUlJBWV9TSVpFKG1mZ19jbGtzKSwNCit9Ow0KKw0K
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG9mX21hdGNoX2Nsa19tdDgxOTJfbWZn
W10gPSB7DQorCXsNCisJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1tZmdjZmciLA0K
KwkJLmRhdGEgPSAmbWZnX2Rlc2MsDQorCX0sIHsNCisJCS8qIHNlbnRpbmVsICovDQorCX0NCit9
Ow0KKw0KK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNsa19tdDgxOTJfbWZnX2RydiA9
IHsNCisJLnByb2JlID0gbXRrX2Nsa19zaW1wbGVfcHJvYmUsDQorCS5kcml2ZXIgPSB7DQorCQku
bmFtZSA9ICJjbGstbXQ4MTkyLW1mZyIsDQorCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9j
bGtfbXQ4MTkyX21mZywNCisJfSwNCit9Ow0KKw0KK2J1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKGNs
a19tdDgxOTJfbWZnX2Rydik7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

