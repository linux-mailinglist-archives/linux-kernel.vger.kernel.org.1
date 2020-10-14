Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0B28E45C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbgJNQ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387494AbgJNQ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:26:07 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBEDC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:26:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t9so2600971qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezb7YqWZVrJaCKJV67gX4kc5lKOmF1DjdN8/j6/OFck=;
        b=ewcOW6EvnspyZ52QGl9rHoQ67VpyCbxngY5O/0oQ31cyVRqtwx2LN2OljA7OnWfRIb
         2KyYn46i1C/pNtWgEAEYFLSzIKNr/BRfWA3+abPLpkymDj2eLko+3P8ZJ14v1LVpEuUW
         mxYgPzQnirrJHecfl9p+vClPguOvxc5gFj4QfWqZ+ys2yzr6iejdCC0xqmLG7ciLWGht
         YJkUAYipdvLrrZ3MGqD1VjyoT/ve0eHdqe56brWFLa5qcs+CXQALzA+DF4KnqB77WI3y
         OQGggC7wzxo40AJ4M46Krk2X93dnAP3N0YDIbGedK3V3y3+hq8TjgdY876j/U+KxdRp/
         QVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezb7YqWZVrJaCKJV67gX4kc5lKOmF1DjdN8/j6/OFck=;
        b=c0jPYO1/3lQkt5JAYlEoeFEmQXp//IsxTEcEGqTYss2lgkkI4GVphDYJp6Gp2Fj0Kj
         ZHqlr5ffWfqdAijqQCnqtTfYsXng4hO9GauBKC/7NarBNqJCgmmO4GtQTmULpRNS1GDU
         8MoKY6ua5YTWZvn9jSLpWRdEwOiv1TLZB0b3skBs5pMTRMbtQCLWaOmz4RTvTsJJ03uh
         kKmJ/nMNuZNQ+cJ/GGZsi7wUxYlLUDosZZ5VcfylaVE+eiWAnS0Ykq11UG/ckrB1IQJn
         evJVk4dDzSMIiOop4FUrLA/Px69rLrB2dFnX+4DSl1BwTvhVFFDyL1U+2EFbZ0dXW8mU
         sbuw==
X-Gm-Message-State: AOAM531zBHdF4gp5Tf6m1f8I36CAko0YshsDSA9ozq2yBju29qYMBbxu
        ID1fTFin0h/UcvxvoETMkHOZyHPvUppYt5nTIUHq0A==
X-Google-Smtp-Source: ABdhPJyFs+okr+cN5qm0GDm0Z6tBqa97vLdQe5IacZVByeQY5q3d+xmwB6sFgr7AQ2eHzOGUc+J8DirYRjc4b28ZJK8=
X-Received: by 2002:ac8:57c1:: with SMTP id w1mr5560420qta.290.1602692764783;
 Wed, 14 Oct 2020 09:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d3c499057536ce86@google.com> <000000000000c69c7805adef8597@google.com>
 <20200829012415.GB486691@rowland.harvard.edu> <CAAeHK+z2KDbNVW5_5BA8P+r=8+VQY1p9ksJmny6ZW0xR3zBobA@mail.gmail.com>
In-Reply-To: <CAAeHK+z2KDbNVW5_5BA8P+r=8+VQY1p9ksJmny6ZW0xR3zBobA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 14 Oct 2020 18:25:53 +0200
Message-ID: <CACT4Y+YUu6YzUwTYBYYyFLVkeW_AxftwE=qmQpQe4jMuwUjVSA@mail.gmail.com>
Subject: Re: INFO: task hung in usb_bulk_msg
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        rafael.j.wysocki@intel.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 3:08 PM 'Andrey Konovalov' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Sat, Aug 29, 2020 at 3:24 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Aug 28, 2020 at 05:52:16AM -0700, syzbot wrote:
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1052a669900000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=7a7613e5ba9ae7bd15f9
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c328e900000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155eff41900000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com
> > >
> > > INFO: task syz-executor790:9958 blocked for more than 143 seconds.
> > >       Not tainted 5.9.0-rc2-syzkaller #0
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > task:syz-executor790 state:D stack:28240 pid: 9958 ppid:  6854 flags:0x00004004
> > > Call Trace:
> > >  context_switch kernel/sched/core.c:3778 [inline]
> > >  __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
> > >  schedule+0xd0/0x2a0 kernel/sched/core.c:4602
> > >  schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
> > >  do_wait_for_common kernel/sched/completion.c:85 [inline]
> > >  __wait_for_common kernel/sched/completion.c:106 [inline]
> > >  wait_for_common kernel/sched/completion.c:117 [inline]
> > >  wait_for_completion_timeout+0x15e/0x270 kernel/sched/completion.c:157
> > >  usb_start_wait_urb+0x144/0x2b0 drivers/usb/core/message.c:63
> > >  usb_bulk_msg+0x226/0x550 drivers/usb/core/message.c:254
> > >  do_proc_bulk+0x39b/0x710 drivers/usb/core/devio.c:1231
> > >  proc_bulk drivers/usb/core/devio.c:1268 [inline]
> > >  usbdev_do_ioctl drivers/usb/core/devio.c:2542 [inline]
> > >  usbdev_ioctl+0x586/0x3360 drivers/usb/core/devio.c:2708
> >
> > I'm confused about this bug report.
> >
> > Here's the syz reproducer from the link listed above:
> >
> > #
> > https://syzkaller.appspot.com/bug?id=bf172344c5f1d3487a4feff67c3dd30e08d5b635
> > # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> > #{"threaded":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"netdev":true,"close_fds":true}
> > r0 = syz_open_dev$usbfs(&(0x7f0000000040)='/dev/bus/usb/00#/00#\x00',
> > 0x4000000000000071, 0x28081)
> > r1 = socket$inet6(0xa, 0x2, 0x0)
> > r2 = dup(r1)
> > ioctl$PERF_EVENT_IOC_ENABLE(r2, 0x8912, 0x400200)
> > socketpair$unix(0x1, 0x0, 0x0, &(0x7f0000000000))
> > ioctl$USBDEVFS_CONTROL(r0, 0x8108551b, &(0x7f0000001140)={0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0})
> > ioctl$USBDEVFS_CLEAR_HALT(r0, 0xc0185502, &(0x7f0000000000)={0x1, 0x1})
> >
> > As far as I can see, the only USB ioctls used in this test are
> > USBDEVFS_CONTROL and USBDEVFS_CLEAR_HALT.  Neither of those calls
> > do_proc_bulk() or usb_bulk_msg(), so how did those routines end up in
> > the stack trace?
> >
> > In fact, do_proc_bulk() is called only for USBDEVFS_BULK.  But the test
> > doesn't use that ioctl!
> >
> > What's going on?  Am I missing part of the test?
>
> Hi Alan,
>
> Yeah, it's a bit confusing, sorry for that. Since syzkaller mutates
> the values that are passed into syscalls, it might mutate the cmd
> value of an ioctl. This results in a mismatch between the name of a
> syscall in syzkaller's notation, and the actual cmd value. In this
> case we have:
>
> ioctl$USBDEVFS_CONTROL(r0, 0x8108551b, ...)
>
> where 0x8108551b == 2164806939, which is the value for
> USBDEVFS_DISCONNECT_CLAIM [1], and
>
> ioctl$USBDEVFS_CLEAR_HALT(r0, 0xc0185502, ...)
>
> where 0xc0185502 == 3222820098, which is the value for USBDEVFS_BULK [2].
>
> I remember Dmitry did some changes to this part, but I think syzkaller
> only avoids getting disabled ioctls during mutations. Dmitry, maybe it
> would make sense to avoid getting other known ioctls during mutations?

Agree, it would make sense. I've started working on it but wasn't able
to finish. It also affects get/setsockopt, fcntl, prctl, bpf and
others. In this more general context it turns out to be an interesting
problem figuring out what is that exactly we don't want to mutate and
to what values.
