Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504EF2F8C91
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbhAPJJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:09:25 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40255 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbhAPJHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:51 -0500
X-UUID: 5d99b24f2edf4ac2a138dc5046852fc0-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=G+OJnN7fDA/BpSOYjVKjCZxkMLdTgC3xWjZvIWrZOsk=;
        b=pHDDMdXWkSb3s9ywKTtXatolnEcbHvXhRpwk6XgrtNtbd1HnYvJHKGO8ZPymmqEy1+1e8dmK8KGKu8voJs5BLeu/20AcN+m6UYQcWKzgHwggxSKow0ePqArJ/ae9Wv32coBwG3ihT+gThhEYEh5ezEvMUfohUlYS1beUg8N5T+o=;
X-UUID: 5d99b24f2edf4ac2a138dc5046852fc0-20210116
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1269323464; Sat, 16 Jan 2021 17:07:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:06:58 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:06:58 +0800
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
Subject: [PATCH next 03/15] dt-bindings: phy: mediatek: dsi-phy: modify compatible dependence
Date:   Sat, 16 Jan 2021 17:06:44 +0800
Message-ID: <20210116090656.11752-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2941C6C062B00D6A4C12F6AB8FC1907DA6D697F2F4234EBEDA9C467556CFAEAB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNvbXBhdGlsYmUgIm1lZGlhdGVrLG10NzYyMy1taXBpLXR4IiBpcyBub3Qgc3VwcG9ydGVk
IGluIGRyaXZlciwNCmFuZCBpbiBmYWN0IHVzZXMgIm1lZGlhdGVrLG10MjcwMS1taXBpLXR4IiBp
bnN0ZWFkIG9uIE1UNzYyMywgc28gY2hhbmdlcw0KdGhlIGNvbXBhdGlibGUgaXRlbXMgdG8gbWFr
ZSBkZXBlbmRlbmNlIGNsZWFyLg0KDQpBbmQgYWRkIGFuIG9wdGlvbmFsICJjbG9jay1uYW1lcyIg
cHJvcGVydHksIGl0J3Mgbm90IHVzZWQgdG8gZ2V0IHRoZSBjbG9jaywNCmJ1dCBzb21lIERUUyBm
aWxlcyBwcm92aWRlIGl0Lg0KDQpDYzogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtlcm5l
bC5vcmc+DQpDYzogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IC4uLi9iaW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sICAgICAgICAgIHwgMTcgKysr
KysrKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BoeS9tZWRpYXRlayxkc2ktcGh5LnlhbWwNCmluZGV4IDcxZDRhY2VhMWY2Ni4uYWY2
ZTU1NGM1YjY5IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BoeS9tZWRpYXRlayxkc2ktcGh5LnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sDQpAQCAtMTksMTEgKzE5LDE0IEBA
IHByb3BlcnRpZXM6DQogICAgIHBhdHRlcm46ICJeZHNpLXBoeUBbMC05YS1mXSskIg0KIA0KICAg
Y29tcGF0aWJsZToNCi0gICAgZW51bToNCi0gICAgICAtIG1lZGlhdGVrLG10MjcwMS1taXBpLXR4
DQotICAgICAgLSBtZWRpYXRlayxtdDc2MjMtbWlwaS10eA0KLSAgICAgIC0gbWVkaWF0ZWssbXQ4
MTczLW1pcGktdHgNCi0gICAgICAtIG1lZGlhdGVrLG10ODE4My1taXBpLXR4DQorICAgIG9uZU9m
Og0KKyAgICAgIC0gaXRlbXM6DQorICAgICAgICAgIC0gZW51bToNCisgICAgICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ3NjIzLW1pcGktdHgNCisgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQy
NzAxLW1pcGktdHgNCisgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDI3MDEtbWlwaS10eA0KKyAg
ICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE3My1taXBpLXR4DQorICAgICAgLSBjb25zdDogbWVk
aWF0ZWssbXQ4MTgzLW1pcGktdHgNCiANCiAgIHJlZzoNCiAgICAgbWF4SXRlbXM6IDENCkBAIC0z
Miw2ICszNSwxMCBAQCBwcm9wZXJ0aWVzOg0KICAgICBpdGVtczoNCiAgICAgICAtIGRlc2NyaXB0
aW9uOiBQTEwgcmVmZXJlbmNlIGNsb2NrDQogDQorICBjbG9jay1uYW1lczoNCisgICAgaXRlbXM6
DQorICAgICAgLSBjb25zdDogcmVmDQorDQogICBjbG9jay1vdXRwdXQtbmFtZXM6DQogICAgIG1h
eEl0ZW1zOiAxDQogDQotLSANCjIuMTguMA0K

