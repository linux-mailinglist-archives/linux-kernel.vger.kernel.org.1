Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327CC19D1B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390427AbgDCIEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 04:04:08 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41509 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727431AbgDCIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:04:07 -0400
X-UUID: 62cdd6ca889f49078ab85b706985f965-20200403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SXMSLBQsSUZgUuEZUoBkJ70NApTii4m2ZG6S3nFKqQw=;
        b=ocEDhnna7MEmJFSM1HpX3cO5awiWG52jGjOfBbtvblABStTwQ/Z0Nfwy6vDGSG1gIZ2/AGYB/AC9Gkd0eW93mTcxGWFlA9b88jmVm7pOqatBRzz+V/eECnCXTTnp3Sa968z3EL5yT2ldkT7EGqpqqHW2+iVxMBRrT+62QuwSLbc=;
X-UUID: 62cdd6ca889f49078ab85b706985f965-20200403
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 487088426; Fri, 03 Apr 2020 16:03:59 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 3 Apr
 2020 16:03:59 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 3 Apr 2020 16:03:57 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v14 3/3] drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
Date:   Fri, 3 Apr 2020 16:03:50 +0800
Message-ID: <20200403080350.95826-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200403080350.95826-1-jitao.shi@mediatek.com>
References: <20200403080350.95826-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1F8009A16C3C12A076DB5621D0BD997557D38E7207AD03FA9FD39F901D19D8562000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29uZmlnIGRwaSBwaW5zIG1vZGUgdG8gb3V0cHV0IGFuZCBwdWxsIGxvdyB3aGVuIGRwaSBpcyBk
aXNhYmxlZC4NCkFvdmlkIGxlYWthZ2UgY3VycmVudCBmcm9tIHNvbWUgZHBpIHBpbnMgKEhzeW5j
IFZzeW5jIERFIC4uLiApLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwg
MzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDMxIGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQppbmRleCAwODdmNWNl
NzMyZTEuLjFlMDEyNTQ3ODhkOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCkBA
IC0xMCw3ICsxMCw5IEBADQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KICNpbmNsdWRlIDxs
aW51eC9vZi5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGlu
dXgvb2ZfZ3Bpby5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9ncmFwaC5oPg0KKyNpbmNsdWRlIDxs
aW51eC9waW5jdHJsL2NvbnN1bWVyLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rldmlj
ZS5oPg0KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KIA0KQEAgLTc0LDYgKzc2LDkgQEAgc3Ry
dWN0IG10a19kcGkgew0KIAllbnVtIG10a19kcGlfb3V0X3ljX21hcCB5Y19tYXA7DQogCWVudW0g
bXRrX2RwaV9vdXRfYml0X251bSBiaXRfbnVtOw0KIAllbnVtIG10a19kcGlfb3V0X2NoYW5uZWxf
c3dhcCBjaGFubmVsX3N3YXA7DQorCXN0cnVjdCBwaW5jdHJsICpwaW5jdHJsOw0KKwlzdHJ1Y3Qg
cGluY3RybF9zdGF0ZSAqcGluc19ncGlvOw0KKwlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19k
cGk7DQogCWludCByZWZjb3VudDsNCiB9Ow0KIA0KQEAgLTM3OSw2ICszODQsOSBAQCBzdGF0aWMg
dm9pZCBtdGtfZHBpX3Bvd2VyX29mZihzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KIAlpZiAoLS1kcGkt
PnJlZmNvdW50ICE9IDApDQogCQlyZXR1cm47DQogDQorCWlmIChkcGktPnBpbmN0cmwgJiYgZHBp
LT5waW5zX2dwaW8pDQorCQlwaW5jdHJsX3NlbGVjdF9zdGF0ZShkcGktPnBpbmN0cmwsIGRwaS0+
cGluc19ncGlvKTsNCisNCiAJbXRrX2RwaV9kaXNhYmxlKGRwaSk7DQogCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShkcGktPnBpeGVsX2Nsayk7DQogCWNsa19kaXNhYmxlX3VucHJlcGFyZShkcGktPmVu
Z2luZV9jbGspOw0KQEAgLTQwMyw2ICs0MTEsOSBAQCBzdGF0aWMgaW50IG10a19kcGlfcG93ZXJf
b24oc3RydWN0IG10a19kcGkgKmRwaSkNCiAJCWdvdG8gZXJyX3BpeGVsOw0KIAl9DQogDQorCWlm
IChkcGktPnBpbmN0cmwgJiYgZHBpLT5waW5zX2RwaSkNCisJCXBpbmN0cmxfc2VsZWN0X3N0YXRl
KGRwaS0+cGluY3RybCwgZHBpLT5waW5zX2RwaSk7DQorDQogCW10a19kcGlfZW5hYmxlKGRwaSk7
DQogCXJldHVybiAwOw0KIA0KQEAgLTcwNSw2ICs3MTYsMjYgQEAgc3RhdGljIGludCBtdGtfZHBp
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWRwaS0+ZGV2ID0gZGV2Ow0K
IAlkcGktPmNvbmYgPSAoc3RydWN0IG10a19kcGlfY29uZiAqKW9mX2RldmljZV9nZXRfbWF0Y2hf
ZGF0YShkZXYpOw0KIA0KKwlkcGktPnBpbmN0cmwgPSBkZXZtX3BpbmN0cmxfZ2V0KCZwZGV2LT5k
ZXYpOw0KKwlpZiAoSVNfRVJSKGRwaS0+cGluY3RybCkpIHsNCisJCWRwaS0+cGluY3RybCA9IE5V
TEw7DQorCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsIVxuIik7DQor
CX0NCisJaWYgKGRwaS0+cGluY3RybCkgew0KKwkJZHBpLT5waW5zX2dwaW8gPSBwaW5jdHJsX2xv
b2t1cF9zdGF0ZShkcGktPnBpbmN0cmwsICJzbGVlcCIpOw0KKwkJaWYgKElTX0VSUihkcGktPnBp
bnNfZ3BpbykpIHsNCisJCQlkcGktPnBpbnNfZ3BpbyA9IE5VTEw7DQorCQkJZGV2X2RiZygmcGRl
di0+ZGV2LCAiQ2Fubm90IGZpbmQgcGluY3RybCBpZGxlIVxuIik7DQorCQl9DQorCQlpZiAoZHBp
LT5waW5zX2dwaW8pDQorCQkJcGluY3RybF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGkt
PnBpbnNfZ3Bpbyk7DQorDQorCQlkcGktPnBpbnNfZHBpID0gcGluY3RybF9sb29rdXBfc3RhdGUo
ZHBpLT5waW5jdHJsLCAiZGVmYXVsdCIpOw0KKwkJaWYgKElTX0VSUihkcGktPnBpbnNfZHBpKSkg
ew0KKwkJCWRwaS0+cGluc19kcGkgPSBOVUxMOw0KKwkJCWRldl9kYmcoJnBkZXYtPmRldiwgIkNh
bm5vdCBmaW5kIHBpbmN0cmwgYWN0aXZlIVxuIik7DQorCQl9DQorCX0NCiAJbWVtID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJZHBpLT5yZWdzID0g
ZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgbWVtKTsNCiAJaWYgKElTX0VSUihkcGktPnJlZ3Mp
KSB7DQotLSANCjIuMjEuMA0K

