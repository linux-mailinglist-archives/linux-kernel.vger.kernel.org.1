Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7654E2A8F39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgKFGKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:10:41 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:41074 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726427AbgKFGKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:10:40 -0500
X-UUID: 90920305bdd44e38b8425b7b6b02ee91-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+jQTv6Qdqq2eI24/km4wG6QU5N33+5xqcoowHO6chiA=;
        b=RDWP4ishM7KYGKitAvZze0d0T1Zsp9xTKH7MXnfW2rQa85ZHKYRLwqN8Df6wbAjXyqgdYPLsYdy+cjtoJ3gD87joWnhnxV+wrKo/HaB0TzsNjOTwI7HBm3uza2ylAVAEMwVIUodA/ub0Giz7v7ilf4TJf5TURHb795sDzjnDB7A=;
X-UUID: 90920305bdd44e38b8425b7b6b02ee91-20201106
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1204966392; Fri, 06 Nov 2020 14:10:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:10:22 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:10:20 +0800
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
        <linux-mediatek@lists.infradead.org>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 16/17] phy: tegra: convert to devm_platform_ioremap_resource(_byname)
Date:   Fri, 6 Nov 2020 14:08:49 +0800
Message-ID: <1604642930-29019-16-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 52AC62223D6A58C1141D2B11B17D5F423BD0D094CBA3439EF0BF2F6F9F23FAA42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShfYnluYW1lKSB0byBzaW1wbGlmeSBj
b2RlDQoNCkNjOiBKQyBLdW8gPGpja3VvQG52aWRpYS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBubyBjaGFuZ2Vz
DQotLS0NCiBkcml2ZXJzL3BoeS90ZWdyYS9waHktdGVncmExOTQtcDJ1LmMgfCA0ICstLS0NCiBk
cml2ZXJzL3BoeS90ZWdyYS94dXNiLmMgICAgICAgICAgICAgfCA0ICstLS0NCiAyIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGh5L3RlZ3JhL3BoeS10ZWdyYTE5NC1wMnUuYyBiL2RyaXZlcnMvcGh5L3RlZ3JhL3Bo
eS10ZWdyYTE5NC1wMnUuYw0KaW5kZXggNzA0MmJlZDlmZWFhLi4zZWUwMmI5ZWIwNGYgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3BoeS90ZWdyYS9waHktdGVncmExOTQtcDJ1LmMNCisrKyBiL2RyaXZl
cnMvcGh5L3RlZ3JhL3BoeS10ZWdyYTE5NC1wMnUuYw0KQEAgLTcyLDE0ICs3MiwxMiBAQCBzdGF0
aWMgaW50IHRlZ3JhX3AydV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KIAlzdHJ1Y3QgcGh5ICpnZW5lcmljX3Bo
eTsNCiAJc3RydWN0IHRlZ3JhX3AydSAqcGh5Ow0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAN
CiAJcGh5ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwaHkpLCBHRlBfS0VSTkVMKTsNCiAJ
aWYgKCFwaHkpDQogCQlyZXR1cm4gLUVOT01FTTsNCiANCi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwgImN0bCIpOw0KLQlwaHktPmJhc2Ug
PSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwlwaHktPmJhc2UgPSBkZXZtX3Bs
YXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsICJjdGwiKTsNCiAJaWYgKElTX0VS
UihwaHktPmJhc2UpKQ0KIAkJcmV0dXJuIFBUUl9FUlIocGh5LT5iYXNlKTsNCiANCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BoeS90ZWdyYS94dXNiLmMgYi9kcml2ZXJzL3BoeS90ZWdyYS94dXNiLmMN
CmluZGV4IGRlNGE0NmZlMTc2My4uMDY3ZTcxMzI2ODI2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9w
aHkvdGVncmEveHVzYi5jDQorKysgYi9kcml2ZXJzL3BoeS90ZWdyYS94dXNiLmMNCkBAIC0xMTQ4
LDcgKzExNDgsNiBAQCBzdGF0aWMgaW50IHRlZ3JhX3h1c2JfcGFkY3RsX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWNvbnN0IHN0cnVjdCB0ZWdyYV94dXNiX3BhZGN0bF9z
b2MgKnNvYzsNCiAJc3RydWN0IHRlZ3JhX3h1c2JfcGFkY3RsICpwYWRjdGw7DQogCWNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoOw0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJaW50
IGVycjsNCiANCiAJLyogZm9yIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHdpdGggb2xkIGRldmlj
ZSB0cmVlcyAqLw0KQEAgLTExNzMsOCArMTE3Miw3IEBAIHN0YXRpYyBpbnQgdGVncmFfeHVzYl9w
YWRjdGxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJSU5JVF9MSVNUX0hF
QUQoJnBhZGN0bC0+cGFkcyk7DQogCW11dGV4X2luaXQoJnBhZGN0bC0+bG9jayk7DQogDQotCXJl
cyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQotCXBh
ZGN0bC0+cmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0KKwlw
YWRjdGwtPnJlZ3MgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQog
CWlmIChJU19FUlIocGFkY3RsLT5yZWdzKSkgew0KIAkJZXJyID0gUFRSX0VSUihwYWRjdGwtPnJl
Z3MpOw0KIAkJZ290byByZW1vdmU7DQotLSANCjIuMTguMA0K

