Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71D300280
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbhAVMII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:08:08 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:28920 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727836AbhAVMFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:05:10 -0500
X-UUID: 331a2452adb147d69964738430c2bc3a-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rQE86x1vLhhJsKySBxWyeudkJDwAAEMmDiZhyp7VOUA=;
        b=N9892eY7wt9oLvDDK8EU3bIhpGbCyvX/05T7IfhMwGb1UxRb6cDqkLXibiMkz7wahY6Gcy6Jqjawe3o3A40KeN5DW73BgmM3F5G9FkQJOBUxeu4uw8KLqcO2GgZmfynZJRiX9ZUvVDiXRaY9nLnvjVz4frt9KChxSUMwRw9CpGw=;
X-UUID: 331a2452adb147d69964738430c2bc3a-20210122
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1835933710; Fri, 22 Jan 2021 20:03:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:37 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:36 +0800
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
Subject: [PATCH next v2 01/17] dt-bindings: usb: fix yamllint check warning
Date:   Fri, 22 Jan 2021 20:03:07 +0800
Message-ID: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ADFE0B5E22C8140947A86047B55443B9E361AEBABB43BE4979F31119D064070D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHdhcm5pbmc6ICJtaXNzaW5nIHN0YXJ0aW5nIHNwYWNlIGluIGNvbW1lbnQiDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djI6IG5vIGNoYW5nZXMNCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvdXNiLWRldmljZS55YW1sIHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3VzYi91c2ItZGV2aWNlLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1kZXZpY2UueWFtbA0KaW5kZXggN2JiMjVhNDU0MjdkLi4y
M2U3NmNmYjIwNjYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL3VzYi1kZXZpY2UueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi91c2ItZGV2aWNlLnlhbWwNCkBAIC04Miw5ICs4Miw5IEBAIHJlcXVpcmVkOg0K
IGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQogDQogZXhhbXBsZXM6DQotICAjaHViIGNvbm5l
Y3RlZCB0byBwb3J0IDENCi0gICNkZXZpY2UgY29ubmVjdGVkIHRvIHBvcnQgMg0KLSAgI2Rldmlj
ZSBjb25uZWN0ZWQgdG8gcG9ydCAzDQorICAjIGh1YiBjb25uZWN0ZWQgdG8gcG9ydCAxDQorICAj
IGRldmljZSBjb25uZWN0ZWQgdG8gcG9ydCAyDQorICAjIGRldmljZSBjb25uZWN0ZWQgdG8gcG9y
dCAzDQogICAjICAgIGludGVyZmFjZSAwIG9mIGNvbmZpZ3VyYXRpb24gMQ0KICAgIyAgICBpbnRl
cmZhY2UgMCBvZiBjb25maWd1cmF0aW9uIDINCiAgIC0gfA0KLS0gDQoyLjE4LjANCg==

