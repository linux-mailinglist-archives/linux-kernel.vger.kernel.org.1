Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917642CCC73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgLCCWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:22:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48951 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727811AbgLCCWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:22:37 -0500
X-UUID: aeebf121efbd4d459fec7a872a8ac5b6-20201203
X-UUID: aeebf121efbd4d459fec7a872a8ac5b6-20201203
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2076224499; Thu, 03 Dec 2020 10:21:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Dec 2020 10:21:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Dec 2020 10:21:49 +0800
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
Subject: [PATCH v5 0/4] kasan: add workqueue stack for generic KASAN
Date:   Thu, 3 Dec 2020 10:21:48 +0800
Message-ID: <20201203022148.29754-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reports many UAF issues for workqueue, see [1].
In some of these access/allocation happened in process_one_work(),
we see the free stack is useless in KASAN report, it doesn't help
programmers to solve UAF for workqueue issue.

This patchset improves KASAN reports by making them to have workqueue
queueing stack. It is useful for programmers to solve use-after-free
or double-free memory issue.

Generic KASAN also records the last two workqueue stacks and prints
them in KASAN report. It is only suitable for generic KASAN.

[1]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22+process_one_work
[2]https://bugzilla.kernel.org/show_bug.cgi?id=198437

Walter Wu (4):
workqueue: kasan: record workqueue stack
kasan: print workqueue stack
lib/test_kasan.c: add workqueue test case
kasan: update documentation for generic kasan

---
Changes since v4:
- Not found timer use case, so that remove timer patch
- remove a mention of call_rcu() from the kasan_record_aux_stack()
  Thanks for Dmitry and Alexander suggestion.

Changes since v3:
- testcases have merge conflict, so that need to
  be rebased onto the KASAN-KUNIT.

Changes since v2:
- modify kasan document to be readable,
  Thanks for Marco suggestion.

Changes since v1:
- Thanks for Marco and Thomas suggestion.
- Remove unnecessary code and fix commit log
- reuse kasan_record_aux_stack() and aux_stack
  to record timer and workqueue stack.
- change the aux stack title for common name.

---
Documentation/dev-tools/kasan.rst |  5 +++--
kernel/workqueue.c                |  3 +++
lib/test_kasan_module.c           | 29 +++++++++++++++++++++++++++++
mm/kasan/generic.c                |  4 +---
mm/kasan/report.c                 |  4 ++--
5 files changed, 38 insertions(+), 7 deletions(-)
