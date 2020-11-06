Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60252A8F2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgKFGJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:09:56 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:23746 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726268AbgKFGJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:09:53 -0500
X-UUID: 1906e9aee8d5405b800213e32c458082-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=COJEGhwhZ3YiSgy4tngOZ9SFs4XBRBqOlSY8hmLbX5E=;
        b=BSKgs/Om5dv6qXrKAC9gAvzibx8KlJ1YSbZtRmois4sJcUR7Z6tnP12ipG0YQZ6OdNs+sLdAIYQU5w6OBURxpzuXXOV8Srdj6bm6lR7N+36mZowutSYTmFVGwE9X1cWyd2349iSXmPwvmo6ZPVyoW7eRljnbaespTOsch5BfJ7Y=;
X-UUID: 1906e9aee8d5405b800213e32c458082-20201106
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 859158244; Fri, 06 Nov 2020 14:09:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:47 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:45 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ondrej Jirman <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Remi Pommarel <repk@triplefau.lt>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Joe Perches <joe@perches.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Anil Varughese <aniljoy@cadence.com>, Li Jun <jun.li@nxp.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 09/17] phy: phy-mtk-ufs: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:42 +0800
Message-ID: <1604642930-29019-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 45453EAE72756B745B4B72D84C1D76AA618179DF419B512DF28C53DFD2BAE7C12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdWZz
LmMgfCA0ICstLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXVmcy5jIGIv
ZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay11ZnMuYw0KaW5kZXggY2Y5NGY1YzM1ZGM1Li43
NjliMDBiMDM4ZDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXVm
cy5jDQorKysgYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXVmcy5jDQpAQCAtMTk1LDcg
KzE5NSw2IEBAIHN0YXRpYyBpbnQgdWZzX210a19waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCiAJc3RydWN0
IHBoeSAqZ2VuZXJpY19waHk7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRlcjsN
Ci0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCXN0cnVjdCB1ZnNfbXRrX3BoeSAqcGh5Ow0KIAlp
bnQgcmV0Ow0KIA0KQEAgLTIwMyw4ICsyMDIsNyBAQCBzdGF0aWMgaW50IHVmc19tdGtfcGh5X3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWlmICghcGh5KQ0KIAkJcmV0dXJu
IC1FTk9NRU07DQogDQotCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09V
UkNFX01FTSwgMCk7DQotCXBoeS0+bW1pbyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJl
cyk7DQorCXBoeS0+bW1pbyA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAw
KTsNCiAJaWYgKElTX0VSUihwaHktPm1taW8pKQ0KIAkJcmV0dXJuIFBUUl9FUlIocGh5LT5tbWlv
KTsNCiANCi0tIA0KMi4xOC4wDQo=

