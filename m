Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817882A8F3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgKFGLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:11:02 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:52157 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726306AbgKFGLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:11:02 -0500
X-UUID: c76bef7013e04e5db29008c1e9d58bd8-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SZ/bmiQ31xaUdPCdAKSj0fT+ct7Qr3u27vV3q/CfUUI=;
        b=KjhXO7Q9WxrbEK6YNhfZlPbqbOoQzNIKbeIbxN7YoQsEk8SdFv0cV2xBHb2UH2ItvDrGu3NlQoxkrEJb5t29nyUcYz5SjzZz2Kmni8XzYyGu+lfbsjo+/I1UJVWaJbwdHKCLJFXLyYugOJ5bfsvDJbwNb24WGXPT71t1BDs7QLQ=;
X-UUID: c76bef7013e04e5db29008c1e9d58bd8-20201106
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 318759687; Fri, 06 Nov 2020 14:09:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:49 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:48 +0800
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
Subject: [PATCH v2 10/17] phy: qualcomm: convert to devm_platform_ioremap_resource(_byname)
Date:   Fri, 6 Nov 2020 14:08:43 +0800
Message-ID: <1604642930-29019-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2C7404545813924BCDB9CF82E2506933C885144DAB531D918CBFB360B05661F72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShfYnluYW1lKSB0byBzaW1wbGlmeSBj
b2RlDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L3F1YWxjb21tL3Bo
eS1xY29tLWFwcTgwNjQtc2F0YS5jIHwgNCArLS0tDQogZHJpdmVycy9waHkvcXVhbGNvbW0vcGh5
LXFjb20taXBxNDAxOS11c2IuYyAgfCA0ICstLS0NCiBkcml2ZXJzL3BoeS9xdWFsY29tbS9waHkt
cWNvbS1pcHE4MDZ4LXNhdGEuYyB8IDQgKy0tLQ0KIGRyaXZlcnMvcGh5L3F1YWxjb21tL3BoeS1x
Y29tLXBjaWUyLmMgICAgICAgIHwgNSArLS0tLQ0KIGRyaXZlcnMvcGh5L3F1YWxjb21tL3BoeS1x
Y29tLXF1c2IyLmMgICAgICAgIHwgNCArLS0tDQogNSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvcXVhbGNv
bW0vcGh5LXFjb20tYXBxODA2NC1zYXRhLmMgYi9kcml2ZXJzL3BoeS9xdWFsY29tbS9waHktcWNv
bS1hcHE4MDY0LXNhdGEuYw0KaW5kZXggY2U5MWFlN2Y4ZGJkLi5kNDM3YTI0OWNkNzMgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3BoeS9xdWFsY29tbS9waHktcWNvbS1hcHE4MDY0LXNhdGEuYw0KKysr
IGIvZHJpdmVycy9waHkvcXVhbGNvbW0vcGh5LXFjb20tYXBxODA2NC1zYXRhLmMNCkBAIC0yMDEs
NyArMjAxLDYgQEAgc3RhdGljIGludCBxY29tX2FwcTgwNjRfc2F0YV9waHlfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCXN0cnVjdCBxY29tX2FwcTgwNjRfc2F0YV9w
aHkgKnBoeTsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCi0Jc3RydWN0IHJl
c291cmNlICpyZXM7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRlcjsNCiAJc3Ry
dWN0IHBoeSAqZ2VuZXJpY19waHk7DQogCWludCByZXQ7DQpAQCAtMjEwLDggKzIwOSw3IEBAIHN0
YXRpYyBpbnQgcWNvbV9hcHE4MDY0X3NhdGFfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogCWlmICghcGh5KQ0KIAkJcmV0dXJuIC1FTk9NRU07DQogDQotCXJlcyA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQotCXBoeS0+bW1p
byA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQorCXBoeS0+bW1pbyA9IGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCiAJaWYgKElTX0VSUihwaHktPm1t
aW8pKQ0KIAkJcmV0dXJuIFBUUl9FUlIocGh5LT5tbWlvKTsNCiANCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3BoeS9xdWFsY29tbS9waHktcWNvbS1pcHE0MDE5LXVzYi5jIGIvZHJpdmVycy9waHkvcXVh
bGNvbW0vcGh5LXFjb20taXBxNDAxOS11c2IuYw0KaW5kZXggZmM3ZjlkZjgwYTdiLi5kM2U3ZDVl
MWQxYjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9xdWFsY29tbS9waHktcWNvbS1pcHE0MDE5
LXVzYi5jDQorKysgYi9kcml2ZXJzL3BoeS9xdWFsY29tbS9waHktcWNvbS1pcHE0MDE5LXVzYi5j
DQpAQCAtOTUsNyArOTUsNiBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpcHE0MDE5X3VzYl9w
aHlfb2ZfbWF0Y2gpOw0KIHN0YXRpYyBpbnQgaXBxNDAxOV91c2JfcGh5X3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+
ZGV2Ow0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJc3RydWN0IHBoeV9wcm92aWRlciAqcGh5
X3Byb3ZpZGVyOw0KIAlzdHJ1Y3QgaXBxNDAxOV91c2JfcGh5ICpwaHk7DQogDQpAQCAtMTA0LDgg
KzEwMyw3IEBAIHN0YXRpYyBpbnQgaXBxNDAxOV91c2JfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQogCQlyZXR1cm4gLUVOT01FTTsNCiANCiAJcGh5LT5kZXYgPSAmcGRl
di0+ZGV2Ow0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9N
RU0sIDApOw0KLQlwaHktPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwg
cmVzKTsNCisJcGh5LT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYs
IDApOw0KIAlpZiAoSVNfRVJSKHBoeS0+YmFzZSkpIHsNCiAJCWRldl9lcnIoZGV2LCAiZmFpbGVk
IHRvIHJlbWFwIHJlZ2lzdGVyIG1lbW9yeVxuIik7DQogCQlyZXR1cm4gUFRSX0VSUihwaHktPmJh
c2UpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3F1YWxjb21tL3BoeS1xY29tLWlwcTgwNngt
c2F0YS5jIGIvZHJpdmVycy9waHkvcXVhbGNvbW0vcGh5LXFjb20taXBxODA2eC1zYXRhLmMNCmlu
ZGV4IDQxYTY5ZjU2YjM0Ni4uMGZjMmExZWQzOWIzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkv
cXVhbGNvbW0vcGh5LXFjb20taXBxODA2eC1zYXRhLmMNCisrKyBiL2RyaXZlcnMvcGh5L3F1YWxj
b21tL3BoeS1xY29tLWlwcTgwNngtc2F0YS5jDQpAQCAtMTI4LDcgKzEyOCw2IEBAIHN0YXRpYyBp
bnQgcWNvbV9pcHE4MDZ4X3NhdGFfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQogew0KIAlzdHJ1Y3QgcWNvbV9pcHE4MDZ4X3NhdGFfcGh5ICpwaHk7DQogCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQotCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KIAlzdHJ1
Y3QgcGh5X3Byb3ZpZGVyICpwaHlfcHJvdmlkZXI7DQogCXN0cnVjdCBwaHkgKmdlbmVyaWNfcGh5
Ow0KIAlpbnQgcmV0Ow0KQEAgLTEzNyw4ICsxMzYsNyBAQCBzdGF0aWMgaW50IHFjb21faXBxODA2
eF9zYXRhX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoIXBo
eSkNCiAJCXJldHVybiAtRU5PTUVNOw0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQlwaHktPm1taW8gPSBkZXZtX2lvcmVtYXBfcmVz
b3VyY2UoZGV2LCByZXMpOw0KKwlwaHktPm1taW8gPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVz
b3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIocGh5LT5tbWlvKSkNCiAJCXJldHVybiBQVFJf
RVJSKHBoeS0+bW1pbyk7DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvcXVhbGNvbW0vcGh5
LXFjb20tcGNpZTIuYyBiL2RyaXZlcnMvcGh5L3F1YWxjb21tL3BoeS1xY29tLXBjaWUyLmMNCmlu
ZGV4IDlkYmEzNTk0ZTZkOS4uNTQwN2U1OWJiMTg1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkv
cXVhbGNvbW0vcGh5LXFjb20tcGNpZTIuYw0KKysrIGIvZHJpdmVycy9waHkvcXVhbGNvbW0vcGh5
LXFjb20tcGNpZTIuYw0KQEAgLTI1MCw3ICsyNTAsNiBAQCBzdGF0aWMgaW50IHFjb21fcGNpZTJf
cGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgcGh5
X3Byb3ZpZGVyICpwaHlfcHJvdmlkZXI7DQogCXN0cnVjdCBxY29tX3BoeSAqcXBoeTsNCi0Jc3Ry
dWN0IHJlc291cmNlICpyZXM7DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQog
CXN0cnVjdCBwaHkgKnBoeTsNCiAJaW50IHJldDsNCkBAIC0yNjAsOSArMjU5LDcgQEAgc3RhdGlj
IGludCBxY29tX3BjaWUyX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
IAkJcmV0dXJuIC1FTk9NRU07DQogDQogCXFwaHktPmRldiA9IGRldjsNCi0NCi0JcmVzID0gcGxh
dGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0JcXBoeS0+YmFz
ZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQorCXFwaHktPmJhc2UgPSBkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIocXBoeS0+
YmFzZSkpDQogCQlyZXR1cm4gUFRSX0VSUihxcGh5LT5iYXNlKTsNCiANCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3BoeS9xdWFsY29tbS9waHktcWNvbS1xdXNiMi5jIGIvZHJpdmVycy9waHkvcXVhbGNv
bW0vcGh5LXFjb20tcXVzYjIuYw0KaW5kZXggNTU3NTQ3ZGFiZmQ1Li4xMDk3OTIyMDNiYWYgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9xdWFsY29tbS9waHktcWNvbS1xdXNiMi5jDQorKysgYi9k
cml2ZXJzL3BoeS9xdWFsY29tbS9waHktcWNvbS1xdXNiMi5jDQpAQCAtODQ0LDcgKzg0NCw2IEBA
IHN0YXRpYyBpbnQgcXVzYjJfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQogCXN0cnVjdCBxdXNiMl9waHkgKnFwaHk7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9w
cm92aWRlcjsNCiAJc3RydWN0IHBoeSAqZ2VuZXJpY19waHk7DQotCXN0cnVjdCByZXNvdXJjZSAq
cmVzOw0KIAlpbnQgcmV0LCBpOw0KIAlpbnQgbnVtOw0KIAl1MzIgdmFsdWU7DQpAQCAtODU1LDgg
Kzg1NCw3IEBAIHN0YXRpYyBpbnQgcXVzYjJfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogCQlyZXR1cm4gLUVOT01FTTsNCiAJb3IgPSAmcXBoeS0+b3ZlcnJpZGVzOw0K
IA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDAp
Ow0KLQlxcGh5LT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCisJcXBo
eS0+YmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCiAJaWYg
KElTX0VSUihxcGh5LT5iYXNlKSkNCiAJCXJldHVybiBQVFJfRVJSKHFwaHktPmJhc2UpOw0KIA0K
LS0gDQoyLjE4LjANCg==

