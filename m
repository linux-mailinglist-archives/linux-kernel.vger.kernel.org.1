Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAB82AAF09
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgKICJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:09:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58255 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729154AbgKICJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:09:29 -0500
X-UUID: 49b12bc028c548f2960c09617f5abc31-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t6pUhuIbwyo1xzafQ+lL/R3rlSTIMMuqKMCM7TBHf84=;
        b=Vi/UaUpc0U3uNrMwfqS9BVlg9rc4Ad7UWM1ny3q6U2u8dBM6W52MGbmUAyJZm2HAjzvCn/ZE+S1mBpOUgz0cGswd4k/G0WMiBC2fN/+lpBfHFZfx78qNMbOZVCiemPidGPXIMZZjYQms/5aZYxDrNUuKmLIFjCbBf3Ji2JoGjuE=;
X-UUID: 49b12bc028c548f2960c09617f5abc31-20201109
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1910421238; Mon, 09 Nov 2020 10:03:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:03:51 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v5 02/24] dt-bindings: ARM: Mediatek: Add new document bindings of mdpsys controller
Date:   Mon, 9 Nov 2020 10:03:27 +0800
Message-ID: <1604887429-29445-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E5C02B343CC9730C7A6DA1A68A16921C9F340624DF9E5F0B65DD78B3841F01432000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIHRoZSBuZXcgYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIG1kcHN5cyBj
b250cm9sbGVyDQpmb3IgTWVkaWF0ZWsgTVQ4MTkyLg0KDQpTaWduZWQtb2ZmLWJ5OiBXZWl5aSBM
dSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxtZHBzeXMueWFtbCAgICAgfCAzOCArKysrKysrKysrKysrKysrKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtZHBz
eXMueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9tZWRpYXRlay9tZWRpYXRlayxtZHBzeXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbWRwc3lzLnlhbWwNCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi44MzFhY2RjDQotLS0gL2Rldi9udWxsDQorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVr
LG1kcHN5cy55YW1sDQpAQCAtMCwwICsxLDM4IEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1kcHN5cy55
YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55
YW1sIw0KKw0KK3RpdGxlOiBNZWRpYVRlayBNRFBTWVMgQ29udHJvbGxlcg0KKw0KK21haW50YWlu
ZXJzOg0KKyAgLSBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0
aW9uOg0KKyAgVGhlIE1lZGlhdGVrIG1kcHN5cyBjb250cm9sbGVyIHByb3ZpZGVzIGZ1bmN0aW9u
YWwgY29uZmlndXJhdGlvbnMgYW5kIGNsb2NrcyB0byB0aGUgc3lzdGVtLg0KKw0KK3Byb3BlcnRp
ZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBpdGVtczoNCisgICAgICAtIGVudW06DQorICAgICAg
ICAgIC0gbWVkaWF0ZWssbXQ4MTkyLW1kcHN5cw0KKyAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KKw0K
KyAgcmVnOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgJyNjbG9jay1jZWxscyc6DQorICAgIGNv
bnN0OiAxDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVnDQorDQorZXhh
bXBsZXM6DQorICAtIHwNCisgICAgbWRwc3lzOiBzeXNjb25AMWYwMDAwMDAgew0KKyAgICAgICAg
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItbWRwc3lzIiwgInN5c2NvbiI7DQorICAgICAg
ICByZWcgPSA8MCAweDFmMDAwMDAwIDAgMHgxMDAwPjsNCisgICAgICAgICNjbG9jay1jZWxscyA9
IDwxPjsNCisgICAgfTsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

