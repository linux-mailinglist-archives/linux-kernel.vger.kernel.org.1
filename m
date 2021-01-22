Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A95300288
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbhAVMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:08:44 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40506 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727867AbhAVMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:05:02 -0500
X-UUID: c2e997dd67a54efb8ee63c8ba758c0e8-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oWYkCrHwpIFtfYQr59l/fzuj/QCgyJUK1c+1Ass2rkk=;
        b=hsp0FEo/diLmwNdeyy5SkvgsoBZzOozdg+B5nUa76rkM/79OTSO4eKe3G7Tuswvh5V4d2pq4FmxkIVV7XtwQ3WwEMZQwVD3w5sfLWm/MZvYlAKwg6gUQPBSZtvAojZV+e6Bb58cydLpw/EeEr+8hr8XIiuGnZv8T6u9EZcU4W/8=;
X-UUID: c2e997dd67a54efb8ee63c8ba758c0e8-20210122
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 498015368; Fri, 22 Jan 2021 20:03:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:45 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:44 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next v2 16/17] arm: dts: mt7623: harmonize node names and compatibles
Date:   Fri, 22 Jan 2021 20:03:22 +0800
Message-ID: <20210122120323.4337-16-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 34CC57FC08A18569532AD1F9562FD9DADB9CFA01D81C6BF998D6ACCD20841C072000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mjogbm8gY2hh
bmdlcw0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzLmR0c2kgIHwgMjYgKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0NCiBhcmNoL2FybS9ib290L2R0cy9tdDc2MjNuLmR0c2kgfCAgNCAr
Ky0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyMy5kdHNpIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbXQ3NjIzLmR0c2kNCmluZGV4IGFlYTY4MDk1MDBkNy4uM2MxMWY3Y2ZjYzQwIDEw
MDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzLmR0c2kNCisrKyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL210NzYyMy5kdHNpDQpAQCAtNzg3LDggKzc4Nyw5IEBADQogCQl9Ow0KIAl9Ow0K
IA0KLQlwY2llMF9waHk6IHBjaWUtcGh5QDFhMTQ5MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCisJcGNpZTBfcGh5OiB0LXBoeUAxYTE0OTAwMCB7DQor
CQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMy10cGh5IiwNCisJCQkgICAgICJtZWRpYXRl
ayxnZW5lcmljLXRwaHktdjEiOw0KIAkJcmVnID0gPDAgMHgxYTE0OTAwMCAwIDB4MDcwMD47DQog
CQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KQEAgLTgwNCw4
ICs4MDUsOSBAQA0KIAkJfTsNCiAJfTsNCiANCi0JcGNpZTFfcGh5OiBwY2llLXBoeUAxYTE0YTAw
MCB7DQotCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MSI7DQorCXBjaWUx
X3BoeTogdC1waHlAMWExNGEwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjMt
dHBoeSIsDQorCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCiAJCXJlZyA9IDww
IDB4MWExNGEwMDAgMCAweDA3MDA+Ow0KIAkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQogCQkjc2l6
ZS1jZWxscyA9IDwyPjsNCkBAIC04MjMsNyArODI1LDcgQEANCiANCiAJdXNiMTogdXNiQDFhMWMw
MDAwIHsNCiAJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIzLXhoY2kiLA0KLQkJCSAgICAg
Im1lZGlhdGVrLG10ODE3My14aGNpIjsNCisJCQkgICAgICJtZWRpYXRlayxtdGsteGhjaSI7DQog
CQlyZWcgPSA8MCAweDFhMWMwMDAwIDAgMHgxMDAwPiwNCiAJCSAgICAgIDwwIDB4MWExYzQ3MDAg
MCAweDAxMDA+Ow0KIAkJcmVnLW5hbWVzID0gIm1hYyIsICJpcHBjIjsNCkBAIC04MzYsOSArODM4
LDkgQEANCiAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCX07DQogDQotCXUzcGh5MTogdXNiLXBo
eUAxYTFjNDAwMCB7DQotCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMy11M3BoeSIsDQot
CQkJICAgICAibWVkaWF0ZWssbXQyNzAxLXUzcGh5IjsNCisJdTNwaHkxOiB0LXBoeUAxYTFjNDAw
MCB7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMy10cGh5IiwNCisJCQkgICAgICJt
ZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KIAkJcmVnID0gPDAgMHgxYTFjNDAwMCAwIDB4MDcw
MD47DQogCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KQEAg
LTg2NCw3ICs4NjYsNyBAQA0KIA0KIAl1c2IyOiB1c2JAMWEyNDAwMDAgew0KIAkJY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDc2MjMteGhjaSIsDQotCQkJICAgICAibWVkaWF0ZWssbXQ4MTczLXho
Y2kiOw0KKwkJCSAgICAgIm1lZGlhdGVrLG10ay14aGNpIjsNCiAJCXJlZyA9IDwwIDB4MWEyNDAw
MDAgMCAweDEwMDA+LA0KIAkJICAgICAgPDAgMHgxYTI0NDcwMCAwIDB4MDEwMD47DQogCQlyZWct
bmFtZXMgPSAibWFjIiwgImlwcGMiOw0KQEAgLTg3Nyw5ICs4NzksOSBAQA0KIAkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCiAJfTsNCiANCi0JdTNwaHkyOiB1c2ItcGh5QDFhMjQ0MDAwIHsNCi0JCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIzLXUzcGh5IiwNCi0JCQkgICAgICJtZWRpYXRlayxt
dDI3MDEtdTNwaHkiOw0KKwl1M3BoeTI6IHQtcGh5QDFhMjQ0MDAwIHsNCisJCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ3NjIzLXRwaHkiLA0KKwkJCSAgICAgIm1lZGlhdGVrLGdlbmVyaWMtdHBo
eS12MSI7DQogCQlyZWcgPSA8MCAweDFhMjQ0MDAwIDAgMHgwNzAwPjsNCiAJCSNhZGRyZXNzLWNl
bGxzID0gPDI+Ow0KIAkJI3NpemUtY2VsbHMgPSA8Mj47DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvbXQ3NjIzbi5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi5kdHNpDQpp
bmRleCAxODgwYWM5ZTMyY2YuLmJjYjA4NDZlMjlmZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL210NzYyM24uZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi5kdHNp
DQpAQCAtMjQ2LDcgKzI0Niw3IEBADQogCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAl9Ow0KIA0K
LQltaXBpX3R4MDogbWlwaS1kcGh5QDEwMDEwMDAwIHsNCisJbWlwaV90eDA6IGRzaS1waHlAMTAw
MTAwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjMtbWlwaS10eCIsDQogCQkJ
ICAgICAibWVkaWF0ZWssbXQyNzAxLW1pcGktdHgiOw0KIAkJcmVnID0gPDAgMHgxMDAxMDAwMCAw
IDB4OTA+Ow0KQEAgLTI2NSw3ICsyNjUsNyBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJ
fTsNCiANCi0JaGRtaV9waHk6IHBoeUAxMDIwOTEwMCB7DQorCWhkbWlfcGh5OiBoZG1pLXBoeUAx
MDIwOTEwMCB7DQogCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMy1oZG1pLXBoeSIsDQog
CQkJICAgICAibWVkaWF0ZWssbXQyNzAxLWhkbWktcGh5IjsNCiAJCXJlZyA9IDwwIDB4MTAyMDkx
MDAgMCAweDI0PjsNCi0tIA0KMi4xOC4wDQo=

