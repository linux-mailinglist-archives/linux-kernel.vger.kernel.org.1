Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9347A2C02F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgKWKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:05:21 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:53654 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgKWKFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:05:19 -0500
Received: by mail-io1-f70.google.com with SMTP id c17so12290353iom.20
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BES57B4JG1nbaujnQb/iDqduyXORqzEHVZ+fboilFls=;
        b=s9cUEh58YJnelnsPjMFNclKQCFM2+sG0tp1lTbtsA5NLh7oPDfV6PpEcrPKQDk8JWZ
         2y2z2oH1OJECsoSOZoGkonWRD7IeOec4UgEQlMB61xdRu1uwpHXmoc1yvJPq4uGpPJJW
         nsiRew7oyIvDPM3qUmw+L+8Pfk12eECFH16IcqJWgjFvx5Ayc1qzzWd9lf073fLFv+Ou
         DTBsmDj3A970vlSfBpw5qAUZbvIwWqF67dZChI5rWpHZ6m3S327KhyhWjf7Bzrun0nXR
         ajgpqzHx1A1wyAc2rwos49IF9p/VIajp+uRIRBFMDXcIcNBHdb6ytL8HHUM5WsL47hGh
         0/4w==
X-Gm-Message-State: AOAM531zP5pqwkWQZ8hWvC9eZNahiPmV284Cs1ukjp66eqfEm641W7PO
        KJ9V2CeIQpoij5vvBqUwr0cPMA6rMju1bX69jD+acvEUdMPA
X-Google-Smtp-Source: ABdhPJwSorRGNEeSeAvS4oNVeulu7Uyu4xvkgFiQJ23LNQl2fqWExUhKkJqJ5wENYjRWC5b5TZXrYArHcxfMM2QLeo1mp5xf7/tb
MIME-Version: 1.0
X-Received: by 2002:a92:c88c:: with SMTP id w12mr36901962ilo.204.1606125917149;
 Mon, 23 Nov 2020 02:05:17 -0800 (PST)
Date:   Mon, 23 Nov 2020 02:05:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c19e7b05b4c35440@google.com>
Subject: WARNING in cm109_submit_buzz_toggle/usb_submit_urb
From:   syzbot <syzbot+c7e665956b189738fe5e@syzkaller.appspotmail.com>
To:     eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a349e4c6 Merge tag 'xfs-5.10-fixes-7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1756e035500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=330f3436df12fd44
dashboard link: https://syzkaller.appspot.com/bug?extid=c7e665956b189738fe5e
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c7e665956b189738fe5e@syzkaller.appspotmail.com

------------[ cut here ]------------
URB 000000001a5f6e54 submitted while active
WARNING: CPU: 0 PID: 15525 at drivers/usb/core/urb.c:378 usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Modules linked in:
CPU: 0 PID: 15525 Comm: syz-executor.5 Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x1228/0x14e0 drivers/usb/core/urb.c:378
Code: 89 de e8 2b 93 3b fc 84 db 0f 85 da f4 ff ff e8 0e 9b 3b fc 4c 89 fe 48 c7 c7 e0 6a e1 89 c6 05 03 18 a4 07 01 e8 82 fe 77 03 <0f> 0b e9 b8 f4 ff ff c7 44 24 14 01 00 00 00 e9 6f f5 ff ff 41 bd
RSP: 0018:ffffc9000395f710 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff8158f3b5 RDI: fffff5200072bed4
RBP: 0000000000000020 R08: 0000000000000001 R09: ffff8880b9e2011b
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801ef80488
R13: 00000000fffffff0 R14: ffffffff85a1ef60 R15: ffff88801297a600
FS:  00007f8480e75700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f56ba3fdc10 CR3: 0000000018999000 CR4: 00000000001526f0
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
RIP: 0033:0x45deb9
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8480e74c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000003a6c0 RCX: 000000000045deb9
RDX: 0000000000001006 RSI: 0000000020001440 RDI: 0000000000000006
RBP: 000000000118bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 000000000169fb7f R14: 00007f8480e759c0 R15: 000000000118bf2c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
