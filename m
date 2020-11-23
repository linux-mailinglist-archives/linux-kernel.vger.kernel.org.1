Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AE92C03DC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgKWLKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:10:47 -0500
Received: from mail.wangsu.com ([123.103.51.227]:37137 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbgKWLKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:10:47 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 06:10:46 EST
Received: from fedora31.wangsu.com (unknown [59.61.78.237])
        by app2 (Coremail) with SMTP id 4zNnewD3_qZdl7tfw3cBAA--.1006S2;
        Mon, 23 Nov 2020 19:05:09 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, linf@wangsu.com
Subject: [PATCH] [RFC] init/main: fix broken buffer_init when DEFERRED_STRUCT_PAGE_INIT set
Date:   Mon, 23 Nov 2020 19:05:00 +0800
Message-Id: <20201123110500.103523-1-linf@wangsu.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewD3_qZdl7tfw3cBAA--.1006S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy3ArWDKw4kuw18ZFy5urg_yoW5Zr4kpF
        ZIkFWUJrWkAFsxtw47uwnIvrn7Jan5WF47CrW0vr9xAw12kr9FqFWvkrnrZFy0yrZIvF45
        JFWDXwn5Cw1UXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r48McIj6xkF7I0En7xvr7AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
        I20VAGYxC7MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx2
        6r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JjzmhwUUUUU=
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the booting phase if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set,
we have following callchain:

start_kernel
...
  mm_init
    mem_init
     memblock_free_all
       reset_all_zones_managed_pages
       free_low_memory_core_early
...
  buffer_init
    nr_free_buffer_pages
      zone->managed_pages
...
  rest_init
    kernel_init
      kernel_init_freeable
        page_alloc_init_late
          kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
          wait_for_completion(&pgdat_init_all_done_comp);
          ...
          files_maxfiles_init

It's clear that buffer_init depends on zone->managed_pages, but it's reset
in reset_all_zones_managed_pages after that pages are readded into
 zone->managed_pages, but when buffer_init runs this process is half done
 and most of them will finally be added till deferred_init_memmap done.
In large memory couting of nr_free_buffer_pages drifts too much, also
drifting from kernels to kernels on same hardware.

Fix is simple, it delays buffer_init run till deferred_init_memmap all done.

But as corrected by this patch, max_buffer_heads becomes very large,
the value is roughly as many as 4 times of totalram_pages, formula:
max_buffer_heads = nrpages * (10%) * (PAGE_SIZE / sizeof(struct buffer_head));

Say in a 64GB memory box we have 16777216 pages, then max_buffer_heads
turns out to be roughly 67,108,864.
In common cases, should a buffer_head be mapped to one page/block(4KB)?
So max_buffer_heads never exceeds totalram_pages.
IMO it's likely to make buffer_heads_over_limit bool value alwasy false,
then make codes 'if (buffer_heads_over_limit)' test in vmscan unnecessary.
Correct me if it's not true.

So this patch will change the original behavior related to
buffer_heads_over_limit in vmscan since we used a half done value
of zone->managed_pages before, or should we use a smaller factor(<10%) in
previous formula.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 init/main.c     | 2 --
 mm/page_alloc.c | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 20baced721ad..a3f7c3416286 100644
--- a/init/main.c
+++ b/init/main.c
@@ -58,7 +58,6 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
-#include <linux/buffer_head.h>
 #include <linux/page_ext.h>
 #include <linux/debug_locks.h>
 #include <linux/debugobjects.h>
@@ -1034,7 +1033,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	fork_init();
 	proc_caches_init();
 	uts_ns_init();
-	buffer_init();
 	key_init();
 	security_init();
 	dbg_late_init();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..2931d706fb52 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -70,6 +70,7 @@
 #include <linux/psi.h>
 #include <linux/padata.h>
 #include <linux/khugepaged.h>
+#include <linux/buffer_head.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -2103,6 +2104,8 @@ void __init page_alloc_init_late(void)
 	files_maxfiles_init();
 #endif
 
+	buffer_init();
+
 	/* Discard memblock private memory */
 	memblock_discard();
 
-- 
2.25.4

