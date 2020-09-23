Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C45274FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 06:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIWEKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 00:10:18 -0400
Received: from mail5.windriver.com ([192.103.53.11]:35708 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIWEKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 00:10:18 -0400
X-Greylist: delayed 3042 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 00:09:47 EDT
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 08N3GRwo028821
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 22 Sep 2020 20:16:37 -0700
Received: from pek-qzhang2-d1.wrs.com (128.224.162.183) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 20:16:16 -0700
From:   <qiang.zhang@windriver.com>
To:     <tglx@linutronix.de>, <miaoqinglang@huawei.com>,
        <elver@google.com>, <longman@redhat.com>,
        <akpm@linux-foundation.org>, <cai@gmx.us>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] debugobjects: install CPU hotplug callback
Date:   Wed, 23 Sep 2020 11:16:13 +0800
Message-ID: <20200923031613.20161-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Due to CPU hotplug, it may never be online after it's offline,
some objects in percpu pool is never free. in order to avoid
this happening, install CPU hotplug callback, call this callback
func to free objects in percpu pool when CPU going offline.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Qian Cai <cai@gmx.us>
---
 v1->v2:
 Modify submission information.

 v2->v3:
 In CPU hotplug callback func, add clear percpu pool "obj_free" operation.
 capitalize 'CPU', and use shorter preprocessor sequence.

 v3->v4:
 Add Cc and Acked-by tags

 include/linux/cpuhotplug.h |  1 +
 lib/debugobjects.c         | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 3215023d4852..0c39d57e5342 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -36,6 +36,7 @@ enum cpuhp_state {
 	CPUHP_X86_MCE_DEAD,
 	CPUHP_VIRT_NET_DEAD,
 	CPUHP_SLUB_DEAD,
+	CPUHP_DEBUG_OBJ_DEAD,
 	CPUHP_MM_WRITEBACK_DEAD,
 	CPUHP_MM_VMSTAT_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fe4557955d97..bb69a02c3e7b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
+#include <linux/cpu.h>
 
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
@@ -433,6 +434,24 @@ static void free_object(struct debug_obj *obj)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int object_cpu_offline(unsigned int cpu)
+{
+	struct debug_percpu_free *percpu_pool;
+	struct hlist_node *tmp;
+	struct debug_obj *obj;
+
+	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
+	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+	}
+	percpu_pool->obj_free = 0;
+
+	return 0;
+}
+#endif
+
 /*
  * We run out of memory. That means we probably have tons of objects
  * allocated.
@@ -1367,6 +1386,11 @@ void __init debug_objects_mem_init(void)
 	} else
 		debug_objects_selftest();
 
+#ifdef CONFIG_HOTPLUG_CPU
+	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
+					object_cpu_offline);
+#endif
+
 	/*
 	 * Increase the thresholds for allocating and freeing objects
 	 * according to the number of possible CPUs available in the system.
-- 
2.17.1

