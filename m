Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA35C2836DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJENtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgJENtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601905770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcwpmSDTuwQc1R+BSJe2pTVrTPPnd9KXX2nscQ2rZhA=;
        b=LySFCh3KoEp/2n/PmTCxZF9rhflmJDzQRmBLeJhVnBYe/fEkolzV7tQLaLPg/yjZ3R2iuv
        9NJ6nINFiEjT77Q0eJN7HU/x6F4GuMfpjqu5R+MnDvSCVH3LEk986HebDVkWBYRgwv6HEd
        AR5/somvV3O0y/btKTZR+kjlZDoH1mI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-qHoyLckeNASSVVLXAa6SHw-1; Mon, 05 Oct 2020 09:49:29 -0400
X-MC-Unique: qHoyLckeNASSVVLXAa6SHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C9E3420E7;
        Mon,  5 Oct 2020 13:49:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.132])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0874F1002D46;
        Mon,  5 Oct 2020 13:49:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  5 Oct 2020 15:49:27 +0200 (CEST)
Date:   Mon, 5 Oct 2020 15:49:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com>,
        axboe@kernel.dk, christian@brauner.io,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>
Subject: Re: WARNING in get_signal
Message-ID: <20201005134923.GA9995@redhat.com>
References: <000000000000da06e405b0b20f1e@google.com>
 <87zh54bp0n.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh54bp0n.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02, Eric W. Biederman wrote:
>
> syzbot <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com> writes:
>
> > Hello,
> >
> > syzbot found the following issue on:
>
> So this is:
>
> static void do_jobctl_trap(void)
> {
> 	struct signal_struct *signal = current->signal;
> 	int signr = current->jobctl & JOBCTL_STOP_SIGMASK;
>
> 	if (current->ptrace & PT_SEIZED) {
> 		if (!signal->group_stop_count &&
> 		    !(signal->flags & SIGNAL_STOP_STOPPED))
> 			signr = SIGTRAP;
> 		WARN_ON_ONCE(!signr);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 		ptrace_do_notify(signr, signr | (PTRACE_EVENT_STOP << 8),
> 				 CLD_STOPPED);
> 	} else {
> 		WARN_ON_ONCE(!signr);
> 		ptrace_stop(signr, CLD_STOPPED, 0, NULL);
> 		current->exit_code = 0;
> 	}
> }
>
> I have the state of this paged out of my head at the moment.
>
> Oleg or Tejun do you remember what is supposed to keep signr from being
> NULL?

This nearly killed me, but I seem to understand whats going on.
ptrace_init_task() does task_set_jobctl_pending(JOBCTL_TRAP_STOP) while
SIGNAL_STOP_STOPPED, child->jobctl & JOBCTL_STOP_SIGMASK == 0.

> It looks like this code was introduced in commit 73ddff2bee15 ("job
> control: introduce JOBCTL_TRAP_STOP and use it for group stop trap").

Yes, but I bet this was broken later, _may be_ by 924de3b8c9410c4.

I need to take a rest and read this code again. I too forgot how this
all supposed to work.

Oleg.

