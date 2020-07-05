Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC90C214AB3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgGEGtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 02:49:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41647 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726625AbgGEGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:48:46 -0400
X-UUID: 5a1bdc30f6bf45c6b8368f3197906738-20200705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NywHPAueQWZsL8tcuK4bPq8/aZhOZfaPkZYtAImJHB4=;
        b=Rk3etQUR5TicHENrARtTUdBcgRi5aqSCvY7LXC6ZuAVrxBBBYtafb1JEN5wWXNb2mCVqLU4AVMft194AW7UgLI27+dYJAFWGN6EDeZ6fajwtFDNhoYSEPnhc+/1WyFJ6pQ0AbddJ6TUaV9FHU39Iuz9seFvqsTe7kwFzGmdKZb0=;
X-UUID: 5a1bdc30f6bf45c6b8368f3197906738-20200705
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1873665638; Sun, 05 Jul 2020 14:48:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 5 Jul 2020 14:48:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Jul 2020 14:48:36 +0800
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
Subject: [PATCH v2 2/8] soc: mediatek: cmdq: add write_s function
Date:   Sun, 5 Jul 2020 14:48:29 +0800
Message-ID: <1593931715-32761-3-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5106C909F20D3A9629D97E2841EF04F1A236420A2373B7DFA7317F8EAE1EB7E62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQp3cml0
ZXMgdmFsdWUgY29udGFpbnMgaW4gaW50ZXJuYWwgcmVnaXN0ZXIgdG8gYWRkcmVzcw0Kd2l0aCBs
YXJnZSBkbWEgYWNjZXNzIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2ll
aCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAgIDE5ICsrKysrKysrKysrKysrKysrKysNCiBpbmNs
dWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMSArDQogaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICAgMTkgKysrKysrKysrKysrKysrKysr
Kw0KIDMgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggOWZhZjc4ZmJlZDNhLi44ODAzNDliM2YxNmMgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0xOCw2ICsxOCwxMCBA
QCBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCiAJCXUzMiB2YWx1ZTsNCiAJ
CXUzMiBtYXNrOw0KKwkJc3RydWN0IHsNCisJCQl1MTYgYXJnX2M7DQorCQkJdTE2IHNyY19yZWc7
DQorCQl9Ow0KIAl9Ow0KIAl1bmlvbiB7DQogCQl1MTYgb2Zmc2V0Ow0KQEAgLTIyMyw2ICsyMjcs
MjEgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1
YnN5cywNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9tYXNrKTsNCiANCitpbnQg
Y21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdf
aWR4LA0KKwkJICAgICB1MTYgYWRkcl9sb3csIHUxNiBzcmNfcmVnX2lkeCkNCit7DQorCXN0cnVj
dCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7fTsNCisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9X
UklURV9TOw0KKwlpbnN0LnNyY190ID0gQ01EUV9SRUdfVFlQRTsNCisJaW5zdC5zb3AgPSBoaWdo
X2FkZHJfcmVnX2lkeDsNCisJaW5zdC5vZmZzZXQgPSBhZGRyX2xvdzsNCisJaW5zdC5zcmNfcmVn
ID0gc3JjX3JlZ19pZHg7DQorDQorCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3Qs
IGluc3QpOw0KK30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3MpOw0KKw0KIGludCBj
bWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCiB7DQogCXN0cnVj
dCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5oDQppbmRleCAwNWVlYTFhZWY1YWEuLjFmNzZjZmVkYjE2ZCAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCisrKyBi
L2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCkBAIC02MCw2ICs2MCw3
IEBAIGVudW0gY21kcV9jb2RlIHsNCiAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KIAlDTURRX0NP
REVfV0ZFID0gMHgyMCwNCiAJQ01EUV9DT0RFX0VPQyA9IDB4NDAsDQorCUNNRFFfQ09ERV9XUklU
RV9TID0gMHg5MCwNCiAJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCiB9Ow0KIA0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4
L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCAyMjQ5ZWNhZjc3ZTQuLjliMGM1N2EwMDYz
ZCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisr
KyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xMiw2ICsxMiw4
IEBADQogI2luY2x1ZGUgPGxpbnV4L3RpbWVyLmg+DQogDQogI2RlZmluZSBDTURRX05PX1RJTUVP
VVQJCTB4ZmZmZmZmZmZ1DQorI2RlZmluZSBDTURRX0FERFJfSElHSChhZGRyKQkoKHUzMikoKChh
ZGRyKSA+PiAxNikgJiBHRU5NQVNLKDMxLCAwKSkpDQorI2RlZmluZSBDTURRX0FERFJfTE9XKGFk
ZHIpCSgodTE2KShhZGRyKSB8IEJJVCgxKSkNCiANCiBzdHJ1Y3QgY21kcV9wa3Q7DQogDQpAQCAt
MTAzLDYgKzEwNSwyMyBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTggc3Vic3lzLA0KIAkJCXUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0K
IA0KIC8qKg0KKyAqIGNtZHFfcGt0X3dyaXRlX3MoKSAtIGFwcGVuZCB3cml0ZV9zIGNvbW1hbmQg
dG8gdGhlIENNRFEgcGFja2V0DQorICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQorICogQGhpZ2hf
YWRkcl9yZWdfaWR4OglpbnRlcm5hbCByZWdpc3RlciBJRCB3aGljaCBjb250YWlucyBoaWdoIGFk
ZHJlc3Mgb2YgcGENCisgKiBAYWRkcl9sb3c6CWxvdyBhZGRyZXNzIG9mIHBhDQorICogQHNyY19y
ZWdfaWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3RlciBJRCB3aGljaCBjYWNoZSBzb3VyY2Ug
dmFsdWUNCisgKg0KKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29k
ZSBpcyByZXR1cm5lZA0KKyAqDQorICogU3VwcG9ydCB3cml0ZSB2YWx1ZSB0byBwaHlzaWNhbCBh
ZGRyZXNzIHdpdGhvdXQgc3Vic3lzLiBVc2UgQ01EUV9BRERSX0hJR0goKQ0KKyAqIHRvIGdldCBo
aWdoIGFkZHJlc3MgYW5kIGNhbGwgY21kcV9wa3RfYXNzaWduKCkgdG8gYXNzaWduIHZhbHVlIGlu
dG8gaW50ZXJuYWwNCisgKiByZWcuIEFsc28gdXNlIENNRFFfQUREUl9MT1coKSB0byBnZXQgbG93
IGFkZHJlc3MgZm9yIGFkZHJfbG93IHBhcmFtZXRlciB3aGVuDQorICogY2FsbCB0byB0aGlzIGZ1
bmN0aW9uLg0KKyAqLw0KK2ludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQorCQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNyY19y
ZWdfaWR4KTsNCisNCisvKioNCiAgKiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBl
dmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tl
dA0KICAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byAid2FpdCBhbmQgQ0xFQVIi
DQotLSANCjEuNy45LjUNCg==

