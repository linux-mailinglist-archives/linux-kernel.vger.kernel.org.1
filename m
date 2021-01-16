Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA292F8C66
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbhAPJIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:08:00 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6112 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726595AbhAPJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:53 -0500
X-UUID: 547eb8ad9f114c21ac9dbc17e4146e30-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uDNLP7ADdXCMr8hSuR/u2EkeXQr9wsPK4ssl9r4Wats=;
        b=FO+fXLlqwKtHWU4TNdteO+/qkcuU/XBgIyyQeyzhHZm1Dgye2ys2SJEee5oZXdxkrCmnitAyqsAcFvGd36AsQxuZLvEp3ekwG3mbNFH6C+WmrH1N/Iyx5LIhLI0xp6O8C1yfijadfEVXl8MH/ntQlY2fFQAUykXbsPvuP62sYk0=;
X-UUID: 547eb8ad9f114c21ac9dbc17e4146e30-20210116
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 264209683; Sat, 16 Jan 2021 17:07:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:07:04 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:07:04 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next 14/15] arm: dts: mt7623: harmonize node names and compatibles
Date:   Sat, 16 Jan 2021 17:06:55 +0800
Message-ID: <20210116090656.11752-14-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 54C35A6C593BFAA8C54FCFEAE478818AD46520745EBBB51584EBB75785034DB32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm0v
Ym9vdC9kdHMvbXQ3NjIzLmR0c2kgIHwgMjYgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCiBh
cmNoL2FybS9ib290L2R0cy9tdDc2MjNuLmR0c2kgfCAgNCArKy0tDQogMiBmaWxlcyBjaGFuZ2Vk
LCAxNiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL210NzYyMy5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzLmR0c2kN
CmluZGV4IGFlYTY4MDk1MDBkNy4uM2MxMWY3Y2ZjYzQwIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvbXQ3NjIzLmR0c2kNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyMy5kdHNp
DQpAQCAtNzg3LDggKzc4Nyw5IEBADQogCQl9Ow0KIAl9Ow0KIA0KLQlwY2llMF9waHk6IHBjaWUt
cGh5QDFhMTQ5MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYx
IjsNCisJcGNpZTBfcGh5OiB0LXBoeUAxYTE0OTAwMCB7DQorCQljb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10NzYyMy10cGh5IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0K
IAkJcmVnID0gPDAgMHgxYTE0OTAwMCAwIDB4MDcwMD47DQogCQkjYWRkcmVzcy1jZWxscyA9IDwy
PjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KQEAgLTgwNCw4ICs4MDUsOSBAQA0KIAkJfTsNCiAJ
fTsNCiANCi0JcGNpZTFfcGh5OiBwY2llLXBoeUAxYTE0YTAwMCB7DQotCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MSI7DQorCXBjaWUxX3BoeTogdC1waHlAMWExNGEwMDAg
ew0KKwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjMtdHBoeSIsDQorCQkJICAgICAibWVk
aWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCiAJCXJlZyA9IDwwIDB4MWExNGEwMDAgMCAweDA3MDA+
Ow0KIAkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQogCQkjc2l6ZS1jZWxscyA9IDwyPjsNCkBAIC04
MjMsNyArODI1LDcgQEANCiANCiAJdXNiMTogdXNiQDFhMWMwMDAwIHsNCiAJCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ3NjIzLXhoY2kiLA0KLQkJCSAgICAgIm1lZGlhdGVrLG10ODE3My14aGNp
IjsNCisJCQkgICAgICJtZWRpYXRlayxtdGsteGhjaSI7DQogCQlyZWcgPSA8MCAweDFhMWMwMDAw
IDAgMHgxMDAwPiwNCiAJCSAgICAgIDwwIDB4MWExYzQ3MDAgMCAweDAxMDA+Ow0KIAkJcmVnLW5h
bWVzID0gIm1hYyIsICJpcHBjIjsNCkBAIC04MzYsOSArODM4LDkgQEANCiAJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQogCX07DQogDQotCXUzcGh5MTogdXNiLXBoeUAxYTFjNDAwMCB7DQotCQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMy11M3BoeSIsDQotCQkJICAgICAibWVkaWF0ZWssbXQy
NzAxLXUzcGh5IjsNCisJdTNwaHkxOiB0LXBoeUAxYTFjNDAwMCB7DQorCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10NzYyMy10cGh5IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHkt
djEiOw0KIAkJcmVnID0gPDAgMHgxYTFjNDAwMCAwIDB4MDcwMD47DQogCQkjYWRkcmVzcy1jZWxs
cyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KQEAgLTg2NCw3ICs4NjYsNyBAQA0KIA0K
IAl1c2IyOiB1c2JAMWEyNDAwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjMt
eGhjaSIsDQotCQkJICAgICAibWVkaWF0ZWssbXQ4MTczLXhoY2kiOw0KKwkJCSAgICAgIm1lZGlh
dGVrLG10ay14aGNpIjsNCiAJCXJlZyA9IDwwIDB4MWEyNDAwMDAgMCAweDEwMDA+LA0KIAkJICAg
ICAgPDAgMHgxYTI0NDcwMCAwIDB4MDEwMD47DQogCQlyZWctbmFtZXMgPSAibWFjIiwgImlwcGMi
Ow0KQEAgLTg3Nyw5ICs4NzksOSBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCiAN
Ci0JdTNwaHkyOiB1c2ItcGh5QDFhMjQ0MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ3NjIzLXUzcGh5IiwNCi0JCQkgICAgICJtZWRpYXRlayxtdDI3MDEtdTNwaHkiOw0KKwl1M3Bo
eTI6IHQtcGh5QDFhMjQ0MDAwIHsNCisJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIzLXRw
aHkiLA0KKwkJCSAgICAgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MSI7DQogCQlyZWcgPSA8MCAw
eDFhMjQ0MDAwIDAgMHgwNzAwPjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KIAkJI3NpemUt
Y2VsbHMgPSA8Mj47DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi5kdHNp
IGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi5kdHNpDQppbmRleCAxODgwYWM5ZTMyY2YuLmJj
YjA4NDZlMjlmZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyM24uZHRzaQ0K
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzbi5kdHNpDQpAQCAtMjQ2LDcgKzI0Niw3IEBA
DQogCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAl9Ow0KIA0KLQltaXBpX3R4MDogbWlwaS1kcGh5
QDEwMDEwMDAwIHsNCisJbWlwaV90eDA6IGRzaS1waHlAMTAwMTAwMDAgew0KIAkJY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDc2MjMtbWlwaS10eCIsDQogCQkJICAgICAibWVkaWF0ZWssbXQyNzAx
LW1pcGktdHgiOw0KIAkJcmVnID0gPDAgMHgxMDAxMDAwMCAwIDB4OTA+Ow0KQEAgLTI2NSw3ICsy
NjUsNyBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCiANCi0JaGRtaV9waHk6IHBo
eUAxMDIwOTEwMCB7DQorCWhkbWlfcGh5OiBoZG1pLXBoeUAxMDIwOTEwMCB7DQogCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10NzYyMy1oZG1pLXBoeSIsDQogCQkJICAgICAibWVkaWF0ZWssbXQy
NzAxLWhkbWktcGh5IjsNCiAJCXJlZyA9IDwwIDB4MTAyMDkxMDAgMCAweDI0PjsNCi0tIA0KMi4x
OC4wDQo=

