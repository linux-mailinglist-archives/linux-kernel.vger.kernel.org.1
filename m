Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16285300291
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbhAVMKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:10:11 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:51331 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727831AbhAVMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:40 -0500
X-UUID: e38afb97318c46019950fde82670b343-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZUATM9+QQjfDmz4kMF8bIUWZoXTmatRncETtaTVp+eg=;
        b=SwI5xAEdMuuNhcAuRUr55B1ZFFjucaJv+Y1JwzSFrK3cEjx9vcEM3aNMtFD5o54rqXtn77YYQjXKehBwcCPThdZyaiB3Vdzy7z8pSV/5jhctqW/UQYTEgwuNjXRvQRQuGeVmIU6NYHNjFfsZ6qjX8dh8kH/k1446aqw4wAfudVA=;
X-UUID: e38afb97318c46019950fde82670b343-20210122
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 350030239; Fri, 22 Jan 2021 20:03:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:40 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:39 +0800
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
Subject: [PATCH next v2 07/17] dt-bindings: usb: mtk-xhci: add optional assigned clock properties
Date:   Fri, 22 Jan 2021 20:03:13 +0800
Message-ID: <20210122120323.4337-7-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8DFE6F3FA59A3A1C146558498F64A63A9EF7EEEB84E0C644EA3DB1CBC704FE852000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG9wdGlvbmFsIHByb3BlcnR5ICJhc3NpZ25lZC1jbG9jayIgYW5kICJhc3NpZ25lZC1jbG9j
ay1wYXJlbnRzIg0KdXNlZCBieSBtdDc2MjkuDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1
biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjI6IHNlcGFyYXRlIGNvbXBhdGli
bGUgb3V0IG9mIHRoZSBwYXRjaA0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21l
ZGlhdGVrLG10ay14aGNpLnlhbWwgICAgICAgIHwgOCArKysrKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KaW5kZXggYTM4MTdm
M2FmNTlkLi41ZWI4ZDdjZDgxNTUgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwNCisrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KQEAgLTY3
LDYgKzY3LDE0IEBAIHByb3BlcnRpZXM6DQogICAgICAgLSBjb25zdDogZG1hX2NrDQogICAgICAg
LSBjb25zdDogeGhjaV9jaw0KIA0KKyAgYXNzaWduZWQtY2xvY2tzOg0KKyAgICBtaW5JdGVtczog
MQ0KKyAgICBtYXhJdGVtczogNQ0KKw0KKyAgYXNzaWduZWQtY2xvY2stcGFyZW50czoNCisgICAg
bWluSXRlbXM6IDENCisgICAgbWF4SXRlbXM6IDUNCisNCiAgIHBoeXM6DQogICAgIGRlc2NyaXB0
aW9uOg0KICAgICAgIExpc3Qgb2YgYWxsIFBIWXMgdXNlZCBvbiB0aGlzIEhDRCwgaXQncyBiZXR0
ZXIgdG8ga2VlcCBQSFlzIGluIG9yZGVyDQotLSANCjIuMTguMA0K

