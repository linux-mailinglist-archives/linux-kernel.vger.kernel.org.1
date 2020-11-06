Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504C72A8F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKFGJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:09:53 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:57034 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726241AbgKFGJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:09:50 -0500
X-UUID: 606cfe2c69fe4fa88821e250a4207f40-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hHePrxz5/N/IKVqvcGZCe9swAjMl2cJVBXsFNc5Mopg=;
        b=S6iyqS4LkHAfsHJsUr86qQs9yEzUVgp1a6//ZPoTsdokhiSzpQrmVRHlwI+idEY+dsPFjL9I8qFzw0lJy9T1zCDg5t7ItpPb40svmrtKwYk3EkC450QKmmj86OdkYjnNEpvyDIn0IGWDpGtXrnD3XkuEoZQo4IIOguIOfeJ/Oe4=;
X-UUID: 606cfe2c69fe4fa88821e250a4207f40-20201106
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1252257986; Fri, 06 Nov 2020 14:09:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:41 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:39 +0800
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
Subject: [PATCH v2 07/17] phy: marvell: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:40 +0800
Message-ID: <1604642930-29019-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 560F24EEC0310DBD1D67BC45329273076EEEA38311B89C3D5597AFE4FEAA59A02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L21hcnZlbGwvcGh5LWFybWFkYTM3
NS11c2IyLmMgfCA0ICstLS0NCiBkcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1iZXJsaW4tdXNiLmMg
ICAgIHwgNCArLS0tDQogZHJpdmVycy9waHkvbWFydmVsbC9waHktbW1wMy11c2IuYyAgICAgICB8
IDQgKy0tLQ0KIGRyaXZlcnMvcGh5L21hcnZlbGwvcGh5LW12ZWJ1LXNhdGEuYyAgICAgfCA0ICst
LS0NCiBkcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1weGEtMjhubS1oc2ljLmMgIHwgNCArLS0tDQog
ZHJpdmVycy9waHkvbWFydmVsbC9waHktcHhhLTI4bm0tdXNiMi5jICB8IDQgKy0tLQ0KIGRyaXZl
cnMvcGh5L21hcnZlbGwvcGh5LXB4YS11c2IuYyAgICAgICAgfCA0ICstLS0NCiA3IGZpbGVzIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1hcm1hZGEzNzUtdXNiMi5jIGIvZHJpdmVycy9waHkvbWFy
dmVsbC9waHktYXJtYWRhMzc1LXVzYjIuYw0KaW5kZXggZmE1ZGM5NDYyZDA5Li5iMTQxZTNjZDhh
OTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1hcm1hZGEzNzUtdXNiMi5j
DQorKysgYi9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1hcm1hZGEzNzUtdXNiMi5jDQpAQCAtMTA1
LDE1ICsxMDUsMTMgQEAgc3RhdGljIGludCBhcm1hZGEzNzVfdXNiX3BoeV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlzdHJ1Y3QgcGh5ICpwaHk7DQogCXN0cnVjdCBwaHlf
cHJvdmlkZXIgKnBoeV9wcm92aWRlcjsNCiAJdm9pZCBfX2lvbWVtICp1c2JfY2x1c3Rlcl9iYXNl
Ow0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJc3RydWN0IGFybWFkYTM3NV9jbHVzdGVyX3Bo
eSAqY2x1c3Rlcl9waHk7DQogDQogCWNsdXN0ZXJfcGh5ID0gZGV2bV9remFsbG9jKGRldiwgc2l6
ZW9mKCpjbHVzdGVyX3BoeSksIEdGUF9LRVJORUwpOw0KIAlpZiAoIWNsdXN0ZXJfcGh5KQ0KIAkJ
cmV0dXJuICAtRU5PTUVNOw0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwg
SU9SRVNPVVJDRV9NRU0sIDApOw0KLQl1c2JfY2x1c3Rlcl9iYXNlID0gZGV2bV9pb3JlbWFwX3Jl
c291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQorCXVzYl9jbHVzdGVyX2Jhc2UgPSBkZXZtX3BsYXRm
b3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIodXNiX2NsdXN0ZXJf
YmFzZSkpDQogCQlyZXR1cm4gUFRSX0VSUih1c2JfY2x1c3Rlcl9iYXNlKTsNCiANCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1iZXJsaW4tdXNiLmMgYi9kcml2ZXJzL3BoeS9t
YXJ2ZWxsL3BoeS1iZXJsaW4tdXNiLmMNCmluZGV4IGE0M2RmNjMwMDdjNS4uNzhlZjZhZTcyYTlh
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvbWFydmVsbC9waHktYmVybGluLXVzYi5jDQorKysg
Yi9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1iZXJsaW4tdXNiLmMNCkBAIC0xNjUsNyArMTY1LDYg
QEAgc3RhdGljIGludCBwaHlfYmVybGluX3VzYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIAljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaCA9DQogCQlvZl9tYXRj
aF9kZXZpY2UocGh5X2Jlcmxpbl91c2Jfb2ZfbWF0Y2gsICZwZGV2LT5kZXYpOw0KIAlzdHJ1Y3Qg
cGh5X2Jlcmxpbl91c2JfcHJpdiAqcHJpdjsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCXN0
cnVjdCBwaHkgKnBoeTsNCiAJc3RydWN0IHBoeV9wcm92aWRlciAqcGh5X3Byb3ZpZGVyOw0KIA0K
QEAgLTE3Myw4ICsxNzIsNyBAQCBzdGF0aWMgaW50IHBoeV9iZXJsaW5fdXNiX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWlmICghcHJpdikNCiAJCXJldHVybiAtRU5PTUVN
Ow0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0s
IDApOw0KLQlwcml2LT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJl
cyk7DQorCXByaXYtPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwg
MCk7DQogCWlmIChJU19FUlIocHJpdi0+YmFzZSkpDQogCQlyZXR1cm4gUFRSX0VSUihwcml2LT5i
YXNlKTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tbXAzLXVzYi5j
IGIvZHJpdmVycy9waHkvbWFydmVsbC9waHktbW1wMy11c2IuYw0KaW5kZXggNDk5ODY5NTk1YTU4
Li4wNGMwYmFkYTM1MTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tbXAz
LXVzYi5jDQorKysgYi9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tbXAzLXVzYi5jDQpAQCAtMjQ2
LDcgKzI0Niw2IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG1tcDNfdXNiX3BoeV9vZl9tYXRj
aCk7DQogc3RhdGljIGludCBtbXAzX3VzYl9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCiB7DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQotCXN0cnVj
dCByZXNvdXJjZSAqcmVzb3VyY2U7DQogCXN0cnVjdCBtbXAzX3VzYl9waHkgKm1tcDNfdXNiX3Bo
eTsNCiAJc3RydWN0IHBoeV9wcm92aWRlciAqcHJvdmlkZXI7DQogDQpAQCAtMjU0LDggKzI1Myw3
IEBAIHN0YXRpYyBpbnQgbW1wM191c2JfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogCWlmICghbW1wM191c2JfcGh5KQ0KIAkJcmV0dXJuIC1FTk9NRU07DQogDQotCXJl
c291cmNlID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsN
Ci0JbW1wM191c2JfcGh5LT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzb3Vy
Y2UpOw0KKwltbXAzX3VzYl9waHktPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2UocGRldiwgMCk7DQogCWlmIChJU19FUlIobW1wM191c2JfcGh5LT5iYXNlKSkgew0KIAkJZGV2
X2VycihkZXYsICJmYWlsZWQgdG8gcmVtYXAgUEhZIHJlZ3NcbiIpOw0KIAkJcmV0dXJuIFBUUl9F
UlIobW1wM191c2JfcGh5LT5iYXNlKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tYXJ2ZWxs
L3BoeS1tdmVidS1zYXRhLmMgYi9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1zYXRhLmMN
CmluZGV4IDNjMDFiNWRjZWFhZS4uNTFhNDY0NmUyOTMzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9w
aHkvbWFydmVsbC9waHktbXZlYnUtc2F0YS5jDQorKysgYi9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3Bo
eS1tdmVidS1zYXRhLmMNCkBAIC04MCw3ICs4MCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGh5
X29wcyBwaHlfbXZlYnVfc2F0YV9vcHMgPSB7DQogc3RhdGljIGludCBwaHlfbXZlYnVfc2F0YV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCiAJc3RydWN0IHBoeV9wcm92
aWRlciAqcGh5X3Byb3ZpZGVyOw0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJc3RydWN0IHBy
aXYgKnByaXY7DQogCXN0cnVjdCBwaHkgKnBoeTsNCiANCkBAIC04OCw4ICs4Nyw3IEBAIHN0YXRp
YyBpbnQgcGh5X212ZWJ1X3NhdGFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAJaWYgKCFwcml2KQ0KIAkJcmV0dXJuIC1FTk9NRU07DQogDQotCXJlcyA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQotCXByaXYtPmJhc2UgPSBkZXZt
X2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCisJcHJpdi0+YmFzZSA9IGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCiAJaWYgKElTX0VSUihwcml2LT5i
YXNlKSkNCiAJCXJldHVybiBQVFJfRVJSKHByaXYtPmJhc2UpOw0KIA0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGh5L21hcnZlbGwvcGh5LXB4YS0yOG5tLWhzaWMuYyBiL2RyaXZlcnMvcGh5L21hcnZl
bGwvcGh5LXB4YS0yOG5tLWhzaWMuYw0KaW5kZXggMzFiNDNkMmVlMzlhLi5jNWMxMDA1NjNmNTUg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1weGEtMjhubS1oc2ljLmMNCisr
KyBiL2RyaXZlcnMvcGh5L21hcnZlbGwvcGh5LXB4YS0yOG5tLWhzaWMuYw0KQEAgLTE2Miw3ICsx
NjIsNiBAQCBzdGF0aWMgaW50IG12X2hzaWNfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgcGh5X3Byb3ZpZGVyICpwaHlfcHJvdmlkZXI7DQogCXN0
cnVjdCBtdl9oc2ljX3BoeSAqbXZfcGh5Ow0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnI7DQogDQogCW12
X3BoeSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKm12X3BoeSksIEdGUF9LRVJO
RUwpOw0KIAlpZiAoIW12X3BoeSkNCkBAIC0xNzYsOCArMTc1LDcgQEAgc3RhdGljIGludCBtdl9o
c2ljX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIFBU
Ul9FUlIobXZfcGh5LT5jbGspOw0KIAl9DQogDQotCXIgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQltdl9waHktPmJhc2UgPSBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoJnBkZXYtPmRldiwgcik7DQorCW12X3BoeS0+YmFzZSA9IGRldm1fcGxhdGZvcm1f
aW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCiAJaWYgKElTX0VSUihtdl9waHktPmJhc2UpKQ0K
IAkJcmV0dXJuIFBUUl9FUlIobXZfcGh5LT5iYXNlKTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3BoeS9tYXJ2ZWxsL3BoeS1weGEtMjhubS11c2IyLmMgYi9kcml2ZXJzL3BoeS9tYXJ2ZWxsL3Bo
eS1weGEtMjhubS11c2IyLmMNCmluZGV4IGExNzVhZTkxNWYwMi4uMGIzOTBiOWQyYWUxIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9waHkvbWFydmVsbC9waHktcHhhLTI4bm0tdXNiMi5jDQorKysgYi9k
cml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1weGEtMjhubS11c2IyLmMNCkBAIC0yOTQsNyArMjk0LDYg
QEAgc3RhdGljIGludCBtdl91c2IyX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIHsNCiAJc3RydWN0IHBoeV9wcm92aWRlciAqcGh5X3Byb3ZpZGVyOw0KIAlzdHJ1Y3Qg
bXZfdXNiMl9waHkgKm12X3BoeTsNCi0Jc3RydWN0IHJlc291cmNlICpyOw0KIA0KIAltdl9waHkg
PSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCptdl9waHkpLCBHRlBfS0VSTkVMKTsN
CiAJaWYgKCFtdl9waHkpDQpAQCAtMzA4LDggKzMwNyw3IEBAIHN0YXRpYyBpbnQgbXZfdXNiMl9w
aHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCXJldHVybiBQVFJfRVJS
KG12X3BoeS0+Y2xrKTsNCiAJfQ0KIA0KLQlyID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYs
IElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0JbXZfcGh5LT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291
cmNlKCZwZGV2LT5kZXYsIHIpOw0KKwltdl9waHktPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVt
YXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIobXZfcGh5LT5iYXNlKSkNCiAJCXJl
dHVybiBQVFJfRVJSKG12X3BoeS0+YmFzZSk7DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkv
bWFydmVsbC9waHktcHhhLXVzYi5jIGIvZHJpdmVycy9waHkvbWFydmVsbC9waHktcHhhLXVzYi5j
DQppbmRleCA4N2ZmNzU1MGI5MTIuLmZmZTg4OTg5M2ZmNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
cGh5L21hcnZlbGwvcGh5LXB4YS11c2IuYw0KKysrIGIvZHJpdmVycy9waHkvbWFydmVsbC9waHkt
cHhhLXVzYi5jDQpAQCAtMjg2LDcgKzI4Niw2IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHB4
YV91c2JfcGh5X29mX21hdGNoKTsNCiBzdGF0aWMgaW50IHB4YV91c2JfcGh5X3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRl
di0+ZGV2Ow0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlc291cmNlOw0KIAlzdHJ1Y3QgcHhhX3VzYl9w
aHkgKnB4YV91c2JfcGh5Ow0KIAlzdHJ1Y3QgcGh5X3Byb3ZpZGVyICpwcm92aWRlcjsNCiAJY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCAqb2ZfaWQ7DQpAQCAtMzAxLDggKzMwMCw3IEBAIHN0YXRp
YyBpbnQgcHhhX3VzYl9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJ
ZWxzZQ0KIAkJcHhhX3VzYl9waHktPnZlcnNpb24gPSBQWEFfVVNCX1BIWV9NTVAyOw0KIA0KLQly
ZXNvdXJjZSA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7
DQotCXB4YV91c2JfcGh5LT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzb3Vy
Y2UpOw0KKwlweGFfdXNiX3BoeS0+YmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJj
ZShwZGV2LCAwKTsNCiAJaWYgKElTX0VSUihweGFfdXNiX3BoeS0+YmFzZSkpIHsNCiAJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIHJlbWFwIFBIWSByZWdzXG4iKTsNCiAJCXJldHVybiBQVFJfRVJS
KHB4YV91c2JfcGh5LT5iYXNlKTsNCi0tIA0KMi4xOC4wDQo=

