Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7472A8F2B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKFGJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:09:46 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:43261 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbgKFGJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:09:43 -0500
X-UUID: da6da30c44cb4092966d81f697bdca1a-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PweRil4FFXPbptar9sORCDNrEH/q2CV86YV9ivzFLXw=;
        b=TZ6sBLA1dnLq8sGSEw0mEGiubu/bRI1nC6etK9YzHTaLMkk2Xx04V0otxpZlNiKAKgMT2fLQGVFWp4nM3ad77MiKjxQagebdr63ZClcPhKHtyPiJ6aHqGDPlwjECobAojbAHxP9/PthTgQD6WRZrMUhdw7UXGZJs4BK9IyISgik=;
X-UUID: da6da30c44cb4092966d81f697bdca1a-20201106
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 130756316; Fri, 06 Nov 2020 14:09:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:33 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:31 +0800
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
Subject: [PATCH v2 04/17] phy: cadence: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:37 +0800
Message-ID: <1604642930-29019-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1D7021FA13D9EDDDCEEA66B61BD5DE3F67C44FCBEE3775403F780CB4CB5B31672000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCkFj
a2VkLWJ5OiBQZXRlciBDaGVuIDxwZXRlci5jaGVuQG54cC5jb20+DQotLS0NCnYyOiBhZGQgQWNr
ZWQtYnkgUGV0ZXINCi0tLQ0KIGRyaXZlcnMvcGh5L2NhZGVuY2UvY2Rucy1kcGh5LmMgICAgICAg
ICAgfCA0ICstLS0NCiBkcml2ZXJzL3BoeS9jYWRlbmNlL3BoeS1jYWRlbmNlLXNhbHZvLmMgIHwg
NCArLS0tDQogZHJpdmVycy9waHkvY2FkZW5jZS9waHktY2FkZW5jZS1zaWVycmEuYyB8IDQgKy0t
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvY2FkZW5jZS9jZG5zLWRwaHkuYyBiL2RyaXZlcnMvcGh5
L2NhZGVuY2UvY2Rucy1kcGh5LmMNCmluZGV4IDkwYzRlOWI1YWFjOC4uYmEwNDJlMzljZmFmIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9waHkvY2FkZW5jZS9jZG5zLWRwaHkuYw0KKysrIGIvZHJpdmVy
cy9waHkvY2FkZW5jZS9jZG5zLWRwaHkuYw0KQEAgLTMxNCw3ICszMTQsNiBAQCBzdGF0aWMgaW50
IGNkbnNfZHBoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCiAJc3Ry
dWN0IHBoeV9wcm92aWRlciAqcGh5X3Byb3ZpZGVyOw0KIAlzdHJ1Y3QgY2Ruc19kcGh5ICpkcGh5
Ow0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJaW50IHJldDsNCiANCiAJZHBoeSA9IGRldm1f
a3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKmRwaHkpLCBHRlBfS0VSTkVMKTsNCkBAIC0zMjYs
OCArMzI1LDcgQEAgc3RhdGljIGludCBjZG5zX2RwaHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCiAJaWYgKCFkcGh5LT5vcHMpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCi0J
cmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0J
ZHBoeS0+cmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0KKwlk
cGh5LT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KIAlp
ZiAoSVNfRVJSKGRwaHktPnJlZ3MpKQ0KIAkJcmV0dXJuIFBUUl9FUlIoZHBoeS0+cmVncyk7DQog
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvY2FkZW5jZS9waHktY2FkZW5jZS1zYWx2by5jIGIv
ZHJpdmVycy9waHkvY2FkZW5jZS9waHktY2FkZW5jZS1zYWx2by5jDQppbmRleCA4OGUyMzlhZGMz
YjguLjUxYzBiOThmNWZkNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGh5L2NhZGVuY2UvcGh5LWNh
ZGVuY2Utc2Fsdm8uYw0KKysrIGIvZHJpdmVycy9waHkvY2FkZW5jZS9waHktY2FkZW5jZS1zYWx2
by5jDQpAQCAtMjYzLDcgKzI2Myw2IEBAIHN0YXRpYyBpbnQgY2Ruc19zYWx2b19waHlfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJc3RydWN0IHBoeV9wcm92aWRlciAqcGh5
X3Byb3ZpZGVyOw0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KIAlzdHJ1Y3Qg
Y2Ruc19zYWx2b19waHkgKnNhbHZvX3BoeTsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCWNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoOw0KIAlzdHJ1Y3QgY2Ruc19zYWx2b19kYXRh
ICpkYXRhOw0KIA0KQEAgLTI4MSw4ICsyODAsNyBAQCBzdGF0aWMgaW50IGNkbnNfc2Fsdm9fcGh5
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWlmIChJU19FUlIoc2Fsdm9f
cGh5LT5jbGspKQ0KIAkJcmV0dXJuIFBUUl9FUlIoc2Fsdm9fcGh5LT5jbGspOw0KIA0KLQlyZXMg
PSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQlzYWx2
b19waHktPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwlzYWx2b19w
aHktPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlm
IChJU19FUlIoc2Fsdm9fcGh5LT5iYXNlKSkNCiAJCXJldHVybiBQVFJfRVJSKHNhbHZvX3BoeS0+
YmFzZSk7DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvY2FkZW5jZS9waHktY2FkZW5jZS1z
aWVycmEuYyBiL2RyaXZlcnMvcGh5L2NhZGVuY2UvcGh5LWNhZGVuY2Utc2llcnJhLmMNCmluZGV4
IDQ1M2VmMjZmYTFjNy4uMjZhMGJhZGFiZTM4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvY2Fk
ZW5jZS9waHktY2FkZW5jZS1zaWVycmEuYw0KKysrIGIvZHJpdmVycy9waHkvY2FkZW5jZS9waHkt
Y2FkZW5jZS1zaWVycmEuYw0KQEAgLTQ3OSw3ICs0NzksNiBAQCBzdGF0aWMgaW50IGNkbnNfc2ll
cnJhX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAljb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaDsNCiAJc3RydWN0IGNkbnNfc2llcnJhX2RhdGEgKmRhdGE7
DQogCXVuc2lnbmVkIGludCBpZF92YWx1ZTsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCWlu
dCBpLCByZXQsIG5vZGUgPSAwOw0KIAl2b2lkIF9faW9tZW0gKmJhc2U7DQogCXN0cnVjdCBjbGsg
KmNsazsNCkBAIC01MDIsOCArNTAxLDcgQEAgc3RhdGljIGludCBjZG5zX3NpZXJyYV9waHlfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJc3AtPmRldiA9IGRldjsNCiAJc3At
PmluaXRfZGF0YSA9IGRhdGE7DQogDQotCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgMCk7DQotCWJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2
LCByZXMpOw0KKwliYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAp
Ow0KIAlpZiAoSVNfRVJSKGJhc2UpKSB7DQogCQlkZXZfZXJyKGRldiwgIm1pc3NpbmcgXCJyZWdc
IlxuIik7DQogCQlyZXR1cm4gUFRSX0VSUihiYXNlKTsNCi0tIA0KMi4xOC4wDQo=

