Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA8F29820E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 15:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416588AbgJYOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 10:25:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416477AbgJYOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 10:25:46 -0400
Date:   Sun, 25 Oct 2020 14:25:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603635943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gsqMBRjQY8o2ID+S7azVkHXDmmk1JzcdYLNIsSSeFhQ=;
        b=D6wD3v+y8ATiD+bzK4sr4Y8p8Fz+Gm+ZPzTDPA6C5gZsIPEWxawAq/oonv56Y8ZN1No2Wc
        1mADofoFerJOU8iPh05B9HMkexTC099S5LKxR5RMxF5S0iQjHm1qus0OYPV2lBo20Jo7xB
        gsUeA+HGSkQ5AX9uuR30bGcntys8qNb9K3IyE1PMAM7QI08pEzpzpmgNMAUJYimvme3FOm
        xTV98PHTLl7ZC1IYoDk1C5JTbWb2FoV85eQI8CnNqnx2SDnMtK9cAvw4qnA7mhki+BUgzg
        TO5sqjv2dhC82Z2+wtLV7BX/sN4f6Y6H7J7rXY2qmn6RqqzBlt/rV/A5ZXQdWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603635943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gsqMBRjQY8o2ID+S7azVkHXDmmk1JzcdYLNIsSSeFhQ=;
        b=RkKAgZRh6ia4p03UdldRgBAxvWVv/SdA2leHpTxBIodxTk4FO2PugUfg1f2s+ULw+nfi4L
        FabLDAsWgdta8/Bw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for 5.10-rc1
References: <160363590465.1234.11586095980767794789.tglx@nanos>
Message-ID: <160363590706.1234.6760142775707433453.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-10-25

up to:  a73f863af4ce: sched/features: Fix !CONFIG_JUMP_LABEL case


Two scheduler fixes:

  - A trivial build fix for sched_feat() to compile correctly with
    CONFIG_JUMP_LABEL=n

  - Replace a zero lenght array with a flexible array.

Thanks,

	tglx

------------------>
Juri Lelli (1):
      sched/features: Fix !CONFIG_JUMP_LABEL case

zhuguangqing (1):
      sched: Replace zero-length array with flexible-array


 kernel/sched/core.c  |  2 +-
 kernel/sched/sched.h | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8160ab5263f8..d2003a7d5ab5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -44,7 +44,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
+#ifdef CONFIG_SCHED_DEBUG
 /*
  * Debugging: various feature bits
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..df80bfcea92e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1471,7 +1471,7 @@ struct sched_group_capacity {
 	int			id;
 #endif
 
-	unsigned long		cpumask[0];		/* Balance mask */
+	unsigned long		cpumask[];		/* Balance mask */
 };
 
 struct sched_group {
@@ -1629,7 +1629,7 @@ enum {
 
 #undef SCHED_FEAT
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
+#ifdef CONFIG_SCHED_DEBUG
 
 /*
  * To support run-time toggling of sched features, all the translation units
@@ -1637,6 +1637,7 @@ enum {
  */
 extern const_debug unsigned int sysctl_sched_features;
 
+#ifdef CONFIG_JUMP_LABEL
 #define SCHED_FEAT(name, enabled)					\
 static __always_inline bool static_branch_##name(struct static_key *key) \
 {									\
@@ -1649,7 +1650,13 @@ static __always_inline bool static_branch_##name(struct static_key *key) \
 extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
 #define sched_feat(x) (static_branch_##x(&sched_feat_keys[__SCHED_FEAT_##x]))
 
-#else /* !(SCHED_DEBUG && CONFIG_JUMP_LABEL) */
+#else /* !CONFIG_JUMP_LABEL */
+
+#define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
+
+#endif /* CONFIG_JUMP_LABEL */
+
+#else /* !SCHED_DEBUG */
 
 /*
  * Each translation unit has its own copy of sysctl_sched_features to allow
@@ -1665,7 +1672,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 
 #define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
 
-#endif /* SCHED_DEBUG && CONFIG_JUMP_LABEL */
+#endif /* SCHED_DEBUG */
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;

