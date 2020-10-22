Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7039D295E80
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898327AbgJVMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:37:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33545 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898303AbgJVMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:37:54 -0400
X-UUID: aee6dd21c8754a7093f5444193eb5184-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=h8zPlVqxZhGhHgUXWdmgYzf2iYnusNn7hJWQ5EpylJk=;
        b=dm78hj3o5mNKBxy3dljRp/BZkVzQGpHJ6zy/TbH0fCGmAwur2eb3/wiwyMtUHrg5InHJzzyA7/zhPN7OREbcJJdSdIiEMY/HEwU8IkjYdarimJVyhxYdlWEQC7a3wNokDx3GYffmsGFbKYzwlDJIuQpYrqBWJqdJXmnvI2SZfJc=;
X-UUID: aee6dd21c8754a7093f5444193eb5184-20201022
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 637922461; Thu, 22 Oct 2020 20:37:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:45 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 02/34] dt-bindings: ARM: Mediatek: Add new document bindings of imp i2c wrapper controller
Date:   Thu, 22 Oct 2020 20:36:55 +0800
Message-ID: <1603370247-30437-3-git-send-email-weiyi.lu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGRzIHRoZSBuZXcgYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIGltcCBpMmMg
d3JhcHBlciBjb250cm9sbGVyDQpmb3IgTWVkaWF0ZWsgTVQ4MTkyLg0KDQpTaWduZWQtb2ZmLWJ5
OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxpbXBfaWljX3dyYXAueWFtbCAgICAgICAgfCA3OCArKysrKysrKysrKysrKysr
KysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRp
YXRlayxpbXBfaWljX3dyYXAueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbXBfaWljX3dyYXAueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWss
aW1wX2lpY193cmFwLnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi41
ZDBjZjM3DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGltcF9paWNfd3JhcC55YW1sDQpAQCAtMCwwICsx
LDc4IEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xh
dXNlKQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVt
YXMvYXJtL21lZGlhdGVrL21lZGlhdGVrLGltcF9paWNfd3JhcC55YW1sIw0KKyRzY2hlbWE6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBN
ZWRpYVRlayBJTVAgSTJDIFdyYXBwZXIgQ29udHJvbGxlcg0KKw0KK21haW50YWluZXJzOg0KKyAg
LSBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOg0KKyAg
VGhlIE1lZGlhdGVrIGltcCBpMmMgd3JhcHBlciBjb250cm9sbGVyIHByb3ZpZGVzIGZ1bmN0aW9u
YWwgY29uZmlndXJhdGlvbnMgYW5kIGNsb2NrcyB0byB0aGUgc3lzdGVtLg0KKw0KK3Byb3BlcnRp
ZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBpdGVtczoNCisgICAgICAtIGVudW06DQorICAgICAg
ICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWltcF9paWNfd3JhcF9jDQorICAgICAgICAgIC0gbWVkaWF0
ZWssbXQ4MTkyLWltcF9paWNfd3JhcF9lDQorICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWlt
cF9paWNfd3JhcF9zDQorICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWltcF9paWNfd3JhcF93
cw0KKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfdw0KKyAgICAgICAg
ICAtIG1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfbg0KKyAgICAgIC0gY29uc3Q6IHN5c2Nv
bg0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgJyNjbG9jay1jZWxscyc6DQor
ICAgIGNvbnN0OiAxDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVnDQor
DQorZXhhbXBsZXM6DQorICAtIHwNCisgICAgaW1wX2lpY193cmFwX2M6IHN5c2NvbkAxMTAwNzAw
MCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBf
YyIsICJzeXNjb24iOw0KKyAgICAgICAgcmVnID0gPDAgMHgxMTAwNzAwMCAwIDB4MTAwMD47DQor
ICAgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQorICAgIH07DQorDQorICAtIHwNCisgICAgaW1w
X2lpY193cmFwX2U6IHN5c2NvbkAxMWNiMTAwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfZSIsICJzeXNjb24iOw0KKyAgICAgICAgcmVnID0g
PDAgMHgxMWNiMTAwMCAwIDB4MTAwMD47DQorICAgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQor
ICAgIH07DQorDQorICAtIHwNCisgICAgaW1wX2lpY193cmFwX3M6IHN5c2NvbkAxMWQwMzAwMCB7
DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfcyIs
ICJzeXNjb24iOw0KKyAgICAgICAgcmVnID0gPDAgMHgxMWQwMzAwMCAwIDB4MTAwMD47DQorICAg
ICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQorICAgIH07DQorDQorICAtIHwNCisgICAgaW1wX2lp
Y193cmFwX3dzOiBzeXNjb25AMTFkMjMwMDAgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTItaW1wX2lpY193cmFwX3dzIiwgInN5c2NvbiI7DQorICAgICAgICByZWcgPSA8
MCAweDExZDIzMDAwIDAgMHgxMDAwPjsNCisgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsNCisg
ICAgfTsNCisNCisgIC0gfA0KKyAgICBpbXBfaWljX3dyYXBfdzogc3lzY29uQDExZTAxMDAwIHsN
CisgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWltcF9paWNfd3JhcF93Iiwg
InN5c2NvbiI7DQorICAgICAgICByZWcgPSA8MCAweDExZTAxMDAwIDAgMHgxMDAwPjsNCisgICAg
ICAgICNjbG9jay1jZWxscyA9IDwxPjsNCisgICAgfTsNCisNCisgIC0gfA0KKyAgICBpbXBfaWlj
X3dyYXBfbjogc3lzY29uQDExZjAyMDAwIHsNCisgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTkyLWltcF9paWNfd3JhcF9uIiwgInN5c2NvbiI7DQorICAgICAgICByZWcgPSA8MCAw
eDExZjAyMDAwIDAgMHgxMDAwPjsNCisgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsNCisgICAg
fTsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

