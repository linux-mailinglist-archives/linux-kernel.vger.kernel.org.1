Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8BD2F8C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbhAPJJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:09:10 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:65504 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725917AbhAPJHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:51 -0500
X-UUID: 0e93ae7d70eb460891d3321686daa840-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WwnxhgLorwhyw1NLWXPU1c0dLoXf00sfDywbsWBcEVw=;
        b=DWysyi7JLan8Bjf8E7+dU8HDF1Xj5BqXmcXVZ9qVKuxhqTXpdQzBCIY9CftzcU6e6xsXOaUKnOCZg2GwZU6dP6EJ2wZGApWqOP0Ox3SoZSPzhYUjIIZPTVLfUOsz/BThX658V5iFZOW79SnEaXdV/XFNZMw1By85VRe8rnoQMas=;
X-UUID: 0e93ae7d70eb460891d3321686daa840-20210116
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1544900288; Sat, 16 Jan 2021 17:07:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:06:59 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:06:59 +0800
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
Subject: [PATCH next 04/15] dt-bindings: phy: mediatek: hdmi-phy: modify compatible items
Date:   Sat, 16 Jan 2021 17:06:45 +0800
Message-ID: <20210116090656.11752-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5BC015561A5653D4F8ACCF64C6C64176CFAF5038CEA1E38B92D473DF6C9A42D62000:8
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
LQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sICAg
IHwgMTEgKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sDQppbmRleCA0NzUyNTE3YTE0NDYu
LjBkOTQ5NTBiODRjYSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sDQpAQCAtMjEsMTAgKzIx
LDEzIEBAIHByb3BlcnRpZXM6DQogICAgIHBhdHRlcm46ICJeaGRtaS1waHlAWzAtOWEtZl0rJCIN
CiANCiAgIGNvbXBhdGlibGU6DQotICAgIGVudW06DQotICAgICAgLSBtZWRpYXRlayxtdDI3MDEt
aGRtaS1waHkNCi0gICAgICAtIG1lZGlhdGVrLG10NzYyMy1oZG1pLXBoeQ0KLSAgICAgIC0gbWVk
aWF0ZWssbXQ4MTczLWhkbWktcGh5DQorICAgIG9uZU9mOg0KKyAgICAgIC0gaXRlbXM6DQorICAg
ICAgICAgIC0gZW51bToNCisgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ3NjIzLWhkbWktcGh5
DQorICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10MjcwMS1oZG1pLXBoeQ0KKyAgICAgIC0g
Y29uc3Q6IG1lZGlhdGVrLG10MjcwMS1oZG1pLXBoeQ0KKyAgICAgIC0gY29uc3Q6IG1lZGlhdGVr
LG10ODE3My1oZG1pLXBoeQ0KIA0KICAgcmVnOg0KICAgICBtYXhJdGVtczogMQ0KLS0gDQoyLjE4
LjANCg==

