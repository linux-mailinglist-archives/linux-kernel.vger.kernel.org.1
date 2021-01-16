Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215E12F8C67
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhAPJIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:08:02 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:46871 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726906AbhAPJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:08:00 -0500
X-UUID: 1fe82d121a43441cba0ab18cb43edf66-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zs+CwzzlLB5XfSyxussKwdTKfOrG+slA6GzwOnDq/Iw=;
        b=C9oFTsvt+mR+t6vuT7lG9tIkJLk/moQzTpbyiJQLvygpM14mjin7U4vMz4K9rCj5bkiLs0To3mP9ijlVb+TdxwnoPKuUQe6iYEaqLQ1Eq2rTPPotdMxZPGKt6l94CC8FxlJ3xTVzgReZt9yClo3nD2QkoQiL21xqXcPE8b8HckU=;
X-UUID: 1fe82d121a43441cba0ab18cb43edf66-20210116
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 600546261; Sat, 16 Jan 2021 17:07:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH next 15/15] arm: dts: mt2701: harmonize node names and compatibles
Date:   Sat, 16 Jan 2021 17:06:56 +0800
Message-ID: <20210116090656.11752-15-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3351F36B74ACAF5BC9F06954368254E694B34A1E7224F948F1C411D66B9947592000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm0v
Ym9vdC9kdHMvbXQyNzAxLmR0c2kgfCAxOSArKysrKysrKysrKy0tLS0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9h
cmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL210MjcwMS5k
dHNpDQppbmRleCBmYWRlMTQyODQwMTcuLjQ3NzZmODVkNmQ1YiAxMDA2NDQNCi0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL210MjcwMS5kdHNpDQorKysgYi9hcmNoL2FybS9ib290L2R0cy9tdDI3MDEu
ZHRzaQ0KQEAgLTYwNyw3ICs2MDcsNyBAQA0KIAl9Ow0KIA0KIAl1c2IwOiB1c2JAMWExYzAwMDAg
ew0KLQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMteGhjaSI7DQorCQljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10MjcwMS14aGNpIiwgIm1lZGlhdGVrLG10ay14aGNpIjsNCiAJCXJlZyA9
IDwwIDB4MWExYzAwMDAgMCAweDEwMDA+LA0KIAkJICAgICAgPDAgMHgxYTFjNDcwMCAwIDB4MDEw
MD47DQogCQlyZWctbmFtZXMgPSAibWFjIiwgImlwcGMiOw0KQEAgLTYyMCw4ICs2MjAsOSBAQA0K
IAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCiANCi0JdTNwaHkwOiB1c2ItcGh5QDFhMWM0
MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzAxLXUzcGh5IjsNCisJdTNwaHkw
OiB0LXBoeUAxYTFjNDAwMCB7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS10cGh5
IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KIAkJcmVnID0gPDAgMHgx
YTFjNDAwMCAwIDB4MDcwMD47DQogCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAJCSNzaXplLWNl
bGxzID0gPDI+Ow0KQEAgLTY0Niw3ICs2NDcsNyBAQA0KIAl9Ow0KIA0KIAl1c2IxOiB1c2JAMWEy
NDAwMDAgew0KLQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMteGhjaSI7DQorCQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS14aGNpIiwgIm1lZGlhdGVrLG10ay14aGNpIjsNCiAJ
CXJlZyA9IDwwIDB4MWEyNDAwMDAgMCAweDEwMDA+LA0KIAkJICAgICAgPDAgMHgxYTI0NDcwMCAw
IDB4MDEwMD47DQogCQlyZWctbmFtZXMgPSAibWFjIiwgImlwcGMiOw0KQEAgLTY1OSw4ICs2NjAs
OSBAQA0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCiANCi0JdTNwaHkxOiB1c2ItcGh5
QDFhMjQ0MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzAxLXUzcGh5IjsNCisJ
dTNwaHkxOiB0LXBoeUAxYTI0NDAwMCB7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Mjcw
MS10cGh5IiwNCisJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KIAkJcmVnID0g
PDAgMHgxYTI0NDAwMCAwIDB4MDcwMD47DQogCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAJCSNz
aXplLWNlbGxzID0gPDI+Ow0KQEAgLTcwMCw4ICs3MDIsOSBAQA0KIAkJc3RhdHVzID0gImRpc2Fi
bGVkIjsNCiAJfTsNCiANCi0JdTJwaHkwOiB1c2ItcGh5QDExMjEwMDAwIHsNCi0JCWNvbXBhdGli
bGUgPSAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCisJdTJwaHkwOiB0LXBoeUAxMTIxMDAw
MCB7DQorCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS10cGh5IiwNCisJCQkgICAgICJt
ZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KIAkJcmVnID0gPDAgMHgxMTIxMDAwMCAwIDB4MDgw
MD47DQogCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAJCSNzaXplLWNlbGxzID0gPDI+Ow0KLS0g
DQoyLjE4LjANCg==

