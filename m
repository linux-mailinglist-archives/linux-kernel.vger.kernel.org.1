Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47F2CFD40
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgLES30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgLES3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:21 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DD0C094250
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 05:03:09 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so5314655pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 05:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibu+HPexsNJ6GCHgTCs1EnvihRdwIFloguIfEoBcFm0=;
        b=RIWJqFEUtUvKu8Fg1Zcim0D0ygw/emSaDfHLDuSMZVi1l6jU98f0+j1WCvxvvrXmbM
         Zz7Sr/edGmZx8HWClxGoOS136rCnQ1gGAPZhN7ffez6dlZGHiW+lhfJkjQnXlF/DmcGV
         j3hVd1mClJVrhdcn5tFzL/2qmSGBKn5QetJBoFw03uBntP75pIbJLNCJCW5g8A95YVar
         h1pf9RM+JYZAqyk9myiNWcGDxI851yBOCBx8Uf5/huiuzSMioyS+Ke4ayojmQfH/XBos
         gO+Ml53OUJiZ8lF7EYb8uvp4uvrtkfNLiPCa5d/7BXjnzxxV8VQ0Gw4FOZU7yaEC3a0S
         4IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibu+HPexsNJ6GCHgTCs1EnvihRdwIFloguIfEoBcFm0=;
        b=LZKeBW4lFiNmWqbaLbiuSofvz2LjBWryI7zrbaPMuE5WRkY4dyhucKAKA/LSh+d+6H
         mL0ZmzgWDB5H79hWa9cXeNERJ+/z2Ez4RknOmjrWd9iuX/ZdRk0oUTHjkInyzIeSgEzt
         gUfs+rjhDArqKdTYPrdkoUJaZMc7hdjte0vjZ6Ylu6xMmG1o0bGbeJ/DkIzR5IKNqRU7
         l8OLdi+lFsf8h3MF3hgX+K61+ImKjzlXEDqQd5FVmyFhUIPcULqSzr3YnaeZXNZKNP/+
         Rgm0jeTytVJABfEdiBk0heZvITvcf3GqyRVRXUidJPXqN7A4X5L0vuPi5L94rCjERUDz
         I4dg==
X-Gm-Message-State: AOAM531COijXqWuK2sqSH+L+0ivWcFWAx3tgomuEJp1GmqW9giUzZMhe
        8r+egxRV+zAOCntO0WBwyNnS4g==
X-Google-Smtp-Source: ABdhPJxGItJGcsCAEef158uYkZotzF/UVDU0ARQIri7AoCY66ltru3tqE9faWvDHTvvNRxMmQE/Xbw==
X-Received: by 2002:a65:5944:: with SMTP id g4mr11607407pgu.446.1607173388919;
        Sat, 05 Dec 2020 05:03:08 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id kb12sm5047790pjb.2.2020.12.05.05.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 05:03:08 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/9] mm: memcontrol: convert kernel stack account to byte-sized
Date:   Sat,  5 Dec 2020 21:02:18 +0800
Message-Id: <20201205130224.81607-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201205130224.81607-1-songmuchun@bytedance.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel stack account is the only one that counts in KiB.
This patch convert it from KiB to byte.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 2 +-
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 2 +-
 kernel/fork.c          | 8 ++++----
 mm/memcontrol.c        | 2 +-
 mm/page_alloc.c        | 2 +-
 mm/vmstat.c            | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6ffa470e2984..855886a6ba0e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -446,7 +446,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
 			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 			     nid, K(i.sharedram),
-			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
+			     nid, node_page_state(pgdat, NR_KERNEL_STACK_B) / 1024,
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 887a5532e449..c396b6cfba82 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -101,7 +101,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "SReclaimable:   ", sreclaimable);
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
 	seq_printf(m, "KernelStack:    %8lu kB\n",
-		   global_node_page_state(NR_KERNEL_STACK_KB));
+		   global_node_page_state(NR_KERNEL_STACK_B) / 1024);
 #ifdef CONFIG_SHADOW_CALL_STACK
 	seq_printf(m, "ShadowCallStack:%8lu kB\n",
 		   global_node_page_state(NR_KERNEL_SCS_KB));
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 15132adaa233..bd34416293ec 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -202,7 +202,7 @@ enum node_stat_item {
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
-	NR_KERNEL_STACK_KB,	/* measured in KiB */
+	NR_KERNEL_STACK_B,	/* measured in byte */
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 345f378e104d..2913d7c43dcb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -382,11 +382,11 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 
 	/* All stack pages are in the same node. */
 	if (vm)
-		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
+		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_B,
+				      account * THREAD_SIZE);
 	else
-		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
+		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_B,
+				      account * THREAD_SIZE);
 }
 
 static int memcg_charge_kernel_stack(struct task_struct *tsk)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 695dedf8687a..a7ec79dcb7dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1500,7 +1500,7 @@ struct memory_stat {
 static struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
-	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
+	{ "kernel_stack", 1, NR_KERNEL_STACK_B },
 	{ "percpu", 1, MEMCG_PERCPU_B },
 	{ "sock", PAGE_SIZE, MEMCG_SOCK },
 	{ "shmem", PAGE_SIZE, NR_SHMEM },
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 56e603eea1dd..c28f8e1f1ef6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5573,7 +5573,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
-			node_page_state(pgdat, NR_KERNEL_STACK_KB),
+			node_page_state(pgdat, NR_KERNEL_STACK_B) / 1024,
 #ifdef CONFIG_SHADOW_CALL_STACK
 			node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f7857a7052e4..3e3bcaf7ba7e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -353,7 +353,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
-	if (unlikely(item == NR_KERNEL_STACK_KB))
+	if (unlikely(item == NR_KERNEL_STACK_B))
 		t <<= PAGE_SHIFT;
 
 	if (unlikely(abs(x) > t)) {
@@ -575,7 +575,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		 * for all cpus in a node.
 		 */
 		t = this_cpu_read(pcp->stat_threshold);
-		if (unlikely(item == NR_KERNEL_STACK_KB))
+		if (unlikely(item == NR_KERNEL_STACK_B))
 			t <<= PAGE_SHIFT;
 
 		o = this_cpu_read(*p);
-- 
2.11.0

