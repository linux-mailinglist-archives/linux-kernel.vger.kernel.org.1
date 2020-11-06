Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B882A8F37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKFGK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:10:28 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:50738 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726242AbgKFGK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:10:27 -0500
X-UUID: 1b55ed1272584519a646441b1e70d0ed-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kcYJOQCUhpL0Je8ZLN8zpzjkwI1DXOb1DaBG4XizmFU=;
        b=eRZi6PWpR3VJ3M/nFI8L42HSilmwAvocbFO4EXOl8Tdrgk/0JwS4U22xLGJPW65U6rqenzGieDCPNbxgPkKPKqewb/lj1F0sp+D3FCTcTeIl1yy538y3DkWpglbG2qT/Ip4wjaG5D5QubQXlgBYhrDS4B9FsvaLIzY8IVan9BYo=;
X-UUID: 1b55ed1272584519a646441b1e70d0ed-20201106
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1716411174; Fri, 06 Nov 2020 14:10:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:10:17 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:10:08 +0800
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
Subject: [PATCH v2 14/17] phy: samsung: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:47 +0800
Message-ID: <1604642930-29019-14-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FC796B7022F1A2B384200FD8F2280FDFCAF8AABA395D4A6FE9B23C12774B49BB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NClJl
dmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQotLS0NCnYy
OiBhZGQgUmV2aWV3ZWQtYnkgS3J6eXN6dG9mDQotLS0NCiBkcml2ZXJzL3BoeS9zYW1zdW5nL3Bo
eS1leHlub3MtcGNpZS5jICAgICB8IDcgKystLS0tLQ0KIGRyaXZlcnMvcGh5L3NhbXN1bmcvcGh5
LWV4eW5vczUtdXNiZHJkLmMgIHwgNCArLS0tDQogZHJpdmVycy9waHkvc2Ftc3VuZy9waHktZXh5
bm9zNTI1MC1zYXRhLmMgfCA1ICstLS0tDQogZHJpdmVycy9waHkvc2Ftc3VuZy9waHktc2Ftc3Vu
Zy11c2IyLmMgICAgfCA0ICstLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MTUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9zYW1zdW5nL3BoeS1l
eHlub3MtcGNpZS5jIGIvZHJpdmVycy9waHkvc2Ftc3VuZy9waHktZXh5bm9zLXBjaWUuYw0KaW5k
ZXggN2UyOGIxYWVhMGQxLi5jOThmZmY1YzFhYzggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9z
YW1zdW5nL3BoeS1leHlub3MtcGNpZS5jDQorKysgYi9kcml2ZXJzL3BoeS9zYW1zdW5nL3BoeS1l
eHlub3MtcGNpZS5jDQpAQCAtMjMyLDcgKzIzMiw2IEBAIHN0YXRpYyBpbnQgZXh5bm9zX3BjaWVf
cGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXN0cnVjdCBleHlub3Nf
cGNpZV9waHkgKmV4eW5vc19waHk7DQogCXN0cnVjdCBwaHkgKmdlbmVyaWNfcGh5Ow0KIAlzdHJ1
Y3QgcGh5X3Byb3ZpZGVyICpwaHlfcHJvdmlkZXI7DQotCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0K
IAljb25zdCBzdHJ1Y3QgZXh5bm9zX3BjaWVfcGh5X2RhdGEgKmRydl9kYXRhOw0KIA0KIAlkcnZf
ZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KQEAgLTI0MywxMyArMjQyLDEx
IEBAIHN0YXRpYyBpbnQgZXh5bm9zX3BjaWVfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogCWlmICghZXh5bm9zX3BoeSkNCiAJCXJldHVybiAtRU5PTUVNOw0KIA0KLQly
ZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQll
eHlub3NfcGh5LT5waHlfYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQor
CWV4eW5vc19waHktPnBoeV9iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBk
ZXYsIDApOw0KIAlpZiAoSVNfRVJSKGV4eW5vc19waHktPnBoeV9iYXNlKSkNCiAJCXJldHVybiBQ
VFJfRVJSKGV4eW5vc19waHktPnBoeV9iYXNlKTsNCiANCi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAxKTsNCi0JZXh5bm9zX3BoeS0+YmxrX2Jhc2Ug
PSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwlleHlub3NfcGh5LT5ibGtfYmFz
ZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAxKTsNCiAJaWYgKElTX0VS
UihleHlub3NfcGh5LT5ibGtfYmFzZSkpDQogCQlyZXR1cm4gUFRSX0VSUihleHlub3NfcGh5LT5i
bGtfYmFzZSk7DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvc2Ftc3VuZy9waHktZXh5bm9z
NS11c2JkcmQuYyBiL2RyaXZlcnMvcGh5L3NhbXN1bmcvcGh5LWV4eW5vczUtdXNiZHJkLmMNCmlu
ZGV4IGNmYTliOGI3ZTVhYy4uZWUwODQ4ZmU4NDMyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkv
c2Ftc3VuZy9waHktZXh5bm9zNS11c2JkcmQuYw0KKysrIGIvZHJpdmVycy9waHkvc2Ftc3VuZy9w
aHktZXh5bm9zNS11c2JkcmQuYw0KQEAgLTgyOSw3ICs4MjksNiBAQCBzdGF0aWMgaW50IGV4eW5v
czVfdXNiZHJkX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25vZGU7DQogCXN0cnVjdCBleHlub3M1X3Vz
YmRyZF9waHkgKnBoeV9kcmQ7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRlcjsN
Ci0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCWNvbnN0IHN0cnVjdCBleHlub3M1X3VzYmRyZF9w
aHlfZHJ2ZGF0YSAqZHJ2X2RhdGE7DQogCXN0cnVjdCByZWdtYXAgKnJlZ19wbXU7DQogCXUzMiBw
bXVfb2Zmc2V0Ow0KQEAgLTg0Myw4ICs4NDIsNyBAQCBzdGF0aWMgaW50IGV4eW5vczVfdXNiZHJk
X3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlkZXZfc2V0X2RydmRh
dGEoZGV2LCBwaHlfZHJkKTsNCiAJcGh5X2RyZC0+ZGV2ID0gZGV2Ow0KIA0KLQlyZXMgPSBwbGF0
Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQlwaHlfZHJkLT5y
ZWdfcGh5ID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCisJcGh5X2RyZC0+cmVn
X3BoeSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCiAJaWYgKElT
X0VSUihwaHlfZHJkLT5yZWdfcGh5KSkNCiAJCXJldHVybiBQVFJfRVJSKHBoeV9kcmQtPnJlZ19w
aHkpOw0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3NhbXN1bmcvcGh5LWV4eW5vczUyNTAt
c2F0YS5jIGIvZHJpdmVycy9waHkvc2Ftc3VuZy9waHktZXh5bm9zNTI1MC1zYXRhLmMNCmluZGV4
IDRkZDczMjRkOTFiMi4uOWVjMjM0MjQzZjdjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvc2Ft
c3VuZy9waHktZXh5bm9zNTI1MC1zYXRhLmMNCisrKyBiL2RyaXZlcnMvcGh5L3NhbXN1bmcvcGh5
LWV4eW5vczUyNTAtc2F0YS5jDQpAQCAtMTYyLDcgKzE2Miw2IEBAIHN0YXRpYyBpbnQgZXh5bm9z
X3NhdGFfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1
Y3QgZXh5bm9zX3NhdGFfcGh5ICpzYXRhX3BoeTsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBk
ZXYtPmRldjsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIg
KnBoeV9wcm92aWRlcjsNCiAJc3RydWN0IGRldmljZV9ub2RlICpub2RlOw0KIAlpbnQgcmV0ID0g
MDsNCkBAIC0xNzEsOSArMTcwLDcgQEAgc3RhdGljIGludCBleHlub3Nfc2F0YV9waHlfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKCFzYXRhX3BoeSkNCiAJCXJldHVy
biAtRU5PTUVNOw0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNP
VVJDRV9NRU0sIDApOw0KLQ0KLQlzYXRhX3BoeS0+cmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJj
ZShkZXYsIHJlcyk7DQorCXNhdGFfcGh5LT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlKHBkZXYsIDApOw0KIAlpZiAoSVNfRVJSKHNhdGFfcGh5LT5yZWdzKSkNCiAJCXJldHVy
biBQVFJfRVJSKHNhdGFfcGh5LT5yZWdzKTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9z
YW1zdW5nL3BoeS1zYW1zdW5nLXVzYjIuYyBiL2RyaXZlcnMvcGh5L3NhbXN1bmcvcGh5LXNhbXN1
bmctdXNiMi5jDQppbmRleCBhM2VkM2ZmMDQ2OTAuLmY3OWY2MDVjZmY3OSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvcGh5L3NhbXN1bmcvcGh5LXNhbXN1bmctdXNiMi5jDQorKysgYi9kcml2ZXJzL3Bo
eS9zYW1zdW5nL3BoeS1zYW1zdW5nLXVzYjIuYw0KQEAgLTE0Myw3ICsxNDMsNiBAQCBzdGF0aWMg
aW50IHNhbXN1bmdfdXNiMl9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAJY29uc3Qgc3RydWN0IHNhbXN1bmdfdXNiMl9waHlfY29uZmlnICpjZmc7DQogCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92
aWRlcjsNCi0Jc3RydWN0IHJlc291cmNlICptZW07DQogCXN0cnVjdCBzYW1zdW5nX3VzYjJfcGh5
X2RyaXZlciAqZHJ2Ow0KIAlpbnQgaSwgcmV0Ow0KIA0KQEAgLTE2Nyw4ICsxNjYsNyBAQCBzdGF0
aWMgaW50IHNhbXN1bmdfdXNiMl9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCiAJZHJ2LT5jZmcgPSBjZmc7DQogCWRydi0+ZGV2ID0gZGV2Ow0KIA0KLQltZW0gPSBwbGF0
Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQlkcnYtPnJlZ19w
aHkgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCBtZW0pOw0KKwlkcnYtPnJlZ19waHkgPSBk
ZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIoZHJ2
LT5yZWdfcGh5KSkgew0KIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gbWFwIHJlZ2lzdGVyIG1l
bW9yeSAocGh5KVxuIik7DQogCQlyZXR1cm4gUFRSX0VSUihkcnYtPnJlZ19waHkpOw0KLS0gDQoy
LjE4LjANCg==

