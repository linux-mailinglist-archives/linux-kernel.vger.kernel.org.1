Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65642F8C85
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbhAPJIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:08:49 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39474 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726375AbhAPJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:54 -0500
X-UUID: 8b955c0cfe544f0289fbaa86018b6d21-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GB0vtQkEwWei9wzY+9h3r46wLRGJpP/EuhOhHmCWvRU=;
        b=Lcn8Cq+r8ylBkdltpYWy0USHRWqG+76B2C6LMxoLMXtKBntWM+OSGqdYjKdjoKJe9S+zU3LKLn6Y7Rp9TToAy1D/QjGUkF6Itaimhph4KFEpyLOoNHI1SwOrHXtcyVpZQh7VHylE8aQK3krimMhPelQF4UUlWLf9A48fySrPohI=;
X-UUID: 8b955c0cfe544f0289fbaa86018b6d21-20210116
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 860530851; Sat, 16 Jan 2021 17:07:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:07:02 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:07:02 +0800
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
Subject: [PATCH next 12/15] arm64: dts: mediatek: mt8183: fix dtbs_check warning
Date:   Sat, 16 Jan 2021 17:06:53 +0800
Message-ID: <20210116090656.11752-12-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 642A46D8C21FEDB3D30977DFECD18F391399E364FD2873F15A35EB1082F3ED5E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGFybW9uaXplIG5vZGUgbmFtZXMsIGNvbXBhdGlibGVzIGFuZCBwcm9wZXJ0aWVzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0N
CiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIHwgOSArKysrLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCmluZGV4IDViNzgyYTQ3NjllNy4u
YTY5YTAzM2E2OGFjIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRz
aQ0KQEAgLTg2NSw3ICs4NjUsNyBAQA0KIAkJCXJhbmdlczsNCiAJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KIA0KLQkJCXVzYl9ob3N0OiB4aGNpQDExMjAwMDAwIHsNCisJCQl1c2JfaG9zdDogdXNi
QDExMjAwMDAwIHsNCiAJCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMteGhjaSIsDQog
CQkJCQkgICAgICJtZWRpYXRlayxtdGsteGhjaSI7DQogCQkJCXJlZyA9IDwwIDB4MTEyMDAwMDAg
MCAweDEwMDA+Ow0KQEAgLTkwOCwxMSArOTA4LDExIEBADQogCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCiAJCX07DQogDQotCQltaXBpX3R4MDogbWlwaS1kcGh5QDExZTUwMDAwIHsNCisJCW1pcGlf
dHgwOiBkc2ktcGh5QDExZTUwMDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4
My1taXBpLXR4IjsNCiAJCQlyZWcgPSA8MCAweDExZTUwMDAwIDAgMHgxMDAwPjsNCiAJCQljbG9j
a3MgPSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfTUlQSUQwXzI2TT47DQotCQkJY2xvY2stbmFt
ZXMgPSAicmVmX2NsayI7DQorCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCiAJCQkjY2xvY2stY2Vs
bHMgPSA8MD47DQogCQkJI3BoeS1jZWxscyA9IDwwPjsNCiAJCQljbG9jay1vdXRwdXQtbmFtZXMg
PSAibWlwaV90eDBfcGxsIjsNCkBAIC05MzEsMTEgKzkzMSwxMCBAQA0KIAkJCX07DQogCQl9Ow0K
IA0KLQkJdTNwaHk6IHVzYi1waHlAMTFmNDAwMDAgew0KKwkJdTNwaHk6IHQtcGh5QDExZjQwMDAw
IHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My10cGh5IiwNCiAJCQkJICAgICAi
bWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCiAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCi0J
CQkjcGh5LWNlbGxzID0gPDE+Ow0KIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KIAkJCXJhbmdlcyA9
IDwwIDAgMHgxMWY0MDAwMCAweDEwMDA+Ow0KIAkJCXN0YXR1cyA9ICJva2F5IjsNCi0tIA0KMi4x
OC4wDQo=

