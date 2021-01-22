Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9469C300278
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbhAVMGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:06:40 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:1250 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727834AbhAVMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:36 -0500
X-UUID: 920215f943fa40c78ff968fe4b90154d-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qIn76i6k7v8nzgG5bm1U6TpPbZcZbA1soeOBQIpORHs=;
        b=MOzGkl2qviJ3BNbcS+7W+CUC85gnJRJ4jXgZoUShUt6SHKEPr9Ykx7dlptvYUXDVv7RLFcjw67hOxL6X12+YlxuMXxm7p0bVyIxE4DVSgKW4xMnSkMAEtFR4i2hGJCwWgTFG7RHHvCUZTGHKRGQT78DYbP41UJENWZ5dDQ1mRQ0=;
X-UUID: 920215f943fa40c78ff968fe4b90154d-20210122
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 167410604; Fri, 22 Jan 2021 20:03:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:38 +0800
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
Subject: [PATCH next v2 04/17] dt-bindings: phy: mediatek: dsi-phy: add optional clock-names
Date:   Fri, 22 Jan 2021 20:03:10 +0800
Message-ID: <20210122120323.4337-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 86837ABBFC079ABAB25A98071F31EC46D1D50F48A4BE82A5159FF40948B9DD082000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFuIG9wdGlvbmFsICJjbG9jay1uYW1lcyIgcHJvcGVydHksIGl0J3Mgbm90IHVzZWQgdG8g
Z2V0IHRoZSBjbG9jaywNCmJ1dCBzb21lIERUUyBmaWxlcyAoZS5nLiBtdDgxODMpIHByb3ZpZGUg
aXQuDQoNCkNjOiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4NCkNjOiBQ
aGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KU2lnbmVkLW9mZi1ieTogQ2h1
bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2MjogbmV3IHBhdGNo
IHNlcGFyYXRlZCBmcm9tIFszLzE1XSBzdWdnZXN0ZWQgYnkgQ0sNCi0tLQ0KIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sIHwgNCArKysr
DQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxkc2ktcGh5LnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFt
bA0KaW5kZXggNmU0ZDc5NWY5YjAyLi5hZjZlNTU0YzViNjkgMTAwNjQ0DQotLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFtbA0KKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxkc2ktcGh5
LnlhbWwNCkBAIC0zNSw2ICszNSwxMCBAQCBwcm9wZXJ0aWVzOg0KICAgICBpdGVtczoNCiAgICAg
ICAtIGRlc2NyaXB0aW9uOiBQTEwgcmVmZXJlbmNlIGNsb2NrDQogDQorICBjbG9jay1uYW1lczoN
CisgICAgaXRlbXM6DQorICAgICAgLSBjb25zdDogcmVmDQorDQogICBjbG9jay1vdXRwdXQtbmFt
ZXM6DQogICAgIG1heEl0ZW1zOiAxDQogDQotLSANCjIuMTguMA0K

