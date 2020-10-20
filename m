Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D730B2932C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390159AbgJTBoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgJTBn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:43:59 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3380BC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:43:58 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id n5so299596ile.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XAAkRNg7A/TYOfd7TzMRVi6CP7WYBCVGkA6DPvfq6rE=;
        b=ic2+GU9qCIr0q4tZ/OA7CdybQQTIEbZ367gA6JQaD7EYLvU+9CfP+BxV/63bVsNVD5
         EK+HKnzTAhkjk1I75VTCo/xauPUjtShI9gnvk7zBsW4SlCbXkZTTSzdzcalAKuJLAgXL
         hTLGTpWv46yXBS43a5FgwJf/zWanC3ll4O33Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAAkRNg7A/TYOfd7TzMRVi6CP7WYBCVGkA6DPvfq6rE=;
        b=tHC3gThtnHWH0WMnbvnFlxtEQ6YxqJ9RrxHqzqLlTv2rGnxDLgouvJ9y8AHe4DfVyr
         N0sZd8mXLjaqVIVDYey6WHY8IwnXuHb2wZHYdWQOtigNckzQkVTuKKNTbNdplrWNdAeU
         2+e+c65wuotxhD+sdGrkvml1xeE74SxK2j0RcIlS+SU24XuKRqr2B++yCnxtJWYn6nEZ
         yi2gsxOMnd5hBDnrqOTeTdejkEj37ppW2inZhpGlQqjLQpg+YKui9JXc+lTZScNF7l7x
         xWCPVxxKwsleBHJk4QCXpggStD0m/zoMbkTYOTmM0uvQZ9Woo4GFL1qU+P4/jAwuE8VX
         3eDQ==
X-Gm-Message-State: AOAM530LjlytFy/tuE0c2MtT5WF4A1poLgxaH151PIzbva3Gw9GDiB2l
        9BMtCOASqe3w45PswiCtlpxd7g==
X-Google-Smtp-Source: ABdhPJxfv11qZLtko4h/gn2afZqdYNNLI/VJaYJRBUTrCrsEvC7UQaNgoIew9CCnVjXwqgcuvh5oMQ==
X-Received: by 2002:a92:cc92:: with SMTP id x18mr221058ilo.63.1603158237569;
        Mon, 19 Oct 2020 18:43:57 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:43:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 04/26] sched/fair: Add a few assertions
Date:   Mon, 19 Oct 2020 21:43:14 -0400
Message-Id: <20201020014336.2076526-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bd6aed63f5e3..b4bc82f46fe7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6228,6 +6228,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	}
 
 symmetric:
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if (available_idle_cpu(target) || sched_idle_cpu(target))
 		return target;
 
@@ -6670,8 +6675,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
@@ -6682,6 +6685,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
+	/*
+	 * required for stable ->cpus_allowed
+	 */
+	lockdep_assert_held(&p->pi_lock);
+
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

