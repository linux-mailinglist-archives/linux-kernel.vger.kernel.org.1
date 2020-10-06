Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB9285074
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJFRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgJFRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602003932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJcTj5yDFr6ZWVoIw5jsMoDe6o0IbfUHl+w8TFbOuHs=;
        b=BeTQtZkCIE//TuHLmbSv2e9Qe0ZVPTR+jUwbc7qXmROQjm6hl8gddnVrnPW5IV+SV/Qpx8
        SfEA7mgOlec1Idzg7d18Qv+M5Q0Lv/znfqYMSq48E+twwpunryG4tqx/+s1rkKYnXqqH9a
        tkebi7YA78COPc8Jl5RoFMveNi+Zu5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-xsnUbgMfM--AZu5bL-9mSw-1; Tue, 06 Oct 2020 13:05:28 -0400
X-MC-Unique: xsnUbgMfM--AZu5bL-9mSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F7B31902EA7;
        Tue,  6 Oct 2020 17:05:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.132])
        by smtp.corp.redhat.com (Postfix) with SMTP id D90A25C1BD;
        Tue,  6 Oct 2020 17:05:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Oct 2020 19:05:26 +0200 (CEST)
Date:   Tue, 6 Oct 2020 19:05:23 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com>,
        axboe@kernel.dk, christian@brauner.io,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>
Subject: Re: WARNING in get_signal
Message-ID: <20201006170523.GC9995@redhat.com>
References: <000000000000da06e405b0b20f1e@google.com>
 <87zh54bp0n.fsf@x220.int.ebiederm.org>
 <20201005134923.GA9995@redhat.com>
 <20201005163016.GB9995@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005163016.GB9995@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05, Oleg Nesterov wrote:
>
> On 10/05, Oleg Nesterov wrote:
> >
> > > It looks like this code was introduced in commit 73ddff2bee15 ("job
> > > control: introduce JOBCTL_TRAP_STOP and use it for group stop trap").
> >
> > Yes, but I bet this was broken later, _may be_ by 924de3b8c9410c4.
>
> No, it seems this bug is really old. I'll try to make the fix tomorrow.

I still do not see a good fix. I am crying ;)

For the moment, lets forget about this problem. 924de3b8c9410c4 was wrong
anyway, task_join_group_stop() should be fixed:

	- if current is traced, "jobctl & JOBCTL_STOP_PENDING" is not
	  enough, we need to check SIGNAL_STOP_STOPPED/group_stop_count

	- if the new thread is traced, task_join_group_stop() should do
	  nothing, we should rely on ptrace_init_task()


Now lets return to this bug report. This (incomplete) test-case

	void *tf(void *arg)
	{
		return NULL;
	}

	int main(void)
	{
		int pid = fork();
		if (!pid) {
			setpgrp();
			kill(getpid(), SIGTSTP);

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
		int thr = waitpid(-1, &status, 0);
		printf("pids: %d %d status: %x\n", pid, thr, status);

		return 0;
	}

triggers WARN_ON_ONCE(!signr) in do_jobctl_trap() and shows that the
auto-attached sub-thread reports the wrong status.

This patch

	--- x/include/linux/ptrace.h
	+++ x/include/linux/ptrace.h
	@@ -218,7 +218,7 @@ static inline void ptrace_init_task(stru
			__ptrace_link(child, current->parent, current->ptracer_cred);
	 
			if (child->ptrace & PT_SEIZED)
	-			task_set_jobctl_pending(child, JOBCTL_TRAP_STOP);
	+			task_set_jobctl_pending(child, JOBCTL_TRAP_STOP|SIGTRAP);
			else
				sigaddset(&child->pending.signal, SIGSTOP);
		}

should fix the problem, but it is not enough even if we forget about
task_join_group_stop().

	- it is not clear to me if the new thread should join the group stop
	  after (say) PTRACE_CONT. If yes, it is not clear how can we do this.

	- in any case it should stop after ptrace_detach(), but in this case
	  jobctl & JOBCTL_STOP_SIGMASK == SIGTRAP doesn't look right.

	  So perhaps we can change the patch above to use
	  current->jobctl & JOBCTL_STOP_SIGMASK instead of SIGTRAP ?

	  This too doesn't look good, the 1st ptrace_stop() should probably
	  always report SIGTRAP...

Oleg.

