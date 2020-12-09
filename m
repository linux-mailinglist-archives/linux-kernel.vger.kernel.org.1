Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7178D2D498D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgLISzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:55:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44054 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387475AbgLISzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:55:06 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9IjM6t045036;
        Wed, 9 Dec 2020 18:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Y0IK4+Y0boYsAbFLqAV9TQ4Xmpi27erST0tZ8rCczPo=;
 b=wnL33jbwmsoqQ849gR90zx546GmHL5P7GCoBc9zBhPjuHB3zb3UFtQ9fsTynCfAsQ6cC
 GwYR75i0yWR/gwkhKoz7RqL5ty8Rx9tMgtzl/W/rLfp5f/CnNPJos9jCBhgwQO+KPYup
 KapW3oNAcSkphXkQ20u7Fptb1t5E4PndIq/8E2zJwiplDOlAhix2eli6Jcs3rVQAzWkS
 MeDDcKeDrYumr4FN5wqYyxEl//Fbog22dNe2KWpS4NgVEtkfoYvaupjqcjRtktidAK62
 McQrPqwpIoB6Jq/65TtMyU74PPK/fEE5bb4f0vC+l6kzbq0zG+TYtya+ARWQvxCqnC7G vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 357yqc1wyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 18:52:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9IiXpl053377;
        Wed, 9 Dec 2020 18:52:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 358m40pfqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 18:52:12 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9Iq7Q8015034;
        Wed, 9 Dec 2020 18:52:08 GMT
Received: from chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com (/100.100.237.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 10:52:07 -0800
Date:   Wed, 9 Dec 2020 13:52:03 -0500
From:   Chris Hyser <chris.hyser@oracle.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20201209185203.GC6876@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
 <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <20201206173418.GC201514@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206173418.GC201514@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=2 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 12:34:18PM -0500, Joel Fernandes wrote:
>
...
> Looks ok to me except the missing else { } clause you found. Also, maybe
> dest/src can be renamed to from/to to make meaning of variables more clear?
> 
> Also looking forward to the docs/test updates.
> 
> thanks!
> 
>  - Joel

I fixed the else clause, made the name changes, added the documentation and
fixed the selftests so they pass. Patch inline.

-chrish

 .../admin-guide/hw-vuln/core-scheduling.rst        | 98 ++++++++++++++++------
 include/linux/sched.h                              |  4 +-
 include/uapi/linux/prctl.h                         |  3 +
 kernel/sched/coretag.c                             | 59 ++++++++-----
 kernel/sched/debug.c                               |  1 +
 kernel/sched/sched.h                               |  2 +-
 kernel/sys.c                                       |  6 +-
 tools/include/uapi/linux/prctl.h                   |  3 +
 tools/testing/selftests/sched/test_coresched.c     | 14 +++-
 9 files changed, 136 insertions(+), 54 deletions(-)

-- >8 --
From beca9bae6750a66d8c30bbed1d6b8b26b2da05f4 Mon Sep 17 00:00:00 2001
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

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index c211a7b..0eefa9b 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -100,33 +100,83 @@ The color is an 8-bit value allowing for up to 256 unique colors.
 
 prctl interface
 ###############
-A ``prtcl(2)`` command ``PR_SCHED_CORE_SHARE`` is available to a process to request
-sharing a core with another process.  For example, consider 2 processes ``P1``
-and ``P2`` with PIDs 100 and 200. If process ``P1`` calls
-``prctl(PR_SCHED_CORE_SHARE, 200)``, the kernel makes ``P1`` share a core with ``P2``.
-The kernel performs ptrace access mode checks before granting the request.
+A ``prtcl(2)`` command ``PR_SCHED_CORE_SHARE`` provides an interface for the
+creation of and admission and removal of tasks from core scheduling groups.
 
-.. note:: This operation is not commutative. P1 calling
-          ``prctl(PR_SCHED_CORE_SHARE, pidof(P2)`` is not the same as P2 calling the
-          same for P1. The former case is P1 joining P2's group of processes
-          (which P2 would have joined with ``prctl(2)`` prior to P1's ``prctl(2)``).
+::
 
-.. note:: The core-sharing granted with prctl(2) will be subject to
-          core-sharing restrictions specified by the CGroup interface. For example
-          if P1 and P2 are a part of 2 different tagged CGroups, then they will
-          not share a core even if a prctl(2) call is made. This is analogous
-          to how affinities are set using the cpuset interface.
+    #include <sys/prctl.h>
 
-It is important to note that, on a ``CLONE_THREAD`` ``clone(2)`` syscall, the child
-will be assigned the same tag as its parent and thus be allowed to share a core
-with them. This design choice is because, for the security usecase, a
-``CLONE_THREAD`` child can access its parent's address space anyway, so there's
-no point in not allowing them to share a core. If a different behavior is
-desired, the child thread can call ``prctl(2)`` as needed.  This behavior is
-specific to the ``prctl(2)`` interface. For the CGroup interface, the child of a
-fork always shares a core with its parent.  On the other hand, if a parent
-was previously tagged via ``prctl(2)`` and does a regular ``fork(2)`` syscall, the
-child will receive a unique tag.
+    int prctl(int option, unsigned long arg2, unsigned long arg3,
+            unsigned long arg4, unsigned long arg5);
+
+option:
+    ``PR_SCHED_CORE_SHARE``
+
+arg2:
+    - ``PR_SCHED_CORE_CLEAR            0  -- clear core_sched cookie of pid``
+    - ``PR_SCHED_CORE_SHARE_FROM       1  -- get core_sched cookie from pid``
+    - ``PR_SCHED_CORE_SHARE_TO         2  -- push core_sched cookie to pid``
+
+arg3:
+    ``tid`` of the task for which the operation applies
+
+arg4 and arg5:
+    MUST be equal to 0.
+
+Creation
+~~~~~~~~
+Creation is accomplished by sharing a ''cookie'' from a process not currently in
+a core scheduling group.
+
+::
+
+    if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_FROM, src_tid, 0, 0) < 0)
+            handle_error("src_tid sched_core failed");
+
+Removal
+~~~~~~~
+Removing a task from a core scheduling group is done by:
+
+::
+
+    if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_CLEAR, clr_tid, 0, 0) < 0)
+             handle_error("clr_tid sched_core failed");
+
+Cookie Transferal
+~~~~~~~~~~~~~~~~~
+Transferring a cookie between the current and other tasks is possible using
+PR_SCHED_CORE_SHARE_FROM and PR_SCHED_CORE_SHARE_TO to inherit a cookie from a
+specified task or a share a cookie with a task. In combination this allows a
+simple helper program to pull a cookie from a task in an existing core
+scheduling group and share it with already running tasks.
+
+::
+
+    if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_FROM, from_tid, 0, 0) < 0)
+            handle_error("from_tid sched_core failed");
+
+    if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_TO, to_tid, 0, 0) < 0)
+            handle_error("to_tid sched_core failed");
+
+
+.. note:: The core-sharing granted with ``prctl(2)`` will be subject to
+          core-sharing restrictions specified by the CGroup interface. For example,
+          if tasks T1 and T2 are a part of 2 different tagged CGroups, then they will
+          not share a core even if ``prctl(2)`` is called. This is analogous to how
+          affinities are set using the cpuset interface.
+
+It is important to note that, on a ``clone(2)`` syscall with ``CLONE_THREAD`` set,
+the child will be assigned the same ''cookie'' as its parent and thus in the
+same core scheduling group.  In the security usecase, a ``CLONE_THREAD`` child
+can access its parent's address space anyway (``CLONE_THREAD`` requires
+``CLONE_SIGHAND`` which requires ``CLONE_VM``), so there's no point in not
+allowing them to share a core. If a different behavior is desired, the child
+thread can call ``prctl(2)`` as needed.  This behavior is specific to the
+``prctl(2)`` interface. For the CGroup interface, the child of a fork always
+shares a core with its parent.  On the other hand, if a parent was previously
+tagged via ``prctl(2)`` and does a regular ``fork(2)`` syscall, the child will
+receive a unique tag.
 
 Design/Implementation
 ---------------------
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
index 9b587a1..6452137 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -8,6 +8,7 @@
  * Initial interfacing code  by Peter Ziljstra.
  */
 
+#include <linux/prctl.h>
 #include "sched.h"
 
 /*
@@ -438,36 +439,48 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
 }
 
 /* Called from prctl interface: PR_SCHED_CORE_SHARE */
-int sched_core_share_pid(pid_t pid)
+int sched_core_share_pid(unsigned long flags, pid_t pid)
 {
+	struct task_struct *to;
+	struct task_struct *from;
 	struct task_struct *task;
 	int err;
 
-	if (!pid) { /* Reset current task's cookie. */
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
+		to = task;
+		from = NULL;
+	} else if (flags == PR_SCHED_CORE_SHARE_TO) {
+		to = task;
+		from = current;
+	} else if (flags == PR_SCHED_CORE_SHARE_FROM) {
+		to = current;
+		from = task;
+	} else {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = sched_core_share_tasks(to, from);
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
index 53f0f58..3e0b9df 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1229,7 +1229,7 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p);
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
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 4c45b7d..cd37bbf 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -249,5 +249,8 @@ struct prctl_mm_map {
 
 /* Request the scheduler to share a core */
 #define PR_SCHED_CORE_SHARE		59
+# define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
+# define PR_SCHED_CORE_SHARE_FROM	1  /* get core_sched cookie from pid */
+# define PR_SCHED_CORE_SHARE_TO		2  /* push core_sched cookie to pid */
 
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/testing/selftests/sched/test_coresched.c b/tools/testing/selftests/sched/test_coresched.c
index 70ed275..6ce612e 100644
--- a/tools/testing/selftests/sched/test_coresched.c
+++ b/tools/testing/selftests/sched/test_coresched.c
@@ -23,6 +23,9 @@
 
 #ifndef PR_SCHED_CORE_SHARE
 #define PR_SCHED_CORE_SHARE 59
+# define PR_SCHED_CORE_CLEAR            0
+# define PR_SCHED_CORE_SHARE_FROM       1
+# define PR_SCHED_CORE_SHARE_TO         2
 #endif
 
 #ifndef DEBUG_PRINT
@@ -391,9 +394,14 @@ struct task_state *add_task(char *p)
 
 	    pid = mem->pid_share;
 	    mem->pid_share = 0;
-	    if (pid == -1)
-		pid = 0;
-	    prctl(PR_SCHED_CORE_SHARE, pid);
+
+	    if (pid == -1) {
+		if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CLEAR, getpid(), 0, 0))
+		    perror("prctl() PR_SCHED_CORE_CLEAR failed");
+	    } else {
+		if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_FROM, pid, 0, 0))
+		    perror("prctl() PR_SCHED_CORE_SHARE_FROM failed");
+	    }
 	    pthread_mutex_unlock(&mem->m);
 	    pthread_cond_signal(&mem->cond_par);
 	}
