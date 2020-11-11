Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00792AE671
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 03:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgKKCeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 21:34:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38047 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725928AbgKKCeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 21:34:05 -0500
X-UUID: f2e05021bd2a4d70a8e876962742d36e-20201111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cTeQ/hjldFmEyV5pQnqStA/bVh7oOAFXTZ9SDz6FiSc=;
        b=sAgAUfrBKnBCM+5q+fYpXZajMMt4CbSBcX9ZagzeEijirjJs30VXaGJdny4EzRHbSAccRsnBEs/reKJcCW5tKBsUfH3hcSG+wuMF5gkfH9Lg5qLkTOUoubr6LIHjGqrGX2XnefIGqvxUlh4Qu1NGw41pZpPd3pDGCT73oBFiCrk=;
X-UUID: f2e05021bd2a4d70a8e876962742d36e-20201111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 827047059; Wed, 11 Nov 2020 10:33:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 10:33:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 10:33:57 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
Subject: [PATCH v2] clk: mediatek: fix mtk_clk_register_mux() as static function
Date:   Wed, 11 Nov 2020 10:33:56 +0800
Message-ID: <1605062036-12735-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bXRrX2Nsa19yZWdpc3Rlcl9tdXgoKSBzaG91bGQgYmUgYSBzdGF0aWMgZnVuY3Rpb24NCg0KRml4
ZXM6IGEzYWU1NDk5MTdmMTYgKCJjbGs6IG1lZGlhdGVrOiBBZGQgbmV3IGNsa211eCByZWdpc3Rl
ciBBUEkiKQ0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdXguYyB8IDIgKy0NCiBkcml2ZXJzL2Ns
ay9tZWRpYXRlay9jbGstbXV4LmggfCA0IC0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW11eC5jIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW11eC5jDQppbmRleCAxNGUx
MjdlLi5kY2MxMzUyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW11eC5j
DQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXV4LmMNCkBAIC0xNTUsNyArMTU1LDcg
QEAgc3RhdGljIGludCBtdGtfY2xrX211eF9zZXRfcGFyZW50X3NldGNscl9sb2NrKHN0cnVjdCBj
bGtfaHcgKmh3LCB1OCBpbmRleCkNCiAJLnNldF9wYXJlbnQgPSBtdGtfY2xrX211eF9zZXRfcGFy
ZW50X3NldGNscl9sb2NrLA0KIH07DQogDQotc3RydWN0IGNsayAqbXRrX2Nsa19yZWdpc3Rlcl9t
dXgoY29uc3Qgc3RydWN0IG10a19tdXggKm11eCwNCitzdGF0aWMgc3RydWN0IGNsayAqbXRrX2Ns
a19yZWdpc3Rlcl9tdXgoY29uc3Qgc3RydWN0IG10a19tdXggKm11eCwNCiAJCQkJIHN0cnVjdCBy
ZWdtYXAgKnJlZ21hcCwNCiAJCQkJIHNwaW5sb2NrX3QgKmxvY2spDQogew0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdXguaCBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Ns
ay1tdXguaA0KaW5kZXggZjU2MjVmNC4uOGUyZjkyNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdXguaA0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW11eC5o
DQpAQCAtNzcsMTAgKzc3LDYgQEAgc3RydWN0IG10a19tdXggew0KIAkJCV93aWR0aCwgX2dhdGUs
IF91cGRfb2ZzLCBfdXBkLAkJCVwNCiAJCQlDTEtfU0VUX1JBVEVfUEFSRU5UKQ0KIA0KLXN0cnVj
dCBjbGsgKm10a19jbGtfcmVnaXN0ZXJfbXV4KGNvbnN0IHN0cnVjdCBtdGtfbXV4ICptdXgsDQot
CQkJCSBzdHJ1Y3QgcmVnbWFwICpyZWdtYXAsDQotCQkJCSBzcGlubG9ja190ICpsb2NrKTsNCi0N
CiBpbnQgbXRrX2Nsa19yZWdpc3Rlcl9tdXhlcyhjb25zdCBzdHJ1Y3QgbXRrX211eCAqbXV4ZXMs
DQogCQkJICAgaW50IG51bSwgc3RydWN0IGRldmljZV9ub2RlICpub2RlLA0KIAkJCSAgIHNwaW5s
b2NrX3QgKmxvY2ssDQotLSANCjEuOC4xLjEuZGlydHkNCg==

