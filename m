Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27522932D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390200AbgJTBos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390246AbgJTBok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:40 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE6C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:40 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so593544ior.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3SgsUK223+FY6bJR4gSyQVMXeQ4H0d1HsyCtBOHPqw=;
        b=TlO5nj34zgGg58rYhyDRNX0zsp1+srEi1hxq/zZUf1nWA2yyLd73GQ/Km5dMCzzYcS
         46GuPbVh7mSdoiYpOcxjo10bM/f3Vj6Es1FtemE+tTvAMUk8KFaSSFqmTh0anhyjFsML
         fJw5/FIhF+qK0RpklYZ5hyJUnBLdFTnEzLXT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3SgsUK223+FY6bJR4gSyQVMXeQ4H0d1HsyCtBOHPqw=;
        b=iO1/F7r9XyDLKTNIqS6IaWl2vD9q0RJHX+R8iL1OWlY3Ngh2ypLPxUgPDWwpBwzGNN
         vRH+UgiWhBUlIDQFDWJ76Iwg2HxoCrzZs0Foe2ozCXODPJaIxmvVRn4ZtcWejLC/5wTU
         ATHgkCTSC6c/CAGGtexM2u+j1ZrmqGJM/9qHcQayHueP+68gYqNVp4sCUlWrm/iiwvrq
         wwnUn86ip5WrYv2XE+XTbL4yeeDiLse2KZew3vsJm9HSN35omaOaqxmzENtA+ElS7ACX
         wuFgxFYtH9yrma7ODaw/hQqGrT8NqgjydjZH5iyuIQvg7GdOFxilESAtAUK5XLaIc/Hf
         /cig==
X-Gm-Message-State: AOAM530VW16YQ6sCgzBcyQnjOy42VZ1w3YXr7L4iiFPyMeKjYzHp/+S/
        2JAYn/HKnzhbhaufEEWnLOf2TPyBX6KfNw==
X-Google-Smtp-Source: ABdhPJz0Lri6gEUUj9fBNlU/jL+EX+iGB6qNOA1AA+lIuzvCdXI5ZOnprivi4YM0vEKhnHehGEO0Ug==
X-Received: by 2002:a6b:8f92:: with SMTP id r140mr462094iod.81.1603158279651;
        Mon, 19 Oct 2020 18:44:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:38 -0700 (PDT)
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
Subject: [PATCH v8 -tip 18/26] sched: Add a per-thread core scheduling interface
Date:   Mon, 19 Oct 2020 21:43:28 -0400
Message-Id: <20201020014336.2076526-19-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a per-thread core scheduling interface which allows a thread to share a
core with another thread, or have a core exclusively for itself.

ChromeOS uses core-scheduling to securely enable hyperthreading.  This cuts
down the keypress latency in Google docs from 150ms to 50ms while improving
the camera streaming frame rate by ~3%.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h            |  2 ++
 include/uapi/linux/prctl.h       |  3 ++
 kernel/sched/core.c              | 51 +++++++++++++++++++++++++++++---
 kernel/sys.c                     |  3 ++
 tools/include/uapi/linux/prctl.h |  3 ++
 5 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c6034c00846a..4cb76575afa8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2078,11 +2078,13 @@ void sched_core_unsafe_enter(void);
 void sched_core_unsafe_exit(void);
 bool sched_core_wait_till_safe(unsigned long ti_check);
 bool sched_core_kernel_protected(void);
+int sched_core_share_pid(pid_t pid);
 #else
 #define sched_core_unsafe_enter(ignore) do { } while (0)
 #define sched_core_unsafe_exit(ignore) do { } while (0)
 #define sched_core_wait_till_safe(ignore) do { } while (0)
 #define sched_core_kernel_protected(ignore) do { } while (0)
+#define sched_core_share_pid(pid_t pid) do { } while (0)
 #endif
 
 #endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c334e6a02e5f..217b0482aea1 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -248,4 +248,7 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE_SHARE		59
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 30a9e4cb5ce1..a0678614a056 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -310,6 +310,7 @@ static int __sched_core_stopper(void *data)
 }
 
 static DEFINE_MUTEX(sched_core_mutex);
+static DEFINE_MUTEX(sched_core_tasks_mutex);
 static int sched_core_count;
 
 static void __sched_core_enable(void)
@@ -3588,8 +3589,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	RB_CLEAR_NODE(&p->core_node);
 
 	/*
-	 * Tag child via per-task cookie only if parent is tagged via per-task
-	 * cookie. This is independent of, but can be additive to the CGroup tagging.
+	 * If parent is tagged via per-task cookie, tag the child (either with
+	 * the parent's cookie, or a new one). The final cookie is calculated
+	 * by concatenating the per-task cookie with that of the CGroup's.
 	 */
 	if (current->core_task_cookie) {
 
@@ -9301,7 +9303,7 @@ static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2
 	unsigned long cookie;
 	int ret = -ENOMEM;
 
-	mutex_lock(&sched_core_mutex);
+	mutex_lock(&sched_core_tasks_mutex);
 
 	/*
 	 * NOTE: sched_core_get() is done by sched_core_alloc_task_cookie() or
@@ -9400,10 +9402,51 @@ static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2
 
 	ret = 0;
 out_unlock:
-	mutex_unlock(&sched_core_mutex);
+	mutex_unlock(&sched_core_tasks_mutex);
 	return ret;
 }
 
+/* Called from prctl interface: PR_SCHED_CORE_SHARE */
+int sched_core_share_pid(pid_t pid)
+{
+	struct task_struct *task;
+	int err;
+
+	if (pid == 0) { /* Recent current task's cookie. */
+		/* Resetting a cookie requires privileges. */
+		if (current->core_task_cookie)
+			if (!capable(CAP_SYS_ADMIN))
+				return -EPERM;
+		task = NULL;
+	} else {
+		rcu_read_lock();
+		task = pid ? find_task_by_vpid(pid) : current;
+		if (!task) {
+			rcu_read_unlock();
+			return -ESRCH;
+		}
+
+		get_task_struct(task);
+
+		/*
+		 * Check if this process has the right to modify the specified
+		 * process. Use the regular "ptrace_may_access()" checks.
+		 */
+		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+			rcu_read_unlock();
+			err = -EPERM;
+			goto out_put;
+		}
+		rcu_read_unlock();
+	}
+
+	err = sched_core_share_tasks(current, task);
+out_put:
+	if (task)
+		put_task_struct(task);
+	return err;
+}
+
 /* CGroup interface */
 static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 {
diff --git a/kernel/sys.c b/kernel/sys.c
index 6401880dff74..17911b8680b1 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2530,6 +2530,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+	case PR_SCHED_CORE_SHARE:
+		error = sched_core_share_pid(arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 07b4f8131e36..9318f643c4b3 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -238,4 +238,7 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE_SHARE		59
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.29.0.rc1.297.gfa9743e501-goog

