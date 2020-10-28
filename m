Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC05329D456
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgJ1VvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgJ1VvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:51:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE3CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:51:01 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k65so1129030oih.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8TBnjK5wZnIi4uA7A5I6QhsQOmsey9iIWx5yjyuhrm8=;
        b=MV8tNFDch4xo8/kRa0T+S+PjvrdY2jBFYYkNZUMlzKayjmIGPayGPAsPHnL2e0wVEl
         lAkfL1AOb+1O1sysTc+jk7G8UvgiSG7gef9E1E+FQt2n8Qh3g/tTH47flqyMP5yk3tHG
         ZSr8WnmaLf5hRd2Od2W0qsr58TtEuuHpwV/F4xWCp9RgmBNTcpWCtdzbBxkpRNIyWmuE
         zNLtt723PQ0ssr6ddcio9HHs4arvs7BIl26SR/kuCkwqHab6S7wvCJFWv2JFJlITP3Gr
         1TzMCHJk1+6XKp/FIDuql//zanBThHE2OSNzXsD+Cab8MzpQBpBCN7nqUhW/IKLMU4Yu
         EE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8TBnjK5wZnIi4uA7A5I6QhsQOmsey9iIWx5yjyuhrm8=;
        b=NFiFUhykrQW44WXjagqHTcnWqr9FHFs6LTpTBvm4ZIJpBb2fgCF+MYyls3JCns/WqV
         IfY+NGX6SIcjKsOcAML2P4MU7wDjSIl1SKHQUdA4GM7I8nkYepdjB0rcP6e1zSZA5QTs
         STl6HabPSzteU5t4n0D4bKsWj5FMmSjp0WmeQkxx705xiaY4KezU6q5oR1090zU7QBSb
         Apvey+J92ztIyo0nzGRoAUUAxc8kAuxmYhnpLPnDRAkSB7L7f0OaOWf569TUT5hivN1g
         X5pAJOSY8tpRu2N9KNJj0iJbkDQLeD4HzRTRr56Jxsra0MmEIavtxAUUvK2UVoLybOlJ
         jUrg==
X-Gm-Message-State: AOAM531JTz5eQsgcsQy28Pr7dQH2wZtBPoFsTK/e9iWmQUr3tDKM3drF
        p6hVxelJJTdy2bc1xvItsVX7mMOedtQPy+uS
X-Google-Smtp-Source: ABdhPJxpBaJdcsWjbhnGsxbZWpYTjw5lI9EKLbjpsLDoVj2RuXMvZ21MXZsZeDe1oM2ySoOL62fDfQ==
X-Received: by 2002:a17:90a:7c03:: with SMTP id v3mr6534197pjf.233.1603887656589;
        Wed, 28 Oct 2020 05:20:56 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id a143sm6329137pfd.138.2020.10.28.05.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:20:56 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     "' Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
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
        Tim Chen ' <tim.c.chen@intel.com>
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH 8/8] sched: Add newlines after declarations
Date:   Wed, 28 Oct 2020 05:19:17 -0700
Message-Id: <20201028121917.635203-9-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028121917.635203-1-jbwyatt4@gmail.com>
References: <20201028121917.635203-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silences checkpatch warnings.

Issue reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7bf20110fdf5..b38cdb54ec81 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5034,6 +5034,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (!fi_before) {
 		for_each_cpu(i, smt_mask) {
 			struct rq *rq_i = cpu_rq(i);
+
 			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
 		}
 	}
@@ -5200,6 +5201,7 @@ next_class:;
 	if (!fi_before && rq->core->core_forceidle) {
 		for_each_cpu(i, smt_mask) {
 			struct rq *rq_i = cpu_rq(i);
+
 			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
 		}
 	}
-- 
2.28.0

