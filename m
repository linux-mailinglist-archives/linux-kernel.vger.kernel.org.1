Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F327678C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgIXEKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:10:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46422 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgIXEKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:10:20 -0400
X-UUID: fa50f555e6b14c81bb6e9d5d0fea0074-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jERA97XeyBTxK9uRT3LHVudEGcqfyQoFzaVX3v1wRNo=;
        b=Tvu1auoUk0g9FYSf6jotBbJKeVSRyb9lnVgpl3AH/erIGOKbm45KiBMwLXr9UAJG1RAcGQcY2UcVUx57ozW/RymS+D+RkCmOGUyNWtgWh7Ry85R7gTw4kmqM9ufzf4MW5tVFlTFSTC3iib9BseEagCxFpABmdcsVceRpeF/d05A=;
X-UUID: fa50f555e6b14c81bb6e9d5d0fea0074-20200924
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 221699063; Thu, 24 Sep 2020 12:05:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 12:05:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 12:05:13 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v4 3/6] kasan: print timer and workqueue stack
Date:   Thu, 24 Sep 2020 12:05:13 +0800
Message-ID: <20200924040513.31051-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGF1eF9zdGFja1syXSBpcyByZXVzZWQgdG8gcmVjb3JkIHRoZSBjYWxsX3JjdSgpIGNhbGwg
c3RhY2ssDQp0aW1lciBpbml0IGNhbGwgc3RhY2ssIGFuZCBlbnF1ZXVpbmcgd29yayBjYWxsIHN0
YWNrcy4gU28gdGhhdA0Kd2UgbmVlZCB0byBjaGFuZ2UgdGhlIGF1eGlsaWFyeSBzdGFjayB0aXRs
ZSBmb3IgY29tbW9uIHRpdGxlLA0KcHJpbnQgdGhlbSBpbiBLQVNBTiByZXBvcnQuDQoNClNpZ25l
ZC1vZmYtYnk6IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NClN1Z2dlc3Rl
ZC1ieTogTWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQpBY2tlZC1ieTogTWFyY28gRWx2
ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQpSZXZpZXdlZC1ieTogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtv
dkBnb29nbGUuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHJleSBLb25vdmFsb3YgPGFuZHJleWtudmxA
Z29vZ2xlLmNvbT4NCkNjOiBBbmRyZXkgUnlhYmluaW4gPGFyeWFiaW5pbkB2aXJ0dW96em8uY29t
Pg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KLS0tDQoNCnYy
Og0KLSBUaGFua3MgZm9yIE1hcmNvIHN1Z2dlc3Rpb24uDQotIFdlIG1vZGlmeSBhdXggc3RhY2sg
dGl0bGUgbmFtZSBpbiBLQVNBTiByZXBvcnQNCiAgaW4gb3JkZXIgdG8gcHJpbnQgY2FsbF9yY3Uo
KS90aW1lci93b3JrcXVldWUgc3RhY2suDQoNCi0tLQ0KIG1tL2thc2FuL3JlcG9ydC5jIHwgNCAr
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL21tL2thc2FuL3JlcG9ydC5jIGIvbW0va2FzYW4vcmVwb3J0LmMNCmluZGV4
IDRmNDlmYTZjZDFhYS4uODg2ODA5ZDBhOGRkIDEwMDY0NA0KLS0tIGEvbW0va2FzYW4vcmVwb3J0
LmMNCisrKyBiL21tL2thc2FuL3JlcG9ydC5jDQpAQCAtMTgzLDEyICsxODMsMTIgQEAgc3RhdGlj
IHZvaWQgZGVzY3JpYmVfb2JqZWN0KHN0cnVjdCBrbWVtX2NhY2hlICpjYWNoZSwgdm9pZCAqb2Jq
ZWN0LA0KIA0KICNpZmRlZiBDT05GSUdfS0FTQU5fR0VORVJJQw0KIAkJaWYgKGFsbG9jX2luZm8t
PmF1eF9zdGFja1swXSkgew0KLQkJCXByX2VycigiTGFzdCBjYWxsX3JjdSgpOlxuIik7DQorCQkJ
cHJfZXJyKCJMYXN0IHBvdGVudGlhbGx5IHJlbGF0ZWQgd29yayBjcmVhdGlvbjpcbiIpOw0KIAkJ
CXByaW50X3N0YWNrKGFsbG9jX2luZm8tPmF1eF9zdGFja1swXSk7DQogCQkJcHJfZXJyKCJcbiIp
Ow0KIAkJfQ0KIAkJaWYgKGFsbG9jX2luZm8tPmF1eF9zdGFja1sxXSkgew0KLQkJCXByX2Vycigi
U2Vjb25kIHRvIGxhc3QgY2FsbF9yY3UoKTpcbiIpOw0KKwkJCXByX2VycigiU2Vjb25kIHRvIGxh
c3QgcG90ZW50aWFsbHkgcmVsYXRlZCB3b3JrIGNyZWF0aW9uOlxuIik7DQogCQkJcHJpbnRfc3Rh
Y2soYWxsb2NfaW5mby0+YXV4X3N0YWNrWzFdKTsNCiAJCQlwcl9lcnIoIlxuIik7DQogCQl9DQot
LSANCjIuMTguMA0K

