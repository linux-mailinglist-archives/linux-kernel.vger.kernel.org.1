Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00402429C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgHLMxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:53:37 -0400
Received: from foss.arm.com ([217.140.110.172]:44656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgHLMx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:53:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF1021045;
        Wed, 12 Aug 2020 05:53:28 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 922D33F70D;
        Wed, 12 Aug 2020 05:53:27 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v5 11/17] sched/topology: Mark SD_PREFER_SIBLING as SDF_NEEDS_GROUPS
Date:   Wed, 12 Aug 2020 13:52:54 +0100
Message-Id: <20200812125300.11889-12-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812125300.11889-1-valentin.schneider@arm.com>
References: <20200812125300.11889-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD_PREFER_SIBLING is currently considered in sd_parent_degenerate() but not
in sd_degenerate(). It too hinges on load balancing, and thus won't have
any effect when set on a domain with a single group. Add it to
SD_DEGENERATE_GROUPS_MASK.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 4 +++-
 kernel/sched/topology.c        | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 4f07b405564e..75c9749a6e2d 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -131,8 +131,10 @@ SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD)
  *
  * Set up until domains start spanning NUMA nodes. Close to being a SHARED_CHILD
  * flag, but cleared below domains with SD_ASYM_CPUCAPACITY.
+ *
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_PREFER_SIBLING, 0)
+SD_FLAG(SD_PREFER_SIBLING, SDF_NEEDS_GROUPS)
 
 /*
  * sched_groups of this level overlap
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 02fd8db747b2..8064f495641b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -184,7 +184,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 	/* Flags needing groups don't count if only 1 group in parent */
 	if (parent->groups == parent->groups->next)
-		pflags &= ~(SD_DEGENERATE_GROUPS_MASK | SD_PREFER_SIBLING);
+		pflags &= ~SD_DEGENERATE_GROUPS_MASK;
 
 	if (~cflags & pflags)
 		return 0;
-- 
2.27.0

