Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2274E2DBFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgLPLwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:52:14 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34413 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725824AbgLPLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:52:14 -0500
X-UUID: fdf872da8e62467c8bb69f306ccaa594-20201216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EhM5bUedZiGi+gUkZ9oWBBRQVQNZKqOj1hTnbNAjz8M=;
        b=VTUcV/YXdfpQFoklALtkDCzneF/F7yPNOCR3K7it15OGuwX6MRIOjygGZBqGiuXwLv6HL4MVAyjwVpoONnGRJL5ctCPq+rolu9+WVK2zE8DlLrh1/3AYEi4UxZWCQ/uSFXC8LMupqiEz6wGoBExWTDa/nnLXeyUt7IN683Kcay4=;
X-UUID: fdf872da8e62467c8bb69f306ccaa594-20201216
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1742747652; Wed, 16 Dec 2020 19:51:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 19:51:25 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 19:51:25 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 2/3] usb: xhci-mtk: fix UAS issue by XHCI_BROKEN_STREAMS quirk
Date:   Wed, 16 Dec 2020 19:51:24 +0800
Message-ID: <20201216115125.5886-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 16A401981E0BC0AB1C65443D744871EF4B75EBA9A7655DE5439D5904123EC1B42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIDAuOTYgeEhDSSBjb250cm9sbGVyIG9uIHNvbWUgcGxhdGZvcm1zIGRvZXMgbm90IHN1cHBv
cnQNCmJ1bGsgc3RyZWFtIGV2ZW4gSENDUEFSQU1TIHNheXMgc3VwcG9ydGluZywgZHVlIHRvIE1h
eFBTQVNpemUNCmlzIHNldCBhIG5vbi16ZXJvIGRlZmF1bHQgdmFsdWUgYnkgbWlzdGFrZSwgaGVy
ZSB1c2UNClhIQ0lfQlJPS0VOX1NUUkVBTVMgcXVpcmsgdG8gZml4IGl0Lg0KDQpGaXhlczogOTRh
NjMxZDkxYWQzICgidXNiOiB4aGNpLW10azogY2hlY2sgaGNjX3BhcmFtcyBhZnRlciBhZGRpbmcg
cHJpbWFyeSBoY2QiKQ0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5A
bWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIHwgNyArKysr
KystDQogZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5oIHwgMSArDQogMiBmaWxlcyBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS1tdGsuYyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KaW5kZXgg
OGYzMjFmMzlhYjk2Li4wOGRhYjk3NGQ4NDcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9ob3N0
L3hoY2ktbXRrLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KQEAgLTM5NSw2
ICszOTUsOSBAQCBzdGF0aWMgdm9pZCB4aGNpX210a19xdWlya3Moc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgeGhjaV9oY2QgKnhoY2kpDQogCXhoY2ktPnF1aXJrcyB8PSBYSENJX1NQVVJJT1VT
X1NVQ0NFU1M7DQogCWlmIChtdGstPmxwbV9zdXBwb3J0KQ0KIAkJeGhjaS0+cXVpcmtzIHw9IFhI
Q0lfTFBNX1NVUFBPUlQ7DQorDQorCWlmIChtdGstPmJyb2tlbl9zdHJlYW1zKQ0KKwkJeGhjaS0+
cXVpcmtzIHw9IFhIQ0lfQlJPS0VOX1NUUkVBTVM7DQogfQ0KIA0KIC8qIGNhbGxlZCBkdXJpbmcg
cHJvYmUoKSBhZnRlciBjaGlwIHJlc2V0IGNvbXBsZXRlcyAqLw0KQEAgLTQ2MCw2ICs0NjMsOCBA
QCBzdGF0aWMgaW50IHhoY2lfbXRrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQogCQlyZXR1cm4gcmV0Ow0KIA0KIAltdGstPmxwbV9zdXBwb3J0ID0gb2ZfcHJvcGVydHlfcmVh
ZF9ib29sKG5vZGUsICJ1c2IzLWxwbS1jYXBhYmxlIik7DQorCW10ay0+YnJva2VuX3N0cmVhbXMg
PQ0KKwkJb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5vZGUsICJtZWRpYXRlayxicm9rZW5fc3RyZWFt
c19xdWlyayIpOw0KIAkvKiBvcHRpb25hbCBwcm9wZXJ0eSwgaWdub3JlIHRoZSBlcnJvciBpZiBp
dCBkb2VzIG5vdCBleGlzdCAqLw0KIAlvZl9wcm9wZXJ0eV9yZWFkX3UzMihub2RlLCAibWVkaWF0
ZWssdTNwLWRpcy1tc2siLA0KIAkJCSAgICAgJm10ay0+dTNwX2Rpc19tc2spOw0KQEAgLTU0Niw3
ICs1NTEsNyBAQCBzdGF0aWMgaW50IHhoY2lfbXRrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogCWlmIChyZXQpDQogCQlnb3RvIHB1dF91c2IzX2hjZDsNCiANCi0JaWYgKEhD
Q19NQVhfUFNBKHhoY2ktPmhjY19wYXJhbXMpID49IDQpDQorCWlmICghbXRrLT5icm9rZW5fc3Ry
ZWFtcyAmJiBIQ0NfTUFYX1BTQSh4aGNpLT5oY2NfcGFyYW1zKSA+PSA0KQ0KIAkJeGhjaS0+c2hh
cmVkX2hjZC0+Y2FuX2RvX3N0cmVhbXMgPSAxOw0KIA0KIAlyZXQgPSB1c2JfYWRkX2hjZCh4aGNp
LT5zaGFyZWRfaGNkLCBpcnEsIElSUUZfU0hBUkVEKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9ob3N0L3hoY2ktbXRrLmggYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmgNCmluZGV4IGE5
M2NmZTgxNzkwNC4uODZhYTQ5Nzg5MTVlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC94
aGNpLW10ay5oDQorKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmgNCkBAIC0xNDcsNiAr
MTQ3LDcgQEAgc3RydWN0IHhoY2lfaGNkX210ayB7DQogCXN0cnVjdCBwaHkgKipwaHlzOw0KIAlp
bnQgbnVtX3BoeXM7DQogCWJvb2wgbHBtX3N1cHBvcnQ7DQorCWJvb2wgYnJva2VuX3N0cmVhbXM7
DQogCS8qIHVzYiByZW1vdGUgd2FrZXVwICovDQogCWJvb2wgdXdrX2VuOw0KIAlzdHJ1Y3QgcmVn
bWFwICp1d2s7DQotLSANCjIuMTguMA0K

