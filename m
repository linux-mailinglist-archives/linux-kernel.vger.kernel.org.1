Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16243276788
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIXEIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:08:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45158 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgIXEIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:08:45 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 00:08:44 EDT
X-UUID: 031d0cc632804df7b22e8a729a49ec48-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dMII3+0XheNBeDRCJOnd6NRZNf7iDHcFRVLV7dSXF+k=;
        b=KvhTLfP/K7dh3HStSf2sbxwwBlNFmP8LjxilGy8Wx8sUimh4QPK6zX5mO1PUxFCvD5CltoNG+XDyn9OS60OO/f64cAagKo19Bg8M4qOG5pAw6w9Qh19k/wfSl/5Wwd7kNMpN20qKKC68GjuJDAUS216Zu2iLw+uRL3Di++Nsh0g=;
X-UUID: 031d0cc632804df7b22e8a729a49ec48-20200924
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1673301738; Thu, 24 Sep 2020 12:03:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 12:03:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 12:03:37 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
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
Subject: [PATCH v4 1/6] timer: kasan: record timer stack
Date:   Thu, 24 Sep 2020 12:03:35 +0800
Message-ID: <20200924040335.30934-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBhbmFseXplIHVzZS1hZnRlci1mcmVlIG9yIGRvdWJsZS1mcmVlIGlzc3VlLCByZWNvcmRp
bmcgdGhlIHRpbWVyDQpzdGFja3MgaXMgaGVscGZ1bCB0byBwcmVzZXJ2ZSB1c2FnZSBoaXN0b3J5
IHdoaWNoIHBvdGVudGlhbGx5IGdpdmVzDQphIGhpbnQgYWJvdXQgdGhlIGFmZmVjdGVkIGNvZGUu
DQoNClJlY29yZCB0aGUgbW9zdCByZWNlbnQgdHdvIHRpbWVyIGluaXQgY2FsbHMgaW4gS0FTQU4g
d2hpY2ggYXJlIHByaW50ZWQNCm9uIGZhaWx1cmUgaW4gdGhlIEtBU0FOIHJlcG9ydC4NCg0KRm9y
IHRpbWVycyBpdCBoYXMgdHVybmVkIG91dCB0byBiZSB1c2VmdWwgdG8gcmVjb3JkIHRoZSBzdGFj
ayB0cmFjZQ0Kb2YgdGhlIHRpbWVyIGluaXQgY2FsbC4gQmVjYXVzZSBpZiB0aGUgVUFGIHJvb3Qg
Y2F1c2UgaXMgaW4gdGltZXIgaW5pdCwNCnRoZW4gdXNlciBjYW4gc2VlIEtBU0FOIHJlcG9ydCB0
byBnZXQgd2hlcmUgaXQgaXMgcmVnaXN0ZXJlZCBhbmQgZmluZA0Kb3V0IHRoZSByb290IGNhdXNl
LiBJdCBkb24ndCBuZWVkIHRvIGVuYWJsZSBERUJVR19PQkpFQ1RTX1RJTUVSUywNCmJ1dCB0aGV5
IGhhdmUgYSBjaGFuY2UgdG8gZmluZCBvdXQgdGhlIHJvb3QgY2F1c2UuDQoNClNpZ25lZC1vZmYt
Ynk6IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NClN1Z2dlc3RlZC1ieTog
TWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQpTdWdnZXN0ZWQtYnk6IFRob21hcyBHbGVp
eG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KQWNrZWQtYnk6IE1hcmNvIEVsdmVyIDxlbHZlckBn
b29nbGUuY29tPg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNv
bT4NClJldmlld2VkLWJ5OiBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2dsZS5jb20+
DQpDYzogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4NCkNjOiBBbGV4
YW5kZXIgUG90YXBlbmtvIDxnbGlkZXJAZ29vZ2xlLmNvbT4NCkNjOiBKb2huIFN0dWx0eiA8am9o
bi5zdHVsdHpAbGluYXJvLm9yZz4NCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4NCkNjOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQotLS0NCg0KdjI6DQot
IFRoYW5rcyBmb3IgTWFyY28gYW5kIFRob21hcyBzdWdnZXN0aW9uLg0KLSBSZW1vdmUgdW5uZWNl
c3NhcnkgY29kZSBhbmQgZml4IGNvbW1pdCBsb2cNCi0gcmV1c2Uga2FzYW5fcmVjb3JkX2F1eF9z
dGFjaygpIGFuZCBhdXhfc3RhY2sNCiAgdG8gcmVjb3JkIHRpbWVyIGFuZCB3b3JrcXVldWUgc3Rh
Y2suDQoNCi0tLQ0KIGtlcm5lbC90aW1lL3RpbWVyLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3RpbWVyLmMgYi9r
ZXJuZWwvdGltZS90aW1lci5jDQppbmRleCBhMTY3NjRiMDExNmUuLjFlZDhmOGFjYTdmNSAxMDA2
NDQNCi0tLSBhL2tlcm5lbC90aW1lL3RpbWVyLmMNCisrKyBiL2tlcm5lbC90aW1lL3RpbWVyLmMN
CkBAIC03OTYsNiArNzk2LDkgQEAgc3RhdGljIHZvaWQgZG9faW5pdF90aW1lcihzdHJ1Y3QgdGlt
ZXJfbGlzdCAqdGltZXIsDQogCXRpbWVyLT5mdW5jdGlvbiA9IGZ1bmM7DQogCXRpbWVyLT5mbGFn
cyA9IGZsYWdzIHwgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKTsNCiAJbG9ja2RlcF9pbml0X21hcCgm
dGltZXItPmxvY2tkZXBfbWFwLCBuYW1lLCBrZXksIDApOw0KKw0KKwkvKiByZWNvcmQgdGhlIHRp
bWVyIHN0YWNrIGluIG9yZGVyIHRvIHByaW50IGl0IGluIEtBU0FOIHJlcG9ydCAqLw0KKwlrYXNh
bl9yZWNvcmRfYXV4X3N0YWNrKHRpbWVyKTsNCiB9DQogDQogLyoqDQotLSANCjIuMTguMA0K

