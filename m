Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E6E2C8355
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgK3LgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3LgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:36:23 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A7C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:35:42 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id u21so1999674qtw.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5sNEUwZv1K50BqKV7c3ftMNBsmHEC14THTGxBHQxI8=;
        b=qDh7VSGxtCcc/+zwyRiXuhY17S7Cx0oN9r1HgUwaXFmf6R8JQGhO2kEMaKmgcjPw3i
         9SbLg3HTdvvLYQQxUSA3IcNPa/iKsyKWiPi88bZ/saCPr1+ea6t8QzQ7m8N3BuFgPt5+
         12i7vpCn0so1gtPzlAIkDucVnnx+AzhVsgWxD1bNLcyH8B7mJdDQcx3v+kdnrdwWVzxe
         fVrxhbMt8x+QyWupfAaKt3gg+dpjg5S7nsMpnrjCkkGXrckNAyiaPJXBGPKYbkUlQfLD
         o1v6CGIe+qyZAOs6EoJr/YvxSLzpzH8dK05+C9WaJWHVNZlg1XRqbRETcEYfMvYgNQek
         2ABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5sNEUwZv1K50BqKV7c3ftMNBsmHEC14THTGxBHQxI8=;
        b=pu6FKlq6IDKd5BObwalsBrw57H7s0pz4td0SjCByv/J3LSqTwYv6ggcCmGfU1MxBw2
         AzMI4aQOXI7YxW1lKN9zE9F2bpKGPsR3/IoiRKTakixMOshviQ6/sUHqkVwlShbjahJ0
         N3LFcdpLTEY0r5lv+Bnq3g0W+ERYgB8IF9+Ifakf9I6nYkThlHNMJia32VG8BTOIXVbV
         kue7n9vfnOR41MB92uRS4hKvYdC7J/Ma2J92/dTbCDAaIT8GxMSI2OosZhilHxDoS61O
         KuCrPsazGfMRZBUsOlI4xTyB5CyZHjcVCWQyDd65ZZ1zNzRLmIgYQRFTuCJhKJy9rQaY
         wOXw==
X-Gm-Message-State: AOAM533Emyxo8jt9crBLvoprjgQoAtUuVF8xp2QChOkkC8x6/f4YCDGL
        qAPIYEVdcYed/ekcOF03fPLqC+gwhH4lpdFUfdzQ9w==
X-Google-Smtp-Source: ABdhPJw4oaDAbZY6FOEr3pZJeF6YVExgCUonq8tti1OOxVGgwRmD1kbVdJgh/82rHaZoOofy66J3K5SkdtlWyNWW0Ew=
X-Received: by 2002:aed:2744:: with SMTP id n62mr21464788qtd.67.1606736141924;
 Mon, 30 Nov 2020 03:35:41 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004e5bdb05b5516009@google.com>
In-Reply-To: <0000000000004e5bdb05b5516009@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Nov 2020 12:35:30 +0100
Message-ID: <CACT4Y+bhEC6aHBs-2qa76kGaCQ4=0v7Hi_bXwu_5air5seBLpQ@mail.gmail.com>
Subject: Re: BUG: rwlock bad magic on CPU, kworker/0:LINE/NUM, ADDR
To:     syzbot <syzbot+cb987a9c796abc570b47@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>, jmaloy@redhat.com,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tipc-discussion@lists.sourceforge.net,
        Ying Xue <ying.xue@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 12:33 PM syzbot
<syzbot+cb987a9c796abc570b47@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    90cf87d1 enetc: Let the hardware auto-advance the taprio b..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=135479b3500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5720c06118e6c4cc
> dashboard link: https://syzkaller.appspot.com/bug?extid=cb987a9c796abc570b47
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cb987a9c796abc570b47@syzkaller.appspotmail.com
>
> tipc: 32-bit node address hash set to aa1414ac
> BUG: rwlock bad magic on CPU#0, kworker/0:18/18158, 00000000859f2a8d
> CPU: 0 PID: 18158 Comm: kworker/0:18 Not tainted 5.10.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events tipc_net_finalize_work
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:118
>  rwlock_bug kernel/locking/spinlock_debug.c:144 [inline]
>  debug_write_lock_before kernel/locking/spinlock_debug.c:182 [inline]
>  do_raw_write_lock+0x1ef/0x280 kernel/locking/spinlock_debug.c:206
>  tipc_mon_reinit_self+0x1f7/0x630 net/tipc/monitor.c:685

There was also "general protection fault in tipc_mon_reinit_self":
https://syzkaller.appspot.com/bug?id=dc141b9a05cb48d3d9b46837bc2fdc9e7d95dbe9
which also happened once. Smells like an intricate race condition.


>  tipc_net_finalize net/tipc/net.c:134 [inline]
>  tipc_net_finalize+0x1df/0x310 net/tipc/net.c:125
>  process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
>  kthread+0x3af/0x4a0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004e5bdb05b5516009%40google.com.
