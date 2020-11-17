Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230F82B7233
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgKQXU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgKQXU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:58 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0305AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:58 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so22738254qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2/+KjIg2KsuaB+wK1Ze2pADHPGDZxf6qKZQSfgC7nk=;
        b=GkWpOUwzqiN2dJTg3xJr4PscdebYHJu67SesedC0saLuULs/z2m7w6Sgn6mOcSvxoW
         sSUaypQJK7hAaRP5ORM53kaTg8i9yf29xd6V3iRq2AqpnGFDE0tlUe4F0u1HDxTHFoFE
         eHbbyigrVCpQiofVEx1QxWfk9xxbFHe2HmImw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2/+KjIg2KsuaB+wK1Ze2pADHPGDZxf6qKZQSfgC7nk=;
        b=jwp6M3vOOPa7PYBMGxxgZ24tMn9Z32mjH25aE0c7BocpJN+/lSQMalF8kHE+qn5Msb
         4F/71b4BsP6k8mIREDeYN6ySI37Px88ju+wD+1k9qtiOSPYmxjgDvH38azkz0YOosUou
         Sh/wCsVYGpANRNK2VJQRLdrxGM0DTMmzi59HIJyC27BvgL2dk3aWO7xi3EWftlpazEd9
         9bOZwhujGIv4VuKvF0Wud1RD5zMjgWFGBnOPBc+hsFc0px5F2k9O31JBDHZVY87Ex0jK
         i+4Q2tLSwSDpURfdGHAJPaTz1uS0Xzv2tIhgpgB2kLLo+sSIrh6lidvVM5Fw5Oz2TYtw
         3NqA==
X-Gm-Message-State: AOAM531Kepv7tk3XjbdbWdVR58UXNqj+ee1ti/4C8TWowMHP/0LdayWd
        s/5FczH144FEQd9UuOOikMIASg==
X-Google-Smtp-Source: ABdhPJwQ0DhKBmzWmADpWL8N48Z3PpaPdtMGXz3P5V2h62Kd+Lou/E6eWBciW16+8U73rL9fWzDVxw==
X-Received: by 2002:a37:7304:: with SMTP id o4mr2172851qkc.351.1605655257205;
        Tue, 17 Nov 2020 15:20:57 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:56 -0800 (PST)
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
Subject: [PATCH -tip 23/32] sched: Add a per-thread core scheduling interface
Date:   Tue, 17 Nov 2020 18:19:53 -0500
Message-Id: <20201117232003.3580179-24-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
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
Reviewed-by: Aubrey Li <aubrey.intel@gmail.com>
Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h            |  1 +
 include/uapi/linux/prctl.h       |  3 ++
 kernel/sched/core.c              | 51 +++++++++++++++++++++++++++++---
 kernel/sys.c                     |  3 ++
 tools/include/uapi/linux/prctl.h |  3 ++
 5 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c6a3b0fa952b..79d76c78cc8e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2083,6 +2083,7 @@ void sched_core_unsafe_enter(void);
 void sched_core_unsafe_exit(void);
 bool sched_core_wait_till_safe(unsigned long ti_check);
 bool sched_core_kernel_protected(void);
+int sched_core_share_pid(pid_t pid);
 #else
 #define sched_core_unsafe_enter(ignore) do { } while (0)
 #define sched_core_unsafe_exit(ignore) do { } while (0)
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
index 7ccca355623a..a95898c75bdf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -310,6 +310,7 @@ static int __sched_core_stopper(void *data)
 }
 
 static DEFINE_MUTEX(sched_core_mutex);
+static DEFINE_MUTEX(sched_core_tasks_mutex);
 static int sched_core_count;
 
 static void __sched_core_enable(void)
@@ -4037,8 +4038,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	RB_CLEAR_NODE(&p->core_node);
 
 	/*
-	 * Tag child via per-task cookie only if parent is tagged via per-task
-	 * cookie. This is independent of, but can be additive to the CGroup tagging.
+	 * If parent is tagged via per-task cookie, tag the child (either with
+	 * the parent's cookie, or a new one). The final cookie is calculated
+	 * by concatenating the per-task cookie with that of the CGroup's.
 	 */
 	if (current->core_task_cookie) {
 
@@ -9855,7 +9857,7 @@ static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2
 	unsigned long cookie;
 	int ret = -ENOMEM;
 
-	mutex_lock(&sched_core_mutex);
+	mutex_lock(&sched_core_tasks_mutex);
 
 	/*
 	 * NOTE: sched_core_get() is done by sched_core_alloc_task_cookie() or
@@ -9954,10 +9956,51 @@ static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2
 
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
index a730c03ee607..61a3c98e36de 100644
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
index 7f0827705c9a..4c45b7dcd92d 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -247,4 +247,7 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE_SHARE		59
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.29.2.299.gdc1121823c-goog

