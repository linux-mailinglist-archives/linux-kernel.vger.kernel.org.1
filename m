Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA42A2932DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbgJTBpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgJTBoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:46 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0210C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:45 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l16so269192ilt.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZaoqEfti+60sAgPkWgID3qpU9arAGqqBfDYeDbxdJ4=;
        b=QiP8Vz2JUTa7KOe9aSFQz13dW9Qye2C5vZTKH+WK1yN+DxcQs66Z7TJIh1smG2GAjq
         UwKagly+cnGxfzgwXKXTx/IPDD+sawDzI5kUk1a/nTG5Wk12R4UIqDCnq4bI3u1aDQYK
         BlxR1tOqa4+sTzTauGKpHXN+jOyGdH469CNm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZaoqEfti+60sAgPkWgID3qpU9arAGqqBfDYeDbxdJ4=;
        b=TM8E9MBwCzXGVMb6rObPfwnBzMKo4ns2oTLVdNNAaYb8DAtAFMFuO+xN5rbaZEeu5Q
         rMVH1wKFqF03Vt+NQtB3tX1VJvgQPRBjk5UT480q2yyIF7UaqtJf/Qupm5pIIEoa5E6g
         unL6pZgZ9K2vJAy+5HIzNlBBN0e0OvpCI3QJllXFO+qfodtV5iboIzXef4dM9jmL16cz
         jD3GIzHOMycLQsDmxg5JhomOQxg/cnoB0ZkXmyNBh67+dIJh3qu65SXk8zKWwhVINIt1
         uMAf6qUKJFsiJ4UkUd5etEbvEBM1hZh0k/hrOCF7Wq88bpvxgOHcKSMuyUa97YY6zMJd
         DJLA==
X-Gm-Message-State: AOAM53232AfUmcaifCeOmAE1kOG53Q5JRvBUGgjJTd7IBBq+o5cyG5u/
        mirpQQav1ePrf7iR1FvzwID3rw==
X-Google-Smtp-Source: ABdhPJyT300ugbTPiGtKor04hTDjD8720EO+Osh1FJEHYoPBG+BBsedWSD7azdtQ0O4mG1rnhcrRjg==
X-Received: by 2002:a92:ce09:: with SMTP id b9mr269399ilo.14.1603158285333;
        Mon, 19 Oct 2020 18:44:45 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:44 -0700 (PDT)
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
Subject: [PATCH v8 -tip 20/26] sched: Release references to the per-task cookie on exit
Date:   Mon, 19 Oct 2020 21:43:30 -0400
Message-Id: <20201020014336.2076526-21-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During exit, we have to free the references to a cookie that might be shared by
many tasks. This commit therefore ensures when the task_struct is released, any
references to cookies that it holds are also released.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h | 2 ++
 kernel/fork.c         | 1 +
 kernel/sched/core.c   | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4cb76575afa8..eabd96beff92 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2079,12 +2079,14 @@ void sched_core_unsafe_exit(void);
 bool sched_core_wait_till_safe(unsigned long ti_check);
 bool sched_core_kernel_protected(void);
 int sched_core_share_pid(pid_t pid);
+void sched_tsk_free(struct task_struct *tsk);
 #else
 #define sched_core_unsafe_enter(ignore) do { } while (0)
 #define sched_core_unsafe_exit(ignore) do { } while (0)
 #define sched_core_wait_till_safe(ignore) do { } while (0)
 #define sched_core_kernel_protected(ignore) do { } while (0)
 #define sched_core_share_pid(pid_t pid) do { } while (0)
+#define sched_tsk_free(tsk) do { } while (0)
 #endif
 
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index b9c289d0f4ef..a39248a02fdd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -736,6 +736,7 @@ void __put_task_struct(struct task_struct *tsk)
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
+	sched_tsk_free(tsk);
 
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 42aa811eab14..61e1dcf11000 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9631,6 +9631,14 @@ static int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
 
 	return 0;
 }
+
+void sched_tsk_free(struct task_struct *tsk)
+{
+	if (!tsk->core_task_cookie)
+		return;
+	sched_core_put_task_cookie(tsk->core_task_cookie);
+	sched_core_put();
+}
 #endif
 
 static struct cftype cpu_legacy_files[] = {
-- 
2.29.0.rc1.297.gfa9743e501-goog

