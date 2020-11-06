Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D727E2A8F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKFGJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:09:50 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36975 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726226AbgKFGJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:09:49 -0500
X-UUID: ea47e1df5ce3474095417eac998f0c58-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xZj5FS3qarE4LiVeGgbEFWP056/5Rti+dd86wpSltKU=;
        b=e+r0A7/nQEXl8HZdRLmgnaMUMIig9F0BkFpRzQS4qriyepHs5NVhjF1qEaQgVZRsbjW9B/azbtIaqYvC7Ldcr7tZWYtK0LqsN1f+nsxobQ2F27fgfNJ6w4+KMXdGQ+1yHSnnJEQgf41HVfgxNG4mjDukA6by4dU9LIgonlblUbA=;
X-UUID: ea47e1df5ce3474095417eac998f0c58-20201106
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1871454147; Fri, 06 Nov 2020 14:09:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:39 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:37 +0800
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
Subject: [PATCH v2 06/17] phy: lantiq: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:39 +0800
Message-ID: <1604642930-29019-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E0754A240AA9878765DF52914A59CB090607181917D4BCBFAF1EEA051011EB1A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L2xhbnRpcS9waHktbGFudGlxLXZy
eDIwMC1wY2llLmMgfCA0ICstLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9sYW50aXEvcGh5LWxhbnRp
cS12cngyMDAtcGNpZS5jIGIvZHJpdmVycy9waHkvbGFudGlxL3BoeS1sYW50aXEtdnJ4MjAwLXBj
aWUuYw0KaW5kZXggMjJjNTY5ODEyM2NmLi5lZjkzYmYyY2JhMTAgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3BoeS9sYW50aXEvcGh5LWxhbnRpcS12cngyMDAtcGNpZS5jDQorKysgYi9kcml2ZXJzL3Bo
eS9sYW50aXEvcGh5LWxhbnRpcS12cngyMDAtcGNpZS5jDQpAQCAtNDAyLDcgKzQwMiw2IEBAIHN0
YXRpYyBpbnQgbHRxX3ZyeDIwMF9wY2llX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIAlzdHJ1Y3QgbHRxX3ZyeDIwMF9wY2llX3BoeV9wcml2ICpwcml2Ow0KIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KIAlzdHJ1Y3QgcGh5X3Byb3ZpZGVyICpwcm92
aWRlcjsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCXZvaWQgX19pb21lbSAqYmFzZTsNCiAJ
aW50IHJldDsNCiANCkBAIC00MTAsOCArNDA5LDcgQEAgc3RhdGljIGludCBsdHFfdnJ4MjAwX3Bj
aWVfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWlmICghcHJpdikN
CiAJCXJldHVybiAtRU5PTUVNOw0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRl
diwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQliYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRl
diwgcmVzKTsNCisJYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAw
KTsNCiAJaWYgKElTX0VSUihiYXNlKSkNCiAJCXJldHVybiBQVFJfRVJSKGJhc2UpOw0KIA0KLS0g
DQoyLjE4LjANCg==

