Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEEB2D2645
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgLHIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgLHIfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:35:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E71C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5eN9bOq5BisU3LrIXD+xvKeOuXnCMEoU0VfsvsdlUUA=; b=U93NTA6VG6BYwoSv/DlNn0AMK5
        hxtekoS7zDnZD5Pvsw1MCoJQMJXE9hVfITYKRS+mzx6VEnXF0cCeuaHa9aqe6NFdkOcpuwT4uBBVc
        hm8xMZNszIu7RUydx5CUFMRGQAfXcT4eEAVwVAdjIzxQ9KONR1PoCp8z/A6yPTrhE/B86hSZlMXM/
        xc2rVIhMbSczGsd227jdPY1BqMEq5Y7gFkpogSszahJERedv/rHAW6tqzUKD688V2yMmcXYrqzVYp
        vobr+TtDruvgK5uxrfHK6zhClr/spAEl1yy6hIwcpJsgUWlYLKA2cYyIG3yw7Cxt2vMSiA+sP8sKf
        z3Tosqsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmYRr-0005IT-84; Tue, 08 Dec 2020 08:34:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2717A3059C6;
        Tue,  8 Dec 2020 09:34:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06FF320815F05; Tue,  8 Dec 2020 09:34:12 +0100 (CET)
Date:   Tue, 8 Dec 2020 09:34:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] perf: Break deadlock involving exec_update_mutex
Message-ID: <20201208083412.GR2414@hirez.programming.kicks-ass.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
 <875z5h4b7a.fsf@x220.int.ebiederm.org>
 <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
 <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
 <20201207090953.GF3040@hirez.programming.kicks-ass.net>
 <CAHk-=wjgG=_-zONkBkKnkOv3uoVRy45hTxx8e-6Ks3j-3TVHKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgG=_-zONkBkKnkOv3uoVRy45hTxx8e-6Ks3j-3TVHKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:40:11AM -0800, Linus Torvalds wrote:
> On Mon, Dec 7, 2020 at 1:10 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > PeterZ, is there something I'm missing?
> >
> > Like this?
> >
> >   https://lkml.kernel.org/r/20200828123720.GZ1362448@hirez.programming.kicks-ass.net
> 
> Yes, except I think you should remove the old ptrace_may_access() check.

> I don't see any point at all in checking privileges twice, and I do
> see real downsides. Not just that KCSAN issue, but also lack of
> coverage (ie the second check will then effectively never be tested,
> which is bad too).

Fair enough, find below.

I suppose I'll queue the below into tip/perf/core for next merge window,
unless you want it in a hurry?

---
Subject: perf: Break deadlock involving exec_update_mutex
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 28 Aug 2020 14:37:20 +0200

Syzbot reported a lock inversion involving perf. The sore point being
perf holding exec_update_mutex() for a very long time, specifically
across a whole bunch of filesystem ops in pmu::event_init() (uprobes)
and anon_inode_getfile().

This then inverts against procfs code trying to take
exec_update_mutex.

Move the permission checks later, such that we need to hold the mutex
over less code.

Reported-by: syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11832,24 +11832,6 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_task;
 	}
 
-	if (task) {
-		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
-		if (err)
-			goto err_task;
-
-		/*
-		 * Preserve ptrace permission check for backwards compatibility.
-		 *
-		 * We must hold exec_update_mutex across this and any potential
-		 * perf_install_in_context() call for this new event to
-		 * serialize against exec() altering our credentials (and the
-		 * perf_event_exit_task() that could imply).
-		 */
-		err = -EACCES;
-		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
-			goto err_cred;
-	}
-
 	if (flags & PERF_FLAG_PID_CGROUP)
 		cgroup_fd = pid;
 
@@ -11857,7 +11839,7 @@ SYSCALL_DEFINE5(perf_event_open,
 				 NULL, NULL, cgroup_fd);
 	if (IS_ERR(event)) {
 		err = PTR_ERR(event);
-		goto err_cred;
+		goto err_task;
 	}
 
 	if (is_sampling_event(event)) {
@@ -11976,6 +11958,24 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_context;
 	}
 
+	if (task) {
+		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
+		if (err)
+			goto err_file;
+
+		/*
+		 * Preserve ptrace permission check for backwards compatibility.
+		 *
+		 * We must hold exec_update_mutex across this and any potential
+		 * perf_install_in_context() call for this new event to
+		 * serialize against exec() altering our credentials (and the
+		 * perf_event_exit_task() that could imply).
+		 */
+		err = -EACCES;
+		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+			goto err_cred;
+	}
+
 	if (move_group) {
 		gctx = __perf_event_ctx_lock_double(group_leader, ctx);
 
@@ -12151,7 +12151,10 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (move_group)
 		perf_event_ctx_unlock(group_leader, gctx);
 	mutex_unlock(&ctx->mutex);
-/* err_file: */
+err_cred:
+	if (task)
+		mutex_unlock(&task->signal->exec_update_mutex);
+err_file:
 	fput(event_file);
 err_context:
 	perf_unpin_context(ctx);
@@ -12163,9 +12166,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	 */
 	if (!event_file)
 		free_event(event);
-err_cred:
-	if (task)
-		mutex_unlock(&task->signal->exec_update_mutex);
 err_task:
 	if (task)
 		put_task_struct(task);
