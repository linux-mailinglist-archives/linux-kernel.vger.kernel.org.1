Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B7D2C5A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391649AbgKZRRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:17:18 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:40203 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390083AbgKZRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:17:18 -0500
Received: by mail-io1-f71.google.com with SMTP id c2so1817588ioq.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 09:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nz0kWD3jPQEETBi1E7TNq3BBn/NlA7rJRZa61l4DyJ8=;
        b=YIAuT1zeLHxb1ZEF3eNEUWa2EzpJ/9Cwe0+22qyV5h+R1oYYg8HaiUMJ8aPAMSqLHy
         hteUy6v1tyq9zzBDykOifv9Q3TUi8RdFRAjM/3XEcrE7zF+osK7EP0TO5xouTk7ZDAOA
         FYyt/wl4TRw/sapbpo1hTxUtRieP3HmJb5kmGqqYlEdOfbzBBTB2/IS2+p3Z8bwK+vDN
         DaTHHD85jAz6YMwCEjqobd+2fSZtvrImFrwroQSA1EjFwS4hLzek9yziNjupgELOJS7k
         CZyq2FlsnyQjbuDomAhzqoowEDCh7xbUbJC33fgb2gZ4iyTQnNT5l6vvN40Heo3AikfA
         0b0g==
X-Gm-Message-State: AOAM533Y20B4l2Ql2khC6e9Fzxi+naaegTxBBubdIg9ResM9v9ZmX7G3
        a3snHW8bkM5CPDA7B6ZRL0mqelll0GJHWh4k0JYbjzPPTPV3
X-Google-Smtp-Source: ABdhPJyAUtPAIwDuTJx0shOYau9IFkx1HjwllJ7w0/aSVXwA7FFhIkIQyZgGRBmgHCKoPWcRd3nlf74MOrJ1Mkp0GDFxa2Gi81+V
MIME-Version: 1.0
X-Received: by 2002:a92:cc45:: with SMTP id t5mr3289985ilq.248.1606411035805;
 Thu, 26 Nov 2020 09:17:15 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:17:15 -0800
In-Reply-To: <000000000000c19e7b05b4c35440@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000270f5805b505b74c@google.com>
Subject: Re: WARNING in cm109_submit_buzz_toggle/usb_submit_urb
From:   syzbot <syzbot+c7e665956b189738fe5e@syzkaller.appspotmail.com>
To:     eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    fa02fcd9 Merge tag 'media/v5.10-2' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d1a88d500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb8d1a3819ba4356
dashboard link: https://syzkaller.appspot.com/bug?extid=c7e665956b189738fe5e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ba912d500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dfad85500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c7e665956b189738fe5e@syzkaller.appspotmail.com

------------[ cut here ]------------
URB 0000000056bd5df7 submitted while active
WARNING: CPU: 0 PID: 8490 at drivers/usb/core/urb.c:378 usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Modules linked in:
CPU: 0 PID: 8490 Comm: syz-executor949 Not tainted 5.10.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Code: 89 de e8 6b d6 3b fc 84 db 0f 85 da f4 ff ff e8 4e de 3b fc 4c 89 fe 48 c7 c7 00 57 e1 89 c6 05 01 64 a4 07 01 e8 d4 0c 78 03 <0f> 0b e9 b8 f4 ff ff c7 44 24 14 01 00 00 00 e9 6f f5 ff ff 41 bd
RSP: 0018:ffffc900012ef710 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802068b480 RSI: ffffffff8158d875 RDI: fffff5200025ded4
RBP: 0000000000000020 R08: 0000000000000001 R09: ffff8880b9e2011b
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880117c3078
R13: 00000000fffffff0 R14: ffffffff85a190a0 R15: ffff88801d38cd00
FS:  0000000001949880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005637666ec160 CR3: 0000000029267000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 cm109_submit_buzz_toggle+0xd0/0x130 drivers/input/misc/cm109.c:351
 cm109_toggle_buzzer_async drivers/input/misc/cm109.c:487 [inline]
 cm109_input_ev+0x1ea/0x230 drivers/input/misc/cm109.c:621
 input_handle_event+0x66e/0x1400 drivers/input/input.c:376
 input_inject_event+0x2f5/0x310 drivers/input/input.c:471
 kd_sound_helper+0x122/0x260 drivers/tty/vt/keyboard.c:242
 input_handler_for_each_handle+0xf4/0x210 drivers/input/input.c:2356
 kd_mksound+0x85/0x120 drivers/tty/vt/keyboard.c:266
 do_con_trol+0x813/0x54c0 drivers/tty/vt/vt.c:2152
 do_con_write+0xb89/0x1dd0 drivers/tty/vt/vt.c:2911
 con_write+0x22/0xb0 drivers/tty/vt/vt.c:3255
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x3ce/0xf80 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x4d9/0x870 drivers/tty/tty_io.c:1046
 vfs_write+0x28e/0xa30 fs/read_write.c:603
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x444859
Code: e8 bc af 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 9b d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd082c1508 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444859
RDX: 0000000000001006 RSI: 0000000020001440 RDI: 0000000000000005
RBP: 00000000006d0018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 000000000000000d R11: 0000000000000246 R12: 0000000000402480
R13: 0000000000402510 R14: 0000000000000000 R15: 0000000000000000

