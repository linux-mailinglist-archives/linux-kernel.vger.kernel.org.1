Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A109A1F0393
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 01:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgFEXmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 19:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgFEXmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:42:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6171A207ED;
        Fri,  5 Jun 2020 23:42:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jhLyg-002sCP-E7; Fri, 05 Jun 2020 19:42:22 -0400
Message-ID: <20200605234222.323583308@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Jun 2020 19:41:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Liwei Song <liwei.song@windriver.com>
Subject: [PATCH RT 4/8] mm: Dont warn about atomic memory allocations during suspend
References: <20200605234149.965509211@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.4.44-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Liwei Song <liwei.song@windriver.com>

The ACPI code allocates larger amount of memory during resume. This
triggers a warning because the allocation happens with disabled
interrupts.
At this stage only one CPU is active so there should be no lock
contention. If SLUB needs to call into the buddy allocator for more
memory then it should not enable interrupts.

Limit the check to system state with more CPUs and scheduling and only
enable interrupts in SLUB at this stage.

Signed-off-by: Liwei Song <liwei.song@windriver.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: commit description, allocate_slab() hunk]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/slub.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 44a602fc8a16..bea18bbae247 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1635,7 +1635,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		enableirqs = true;
 
 #ifdef CONFIG_PREEMPT_RT
-	if (system_state > SYSTEM_BOOTING)
+	if (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND)
 		enableirqs = true;
 #endif
 	if (enableirqs)
@@ -2751,7 +2751,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	unsigned long tid;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() &&
+			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
 
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (!s)
@@ -3216,7 +3217,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	int i;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() &&
+			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
 
 	/* memcg and kmem_cache debug support */
 	s = slab_pre_alloc_hook(s, flags);
-- 
2.26.2


