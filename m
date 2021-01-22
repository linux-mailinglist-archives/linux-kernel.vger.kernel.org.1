Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB330027B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbhAVMH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:07:29 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:44304 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727848AbhAVME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:56 -0500
X-UUID: e57b81fedfa240e2b40d51568eff30ad-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8Q8mJMm+Uv8HA/8uAiIdYzb3sWdEMBkU/9KRt2tyL7E=;
        b=CeTLMHpnSUqk9uNQUYLgpK/am7ykfCm4ViFc4muEDThJ787NsNJFlv5QeEvyJthdwfOjEdfmVk6B0ZmqrNcQPtQ+cNzuKm/mkIDM9IL+qAxS8jUSLRrBI9S4gNRpUTUILjH8HpEj1oURV+I7h273HpiC1ludyoZGyiSqoqgMvJM=;
X-UUID: e57b81fedfa240e2b40d51568eff30ad-20210122
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 949558648; Fri, 22 Jan 2021 20:03:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:39 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:38 +0800
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
Subject: [PATCH next v2 05/17] dt-bindings: phy: mediatek: hdmi-phy: modify compatible items
Date:   Fri, 22 Jan 2021 20:03:11 +0800
Message-ID: <20210122120323.4337-5-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 50CFC95EF7B87D8F8EAF2E73A2B4E8C6A1FCA440BD1F72A9CC4FA90D3DEB561C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNvbXBhdGlsYmUgIm1lZGlhdGVrLG10NzYyMy1oZG1pLXR4IiBpcyBub3Qgc3VwcG9ydGVk
IGluIGRyaXZlciwNCmFuZCBpbiBmYWN0IHVzZXMgIm1lZGlhdGVrLG10MjcwMS1oZG1pLXR4IiBp
bnN0ZWFkIG9uIE1UNzYyMywgc28gY2hhbmdlcw0KdGhlIGNvbXBhdGlibGUgaXRlbXMgdG8gbWFr
ZSBkZXBlbmRlbmNlIGNsZWFyLg0KDQpDYzogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtl
cm5lbC5vcmc+DQpDYzogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRp
YXRlayxoZG1pLXBoeS55YW1sICAgIHwgMTEgKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1s
DQppbmRleCA0NzUyNTE3YTE0NDYuLjBkOTQ5NTBiODRjYSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBo
eS55YW1sDQpAQCAtMjEsMTAgKzIxLDEzIEBAIHByb3BlcnRpZXM6DQogICAgIHBhdHRlcm46ICJe
aGRtaS1waHlAWzAtOWEtZl0rJCINCiANCiAgIGNvbXBhdGlibGU6DQotICAgIGVudW06DQotICAg
ICAgLSBtZWRpYXRlayxtdDI3MDEtaGRtaS1waHkNCi0gICAgICAtIG1lZGlhdGVrLG10NzYyMy1o
ZG1pLXBoeQ0KLSAgICAgIC0gbWVkaWF0ZWssbXQ4MTczLWhkbWktcGh5DQorICAgIG9uZU9mOg0K
KyAgICAgIC0gaXRlbXM6DQorICAgICAgICAgIC0gZW51bToNCisgICAgICAgICAgICAgIC0gbWVk
aWF0ZWssbXQ3NjIzLWhkbWktcGh5DQorICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Mjcw
MS1oZG1pLXBoeQ0KKyAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10MjcwMS1oZG1pLXBoeQ0KKyAg
ICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE3My1oZG1pLXBoeQ0KIA0KICAgcmVnOg0KICAgICBt
YXhJdGVtczogMQ0KLS0gDQoyLjE4LjANCg==

