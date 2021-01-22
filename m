Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC2300290
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbhAVMJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:09:44 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:41617 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727854AbhAVMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:39 -0500
X-UUID: 9383e623499545c98aa24f6461af3845-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uUkfGqqCxCFWoBRe1Hp2gLCJX5B+cAZ8kmC5XDvA+IU=;
        b=ABAJM5G9k3LJipWo8mjDN7Prw98h/DRcXyjJ305U5KXk19oYJfe+b2ha6YagHK/Hx84K7/5kNrEqmOU7CHbR9fmXRcLLUKH+AGrSi/SJW0GNC3StZLhkpAM5DHWt1WqKiJzDqr4J902zBrRmECAcDp0l9IrBNYAB2v5XKK7pTYI=;
X-UUID: 9383e623499545c98aa24f6461af3845-20210122
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 675554263; Fri, 22 Jan 2021 20:03:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:44 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:44 +0800
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
Subject: [PATCH next v2 15/17] arm: dts: mt7629: harmonize node names and compatibles
Date:   Fri, 22 Jan 2021 20:03:21 +0800
Message-ID: <20210122120323.4337-15-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 724D2CBA5CBBCA9E67223AC6DD9CBC8D9C4576045DDCB515EE0AC2073ADA45CB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mjogbm8gY2hh
bmdlcw0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0c2kgfCAxMiArKysrKysrLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0c2kgYi9hcmNoL2FybS9ib290
L2R0cy9tdDc2MjkuZHRzaQ0KaW5kZXggNWNiYjNkMjQ0Yzc1Li44NzQwNDNmMDQ5MGQgMTAwNjQ0
DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9v
dC9kdHMvbXQ3NjI5LmR0c2kNCkBAIC0zMjksOCArMzI5LDkgQEANCiAJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KIAkJfTsNCiANCi0JCXUzcGh5MDogdXNiLXBoeUAxYTBjNDAwMCB7DQotCQkJY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KKwkJdTNwaHkwOiB0LXBoeUAx
YTBjNDAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjktdHBoeSIsDQorCQkJ
CSAgICAgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MiI7DQogCQkJI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQogCQkJI3NpemUtY2VsbHMgPSA8MT47DQogCQkJcmFuZ2VzID0gPDAgMHgxYTBjNDAwMCAw
eGUwMD47DQpAQCAtNDEzLDE0ICs0MTQsMTUgQEANCiAJCQl9Ow0KIAkJfTsNCiANCi0JCXBjaWVw
aHkxOiBwY2llLXBoeUAxYTE0YTAwMCB7DQotCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5l
cmljLXRwaHktdjIiOw0KKwkJcGNpZXBoeTE6IHQtcGh5QDFhMTRhMDAwIHsNCisJCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10NzYyOS10cGh5IiwNCisJCQkJICAgICAibWVkaWF0ZWssZ2VuZXJp
Yy10cGh5LXYyIjsNCiAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCiAJCQkjc2l6ZS1jZWxscyA9
IDwxPjsNCiAJCQlyYW5nZXMgPSA8MCAweDFhMTRhMDAwIDB4MTAwMD47DQogCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCiANCi0JCQlwY2llcG9ydDE6IHBvcnQxcGh5QDAgew0KKwkJCXBjaWVwb3J0
MTogcGNpZS1waHlAMCB7DQogCQkJCXJlZyA9IDwwIDB4MTAwMD47DQogCQkJCWNsb2NrcyA9IDwm
Y2xrMjBtPjsNCiAJCQkJY2xvY2stbmFtZXMgPSAicmVmIjsNCi0tIA0KMi4xOC4wDQo=

