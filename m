Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C782B276778
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIXECn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:02:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57587 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgIXECm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:02:42 -0400
X-UUID: ea9a012e0b7743eabc5607017e117eba-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RdjwgzjFAA7kh4oYttC+KDV9EMdKnsHtZfsovneYDmY=;
        b=RQvO7IqaNmBkVsbDj4dB4G4SWNPM6jQa23RnKjrfHH+EhFZNAL0qzUVBNZbWovnuZmjU3iPIpDMAe4iApJz1jRr7GpfqxUNZ7kQqhLJP8sfTsmmtOgeKu6qO9xnMlbofazft82LkG/bR3+WVG9GTf1sRh5Ld1Pd1XhChL40Q7Rk=;
X-UUID: ea9a012e0b7743eabc5607017e117eba-20200924
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2008707020; Thu, 24 Sep 2020 12:02:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 12:02:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 12:02:28 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
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
Subject: [PATCH v4 0/6] kasan: add workqueue and timer stack for generic KASAN
Date:   Thu, 24 Sep 2020 12:01:52 +0800
Message-ID: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FB7A3B37DFD44E891641141635D054C21024695F78B6E62C4D04FF435D1CC3DA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3l6Ym90IHJlcG9ydHMgbWFueSBVQUYgaXNzdWVzIGZvciB3b3JrcXVldWUgb3IgdGltZXIsIHNl
ZSBbMV0gYW5kIFsyXS4NCkluIHNvbWUgb2YgdGhlc2UgYWNjZXNzL2FsbG9jYXRpb24gaGFwcGVu
ZWQgaW4gcHJvY2Vzc19vbmVfd29yaygpLA0Kd2Ugc2VlIHRoZSBmcmVlIHN0YWNrIGlzIHVzZWxl
c3MgaW4gS0FTQU4gcmVwb3J0LCBpdCBkb2Vzbid0IGhlbHANCnByb2dyYW1tZXJzIHRvIHNvbHZl
IFVBRiBvbiB3b3JrcXVldWUuIFRoZSBzYW1lIG1heSBzdGFuZCBmb3IgdGltZXMuDQoNClRoaXMg
cGF0Y2hzZXQgaW1wcm92ZXMgS0FTQU4gcmVwb3J0cyBieSBtYWtpbmcgdGhlbSB0byBoYXZlIHdv
cmtxdWV1ZQ0KcXVldWVpbmcgc3RhY2sgYW5kIHRpbWVyIHN0YWNrIGluZm9ybWF0aW9uLiBJdCBp
cyB1c2VmdWwgZm9yIHByb2dyYW1tZXJzDQp0byBzb2x2ZSB1c2UtYWZ0ZXItZnJlZSBvciBkb3Vi
bGUtZnJlZSBtZW1vcnkgaXNzdWUuDQoNCkdlbmVyaWMgS0FTQU4gYWxzbyByZWNvcmRzIHRoZSBs
YXN0IHR3byB3b3JrcXVldWUgYW5kIHRpbWVyIHN0YWNrcyBhbmQNCnByaW50cyB0aGVtIGluIEtB
U0FOIHJlcG9ydC4gSXQgaXMgb25seSBzdWl0YWJsZSBmb3IgZ2VuZXJpYyBLQVNBTi4NCg0KWzFd
aHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9nL3N5emthbGxlci1idWdzL3NlYXJjaD9xPSUyMnVz
ZS1hZnRlci1mcmVlJTIyK3Byb2Nlc3Nfb25lX3dvcmsNClsyXWh0dHBzOi8vZ3JvdXBzLmdvb2ds
ZS5jb20vZy9zeXprYWxsZXItYnVncy9zZWFyY2g/cT0lMjJ1c2UtYWZ0ZXItZnJlZSUyMiUyMGV4
cGlyZV90aW1lcnMNClszXWh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9MTk4NDM3DQoNCldhbHRlciBXdSAoNik6DQp0aW1lcjoga2FzYW46IHJlY29yZCB0aW1lciBz
dGFjaw0Kd29ya3F1ZXVlOiBrYXNhbjogcmVjb3JkIHdvcmtxdWV1ZSBzdGFjaw0Ka2FzYW46IHBy
aW50IHRpbWVyIGFuZCB3b3JrcXVldWUgc3RhY2sNCmxpYi90ZXN0X2thc2FuLmM6IGFkZCB0aW1l
ciB0ZXN0IGNhc2UNCmxpYi90ZXN0X2thc2FuLmM6IGFkZCB3b3JrcXVldWUgdGVzdCBjYXNlDQpr
YXNhbjogdXBkYXRlIGRvY3VtZW50YXRpb24gZm9yIGdlbmVyaWMga2FzYW4NCg0KLS0tDQpDaGFu
Z2VzIHNpbmNlIHYzOg0KLSB0ZXN0Y2FzZXMgaGF2ZSBtZXJnZSBjb25mbGljdCwgc28gdGhhdCBu
ZWVkIHRvDQogIGJlIHJlYmFzZWQgb250byB0aGUgS0FTQU4tS1VOSVQuDQoNCkNoYW5nZXMgc2lu
Y2UgdjI6DQotIG1vZGlmeSBrYXNhbiBkb2N1bWVudCB0byBiZSByZWFkYWJsZSwNCiAgVGhhbmtz
IGZvciBNYXJjbyBzdWdnZXN0aW9uLg0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KLSBUaGFua3MgZm9y
IE1hcmNvIGFuZCBUaG9tYXMgc3VnZ2VzdGlvbi4NCi0gUmVtb3ZlIHVubmVjZXNzYXJ5IGNvZGUg
YW5kIGZpeCBjb21taXQgbG9nDQotIHJldXNlIGthc2FuX3JlY29yZF9hdXhfc3RhY2soKSBhbmQg
YXV4X3N0YWNrDQogIHRvIHJlY29yZCB0aW1lciBhbmQgd29ya3F1ZXVlIHN0YWNrLg0KLSBjaGFu
Z2UgdGhlIGF1eCBzdGFjayB0aXRsZSBmb3IgY29tbW9uIG5hbWUuDQoNCi0tLQ0KRG9jdW1lbnRh
dGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0IHwgIDUgKysrLS0NCmtlcm5lbC90aW1lL3RpbWVyLmMg
ICAgICAgICAgICAgICB8ICAzICsrKw0Ka2VybmVsL3dvcmtxdWV1ZS5jICAgICAgICAgICAgICAg
IHwgIDMgKysrDQpsaWIvdGVzdF9rYXNhbl9tb2R1bGUuYyAgICAgICAgICAgfCA1NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQptbS9rYXNh
bi9yZXBvcnQuYyAgICAgICAgICAgICAgICAgfCAgNCArKy0tDQo1IGZpbGVzIGNoYW5nZWQsIDY2
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p

