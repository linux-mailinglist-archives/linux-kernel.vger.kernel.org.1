Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9273C2172E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgGGPqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 11:46:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:29482 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728643AbgGGPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:46:33 -0400
X-UUID: 9d0395b7559a49c9850fa668598a20c4-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OmsSpiiuPqYWe3/jnsNKfZxQpwmDSERR0tJEHUiCPZ4=;
        b=HJo8tlEbq1bcLPo7yzX6PrL8QP/1kMRa0AJUpUTMWXLBeZv0GNR4nqfpaLsFUUX9otG6Wv+7t/kNxlFAH3dFGgfTup740ecBaTc5TE86QqHzB9XGsbPL0HE2h6o++t8VCYmbOOIbHwkBh5FGBxPAxszmM0J8qUY7Mb6yIpMT6nw=;
X-UUID: 9d0395b7559a49c9850fa668598a20c4-20200707
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 263027000; Tue, 07 Jul 2020 23:46:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v3 3/9] soc: mediatek: cmdq: add write_s_mask function
Date:   Tue, 7 Jul 2020 23:45:08 +0800
Message-ID: <1594136714-11650-4-git-send-email-dennis-yc.hsieh@mediatek.com>
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

YWRkIHdyaXRlX3NfbWFzayBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciBmdW5jdGlvbnMgd2hpY2gN
CndyaXRlcyB2YWx1ZSBjb250YWlucyBpbiBpbnRlcm5hbCByZWdpc3RlciB0byBhZGRyZXNzDQp3
aXRoIG1hc2sgYW5kIGxhcmdlIGRtYSBhY2Nlc3Mgc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTog
RGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8ICAgMjMgKysrKysrKysrKysr
KysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwg
ICAgMSArDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICAgMTgg
KysrKysrKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCA4ODAzNDliM2YxNmMu
LjU1MGU5ZTdlM2ZmMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0K
QEAgLTI0Miw2ICsyNDIsMjkgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3Br
dF93cml0ZV9zKTsNCiANCitpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNrKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQorCQkJICB1MTYgYWRkcl9sb3csIHUxNiBz
cmNfcmVnX2lkeCwgdTMyIG1hc2spDQorew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0
ID0ge307DQorCWludCBlcnI7DQorDQorCWluc3Qub3AgPSBDTURRX0NPREVfTUFTSzsNCisJaW5z
dC5tYXNrID0gfm1hc2s7DQorCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5z
dCk7DQorCWlmIChlcnIgPCAwKQ0KKwkJcmV0dXJuIGVycjsNCisNCisJaW5zdC5tYXNrID0gMDsN
CisJaW5zdC5vcCA9IENNRFFfQ09ERV9XUklURV9TX01BU0s7DQorCWluc3Quc3JjX3QgPSBDTURR
X1JFR19UWVBFOw0KKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KKwlpbnN0Lm9mZnNl
dCA9IGFkZHJfbG93Ow0KKwlpbnN0LnNyY19yZWcgPSBzcmNfcmVnX2lkeDsNCisNCisJcmV0dXJu
IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1CT0wo
Y21kcV9wa3Rfd3JpdGVfc19tYXNrKTsNCisNCiBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1MTYgZXZlbnQpDQogew0KIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0
ID0geyB7MH0gfTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KaW5k
ZXggMWY3NmNmZWRiMTZkLi45MGQxZDhlNjQ0MTIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5oDQpAQCAtNjEsNiArNjEsNyBAQCBlbnVtIGNtZHFfY29kZSB7DQog
CUNNRFFfQ09ERV9XRkUgPSAweDIwLA0KIAlDTURRX0NPREVfRU9DID0gMHg0MCwNCiAJQ01EUV9D
T0RFX1dSSVRFX1MgPSAweDkwLA0KKwlDTURRX0NPREVfV1JJVEVfU19NQVNLID0gMHg5MSwNCiAJ
Q01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCiB9Ow0KIA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oDQppbmRleCA5YjBjNTdhMDA2M2QuLjUzMjMwMzQxYmY5NCAxMDA2NDQNCi0tLSBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0xMjIsNiArMTIyLDI0IEBAIGludCBjbWRx
X3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgs
DQogCQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4KTsNCiANCiAvKioNCisgKiBj
bWRxX3BrdF93cml0ZV9zX21hc2soKSAtIGFwcGVuZCB3cml0ZV9zIHdpdGggbWFzayBjb21tYW5k
IHRvIHRoZSBDTURRIHBhY2tldA0KKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KKyAqIEBoaWdo
X2FkZHJfcmVnX2lkeDoJaW50ZXJuYWwgcmVnaXN0ZXIgSUQgd2hpY2ggY29udGFpbnMgaGlnaCBh
ZGRyZXNzIG9mIHBhDQorICogQGFkZHJfbG93Oglsb3cgYWRkcmVzcyBvZiBwYQ0KKyAqIEBzcmNf
cmVnX2lkeDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQgd2hpY2ggY2FjaGUgc291cmNl
IHZhbHVlDQorICogQG1hc2s6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IGFkZHJlc3MgbWFzaywgdXNl
IFUzMl9NQVggaWYgbm8gbmVlZA0KKyAqDQorICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNl
IHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQorICoNCisgKiBTdXBwb3J0IHdyaXRlIHZhbHVl
IHRvIHBoeXNpY2FsIGFkZHJlc3Mgd2l0aG91dCBzdWJzeXMuIFVzZSBDTURRX0FERFJfSElHSCgp
DQorICogdG8gZ2V0IGhpZ2ggYWRkcmVzcyBhbmQgY2FsbCBjbWRxX3BrdF9hc3NpZ24oKSB0byBh
c3NpZ24gdmFsdWUgaW50byBpbnRlcm5hbA0KKyAqIHJlZy4gQWxzbyB1c2UgQ01EUV9BRERSX0xP
VygpIHRvIGdldCBsb3cgYWRkcmVzcyBmb3IgYWRkcl9sb3cgcGFyYW1ldGVyIHdoZW4NCisgKiBj
YWxsIHRvIHRoaXMgZnVuY3Rpb24uDQorICovDQoraW50IGNtZHFfcGt0X3dyaXRlX3NfbWFzayhz
dHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LA0KKwkJCSAgdTE2IGFk
ZHJfbG93LCB1MTYgc3JjX3JlZ19pZHgsIHUzMiBtYXNrKTsNCisNCisvKioNCiAgKiBjbWRxX3Br
dF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tl
dA0KICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KICAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZl
bnQgdHlwZSB0byAid2FpdCBhbmQgQ0xFQVIiDQotLSANCjEuNy45LjUNCg==

