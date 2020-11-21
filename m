Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE52BBC65
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgKUCuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgKUCuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:50:21 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF289C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:50:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id j19so8950661pgg.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGLrSO4JcPtE7Fq3aXXlS7aJTrE+wEjLzcEG2GILgAI=;
        b=nIFqxofc9713yGAdToFg/PvufVfzOLQ3DZQ2YeGvYqdHyXcma7Tm62VfnadhrO9pmp
         hb07tL/ZKXDXKD8Fn0eCSfEZvi7KlS6uO3TSZm7pam7nd83wIZvcl1gdXzRcPyVAno7s
         68CLMDOd2yb6uYZcW3D5lfso0GO94iSnl+4toLA3p8g/2w4rUHXeTC2Fpb6NXJXJymka
         mUI68PLK3Y6qSsiR1LTRIRAdFPOCiLDEwsfntzckwg2bHzRUfJN3zeE+LoWgwb7ZyrLM
         d2GKDs4ljw5sY3uHnQyAVROb71dJH5lvwNvHhVtA25D+Lvout7M3g9PA5nU9IEpb/Fbi
         ZSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FGLrSO4JcPtE7Fq3aXXlS7aJTrE+wEjLzcEG2GILgAI=;
        b=K6xKsR2enC3dpNPQK3KBp6UZs/wlp0hXT9rIJtg+o8nxMF1tEXWosHMnJ8+TitgKa0
         CG3V7IfHkONDNBA+s4IjT4kG44Y2Y7hrw9kf7j5fCEw8q7z/UAJ9/RvuKrBmE/tBf+Qr
         U/UrPydJYX1an1y62uRCWvSdsYBgMBMKgqaHqKT1BvSgXWZ2UV2J/lHy+fHwAMgOIFFk
         z6r6I2jc6KzOfR2L+tIACKLRnL/GI8t6egXOdH3nUhiuLLOrUu9wJn6ZG/bFNo0IdS8E
         Rp9ihvDu5Y2rLdYlbWJb16pXJHRZ0VWq70P9K8Y14etSOyYdckSABbEqoqx4awnSfELK
         4R2Q==
X-Gm-Message-State: AOAM533kDEkft3+NVsUZjJMvQxr7t8Ru5stF+gUx8lRVpBJFPqRupoQq
        FLbP4T+x5QuJwBtXkWrN+N0=
X-Google-Smtp-Source: ABdhPJzOXf+k+hIdYVnfsVHghsBqQ5xN69PuYALuJJGd2hJaQxPKvspnUn8GAqMbaxi8wVnthPRJ7g==
X-Received: by 2002:a17:90b:4b87:: with SMTP id lr7mr12574965pjb.40.1605927020496;
        Fri, 20 Nov 2020 18:50:20 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id f7sm4729283pfe.30.2020.11.20.18.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 18:50:19 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Sperbeck <jsperbeck@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: [RFC] perf/x86: Fix a warning on x86_pmu_stop()
Date:   Sat, 21 Nov 2020 11:50:11 +0900
Message-Id: <20201121025011.227781-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When large PEBS is enabled, the below warning is triggered:

  [6070379.453697] WARNING: CPU: 23 PID: 42379 at arch/x86/events/core.c:1466 x86_pmu_stop+0x95/0xa0
  ...
  [6070379.453831] Call Trace:
  [6070379.453840]  x86_pmu_del+0x50/0x150
  [6070379.453845]  event_sched_out.isra.0+0x95/0x200
  [6070379.453848]  group_sched_out.part.0+0x53/0xd0
  [6070379.453851]  __perf_event_disable+0xee/0x1e0
  [6070379.453854]  event_function+0x89/0xd0
  [6070379.453859]  remote_function+0x3e/0x50
  [6070379.453866]  generic_exec_single+0x91/0xd0
  [6070379.453870]  smp_call_function_single+0xd1/0x110
  [6070379.453874]  event_function_call+0x11c/0x130
  [6070379.453877]  ? task_ctx_sched_out+0x20/0x20
  [6070379.453880]  ? perf_mux_hrtimer_handler+0x370/0x370
  [6070379.453882]  ? event_function_call+0x130/0x130
  [6070379.453886]  perf_event_for_each_child+0x34/0x80
  [6070379.453889]  ? event_function_call+0x130/0x130
  [6070379.453891]  _perf_ioctl+0x24b/0x6a0
  [6070379.453898]  ? sched_setaffinity+0x1ad/0x2a0
  [6070379.453904]  ? _cond_resched+0x15/0x30
  [6070379.453906]  perf_ioctl+0x3d/0x60
  [6070379.453912]  ksys_ioctl+0x87/0xc0
  [6070379.453917]  __x64_sys_ioctl+0x16/0x20
  [6070379.453923]  do_syscall_64+0x52/0x180
  [6070379.453928]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The commit 3966c3feca3f ("x86/perf/amd: Remove need to check "running"
bit in NMI handler") introduced this.  It seems x86_pmu_stop can be
called recursively (like when it losts some samples) like below:

  x86_pmu_stop
    intel_pmu_disable_event  (x86_pmu_disable)
      intel_pmu_pebs_disable
        intel_pmu_drain_pebs_buffer
          x86_pmu_stop

It seems the change is only needed for AMD.  So I added a new bit to
check when it should clear the active mask.

Fixes: 3966c3feca3f ("x86/perf/amd: Remove need to check "running" bit in NMI handler")
Reported-by: John Sperbeck <jsperbeck@google.com>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/core.c   | 1 +
 arch/x86/events/core.c       | 9 +++++++--
 arch/x86/events/perf_event.h | 3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 39eb276d0277..c545fbd423df 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -927,6 +927,7 @@ static __initconst const struct x86_pmu amd_pmu = {
 	.max_period		= (1ULL << 47) - 1,
 	.get_event_constraints	= amd_get_event_constraints,
 	.put_event_constraints	= amd_put_event_constraints,
+	.late_nmi		= 1,
 
 	.format_attrs		= amd_format_attr,
 	.events_sysfs_show	= amd_event_sysfs_show,
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b802a778014..a6c12bd71e66 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1514,8 +1514,13 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
-		x86_pmu.disable(event);
-		__clear_bit(hwc->idx, cpuc->active_mask);
+		if (x86_pmu.late_nmi) {
+			x86_pmu.disable(event);
+			__clear_bit(hwc->idx, cpuc->active_mask);
+		} else {
+			__clear_bit(hwc->idx, cpuc->active_mask);
+			x86_pmu.disable(event);
+		}
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |= PERF_HES_STOPPED;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 10032f023fcc..1ffaa0fcd521 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -682,7 +682,8 @@ struct x86_pmu {
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
 			enabled_ack		:1,
-			counter_freezing	:1;
+			counter_freezing	:1,
+			late_nmi		:1;
 	/*
 	 * sysfs attrs
 	 */
-- 
2.29.2.454.gaff20da3a2-goog

