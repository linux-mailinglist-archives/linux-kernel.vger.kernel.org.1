Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5B1AD5AA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 07:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgDQFXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 01:23:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39305 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726616AbgDQFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 01:23:16 -0400
X-UUID: 3b90cc3f571b4daaa24d2ae732a939f4-20200417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GC70dnpItBpOUTcj3PL92Hyrly0wCDW2Ddw/cKCswvo=;
        b=h2CPCe9sCtqwEezN0e9irmL2n0J1thkAVwI8YOMcwT6FHN2JTBuq7lj9Mqt+HYA2tyS/7/zIE5iriou4SZWr1Zl6Eg8t53aHp6bbao4e7fCcdr5cmcukixJTfED4FPYxSxBKvWyJ73o5CjiUx80ItT2n8m56nLJbeu7mE0VbnnA=;
X-UUID: 3b90cc3f571b4daaa24d2ae732a939f4-20200417
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 483603488; Fri, 17 Apr 2020 13:23:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 13:23:11 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Apr 2020 13:23:12 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Min Guo <min.Guo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: [PATCH 1/2] dt-bindings: phy-mtk-tphy: add the property about force_vbus
Date:   Fri, 17 Apr 2020 13:23:05 +0800
Message-ID: <1587100986-3104-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHNvbWUgcGxhdGZvcm1zLCB0aGV5IGRvbid0IGhhdmUgdmJ1cyBwaW4gY29ubmVjdGlvbiBi
ZXR3ZWVuIHVzYidzIHBoeQ0KYW5kIG1hYy4gSGVuY2Ugd2UgbmVlZCB0byBjb250cm9sIGZvcmNl
X3ZidXMgcmVsYXRlZCByZWdpc3RlcnMgdG8ga2VlcA0KaGFyZHdhcmUgd29ya3Mgbm9ybWFsLg0K
VGhpcyBwYXRjaCBhZGQgdGhlIHJlcXVpcmVkIGJvb2wgcHJvcGVydHkgZm9yY2VfdmJ1cy4NCg0K
U2lnbmVkLW9mZi1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4
dCB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0
DQppbmRleCBkZDc1YjY3NmI3MWQuLjZiNDliNjUxYmVjYyAxMDA2NDQNCi0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQpAQCAt
MzcsNiArMzcsOSBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzIChjb250cm9sbGVyIChwYXJlbnQpIG5v
ZGUpOg0KIAkJICBjYWxpYnJhdGUNCiAgLSBtZWRpYXRlayxzcmMtY29lZgk6IGNvZWZmaWNpZW50
IGZvciBzbGV3IHJhdGUgY2FsaWJyYXRlLCBkZXBlbmRzIG9uDQogCQkgIFNvQyBwcm9jZXNzDQor
IC0gZm9yY2VfdmJ1cwk6IGlmIHRoZSBwbGF0Zm9ybSBoYXMgbm8gdmJ1cyBjb25uZWN0aW9uIGJl
dHdlZW4gcGh5IGFuZCBtYWMsDQorCQkgIChmb3JjZV92YnVzIG1vZGUpLCB0aGVuIHRoaXMgcHJv
cGVydHkgc2hvdWxkIGJlIGV4aXN0Lg0KKwkJICBPdGhlcndpc2Ugbm90IHRvIGFkZCB0aGlzIHBy
b3BlcnR5Lg0KIA0KIFJlcXVpcmVkIHByb3BlcnRpZXMgKHBvcnQgKGNoaWxkKSBub2RlKToNCiAt
IHJlZwkJOiBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIHJlZ2lzdGVyIHNldCBmb3IgdGhlIHBv
cnQuDQotLSANCjIuMTguMA0K

