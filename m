Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED42E789B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgL3MkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:40:24 -0500
Received: from mail.zx2c4.com ([192.95.5.64]:57437 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgL3MkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:40:23 -0500
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b3d86b37
        for <linux-kernel@vger.kernel.org>;
        Wed, 30 Dec 2020 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=DRvKx1JOp86Sg2wzMfT7xlVo2kk=; b=e6i6Za
        qBKb+E/gZ567M3RGDvR/Mus8Ati8OLhKr9WOhwEbTRRqO0GgYeJyV4PO95EgdGhK
        ++dsI0L/etgH3d0/KzKcmourHdJfPsbVtbt1WuePU8UaR7BhWj4sJlJOjqWCNgPn
        Uw87nhw7xT3tHEkAPF5u/8KehaOBR2gS1PlYR4jcUz6gNZs5D/254zH2ID5QskLA
        HZNX+sMsMJ025q1vV36vldxorOhZ7ZWLFu4lH8N7movj7ZnCoQOT7PudiDLdgfoK
        Skbi0lSopVQkEmXouGs58w2RrFWD4HLpyZwZ2UUQPOJkblT4+liZpE+91BXXmTrt
        iPT9fj6zXnYSCJGg==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 34f60ad0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 30 Dec 2020 12:30:14 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id k78so14744617ybf.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 04:39:40 -0800 (PST)
X-Gm-Message-State: AOAM533t7wtdemAPGUOvLffAqZJ+68mSEY3/OrLowL9Mhfha44Z8HF0P
        QjPVLSW9QxfqBwFvOPJAoah1SmVxTmKQon7fcNs=
X-Google-Smtp-Source: ABdhPJxVhJKPTt2+mQwwtrjhm2tlBeeEy4Ve40KqMOumavGG6MgypVzBWHPuh/a6isty0C4UT9VE/0aGF4JT/Z5NXZA=
X-Received: by 2002:a25:4744:: with SMTP id u65mr81479869yba.239.1609331979967;
 Wed, 30 Dec 2020 04:39:39 -0800 (PST)
MIME-Version: 1.0
References: <d56b4194-2b74-b440-c102-3b379daa8194@gmail.com>
In-Reply-To: <d56b4194-2b74-b440-c102-3b379daa8194@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 30 Dec 2020 13:39:28 +0100
X-Gmail-Original-Message-ID: <CAHmME9oORiNMN6EyAWOy3Fxzo33etkQxQtQbKdPqw_fWdw9wtw@mail.gmail.com>
Message-ID: <CAHmME9oORiNMN6EyAWOy3Fxzo33etkQxQtQbKdPqw_fWdw9wtw@mail.gmail.com>
Subject: Re: wg-crypt-wg0 process
To:     Fatih USTA <fatihusta86@gmail.com>
Cc:     WireGuard mailing list <wireguard@lists.zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fatih,

Thanks for the report and the detailed test case. From what I can see,
this behavior presents itself both with the explicit ip link del and
without. When running with debugging enabled, I can see this in dmesg:

[558758.361056] wireguard: wg0: Keypair 244 destroyed for peer 21
[558758.546649] wireguard: wg0: Peer 21 (10.150.150.2:51820) destroyed
[558758.563317] wireguard: wg0: Interface destroyed
[558758.567803] wireguard: wg0: Keypair 243 destroyed for peer 22
[558758.733287] wireguard: wg0: Peer 22 (10.150.150.1:51820) destroyed
[558758.749991] wireguard: wg0: Interface destroyed

The fact that I see "Interface destroyed" for both interfaces means
that wg_destruct() is being called, which includes these calls:

        destroy_workqueue(wg->handshake_receive_wq);
        destroy_workqueue(wg->handshake_send_wq);
        destroy_workqueue(wg->packet_crypt_wq);

In doing so, the output of ps changes from:

$ ps aux|grep wg0
root      200479  0.0  0.0      0     0 ?        I    13:06   0:00
[kworker/0:2-wg-crypt-wg0]
root      201226  0.0  0.0      0     0 ?        I    13:08   0:00
[kworker/1:4-wg-crypt-wg0]
root      201476  0.0  0.0      0     0 ?        I<   13:11   0:00
[wg-crypt-wg0]
root      201484  0.0  0.0      0     0 ?        I<   13:11   0:00
[wg-crypt-wg0]

to:

$ ps aux|grep wg0
root      200479  0.0  0.0      0     0 ?        I    13:06   0:00
[kworker/0:2-wg-crypt-wg0]
root      201226  0.0  0.0      0     0 ?        I    13:08   0:00
[kworker/1:4-wg-crypt-wg0]

What I suspect is happening is that destroying the workqueue does not
actually destroy the kthreads that they were using, so that they can
be reused (and eventually relabeled) by other drivers. Looking at the
stack of those indicates this is probably the case:

$ cat /proc/200479/stack
[<0>] worker_thread+0xba/0x3c0
[<0>] kthread+0x114/0x130
[<0>] ret_from_fork+0x1f/0x30

So it's just hanging out there idle waiting to be scheduled by
something new. In fact, while I was writing this email, that worker
already seems to have been reclaimed by another driver:

$ cat /proc/200479/comm
kworker/0:2-events

Now it's called "events".

This is happening because the kthread isn't actually destroyed, and
task->comm is being hijacked. In proc_task_name we have:

        if (p->flags & PF_WQ_WORKER)
               wq_worker_comm(tcomm, sizeof(tcomm), p);
       else
               __get_task_comm(tcomm, sizeof(tcomm), p);

That top condition holds for workqueue workers, and wq_worker_comm
winds up scnprintf'ing the current worker description in there:

                        /*
                        * ->desc tracks information (wq name or
                        * set_worker_desc()) for the latest execution.  If
                        * current, prepend '+', otherwise '-'.
                        */
                       if (worker->desc[0] != '\0') {
                               if (worker->current_work)
                                       scnprintf(buf + off, size - off, "+%s",
                                                 worker->desc);
                               else
                                       scnprintf(buf + off, size - off, "-%s",
                                                 worker->desc);

But worker->desc isn't set until process_one_work is called:

        /*
        * Record wq name for cmdline and debug reporting, may get
        * overridden through set_worker_desc().
        */
       strscpy(worker->desc, pwq->wq->name, WORKER_DESC_LEN);

And it's never unset after the work is done and it's waiting idle in
worker_thread for the scheduler to reschedule it and eventually call
process_one_work on a new work unit.

It would be easy to just null out that string after the work is done
with something like:

        worker->current_func(work);
        worker->desc[0] = '\0';

But I guess this has never sufficiently bothered anyone before. I
suppose I could submit a patch and see how it's received. But it also
looks like the scnprintf above in wq_worker_comm distinguishes these
cases anyway. If there's a + it means that the work is active and if
there's a - it means that it's an old leftover thread. So maybe this
is fine as-is?

Jason
