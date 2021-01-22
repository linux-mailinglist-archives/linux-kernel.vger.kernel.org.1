Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5374330027E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbhAVMHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:07:51 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:59539 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727905AbhAVMFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:05:30 -0500
X-UUID: a64847cfdb3746a7820d3b6c9ff30284-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IoSpFkZfN5zWBssj/M0jIzpQEODxOOztR6vrrRwST9Q=;
        b=dSJzm5KGBcHcH68mPAZfkqYqtotcmCWyCKhRrKT5Ee18L+5I3XUNreHVTA3yuAIt6yWat5aYSOlAtDd05W6CN5k5efBVEeKkgSyLj/MlbikFrL/vxe2/5ITnJttcjVOJIpKDE1gaHyRoAHSDi9DdBgZ59qgrQ0gdxy3tuVZFABM=;
X-UUID: a64847cfdb3746a7820d3b6c9ff30284-20210122
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 245057536; Fri, 22 Jan 2021 20:03:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:44 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:43 +0800
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
Subject: [PATCH next v2 14/17] arm64: dts: mediatek: mt8183: fix dtbs_check warning
Date:   Fri, 22 Jan 2021 20:03:20 +0800
Message-ID: <20210122120323.4337-14-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 62EA1FA93DE4F85F02C2B74F15D1006C0FC5CB1F644CDC0AB45944C9F7ED8D2A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGFybW9uaXplIG5vZGUgbmFtZXMsIGNvbXBhdGlibGVzIGFuZCBwcm9wZXJ0aWVzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0N
CnYyOiBubyBjaGFuZ2VzDQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4
My5kdHNpIHwgOSArKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxODMuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kN
CmluZGV4IDViNzgyYTQ3NjllNy4uYTY5YTAzM2E2OGFjIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KQEAgLTg2NSw3ICs4NjUsNyBAQA0KIAkJCXJhbmdlczsN
CiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIA0KLQkJCXVzYl9ob3N0OiB4aGNpQDExMjAwMDAw
IHsNCisJCQl1c2JfaG9zdDogdXNiQDExMjAwMDAwIHsNCiAJCQkJY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxODMteGhjaSIsDQogCQkJCQkgICAgICJtZWRpYXRlayxtdGsteGhjaSI7DQogCQkJ
CXJlZyA9IDwwIDB4MTEyMDAwMDAgMCAweDEwMDA+Ow0KQEAgLTkwOCwxMSArOTA4LDExIEBADQog
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCX07DQogDQotCQltaXBpX3R4MDogbWlwaS1kcGh5
QDExZTUwMDAwIHsNCisJCW1pcGlfdHgwOiBkc2ktcGh5QDExZTUwMDAwIHsNCiAJCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE4My1taXBpLXR4IjsNCiAJCQlyZWcgPSA8MCAweDExZTUwMDAw
IDAgMHgxMDAwPjsNCiAJCQljbG9ja3MgPSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfTUlQSUQw
XzI2TT47DQotCQkJY2xvY2stbmFtZXMgPSAicmVmX2NsayI7DQorCQkJY2xvY2stbmFtZXMgPSAi
cmVmIjsNCiAJCQkjY2xvY2stY2VsbHMgPSA8MD47DQogCQkJI3BoeS1jZWxscyA9IDwwPjsNCiAJ
CQljbG9jay1vdXRwdXQtbmFtZXMgPSAibWlwaV90eDBfcGxsIjsNCkBAIC05MzEsMTEgKzkzMSwx
MCBAQA0KIAkJCX07DQogCQl9Ow0KIA0KLQkJdTNwaHk6IHVzYi1waHlAMTFmNDAwMDAgew0KKwkJ
dTNwaHk6IHQtcGh5QDExZjQwMDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4
My10cGh5IiwNCiAJCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCiAJCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCi0JCQkjcGh5LWNlbGxzID0gPDE+Ow0KIAkJCSNzaXplLWNlbGxz
ID0gPDE+Ow0KIAkJCXJhbmdlcyA9IDwwIDAgMHgxMWY0MDAwMCAweDEwMDA+Ow0KIAkJCXN0YXR1
cyA9ICJva2F5IjsNCi0tIA0KMi4xOC4wDQo=

