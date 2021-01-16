Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE482F8C75
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbhAPJI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:08:26 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:46186 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbhAPJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:59 -0500
X-UUID: a74ab4bbbbb142cfbc7862f8f6dbfb7d-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VR5RTJ8obuOVwCZGur1zpK6Fre5HWsYtAU4oqij905Q=;
        b=GAVoH0nhQoeRIdpxR03iofk41yiKuR4PqLe5gG3hGyzhhVpzJ+3zpnnQ05wEL8GxESzBOc97t6F7J9Bz6Hp871fh42hvcOfEa9SoMLvBaASzXmbpe3IuiV0/42yki1yYmIlSL1Ws9I+XZFP4UA6tBCbTsNtLxX3LtJT0YAFyu6w=;
X-UUID: a74ab4bbbbb142cfbc7862f8f6dbfb7d-20210116
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 930869144; Sat, 16 Jan 2021 17:07:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:07:03 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:07:03 +0800
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
Subject: [PATCH next 13/15] arm: dts: mt7629: harmonize node names and compatibles
Date:   Sat, 16 Jan 2021 17:06:54 +0800
Message-ID: <20210116090656.11752-13-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 83740CD150C773CF618FC4FA73D09DAFF1321D15ABC9DA8D35617FCFD9397B312000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmcNCg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm0v
Ym9vdC9kdHMvbXQ3NjI5LmR0c2kgfCAxMiArKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvbXQ3NjI5LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9tdDc2MjkuZHRzaQ0KaW5k
ZXggNWNiYjNkMjQ0Yzc1Li44NzQwNDNmMDQ5MGQgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290
L2R0cy9tdDc2MjkuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0c2kNCkBA
IC0zMjksOCArMzI5LDkgQEANCiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAkJfTsNCiANCi0J
CXUzcGh5MDogdXNiLXBoeUAxYTBjNDAwMCB7DQotCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxn
ZW5lcmljLXRwaHktdjIiOw0KKwkJdTNwaHkwOiB0LXBoeUAxYTBjNDAwMCB7DQorCQkJY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDc2MjktdHBoeSIsDQorCQkJCSAgICAgIm1lZGlhdGVrLGdlbmVy
aWMtdHBoeS12MiI7DQogCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQogCQkJI3NpemUtY2VsbHMg
PSA8MT47DQogCQkJcmFuZ2VzID0gPDAgMHgxYTBjNDAwMCAweGUwMD47DQpAQCAtNDEzLDE0ICs0
MTQsMTUgQEANCiAJCQl9Ow0KIAkJfTsNCiANCi0JCXBjaWVwaHkxOiBwY2llLXBoeUAxYTE0YTAw
MCB7DQotCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiOw0KKwkJcGNp
ZXBoeTE6IHQtcGh5QDFhMTRhMDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYy
OS10cGh5IiwNCisJCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCiAJCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCiAJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCiAJCQlyYW5nZXMgPSA8
MCAweDFhMTRhMDAwIDB4MTAwMD47DQogCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiANCi0JCQlw
Y2llcG9ydDE6IHBvcnQxcGh5QDAgew0KKwkJCXBjaWVwb3J0MTogcGNpZS1waHlAMCB7DQogCQkJ
CXJlZyA9IDwwIDB4MTAwMD47DQogCQkJCWNsb2NrcyA9IDwmY2xrMjBtPjsNCiAJCQkJY2xvY2st
bmFtZXMgPSAicmVmIjsNCi0tIA0KMi4xOC4wDQo=

