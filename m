Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0965129286D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgJSNmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727297AbgJSNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603114968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBdVgTR9Pn1ZkqEutWCBGbgnTOCup2ZKWn1QYQAV580=;
        b=XA4NvjvFU8ra4r5HH45/f9KNVm1s19WNo7Iuk8SjE+boB2nTtLrUlEVyco6qtMVVTZ5ReB
        MrX6Onpe4UCCFTp+tjfbdEGg/ftNCuWgXPj9wAbALHfCc5BUFiX+k4G6a91Ru1VTAMVZ4a
        5O78lxm75ae5f92GXW+7p7ZVm0M74sI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-DmfV2hEXMR2HHafeJp9J5A-1; Mon, 19 Oct 2020 09:42:43 -0400
X-MC-Unique: DmfV2hEXMR2HHafeJp9J5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67770835B49;
        Mon, 19 Oct 2020 13:42:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.71])
        by smtp.corp.redhat.com (Postfix) with SMTP id D24285B4AD;
        Mon, 19 Oct 2020 13:42:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 19 Oct 2020 15:42:41 +0200 (CEST)
Date:   Mon, 19 Oct 2020 15:42:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com>
Subject: [PATCH] ptrace: fix task_join_group_stop() for the case when current
 is traced
Message-ID: <20201019134237.GA18810@redhat.com>
References: <000000000000da06e405b0b20f1e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000da06e405b0b20f1e@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This testcase

	#include <stdio.h>
	#include <unistd.h>
	#include <signal.h>
	#include <sys/ptrace.h>
	#include <sys/wait.h>
	#include <pthread.h>
	#include <assert.h>

	void *tf(void *arg)
	{
		return NULL;
	}

	int main(void)
	{
		int pid = fork();
		if (!pid) {
			kill(getpid(), SIGSTOP);

			pthread_t th;
			pthread_create(&th, NULL, tf, NULL);

			return 0;
		}

		waitpid(pid, NULL, WSTOPPED);

		ptrace(PTRACE_SEIZE, pid, 0, PTRACE_O_TRACECLONE);
		waitpid(pid, NULL, 0);

		ptrace(PTRACE_CONT, pid, 0,0);
		waitpid(pid, NULL, 0);

		int status;
		int thread = waitpid(-1, &status, 0);
		assert(thread > 0 && thread != pid);
		assert(status == 0x80137f);

		return 0;
	}

fails and triggers WARN_ON_ONCE(!signr) in do_jobctl_trap().

This is because task_join_group_stop() has 2 problems when current is traced:

	1. We can't rely on the "JOBCTL_STOP_PENDING" check, a stopped tracee
	   can be woken up by debugger and it can clone another thread which
	   should join the group-stop.

	   We need to check group_stop_count || SIGNAL_STOP_STOPPED.

	2. If SIGNAL_STOP_STOPPED is already set, we should not increment
	   sig->group_stop_count and add JOBCTL_STOP_CONSUME. The new thread
	   should stop without another do_notify_parent_cldstop() report.

To clarify, the problem is very old and we should blame ptrace_init_task().
But now that we have task_join_group_stop() it makes more sense to fix this
helper to avoid the code duplication.

Reported-by: syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index a38b3edc6851..ef8f2a28d37c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -391,16 +391,17 @@ static bool task_participate_group_stop(struct task_struct *task)
 
 void task_join_group_stop(struct task_struct *task)
 {
+	unsigned long mask = current->jobctl & JOBCTL_STOP_SIGMASK;
+	struct signal_struct *sig = current->signal;
+
+	if (sig->group_stop_count) {
+		sig->group_stop_count++;
+		mask |= JOBCTL_STOP_CONSUME;
+	} else if (!(sig->flags & SIGNAL_STOP_STOPPED))
+		return;
+
 	/* Have the new thread join an on-going signal group stop */
-	unsigned long jobctl = current->jobctl;
-	if (jobctl & JOBCTL_STOP_PENDING) {
-		struct signal_struct *sig = current->signal;
-		unsigned long signr = jobctl & JOBCTL_STOP_SIGMASK;
-		unsigned long gstop = JOBCTL_STOP_PENDING | JOBCTL_STOP_CONSUME;
-		if (task_set_jobctl_pending(task, signr | gstop)) {
-			sig->group_stop_count++;
-		}
-	}
+	task_set_jobctl_pending(task, mask | JOBCTL_STOP_PENDING);
 }
 
 /*
-- 
2.25.1.362.g51ebf55


