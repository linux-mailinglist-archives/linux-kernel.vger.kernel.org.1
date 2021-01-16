Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF902F8C65
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbhAPJH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:07:59 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16947 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726416AbhAPJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:53 -0500
X-UUID: 8c14cfce8a6b4ce4ac15279749a72152-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1NGzGRnCR+w17RCentVNvfjPyjrgOicWDwDStm/Ppnk=;
        b=ElzSOKqb48uoFlfzZWiOUnafbWhWC2+zq/eXd+1ziahb/+qvjVP0yo1NIG5oEweiL11QbemUFKeAvHMozWcsM58h0rg6IEKQqafvIhYSM2riMx24SQ9UTjUFfbtMJwrmhlm9PqxTqgj9/G3I8qmmr0EpvrImHepVnLuQOu6FIPQ=;
X-UUID: 8c14cfce8a6b4ce4ac15279749a72152-20210116
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 839267823; Sat, 16 Jan 2021 17:07:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:07:01 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:07:01 +0800
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
Subject: [PATCH next 09/15] arm64: dts: mediatek: mt2712: harmonize node names
Date:   Sat, 16 Jan 2021 17:06:50 +0800
Message-ID: <20210116090656.11752-9-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FA97D7232DB38159C8903CA725EFE3F987503E76C0F654681B44D61DEA36C8872000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcuDQoNClNpZ25lZC1vZmYtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpIHwgOCArKysrLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUuZHRzaSBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQppbmRleCBkYjE3ZDBhNGVkNTcuLmE5Y2NhOWMx
NDZmZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5k
dHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUuZHRzaQ0KQEAg
LTgwNSw3ICs4MDUsNyBAQA0KIAkJcmFuZ2VzOw0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAN
Ci0JCXVzYl9ob3N0MDogeGhjaUAxMTI3MDAwMCB7DQorCQl1c2JfaG9zdDA6IHVzYkAxMTI3MDAw
MCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTIteGhjaSIsDQogCQkJCSAgICAg
Im1lZGlhdGVrLG10ay14aGNpIjsNCiAJCQlyZWcgPSA8MCAweDExMjcwMDAwIDAgMHgxMDAwPjsN
CkBAIC04MTgsNyArODE4LDcgQEANCiAJCX07DQogCX07DQogDQotCXUzcGh5MDogdXNiLXBoeUAx
MTI5MDAwMCB7DQorCXUzcGh5MDogdC1waHlAMTEyOTAwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDI3MTItdHBoeSIsDQogCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYy
IjsNCiAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KQEAgLTg2OSw3ICs4NjksNyBAQA0KIAkJcmFu
Z2VzOw0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiANCi0JCXVzYl9ob3N0MTogeGhjaUAxMTJj
MDAwMCB7DQorCQl1c2JfaG9zdDE6IHVzYkAxMTJjMDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDI3MTIteGhjaSIsDQogCQkJCSAgICAgIm1lZGlhdGVrLG10ay14aGNpIjsNCiAJ
CQlyZWcgPSA8MCAweDExMmMwMDAwIDAgMHgxMDAwPjsNCkBAIC04ODIsNyArODgyLDcgQEANCiAJ
CX07DQogCX07DQogDQotCXUzcGh5MTogdXNiLXBoeUAxMTJlMDAwMCB7DQorCXUzcGh5MTogdC1w
aHlAMTEyZTAwMDAgew0KIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItdHBoeSIsDQog
CQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCiAJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KLS0gDQoyLjE4LjANCg==

