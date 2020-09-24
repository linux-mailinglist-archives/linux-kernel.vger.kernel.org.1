Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E020927678A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgIXEJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:09:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45983 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgIXEJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:09:37 -0400
X-UUID: 2c4428be2c694ba0a92af8d06a46805c-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yih98KEkzJLkFoWBf8Qw3xVcaUYkPNvBrd8fXNNVY9A=;
        b=Abc3bR3E6jmrqWBRfsFdGr4CWrwilzbkqUjO0RC7VWu4+N40YxKvJ2hymgZ1YIM2IG7g2XU8PmnfcR4SN45mKMBI62piRxnjTfH5Gd/MUL3p+S2LvL10bCNqaOMjY94WBk9qDSkqxh0IPNiI4cG2iJBVYKzyx/g/ErcSU79elnc=;
X-UUID: 2c4428be2c694ba0a92af8d06a46805c-20200924
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1562696609; Thu, 24 Sep 2020 12:04:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 12:04:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 12:04:22 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
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
Subject: [PATCH v4 2/6] workqueue: kasan: record workqueue stack
Date:   Thu, 24 Sep 2020 12:04:22 +0800
Message-ID: <20200924040422.30995-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVjb3JkcyB0aGUgbGFzdCB0d28gZW5xdWV1aW5nIHdvcmsgY2FsbCBzdGFja3MgaW4gb3JkZXIg
dG8gcHJpbnQgdGhlbQ0KaW4gS0FTQU4gcmVwb3J0LiBJdCBpcyB1c2VmdWwgZm9yIHByb2dyYW1t
ZXJzIHRvIHNvbHZlIHVzZS1hZnRlci1mcmVlDQpvciBkb3VibGUtZnJlZSBtZW1vcnkgd29ya3F1
ZXVlIGlzc3VlLg0KDQpGb3Igd29ya3F1ZXVlIGl0IGhhcyB0dXJuZWQgb3V0IHRvIGJlIHVzZWZ1
bCB0byByZWNvcmQgdGhlIGVucXVldWluZw0Kd29yayBjYWxsIHN0YWNrcy4gQmVjYXVzZSB1c2Vy
IGNhbiBzZWUgS0FTQU4gcmVwb3J0IHRvIGRldGVybWluZQ0Kd2hldGhlciBpdCBpcyByb290IGNh
dXNlLiBUaGV5IGRvbid0IG5lZWQgdG8gZW5hYmxlIGRlYnVnb2JqZWN0cywNCmJ1dCB0aGV5IGhh
dmUgYSBjaGFuY2UgdG8gZmluZCBvdXQgdGhlIHJvb3QgY2F1c2UuDQoNClNpZ25lZC1vZmYtYnk6
IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NClN1Z2dlc3RlZC1ieTogTWFy
Y28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQpBY2tlZC1ieTogTWFyY28gRWx2ZXIgPGVsdmVy
QGdvb2dsZS5jb20+DQpBY2tlZC1ieTogVGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPg0KUmV2aWV3
ZWQtYnk6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NClJldmlld2VkLWJ5OiBB
bmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2dsZS5jb20+DQpDYzogQW5kcmV5IFJ5YWJp
bmluIDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4NCkNjOiBBbGV4YW5kZXIgUG90YXBlbmtvIDxn
bGlkZXJAZ29vZ2xlLmNvbT4NCkNjOiBMYWkgSmlhbmdzaGFuIDxqaWFuZ3NoYW5sYWlAZ21haWwu
Y29tPg0KLS0tDQoNCnYyOg0KLSBUaGFua3MgZm9yIE1hcmNvIHN1Z2dlc3Rpb24uDQotIFJlbW92
ZSB1bm5lY2Vzc2FyeSBjb2RlDQotIHJldXNlIGthc2FuX3JlY29yZF9hdXhfc3RhY2soKSBhbmQg
YXV4X3N0YWNrDQogIHRvIHJlY29yZCB0aW1lciBhbmQgd29ya3F1ZXVlIHN0YWNrDQoNCi0tLQ0K
DQoga2VybmVsL3dvcmtxdWV1ZS5jIHwgMyArKysNCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9rZXJuZWwvd29ya3F1ZXVlLmMgYi9rZXJuZWwvd29ya3F1
ZXVlLmMNCmluZGV4IGM0MWMzYzE3Yjg2YS4uNWZlYTdkYzkxODBmIDEwMDY0NA0KLS0tIGEva2Vy
bmVsL3dvcmtxdWV1ZS5jDQorKysgYi9rZXJuZWwvd29ya3F1ZXVlLmMNCkBAIC0xMzI0LDYgKzEz
MjQsOSBAQCBzdGF0aWMgdm9pZCBpbnNlcnRfd29yayhzdHJ1Y3QgcG9vbF93b3JrcXVldWUgKnB3
cSwgc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrLA0KIHsNCiAJc3RydWN0IHdvcmtlcl9wb29sICpw
b29sID0gcHdxLT5wb29sOw0KIA0KKwkvKiByZWNvcmQgdGhlIHdvcmsgY2FsbCBzdGFjayBpbiBv
cmRlciB0byBwcmludCBpdCBpbiBLQVNBTiByZXBvcnRzICovDQorCWthc2FuX3JlY29yZF9hdXhf
c3RhY2sod29yayk7DQorDQogCS8qIHdlIG93biBAd29yaywgc2V0IGRhdGEgYW5kIGxpbmsgKi8N
CiAJc2V0X3dvcmtfcHdxKHdvcmssIHB3cSwgZXh0cmFfZmxhZ3MpOw0KIAlsaXN0X2FkZF90YWls
KCZ3b3JrLT5lbnRyeSwgaGVhZCk7DQotLSANCjIuMTguMA0K

