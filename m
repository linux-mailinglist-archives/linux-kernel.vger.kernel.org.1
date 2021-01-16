Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC0D2F8C69
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbhAPJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:08:07 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8608 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726532AbhAPJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:08:01 -0500
X-UUID: fedd5c330b79423fb9339607c6f3a566-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OvB3hFXFOGVfdgXjM+br8KRrMWIctwVUZM9CMEHfv58=;
        b=krL3s7DhLTgXyVHQvIRMIuwm/NA+sYMipDkdI8MoxJ+4uINI7WU6jTf8G896/CyC4laLx5zsrwrTW1O0KpwVXc/9eNw43L7w4EqLkl/x+kCBBVyRhkN8nH4V4Tmjtb+HzviFhquDzafr4oC/vHuSjBUo6m0XGRwlFRvL6IuwHQQ=;
X-UUID: fedd5c330b79423fb9339607c6f3a566-20210116
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1694441950; Sat, 16 Jan 2021 17:07:05 +0800
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
Subject: [PATCH next 05/15] dt-bindings: phy: mediatek: tphy: change patternProperties
Date:   Sat, 16 Jan 2021 17:06:46 +0800
Message-ID: <20210116090656.11752-5-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B103B041099089C7B619B9F8A127C6E346592EF7748ECFD923257CD1ED34FCC12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHBoeSBtYXkgYmUgbmFtZWQgYXMgcGNpZS1waHkgd2hlbiB0aGUgVC1QSFkgb25seSBzdXBw
b3J0cw0KUENJZSBtb2RlLCBpdCdzIGFsc28gdGhlIHNpbWlsYXIgY2FzZSBmb3IgU0FUQSwgbmFt
ZWQgYXMNCnNhdGEtcGh5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5n
Lnl1bkBtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGh5L21lZGlhdGVrLHRwaHkueWFtbCB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5LnlhbWwNCmluZGV4IDYwMmU2ZmY0
NTc4NS4uNGYxNzMzZmQ5YTU1IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5LnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55YW1sDQpAQCAtMTE3LDcgKzExNyw3
IEBAIHByb3BlcnRpZXM6DQogDQogIyBSZXF1aXJlZCBjaGlsZCBub2RlOg0KIHBhdHRlcm5Qcm9w
ZXJ0aWVzOg0KLSAgIl51c2ItcGh5QFswLTlhLWZdKyQiOg0KKyAgIl4odXNifHBjaWV8c2F0YSkt
cGh5QFswLTlhLWZdKyQiOg0KICAgICB0eXBlOiBvYmplY3QNCiAgICAgZGVzY3JpcHRpb246DQog
ICAgICAgQSBzdWItbm9kZSBpcyByZXF1aXJlZCBmb3IgZWFjaCBwb3J0IHRoZSBjb250cm9sbGVy
IHByb3ZpZGVzLg0KLS0gDQoyLjE4LjANCg==

