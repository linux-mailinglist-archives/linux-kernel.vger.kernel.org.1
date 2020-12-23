Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8B2E1830
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 05:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgLWEz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 23:55:59 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:54983 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgLWEz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 23:55:58 -0500
Received: by mail-io1-f69.google.com with SMTP id w26so8751996iox.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 20:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0AMYjD/pxBTETFPwb6JYZi7Zmkv7q/ElhzCe3QZaWNQ=;
        b=Gec5wjVSI+DJfN2eD+Ws6e9g18pEThfTCwCjrY5Vd9qZHFdx/uPe7U6rpweIT5ysZn
         MgKQj3WTbZCQ37qbeTQdyekIDOMvWdKBiPvRy1tD8ZqNWoRffc6YEDOif0F+sjr3DqxP
         rr9gHRGcvrMcn5spPdndQlx3qIgKnuStPUIh24l4+vJterUsIPQUyRVijyTgABnVaojF
         CtJyZXXJd7dGazsl9mHY7XPTYimOk2jh5xK3oGajPGWzPaegw8RwbLW0UKHKd1P6hJX5
         CbBuRhrjDct4ISt+I1xJPSOJmV1r+h6NrPlfhMRfOiHTEPnUCk1G+pMi3ATbK324ybTh
         s0bA==
X-Gm-Message-State: AOAM530JhNok9zbx8tVN1xk5UGCtMN/kS49UMvyXE99iFggKbSX5QQUR
        TxJFn/MjnIqKf+w1qzsKko3wgdgnWtaqRwvKO6wG27OMIV1F
X-Google-Smtp-Source: ABdhPJzISnbV2PHeJ+Oxrkr7p3UTw5CVnrOBGiuc9E3Z/5NFBcDh8BjYrTPDazJPZthTe0shCPBPL1XcztXeL/2WciWz1DffGSFl
MIME-Version: 1.0
X-Received: by 2002:a92:ce47:: with SMTP id a7mr24558636ilr.261.1608699317489;
 Tue, 22 Dec 2020 20:55:17 -0800 (PST)
Date:   Tue, 22 Dec 2020 20:55:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e950e05b71a7fd9@google.com>
Subject: UBSAN: shift-out-of-bounds in vhci_hub_control
From:   syzbot <syzbot+297d20e437b79283bf6d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a409ed15 Merge tag 'gpio-v5.11-1' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1053b623500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7c39e7211134bc0
dashboard link: https://syzkaller.appspot.com/bug?extid=297d20e437b79283bf6d
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f4f137500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1115f30f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+297d20e437b79283bf6d@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in drivers/usb/usbip/vhci_hcd.c:399:41
shift exponent 768 is too large for 32-bit type 'int'
CPU: 1 PID: 8482 Comm: syz-executor092 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 vhci_hub_control.cold+0x205/0x246 drivers/usb/usbip/vhci_hcd.c:399
 rh_call_control drivers/usb/core/hcd.c:683 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:841 [inline]
 usb_hcd_submit_urb+0xcaa/0x22d0 drivers/usb/core/hcd.c:1544
 usb_submit_urb+0x6e4/0x1560 drivers/usb/core/urb.c:585
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 do_proc_control+0x4cb/0x9c0 drivers/usb/core/devio.c:1165
 proc_control drivers/usb/core/devio.c:1191 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2535 [inline]
 usbdev_ioctl+0x12c1/0x3b20 drivers/usb/core/devio.c:2708
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443f39
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd18a092c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443f39
RDX: 0000000020000000 RSI: 00000000c0185500 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000401bc0
R13: 0000000000401c50 R14: 0000000000000000 R15: 0000000000000000
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
