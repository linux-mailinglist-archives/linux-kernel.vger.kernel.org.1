Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC632A8F2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKFGJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:09:58 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:48921 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgKFGJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:09:56 -0500
X-UUID: e0cef88998f64651a4f3929b6c8321d7-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=14pEItytI3ou2XYTXAr0mt+usGhY5nCU0v1aINsIjZk=;
        b=hWO9E0xsqpupSWLmYO5N1FQso/7o+OTTpvxrTwLqCKtnE4fOdb5gFcZlpvD68ye0c6TSt/MZwSZk0Ks9Cy6XnxTAHM+or5G5epbJaZAtwMu4jGFwExs0oX0wjwp372+w+H3Zfo+ojrF9IXYzQBAiArz+icfcPi1aXpYIpPYtPVs=;
X-UUID: e0cef88998f64651a4f3929b6c8321d7-20201106
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 247845975; Fri, 06 Nov 2020 14:09:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:44 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:42 +0800
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
Subject: [PATCH v2 08/17] phy: phy-xgene: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:41 +0800
Message-ID: <1604642930-29019-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 40B54A23EA6D8C92BE8AEA978EF9ED140FE8132AD0B2E7A25CED412601DE87FB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L3BoeS14Z2VuZS5jIHwgNCArLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9waHkvcGh5LXhnZW5lLmMgYi9kcml2ZXJzL3BoeS9waHkteGdlbmUu
Yw0KaW5kZXggYjg4OTIyZTdkZTFkLi5mNGNkNTkwZmJkZTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3BoeS9waHkteGdlbmUuYw0KKysrIGIvZHJpdmVycy9waHkvcGh5LXhnZW5lLmMNCkBAIC0xNjQ0
LDcgKzE2NDQsNiBAQCBzdGF0aWMgaW50IHhnZW5lX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KIHsNCiAJc3RydWN0IHBoeV9wcm92aWRlciAqcGh5X3Byb3ZpZGVyOw0K
IAlzdHJ1Y3QgeGdlbmVfcGh5X2N0eCAqY3R4Ow0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJ
dTMyIGRlZmF1bHRfc3BkW10gPSBERUZBVUxUX1NBVEFfU1BEX1NFTDsNCiAJdTMyIGRlZmF1bHRf
dHhib29zdF9nYWluW10gPSBERUZBVUxUX1NBVEFfVFhCT09TVF9HQUlOOw0KIAl1MzIgZGVmYXVs
dF90eGV5ZV9kaXJlY3Rpb25bXSA9IERFRkFVTFRfU0FUQV9UWEVZRURJUkVDVElPTjsNCkBAIC0x
NjYxLDggKzE2NjAsNyBAQCBzdGF0aWMgaW50IHhnZW5lX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIA0KIAljdHgtPmRldiA9ICZwZGV2LT5kZXY7DQogDQotCXJlcyA9
IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQotCWN0eC0+
c2RzX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCisJY3R4
LT5zZHNfYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCiAJ
aWYgKElTX0VSUihjdHgtPnNkc19iYXNlKSkNCiAJCXJldHVybiBQVFJfRVJSKGN0eC0+c2RzX2Jh
c2UpOw0KIA0KLS0gDQoyLjE4LjANCg==

