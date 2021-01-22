Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456BC3009FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbhAVRiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbhAVPrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:47:00 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AB3C061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:46:20 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c12so4401096qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtQk9ayfQEr7teEjfKhm3TM2bpkUNiYFTP1mYC82faI=;
        b=nFcOl081Xte0SFGjAz5dWz7J7E3Zagw3yR75YI76jAFF+YowQoOXK93BIQskvy4Xx3
         a3ni6e68yQDldThWjY8upxca5MZIsE7GewNhmpN0xZEyAOYNlTtePEFha9cs2gXF0q4j
         lyYTClt0a3VKVJF8AgihsEb0yE84Sbe+pBo2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtQk9ayfQEr7teEjfKhm3TM2bpkUNiYFTP1mYC82faI=;
        b=QxJ+dB64iv178qrhXPfY5PYFL935a+ebnswpCG8GIPDIKdLpKI0/9TKSox8y3sWGPc
         qwOkohtSEBjqgYycf6263uEiFwHw7pBqy66HhdFT009FGecHH8qUjdcudSexqdjbf2nG
         Ww9fsV0jK5aurhHrh09iOCvkOVT7/EFXDsgEMIjeynoaDMTFsbu2o1KsT/6hhaK+5ZMD
         G46bhujnnDQqDTB+Hovq/08WRgdItDUdW4v8rae9ss5nMpLdivbA2TNP2OwiyhPYGpE2
         xFGFVej86CJBYk1Xq0IVKCVrQ0m0oqerLei8Naw8827CuUzV/ARq0qN4UIIMDDlh169r
         PbTQ==
X-Gm-Message-State: AOAM531FQcj732tns+d9v7drIAJvod1ekuCnOcij9xfVCht2haHTWt5P
        4PBTmUsKvcQvI0rRqLVYw+pwGdPldZgaww==
X-Google-Smtp-Source: ABdhPJzBOe5fTuzDhuV/LlNZD6ayOcWoK8UeH3kJOzZfvIbx11p795QL1375uxIukztUi9ZkgUBz1g==
X-Received: by 2002:ac8:4896:: with SMTP id i22mr4745895qtq.381.1611330379145;
        Fri, 22 Jan 2021 07:46:19 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z190sm6353124qkb.133.2021.01.22.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 07:46:18 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Rate limit calls to update_blocked_averages() for NOHZ
Date:   Fri, 22 Jan 2021 10:46:00 -0500
Message-Id: <20210122154600.1722680-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an octacore ARM64 device running ChromeOS Linux kernel v5.4, I found
that there are a lot of calls to update_blocked_averages(). This causes
the schedule loop to slow down to taking upto 500 micro seconds at
times (due to newidle load balance). I have also seen this manifest in
the periodic balancer.

Closer look shows that the problem is caused by the following
ingredients:
1. If the system has a lot of inactive CGroups (thanks Dietmar for
suggesting to inspect /proc/sched_debug for this), this can make
__update_blocked_fair() take a long time.

2. The device has a lot of CPUs in a cluster which causes schedutil in a
shared frequency domain configuration to be slower than usual. (the load
average updates also try to update the frequency in schedutil).

3. The CPU is running at a low frequency causing the scheduler/schedutil
code paths to take longer than when running at a high CPU frequency.

The fix is simply rate limit the calls to update_blocked_averages to 20
times per second. It appears that updating the blocked average less
often is sufficient. Currently I see about 200 calls per second
sometimes, which seems overkill.

schbench shows a clear improvement with the change:

Without patch:
~/schbench -t 2 -m 2 -r 5
Latency percentiles (usec) runtime 5 (s) (212 total samples)
        50.0th: 210 (106 samples)
        75.0th: 619 (53 samples)
        90.0th: 665 (32 samples)
        95.0th: 703 (11 samples)
        *99.0th: 12656 (8 samples)
        99.5th: 12784 (1 samples)
        99.9th: 13424 (1 samples)
        min=15, max=13424

With patch:
~/schbench -t 2 -m 2 -r 5
Latency percentiles (usec) runtime 5 (s) (214 total samples)
        50.0th: 188 (108 samples)
        75.0th: 238 (53 samples)
        90.0th: 623 (32 samples)
        95.0th: 657 (12 samples)
        *99.0th: 717 (7 samples)
        99.5th: 725 (2 samples)
        99.9th: 725 (0 samples)

Cc: Paul McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Suggested-by: Dietmar Eggeman <dietmar.eggemann@arm.com>
Co-developed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..fe2dc0024db5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8381,7 +8381,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
 	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
 		return false;
 
-	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
+	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick + (HZ/20)))
 		return true;
 
 	update_blocked_averages(cpu);
-- 
2.30.0.280.ga3ce27912f-goog

