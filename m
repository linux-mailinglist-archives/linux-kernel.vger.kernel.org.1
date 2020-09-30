Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D8727E226
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgI3HJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:09:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40861 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:09:27 -0400
X-UUID: a0f9b24352d74a2b91f1885051b6869b-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IcHcY2GTxRqXGr2c5Od/IbtILzjIIei29lysc2o5kuY=;
        b=dUD+TmmFGxb2ZO8RuYX4nK8I28jgLxvLQLJxllOQ8+mCIbx1/qCcySMg98eapFj8Nt8sJnBvFleeJZ+9GC2qPyBSHT912IqEm5JJ1/1vQFsBqCtXt0bXCz0g6ugfRWe22dAMO1mco5M+RqW1xw2PHoPfIf62dLfn2GL3s3gXjQA=;
X-UUID: a0f9b24352d74a2b91f1885051b6869b-20200930
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1495445841; Wed, 30 Sep 2020 15:09:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:09:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:09:15 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Subject: [PATCH v3 11/24] iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable for MediaTek
Date:   Wed, 30 Sep 2020 15:06:34 +0800
Message-ID: <20200930070647.10188-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHN0YW5kYXJkIGlucHV0IGlvdmEgYml0cyBpcyAzMi4gTWVkaWFUZWsgcXVhZCB0aGUgbHZs
MSBwYWdldGFibGUNCig0ICogbHZsMSkuIE5vIGNoYW5nZSBmb3IgbHZsMiBwYWdldGFibGUuIFRo
ZW4gdGhlIGlvdmEgYml0cyBjYW4gcmVhY2gNCjM0Yml0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25n
IFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJs
ZS1hcm0tdjdzLmMgfCAxMyArKysrKysrKysrLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
YyAgICAgICAgICB8ICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFy
bS12N3MuYyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCmluZGV4IDgzNjJm
ZGY3NjY1Ny4uMzA2YmFlMjc1NWVkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9pby1wZ3Rh
YmxlLWFybS12N3MuYw0KKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0K
QEAgLTUwLDEwICs1MCwxNyBAQA0KICAqLw0KICNkZWZpbmUgQVJNX1Y3U19BRERSX0JJVFMJCTMy
DQogI2RlZmluZSBfQVJNX1Y3U19MVkxfQklUUyhsdmwpCQkoMTYgLSAobHZsKSAqIDQpDQorLyog
TWVkaWFUZWs6IHRvdGFsbHkgMzRiaXRzLCAxNGJpdHMgYXQgbHZsMSBhbmQgOGJpdHMgYXQgbHZs
Mi4gKi8NCisjZGVmaW5lIF9BUk1fVjdTX0xWTF9CSVRTX01USyhsdmwpCSgyMCAtIChsdmwpICog
NikNCiAjZGVmaW5lIEFSTV9WN1NfTFZMX1NISUZUKGx2bCkJCShBUk1fVjdTX0FERFJfQklUUyAt
ICg0ICsgOCAqIChsdmwpKSkNCiAjZGVmaW5lIEFSTV9WN1NfVEFCTEVfU0hJRlQJCTEwDQogDQot
I2RlZmluZSBBUk1fVjdTX1BURVNfUEVSX0xWTChsdmwsIGNmZykJKDEgPDwgX0FSTV9WN1NfTFZM
X0JJVFMobHZsKSkNCisjZGVmaW5lIEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2bCwgY2ZnKQkoewkJ
CQlcDQorCWludCBfbHZsID0gbHZsOwkJCQkJCQlcDQorCSFhcm1fdjdzX2lzX210a19lbmFibGVk
KGNmZykgPwkJCQkJXA0KKwkgKDEgPDwgX0FSTV9WN1NfTFZMX0JJVFMoX2x2bCkpIDogKDEgPDwg
X0FSTV9WN1NfTFZMX0JJVFNfTVRLKF9sdmwpKTtcDQorfSkNCisNCiAjZGVmaW5lIEFSTV9WN1Nf
VEFCTEVfU0laRShsdmwsIGNmZykJCQkJCVwNCiAJKEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2bCwg
Y2ZnKSAqIHNpemVvZihhcm1fdjdzX2lvcHRlKSkNCiANCkBAIC02Myw3ICs3MCw3IEBADQogI2Rl
ZmluZSBfQVJNX1Y3U19JRFhfTUFTSyhsdmwsIGNmZykJKEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2
bCwgY2ZnKSAtIDEpDQogI2RlZmluZSBBUk1fVjdTX0xWTF9JRFgoYWRkciwgbHZsLCBjZmcpCSh7
CQkJXA0KIAlpbnQgX2wgPSBsdmw7CQkJCQkJCVwNCi0JKCh1MzIpKGFkZHIpID4+IEFSTV9WN1Nf
TFZMX1NISUZUKF9sKSkgJiBfQVJNX1Y3U19JRFhfTUFTSyhfbCwgY2ZnKTsgXA0KKwkoKGFkZHIp
ID4+IEFSTV9WN1NfTFZMX1NISUZUKF9sKSkgJiBfQVJNX1Y3U19JRFhfTUFTSyhfbCwgY2ZnKTsg
XA0KIH0pDQogDQogLyoNCkBAIC03NTUsNyArNzYyLDcgQEAgc3RhdGljIHN0cnVjdCBpb19wZ3Rh
YmxlICphcm1fdjdzX2FsbG9jX3BndGFibGUoc3RydWN0IGlvX3BndGFibGVfY2ZnICpjZmcsDQog
ew0KIAlzdHJ1Y3QgYXJtX3Y3c19pb19wZ3RhYmxlICpkYXRhOw0KIA0KLQlpZiAoY2ZnLT5pYXMg
PiBBUk1fVjdTX0FERFJfQklUUykNCisJaWYgKGNmZy0+aWFzID4gKGFybV92N3NfaXNfbXRrX2Vu
YWJsZWQoY2ZnKSA/IDM0IDogQVJNX1Y3U19BRERSX0JJVFMpKQ0KIAkJcmV0dXJuIE5VTEw7DQog
DQogCWlmIChjZmctPm9hcyA+IChhcm1fdjdzX2lzX210a19lbmFibGVkKGNmZykgPyAzNSA6IEFS
TV9WN1NfQUREUl9CSVRTKSkNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggZjZhMmUzZWI1OWQyLi42ZTg1Yzk5
NzZhMzMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2
ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtMzE2LDcgKzMxNiw3IEBAIHN0YXRpYyBpbnQgbXRr
X2lvbW11X2RvbWFpbl9maW5hbGlzZShzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9tKQ0KIAkJ
CUlPX1BHVEFCTEVfUVVJUktfVExCSV9PTl9NQVAgfA0KIAkJCUlPX1BHVEFCTEVfUVVJUktfQVJN
X01US19FWFQsDQogCQkucGdzaXplX2JpdG1hcCA9IG10a19pb21tdV9vcHMucGdzaXplX2JpdG1h
cCwNCi0JCS5pYXMgPSAzMiwNCisJCS5pYXMgPSAzNCwNCiAJCS5vYXMgPSAzNSwNCiAJCS50bGIg
PSAmbXRrX2lvbW11X2ZsdXNoX29wcywNCiAJCS5pb21tdV9kZXYgPSBkYXRhLT5kZXYsDQotLSAN
CjIuMTguMA0K

