Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A262AAEEC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgKICEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:04:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57288 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729067AbgKICEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:04:04 -0500
X-UUID: dfc0c51316b848dbafacf7de4ff1bc8f-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ftPxtc+iQCzrE74P/pq+OCJL4UAyhW8S1+eTiI7YSZ4=;
        b=GEbDZT6z/2Fucaks8mqa3VLfanFiPkRyTgxqguYY90rKfV+JhtsqGQMPKOuAg4AYGsg+T3jZcgnSssAgK2c8PJGy/OJfeIHuFBPr2B8UMI84bBjnuGCqSzckVov3n/N+CMncf2g4lZJm44633B9DvDaqPbmzW96Euk3RNnNLc04=;
X-UUID: dfc0c51316b848dbafacf7de4ff1bc8f-20201109
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 652490627; Mon, 09 Nov 2020 10:03:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:03:52 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v5 08/24] clk: mediatek: Add configurable enable control to mtk_pll_data
Date:   Mon, 9 Nov 2020 10:03:33 +0800
Message-ID: <1604887429-29445-9-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gYWxsIE1lZGlhVGVrIFBMTCBkZXNpZ24sIGJpdDAgb2YgQ09OMCByZWdpc3RlciBpcyBhbHdh
eXMNCnRoZSBlbmFibGUgYml0Lg0KSG93ZXZlciwgdGhlcmUncyBhIHNwZWNpYWwgY2FzZSBvZiB1
c2JwbGwgb24gTVQ4MTkyLg0KVGhlIGVuYWJsZSBiaXQgb2YgdXNicGxsIGlzIG1vdmVkIHRvIGJp
dDIgb2Ygb3RoZXIgcmVnaXN0ZXIuDQpBZGQgY29uZmlndXJhYmxlIGVuX3JlZyBhbmQgcGxsX2Vu
X2JpdCBmb3IgZW5hYmxlIGNvbnRyb2wgb3INCmRlZmF1bHQgMCB3aGVyZSBwbGwgZGF0YSBhcmUg
c3RhdGljIHZhcmlhYmxlcy4NCkhlbmNlLCBDT04wX0JBU0VfRU4gY291bGQgYWxzbyBiZSByZW1v
dmVkLg0KQW5kIHRoZXJlIG1pZ2h0IGhhdmUgYW5vdGhlciBzcGVjaWFsIGNhc2Ugb24gb3RoZXIg
Y2hpcHMsDQp0aGUgZW5hYmxlIGJpdCBpcyBzdGlsbCBvbiBDT04wIHJlZ2lzdGVyIGJ1dCBub3Qg
YXQgYml0MC4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuaCB8ICAyICsrDQogZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jIHwgMTUgKysrKysrKysrKy0tLS0tDQogMiBmaWxlcyBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5oIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LW10ay5oDQppbmRleCBjM2Q2NzU2Li5jNTgwNjYzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsv
bWVkaWF0ZWsvY2xrLW10ay5oDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmgN
CkBAIC0yMzMsNiArMjMzLDggQEAgc3RydWN0IG10a19wbGxfZGF0YSB7DQogCXVpbnQzMl90IHBj
d19jaGdfcmVnOw0KIAljb25zdCBzdHJ1Y3QgbXRrX3BsbF9kaXZfdGFibGUgKmRpdl90YWJsZTsN
CiAJY29uc3QgY2hhciAqcGFyZW50X25hbWU7DQorCXVpbnQzMl90IGVuX3JlZzsNCisJdWludDhf
dCBwbGxfZW5fYml0OyAvKiBBc3N1bWUgMCwgaW5kaWNhdGVzIEJJVCgwKSBieSBkZWZhdWx0ICov
DQogfTsNCiANCiB2b2lkIG10a19jbGtfcmVnaXN0ZXJfcGxscyhzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5vZGUsDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jIGIvZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jDQppbmRleCAxMWVkNWQxLi43ZmIwMDFhIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jDQorKysgYi9kcml2ZXJzL2Ns
ay9tZWRpYXRlay9jbGstcGxsLmMNCkBAIC00NCw2ICs0NCw3IEBAIHN0cnVjdCBtdGtfY2xrX3Bs
bCB7DQogCXZvaWQgX19pb21lbQkqdHVuZXJfZW5fYWRkcjsNCiAJdm9pZCBfX2lvbWVtCSpwY3df
YWRkcjsNCiAJdm9pZCBfX2lvbWVtCSpwY3dfY2hnX2FkZHI7DQorCXZvaWQgX19pb21lbQkqZW5f
YWRkcjsNCiAJY29uc3Qgc3RydWN0IG10a19wbGxfZGF0YSAqZGF0YTsNCiB9Ow0KIA0KQEAgLTU2
LDcgKzU3LDcgQEAgc3RhdGljIGludCBtdGtfcGxsX2lzX3ByZXBhcmVkKHN0cnVjdCBjbGtfaHcg
Kmh3KQ0KIHsNCiAJc3RydWN0IG10a19jbGtfcGxsICpwbGwgPSB0b19tdGtfY2xrX3BsbChodyk7
DQogDQotCXJldHVybiAocmVhZGwocGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCkgJiBDT04wX0JB
U0VfRU4pICE9IDA7DQorCXJldHVybiAocmVhZGwocGxsLT5lbl9hZGRyKSAmIEJJVChwbGwtPmRh
dGEtPnBsbF9lbl9iaXQpKSAhPSAwOw0KIH0NCiANCiBzdGF0aWMgdW5zaWduZWQgbG9uZyBfX210
a19wbGxfcmVjYWxjX3JhdGUoc3RydWN0IG10a19jbGtfcGxsICpwbGwsIHUzMiBmaW4sDQpAQCAt
MjQ4LDggKzI0OSw4IEBAIHN0YXRpYyBpbnQgbXRrX3BsbF9wcmVwYXJlKHN0cnVjdCBjbGtfaHcg
Kmh3KQ0KIAl3cml0ZWwociwgcGxsLT5wd3JfYWRkcik7DQogCXVkZWxheSgxKTsNCiANCi0JciA9
IHJlYWRsKHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApIHwgQ09OMF9CQVNFX0VOOw0KLQl3cml0
ZWwociwgcGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQorCXIgPSByZWFkbChwbGwtPmVuX2Fk
ZHIpIHwgQklUKHBsbC0+ZGF0YS0+cGxsX2VuX2JpdCk7DQorCXdyaXRlbChyLCBwbGwtPmVuX2Fk
ZHIpOw0KIA0KIAlkaXZfZW5fbWFzayA9IHBsbC0+ZGF0YS0+ZW5fbWFzayAmIH5DT04wX0JBU0Vf
RU47DQogCWlmIChkaXZfZW5fbWFzaykgew0KQEAgLTI5MCw4ICsyOTEsOCBAQCBzdGF0aWMgdm9p
ZCBtdGtfcGxsX3VucHJlcGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCiAJCXdyaXRlbChyLCBwbGwt
PmJhc2VfYWRkciArIFJFR19DT04wKTsNCiAJfQ0KIA0KLQlyID0gcmVhZGwocGxsLT5iYXNlX2Fk
ZHIgKyBSRUdfQ09OMCkgJiB+Q09OMF9CQVNFX0VOOw0KLQl3cml0ZWwociwgcGxsLT5iYXNlX2Fk
ZHIgKyBSRUdfQ09OMCk7DQorCXIgPSByZWFkbChwbGwtPmVuX2FkZHIpICYgfkJJVChwbGwtPmRh
dGEtPnBsbF9lbl9iaXQpOw0KKwl3cml0ZWwociwgcGxsLT5lbl9hZGRyKTsNCiANCiAJciA9IHJl
YWRsKHBsbC0+cHdyX2FkZHIpIHwgQ09OMF9JU09fRU47DQogCXdyaXRlbChyLCBwbGwtPnB3cl9h
ZGRyKTsNCkBAIC0zMzMsNiArMzM0LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgY2xrICptdGtfY2xrX3Jl
Z2lzdGVyX3BsbChjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhICpkYXRhLA0KIAkJcGxsLT50dW5l
cl9hZGRyID0gYmFzZSArIGRhdGEtPnR1bmVyX3JlZzsNCiAJaWYgKGRhdGEtPnR1bmVyX2VuX3Jl
ZykNCiAJCXBsbC0+dHVuZXJfZW5fYWRkciA9IGJhc2UgKyBkYXRhLT50dW5lcl9lbl9yZWc7DQor
CWlmIChkYXRhLT5lbl9yZWcpDQorCQlwbGwtPmVuX2FkZHIgPSBiYXNlICsgZGF0YS0+ZW5fcmVn
Ow0KKwllbHNlDQorCQlwbGwtPmVuX2FkZHIgPSBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wOw0K
IAlwbGwtPmh3LmluaXQgPSAmaW5pdDsNCiAJcGxsLT5kYXRhID0gZGF0YTsNCiANCi0tIA0KMS44
LjEuMS5kaXJ0eQ0K

