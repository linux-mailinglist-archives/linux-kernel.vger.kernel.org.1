Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF842CCC9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgLCC2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:28:34 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54397 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729493AbgLCC2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:28:34 -0500
X-UUID: 5a3d1b56714f4046bd72a8c5bb642daa-20201203
X-UUID: 5a3d1b56714f4046bd72a8c5bb642daa-20201203
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1617248778; Thu, 03 Dec 2020 10:27:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Dec 2020 10:27:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Dec 2020 10:27:49 +0800
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
Subject: [PATCH v5 3/4] lib/test_kasan.c: add workqueue test case
Date:   Thu, 3 Dec 2020 10:27:48 +0800
Message-ID: <20201203022748.30681-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a test to verify workqueue stack recording and print it in
KASAN report.

The KASAN report was as follows(cleaned up slightly):

 BUG: KASAN: use-after-free in kasan_workqueue_uaf

 Freed by task 54:
  kasan_save_stack+0x24/0x50
  kasan_set_track+0x24/0x38
  kasan_set_free_info+0x20/0x40
  __kasan_slab_free+0x10c/0x170
  kasan_slab_free+0x10/0x18
  kfree+0x98/0x270
  kasan_workqueue_work+0xc/0x18

 Last potentially related work creation:
  kasan_save_stack+0x24/0x50
  kasan_record_wq_stack+0xa8/0xb8
  insert_work+0x48/0x288
  __queue_work+0x3e8/0xc40
  queue_work_on+0xf4/0x118
  kasan_workqueue_uaf+0xfc/0x190

Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
Acked-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---

v4:
- testcase has merge conflict, so that rebase onto the KASAN-KUNIT

---
 lib/test_kasan_module.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
index 2d68db6ae67b..62a87854b120 100644
--- a/lib/test_kasan_module.c
+++ b/lib/test_kasan_module.c
@@ -91,6 +91,34 @@ static noinline void __init kasan_rcu_uaf(void)
 	call_rcu(&global_rcu_ptr->rcu, kasan_rcu_reclaim);
 }
 
+static noinline void __init kasan_workqueue_work(struct work_struct *work)
+{
+	kfree(work);
+}
+
+static noinline void __init kasan_workqueue_uaf(void)
+{
+	struct workqueue_struct *workqueue;
+	struct work_struct *work;
+
+	workqueue = create_workqueue("kasan_wq_test");
+	if (!workqueue) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+	work = kmalloc(sizeof(struct work_struct), GFP_KERNEL);
+	if (!work) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	INIT_WORK(work, kasan_workqueue_work);
+	queue_work(workqueue, work);
+	destroy_workqueue(workqueue);
+
+	pr_info("use-after-free on workqueue\n");
+	((volatile struct work_struct *)work)->data;
+}
 
 static int __init test_kasan_module_init(void)
 {
@@ -102,6 +130,7 @@ static int __init test_kasan_module_init(void)
 
 	copy_user_test();
 	kasan_rcu_uaf();
+	kasan_workqueue_uaf();
 
 	kasan_restore_multi_shot(multishot);
 	return -EAGAIN;
-- 
2.18.0

