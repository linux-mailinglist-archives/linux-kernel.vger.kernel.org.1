Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0542B721E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgKQXU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgKQXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:25 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8D3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:24 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id a13so28014qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbYtXlj95+iXlJkOqVIu3kgn38kg+QwVgoGVckAPFDU=;
        b=R9dcBfwj5h/EPk4ro1H1W5vgw50dgJdtrfn0aiTUD7OSjd1ZOHIsVOQHzwCDj77oyo
         4hE/0wwO9kXgXLWY66MFrLNyJe1HsmvzkG2ZC0803cp/NZgctuwqJUSdAyYnjdZ8d4EZ
         lc26TcdQoEdfQQRBSfDbSoqTQ17arStB3RMjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbYtXlj95+iXlJkOqVIu3kgn38kg+QwVgoGVckAPFDU=;
        b=SmIirX0JTu4CsUDCY4frNnPt88XnDoxOZXaOL7vgxlYROElfWjq3KfBq1xpDWEy7Md
         0ctZm4xmK8PpeXT9GoAKegr3JiTkvT/q66Ih0znDH+MJzOU7oNlzNqtDUMxLVHLTvWDj
         GifPzkQxj4W6MbItxFhabTH0EBPRENn5dsAeRbKrZzx4iYF5408hJKwtYH7exEpnzOo4
         diRFeKQvuMwkWzqze68nJbU5+qDQkSYIp5G3ob5a7BkDSbYZHx+RBF3MKrb2yZwb/W0K
         sA2Wo3/Ic7VxGL2TSjq5E9Squtg2XhFJRe0NK0kSAY16VhiEyLtkZGtMLavJwXNUO1ia
         oy1Q==
X-Gm-Message-State: AOAM530jf/L3OFifSGbHce2hv51ZY8Ax5lCxoTmnTS/GE6+x80lOmJxe
        O4H9EKESE5nYAlxiC1dQwgyJjw==
X-Google-Smtp-Source: ABdhPJyK3lmAa/g5+Kovuk8bmzpev+XpypQvI6OXonnfAxJjUcZ2zGjZsLFU/utEbmAMsdq8s5lovQ==
X-Received: by 2002:a37:bd5:: with SMTP id 204mr1983512qkl.377.1605655224007;
        Tue, 17 Nov 2020 15:20:24 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:23 -0800 (PST)
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 05/32] sched/fair: Add a few assertions
Date:   Tue, 17 Nov 2020 18:19:35 -0500
Message-Id: <20201117232003.3580179-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/fair.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 51483a00a755..ca35bfc0a368 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6245,6 +6245,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		task_util = uclamp_task_util(p);
 	}
 
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
 	    asym_fits_capacity(task_util, target))
 		return target;
@@ -6710,8 +6715,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
@@ -6724,6 +6727,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
 
+	/*
+	 * required for stable ->cpus_allowed
+	 */
+	lockdep_assert_held(&p->pi_lock);
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
-- 
2.29.2.299.gdc1121823c-goog

