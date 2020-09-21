Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482732721DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIULJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:09:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44174 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbgIULJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:09:22 -0400
X-UUID: 5f449cfa016848c98f00573af7ec9e78-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3HUXUX5lDNUCa6N5Zaro0/doIP90sLHg872yoAre1h4=;
        b=uURHy5bSotZURuw/61ltVgAfjx9giDObxIc1Goz0PN2k0nUE2aWetz6hinDLhNnFdFjzoSoqX+mFKm0RqORHjOeDAMcY8U23XJ3JZOUu7ROq66UzagF3MH9Y7Tn43rt7tzxnY2/lLBykDFcFlRn5m+l4W6ciYcV3K2Nkl/gQkkQ=;
X-UUID: 5f449cfa016848c98f00573af7ec9e78-20200921
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1572789909; Mon, 21 Sep 2020 19:04:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 19:04:12 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 19:04:12 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>, <drinkcat@chromium.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH v3 4/4] soc: mediatek: pwrap: add pwrap driver for MT6873/8192 SoCs
Date:   Mon, 21 Sep 2020 19:03:55 +0800
Message-ID: <1600686235-27979-5-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1600686235-27979-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1600686235-27979-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4474EF530B13F100FD9B808B7BD823BA58FC63BF8F27B11311726FF101D38B872000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVQ2ODczLzgxOTIgYXJlIGhpZ2hseSBpbnRlZ3JhdGVkIFNvQ3MgYW5kIHVzZSBQTUlDX01UNjM1
OSBmb3INCnBvd2VyIG1hbmFnZW1lbnQuIFRoaXMgcGF0Y2ggYWRkcyBwd3JhcCBtYXN0ZXIgZHJp
dmVyIHRvDQphY2Nlc3MgUE1JQ19NVDYzNTkuDQoNClNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5n
IFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLXBtaWMtd3JhcC5jDQppbmRleCAxNDliZjAyLi5jNzNlOTJiIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstcG1pYy13cmFwLmMNCkBAIC02MzIsNiArNjMyLDE3IEBAIHN0YXRpYyBpbnQgbXQ2
Nzk3X3JlZ3NbXSA9IHsNCiAJW1BXUkFQX0RDTV9EQkNfUFJEXSA9CQkweDFENCwNCiB9Ow0KIA0K
K3N0YXRpYyBpbnQgbXQ2ODczX3JlZ3NbXSA9IHsNCisJW1BXUkFQX0lOSVRfRE9ORTJdID0JCTB4
MCwNCisJW1BXUkFQX1RJTUVSX0VOXSA9CQkweDNFMCwNCisJW1BXUkFQX0lOVF9FTl0gPQkJMHg0
NDgsDQorCVtQV1JBUF9XQUNTMl9DTURdID0JCTB4QzgwLA0KKwlbUFdSQVBfU1dJTkZfMl9XREFU
QV8zMV8wXSA9CTB4Qzg0LA0KKwlbUFdSQVBfU1dJTkZfMl9SREFUQV8zMV8wXSA9CTB4Qzk0LA0K
KwlbUFdSQVBfV0FDUzJfVkxEQ0xSXSA9CQkweENBNCwNCisJW1BXUkFQX1dBQ1MyX1JEQVRBXSA9
CQkweENBOCwNCit9Ow0KKw0KIHN0YXRpYyBpbnQgbXQ3NjIyX3JlZ3NbXSA9IHsNCiAJW1BXUkFQ
X01VWF9TRUxdID0JCTB4MCwNCiAJW1BXUkFQX1dSQVBfRU5dID0JCTB4NCwNCkBAIC0xMDUwLDYg
KzEwNjEsNyBAQCBlbnVtIHB3cmFwX3R5cGUgew0KIAlQV1JBUF9NVDY3NjUsDQogCVBXUkFQX01U
Njc3OSwNCiAJUFdSQVBfTVQ2Nzk3LA0KKwlQV1JBUF9NVDY4NzMsDQogCVBXUkFQX01UNzYyMiwN
CiAJUFdSQVBfTVQ4MTM1LA0KIAlQV1JBUF9NVDgxNzMsDQpAQCAtMTUxMiw2ICsxNTI0LDcgQEAg
c3RhdGljIGludCBwd3JhcF9pbml0X2NpcGhlcihzdHJ1Y3QgcG1pY193cmFwcGVyICp3cnApDQog
CWNhc2UgUFdSQVBfTVQ3NjIyOg0KIAkJcHdyYXBfd3JpdGVsKHdycCwgMCwgUFdSQVBfQ0lQSEVS
X0VOKTsNCiAJCWJyZWFrOw0KKwljYXNlIFBXUkFQX01UNjg3MzoNCiAJY2FzZSBQV1JBUF9NVDgx
ODM6DQogCQlicmVhazsNCiAJfQ0KQEAgLTE5NDgsNiArMTk2MSwxOSBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHBtaWNfd3JhcHBlcl90eXBlIHB3cmFwX210Njc5NyA9IHsNCiAJLmluaXRfc29jX3Nw
ZWNpZmljID0gTlVMTCwNCiB9Ow0KIA0KK3N0YXRpYyBzdHJ1Y3QgcG1pY193cmFwcGVyX3R5cGUg
cHdyYXBfbXQ2ODczID0gew0KKwkucmVncyA9IG10Njg3M19yZWdzLA0KKwkudHlwZSA9IFBXUkFQ
X01UNjg3MywNCisJLmFyYl9lbl9hbGwgPSAweDc3N2YsDQorCS5pbnRfZW5fYWxsID0gQklUKDQp
IHwgQklUKDUpLA0KKwkuaW50MV9lbl9hbGwgPSAwLA0KKwkuc3BpX3cgPSBQV1JBUF9NQU5fQ01E
X1NQSV9XUklURSwNCisJLndkdF9zcmMgPSBQV1JBUF9XRFRfU1JDX01BU0tfQUxMLA0KKwkuY2Fw
cyA9IFBXUkFQX0NBUF9BUkIsDQorCS5pbml0X3JlZ19jbG9jayA9IHB3cmFwX2NvbW1vbl9pbml0
X3JlZ19jbG9jaywNCisJLmluaXRfc29jX3NwZWNpZmljID0gTlVMTCwNCit9Ow0KKw0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcG1pY193cmFwcGVyX3R5cGUgcHdyYXBfbXQ3NjIyID0gew0KIAkucmVn
cyA9IG10NzYyMl9yZWdzLA0KIAkudHlwZSA9IFBXUkFQX01UNzYyMiwNCkBAIC0yMDI2LDYgKzIw
NTIsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9wd3JhcF9tYXRjaF90
YmxbXSA9IHsNCiAJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc5Ny1wd3JhcCIsDQogCQku
ZGF0YSA9ICZwd3JhcF9tdDY3OTcsDQogCX0sIHsNCisJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10Njg3My1wd3JhcCIsDQorCQkuZGF0YSA9ICZwd3JhcF9tdDY4NzMsDQorCX0sIHsNCiAJCS5j
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMi1wd3JhcCIsDQogCQkuZGF0YSA9ICZwd3JhcF9t
dDc2MjIsDQogCX0sIHsNCi0tIA0KMi42LjQNCg==

