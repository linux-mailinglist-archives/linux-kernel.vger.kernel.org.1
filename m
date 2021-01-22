Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6136300296
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbhAVMLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:11:38 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:62001 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727861AbhAVMEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:35 -0500
X-UUID: edd92a4db27f48178f20bb2d240c0137-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=an2jSo4YgJ+xfkHd5FkDFJC3tnxxFgP78rYeROc9HKk=;
        b=axsZCPFEORl8GsBYv6JSgACCEvQL/bA4uIyVQCb9TVqNCrRmdQLecQbogEqTVKbbwapNLM6JupgK0Nm2JB0G9KfM0hPJDpzzENRe6vwJ2uvJIduC1ddXj48oAFcbhsITnCW+BU0YwoiHZVmN1dH/kNbmZF+t3OgerujYLeXppjk=;
X-UUID: edd92a4db27f48178f20bb2d240c0137-20210122
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 338321640; Fri, 22 Jan 2021 20:03:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:42 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:42 +0800
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
Subject: [PATCH next v2 11/17] arm64: dts: mediatek: mt2712: harmonize node names
Date:   Fri, 22 Jan 2021 20:03:17 +0800
Message-ID: <20210122120323.4337-11-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FC158DB311D5CDC339B388E6DFFAA0D93065E424956087F9196ED5F0F39C37E32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcuDQoNClNpZ25lZC1vZmYtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjI6IG5vIGNo
YW5nZXMNCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpIHwg
OCArKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUu
ZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQppbmRleCBk
YjE3ZDBhNGVkNTcuLmE5Y2NhOWMxNDZmZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210MjcxMmUuZHRzaQ0KQEAgLTgwNSw3ICs4MDUsNyBAQA0KIAkJcmFuZ2VzOw0KIAkJc3Rh
dHVzID0gImRpc2FibGVkIjsNCiANCi0JCXVzYl9ob3N0MDogeGhjaUAxMTI3MDAwMCB7DQorCQl1
c2JfaG9zdDA6IHVzYkAxMTI3MDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3
MTIteGhjaSIsDQogCQkJCSAgICAgIm1lZGlhdGVrLG10ay14aGNpIjsNCiAJCQlyZWcgPSA8MCAw
eDExMjcwMDAwIDAgMHgxMDAwPjsNCkBAIC04MTgsNyArODE4LDcgQEANCiAJCX07DQogCX07DQog
DQotCXUzcGh5MDogdXNiLXBoeUAxMTI5MDAwMCB7DQorCXUzcGh5MDogdC1waHlAMTEyOTAwMDAg
ew0KIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItdHBoeSIsDQogCQkJICAgICAibWVk
aWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KQEAgLTg2
OSw3ICs4NjksNyBAQA0KIAkJcmFuZ2VzOw0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiANCi0J
CXVzYl9ob3N0MTogeGhjaUAxMTJjMDAwMCB7DQorCQl1c2JfaG9zdDE6IHVzYkAxMTJjMDAwMCB7
DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTIteGhjaSIsDQogCQkJCSAgICAgIm1l
ZGlhdGVrLG10ay14aGNpIjsNCiAJCQlyZWcgPSA8MCAweDExMmMwMDAwIDAgMHgxMDAwPjsNCkBA
IC04ODIsNyArODgyLDcgQEANCiAJCX07DQogCX07DQogDQotCXUzcGh5MTogdXNiLXBoeUAxMTJl
MDAwMCB7DQorCXUzcGh5MTogdC1waHlAMTEyZTAwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDI3MTItdHBoeSIsDQogCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsN
CiAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KLS0gDQoyLjE4LjANCg==

