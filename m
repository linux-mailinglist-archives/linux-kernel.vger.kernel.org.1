Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2872AAF00
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgKICJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:09:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58255 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729090AbgKICJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:09:17 -0500
X-UUID: b1d26e9810354a8fab01d2f67df3c461-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nS/h4lF326IF6RH+M2AO8aWjCmA16t/yU1NORMtVHXw=;
        b=dGaKUw/fVCEjADr/js0dhbMAMHb7L9tY/4ounfJWXvWjRGQcXeM+/3Kq+Ih7AiAES2M6hwRGc1g86l5njZ+5sQvnwe7Xtvp9di8tPmtvOBcbq5Mj+oOsKu7igola+aMnPqcYDB1Qo1+7AzpnoPFObRrBgmw5Qhm7DWICFoyH6mk=;
X-UUID: b1d26e9810354a8fab01d2f67df3c461-20201109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1976040483; Mon, 09 Nov 2020 10:03:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:55 +0800
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
Subject: [PATCH v5 20/24] clk: mediatek: Add MT8192 scp adsp clock support
Date:   Mon, 9 Nov 2020 10:03:45 +0800
Message-ID: <1604887429-29445-21-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBzY3AgYWRzcCBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2ZmLWJ5OiBXZWl5
aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsv
S2NvbmZpZyAgICAgICAgICAgICAgIHwgIDYgKysrKw0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL01h
a2VmaWxlICAgICAgICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4
MTkyLXNjcF9hZHNwLmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZp
bGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1zY3BfYWRzcC5jDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0K
aW5kZXggYWJhNjYyZi4uMTAwOWUxZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L0tjb25maWcNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCkBAIC01NTEsNiAr
NTUxLDEyIEBAIGNvbmZpZyBDT01NT05fQ0xLX01UODE5Ml9NU0RDDQogCWhlbHANCiAJICBUaGlz
IGRyaXZlciBzdXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgbXNkYyBhbmQgbXNkY190b3AgY2xvY2tz
Lg0KIA0KK2NvbmZpZyBDT01NT05fQ0xLX01UODE5Ml9TQ1BfQURTUA0KKwlib29sICJDbG9jayBk
cml2ZXIgZm9yIE1lZGlhVGVrIE1UODE5MiBzY3BfYWRzcCINCisJZGVwZW5kcyBvbiBDT01NT05f
Q0xLX01UODE5Mg0KKwloZWxwDQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4
MTkyIHNjcF9hZHNwIGNsb2Nrcy4NCisNCiBjb25maWcgQ09NTU9OX0NMS19NVDg1MTYNCiAJYm9v
bCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDg1MTYiDQogCWRlcGVuZHMgb24gQVJDSF9N
RURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRl
ay9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQppbmRleCA4ZTRlMzQz
Li5hMzM2ZmU3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCisr
KyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQpAQCAtNzcsNSArNzcsNiBAQCBvYmot
JChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfTURQU1lTKSArPSBjbGstbXQ4MTkyLW1kcC5vDQog
b2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX01GR0NGRykgKz0gY2xrLW10ODE5Mi1tZmcu
bw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9NTVNZUykgKz0gY2xrLW10ODE5Mi1t
bS5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX01TREMpICs9IGNsay1tdDgxOTIt
bXNkYy5vDQorb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX1NDUF9BRFNQKSArPSBjbGst
bXQ4MTkyLXNjcF9hZHNwLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTYpICs9IGNs
ay1tdDg1MTYubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODUxNl9BVURTWVMpICs9IGNs
ay1tdDg1MTYtYXVkLm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4
MTkyLXNjcF9hZHNwLmMgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLXNjcF9hZHNw
LmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi40YmMyNDAzDQotLS0gL2Rl
di9udWxsDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLXNjcF9hZHNwLmMN
CkBAIC0wLDAgKzEsNTAgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
bmx5DQorLy8NCisvLyBDb3B5cmlnaHQgKGMpIDIwMjAgTWVkaWFUZWsgSW5jLg0KKy8vIEF1dGhv
cjogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCisNCisjaW5jbHVkZSA8bGludXgv
Y2xrLXByb3ZpZGVyLmg+DQorI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KKyNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisNCisjaW5jbHVkZSAiY2xrLW10ay5oIg0KKyNp
bmNsdWRlICJjbGstZ2F0ZS5oIg0KKw0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgx
OTItY2xrLmg+DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZV9yZWdzIHNjcF9hZHNw
X2NnX3JlZ3MgPSB7DQorCS5zZXRfb2ZzID0gMHgxODAsDQorCS5jbHJfb2ZzID0gMHgxODAsDQor
CS5zdGFfb2ZzID0gMHgxODAsDQorfTsNCisNCisjZGVmaW5lIEdBVEVfU0NQX0FEU1AoX2lkLCBf
bmFtZSwgX3BhcmVudCwgX3NoaWZ0KQlcDQorCUdBVEVfTVRLKF9pZCwgX25hbWUsIF9wYXJlbnQs
ICZzY3BfYWRzcF9jZ19yZWdzLCBfc2hpZnQsICZtdGtfY2xrX2dhdGVfb3BzX25vX3NldGNscikN
CisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19nYXRlIHNjcF9hZHNwX2Nsa3NbXSA9IHsNCisJ
R0FURV9TQ1BfQURTUChDTEtfU0NQX0FEU1BfQVVESU9EU1AsICJzY3BfYWRzcF9hdWRpb2RzcCIs
ICJhZHNwX3NlbCIsIDApLA0KK307DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfY2xrX2Rl
c2Mgc2NwX2Fkc3BfZGVzYyA9IHsNCisJLmNsa3MgPSBzY3BfYWRzcF9jbGtzLA0KKwkubnVtX2Ns
a3MgPSBBUlJBWV9TSVpFKHNjcF9hZHNwX2Nsa3MpLA0KK307DQorDQorc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgb2ZfbWF0Y2hfY2xrX210ODE5Ml9zY3BfYWRzcFtdID0gew0KKwl7
DQorCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItc2NwX2Fkc3AiLA0KKwkJLmRhdGEg
PSAmc2NwX2Fkc3BfZGVzYywNCisJfSwgew0KKwkJLyogc2VudGluZWwgKi8NCisJfQ0KK307DQor
DQorc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgY2xrX210ODE5Ml9zY3BfYWRzcF9kcnYg
PSB7DQorCS5wcm9iZSA9IG10a19jbGtfc2ltcGxlX3Byb2JlLA0KKwkuZHJpdmVyID0gew0KKwkJ
Lm5hbWUgPSAiY2xrLW10ODE5Mi1zY3BfYWRzcCIsDQorCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9t
YXRjaF9jbGtfbXQ4MTkyX3NjcF9hZHNwLA0KKwl9LA0KK307DQorDQorYnVpbHRpbl9wbGF0Zm9y
bV9kcml2ZXIoY2xrX210ODE5Ml9zY3BfYWRzcF9kcnYpOw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

