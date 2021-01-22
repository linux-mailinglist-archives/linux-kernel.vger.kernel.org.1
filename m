Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DE3002A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbhAVMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:13:52 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34330 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbhAVMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:39 -0500
X-UUID: ef8a72d6aa424200b174415468be38b5-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=48EXTivZccVcPZZr+CTslUEs2W/R2G5CDUjauEcVNvY=;
        b=E45GiHkhzUrl1BhSAKjMl1zonSw2KY/wasPgSqTUFp97UNqcyEnhr7AZK98wq5GzwjjbCrz2aP9fLk75yUn+kAikCvK0kr37nkNwLmn1oIwQu4RKrVV5WVPHbWbl+lMp6johNImV+7mXBR8h4gqWClY4zTgdk16fgJNdsekf7Lo=;
X-UUID: ef8a72d6aa424200b174415468be38b5-20210122
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 213331901; Fri, 22 Jan 2021 20:03:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:39 +0800
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
Subject: [PATCH next v2 06/17] dt-bindings: phy: mediatek: tphy: change patternProperties
Date:   Fri, 22 Jan 2021 20:03:12 +0800
Message-ID: <20210122120323.4337-6-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 972F056B92145BF5103B9BFF29F9652B2B8B6FA404D8CD4926BD4901F02E87522000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHBoeSBtYXkgYmUgbmFtZWQgYXMgcGNpZS1waHkgd2hlbiB0aGUgVC1QSFkgb25seSBzdXBw
b3J0cw0KUENJZSBtb2RlLCBpdCdzIGFsc28gdGhlIHNpbWlsYXIgY2FzZSBmb3IgU0FUQSwgbmFt
ZWQgYXMNCnNhdGEtcGh5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5n
Lnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBubyBjaGFuZ2VzDQotLS0NCiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHRwaHkueWFtbCB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5
LnlhbWwNCmluZGV4IDYwMmU2ZmY0NTc4NS4uNGYxNzMzZmQ5YTU1IDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5LnlhbWwNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55
YW1sDQpAQCAtMTE3LDcgKzExNyw3IEBAIHByb3BlcnRpZXM6DQogDQogIyBSZXF1aXJlZCBjaGls
ZCBub2RlOg0KIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KLSAgIl51c2ItcGh5QFswLTlhLWZdKyQiOg0K
KyAgIl4odXNifHBjaWV8c2F0YSktcGh5QFswLTlhLWZdKyQiOg0KICAgICB0eXBlOiBvYmplY3QN
CiAgICAgZGVzY3JpcHRpb246DQogICAgICAgQSBzdWItbm9kZSBpcyByZXF1aXJlZCBmb3IgZWFj
aCBwb3J0IHRoZSBjb250cm9sbGVyIHByb3ZpZGVzLg0KLS0gDQoyLjE4LjANCg==

