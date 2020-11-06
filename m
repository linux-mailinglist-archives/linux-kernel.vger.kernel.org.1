Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D627C2A8F29
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKFGJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:09:38 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbgKFGJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:09:38 -0500
X-UUID: c5ec763de45c4015a2d18432429dafbe-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nEoLX1/+6duNwH8WrVAfgyNUeWNqni/qD+IGm5v49yw=;
        b=sa85xI0F3yJptMrG7cZA4jLfPJ89ToDm/cpSvVOd7gRmDK0HwHf7yVYxYdlHyoAzTWJTVAgcWd/nY8azNEiAts1NVH0Uxf92J24hlXLMN37KApImHhnNma4GAA1KTVEEy31TB/e+HTjCvmT4hJYv9mQrjU9J6eMSjFNTcDnWkN8=;
X-UUID: c5ec763de45c4015a2d18432429dafbe-20201106
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1538193157; Fri, 06 Nov 2020 14:09:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:25 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:24 +0800
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
Subject: [PATCH v2 01/17] phy: allwinner: convert to devm_platform_ioremap_resource(_byname)
Date:   Fri, 6 Nov 2020 14:08:34 +0800
Message-ID: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3C3951C449F6D73153743392941B122F987841F75BC64504B988C2BC4C288B302000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShfYnluYW1lKSB0byBzaW1wbGlmeSBj
b2RlDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L2FsbHdpbm5lci9w
aHktc3VuNGktdXNiLmMgICAgICAgfCA4ICsrLS0tLS0tDQogZHJpdmVycy9waHkvYWxsd2lubmVy
L3BoeS1zdW41MGktdXNiMy5jICAgICB8IDQgKy0tLQ0KIGRyaXZlcnMvcGh5L2FsbHdpbm5lci9w
aHktc3VuNmktbWlwaS1kcGh5LmMgfCA0ICstLS0NCiBkcml2ZXJzL3BoeS9hbGx3aW5uZXIvcGh5
LXN1bjlpLXVzYi5jICAgICAgIHwgNCArLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvYWxsd2lu
bmVyL3BoeS1zdW40aS11c2IuYyBiL2RyaXZlcnMvcGh5L2FsbHdpbm5lci9waHktc3VuNGktdXNi
LmMNCmluZGV4IDY1MWQ1ZTJhMjVjZS4uNDA2ZDU5NDNmOGE4IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9waHkvYWxsd2lubmVyL3BoeS1zdW40aS11c2IuYw0KKysrIGIvZHJpdmVycy9waHkvYWxsd2lu
bmVyL3BoeS1zdW40aS11c2IuYw0KQEAgLTY4Niw3ICs2ODYsNiBAQCBzdGF0aWMgaW50IHN1bjRp
X3VzYl9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJc3RydWN0IGRl
dmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCiAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+
b2Zfbm9kZTsNCiAJc3RydWN0IHBoeV9wcm92aWRlciAqcGh5X3Byb3ZpZGVyOw0KLQlzdHJ1Y3Qg
cmVzb3VyY2UgKnJlczsNCiAJaW50IGksIHJldDsNCiANCiAJZGF0YSA9IGRldm1fa3phbGxvYyhk
ZXYsIHNpemVvZigqZGF0YSksIEdGUF9LRVJORUwpOw0KQEAgLTcwMCw4ICs2OTksNyBAQCBzdGF0
aWMgaW50IHN1bjRpX3VzYl9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAJaWYgKCFkYXRhLT5jZmcpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCi0JcmVzID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwgInBoeV9jdHJsIik7
DQotCWRhdGEtPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwlkYXRh
LT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LCAicGh5
X2N0cmwiKTsNCiAJaWYgKElTX0VSUihkYXRhLT5iYXNlKSkNCiAJCXJldHVybiBQVFJfRVJSKGRh
dGEtPmJhc2UpOw0KIA0KQEAgLTc5Niw5ICs3OTQsNyBAQCBzdGF0aWMgaW50IHN1bjRpX3VzYl9w
aHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJCWlmIChpIHx8IGRh
dGEtPmNmZy0+cGh5MF9kdWFsX3JvdXRlKSB7IC8qIE5vIHBtdSBmb3IgbXVzYiAqLw0KIAkJCXNu
cHJpbnRmKG5hbWUsIHNpemVvZihuYW1lKSwgInBtdSVkIiwgaSk7DQotCQkJcmVzID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LA0KLQkJCQkJCQlJT1JFU09VUkNFX01FTSwgbmFt
ZSk7DQotCQkJcGh5LT5wbXUgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwkJ
CXBoeS0+cG11ID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LCBu
YW1lKTsNCiAJCQlpZiAoSVNfRVJSKHBoeS0+cG11KSkNCiAJCQkJcmV0dXJuIFBUUl9FUlIocGh5
LT5wbXUpOw0KIAkJfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L2FsbHdpbm5lci9waHktc3Vu
NTBpLXVzYjMuYyBiL2RyaXZlcnMvcGh5L2FsbHdpbm5lci9waHktc3VuNTBpLXVzYjMuYw0KaW5k
ZXggYjFjMDRmNzFhMzFkLi44NDA1NWI3MjAwMTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9h
bGx3aW5uZXIvcGh5LXN1bjUwaS11c2IzLmMNCisrKyBiL2RyaXZlcnMvcGh5L2FsbHdpbm5lci9w
aHktc3VuNTBpLXVzYjMuYw0KQEAgLTEzNCw3ICsxMzQsNiBAQCBzdGF0aWMgaW50IHN1bjUwaV91
c2IzX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlzdHJ1Y3Qgc3Vu
NTBpX3VzYjNfcGh5ICpwaHk7DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQog
CXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRlcjsNCi0Jc3RydWN0IHJlc291cmNlICpy
ZXM7DQogDQogCXBoeSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqcGh5KSwgR0ZQX0tFUk5F
TCk7DQogCWlmICghcGh5KQ0KQEAgLTE1Myw4ICsxNTIsNyBAQCBzdGF0aWMgaW50IHN1bjUwaV91
c2IzX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIFBU
Ul9FUlIocGh5LT5yZXNldCk7DQogCX0NCiANCi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNl
KHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0JcGh5LT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jl
c291cmNlKGRldiwgcmVzKTsNCisJcGh5LT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlKHBkZXYsIDApOw0KIAlpZiAoSVNfRVJSKHBoeS0+cmVncykpDQogCQlyZXR1cm4gUFRS
X0VSUihwaHktPnJlZ3MpOw0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L2FsbHdpbm5lci9w
aHktc3VuNmktbWlwaS1kcGh5LmMgYi9kcml2ZXJzL3BoeS9hbGx3aW5uZXIvcGh5LXN1bjZpLW1p
cGktZHBoeS5jDQppbmRleCAxZmE3NjFiYTZjYmIuLmYwYmM4N2Q2NTRkNCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvcGh5L2FsbHdpbm5lci9waHktc3VuNmktbWlwaS1kcGh5LmMNCisrKyBiL2RyaXZl
cnMvcGh5L2FsbHdpbm5lci9waHktc3VuNmktbWlwaS1kcGh5LmMNCkBAIC0yNTMsMTUgKzI1Mywx
MyBAQCBzdGF0aWMgaW50IHN1bjZpX2RwaHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiB7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRlcjsNCiAJc3RydWN0
IHN1bjZpX2RwaHkgKmRwaHk7DQotCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KIAl2b2lkIF9faW9t
ZW0gKnJlZ3M7DQogDQogCWRwaHkgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpk
cGh5KSwgR0ZQX0tFUk5FTCk7DQogCWlmICghZHBoeSkNCiAJCXJldHVybiAtRU5PTUVNOw0KIA0K
LQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0K
LQlyZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQorCXJlZ3Mg
PSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIo
cmVncykpIHsNCiAJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkbid0IG1hcCB0aGUgRFBIWSBl
bmNvZGVyIHJlZ2lzdGVyc1xuIik7DQogCQlyZXR1cm4gUFRSX0VSUihyZWdzKTsNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BoeS9hbGx3aW5uZXIvcGh5LXN1bjlpLXVzYi5jIGIvZHJpdmVycy9waHkv
YWxsd2lubmVyL3BoeS1zdW45aS11c2IuYw0KaW5kZXggZmM2Nzg0ZGQ3ZmEwLi4yZjllNjBjMTg4
YjggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9hbGx3aW5uZXIvcGh5LXN1bjlpLXVzYi5jDQor
KysgYi9kcml2ZXJzL3BoeS9hbGx3aW5uZXIvcGh5LXN1bjlpLXVzYi5jDQpAQCAtMTE3LDcgKzEx
Nyw2IEBAIHN0YXRpYyBpbnQgc3VuOWlfdXNiX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KIAlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KIAlzdHJ1Y3QgcGh5X3Byb3ZpZGVyICpw
aHlfcHJvdmlkZXI7DQotCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KIA0KIAlwaHkgPSBkZXZtX2t6
YWxsb2MoZGV2LCBzaXplb2YoKnBoeSksIEdGUF9LRVJORUwpOw0KIAlpZiAoIXBoeSkNCkBAIC0x
NTYsOCArMTU1LDcgQEAgc3RhdGljIGludCBzdW45aV91c2JfcGh5X3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQl9DQogCX0NCiANCi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0JcGh5LT5wbXUgPSBkZXZtX2lvcmVt
YXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwlwaHktPnBtdSA9IGRldm1fcGxhdGZvcm1faW9yZW1h
cF9yZXNvdXJjZShwZGV2LCAwKTsNCiAJaWYgKElTX0VSUihwaHktPnBtdSkpDQogCQlyZXR1cm4g
UFRSX0VSUihwaHktPnBtdSk7DQogDQotLSANCjIuMTguMA0K

