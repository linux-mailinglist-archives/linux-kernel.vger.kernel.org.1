Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2A1E6848
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 19:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405529AbgE1RHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 13:07:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23025 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405311AbgE1RFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:16 -0400
X-UUID: 311a9738b6714c5b98b03d8413b7362d-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8AiHAdYJBCibSgwBrJh33Kf+JbDiJkLpjqc838PjuJM=;
        b=LR9YXxh7S6Vdmr0Y+Fsy32R/LrIsUPH8PnlE3albe3mqcCTTANRBU/zhNTjlO8wfVXuDFsHMncqTKfV8blWNmdBrQSv87Jqa2XWsvGF2MpypeRZCg/6xbbYQBx2vXiX8mjgmPb175KHBuWnu4QtEPo4LNkMkh+mvBjQK2sjm3X4=;
X-UUID: 311a9738b6714c5b98b03d8413b7362d-20200529
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1605795944; Fri, 29 May 2020 01:05:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 01:05:08 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v6 07/16] soc: mediatek: cmdq: add assign function
Date:   Fri, 29 May 2020 01:04:42 +0800
Message-ID: <1590685491-17107-8-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFzc2lnbiBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciB3aGljaCBhc3NpZ24gY29uc3RhbnQg
dmFsdWUgaW50bw0KaW50ZXJuYWwgcmVnaXN0ZXIgYnkgaW5kZXguDQoNClNpZ25lZC1vZmYtYnk6
IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2Vk
LWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KIGlu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAgMSArDQogaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8IDE0ICsrKysrKysrKysrKysrDQogMyBm
aWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCA5OGYyM2JhM2JhNDcuLjMzMTUzZDE3
YzlkOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTEyLDYg
KzEyLDcgQEANCiAjZGVmaW5lIENNRFFfV1JJVEVfRU5BQkxFX01BU0sJQklUKDApDQogI2RlZmlu
ZSBDTURRX1BPTExfRU5BQkxFX01BU0sJQklUKDApDQogI2RlZmluZSBDTURRX0VPQ19JUlFfRU4J
CUJJVCgwKQ0KKyNkZWZpbmUgQ01EUV9SRUdfVFlQRQkJMQ0KIA0KIHN0cnVjdCBjbWRxX2luc3Ry
dWN0aW9uIHsNCiAJdW5pb24gew0KQEAgLTIxLDggKzIyLDE3IEBAIHN0cnVjdCBjbWRxX2luc3Ry
dWN0aW9uIHsNCiAJdW5pb24gew0KIAkJdTE2IG9mZnNldDsNCiAJCXUxNiBldmVudDsNCisJCXUx
NiByZWdfZHN0Ow0KKwl9Ow0KKwl1bmlvbiB7DQorCQl1OCBzdWJzeXM7DQorCQlzdHJ1Y3Qgew0K
KwkJCXU4IHNvcDo1Ow0KKwkJCXU4IGFyZ19jX3Q6MTsNCisJCQl1OCBhcmdfYl90OjE7DQorCQkJ
dTggZHN0X3Q6MTsNCisJCX07DQogCX07DQotCXU4IHN1YnN5czsNCiAJdTggb3A7DQogfTsNCiAN
CkBAIC0yNzcsNiArMjg3LDE4IEBAIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHU4IHN1YnN5cywNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9wb2xsX21h
c2spOw0KIA0KK2ludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBy
ZWdfaWR4LCB1MzIgdmFsdWUpDQorew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0g
eyB7MH0gfTsNCisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9MT0dJQzsNCisJaW5zdC5kc3RfdCA9
IENNRFFfUkVHX1RZUEU7DQorCWluc3QucmVnX2RzdCA9IHJlZ19pZHg7DQorCWluc3QudmFsdWUg
PSB2YWx1ZTsNCisJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQor
fQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3RfYXNzaWduKTsNCisNCiBzdGF0aWMgaW50IGNtZHFf
cGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KIHsNCiAJc3RydWN0IGNtZHFfaW5z
dHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWls
Ym94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmgNCmluZGV4IGRmZTViMmViODVjYy4uMTIxYzNiYjZkM2RlIDEwMDY0NA0KLS0tIGEv
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KKysrIGIvaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KQEAgLTU5LDYgKzU5LDcgQEAgZW51bSBj
bWRxX2NvZGUgew0KIAlDTURRX0NPREVfSlVNUCA9IDB4MTAsDQogCUNNRFFfQ09ERV9XRkUgPSAw
eDIwLA0KIAlDTURRX0NPREVfRU9DID0gMHg0MCwNCisJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwN
CiB9Ow0KIA0KIGVudW0gY21kcV9jYl9zdGF0dXMgew0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oDQppbmRleCBhNzRjMWQ1YWNkZjMuLjgzMzQwMjExZTFkMyAxMDA2NDQNCi0tLSBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xNTIsNiArMTUyLDIwIEBAIGludCBjbWRx
X3BrdF9wb2xsKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQogICovDQogaW50IGNt
ZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KIAkJICAg
ICAgIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KKw0KKy8qKg0KKyAqIGNtZHFf
cGt0X2Fzc2lnbigpIC0gQXBwZW5kIGxvZ2ljIGFzc2lnbiBjb21tYW5kIHRvIHRoZSBDTURRIHBh
Y2tldCwgYXNrIEdDRQ0KKyAqCQkgICAgICAgdG8gZXhlY3V0ZSBhbiBpbnN0cnVjdGlvbiB0aGF0
IHNldCBhIGNvbnN0YW50IHZhbHVlIGludG8NCisgKgkJICAgICAgIGludGVybmFsIHJlZ2lzdGVy
IGFuZCB1c2UgYXMgdmFsdWUsIG1hc2sgb3IgYWRkcmVzcyBpbg0KKyAqCQkgICAgICAgcmVhZC93
cml0ZSBpbnN0cnVjdGlvbi4NCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAcmVnX2lk
eDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQNCisgKiBAdmFsdWU6CXRoZSBzcGVjaWZp
ZWQgdmFsdWUNCisgKg0KKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3Ig
Y29kZSBpcyByZXR1cm5lZA0KKyAqLw0KK2ludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0
X2ZsdXNoX2FzeW5jKCkgLSB0cmlnZ2VyIENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0
aGUgQ01EUQ0KICAqICAgICAgICAgICAgICAgICAgICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFj
ayBhdCB0aGUgZW5kIG9mIGRvbmUgcGFja2V0DQotLSANCjIuMTguMA0K

