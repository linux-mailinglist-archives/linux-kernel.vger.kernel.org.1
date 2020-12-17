Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF02DCD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLQI1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQI1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:27:36 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73803C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:26:56 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id 2so9713379qtt.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r10KxsklhI6BT5Va29sBPPYNglRSuXlM/i3DYLAMZzY=;
        b=Ti0LZzZHTd2OBNRxuO7VzTlzSTIKJIrRIQWL0GmLBJ8fSN7lUJre1poReDHopOEFXt
         k3C4/0HOxJgSxD1J3RQ3ld+BXNfiq6InrTrM+KbCKZzZm3V6VFSKj17RIEDnc/2jLVud
         z45OmoZgB435B5wHpW0uJz+QmFfRYcUeg6hZ445QDtWAxjUarfexws98wRAybb10Zo+4
         1Dnb7N2j1DCsiRZSRPWd/uFHuQ5OBK4xPPDPtTr3wG1eQ0JTVB4O2388kPjomnp66kOD
         wruOpZNaHpnmdlfH3eXvVQT3YOjsvcrOqf4V8rw0jn0luz8TNkPpr5/kq9cFrCbtMDaA
         RObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r10KxsklhI6BT5Va29sBPPYNglRSuXlM/i3DYLAMZzY=;
        b=EFKWeWWTn9eKWsp7GhaaRKbWR8G62QvXoNf8LnpNyIzCaO5thWHvGOHm28j9JmO8wU
         Rb6Yt2IMwL8TvKRetM1kqWKcPSGGL0FnPX3Ou2++Kq37AMpATeujJXsNHyw58Glf7/AE
         qXYfqIFigYcpmhZVueDBf7CieE3hcEpH7IjjZMDCtF2usgU/mAU2ZH6f14scexNmJUBk
         KmM9Ll8MmBxdu0D97kCtxrUpamjoF+Ckw6YTq1Xrf3p+soWSEzNWHFB9CTFm/gU0yNqk
         G4rOgiBbrum91lOPNH4E40nHCDxg0TCGKvUFyj+2Vym7BFb6w5M5MkmKu7Fqmbu6J18K
         RZ+Q==
X-Gm-Message-State: AOAM530M1AEL2Bhds6FOQYr7G16tUD61xnIixl0JAup1BUBzcvqXUyeX
        LYLw2w+EvBnYbs5+zhV/TWHKDVvdWHiWV4wClh4oUA==
X-Google-Smtp-Source: ABdhPJw9QMH1oAX6S/6XlhMO0vVAw3X+UXwzwgQWQy9lVVd4lt5RmLBdmRoB865lrnDxEkrO8xLFbwuo75I7vuwFcPo=
X-Received: by 2002:ac8:5ac3:: with SMTP id d3mr46889586qtd.66.1608193615455;
 Thu, 17 Dec 2020 00:26:55 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009867cb05b699f5b6@google.com> <20201216205536.GX2443@casper.infradead.org>
In-Reply-To: <20201216205536.GX2443@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 17 Dec 2020 09:26:44 +0100
Message-ID: <CACT4Y+b7tNcnTQpUpO58rHcMCqe6UpQab_TxxYF_nxBZ1xDw9Q@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in count
To:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     syzbot <syzbot+51ce7a5794c3b12a70d1@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 9:55 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 16, 2020 at 11:34:10AM -0800, syzbot wrote:
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+51ce7a5794c3b12a70d1@syzkaller.appspotmail.com
> >
> > =============================
> > WARNING: suspicious RCU usage
> > 5.10.0-rc7-syzkaller #0 Not tainted
> > -----------------------------
> > kernel/sched/core.c:7270 Illegal context switch in RCU-bh read-side critical section!
> >
> > other info that might help us debug this:
> >
> >
> > rcu_scheduler_active = 2, debug_locks = 0
> > no locks held by udevd/9038.
> >
> > stack backtrace:
> > CPU: 3 PID: 9038 Comm: udevd Not tainted 5.10.0-rc7-syzkaller #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x107/0x163 lib/dump_stack.c:118
> >  ___might_sleep+0x220/0x2b0 kernel/sched/core.c:7270
> >  count.constprop.0+0x164/0x270 fs/exec.c:449
> >  do_execveat_common+0x2fd/0x7c0 fs/exec.c:1893
> >  do_execve fs/exec.c:1983 [inline]
> >  __do_sys_execve fs/exec.c:2059 [inline]
> >  __se_sys_execve fs/exec.c:2054 [inline]
> >  __x64_sys_execve+0x8f/0xc0 fs/exec.c:2054
> >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>
> This must be the victim of something else.  There's no way this call
> trace took the RCU read lock.

+lockdep maintainers for lockdep false positive then and +Paul for rcu

There is another recent claim of a false "suspicious RCU usage":
https://lore.kernel.org/lkml/CAKMK7uEiS5SrBYv-2w2wWL=9G4ByoHvtiWVsPqekswZzOGmzjg@mail.gmail.com/
