Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8EF2DD306
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgLQObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:31:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgLQObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608215389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XMOyNnWEzPNuMVmQPVcGqpBzecOTXzJj+aCWyESTsRQ=;
        b=KWGQp53uzDooGlUBG/9RqpPVb/lYzMeZnJN6MPuFYqpMDN544s6/j6wEB1FW2deOhxkMiE
        E+gg9qgXHopWCW+SZ+G2QcIyHQwEAtwSAt4LTzUDBmv7a+iAMRrTXy/xfyh5imDWw08y6l
        RJXRjQEFDzt68BCn1QgJVfUP+HIvQZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-W3CPg7w4Pbi307RPLcbOag-1; Thu, 17 Dec 2020 09:29:47 -0500
X-MC-Unique: W3CPg7w4Pbi307RPLcbOag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87A2E879500;
        Thu, 17 Dec 2020 14:29:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6C0691002391;
        Thu, 17 Dec 2020 14:29:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Dec 2020 15:29:45 +0100 (CET)
Date:   Thu, 17 Dec 2020 15:29:31 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ptrace: make ptrace() fail if the tracee changed its pid
 unexpectedly
Message-ID: <20201217142931.GA8865@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose we have 2 threads, the group-leader L and a sub-theread T,
both parked in ptrace_stop(). Debugger tries to resume both threads
and does

	ptrace(PTRACE_CONT, T);
	ptrace(PTRACE_CONT, L);

If the sub-thread T execs in between, the 2nd PTRACE_CONT doesn not
resume the old leader L, it resumes the post-exec thread T which was
actually now stopped in PTHREAD_EVENT_EXEC. In this case the
PTHREAD_EVENT_EXEC event is lost, and the tracer can't know that the
tracee changed its pid.

This patch makes ptrace() fail in this case until debugger does wait()
and consumes PTHREAD_EVENT_EXEC which reports old_pid. This affects all
ptrace requests except the "asynchronous" PTRACE_INTERRUPT/KILL.

The patch doesn't add the new PTRACE_ option to not complicate the API,
and I _hope_ this won't cause any noticeable regression:

	- If debugger uses PTRACE_O_TRACEEXEC and the thread did an exec
	  and the tracer does a ptrace request without having consumed
	  the exec event, it's 100% sure that the thread the ptracer
	  thinks it is targeting does not exist anymore, or isn't the
	  same as the one it thinks it is targeting.

	- To some degree this patch adds nothing new. In the scenario
	  above ptrace(L) can fail with -ESRCH if it is called after the
	  execing sub-thread wakes the leader up and before it "steals"
	  the leader's pid.

Test-case:

	#include <stdio.h>
	#include <unistd.h>
	#include <signal.h>
	#include <sys/ptrace.h>
	#include <sys/wait.h>
	#include <errno.h>
	#include <pthread.h>
	#include <assert.h>

	void *tf(void *arg)
	{
		execve("/usr/bin/true", NULL, NULL);
		assert(0);

		return NULL;
	}

	int main(void)
	{
		int leader = fork();
		if (!leader) {
			kill(getpid(), SIGSTOP);

			pthread_t th;
			pthread_create(&th, NULL, tf, NULL);
			for (;;)
				pause();

			return 0;
		}

		waitpid(leader, NULL, WSTOPPED);

		ptrace(PTRACE_SEIZE, leader, 0,
				PTRACE_O_TRACECLONE | PTRACE_O_TRACEEXEC);
		waitpid(leader, NULL, 0);

		ptrace(PTRACE_CONT, leader, 0,0);
		waitpid(leader, NULL, 0);

		int status, thread = waitpid(-1, &status, 0);
		assert(thread > 0 && thread != leader);
		assert(status == 0x80137f);

		ptrace(PTRACE_CONT, thread, 0,0);
		/*
		 * waitid() because waitpid(leader, &status, WNOWAIT) does not
		 * report status. Why ????
		 *
		 * Why WEXITED? because we have another kernel problem connected
		 * to mt-exec.
		 */
		siginfo_t info;
		assert(waitid(P_PID, leader, &info, WSTOPPED|WEXITED|WNOWAIT) == 0);
		assert(info.si_pid == leader && info.si_status == 0x0405);

		/* OK, it sleeps in ptrace(PTRACE_EVENT_EXEC == 0x04) */
		assert(ptrace(PTRACE_CONT, leader, 0,0) == -1);
		assert(errno == ESRCH);

		assert(leader == waitpid(leader, &status, WNOHANG));
		assert(status == 0x04057f);

		assert(ptrace(PTRACE_CONT, leader, 0,0) == 0);

		return 0;
	}

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/ptrace.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..1037251ae4a5 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -169,6 +169,27 @@ void __ptrace_unlink(struct task_struct *child)
 	spin_unlock(&child->sighand->siglock);
 }
 
+static bool looks_like_a_spurious_pid(struct task_struct *task)
+{
+	int pid;
+
+	if (task->exit_code != ((PTRACE_EVENT_EXEC << 8) | SIGTRAP))
+		return false;
+
+	rcu_read_lock();
+	pid = task_pid_nr_ns(task, task_active_pid_ns(task->parent));
+	rcu_read_unlock();
+
+	if (pid == task->ptrace_message)
+		return false;
+	/*
+	 * The tracee changed its pid but the PTRACE_EVENT_EXEC event
+	 * was not wait()'ed, most probably debugger targets the old
+	 * leader which was destroyed in de_thread().
+	 */
+	return true;
+}
+
 /* Ensure that nothing can wake it up, even SIGKILL */
 static bool ptrace_freeze_traced(struct task_struct *task)
 {
@@ -179,7 +200,8 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 		return ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	if (task_is_traced(task) && !__fatal_signal_pending(task)) {
+	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
+	    !__fatal_signal_pending(task)) {
 		task->state = __TASK_TRACED;
 		ret = true;
 	}
-- 
2.25.1.362.g51ebf55


