Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5342DB95C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 03:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgLPCpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 21:45:50 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:53718 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLPCpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 21:45:50 -0500
Received: by mail-il1-f200.google.com with SMTP id q2so18226674ilt.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 18:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rDUW7r87onx/RWl3unGJ4GmRrVMni5cJjxiJLLepcRI=;
        b=kXrXtjvE4HGl9TPgGoQvRPJCpy1M/p6SBfkkYULRniHevVLRMGSeBsF0UmFNLMFoyZ
         zHyDWXDRs6yEfZHUg5E3yCoQx0hFtz+PCNuRZRnjVrjyADHHT4QG8sbltPqOMYMv8eDT
         De76thLSLCndPcRzXc6VUtk9Hjg0xPdinhHLbP/qGU7XUdUYnYUFAc4rCIgZr7+K+Iwh
         p4aR4dux5g5peUi+GJ8E5HM3B/W9N272HcUTdjLKwqAFkJqTUR7spaxPagCZEXsiSNrK
         ewMAotm1rNmyTHFNbRgApicOIVp9th6JAWNgWqYdIFY5dSy6B86Q4EQZIAP/4OL0bZpF
         g9Kg==
X-Gm-Message-State: AOAM5324Kn7duxm4HVVd0DToo/OrPeBoYgdALiVg0xL0IbyaRnUrIxQ+
        gm2tQW62rE51mbD+lFCzMiCHgVlftcJc49vS4TladRAz1JRX
X-Google-Smtp-Source: ABdhPJxRkIbvQahC67PlL1n+oMTqKog23TOdu43rxkB6n4ivsNsa9DqMa47EvkdhQW92i8e7RoA4zZNKG7dVAfJd4z/qtCMLBPkv
MIME-Version: 1.0
X-Received: by 2002:a92:6f12:: with SMTP id k18mr1959322ilc.66.1608086709308;
 Tue, 15 Dec 2020 18:45:09 -0800 (PST)
Date:   Tue, 15 Dec 2020 18:45:09 -0800
In-Reply-To: <0000000000005b303e05b62d6674@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013920205b68bdd58@google.com>
Subject: Re: INFO: task can't die in corrupted (2)
From:   syzbot <syzbot+61cb1d04bf13f0c631b1@syzkaller.appspotmail.com>
To:     ast@kernel.org, christian.brauner@ubuntu.com, daniel@iogearbox.net,
        davem@davemloft.net, gnault@redhat.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9317f948 Add linux-next specific files for 20201215
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=151add97500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c81cc44aa25b5b3
dashboard link: https://syzkaller.appspot.com/bug?extid=61cb1d04bf13f0c631b1
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177df703500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1342f30f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61cb1d04bf13f0c631b1@syzkaller.appspotmail.com

INFO: task syz-executor656:8498 can't die for more than 143 seconds.
task:syz-executor656 state:R  running task     stack:27904 pid: 8498 ppid:  8493 flags:0x00004006
Call Trace:

Showing all locks held in the system:
1 lock held by khungtaskd/1647:
 #0: ffffffff8b78f920 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x28c kernel/locking/lockdep.c:6254
1 lock held by in:imklog/8185:
 #0: ffff88801ad9e0f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:923
3 locks held by syz-executor656/8498:

=============================================

Kernel panic - not syncing: hung_task: blocked tasks
CPU: 0 PID: 1647 Comm: khungtaskd Not tainted 5.10.0-next-20201215-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 panic+0x343/0x77f kernel/panic.c:231
 check_hung_uninterruptible_tasks kernel/hung_task.c:257 [inline]
 watchdog.cold+0x157/0x31d kernel/hung_task.c:338
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Kernel Offset: disabled
Rebooting in 86400 seconds..

