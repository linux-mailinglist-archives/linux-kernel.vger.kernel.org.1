Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EEB2F8C90
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbhAPJJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:09:21 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:33249 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726367AbhAPJHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:51 -0500
X-UUID: b2694990a7934a7aadf4d061fea6d06f-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Pun8v9yMPDCTHtps/y4Jux1MOuwf6jBhU/B3znpzGRU=;
        b=uN3+wiSBq+h8XXRaOpRRENP2zrJiABCTaNGJ8e+0pqmTY7jXUe8eb+qFL1LlGQNoOBZY1WwHKAjM6XWkk8wKjS5/llZ+11vOwENymZlvWND0zCA4eT3Aq/2Yu6vf4cZM226Cbt7PLpxIDtfydQldtojYgRRpKSzPIhtsW7wxh3o=;
X-UUID: b2694990a7934a7aadf4d061fea6d06f-20210116
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 648124648; Sat, 16 Jan 2021 17:07:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:07:00 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:07:00 +0800
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
Subject: [PATCH next 07/15] dt-bindings: usb: mediatek: musb: add mt8516 compatbile
Date:   Sat, 16 Jan 2021 17:06:48 +0800
Message-ID: <20210116090656.11752-7-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DE61612F5C69EEB0311F4163049276AC8C365331AAC1AD784024FF33524DA77B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHN1cHBvcnQgbXQ4NTE2IGNvbXBhdGJpbGUNCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcg
WXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdXNiLnlhbWwgfCAxICsNCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXVzYi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdXNiLnlhbWwNCmluZGV4IGE1MTVjOWYzMGI5
Ni4uZTAyZDhmNWQ1M2RjIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9tZWRpYXRlayxtdXNiLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXVzYi55YW1sDQpAQCAtMTcsNiArMTcsNyBAQCBw
cm9wZXJ0aWVzOg0KICAgY29tcGF0aWJsZToNCiAgICAgaXRlbXM6DQogICAgICAgLSBlbnVtOg0K
KyAgICAgICAgICAtIG1lZGlhdGVrLG10ODUxNi1tdXNiDQogICAgICAgICAgIC0gbWVkaWF0ZWss
bXQyNzAxLW11c2INCiAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdGstbXVzYg0KIA0KLS0gDQoy
LjE4LjANCg==

