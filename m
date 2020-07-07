Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A512172E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgGGPql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 11:46:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52321 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728495AbgGGPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:46:36 -0400
X-UUID: e48af8fa1951480dbd96a6dc9d799530-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JHnnzMliL0zo94t403GWJbOP7Xl5uFEXZUlbV9zs2gs=;
        b=mHkCyA9OmF9qNsh+xePW3oW7EfVMAVgCWqWSElyAofK8F08FaM4rQdiC68FieKAd08ejj5vGWM3cnburuLp9XGoTZPLpqSrT1YJIuhrqZaixAyMUZ17V0CiAHNkFGObx3sUTwr7ILzA2s4rc6u3r8vLpVR7LVyeF4rat33vsCMg=;
X-UUID: e48af8fa1951480dbd96a6dc9d799530-20200707
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1674903097; Tue, 07 Jul 2020 23:46:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 23:46:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 23:46:24 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v3 4/9] soc: mediatek: cmdq: add read_s function
Date:   Tue, 7 Jul 2020 23:45:09 +0800
Message-ID: <1594136714-11650-5-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHJlYWRfcyBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2ggc3VwcG9y
dCByZWFkIHZhbHVlIGZyb20NCnJlZ2lzdGVyIG9yIGRtYSBwaHlzaWNhbCBhZGRyZXNzIGludG8g
Z2NlIGludGVybmFsIHJlZ2lzdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWgg
PGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYyAgIHwgICAxNSArKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xp
bnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMSArDQogaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICAgMTIgKysrKysrKysrKysrDQogMyBmaWxlcyBj
aGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jDQppbmRleCA1NTBlOWU3ZTNmZjIuLmVkOWY1ZTYzYzE5NSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTIyNyw2ICsyMjcsMjEgQEAgaW50IGNtZHFf
cGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiB9DQogRVhQ
T1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9tYXNrKTsNCiANCitpbnQgY21kcV9wa3RfcmVhZF9z
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsIHUxNiBhZGRyX2xv
dywNCisJCSAgICB1MTYgcmVnX2lkeCkNCit7DQorCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGlu
c3QgPSB7fTsNCisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9SRUFEX1M7DQorCWluc3QuZHN0X3Qg
PSBDTURRX1JFR19UWVBFOw0KKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KKwlpbnN0
LnJlZ19kc3QgPSByZWdfaWR4Ow0KKwlpbnN0LnNyY19yZWcgPSBhZGRyX2xvdzsNCisNCisJcmV0
dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1C
T0woY21kcV9wa3RfcmVhZF9zKTsNCisNCiBpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LA0KIAkJICAgICB1MTYgYWRkcl9sb3cs
IHUxNiBzcmNfcmVnX2lkeCkNCiB7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94
L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmgNCmluZGV4IDkwZDFkOGU2NDQxMi4uZWZiZDhhOWViMmQxIDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KKysrIGIvaW5jbHVkZS9saW51
eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KQEAgLTYwLDYgKzYwLDcgQEAgZW51bSBjbWRx
X2NvZGUgew0KIAlDTURRX0NPREVfSlVNUCA9IDB4MTAsDQogCUNNRFFfQ09ERV9XRkUgPSAweDIw
LA0KIAlDTURRX0NPREVfRU9DID0gMHg0MCwNCisJQ01EUV9DT0RFX1JFQURfUyA9IDB4ODAsDQog
CUNNRFFfQ09ERV9XUklURV9TID0gMHg5MCwNCiAJQ01EUV9DT0RFX1dSSVRFX1NfTUFTSyA9IDB4
OTEsDQogCUNNRFFfQ09ERV9MT0dJQyA9IDB4YTAsDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmgNCmluZGV4IDUzMjMwMzQxYmY5NC4uY2Q3ZWM3MTQzNDRlIDEwMDY0NA0KLS0tIGEv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAgLTEwNCw2ICsxMDQsMTggQEAgc3RydWN0IGNt
ZHFfY2xpZW50ICpjbWRxX21ib3hfY3JlYXRlKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGluZGV4
LA0KIGludCBjbWRxX3BrdF93cml0ZV9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJz
eXMsDQogCQkJdTE2IG9mZnNldCwgdTMyIHZhbHVlLCB1MzIgbWFzayk7DQogDQorLyoNCisgKiBj
bWRxX3BrdF9yZWFkX3MoKSAtIGFwcGVuZCByZWFkX3MgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNr
ZXQNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBAaGlnaF9hZGRyX3JlZ19pZHg6CWlu
dGVybmFsIHJlZ2lzdGVyIElEIHdoaWNoIGNvbnRhaW5zIGhpZ2ggYWRkcmVzcyBvZiBwYQ0KKyAq
IEBhZGRyX2xvdzoJbG93IGFkZHJlc3Mgb2YgcGENCisgKiBAcmVnX2lkeDoJdGhlIENNRFEgaW50
ZXJuYWwgcmVnaXN0ZXIgSUQgdG8gY2FjaGUgcmVhZCBkYXRhDQorICoNCisgKiBSZXR1cm46IDAg
Zm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKi8NCitpbnQg
Y21kcV9wa3RfcmVhZF9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19p
ZHgsIHUxNiBhZGRyX2xvdywNCisJCSAgICB1MTYgcmVnX2lkeCk7DQorDQogLyoqDQogICogY21k
cV9wa3Rfd3JpdGVfcygpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNr
ZXQNCiAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCi0tIA0KMS43LjkuNQ0K

