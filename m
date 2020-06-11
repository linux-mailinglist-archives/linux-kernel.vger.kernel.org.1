Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11E41F6D36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 20:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgFKSKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 14:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgFKSKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:10:22 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C078A20838;
        Thu, 11 Jun 2020 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591899021;
        bh=F5r+9LrUwOHW/0inDk1qiwGqErLuc8dWHLIh1RG7LiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=pDRM/F/YdUtkQx3ZwbaKxxm1LqpvAy9ct66IyvpeHlBhpO6/KHVy1FaDxG3eyuYHd
         ZeouaKUljuEtB5AQFxB9BPR31KKumgQvImdVX5wxRUSoBULRLjXdZD2xTGmE53PchO
         9uTdiPw3HVmkLm6QObelbd2zZfWbAjoEN4oK9F1U=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Cc:     Kevin Hao <haokexin@gmail.com>, stable-rt@vger.kernel.org
Subject: [PATCH RT 2/4] mm: slub: Always flush the delayed empty slubs in flush_all()
Date:   Thu, 11 Jun 2020 13:10:15 -0500
Message-Id: <7f22ccf72a55f87d771a9dd0ea0c5e227b6b7b5c.1591898986.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591898986.git.zanussi@kernel.org>
References: <cover.1591898986.git.zanussi@kernel.org>
In-Reply-To: <cover.1591898986.git.zanussi@kernel.org>
References: <cover.1591898986.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Hao <haokexin@gmail.com>

v4.19.127-rt55-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 23a2c31b19e99beaf5107071b0f32a596202cdae ]

After commit f0b231101c94 ("mm/SLUB: delay giving back empty slubs to
IRQ enabled regions"), when the free_slab() is invoked with the IRQ
disabled, the empty slubs are moved to a per-CPU list and will be
freed after IRQ enabled later. But in the current codes, there is
a check to see if there really has the cpu slub on a specific cpu
before flushing the delayed empty slubs, this may cause a reference
of already released kmem_cache in a scenario like below:
	cpu 0				cpu 1
  kmem_cache_destroy()
    flush_all()
                         --->IPI       flush_cpu_slab()
                                         flush_slab()
                                           deactivate_slab()
                                             discard_slab()
                                               free_slab()
                                             c->page = NULL;
      for_each_online_cpu(cpu)
        if (!has_cpu_slab(1, s))
          continue
        this skip to flush the delayed
        empty slub released by cpu1
    kmem_cache_free(kmem_cache, s)

                                       kmalloc()
                                         __slab_alloc()
                                            free_delayed()
                                            __free_slab()
                                            reference to released kmem_cache

Fixes: f0b231101c94 ("mm/SLUB: delay giving back empty slubs to IRQ enabled regions")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 mm/slub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d243c6ef7fc9..a9473bbb1338 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2341,9 +2341,6 @@ static void flush_all(struct kmem_cache *s)
 	for_each_online_cpu(cpu) {
 		struct slub_free_list *f;
 
-		if (!has_cpu_slab(cpu, s))
-			continue;
-
 		f = &per_cpu(slub_free_list, cpu);
 		raw_spin_lock_irq(&f->lock);
 		list_splice_init(&f->list, &tofree);
-- 
2.17.1

