Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D964D2A8F33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKFGKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:10:11 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:24706 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726274AbgKFGKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:10:11 -0500
X-UUID: 6fb65ccfaca94e51aadf48b7cc52076e-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RAGgnDBBxlUMea+BLDILWdxtJ1+gnngFehm4heLDSX0=;
        b=RxBwi26iQurE18reZ7omv2YDBE2t6EKWSd2tKP31TEvCDmhOeZZjb2rWdIzorgWASQMSN5pgayh0QPm4dOIVaAc94Evdut/LzZc8D+eqQo/2Zzv4g6Yxt+t4weFTtJPhQLdzWKKlS4dlaXsFwJXLi8MZmQRlBfH7v2463b+YJmI=;
X-UUID: 6fb65ccfaca94e51aadf48b7cc52076e-20201106
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1773171261; Fri, 06 Nov 2020 14:10:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:10:02 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:54 +0800
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
Subject: [PATCH v2 12/17] phy: renesas: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:45 +0800
Message-ID: <1604642930-29019-12-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 32FD6B92CE71D460B2062F12CC7764D56DBEC637CAE1AB0F201200AE9749D5DE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L3JlbmVzYXMvcGh5LXJjYXItZ2Vu
Mi5jICAgICAgfCA0ICstLS0NCiBkcml2ZXJzL3BoeS9yZW5lc2FzL3BoeS1yY2FyLWdlbjMtcGNp
ZS5jIHwgNCArLS0tDQogZHJpdmVycy9waHkvcmVuZXNhcy9waHktcmNhci1nZW4zLXVzYjIuYyB8
IDQgKy0tLQ0KIGRyaXZlcnMvcGh5L3JlbmVzYXMvcGh5LXJjYXItZ2VuMy11c2IzLmMgfCA0ICst
LS0NCiA0IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9yZW5lc2FzL3BoeS1yY2FyLWdlbjIuYyBiL2RyaXZl
cnMvcGh5L3JlbmVzYXMvcGh5LXJjYXItZ2VuMi5jDQppbmRleCAyZTI3OWFjMGZhNGQuLmMzNzVh
NDY3NmEzZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGh5L3JlbmVzYXMvcGh5LXJjYXItZ2VuMi5j
DQorKysgYi9kcml2ZXJzL3BoeS9yZW5lc2FzL3BoeS1yY2FyLWdlbjIuYw0KQEAgLTMzOSw3ICsz
MzksNiBAQCBzdGF0aWMgaW50IHJjYXJfZ2VuMl9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCiAJc3RydWN0IHJjYXJfZ2VuMl9waHlfZHJpdmVyICpkcnY7DQogCXN0cnVj
dCBwaHlfcHJvdmlkZXIgKnByb3ZpZGVyOw0KIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KLQlz
dHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJdm9pZCBfX2lvbWVtICpiYXNlOw0KIAlzdHJ1Y3QgY2xr
ICpjbGs7DQogCWNvbnN0IHN0cnVjdCByY2FyX2dlbjJfcGh5X2RhdGEgKmRhdGE7DQpAQCAtMzU3
LDggKzM1Niw3IEBAIHN0YXRpYyBpbnQgcmNhcl9nZW4yX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIFBUUl9FUlIoY2xrKTsNCiAJfQ0KIA0KLQlyZXMg
PSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQliYXNl
ID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCisJYmFzZSA9IGRldm1fcGxhdGZv
cm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCiAJaWYgKElTX0VSUihiYXNlKSkNCiAJCXJl
dHVybiBQVFJfRVJSKGJhc2UpOw0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3JlbmVzYXMv
cGh5LXJjYXItZ2VuMy1wY2llLmMgYi9kcml2ZXJzL3BoeS9yZW5lc2FzL3BoeS1yY2FyLWdlbjMt
cGNpZS5jDQppbmRleCBjNGU0YWEyMTY5MzYuLjRkYzcyMWViOTU3NyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvcGh5L3JlbmVzYXMvcGh5LXJjYXItZ2VuMy1wY2llLmMNCisrKyBiL2RyaXZlcnMvcGh5
L3JlbmVzYXMvcGh5LXJjYXItZ2VuMy1wY2llLmMNCkBAIC03Niw3ICs3Niw2IEBAIHN0YXRpYyBp
bnQgcmNhcl9nZW4zX3BoeV9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQogCXN0cnVjdCBwaHlfcHJvdmlk
ZXIgKnByb3ZpZGVyOw0KIAlzdHJ1Y3QgcmNhcl9nZW4zX3BoeSAqcGh5Ow0KLQlzdHJ1Y3QgcmVz
b3VyY2UgKnJlczsNCiAJdm9pZCBfX2lvbWVtICpiYXNlOw0KIAlpbnQgZXJyb3I7DQogDQpAQCAt
ODYsOCArODUsNyBAQCBzdGF0aWMgaW50IHJjYXJfZ2VuM19waHlfcGNpZV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiANCi0JcmVz
ID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0JYmFz
ZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQorCWJhc2UgPSBkZXZtX3BsYXRm
b3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIoYmFzZSkpDQogCQly
ZXR1cm4gUFRSX0VSUihiYXNlKTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9yZW5lc2Fz
L3BoeS1yY2FyLWdlbjMtdXNiMi5jIGIvZHJpdmVycy9waHkvcmVuZXNhcy9waHktcmNhci1nZW4z
LXVzYjIuYw0KaW5kZXggZTM0ZTQ0NzUwMjdjLi4xODk4YmJlN2M4ZTUgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3BoeS9yZW5lc2FzL3BoeS1yY2FyLWdlbjMtdXNiMi5jDQorKysgYi9kcml2ZXJzL3Bo
eS9yZW5lc2FzL3BoeS1yY2FyLWdlbjMtdXNiMi5jDQpAQCAtNjExLDcgKzYxMSw2IEBAIHN0YXRp
YyBpbnQgcmNhcl9nZW4zX3BoeV91c2IyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQogCXN0cnVjdCByY2FyX2dl
bjNfY2hhbiAqY2hhbm5lbDsNCiAJc3RydWN0IHBoeV9wcm92aWRlciAqcHJvdmlkZXI7DQotCXN0
cnVjdCByZXNvdXJjZSAqcmVzOw0KIAljb25zdCBzdHJ1Y3QgcGh5X29wcyAqcGh5X3VzYjJfb3Bz
Ow0KIAlpbnQgcmV0ID0gMCwgaTsNCiANCkBAIC02MjQsOCArNjIzLDcgQEAgc3RhdGljIGludCBy
Y2FyX2dlbjNfcGh5X3VzYjJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJ
aWYgKCFjaGFubmVsKQ0KIAkJcmV0dXJuIC1FTk9NRU07DQogDQotCXJlcyA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQotCWNoYW5uZWwtPmJhc2UgPSBk
ZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwljaGFubmVsLT5iYXNlID0gZGV2bV9w
bGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KIAlpZiAoSVNfRVJSKGNoYW5uZWwt
PmJhc2UpKQ0KIAkJcmV0dXJuIFBUUl9FUlIoY2hhbm5lbC0+YmFzZSk7DQogDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9waHkvcmVuZXNhcy9waHktcmNhci1nZW4zLXVzYjMuYyBiL2RyaXZlcnMvcGh5
L3JlbmVzYXMvcGh5LXJjYXItZ2VuMy11c2IzLmMNCmluZGV4IDU2NmI0Y2Y0ZmYzOC4uZjI3ZDZm
NDcxNjI5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvcmVuZXNhcy9waHktcmNhci1nZW4zLXVz
YjMuYw0KKysrIGIvZHJpdmVycy9waHkvcmVuZXNhcy9waHktcmNhci1nZW4zLXVzYjMuYw0KQEAg
LTEzMyw3ICsxMzMsNiBAQCBzdGF0aWMgaW50IHJjYXJfZ2VuM19waHlfdXNiM19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+
ZGV2Ow0KIAlzdHJ1Y3QgcmNhcl9nZW4zX3VzYjMgKnI7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIg
KnByb3ZpZGVyOw0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJaW50IHJldCA9IDA7DQogCXN0
cnVjdCBjbGsgKmNsazsNCiANCkBAIC0xNDYsOCArMTQ1LDcgQEAgc3RhdGljIGludCByY2FyX2dl
bjNfcGh5X3VzYjNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKCFy
KQ0KIAkJcmV0dXJuIC1FTk9NRU07DQogDQotCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQotCXItPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3Vy
Y2UoZGV2LCByZXMpOw0KKwlyLT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNl
KHBkZXYsIDApOw0KIAlpZiAoSVNfRVJSKHItPmJhc2UpKQ0KIAkJcmV0dXJuIFBUUl9FUlIoci0+
YmFzZSk7DQogDQotLSANCjIuMTguMA0K

