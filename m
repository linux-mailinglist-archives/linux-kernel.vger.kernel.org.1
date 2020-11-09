Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17BA2AAEFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgKICJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:09:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58243 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727979AbgKICJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:09:11 -0500
X-UUID: 0b0e6e0b69a44eba889afb78906abaca-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+lnIzSYZOuELnBES1bpkfPuO78eL0jCxiASeRMa0gfA=;
        b=S8MI2eY6mK11rI6F8UD1A5FX3WcnKuULx8ZqVaXuWGYWdaefn3vwTa9SBgr5P24cLTLua5uVOF2cgDM7lt1v1qPXD66EpioTkDBGszMb+CQwPJOAkvbFeMWD5330n9Loxv2cMu1XieTW60D0wxuhX09wjH+T/hqptQWohNm1SDI=;
X-UUID: 0b0e6e0b69a44eba889afb78906abaca-20201109
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1925659650; Mon, 09 Nov 2020 10:03:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:51 +0800
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
Subject: [PATCH v5 04/24] dt-bindings: ARM: Mediatek: Add new document bindings of scp adsp controller
Date:   Mon, 9 Nov 2020 10:03:29 +0800
Message-ID: <1604887429-29445-5-git-send-email-weiyi.lu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGRzIHRoZSBuZXcgYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIHNjcCBhZHNw
IGNvbnRyb2xsZXINCmZvciBNZWRpYXRlayBNVDgxOTIuDQoNClNpZ25lZC1vZmYtYnk6IFdlaXlp
IEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvYXJtL21lZGlh
dGVrL21lZGlhdGVrLHNjcC1hZHNwLnlhbWwgICB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLHNj
cC1hZHNwLnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssc2NwLWFkc3AueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssc2NwLWFkc3AueWFtbA0K
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjI0ZGYzNWQNCi0tLSAvZGV2L251
bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsv
bWVkaWF0ZWssc2NwLWFkc3AueWFtbA0KQEAgLTAsMCArMSwzOCBAQA0KKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjINCistLS0N
CiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2FybS9tZWRpYXRlay9tZWRpYXRl
ayxzY3AtYWRzcC55YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNj
aGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBNZWRpYVRlayBTQ1AgQURTUCBDb250cm9sbGVy
DQorDQorbWFpbnRhaW5lcnM6DQorICAtIFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+
DQorDQorZGVzY3JpcHRpb246DQorICBUaGUgTWVkaWF0ZWsgc2NwIGFkc3AgY29udHJvbGxlciBw
cm92aWRlcyBmdW5jdGlvbmFsIGNvbmZpZ3VyYXRpb25zIGFuZCBjbG9ja3MgdG8gdGhlIHN5c3Rl
bS4NCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgaXRlbXM6DQorICAgICAg
LSBlbnVtOg0KKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1zY3BfYWRzcA0KKyAgICAgIC0g
Y29uc3Q6IHN5c2Nvbg0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgJyNjbG9j
ay1jZWxscyc6DQorICAgIGNvbnN0OiAxDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUN
CisgIC0gcmVnDQorDQorZXhhbXBsZXM6DQorICAtIHwNCisgICAgc2NwX2Fkc3A6IHN5c2NvbkAx
MDcyMDAwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1zY3BfYWRz
cCIsICJzeXNjb24iOw0KKyAgICAgICAgcmVnID0gPDB4MTA3MjAwMDAgMHgxMDAwPjsNCisgICAg
ICAgICNjbG9jay1jZWxscyA9IDwxPjsNCisgICAgfTsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

