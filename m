Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16D230029E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbhAVMMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:12:43 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:57433 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727828AbhAVMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:36 -0500
X-UUID: 01c3f0bab31a4042bc0917d404f4d3c1-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=33v4emAEwy4Es733aOnIVfsoZyYo4zTl7NmVnYCFqyI=;
        b=dfz9wuoaVZfRUx8wQk4MGX7g+kjBsw2Zp30Js4KG5oov5CxOsrG7x9ktO20RZvsQPotmfgTgp0g9WIzZrD+Yy0UbsKBRGJoh1OSu4z5qMGv41ky7oVCyXhueXiX2giuXkuDNi+bouJwMRKlgwvpJ8EQkhLqRufpVG/GWC/ogpHY=;
X-UUID: 01c3f0bab31a4042bc0917d404f4d3c1-20210122
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 438074738; Fri, 22 Jan 2021 20:03:43 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:40 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:40 +0800
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
Subject: [PATCH next v2 08/17] dt-bindings: usb: mtk-xhci: add compatible for mt2701 and mt7623
Date:   Fri, 22 Jan 2021 20:03:14 +0800
Message-ID: <20210122120323.4337-8-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D2C9E13B7C2D3E36E80E64641C8DE035AD35725A2C9A59818D734E173941A9192000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHR3byBjb21wYXRpYmxlIGZvciBtdDI3MDEgYW5kIG10NzYyMzsNCg0KU2lnbmVkLW9mZi1i
eTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2MjogbmV3
IHBhdGNoIHNlcGFyYXRlZCBmcm9tIFs2LzE1XQ0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sIHwgMiArKw0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KaW5kZXgg
NWViOGQ3Y2Q4MTU1Li40NmZlM2ExODkzNTkgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwNCisrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0K
QEAgLTIzLDggKzIzLDEwIEBAIHByb3BlcnRpZXM6DQogICBjb21wYXRpYmxlOg0KICAgICBpdGVt
czoNCiAgICAgICAtIGVudW06DQorICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLXhoY2kNCiAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDI3MTIteGhjaQ0KICAgICAgICAgICAtIG1lZGlhdGVrLG10
NzYyMi14aGNpDQorICAgICAgICAgIC0gbWVkaWF0ZWssbXQ3NjIzLXhoY2kNCiAgICAgICAgICAg
LSBtZWRpYXRlayxtdDc2MjkteGhjaQ0KICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE3My14aGNp
DQogICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLXhoY2kNCi0tIA0KMi4xOC4wDQo=

