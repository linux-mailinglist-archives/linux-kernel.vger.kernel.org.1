Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E40928C847
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 07:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgJMFb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 01:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbgJMFb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 01:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602567085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3gXkblNuA+4TXam8vUvjMhTpzKuZHtBWbPpGrDicnwQ=;
        b=JYZyWJyT90qURyem3Oham9UCckyZFxBT0mFZ1cyrSy6nm4cIao9hBvaMO2MCy0eSrz1o0N
        7mHwRpiw41JnUTO0KYq8kKGCJpNB/fyhUscTUXowL6Zh/+Gs9EbzJ1xnTy9U4h8xG1GWwO
        NA61VxLNyYEwWUb0Vjp1HbmHh264SHs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-KqxLZwF-PWCmARyYfd7NKg-1; Tue, 13 Oct 2020 01:31:22 -0400
X-MC-Unique: KqxLZwF-PWCmARyYfd7NKg-1
Received: by mail-wr1-f71.google.com with SMTP id l15so10363517wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 22:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3gXkblNuA+4TXam8vUvjMhTpzKuZHtBWbPpGrDicnwQ=;
        b=jT5G+Bi0kLXEDm4PHgQm/3rgbYqitlfw+PqeomPEzV9s9JjNTLYNfxPJIIqfL9xegZ
         O9+1aDmsvdqDoJ8M4o3R0pHB1qOeigNLaBT4JmONk7M0EgQZgiBUGaVF22ARBUn2ZkVS
         BrJteb9Z7YohDIdI6SxRFRZHpwGcW95P8jfGvuJ4kK265GKnR59+DzO7uGruA74T8HYU
         dG6WhSs4neUxA2a96trg0vsPR4aOgBfotAKZSwgzQmzswPIA8XH7A3JTFJhljZoJR3rV
         6q3fF70bb5JBJDRi53bwAwZ7FBTgjxij3i2GDUpJsG2zrIpDf4GVYCneIfLtqSsbEfix
         FGVA==
X-Gm-Message-State: AOAM533rYcCCr5NNttpbn1Ye2QERtXbtOJJQMuU+yHBurmd9lswNNp50
        d5/v2mYtyL7jY4ubpKM7zw2NR2xGnVxReqSaTcYs6py4jaQwHXvUhzt6lZMje6K1muOE2ATS9+3
        IgwG5K5wLIvcpC2Op+Vium9Qc
X-Received: by 2002:adf:82f7:: with SMTP id 110mr32741527wrc.261.1602567081609;
        Mon, 12 Oct 2020 22:31:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeE2vHBq/iU1A90nw7EPZtODx/5lIqzmcv3Epwyo9guHoDfrxmnbpxBVn4AsfTJS3PD7IYew==
X-Received: by 2002:adf:82f7:: with SMTP id 110mr32741510wrc.261.1602567081388;
        Mon, 12 Oct 2020 22:31:21 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.23.182])
        by smtp.gmail.com with ESMTPSA id o194sm24796959wme.24.2020.10.12.22.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 22:31:20 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        patrick.bellasi@matbug.net, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, chris.redpath@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2] sched/features: Fix !CONFIG_JUMP_LABEL case
Date:   Tue, 13 Oct 2020 07:31:14 +0200
Message-Id: <20201013053114.160628-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 765cc3a4b224e ("sched/core: Optimize sched_feat() for
!CONFIG_SCHED_DEBUG builds") made sched features static for
!CONFIG_SCHED_DEBUG configurations, but overlooked the CONFIG_
SCHED_DEBUG enabled and !CONFIG_JUMP_LABEL cases. For the latter echoing
changes to /sys/kernel/debug/sched_features has the nasty effect of
effectively changing what sched_features reports, but without actually
changing the scheduler behaviour (since different translation units get
different sysctl_sched_features).

Fix CONFIG_SCHED_DEBUG and !CONFIG_JUMP_LABEL configurations by properly
restructuring ifdefs.

Fixes: 765cc3a4b224e ("sched/core: Optimize sched_feat() for !CONFIG_SCHED_DEBUG builds")
Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---
v1->v2
 - use CONFIG_JUMP_LABEL (and not the old HAVE_JUMP_LABEL) [Valentin]
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/sched.h | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3dc415f58bd7..a7949e3ed7e7 100644
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
index 28709f6b0975..8d1ca65db3b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
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
-- 
2.26.2

