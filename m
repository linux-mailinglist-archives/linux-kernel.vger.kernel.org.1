Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E8C2CC924
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 22:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgLBVtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 16:49:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52454 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgLBVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:49:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B2Lht9Q132525;
        Wed, 2 Dec 2020 21:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=EQtAcJjWM06k5F1ukd+uRLExmqkq1jUVLlj9vOQYyxc=;
 b=VfrpEXYZWDCy6zJOyFKiZsrXdtbISAzGenCu9fGabzd2e+7+qx13zMeEgHePrBws+4KW
 TY2650RGtO/qvyq5pZTz9gi6TPJGPOgbtoeCFDzjtg6qVodHMSCJ/7RMOKIts37VKyx/
 NgPav7lTvSNx4mHFr0eBXKv8Yo1Ed1UAz5++E/aFLDxLHWfCx2/qJN0hOxhsXYhUZ+TJ
 kGpMihtmUTEbnHt1jwVu5agp9F7GULSoJSgKHJOq5A+vuXcmkwyILGctBhTSYrOJi78a
 AUg/h0yJkJ819j0iSKOpPWIEeLJ2ASQ2TZfY64eMfjnfbmMR2GzlKmNM/Xbq3koJ8Os9 UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 353dyqtwa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Dec 2020 21:47:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B2LkKqp137099;
        Wed, 2 Dec 2020 21:47:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3540auxtaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Dec 2020 21:47:39 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B2LlNqa022383;
        Wed, 2 Dec 2020 21:47:24 GMT
Received: from chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com (/100.100.237.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Dec 2020 13:47:22 -0800
Date:   Wed, 2 Dec 2020 16:47:17 -0500
From:   Chris Hyser <chris.hyser@oracle.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling
 interface
Message-ID: <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-24-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=2
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1011 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=2 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:53PM -0500, Joel Fernandes (Google) wrote:
> Add a per-thread core scheduling interface which allows a thread to share a
> core with another thread, or have a core exclusively for itself.
> 
> ChromeOS uses core-scheduling to securely enable hyperthreading.  This cuts
> down the keypress latency in Google docs from 150ms to 50ms while improving
> the camera streaming frame rate by ~3%.
> 

Inline is a patch for comment to extend this interface to make it more useful.
This patch would still need to provide doc and selftests updates as well.

-chrish

---8<-----------------------

From ec3d6506fee89022d93789e1ba44d49c1b1b04dd Mon Sep 17 00:00:00 2001
From: chris hyser <chris.hyser@oracle.com>
Date: Tue, 10 Nov 2020 15:35:59 -0500
Subject: [PATCH] sched: Provide a more extensive prctl interface for core
 scheduling.

The current prctl interface is a "from" only interface allowing a task to
join an existing core scheduling group by getting the "cookie" from a
specified task/pid.

Additionally, sharing from a task without an existing core scheduling group
(cookie == 0) creates a new cookie shared between the two.

"From" functionality works well for programs modified to use the prctl(),
but many applications will not be modified simply for core scheduling.
Using a wrapper program to share the core scheduling cookie from another
task followed by an "exec" can work, but there is no means to assign a
cookie for an unmodified running task.

Simply inverting the interface to a "to"-only interface, i.e. the calling
task shares it's cookie with the specified task/pid also has limitations,
there being no means to enable tasks to join an existing core scheduling
group for instance.

The solution is to allow both, or more specifically provide a flags
argument to allow various core scheduling commands, currently FROM, TO, and
CLEAR.

The combination of FROM and TO allow a helper program to share the core
scheduling cookie of one task/core scheduling group, with additional tasks.

if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_FROM, src_pid, 0, 0) < 0)
	handle_error("src_pid sched_core failed");
if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_TO, dest_pid, 0, 0) < 0)
	handle_error("dest_pid sched_core failed");

Signed-off-by: chris hyser <chris.hyser@oracle.com>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c9efdf8..eed002e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2084,14 +2084,14 @@ void sched_core_unsafe_enter(void);
 void sched_core_unsafe_exit(void);
 bool sched_core_wait_till_safe(unsigned long ti_check);
 bool sched_core_kernel_protected(void);
-int sched_core_share_pid(pid_t pid);
+int sched_core_share_pid(unsigned long flags, pid_t pid);
 void sched_tsk_free(struct task_struct *tsk);
 #else
 #define sched_core_unsafe_enter(ignore) do { } while (0)
 #define sched_core_unsafe_exit(ignore) do { } while (0)
 #define sched_core_wait_till_safe(ignore) do { } while (0)
 #define sched_core_kernel_protected(ignore) do { } while (0)
-#define sched_core_share_pid(pid) do { } while (0)
+#define sched_core_share_pid(flags, pid) do { } while (0)
 #define sched_tsk_free(tsk) do { } while (0)
 #endif
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 217b048..f8e4e96 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -250,5 +250,8 @@ struct prctl_mm_map {
 
 /* Request the scheduler to share a core */
 #define PR_SCHED_CORE_SHARE		59
+# define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
+# define PR_SCHED_CORE_SHARE_FROM	1  /* get core_sched cookie from pid */
+# define PR_SCHED_CORE_SHARE_TO		2  /* push core_sched cookie to pid */
 
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
index 800c0f8..14feac1 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -9,6 +9,7 @@
  */
 
 #include "sched.h"
+#include "linux/prctl.h"
 
 /*
  * Wrapper representing a complete cookie. The address of the cookie is used as
@@ -456,40 +457,45 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
 }
 
 /* Called from prctl interface: PR_SCHED_CORE_SHARE */
-int sched_core_share_pid(pid_t pid)
+int sched_core_share_pid(unsigned long flags, pid_t pid)
 {
+	struct task_struct *dest;
+	struct task_struct *src;
 	struct task_struct *task;
 	int err;
 
-	if (pid == 0) { /* Recent current task's cookie. */
-		/* Resetting a cookie requires privileges. */
-		if (current->core_task_cookie)
-			if (!capable(CAP_SYS_ADMIN))
-				return -EPERM;
-		task = NULL;
-	} else {
-		rcu_read_lock();
-		task = pid ? find_task_by_vpid(pid) : current;
-		if (!task) {
-			rcu_read_unlock();
-			return -ESRCH;
-		}
-
-		get_task_struct(task);
-
-		/*
-		 * Check if this process has the right to modify the specified
-		 * process. Use the regular "ptrace_may_access()" checks.
-		 */
-		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
-			rcu_read_unlock();
-			err = -EPERM;
-			goto out;
-		}
+	rcu_read_lock();
+	task = find_task_by_vpid(pid);
+	if (!task) {
 		rcu_read_unlock();
+		return -ESRCH;
 	}
 
-	err = sched_core_share_tasks(current, task);
+	get_task_struct(task);
+
+	/*
+	 * Check if this process has the right to modify the specified
+	 * process. Use the regular "ptrace_may_access()" checks.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+		rcu_read_unlock();
+		err = -EPERM;
+		goto out;
+	}
+	rcu_read_unlock();
+
+	if (flags == PR_SCHED_CORE_CLEAR) {
+		dest = task;
+		src = NULL;
+	} else if (flags == PR_SCHED_CORE_SHARE_TO) {
+		dest = task;
+		src = current;
+	} else if (flags == PR_SCHED_CORE_SHARE_FROM) {
+		dest = current;
+		src = task;
+	}
+
+	err = sched_core_share_tasks(dest, src);
 out:
 	if (task)
 		put_task_struct(task);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index cffdfab..50c31f3 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1030,6 +1030,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 
 #ifdef CONFIG_SCHED_CORE
 	__PS("core_cookie", p->core_cookie);
+	__PS("core_task_cookie", p->core_task_cookie);
 #endif
 
 	sched_show_numa(p, m);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b3b89bd..eafb399 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1202,7 +1202,7 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p);
 void sched_core_get(void);
 void sched_core_put(void);
 
-int sched_core_share_pid(pid_t pid);
+int sched_core_share_pid(unsigned long flags, pid_t pid);
 int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
 
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sys.c b/kernel/sys.c
index 61a3c98..da52a0d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2530,9 +2530,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+#ifdef CONFIG_SCHED_CORE
 	case PR_SCHED_CORE_SHARE:
-		error = sched_core_share_pid(arg2);
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = sched_core_share_pid(arg2, arg3);
 		break;
+#endif
 	default:
 		error = -EINVAL;
 		break;
