Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886E727CFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgI2NrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:47:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58281 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729840AbgI2NrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:47:00 -0400
X-UUID: 19498c3299c2498fb2b2bd4e85b87a6a-20200929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AC/DXYeU36EHPrXDYOJrO+0efcpwt/5OaRcV8VbmYaY=;
        b=uT1abKxlLs2Q7ZtYLMxjgVdqlydgrtbxMBRhfXILQ2vWIzDQXbSLtk8Rese/wBPrU319x8yrdmMwkI4eI8eoBLGNVvyL10NWOHAFq68kJoDNq55ZJobho0VqXx0d3tFcO1MukNa3IUM/2ph4P/mvhCulqA5dlnK7Mf/PYT1H3os=;
X-UUID: 19498c3299c2498fb2b2bd4e85b87a6a-20200929
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1390632934; Tue, 29 Sep 2020 21:46:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Sep 2020 21:46:51 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Sep 2020 21:46:50 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v5,2/3] reset-controller: ti: introduce a new reset handler
Date:   Tue, 29 Sep 2020 21:46:41 +0800
Message-ID: <20200929134642.26561-3-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200929134642.26561-1-crystal.guo@mediatek.com>
References: <20200929134642.26561-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW50cm9kdWNlIHRpX3N5c2Nvbl9yZXNldCgpIHRvIGludGVncmF0ZSBhc3NlcnQgYW5kIGRlYXNz
ZXJ0IHRvZ2V0aGVyLg0KSWYgc29tZSBtb2R1bGVzIG5lZWQgZG8gc2VyaWFsaXplZCBhc3NlcnQg
YW5kIGRlYXNzZXJ0IG9wZXJhdGlvbnMNCnRvIHJlc2V0IGl0c2VsZiwgcmVzZXRfY29udHJvbF9y
ZXNldCBjYW4gYmUgY2FsbGVkIGZvciBjb252ZW5pZW5jZS4NCg0KU3VjaCBhcyByZXNldC1xY29t
LWFvc3MuYywgaXQgaW50ZWdyYXRlcyBhc3NlcnQgYW5kIGRlYXNzZXJ0IHRvZ2V0aGVyDQpieSAn
cmVzZXQnIG1ldGhvZC4gTVRLIFNvY3MgYWxzbyBuZWVkIHRoaXMgbWV0aG9kIHRvIHBlcmZvcm0g
cmVzZXQuDQoNClNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0BtZWRpYXRl
ay5jb20+DQotLS0NCiBkcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jIHwgNDAgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQt
dGktc3lzY29uLmMgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jDQppbmRleCBhMjYz
NWMyMWRiN2YuLjVkMWY4MzA2Y2Q0ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcmVzZXQvcmVzZXQt
dGktc3lzY29uLmMNCisrKyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCkBAIC0x
NSwxNSArMTUsMjIgQEANCiAgKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBk
ZXRhaWxzLg0KICAqLw0KIA0KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KICNpbmNsdWRlIDxs
aW51eC9tZmQvc3lzY29uLmg+DQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRl
IDxsaW51eC9vZi5oPg0KKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KICNp
bmNsdWRlIDxsaW51eC9yZXNldC1jb250cm9sbGVyLmg+DQogDQogI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL3Jlc2V0L3RpLXN5c2Nvbi5oPg0KIA0KK3N0cnVjdCBtZWRpYXRla19yZXNldF9kYXRhIHsN
CisJdW5zaWduZWQgY2hhciAqcmVzZXRfYml0czsNCisJdW5zaWduZWQgaW50IHJlc2V0X2R1cmF0
aW9uX3VzOw0KK307DQorDQogLyoqDQogICogc3RydWN0IHRpX3N5c2Nvbl9yZXNldF9jb250cm9s
IC0gcmVzZXQgY29udHJvbCBzdHJ1Y3R1cmUNCiAgKiBAYXNzZXJ0X29mZnNldDogcmVzZXQgYXNz
ZXJ0IGNvbnRyb2wgcmVnaXN0ZXIgb2Zmc2V0IGZyb20gc3lzY29uIGJhc2UNCkBAIC01Niw2ICs2
Myw3IEBAIHN0cnVjdCB0aV9zeXNjb25fcmVzZXRfZGF0YSB7DQogCXN0cnVjdCByZWdtYXAgKnJl
Z21hcDsNCiAJc3RydWN0IHRpX3N5c2Nvbl9yZXNldF9jb250cm9sICpjb250cm9sczsNCiAJdW5z
aWduZWQgaW50IG5yX2NvbnRyb2xzOw0KKwljb25zdCBzdHJ1Y3QgbWVkaWF0ZWtfcmVzZXRfZGF0
YSAqcmVzZXRfZGF0YTsNCiB9Ow0KIA0KICNkZWZpbmUgdG9fdGlfc3lzY29uX3Jlc2V0X2RhdGEo
cmNkZXYpCVwNCkBAIC0xNTgsOSArMTY2LDI5IEBAIHN0YXRpYyBpbnQgdGlfc3lzY29uX3Jlc2V0
X3N0YXR1cyhzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KIAkJIShjb250cm9s
LT5mbGFncyAmIFNUQVRVU19TRVQpOw0KIH0NCiANCitzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNl
dChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KKwkJCQkgIHVuc2lnbmVkIGxv
bmcgaWQpDQorew0KKwlzdHJ1Y3QgdGlfc3lzY29uX3Jlc2V0X2RhdGEgKmRhdGEgPSB0b190aV9z
eXNjb25fcmVzZXRfZGF0YShyY2Rldik7DQorCWludCByZXQ7DQorDQorCWlmIChkYXRhLT5yZXNl
dF9kYXRhKSB7DQorCQlyZXQgPSB0aV9zeXNjb25fcmVzZXRfYXNzZXJ0KHJjZGV2LCBpZCk7DQor
CQlpZiAocmV0KQ0KKwkJCXJldHVybiByZXQ7DQorCQl1c2xlZXBfcmFuZ2UoZGF0YS0+cmVzZXRf
ZGF0YS0+cmVzZXRfZHVyYXRpb25fdXMsDQorCQkJZGF0YS0+cmVzZXRfZGF0YS0+cmVzZXRfZHVy
YXRpb25fdXMgKiAyKTsNCisNCisJCXJldHVybiB0aV9zeXNjb25fcmVzZXRfZGVhc3NlcnQocmNk
ZXYsIGlkKTsNCisJfSBlbHNlIHsNCisJCXJldHVybiAtRU5PVFNVUFA7DQorCX0NCit9DQorDQog
c3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyB0aV9zeXNjb25fcmVzZXRfb3Bz
ID0gew0KIAkuYXNzZXJ0CQk9IHRpX3N5c2Nvbl9yZXNldF9hc3NlcnQsDQogCS5kZWFzc2VydAk9
IHRpX3N5c2Nvbl9yZXNldF9kZWFzc2VydCwNCisJLnJlc2V0CQk9IHRpX3N5c2Nvbl9yZXNldCwN
CiAJLnN0YXR1cwkJPSB0aV9zeXNjb25fcmVzZXRfc3RhdHVzLA0KIH07DQogDQpAQCAtMTgyLDcg
KzIxMCwxMSBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoSVNfRVJSKHJlZ21hcCkpDQogCQlyZXR1cm4gUFRSX0VS
UihyZWdtYXApOw0KIA0KLQlsaXN0ID0gb2ZfZ2V0X3Byb3BlcnR5KG5wLCAidGkscmVzZXQtYml0
cyIsICZzaXplKTsNCisJZGF0YS0+cmVzZXRfZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0
YSgmcGRldi0+ZGV2KTsNCisJaWYgKGRhdGEtPnJlc2V0X2RhdGEpDQorCQlsaXN0ID0gb2ZfZ2V0
X3Byb3BlcnR5KG5wLCBkYXRhLT5yZXNldF9kYXRhLT5yZXNldF9iaXRzLCAmc2l6ZSk7DQorCWVs
c2UNCisJCWxpc3QgPSBvZl9nZXRfcHJvcGVydHkobnAsICJ0aSxyZXNldC1iaXRzIiwgJnNpemUp
Ow0KIAlpZiAoIWxpc3QgfHwgKHNpemUgLyBzaXplb2YoKmxpc3QpKSAlIDcgIT0gMCkgew0KIAkJ
ZGV2X2VycihkZXYsICJpbnZhbGlkIERUIHJlc2V0IGRlc2NyaXB0aW9uXG4iKTsNCiAJCXJldHVy
biAtRUlOVkFMOw0KQEAgLTIxNyw4ICsyNDksMTQgQEAgc3RhdGljIGludCB0aV9zeXNjb25fcmVz
ZXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJcmV0dXJuIGRldm1fcmVz
ZXRfY29udHJvbGxlcl9yZWdpc3RlcihkZXYsICZkYXRhLT5yY2Rldik7DQogfQ0KIA0KK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgbWVkaWF0ZWtfcmVzZXRfZGF0YSBtdGtfcmVzZXRfZGF0YSA9IHsNCisJ
LnJlc2V0X2JpdHMgPSAibWVkaWF0ZWsscmVzZXQtYml0cyIsDQorCS5yZXNldF9kdXJhdGlvbl91
cyA9IDEwLA0KK307DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgdGlfc3lz
Y29uX3Jlc2V0X29mX21hdGNoW10gPSB7DQogCXsgLmNvbXBhdGlibGUgPSAidGksc3lzY29uLXJl
c2V0IiwgfSwNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxzeXNjb24tcmVzZXQiLCAuZGF0
YSA9ICZtdGtfcmVzZXRfZGF0YX0sDQogCXsgLyogc2VudGluZWwgKi8gfSwNCiB9Ow0KIE1PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIHRpX3N5c2Nvbl9yZXNldF9vZl9tYXRjaCk7DQotLSANCjIuMTgu
MA0K

