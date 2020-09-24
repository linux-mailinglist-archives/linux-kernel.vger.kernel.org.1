Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92063276785
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIXEG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:06:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60136 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgIXEG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:06:26 -0400
X-UUID: 888a959d97b549a499044dc089591337-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IVo58NkQ33GGKE0b3jzyWWKlUmdeJt6uk543PzI5rcE=;
        b=BU628Vj8PgwskSfSxzEK0siuGLaRpCuuQVU6AnGoF3pXFNW5myjXYZ4xIm9OiK9j2A78f6ihmbWuM1M/ZCqFeMnhc0GGl937ZiRF+ToLI+udnv+cB4OjAWDcr/ES1gTElmYUWLpPmgAN5PGzeZC13vti+901pWlQvkcZON2pB5k=;
X-UUID: 888a959d97b549a499044dc089591337-20200924
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1807994880; Thu, 24 Sep 2020 12:06:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 12:06:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 12:06:21 +0800
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
Subject: PATCH v4 5/6] kasan: add tests for workqueue stack recording
Date:   Thu, 24 Sep 2020 12:06:21 +0800
Message-ID: <20200924040621.31164-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkcyBhIHRlc3QgdG8gdmVyaWZ5IHdvcmtxdWV1ZSBzdGFjayByZWNvcmRpbmcgYW5kIHByaW50
IGl0IGluDQpLQVNBTiByZXBvcnQuDQoNClRoZSBLQVNBTiByZXBvcnQgd2FzIGFzIGZvbGxvd3Mo
Y2xlYW5lZCB1cCBzbGlnaHRseSk6DQoNCiBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBr
YXNhbl93b3JrcXVldWVfdWFmDQoNCiBGcmVlZCBieSB0YXNrIDU0Og0KICBrYXNhbl9zYXZlX3N0
YWNrKzB4MjQvMHg1MA0KICBrYXNhbl9zZXRfdHJhY2srMHgyNC8weDM4DQogIGthc2FuX3NldF9m
cmVlX2luZm8rMHgyMC8weDQwDQogIF9fa2FzYW5fc2xhYl9mcmVlKzB4MTBjLzB4MTcwDQogIGth
c2FuX3NsYWJfZnJlZSsweDEwLzB4MTgNCiAga2ZyZWUrMHg5OC8weDI3MA0KICBrYXNhbl93b3Jr
cXVldWVfd29yaysweGMvMHgxOA0KDQogTGFzdCBwb3RlbnRpYWxseSByZWxhdGVkIHdvcmsgY3Jl
YXRpb246DQogIGthc2FuX3NhdmVfc3RhY2srMHgyNC8weDUwDQogIGthc2FuX3JlY29yZF93cV9z
dGFjaysweGE4LzB4YjgNCiAgaW5zZXJ0X3dvcmsrMHg0OC8weDI4OA0KICBfX3F1ZXVlX3dvcmsr
MHgzZTgvMHhjNDANCiAgcXVldWVfd29ya19vbisweGY0LzB4MTE4DQogIGthc2FuX3dvcmtxdWV1
ZV91YWYrMHhmYy8weDE5MA0KDQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53
dUBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogTWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+
DQpSZXZpZXdlZC1ieTogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KUmV2aWV3
ZWQtYnk6IEFuZHJleSBLb25vdmFsb3YgPGFuZHJleWtudmxAZ29vZ2xlLmNvbT4NCkNjOiBBbmRy
ZXkgUnlhYmluaW4gPGFyeWFiaW5pbkB2aXJ0dW96em8uY29tPg0KQ2M6IEFsZXhhbmRlciBQb3Rh
cGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KQ2M6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFz
LmJnZ0BnbWFpbC5jb20+DQotLS0NCg0KdjQ6DQotIHRlc3RjYXNlIGhhcyBtZXJnZSBjb25mbGlj
dCwgc28gdGhhdCByZWJhc2Ugb250byB0aGUgS0FTQU4tS1VOSVQNCg0KLS0tDQogbGliL3Rlc3Rf
a2FzYW5fbW9kdWxlLmMgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL3Rlc3Rfa2Fz
YW5fbW9kdWxlLmMgYi9saWIvdGVzdF9rYXNhbl9tb2R1bGUuYw0KaW5kZXggMmU1ZTdiZTk2OTU1
Li5jM2EyZDExM2U3NTcgMTAwNjQ0DQotLS0gYS9saWIvdGVzdF9rYXNhbl9tb2R1bGUuYw0KKysr
IGIvbGliL3Rlc3Rfa2FzYW5fbW9kdWxlLmMNCkBAIC0xMTUsNiArMTE1LDM1IEBAIHN0YXRpYyBu
b2lubGluZSB2b2lkIF9faW5pdCBrYXNhbl90aW1lcl91YWYodm9pZCkNCiAJKCh2b2xhdGlsZSBz
dHJ1Y3QgdGltZXJfbGlzdCAqKXRpbWVyKS0+ZXhwaXJlczsNCiB9DQogDQorc3RhdGljIG5vaW5s
aW5lIHZvaWQgX19pbml0IGthc2FuX3dvcmtxdWV1ZV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAq
d29yaykNCit7DQorCWtmcmVlKHdvcmspOw0KK30NCisNCitzdGF0aWMgbm9pbmxpbmUgdm9pZCBf
X2luaXQga2FzYW5fd29ya3F1ZXVlX3VhZih2b2lkKQ0KK3sNCisJc3RydWN0IHdvcmtxdWV1ZV9z
dHJ1Y3QgKndvcmtxdWV1ZTsNCisJc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrOw0KKw0KKwl3b3Jr
cXVldWUgPSBjcmVhdGVfd29ya3F1ZXVlKCJrYXNhbl93cV90ZXN0Iik7DQorCWlmICghd29ya3F1
ZXVlKSB7DQorCQlwcl9lcnIoIkFsbG9jYXRpb24gZmFpbGVkXG4iKTsNCisJCXJldHVybjsNCisJ
fQ0KKwl3b3JrID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IHdvcmtfc3RydWN0KSwgR0ZQX0tFUk5F
TCk7DQorCWlmICghd29yaykgew0KKwkJcHJfZXJyKCJBbGxvY2F0aW9uIGZhaWxlZFxuIik7DQor
CQlyZXR1cm47DQorCX0NCisNCisJSU5JVF9XT1JLKHdvcmssIGthc2FuX3dvcmtxdWV1ZV93b3Jr
KTsNCisJcXVldWVfd29yayh3b3JrcXVldWUsIHdvcmspOw0KKwlkZXN0cm95X3dvcmtxdWV1ZSh3
b3JrcXVldWUpOw0KKw0KKwlwcl9pbmZvKCJ1c2UtYWZ0ZXItZnJlZSBvbiB3b3JrcXVldWVcbiIp
Ow0KKwkoKHZvbGF0aWxlIHN0cnVjdCB3b3JrX3N0cnVjdCAqKXdvcmspLT5kYXRhOw0KK30NCisN
CiBzdGF0aWMgaW50IF9faW5pdCB0ZXN0X2thc2FuX21vZHVsZV9pbml0KHZvaWQpDQogew0KIAkv
Kg0KQEAgLTEyNiw2ICsxNTUsNyBAQCBzdGF0aWMgaW50IF9faW5pdCB0ZXN0X2thc2FuX21vZHVs
ZV9pbml0KHZvaWQpDQogCWNvcHlfdXNlcl90ZXN0KCk7DQogCWthc2FuX3JjdV91YWYoKTsNCiAJ
a2FzYW5fdGltZXJfdWFmKCk7DQorCWthc2FuX3dvcmtxdWV1ZV91YWYoKTsNCiANCiAJa2FzYW5f
cmVzdG9yZV9tdWx0aV9zaG90KG11bHRpc2hvdCk7DQogCXJldHVybiAtRUFHQUlOOw0KLS0gDQoy
LjE4LjANCg==

