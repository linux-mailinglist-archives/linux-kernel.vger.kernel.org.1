Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4592D2F8C88
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbhAPJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:08:56 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5744 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726355AbhAPJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:53 -0500
X-UUID: 2c9c77b2efa4437b98702a15751ef833-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AD0i1R8yJgFx1z7zUAccj3OpNdRw4eqgL8BYzLFKR2A=;
        b=TDsneO9aOnhLtyLK0eYApAbEy/Cd6uvlROpF5WqZCQuAamKSBlrMExY1xHHEnQPisaCT9U1zcJePvsVjCfVzUQSJplZ64YWcNCGk/4juXNxO14FlHe1pJGEYirh4EbixepLMeklcn8/bkQuo4fQO4QBGeeejmPocCBhlr5JPS/4=;
X-UUID: 2c9c77b2efa4437b98702a15751ef833-20210116
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1308209122; Sat, 16 Jan 2021 17:07:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH next 06/15] dt-bindings: usb: mtk-xhci: add support mt2701 and mt7623
Date:   Sat, 16 Jan 2021 17:06:47 +0800
Message-ID: <20210116090656.11752-6-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8F824AF4D9B980C3A787CC4D4748F8E4E7A4D16D0FF44E694AC9C5BB9BD564332000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHR3byBjb21wYXRpYmxlIGZvciBtdDI3MDEgYW5kIG10NzYyMzsNCmFkZCBwcm9wZXJ0eSAi
YXNzaWduZWQtY2xvY2siIGFuZCAiYXNzaWduZWQtY2xvY2stcGFyZW50cyINCnVzZWQgYnkgbXQ3
NjI5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXho
Y2kueWFtbCAgICAgfCAxMCArKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KaW5kZXggYTM4MTdmM2FmNTlkLi40NmZl
M2ExODkzNTkgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KQEAgLTIzLDggKzIzLDEwIEBA
IHByb3BlcnRpZXM6DQogICBjb21wYXRpYmxlOg0KICAgICBpdGVtczoNCiAgICAgICAtIGVudW06
DQorICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLXhoY2kNCiAgICAgICAgICAgLSBtZWRpYXRl
ayxtdDI3MTIteGhjaQ0KICAgICAgICAgICAtIG1lZGlhdGVrLG10NzYyMi14aGNpDQorICAgICAg
ICAgIC0gbWVkaWF0ZWssbXQ3NjIzLXhoY2kNCiAgICAgICAgICAgLSBtZWRpYXRlayxtdDc2Mjkt
eGhjaQ0KICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE3My14aGNpDQogICAgICAgICAgIC0gbWVk
aWF0ZWssbXQ4MTgzLXhoY2kNCkBAIC02Nyw2ICs2OSwxNCBAQCBwcm9wZXJ0aWVzOg0KICAgICAg
IC0gY29uc3Q6IGRtYV9jaw0KICAgICAgIC0gY29uc3Q6IHhoY2lfY2sNCiANCisgIGFzc2lnbmVk
LWNsb2NrczoNCisgICAgbWluSXRlbXM6IDENCisgICAgbWF4SXRlbXM6IDUNCisNCisgIGFzc2ln
bmVkLWNsb2NrLXBhcmVudHM6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0ZW1zOiA1DQor
DQogICBwaHlzOg0KICAgICBkZXNjcmlwdGlvbjoNCiAgICAgICBMaXN0IG9mIGFsbCBQSFlzIHVz
ZWQgb24gdGhpcyBIQ0QsIGl0J3MgYmV0dGVyIHRvIGtlZXAgUEhZcyBpbiBvcmRlcg0KLS0gDQoy
LjE4LjANCg==

