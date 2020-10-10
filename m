Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437FD28A390
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390312AbgJJW4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732057AbgJJTj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:39:56 -0400
Received: from mail-il1-x14e.google.com (mail-il1-x14e.google.com [IPv6:2607:f8b0:4864:20::14e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418EC05BD1F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 07:16:24 -0700 (PDT)
Received: by mail-il1-x14e.google.com with SMTP id m1so9129337iln.19
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 07:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qo/18ovbHtyHs2tyDnL9a08ag04DhvXqumP6uahafHs=;
        b=Pmto/ILG+Js6jeaYqEFCNOut9otT3f0UYr3Hd7qKpGaP8Bwfy5Pv7TLdzce37NobM9
         y9JQOxw/hCPD9F6IzkL5v0WeHtocg3vFTCJlDQDHe3L7p/0loN1zVdyDmIboJTjdqfTj
         saxLBichNNNb7s0rAGk/RQXYfOjkJqDydyKFPOAy+4SnnVYvOSaujNjS+QjCN0IBRWxx
         jxFHuVJN2wBzCrIKK2vnWT5U5TjgK1GTY+ch/ELHSLuZfRrNQ1NxETqAFYob2t5iZ0Td
         KPHT71Q207sD69HrDXD8h2SFSRaias7tUcxjF03gAP86cSFoRfg0WUvLjVJG3KSGmJmi
         QYdA==
X-Gm-Message-State: AOAM533GbSj76t10FMsf4flccwLnNnFzyZ/hxvEMATGtpNOLWdvP9vl0
        Dl/LmTgdJYmlAUfGPOJvEA6DiRgOaNknYTN9Szz2I2gwmuao
X-Google-Smtp-Source: ABdhPJwGzIrtCqzF4y294kumyrrFkE08AONpsEFLWCOZLsarl5WjdiJupXX6Ic5iVOKEbV+X9cXxlpbjHXm/Uv5kky5HKYVmZVX+
MIME-Version: 1.0
X-Received: by 2002:a92:5e42:: with SMTP id s63mr14101501ilb.205.1602339084196;
 Sat, 10 Oct 2020 07:11:24 -0700 (PDT)
Date:   Sat, 10 Oct 2020 07:11:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec608805b151a3df@google.com>
Subject: INFO: task can't die in congestion_wait
From:   syzbot <syzbot+9d67ed950b326f4f35c3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a804ab08 Add linux-next specific files for 20201006
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141b7afb900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26c1b4cc4a62ccb
dashboard link: https://syzkaller.appspot.com/bug?extid=9d67ed950b326f4f35c3
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d67ed950b326f4f35c3@syzkaller.appspotmail.com

INFO: task syz-executor.0:8666 can't die for more than 143 seconds.
task:syz-executor.0  state:D stack:26592 pid: 8666 ppid:  6885 flags:0x00004006
Call Trace:
 context_switch kernel/sched/core.c:3772 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4521
 schedule+0xcf/0x270 kernel/sched/core.c:4599
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1881
 io_schedule_timeout+0xc6/0x140 kernel/sched/core.c:6281
 congestion_wait+0xff/0x450 mm/backing-dev.c:960
 f2fs_get_meta_page_nofail+0x60/0x70 fs/f2fs/checkpoint.c:117
 get_current_nat_page fs/f2fs/node.c:112 [inline]
 __f2fs_build_free_nids+0x46f/0xe10 fs/f2fs/node.c:2403
 f2fs_build_free_nids fs/f2fs/node.c:2446 [inline]
 f2fs_build_node_manager+0x2549/0x3310 fs/f2fs/node.c:3180
 f2fs_fill_super+0x3b7b/0x7410 fs/f2fs/super.c:3695
 mount_bdev+0x32e/0x3f0 fs/super.c:1419
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3227
 __do_sys_mount fs/namespace.c:3438 [inline]
 __se_sys_mount fs/namespace.c:3411 [inline]
 __x64_sys_mount+0x278/0x2f0 fs/namespace.c:3411
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x46087a
Code: Unable to access opcode bytes at RIP 0x460850.
RSP: 002b:00007f4166abba88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f4166abbb20 RCX: 000000000046087a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f4166abbae0
RBP: 00007f4166abbae0 R08: 00007f4166abbb20 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020012400

Showing all locks held in the system:
3 locks held by kworker/u4:3/39:
 #0: ffff8880ae436058 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #0: ffff8880ae436058 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x284/0x2200 kernel/sched/core.c:4439
 #1: ffff8880ae420ec8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x305/0x440 kernel/sched/psi.c:833
 #2: ffffffff8a554da0 (rcu_read_lock){....}-{1:2}, at: batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:405 [inline]
 #2: ffffffff8a554da0 (rcu_read_lock){....}-{1:2}, at: batadv_nc_worker+0xf3/0xe50 net/batman-adv/network-coding.c:718
1 lock held by khungtaskd/1181:
 #0: ffffffff8a554da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6242
1 lock held by in:imklog/6770:
 #0: ffff8880a75216b0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
2 locks held by agetty/6781:
 #0: ffff8880973f4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:266
 #1: ffffc900010cc2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x223/0x1a70 drivers/tty/n_tty.c:2156
3 locks held by syz-executor.0/8666:

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
