Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747F9276780
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIXEFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:05:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59694 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgIXEFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:05:53 -0400
X-UUID: 4f037dcdbe284f00a0fd594db2bdaf24-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PimmuaElZUMsgbQjwJ8de8rcFyaYrVbSXAmqAq7D2xA=;
        b=rzaNtTpRz2b66QfQkp+d00sFmLYUTxrf4XZqzY99dEM1uCJaiK/bM1iAr3NgYm3rKxxDMCi5VntKi+bt5mdLm6Z6F4FgZOtxm+5DLc/0AVHPJWdyYDZ9LTETxcJ/GygoLL4urp8WGmiqNl9Vqg4MzjNOQB2/6NjMmAvHp4A50kA=;
X-UUID: 4f037dcdbe284f00a0fd594db2bdaf24-20200924
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1895011425; Thu, 24 Sep 2020 12:05:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 12:05:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 12:05:47 +0800
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
Subject: [PATCH v4 4/6] kasan: add tests for timer stack recording
Date:   Thu, 24 Sep 2020 12:05:48 +0800
Message-ID: <20200924040548.31112-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkcyBhIHRlc3QgdG8gdmVyaWZ5IHRpbWVyIHN0YWNrIHJlY29yZGluZyBhbmQgcHJpbnQgaXQN
CmluIEtBU0FOIHJlcG9ydC4NCg0KVGhlIEtBU0FOIHJlcG9ydCB3YXMgYXMgZm9sbG93cyhjbGVh
bmVkIHVwIHNsaWdodGx5KToNCg0KIEJVRzogS0FTQU46IHVzZS1hZnRlci1mcmVlIGluIGthc2Fu
X3RpbWVyX3VhZg0KDQogRnJlZWQgYnkgdGFzayAwOg0KICBrYXNhbl9zYXZlX3N0YWNrKzB4MjQv
MHg1MA0KICBrYXNhbl9zZXRfdHJhY2srMHgyNC8weDM4DQogIGthc2FuX3NldF9mcmVlX2luZm8r
MHgyMC8weDQwDQogIF9fa2FzYW5fc2xhYl9mcmVlKzB4MTBjLzB4MTcwDQogIGthc2FuX3NsYWJf
ZnJlZSsweDEwLzB4MTgNCiAga2ZyZWUrMHg5OC8weDI3MA0KICBrYXNhbl90aW1lcl9mdW5jdGlv
bisweDFjLzB4MjgNCg0KIExhc3QgcG90ZW50aWFsbHkgcmVsYXRlZCB3b3JrIGNyZWF0aW9uOg0K
ICBrYXNhbl9zYXZlX3N0YWNrKzB4MjQvMHg1MA0KICBrYXNhbl9yZWNvcmRfdG1yX3N0YWNrKzB4
YTgvMHhiOA0KICBpbml0X3RpbWVyX2tleSsweGYwLzB4MjQ4DQogIGthc2FuX3RpbWVyX3VhZisw
eDVjLzB4ZDgNCg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0
ZWsuY29tPg0KQWNrZWQtYnk6IE1hcmNvIEVsdmVyIDxlbHZlckBnb29nbGUuY29tPg0KUmV2aWV3
ZWQtYnk6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NClJldmlld2VkLWJ5OiBB
bmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2dsZS5jb20+DQpDYzogQW5kcmV5IFJ5YWJp
bmluIDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4NCkNjOiBBbGV4YW5kZXIgUG90YXBlbmtvIDxn
bGlkZXJAZ29vZ2xlLmNvbT4NCkNjOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21h
aWwuY29tPg0KLS0tDQoNCnY0Og0KLSB0ZXN0Y2FzZSBoYXMgbWVyZ2UgY29uZmxpY3QsIHNvIHRo
YXQgcmViYXNlIG9udG8gdGhlIEtBU0FOLUtVTklUDQoNCi0tLQ0KIGxpYi90ZXN0X2thc2FuX21v
ZHVsZS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9saWIvdGVzdF9rYXNhbl9tb2R1bGUuYyBi
L2xpYi90ZXN0X2thc2FuX21vZHVsZS5jDQppbmRleCAyZDY4ZGI2YWU2N2IuLmQ4MjM0YTFkYjhj
OSAxMDA2NDQNCi0tLSBhL2xpYi90ZXN0X2thc2FuX21vZHVsZS5jDQorKysgYi9saWIvdGVzdF9r
YXNhbl9tb2R1bGUuYw0KQEAgLTEyLDYgKzEyLDcgQEANCiAjaW5jbHVkZSA8bGludXgvcHJpbnRr
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5o
Pg0KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KIA0KICNpbmNsdWRlICIuLi9tbS9rYXNhbi9r
YXNhbi5oIg0KIA0KQEAgLTkxLDYgKzkyLDI5IEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5p
dCBrYXNhbl9yY3VfdWFmKHZvaWQpDQogCWNhbGxfcmN1KCZnbG9iYWxfcmN1X3B0ci0+cmN1LCBr
YXNhbl9yY3VfcmVjbGFpbSk7DQogfQ0KIA0KK3N0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBr
YXNhbl90aW1lcl9mdW5jdGlvbihzdHJ1Y3QgdGltZXJfbGlzdCAqdGltZXIpDQorew0KKwlkZWxf
dGltZXIodGltZXIpOw0KKwlrZnJlZSh0aW1lcik7DQorfQ0KKw0KK3N0YXRpYyBub2lubGluZSB2
b2lkIF9faW5pdCBrYXNhbl90aW1lcl91YWYodm9pZCkNCit7DQorCXN0cnVjdCB0aW1lcl9saXN0
ICp0aW1lcjsNCisNCisJdGltZXIgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgdGltZXJfbGlzdCks
IEdGUF9LRVJORUwpOw0KKwlpZiAoIXRpbWVyKSB7DQorCQlwcl9lcnIoIkFsbG9jYXRpb24gZmFp
bGVkXG4iKTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwl0aW1lcl9zZXR1cCh0aW1lciwga2FzYW5f
dGltZXJfZnVuY3Rpb24sIDApOw0KKwlhZGRfdGltZXIodGltZXIpOw0KKwltc2xlZXAoMTAwKTsN
CisNCisJcHJfaW5mbygidXNlLWFmdGVyLWZyZWUgb24gdGltZXJcbiIpOw0KKwkoKHZvbGF0aWxl
IHN0cnVjdCB0aW1lcl9saXN0ICopdGltZXIpLT5leHBpcmVzOw0KK30NCiANCiBzdGF0aWMgaW50
IF9faW5pdCB0ZXN0X2thc2FuX21vZHVsZV9pbml0KHZvaWQpDQogew0KQEAgLTEwMiw2ICsxMjYs
NyBAQCBzdGF0aWMgaW50IF9faW5pdCB0ZXN0X2thc2FuX21vZHVsZV9pbml0KHZvaWQpDQogDQog
CWNvcHlfdXNlcl90ZXN0KCk7DQogCWthc2FuX3JjdV91YWYoKTsNCisJa2FzYW5fdGltZXJfdWFm
KCk7DQogDQogCWthc2FuX3Jlc3RvcmVfbXVsdGlfc2hvdChtdWx0aXNob3QpOw0KIAlyZXR1cm4g
LUVBR0FJTjsNCi0tIA0KMi4xOC4wDQo=

