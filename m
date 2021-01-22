Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321E83002A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbhAVMOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:14:15 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:55777 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727829AbhAVMEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:35 -0500
X-UUID: f831c8082bc9438aa9dd83907b6c3c69-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iJWCGfU5SL9p5xF0unlcnUoDW5RnO4Bq8sFL6Of5k4Q=;
        b=N6J4yGxAsQA7HHofCZ1Lgxi8dedjZotGlG4t6cC2BVUoZHD+VhkwdyThaiDmb9i5Dpvfx3/DtWp8OEPSsMusUt6HpXbEzg+YxwmHO23qSf4wy4kI03FV5P9rTdqOQsXBpLpe+kFilUIS1RN6VDiACOdBMZurrCIgLXMzf8OvJSE=;
X-UUID: f831c8082bc9438aa9dd83907b6c3c69-20210122
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 883762335; Fri, 22 Jan 2021 20:03:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:38 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:37 +0800
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
Subject: [PATCH next v2 03/17] dt-bindings: phy: mediatek: dsi-phy: modify compatible dependence
Date:   Fri, 22 Jan 2021 20:03:09 +0800
Message-ID: <20210122120323.4337-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F04E50F19F4BC40B902CECC833742C05D9A0D46DB951459ADC99C74EEFBAC6A92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNvbXBhdGlsYmUgIm1lZGlhdGVrLG10NzYyMy1taXBpLXR4IiBpcyBub3Qgc3VwcG9ydGVk
IGluIGRyaXZlciwNCmFuZCBpbiBmYWN0IHVzZXMgIm1lZGlhdGVrLG10MjcwMS1taXBpLXR4IiBp
bnN0ZWFkIG9uIE1UNzYyMywgc28gY2hhbmdlcw0KdGhlIGNvbXBhdGlibGUgaXRlbXMgdG8gbWFr
ZSBkZXBlbmRlbmNlIGNsZWFyLg0KDQpDYzogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtl
cm5lbC5vcmc+DQpDYzogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KdjI6IHNlcGFyYXRlIHR3byBwYXRjaGVzIHN1Z2dlc3RlZCBieSBDSw0KLS0tDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFtbCAgIHwgMTMgKysrKysr
KystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21l
ZGlhdGVrLGRzaS1waHkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sDQppbmRleCA3MWQ0YWNlYTFmNjYuLjZlNGQ3OTVmOWIw
MiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVk
aWF0ZWssZHNpLXBoeS55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFtbA0KQEAgLTE5LDExICsxOSwxNCBAQCBwcm9wZXJ0
aWVzOg0KICAgICBwYXR0ZXJuOiAiXmRzaS1waHlAWzAtOWEtZl0rJCINCiANCiAgIGNvbXBhdGli
bGU6DQotICAgIGVudW06DQotICAgICAgLSBtZWRpYXRlayxtdDI3MDEtbWlwaS10eA0KLSAgICAg
IC0gbWVkaWF0ZWssbXQ3NjIzLW1pcGktdHgNCi0gICAgICAtIG1lZGlhdGVrLG10ODE3My1taXBp
LXR4DQotICAgICAgLSBtZWRpYXRlayxtdDgxODMtbWlwaS10eA0KKyAgICBvbmVPZjoNCisgICAg
ICAtIGl0ZW1zOg0KKyAgICAgICAgICAtIGVudW06DQorICAgICAgICAgICAgICAtIG1lZGlhdGVr
LG10NzYyMy1taXBpLXR4DQorICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10MjcwMS1taXBp
LXR4DQorICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLW1pcGktdHgNCisgICAgICAtIGNv
bnN0OiBtZWRpYXRlayxtdDgxNzMtbWlwaS10eA0KKyAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10
ODE4My1taXBpLXR4DQogDQogICByZWc6DQogICAgIG1heEl0ZW1zOiAxDQotLSANCjIuMTguMA0K

