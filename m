Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383452B722E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgKQXUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgKQXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:47 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED89C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:46 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id b16so274125qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3KZP1TKcPyHGoEqB2YkDWACDaKR4Bua1+vT8adxYIFc=;
        b=eEyY/Dj76jrQ0uonACB7+8FAwlTii9iPxAt0U97iwWB31KAJ3AxH+tdJ0j+LPYK3IZ
         rR+xOGSX+9wG7/eTIwNGdknZTO4PsIJ9S9uDhcTy5OmxjofbKxBRY0lSg9LMJCDr9dBN
         m3HSA+USa9L36L6e5r8Nnn9jqSRpi1qbV3QgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3KZP1TKcPyHGoEqB2YkDWACDaKR4Bua1+vT8adxYIFc=;
        b=PldWVGnc3XtUzlnHyvQ8opmAJQFj8sAFaLql1/0qScoYiJGSeFT+asxcl+HJog7Dss
         98nkWbPwdyQ6P3O36UU1x6Qv3mztNSVvcVldngQ9qwz4sm6fRXMHsuVWjEle8d4+/cDl
         kplvF1nUaG20SybvUtCb+cAkPXYeR67INqdw34aoJPB2AwB1rSjPwx/ogEo6eD/q0WmS
         dYi3aYzfj9tuEpoZSXYAQemmoMu+DY6ogvng4KrZxFvPUZMoFbfeqOJNrE1diVpOGchv
         QBdSWw98YoQ40MSlW6XX3zBF3lxVjvFabjHEAF+3MStJ8+onlqdi/eeHo6Dm1RFJaNqH
         aMYg==
X-Gm-Message-State: AOAM530ONO26reuNXZ3F5184PMs6YMzyai+kNsYRgJJ/GmJg4QlvNiu4
        /1xWgNOChhglL5ytC/qb4t/aAQ==
X-Google-Smtp-Source: ABdhPJzLgoMIhtV0bRfurooM0aiq0qbYZ2A7f7ez7RCedOcuq6ovL36nzFmPB63GEN8VR6j/wXJScQ==
X-Received: by 2002:ac8:5059:: with SMTP id h25mr1737959qtm.283.1605655246165;
        Tue, 17 Nov 2020 15:20:46 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:45 -0800 (PST)
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
Subject: [PATCH -tip 17/32] arch/x86: Add a new TIF flag for untrusted tasks
Date:   Tue, 17 Nov 2020 18:19:47 -0500
Message-Id: <20201117232003.3580179-18-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new TIF flag to indicate whether the kernel needs to be careful
and take additional steps to mitigate micro-architectural issues during
entry into user or guest mode.

This new flag will be used by the series to determine if waiting is
needed or not, during exit to user or guest mode.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Reviewed-by: Aubrey Li <aubrey.intel@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/include/asm/thread_info.h | 2 ++
 kernel/sched/sched.h               | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 93277a8d2ef0..ae4f6196e38c 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -99,6 +99,7 @@ struct thread_info {
 #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_UNSAFE_RET		26	/* On return to process/guest, perform safety checks. */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
@@ -127,6 +128,7 @@ struct thread_info {
 #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
+#define _TIF_UNSAFE_RET 	(1 << TIF_UNSAFE_RET)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5c258ab64052..615092cb693c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2851,3 +2851,9 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+#ifdef CONFIG_SCHED_CORE
+#ifndef TIF_UNSAFE_RET
+#define TIF_UNSAFE_RET (0)
+#endif
+#endif
-- 
2.29.2.299.gdc1121823c-goog

