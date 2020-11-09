Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F62AC4FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgKIT35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKIT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:29:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0671C0613CF;
        Mon,  9 Nov 2020 11:29:55 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id o21so13968366ejb.3;
        Mon, 09 Nov 2020 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RY20dt3ip/OwiBMlSf/TL7DKVGCOSFyGilBoU60ly7Q=;
        b=FTClbMvnZH9/EjC8NIbNp8jg7/wMCyEaakfGIIXFIu9BwEwZLPp9j7X72OWJMGqq5B
         Eq6hQXHkFIVTD0XIdH/62pd1rrox8krxW3FhB8vNKj4xu5Or5zJLPa2wHeAFLcR+J1lV
         Wr6KaCnKDX6lK/dnFvbRUoHZq5fPWzVkPW7u4nL1cNeIPDl7nG0MpN5OV3uHE+4mpOYQ
         D/mFlGXq2uWRo9SwggwlsqI2WQDNnHIZA8z3/k4WxCbeq1dCiIj4vXcnQLXXQaxysStG
         9QHOsNrkxsoGKoDEwX+P2Wv34py9LxCZkH4ngNGUglRFj6l47PJK4pzkhVUTxm8sFvZS
         dzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RY20dt3ip/OwiBMlSf/TL7DKVGCOSFyGilBoU60ly7Q=;
        b=tugKblUTY8z2FuROoKFGZnmVeM16hgIZQvZYZhRo1QHRuLmIARAQ5sC3NVLubAw/kb
         6bseqtwsNlvERfuj9ozK5nyQ4deO9tUH+y5NM1jj+1oRfDvebY+4OVzgL4WUhZlDTB50
         FLBzGpPZrrqON/cfQT61qpwUuVbGP5l/punQcqJ8g5XRp1gKjSJejzU3Nee88NT4i5U+
         MgFDOlFfFgS+8IaUF+TDgxASn4m821TxucmUr6P6KYqzdeKEck7ek2vtPQiA21u07YtA
         aWiSS7gcfJzVDwDfRw46lycjb1PDVBxJeIe4zQAPT0x/RFWmNWlFKBzH19vbs/b7/kOq
         fi/Q==
X-Gm-Message-State: AOAM532PXeWnKCzhsmhQKF4pZLiIP0pbxS80Z8gUtWX3AN5pERQLmhkW
        dAh99/2/JhVlPG6iQcrq0Ghx9xcMRR0G9h1gF+I=
X-Google-Smtp-Source: ABdhPJwu7Wg3rXjrhZkq9jtQaZBWQKNrpmIeD+74Np/FpcVLaQhzhHd1ObqQBbneh0kMXJo+GuIKRUe3LJakVRMpjrg=
X-Received: by 2002:a17:906:1e45:: with SMTP id i5mr16191108ejj.203.1604950194280;
 Mon, 09 Nov 2020 11:29:54 -0800 (PST)
MIME-Version: 1.0
References: <CAEAjamsxe9OuMVpHfox3w57HtGsE3mPXOty9bdXW-iPdx=TXMA@mail.gmail.com>
In-Reply-To: <CAEAjamsxe9OuMVpHfox3w57HtGsE3mPXOty9bdXW-iPdx=TXMA@mail.gmail.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Mon, 9 Nov 2020 14:29:42 -0500
Message-ID: <CAEAjamsjFXWGSwUcCuUOeJ8s9EWGQP-Jvt40bG0Otav=xFb+5A@mail.gmail.com>
Subject: Re: WARNING in usb_composite_setup_continue
To:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug (in linux-5.8.13) found by FuzzUSB (a modified version
of syzkaller).

(corrected analysis)
This bug happens while continuing a delayed setup message in mass
storage gadget.
To be specific, composite_setup() sets FSG_STATE_CONFIG_CHANGE via
fsg_set_alt() (line 1793),
and followed by cdev->delayed_status++ (line 1798).
Meanwile, the mass gadget tries  check cdev->delayed_status == 0
through handle_exception() (line 2428),
which occurs in between the two operations above.
Such a race causes invalid operations eventually.

==================================================================
usb_composite_setup_continue: Unexpected call
WARNING: CPU: 1 PID: 1882 at drivers/usb/gadget/composite.c:2457
usb_composite_setup_continue+0x1c7/0x220
drivers/usb/gadget/composite.c:2457
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 1882 Comm: file-storage Not tainted 5.8.13 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xa7/0xea lib/dump_stack.c:118
 panic+0x298/0x521 kernel/panic.c:231
 __warn.cold.12+0x25/0x32 kernel/panic.c:600
 report_bug+0x1b2/0x260 lib/bug.c:198
 handle_bug+0x43/0x70 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x18/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 ./arch/x86/include/asm/idtentry.h:540
RIP: 0010:usb_composite_setup_continue+0x1c7/0x220
drivers/usb/gadget/composite.c:2457
Code: 62 48 8b 7b 58 4c 89 fe e8 66 fb ff ff e9 e6 fe ff ff e8 6c 89
87 fd 48 c7 c6 60 c9 41 86 48 c7 c7 60 c6 41 86 e8 78 0c 5c fd <0f> 0b
e9 c7 fe ff ff e8 3d a4 ae fd e9 a3 fe ff ff e8 53 a4 ae fd
RSP: 0000:ffff8880446dfd38 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff888069eee4b0 RCX: 0000000000000000
RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffffed10088dbf9d
RBP: ffff8880446dfd60 R08: ffffed100d953fd2 R09: ffffed100d953fd2
R10: ffff88806ca9fe8b R11: ffffed100d953fd1 R12: 0000000000000000
R13: ffff888069eee540 R14: 0000000000000246 R15: ffff888040609310
 handle_exception drivers/usb/gadget/function/f_mass_storage.c:2428 [inline]
 fsg_main_thread+0x12f4/0x59f1 drivers/usb/gadget/function/f_mass_storage.c:2466
 kthread+0x374/0x480 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
==================================================================

Regards,
Kyungtae Kim

On Mon, Nov 9, 2020 at 2:08 PM Kyungtae Kim <kt0755@gmail.com> wrote:
>
> We report a bug (in linux-5.8.13) found by FuzzUSB (a modified version
> of syzkaller).
>
> The bug happens when the freed object tty->port is accessed in
> tty_init_dev (line 1358).
> It seems tty->port is freed during the locking (i.e., tty_ldisc_lock)
> ahead (line 1355).
>
> ==================================================================
> usb_composite_setup_continue: Unexpected call
> WARNING: CPU: 1 PID: 1882 at drivers/usb/gadget/composite.c:2457 usb_composite_setup_continue+0x1c7/0x220 drivers/usb/gadget/composite.c:2457
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 1882 Comm: file-storage Not tainted 5.8.13 #4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xa7/0xea lib/dump_stack.c:118
>  panic+0x298/0x521 kernel/panic.c:231
>  __warn.cold.12+0x25/0x32 kernel/panic.c:600
>  report_bug+0x1b2/0x260 lib/bug.c:198
>  handle_bug+0x43/0x70 arch/x86/kernel/traps.c:235
>  exc_invalid_op+0x18/0x40 arch/x86/kernel/traps.c:255
>  asm_exc_invalid_op+0x12/0x20 ./arch/x86/include/asm/idtentry.h:540
> RIP: 0010:usb_composite_setup_continue+0x1c7/0x220 drivers/usb/gadget/composite.c:2457
> Code: 62 48 8b 7b 58 4c 89 fe e8 66 fb ff ff e9 e6 fe ff ff e8 6c 89 87 fd 48 c7 c6 60 c9 41 86 48 c7 c7 60 c6 41 86 e8 78 0c 5c fd <0f> 0b e9 c7 fe ff ff e8 3d a4 ae fd e9 a3 fe ff ff e8 53 a4 ae fd
> RSP: 0000:ffff8880446dfd38 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: ffff888069eee4b0 RCX: 0000000000000000
> RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffffed10088dbf9d
> RBP: ffff8880446dfd60 R08: ffffed100d953fd2 R09: ffffed100d953fd2
> R10: ffff88806ca9fe8b R11: ffffed100d953fd1 R12: 0000000000000000
> R13: ffff888069eee540 R14: 0000000000000246 R15: ffff888040609310
>  handle_exception drivers/usb/gadget/function/f_mass_storage.c:2428 [inline]
>  fsg_main_thread+0x12f4/0x59f1 drivers/usb/gadget/function/f_mass_storage.c:2466
>  kthread+0x374/0x480 kernel/kthread.c:291
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> ==================================================================
>
> Regards,
> Kyungtae Kim
