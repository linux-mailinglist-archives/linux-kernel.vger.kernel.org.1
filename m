Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D32932CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbgJTBo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390215AbgJTBoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:22 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389DC0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:22 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p9so331877ilr.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnyYMXiGicOgLWW4phC2Gw+5nqSVkiAGa5vUTQsEwIA=;
        b=yF2XdoLiolRC88u+ugatoOiHN6RUHJzJjikVUp8TsQe3Lc/bNWSi2NGEY3/ws6M8pd
         YHVt7xQE+0jcZF8UPLKmORTL5eLW6J/+Pd+m5UMJtsP3xlDezONG/SgI8sZM3vG9cbIN
         zjvhuqT/ffLGyrlb/R0O+xzqhJYaoDJjFhcOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnyYMXiGicOgLWW4phC2Gw+5nqSVkiAGa5vUTQsEwIA=;
        b=RSwwt9f2w8hVJjXcgBRSV1SyruE6i+ViRsRSBIgkvyhC4FIyDVg/hQf0O2ilrDRcho
         7h1Fa9IqFlWGM0nV/uzDWtUeBPyukIVXYFmyOCUtC3zut0J7axYT2B+INECrICKIayy7
         eOh/HmXA0zWQV4AG16FqLl240bAuvewZlPlIhTZAp6v1Fxa4HAeFRA8EXLbPW5UoSEsv
         oD5Kk7N3PkJ4bnTTK5PPh6bMKQbYWyk6wn3PECqAnclVIsDoyZ+e0oY4mGiVdixB/gwb
         EYPTFV3gGv4GbBr41ZffmEA70Zk54E7Cljppan2awm8alKVkWtHNOppF6uoT0YBoJoMz
         C7MQ==
X-Gm-Message-State: AOAM533CldxYDzPgkjUXqaBuOI0S0GLpcsWZljROYlKq0qNfokKBUZp/
        ONp90Eprxc2TCEIRfvkbDPwGTg==
X-Google-Smtp-Source: ABdhPJxi/xEF5CDSBDy4Nr2zisFTlP9HPr9WE7i6YB9vhXjDR2AQOVxRiZJo4MS/9c55Dhcx1MQJ3Q==
X-Received: by 2002:a92:cd0e:: with SMTP id z14mr232657iln.135.1603158261952;
        Mon, 19 Oct 2020 18:44:21 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:21 -0700 (PDT)
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
Subject: [PATCH v8 -tip 12/26] arch/x86: Add a new TIF flag for untrusted tasks
Date:   Mon, 19 Oct 2020 21:43:22 -0400
Message-Id: <20201020014336.2076526-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
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
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/include/asm/thread_info.h | 2 ++
 kernel/sched/sched.h               | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index c448fcfa1b82..45b6dbdf116e 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -99,6 +99,7 @@ struct thread_info {
 #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_UNSAFE_RET   	26	/* On return to process/guest, perform safety checks. */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
@@ -129,6 +130,7 @@ struct thread_info {
 #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
+#define _TIF_UNSAFE_RET 	(1 << TIF_UNSAFE_RET)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d0c7a7f87d73..f7e2d8a3be8e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2769,3 +2769,9 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 
 void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+
+#ifdef CONFIG_SCHED_CORE
+#ifndef TIF_UNSAFE_RET
+#define TIF_UNSAFE_RET (0)
+#endif
+#endif
-- 
2.29.0.rc1.297.gfa9743e501-goog

