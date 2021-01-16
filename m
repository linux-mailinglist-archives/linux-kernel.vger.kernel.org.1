Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EADC2F8C68
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAPJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:07:49 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:9174 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725964AbhAPJHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:47 -0500
X-UUID: b9104e2364bb4d6d91ad2047620d1b62-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yGhzv1EUXi8QSnA1bSVjasGhtffl3aQKGg5i1yBbnS8=;
        b=Y5SBmYAYo7fcFrhZtZHxFoOdaSHU2ehxp00visSoefv7nbHwKZX+uWCA2bSW2W+fu+BNTiPU5dVtbIHvk5dnQGLSkFXLGfF//I3nyCLOS9CtjbCzkmNSuo79XPY4LXERSkJRFp604XpJfz2+Sbfyqo8wTRP0KMxizCtPKha0gLc=;
X-UUID: b9104e2364bb4d6d91ad2047620d1b62-20210116
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 449338106; Sat, 16 Jan 2021 17:07:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:06:57 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:06:57 +0800
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
Subject: [PATCH next 01/15] dt-bindings: usb: fix yamllint check warning
Date:   Sat, 16 Jan 2021 17:06:42 +0800
Message-ID: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D4253F565DE206D3F1DE0E9951088A82B846C0C7F21195BBF20DABE1589C86902000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHdhcm5pbmc6ICJtaXNzaW5nIHN0YXJ0aW5nIHNwYWNlIGluIGNvbW1lbnQiDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWRldmljZS55YW1sIHwg
NiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91
c2ItZGV2aWNlLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3Vz
Yi1kZXZpY2UueWFtbA0KaW5kZXggN2JiMjVhNDU0MjdkLi4yM2U3NmNmYjIwNjYgMTAwNjQ0DQot
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1kZXZpY2UueWFt
bA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91c2ItZGV2aWNl
LnlhbWwNCkBAIC04Miw5ICs4Miw5IEBAIHJlcXVpcmVkOg0KIGFkZGl0aW9uYWxQcm9wZXJ0aWVz
OiB0cnVlDQogDQogZXhhbXBsZXM6DQotICAjaHViIGNvbm5lY3RlZCB0byBwb3J0IDENCi0gICNk
ZXZpY2UgY29ubmVjdGVkIHRvIHBvcnQgMg0KLSAgI2RldmljZSBjb25uZWN0ZWQgdG8gcG9ydCAz
DQorICAjIGh1YiBjb25uZWN0ZWQgdG8gcG9ydCAxDQorICAjIGRldmljZSBjb25uZWN0ZWQgdG8g
cG9ydCAyDQorICAjIGRldmljZSBjb25uZWN0ZWQgdG8gcG9ydCAzDQogICAjICAgIGludGVyZmFj
ZSAwIG9mIGNvbmZpZ3VyYXRpb24gMQ0KICAgIyAgICBpbnRlcmZhY2UgMCBvZiBjb25maWd1cmF0
aW9uIDINCiAgIC0gfA0KLS0gDQoyLjE4LjANCg==

