Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608113002A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbhAVMOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:14:10 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:59539 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727860AbhAVMEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:35 -0500
X-UUID: c3e90bff23f2486ab517ea6f83ef63bd-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b+rliD6ErsjGBCKe2PRtGQm4JfHKXa4sKe26dZmcvbg=;
        b=Y+A+rtcMc4b6gyb/DfivobLleEZthJzShBK/MrkW0+DbuRGzGUnRpm84iQs+FaBxFOH3/42BJgLh18A8J/H4BGdH7wR+Qr05X+JMpcSLKsP34HRIxVhjMmpm0//qa22F8RH9UoA13JmS7/S6vQBuKPZMMdohSZCczar1JwYegr4=;
X-UUID: c3e90bff23f2486ab517ea6f83ef63bd-20210122
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 732322830; Fri, 22 Jan 2021 20:03:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:43 +0800
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
Subject: [PATCH next v2 13/17] arm64: dts: mediatek: mt7622: harmonize node names and compatibles
Date:   Fri, 22 Jan 2021 20:03:19 +0800
Message-ID: <20210122120323.4337-13-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B95AC027A0D275005B58A25D611D752AEAADF4C3D5CD6FDC82CC045DEAA1639F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mjogbm8gY2hh
bmdlcw0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaSB8IDkg
KysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0
c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NzYyMi5kdHNpDQppbmRleCA1Yjll
YzAzMmNlOGQuLjRjZmEwOWIwY2EzYyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ3NjIyLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ3NjIyLmR0c2kNCkBAIC03NDAsOCArNzQwLDggQEANCiAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
DQogCX07DQogDQotCXUzcGh5OiB1c2ItcGh5QDFhMGM0MDAwIHsNCi0JCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ3NjIyLXUzcGh5IiwNCisJdTNwaHk6IHQtcGh5QDFhMGM0MDAwIHsNCisJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIyLXRwaHkiLA0KIAkJCSAgICAgIm1lZGlhdGVrLGdl
bmVyaWMtdHBoeS12MSI7DQogCQlyZWcgPSA8MCAweDFhMGM0MDAwIDAgMHg3MDA+Ow0KIAkJI2Fk
ZHJlc3MtY2VsbHMgPSA8Mj47DQpAQCAtODc1LDggKzg3NSw5IEBADQogCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KIAl9Ow0KIA0KLQlzYXRhX3BoeTogc2F0YS1waHlAMWEyNDMwMDAgew0KLQkJY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KKwlzYXRhX3BoeTogdC1waHlA
MWEyNDMwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjItdHBoeSIsDQorCQkJ
ICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDI+
Ow0KIAkJI3NpemUtY2VsbHMgPSA8Mj47DQogCQlyYW5nZXM7DQotLSANCjIuMTguMA0K

