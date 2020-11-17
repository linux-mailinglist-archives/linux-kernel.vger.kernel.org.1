Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDEE2B721C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgKQXUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgKQXUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:21 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA2C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:21 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id k4so12819136qko.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1Je6HgMdXqqPTTEiGfrVe2IpVmUl1CPHA8vxcxKJj8=;
        b=hKkEfWd00FrAj1gia/ZXZGw7J7Ls3F9GX4M27Dg/I1oqxUBqIxWZuerW9KNOOgk+Gz
         Uw5iiFswQo5C67wVFnoWyKHj8abJ49kczlPHLjklDxRSs61NgjfmeLr5JBBkThHL8vWq
         lhsoei15hEVixpBkwsU/+yZpxZvIucxO3ovEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1Je6HgMdXqqPTTEiGfrVe2IpVmUl1CPHA8vxcxKJj8=;
        b=f/JtgagDhC6gIzhE56EAmEqPpeDuTMMRWWo/yK2/YXHi/svfvMq8QJDbgq8GBiZJug
         X+qZ61sUuoGs5v9ndTxPEwufAHjzsdu+frMIQj2uXx6Qq9ZsrORDsRVx385Tcfk+07OH
         JKMOVGfMSlOcYRfNx2p0L9avHCzmH19qs7szNc6kQeyb3D4YbID9VSgxj+n71zy1qbMp
         +6hPZsEzbIjz6noYi0YEE+EHmg9PpeN19GgOzOxGn8eLVWgD1FmiBpXRBo1g3UNtMhBD
         fe7q1jSD/dH95oT/COg32p+MqHOaovjeyvjbrEo7/7taRwF6EPgmMAsBFxUx9f77a5PL
         Oi6Q==
X-Gm-Message-State: AOAM533d43HpDpJLSSYCkB7SNiZWkyfcp+oOV8nqjR2RBMiKpzcd1rO7
        +qL9WGeZB7fenkxpYc4AeSr1WA==
X-Google-Smtp-Source: ABdhPJysJnGc94YRSe6ylqCu710bVzCZb7hdevES28UNGyvp7sHSnWAOSHfXWidQl9GBeuC+NJbR9Q==
X-Received: by 2002:ae9:f507:: with SMTP id o7mr2093620qkg.420.1605655220236;
        Tue, 17 Nov 2020 15:20:20 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:19 -0800 (PST)
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
Subject: [PATCH -tip 03/32] sched/fair: Fix pick_task_fair crashes due to empty rbtree
Date:   Tue, 17 Nov 2020 18:19:33 -0500
Message-Id: <20201117232003.3580179-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

pick_next_entity() is passed curr == NULL during core-scheduling. Due to
this, if the rbtree is empty, the 'left' variable is set to NULL within
the function. This can cause crashes within the function.

This is not an issue if put_prev_task() is invoked on the currently
running task before calling pick_next_entity(). However, in core
scheduling, it is possible that a sibling CPU picks for another RQ in
the core, via pick_task_fair(). This remote sibling would not get any
opportunities to do a put_prev_task().

Fix it by refactoring pick_task_fair() such that pick_next_entity() is
called with the cfs_rq->curr. This will prevent pick_next_entity() from
crashing if its rbtree is empty.

Also this fixes another possible bug where update_curr() would not be
called on the cfs_rq hierarchy if the rbtree is empty. This could effect
cross-cpu comparison of vruntime.

Suggested-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/fair.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 12cf068eeec8..51483a00a755 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7029,15 +7029,10 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 	do {
 		struct sched_entity *curr = cfs_rq->curr;
 
-		se = pick_next_entity(cfs_rq, NULL);
-
-		if (curr) {
-			if (se && curr->on_rq)
-				update_curr(cfs_rq);
+		if (curr && curr->on_rq)
+			update_curr(cfs_rq);
 
-			if (!se || entity_before(curr, se))
-				se = curr;
-		}
+		se = pick_next_entity(cfs_rq, curr);
 
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
-- 
2.29.2.299.gdc1121823c-goog

