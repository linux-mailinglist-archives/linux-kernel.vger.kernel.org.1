Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022C9295E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898315AbgJVMh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:37:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33545 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898283AbgJVMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:37:52 -0400
X-UUID: a24cbf71aedc4f4f96f2e06e95b2ac2f-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t6pUhuIbwyo1xzafQ+lL/R3rlSTIMMuqKMCM7TBHf84=;
        b=NzO1Sd1UYg+wXqi16v0tgxxlj3cq6LJJfi0/XUknLoYhVynM1I21a29cP1W/Eyp/FuQMmjXBYrq6yZ3hctd0nxxE7Hps9Ziurci/ORMWJChhDQJUNk7r8wDZkA97m5aPE0o5WcVTgkufLpLrwrOcWhsDUZzjbVc5IDnU/2AifSM=;
X-UUID: a24cbf71aedc4f4f96f2e06e95b2ac2f-20201022
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1912351017; Thu, 22 Oct 2020 20:37:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v4 03/34] dt-bindings: ARM: Mediatek: Add new document bindings of mdpsys controller
Date:   Thu, 22 Oct 2020 20:36:56 +0800
Message-ID: <1603370247-30437-4-git-send-email-weiyi.lu@mediatek.com>
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

