Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84972F8C64
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbhAPJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:07:55 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:18193 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbhAPJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:53 -0500
X-UUID: e1bbd0ced2f648e282a7f06f4de89306-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Kv59Axlq0qhwBmXC0hIPeSBvN5ohPuytAp9x0JVl2IA=;
        b=F6hGMnIe2r3alm5qVJ1n8HCFmIQcVbNa1zqOkKTicUTlFfGwtluQ9zVXFX7ZUdqRoR7SPAsNAPPH835TGE4BWk/IXh9yqjFREm9HoPpCKXNq9i3PKQXqhyH/1I3Xsmc9N6YG4U8aUIGyTTJt/SpkzNUSGOoBQW+iUwkSbhT71Ws=;
X-UUID: e1bbd0ced2f648e282a7f06f4de89306-20210116
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 910488761; Sat, 16 Jan 2021 17:07:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH next 11/15] arm64: dts: mediatek: mt7622: harmonize node names and compatibles
Date:   Sat, 16 Jan 2021 17:06:52 +0800
Message-ID: <20210116090656.11752-11-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 883846D0D6C42F269763240AB6E849612BFB772917956454F9FE561056A3A4A92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaSB8IDkgKysrKystLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL210NzYyMi5kdHNpDQppbmRleCA1YjllYzAzMmNlOGQuLjRjZmEwOWIwY2Ez
YyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0c2kN
CisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0c2kNCkBAIC03NDAs
OCArNzQwLDggQEANCiAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCX07DQogDQotCXUzcGh5OiB1
c2ItcGh5QDFhMGM0MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIyLXUzcGh5
IiwNCisJdTNwaHk6IHQtcGh5QDFhMGM0MDAwIHsNCisJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ3NjIyLXRwaHkiLA0KIAkJCSAgICAgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MSI7DQogCQly
ZWcgPSA8MCAweDFhMGM0MDAwIDAgMHg3MDA+Ow0KIAkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQpA
QCAtODc1LDggKzg3NSw5IEBADQogCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAl9Ow0KIA0KLQlz
YXRhX3BoeTogc2F0YS1waHlAMWEyNDMwMDAgew0KLQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxn
ZW5lcmljLXRwaHktdjEiOw0KKwlzYXRhX3BoeTogdC1waHlAMWEyNDMwMDAgew0KKwkJY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDc2MjItdHBoeSIsDQorCQkJICAgICAibWVkaWF0ZWssZ2VuZXJp
Yy10cGh5LXYxIjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KIAkJI3NpemUtY2VsbHMgPSA8
Mj47DQogCQlyYW5nZXM7DQotLSANCjIuMTguMA0K

