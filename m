Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE40120D6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbgF2TW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbgF2TWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:22:45 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E22C030F3B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:56:54 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u17so13400638qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmp0D2tdeFRnXQgw7lSdvfRGqahLRtacjy20V4Dgy4c=;
        b=Jfgz6+ehlKKKW4qoq8xVJu2q7caS/mX7d2eerQrmJ/I8fEtrkUoYA5pgWnWcfjvIDt
         utQSsqPaOEgIRXKX03NaualVOXjO63W2a35ig0TSMcEvHD/PcZNONbY9GUUYfk1mDK7a
         ouQynf+wqQT5N4M8740UpW12VB7n9Jgyl+lX2odBXE5pal3VZrz0Gun2gLsRDsoSeCn1
         4izLQLIdLSK2kPxv32lSMlEo3LqIFrnsiB9ePxMtpwt8X5utuupEstYsFyha+jdQgRgh
         WgnW+TwAW5sRiUUFiQ6MSEV88c8RfYaX8bxGe/hkSHOAZI8dMGVQyQmstOf6vv5SN6vx
         oMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmp0D2tdeFRnXQgw7lSdvfRGqahLRtacjy20V4Dgy4c=;
        b=eGS9hzkIy2dX2D/M9MhsWAbwRdzOcQGFOVnuKmocdz2sO28mh2Sw768ieeYC6qKW7R
         i5j0XzFiX1GSzU9BirFpC0IHiK1OQ083PpQYa0Drpvxj7KN3OXpERHklmV08+AlI/gmj
         IIpYZq2GzvhCwwBZTcb3GYu5rVuo+w9hfb1wd7toY2SZCpUWU8KfRJZWwlEbujoS6AWO
         dLcSt6sjLM0oHQ5Xp0M1fAUfYZbMGfShknxvM4+sgMiFrNm3e8j/1L0EcP8XG4J8jmyD
         QgXrzfcNR0KeqmL5nKQzQ84l3Tt3/s6qB/hoN/pTNahuj1kJAypDEXXHXqv8CffaLs22
         ZIOw==
X-Gm-Message-State: AOAM530u7c5FbsaZmN9WTsxe+qP1AL/FvBALHk5RiUAsYjN2jhJIfuc0
        6dvWdNiD3Vxvh0HM8VLgDJrkEGQQGvR6g1+dWattAw==
X-Google-Smtp-Source: ABdhPJz4vWfkua2eG9MpTJ6k/kJDSLhEXhO0H2alk/afqT4ySNVYGzkUifS11LUHAxlT47DxEztZASWHQWqf40cxVOE=
X-Received: by 2002:ac8:260b:: with SMTP id u11mr16891475qtu.380.1593449812975;
 Mon, 29 Jun 2020 09:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a4293f0598ef165e@google.com> <000000000000a1c96505a109a31b@google.com>
In-Reply-To: <000000000000a1c96505a109a31b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Jun 2020 18:56:41 +0200
Message-ID: <CACT4Y+bK_1tNXQoVHz=maMr-pCw4FK_chGzA7LuvChM6DGO-LA@mail.gmail.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Write in bitfill_aligned
To:     syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>,
        gk568005@gmail.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 10:34 AM syzbot
<syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    fb33c651 Linux 5.6-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17dacd55e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
> dashboard link: https://syzkaller.appspot.com/bug?extid=e5fd3e65515b48c02a30
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b8ca75e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114800e5e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com

+George who may know what causes this

> ==================================================================
> BUG: KASAN: vmalloc-out-of-bounds in bitfill_aligned drivers/video/fbdev/core/sysfillrect.c:54 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in bitfill_aligned+0x34b/0x410 drivers/video/fbdev/core/sysfillrect.c:25
> Write of size 8 at addr ffffc90009621000 by task syz-executor767/9337
>
> CPU: 3 PID: 9337 Comm: syz-executor767 Not tainted 5.6.0-rc6-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0x5/0x315 mm/kasan/report.c:374
>  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
>  kasan_report+0xe/0x20 mm/kasan/common.c:641
>  bitfill_aligned drivers/video/fbdev/core/sysfillrect.c:54 [inline]
>  bitfill_aligned+0x34b/0x410 drivers/video/fbdev/core/sysfillrect.c:25
>  sys_fillrect+0x415/0x7a0 drivers/video/fbdev/core/sysfillrect.c:291
>  drm_fb_helper_sys_fillrect+0x1c/0x190 drivers/gpu/drm/drm_fb_helper.c:719
>  bit_clear_margins+0x2d5/0x4a0 drivers/video/fbdev/core/bitblit.c:232
>  fbcon_clear_margins+0x1de/0x240 drivers/video/fbdev/core/fbcon.c:1379
>  fbcon_switch+0xd1b/0x1740 drivers/video/fbdev/core/fbcon.c:2361
>  redraw_screen+0x2a8/0x770 drivers/tty/vt/vt.c:1008
>  fbcon_modechanged+0x5bd/0x780 drivers/video/fbdev/core/fbcon.c:2998
>  fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:3045
>  fb_set_var+0xad0/0xd40 drivers/video/fbdev/core/fbmem.c:1056
>  do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1109
>  fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1185
>  vfs_ioctl fs/ioctl.c:47 [inline]
>  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
>  __do_sys_ioctl fs/ioctl.c:772 [inline]
>  __se_sys_ioctl fs/ioctl.c:770 [inline]
>  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x433d29
> Code: c4 18 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb da fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff33d61508 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000433d29
> RDX: 00000000200001c0 RSI: 0000000000004601 RDI: 0000000000000003
> RBP: 00000000006b2018 R08: 0000000000000000 R09: 00000000004002e0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401bc0
> R13: 0000000000401c50 R14: 0000000000000000 R15: 0000000000000000
>
>
> Memory state around the buggy address:
>  ffffc90009620f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90009620f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffc90009621000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>                    ^
>  ffffc90009621080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>  ffffc90009621100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
> ==================================================================
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000a1c96505a109a31b%40google.com.
