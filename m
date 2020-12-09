Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006CE2D3C58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgLIHdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:33:52 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:52780 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgLIHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:33:52 -0500
Received: by mail-il1-f200.google.com with SMTP id h4so617625ilq.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 23:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oKhCdeN5p+5cdnOz5gwTVBe+HbKNwK7qKySSgBEppUw=;
        b=Yz2skWWY8NdVcQYOlWQ5j7tBQms5okasOtGpqF6/8Gjk9s0Bl0cVFh+M9HzelciiDL
         BRLyNyBGto2dp7UQDB6ya4wbtPHvn6mVmNUJT0ggSISOv+mOOk04aX2eSi+ce8oN/YPG
         txMCopDNK17lpRDzsirRkWM29c5HeLlxVBgZ7hIBhXmeTEbXA6xce7H2Nw/dZWYjtgaV
         QivKElQQIlGMN2JPg48ngbI/W32CJ9fXo+2e3bH+KpuMpjBIa75YCGNXyrlCTo3ZWqKh
         ffNUGWQsyrpyJZ1udPgTMpZS003pGeBzQV4GPlmFK6avi9bfnZmaEZSK4YUw/j4GrflV
         JHYw==
X-Gm-Message-State: AOAM531gBKYbHENaCmDBwrTUV5aVM8kYibWCX7FozxL+r6f6EaXQuVU/
        txLmYI5s2jh732W1yndSmNfMONFeCC4MbJYr+PfCDPAdLSVO
X-Google-Smtp-Source: ABdhPJxFZF07z5GI3smAAiIdVpt4vBwwZxw5n5fyWs3o7QZrCwgGx4eSQ9wc13SPaczYVpX99zJ73k6OE8pupAdOjLeR47wTzvtv
MIME-Version: 1.0
X-Received: by 2002:a92:4002:: with SMTP id n2mr1029198ila.293.1607499191018;
 Tue, 08 Dec 2020 23:33:11 -0800 (PST)
Date:   Tue, 08 Dec 2020 23:33:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041e8e505b603128f@google.com>
Subject: UBSAN: shift-out-of-bounds in snd_pcm_oss_change_params_locked
From:   syzbot <syzbot+33ef0b6639a8d2d42b4c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alsa-devel@alsa-project.org,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        vbabka@suse.cz, walken@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1656cc13500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
dashboard link: https://syzkaller.appspot.com/bug?extid=33ef0b6639a8d2d42b4c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a8ad37500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bc6adf500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33ef0b6639a8d2d42b4c@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in sound/core/oss/pcm_oss.c:705:23
shift exponent 58 is too large for 32-bit type 'int'
CPU: 1 PID: 8476 Comm: syz-executor572 Not tainted 5.10.0-rc6-next-20201207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 snd_pcm_oss_period_size sound/core/oss/pcm_oss.c:705 [inline]
 snd_pcm_oss_change_params_locked.cold+0x55/0x78 sound/core/oss/pcm_oss.c:925
 snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1084 [inline]
 snd_pcm_oss_make_ready+0xe7/0x1b0 sound/core/oss/pcm_oss.c:1143
 snd_pcm_oss_sync+0x1de/0x800 sound/core/oss/pcm_oss.c:1708
 snd_pcm_oss_release+0x276/0x300 sound/core/oss/pcm_oss.c:2546
 __fput+0x283/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0xb89/0x2a00 kernel/exit.c:823
 do_group_exit+0x125/0x310 kernel/exit.c:920
 __do_sys_exit_group kernel/exit.c:931 [inline]
 __se_sys_exit_group kernel/exit.c:929 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:929
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43ee98
Code: Unable to access opcode bytes at RIP 0x43ee6e.
RSP: 002b:00007ffc0b9ddff8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ee98
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be6a8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
