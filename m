Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1323300279
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbhAVMHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:07:11 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6314 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727499AbhAVMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:36 -0500
X-UUID: f02ac677389d4f52ba38cebd0e3775ee-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XDvTsXbuhgAelgKMHjzRvnXct3BR07oS2COt6QieGF4=;
        b=YFK2Q369XbLQmz48NXCcJhSqUUgE2SHqcLTdPzLsOVHi8+v/gfGw823Rq4h0AFje0YMrWp/x5niO0Z7P7Pt+7dQ5hMj/HTQ2UeLIE7tGRpu2zriEDiBWBH216DDJWEr+y0amguYBFx02nDCDzAoQqKoSDafY9lmqxLOCCni5b3Y=;
X-UUID: f02ac677389d4f52ba38cebd0e3775ee-20210122
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 177427216; Fri, 22 Jan 2021 20:03:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:45 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:45 +0800
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
Subject: [PATCH next v2 17/17] arm: dts: mt2701: harmonize node names and compatibles
Date:   Fri, 22 Jan 2021 20:03:23 +0800
Message-ID: <20210122120323.4337-17-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 280F7A1B7EA74A8FC42AB585FAF740E35CD9B1063BB1B081ECBA46D9393448FC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mjogbm8gY2hh
bmdlcw0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvbXQyNzAxLmR0c2kgfCAxOSArKysrKysrKysr
Ky0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaSBiL2FyY2gv
YXJtL2Jvb3QvZHRzL210MjcwMS5kdHNpDQppbmRleCBmYWRlMTQyODQwMTcuLjQ3NzZmODVkNmQ1
YiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL210MjcwMS5kdHNpDQorKysgYi9hcmNo
L2FybS9ib290L2R0cy9tdDI3MDEuZHRzaQ0KQEAgLTYwNyw3ICs2MDcsNyBAQA0KIAl9Ow0KIA0K
IAl1c2IwOiB1c2JAMWExYzAwMDAgew0KLQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMt
eGhjaSI7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS14aGNpIiwgIm1lZGlhdGVr
LG10ay14aGNpIjsNCiAJCXJlZyA9IDwwIDB4MWExYzAwMDAgMCAweDEwMDA+LA0KIAkJICAgICAg
PDAgMHgxYTFjNDcwMCAwIDB4MDEwMD47DQogCQlyZWctbmFtZXMgPSAibWFjIiwgImlwcGMiOw0K
QEAgLTYyMCw4ICs2MjAsOSBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCiANCi0J
dTNwaHkwOiB1c2ItcGh5QDFhMWM0MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQy
NzAxLXUzcGh5IjsNCisJdTNwaHkwOiB0LXBoeUAxYTFjNDAwMCB7DQorCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10MjcwMS10cGh5IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHkt
djEiOw0KIAkJcmVnID0gPDAgMHgxYTFjNDAwMCAwIDB4MDcwMD47DQogCQkjYWRkcmVzcy1jZWxs
cyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KQEAgLTY0Niw3ICs2NDcsNyBAQA0KIAl9
Ow0KIA0KIAl1c2IxOiB1c2JAMWEyNDAwMDAgew0KLQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxNzMteGhjaSI7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS14aGNpIiwgIm1l
ZGlhdGVrLG10ay14aGNpIjsNCiAJCXJlZyA9IDwwIDB4MWEyNDAwMDAgMCAweDEwMDA+LA0KIAkJ
ICAgICAgPDAgMHgxYTI0NDcwMCAwIDB4MDEwMD47DQogCQlyZWctbmFtZXMgPSAibWFjIiwgImlw
cGMiOw0KQEAgLTY1OSw4ICs2NjAsOSBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsN
CiANCi0JdTNwaHkxOiB1c2ItcGh5QDFhMjQ0MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQyNzAxLXUzcGh5IjsNCisJdTNwaHkxOiB0LXBoeUAxYTI0NDAwMCB7DQorCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10MjcwMS10cGh5IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5lcmlj
LXRwaHktdjEiOw0KIAkJcmVnID0gPDAgMHgxYTI0NDAwMCAwIDB4MDcwMD47DQogCQkjYWRkcmVz
cy1jZWxscyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KQEAgLTcwMCw4ICs3MDIsOSBA
QA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCiANCi0JdTJwaHkwOiB1c2ItcGh5QDEx
MjEwMDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCisJ
dTJwaHkwOiB0LXBoeUAxMTIxMDAwMCB7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Mjcw
MS10cGh5IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KIAkJcmVnID0g
PDAgMHgxMTIxMDAwMCAwIDB4MDgwMD47DQogCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAJCSNz
aXplLWNlbGxzID0gPDI+Ow0KLS0gDQoyLjE4LjANCg==

