Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07F52A00ED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgJ3JN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:13:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41562 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbgJ3JNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:13:55 -0400
X-UUID: 99d6ef79b9f542179138382e5e196829-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wS05c32CeOcsELtrfSXV0XioPOrUrgRETIwe251DuTo=;
        b=TtWVmSOFFMQM+WmiJDPkjBMQXVp5IezBZBkWMi36OYKE/qYHRHsfGaHiPzFSaVGAsc+Kz6MH4ehHJx3/7SIwNdQRAdzfl8lyqm1qwKRcCZyv78PxszVBW+QOqqfotmD5IRE2X4vGlR1Sw/DEiu8GSTzRX60BHroNRWt/RtIla9c=;
X-UUID: 99d6ef79b9f542179138382e5e196829-20201030
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1261586912; Fri, 30 Oct 2020 17:13:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Oct 2020 17:13:46 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 17:13:45 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH v4 3/3] memory: mtk-smi: Add mt8192 support
Date:   Fri, 30 Oct 2020 17:12:54 +0800
Message-ID: <20201030091254.26382-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201030091254.26382-1-yong.wu@mediatek.com>
References: <20201030091254.26382-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG10ODE5MiBzbWkgc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCAxOSArKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1z
bWkuYw0KaW5kZXggNjkxZTRjMzQ0Y2Y4Li5hYzM1MGY4ZDFlMjAgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL21lbW9yeS9tdGstc21pLmMNCisrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KQEAg
LTI2OCw2ICsyNjgsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuIG10
a19zbWlfbGFyYl9tdDgxODMgPSB7DQogCQkJCSAgICAgIC8qIElQVTAgfCBJUFUxIHwgQ0NVICov
DQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zbWlfbGFyYl9nZW4gbXRrX3NtaV9s
YXJiX210ODE5MiA9IHsNCisJLmNvbmZpZ19wb3J0ICAgICAgICAgICAgICAgID0gbXRrX3NtaV9s
YXJiX2NvbmZpZ19wb3J0X2dlbjJfZ2VuZXJhbCwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkIG10a19zbWlfbGFyYl9vZl9pZHNbXSA9IHsNCiAJew0KIAkJLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTY3LXNtaS1sYXJiIiwNCkBAIC0yOTMsNiArMjk3LDEwIEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19zbWlfbGFyYl9vZl9pZHNbXSA9
IHsNCiAJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zbWktbGFyYiIsDQogCQkuZGF0
YSA9ICZtdGtfc21pX2xhcmJfbXQ4MTgzDQogCX0sDQorCXsNCisJCS5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE5Mi1zbWktbGFyYiIsDQorCQkuZGF0YSA9ICZtdGtfc21pX2xhcmJfbXQ4MTky
DQorCX0sDQogCXt9DQogfTsNCiANCkBAIC00MzIsNiArNDQwLDEzIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX3NtaV9jb21tb25fcGxhdCBtdGtfc21pX2NvbW1vbl9tdDgxODMgPSB7DQogCQkg
ICAgRl9NTVUxX0xBUkIoNyksDQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zbWlf
Y29tbW9uX3BsYXQgbXRrX3NtaV9jb21tb25fbXQ4MTkyID0gew0KKwkuZ2VuICAgICAgPSBNVEtf
U01JX0dFTjIsDQorCS5oYXNfZ2FscyA9IHRydWUsDQorCS5idXNfc2VsICA9IEZfTU1VMV9MQVJC
KDEpIHwgRl9NTVUxX0xBUkIoMikgfCBGX01NVTFfTEFSQig1KSB8DQorCQkgICAgRl9NTVUxX0xB
UkIoNiksDQorfTsNCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfc21p
X2NvbW1vbl9vZl9pZHNbXSA9IHsNCiAJew0KIAkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTczLXNtaS1jb21tb24iLA0KQEAgLTQ1Nyw2ICs0NzIsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgbXRrX3NtaV9jb21tb25fb2ZfaWRzW10gPSB7DQogCQkuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxODMtc21pLWNvbW1vbiIsDQogCQkuZGF0YSA9ICZtdGtfc21pX2Nv
bW1vbl9tdDgxODMsDQogCX0sDQorCXsNCisJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5
Mi1zbWktY29tbW9uIiwNCisJCS5kYXRhID0gJm10a19zbWlfY29tbW9uX210ODE5MiwNCisJfSwN
CiAJe30NCiB9Ow0KIA0KLS0gDQoyLjE4LjANCg==

