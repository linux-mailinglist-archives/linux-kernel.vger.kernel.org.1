Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C882D2E2997
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 05:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgLYEXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 23:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgLYEXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 23:23:40 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FCCC061573
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 20:23:00 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2so2091087pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 20:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wuq99Rn0ispZN+zR4SkouvqEn1JYbNiEALa03vYbOXg=;
        b=XFdNZ/nR+SBZmLvXnEpSUyjt2hYifQp/dyc9k2w9p5S4l019f3K0klS3P7f4QtYqir
         v5/hBqRXAwCE5ht6oM/0drLpFYekpxEC6UrUuyL2TQVVRJlMCdfaDIft2uUVTGoRE/Kc
         YMTTIgaR3PqJqAxCRGByx9HfB8ZxCxoCLqTL+lpbf6mCycQA4KmXydefCzzke/75K2Ao
         pBtFhA7nw4kZjjrk/4pepvralGIwi0bvQdeObFiWwZjC1qYuj/BEyuXYoMxbcQb7fmaI
         0Msl/qVa9HIqrboL3kEuoIDXo9vL1zaE5zVHl+aZkr0mJvkFXEhK8A0AObBEt2ot2lvQ
         lv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wuq99Rn0ispZN+zR4SkouvqEn1JYbNiEALa03vYbOXg=;
        b=BobjpffDjjMmnQamlpiuFxRZH0TN677auIDRhMIJ+ucDxXpY4eZ58AWK3U++y4YZrz
         03OgyN5K0tHEOX0gux3Sxw3r7EAEvEcn0Nq73M9CtRfU9HLTewLxYkZG5AKBlj9QxLtC
         V+2Oiqn7pEH/DJK+VEkOqMA3F+zqC9tc8tcPA36cE0Wt1Vthyoa1NOiod+p+WNN/kqRh
         0mAX6ryvt30Zz0fA5rXtiawDlM4PL/Q2SZtbH+DXQRNBia7jJMlT45OL7kfI+7mI+ybi
         r6eQMwJhOvqyyJIHsVtTMFRBMLbUia2+RxAjW5MMWbBVItLOSdbu9Tjaz0srvLPhugAo
         7q8g==
X-Gm-Message-State: AOAM530Rs+eW5YRCg/G+xTYfUtd65A4oQGKLkK2dOJtKb1E1UnWgxP0u
        o0IkofjAwUVlwtd7RJouLrzKsf+9k4yLIts1dDc=
X-Google-Smtp-Source: ABdhPJwzt8K3z6071ycept5ueCASNha0Ci1A8I9hIWbhhvdiwDGxVlF1CsVZPyDvFYMh4xA4R+crUg==
X-Received: by 2002:a63:c64:: with SMTP id 36mr31363736pgm.255.1608870178172;
        Thu, 24 Dec 2020 20:22:58 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id h12sm14229762pgk.70.2020.12.24.20.22.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Dec 2020 20:22:57 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, zhouchengming@bytedance.com
Subject: [PATCH] psi: Add PSI_CPU_FULL state
Date:   Fri, 25 Dec 2020 12:22:48 +0800
Message-Id: <20201225042248.51737-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhouchengming <zhouchengming@bytedance.com>

When I run a simple "perf bench sched pipe" test in a cgroup on my
machine, the output of "watch -d -n 1 cpu.pressure" of this cgroup
will report some avg10 10%-20%.
It's strange because there is not any other process in the cgroup.
Then I found that cpu contention/wait percentage came from outside
of the cgroup and the cpu idle latency, not wait for threads in
the cgroup.
So I think adding PSI_CPU_FULL state will be useful for container
workloads to distinguish between outside cgroup resource contention
and inside cgroup resource contention.
What's more, the PSI_CPU_FULL state includes the latency of the cpu
idle itself, so we can see the system sum latency introduced by cpu
idle state.

Signed-off-by: zhouchengming <zhouchengming@bytedance.com>
---
 include/linux/psi_types.h | 3 ++-
 kernel/sched/psi.c        | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index b95f3211566a..0a23300d49af 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -50,9 +50,10 @@ enum psi_states {
 	PSI_MEM_SOME,
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
+	PSI_CPU_FULL,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 6,
+	NR_PSI_STATES = 7,
 };
 
 enum psi_aggregators {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 967732c0766c..234047e368a5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -224,7 +224,9 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	case PSI_MEM_FULL:
 		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
 	case PSI_CPU_SOME:
-		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
+		return tasks[NR_RUNNING] > tasks[NR_ONCPU] && tasks[NR_ONCPU];
+	case PSI_CPU_FULL:
+		return tasks[NR_RUNNING] && !tasks[NR_ONCPU];
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -681,6 +683,9 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 	if (groupc->state_mask & (1 << PSI_CPU_SOME))
 		groupc->times[PSI_CPU_SOME] += delta;
 
+	if (groupc->state_mask & (1 << PSI_CPU_FULL))
+		groupc->times[PSI_CPU_FULL] += delta;
+
 	if (groupc->state_mask & (1 << PSI_NONIDLE))
 		groupc->times[PSI_NONIDLE] += delta;
 }
@@ -1018,7 +1023,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
 
-	for (full = 0; full < 2 - (res == PSI_CPU); full++) {
+	for (full = 0; full < 2; full++) {
 		unsigned long avg[3];
 		u64 total;
 		int w;
-- 
2.11.0

