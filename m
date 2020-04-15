Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9151AB326
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 23:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442319AbgDOVKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 17:10:12 -0400
Received: from foss.arm.com ([217.140.110.172]:52514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442222AbgDOVFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:05:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEA0E113E;
        Wed, 15 Apr 2020 14:05:26 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E99283F6C4;
        Wed, 15 Apr 2020 14:05:25 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v3 2/9] sched/debug: Make sd->flags sysctl read-only
Date:   Wed, 15 Apr 2020 22:05:05 +0100
Message-Id: <20200415210512.805-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200415210512.805-1-valentin.schneider@arm.com>
References: <20200415210512.805-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing to the sysctl of a sched_domain->flags directly updates the value of
the field, and goes nowhere near update_top_cache_domain(). This means that
the cached domain pointers can end up containing stale data (e.g. the
domain pointed to doesn't have the relevant flag set anymore).

Explicit domain walks that check for flags will be affected by
the write, but this won't be in sync with the cached pointers which will
still point to the domains that were cached at the last sched_domain
build.

In other words, writing to this interface is playing a dangerous game. It
could be made to trigger an update of the cached sched_domain pointers when
written to, but this does not seem to be worth the trouble. Make it
read-only.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a562df57a86e..00796b0a2723 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -258,7 +258,7 @@ sd_alloc_ctl_domain_table(struct sched_domain *sd)
 	set_table_entry(&table[2], "busy_factor",	  &sd->busy_factor,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[3], "imbalance_pct",	  &sd->imbalance_pct,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[4], "cache_nice_tries",	  &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0444, proc_dointvec_minmax);
 	set_table_entry(&table[6], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
 	set_table_entry(&table[7], "name",		  sd->name,	       CORENAME_MAX_SIZE, 0444, proc_dostring);
 	/* &table[8] is terminator */
-- 
2.24.0

