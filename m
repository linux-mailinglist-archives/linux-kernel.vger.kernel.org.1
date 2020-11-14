Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE72B2DB4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 15:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKNOsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 09:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKNOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 09:48:02 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B0C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 06:48:00 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k4so2460911qko.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 06:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpB5UkK56ULUM/SwJXVraZSg8z1gOcmwFB3VTdcmzJo=;
        b=QNRM/oPGZSiJ5Ihc+dQq07AAlcXhfoXogpgu1O+Vw+FE1cUGucylF1m9NB4mVfrwil
         gHYbCmW2Pw2viqaEi7SEzZTn2v6wHiEUJXID9wVcIIUSMr5aqGUKgo8mjd/NuiVupidG
         v4nvNFP+PgT1a67Q72FUZCEtADW3xN5myRnK+TEQW7M/rN54dtvvs0HfgyTRGgWNV+dq
         uMZ7/L7HBrir0e29FqxxcN8/scJviyy6ZPtThkgs7+XclcFtYnTeJisDb/iSKDvxvBlC
         v4Ai4dhrArjmRn0ZPCFzca6E8Z3pKzXyaImOwq7pFKKNh/ZuLWr9pVe6iowlpblCz8wb
         YWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpB5UkK56ULUM/SwJXVraZSg8z1gOcmwFB3VTdcmzJo=;
        b=paowRkH94WVsGaDS3xF/X0R6uOoG1s2igog3Ij44ZGwlERhccz5urtl4D6CzpmIaTU
         K8HrE0qsjDImYTMaRrof2ggZ8cYMXnfSkjYDLU+Swm/SSod06CD0xTsUUYD4a0zJN/8Z
         Y0KzU04aWZ0ki9s0dQPxaL3uKIW2knHx+UqdqSV9zORxGkwBPN7ebcRHuhcZEkHtrmKh
         7lLCHsR1Gr6/o5aPi9rk9j/5tBgNgCVWK31ygRr88KzPBfSBt56SO1ewK6drHm8z1iBn
         4kIkgZOJdFhmh9QLIa0+Rykjo1cVWuLAnttOD0QnJ0EgQ6u2uIPE7QbLTPF+EQEMy2v9
         KO8g==
X-Gm-Message-State: AOAM532WFFZb2guGVnp9PSuek99ihWltD5aagBx5go5cyFCIvqMA9k9v
        XiCOtPLVWG/veFmlDrRVlvA8uOIHXLJys09lUBBc2g==
X-Google-Smtp-Source: ABdhPJzuWjAkMT2fMiblRtI+NGA2TeGiI3YRlWPhDhVvtz73GYSTdIR7z+1XOaHF7I6z6iRkYmCpKWUSt0KbS8331ZE=
X-Received: by 2002:a37:6b07:: with SMTP id g7mr7030919qkc.265.1605365279254;
 Sat, 14 Nov 2020 06:47:59 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a923c105b411505f@google.com>
In-Reply-To: <000000000000a923c105b411505f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 14 Nov 2020 15:47:48 +0100
Message-ID: <CACT4Y+ab10d-3powP6kHV0ixFooQRJVDajAxGaKtA+aYmn7+Mw@mail.gmail.com>
Subject: Re: INFO: task hung in reboot
To:     syzbot <syzbot+9dec836197fea6892a28@syzkaller.appspotmail.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 2:42 PM syzbot
<syzbot+9dec836197fea6892a28@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e7018751 usb: host: ehci-mxc: Remove the driver
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d0c6a1500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a84e3059298aeb27
> dashboard link: https://syzkaller.appspot.com/bug?extid=9dec836197fea6892a28
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9dec836197fea6892a28@syzkaller.appspotmail.com

It seems syzkaller has found another way to reboot the machine.
systemd initialiated shutdown:
[ [0;32m  OK   [0m] Stopped Raise network interfaces.

but it's unclear why.

Kernel also hanged:

[ 2599.057387][    T1] systemd-shutdown[1]: Sending SIGTERM to
remaining processes...
[ 2599.704086][    T1] systemd-shutdown[1]: Sending SIGKILL to
remaining processes...
[ 2600.107613][    T1] systemd-shutdown[1]: All loop devices detached.
[ 2746.006716][ T1253] INFO: task systemd-shutdow:1 blocked for more
than 143 seconds.
[ 2746.014884][ T1253]       Not tainted 5.10.0-rc3-syzkaller #0

It seems due to some misbehaving device:

[ 2746.057796][ T1253]  schedule+0xcb/0x270
[ 2746.061900][ T1253]  wait_for_device_probe+0x1be/0x220
[ 2746.089974][ T1253]  device_shutdown+0x18/0x5c0
[ 2746.094669][ T1253]  __do_sys_reboot.cold+0x5d/0x97

Most likely some USB device because there is lots of USB-related
output before that.



> INFO: task systemd-shutdow:1 blocked for more than 143 seconds.
>       Not tainted 5.10.0-rc3-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:systemd-shutdow state:D stack:23432 pid:    1 ppid:     0 flags:0x00000000
> Call Trace:
>  context_switch kernel/sched/core.c:3774 [inline]
>  __schedule+0x8a2/0x1f30 kernel/sched/core.c:4523
>  schedule+0xcb/0x270 kernel/sched/core.c:4601
>  wait_for_device_probe+0x1be/0x220 drivers/base/dd.c:702
>  device_shutdown+0x18/0x5c0 drivers/base/core.c:4007
>  kernel_restart_prepare kernel/reboot.c:76 [inline]
>  kernel_restart kernel/reboot.c:246 [inline]
>  __do_sys_reboot.cold+0x5d/0x97 kernel/reboot.c:347
>  do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fa389e6c8c6
> Code: Unable to access opcode bytes at RIP 0x7fa389e6c89c.
> RSP: 002b:00007ffe1fb46e18 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa389e6c8c6
> RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
> RBP: 00007ffe1fb46ea8 R08: 0000000000002800 R09: 0000000000000005
> R10: 0000000000000002 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 000055c2d05dc150 R15: 00007ffe1fb47198
>
> Showing all locks held in the system:
> 1 lock held by systemd-shutdow/1:
>  #0: ffffffff871288a8 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x1a4/0x3e0 kernel/reboot.c:344
> 5 locks held by kworker/1:0/17:
> 1 lock held by khungtaskd/1253:
>  #0: ffffffff872492e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:6253
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 1253 Comm: khungtaskd Not tainted 5.10.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:118
>  nmi_cpu_backtrace.cold+0x46/0xe0 lib/nmi_backtrace.c:105
>  nmi_trigger_cpumask_backtrace+0x1da/0x200 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
>  watchdog+0xd32/0xf70 kernel/hung_task.c:294
>  kthread+0x38c/0x460 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
> NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
> NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
> NMI backtrace for cpu 0 skipped: idling at acpi_idle_do_entry+0x1c9/0x250 drivers/acpi/processor_idle.c:517
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000a923c105b411505f%40google.com.
