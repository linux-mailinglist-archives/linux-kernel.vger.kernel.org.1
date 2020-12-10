Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2A2D588B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbgLJKrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgLJKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:47:40 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF49C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:47:00 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id x13so4419653oto.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtdjIQ5SJDFmnCZSyzmhAXH/YH5M6HEt49uwTecu7X8=;
        b=la68MHtIcJruNE2aDq3gUonFJFznSbBFnG5tBh3HfzENHYc+xnlqJgvl3Du0Og0cWs
         eY+7Xr2DDMQUtClvNSTY4tH8MuFFNwklHamYkOndYkxporZ+zBvXfkjlThnA5GZk8Rjd
         nj2IR4bNKVP/paT7F6526UauAQUIRKbOSNPMFdEgjQx7V7lDXHKvXrnHXMgXqh0BPecS
         2Ya3vgV72n7kZS+/4UokTPTZCg0nmzBRqQNh0mCb1irRucM5GPE1/pcWgjrqfAHSLSv/
         NbWndkhp+Vhzx/IhP/S7UgfDox7499pV06k+yAFB56buiIusAkGJv6GTfv/2QIIqiuBS
         TfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtdjIQ5SJDFmnCZSyzmhAXH/YH5M6HEt49uwTecu7X8=;
        b=TqpWhBA27rAxgy3ppDT67YLDzMMUM+0rnAVTzS7/H3BjWm2TSSrEk2zvtF2lnGJ+7D
         MLnA3xBtm89FxlHXgYW1ryRj0vskkWLwx+Y6QVzvwNq1rWWfbebeEcXpvlA7dsTwMnFx
         +fKO26xH3ghL9eC3/Lc/oJEghxw3XPtmE1XPoseZe4TMdUKkKkX1bkE0p3gnyQmftLUj
         1u4+JUyWaqcuEHBSto7TQvxIAA/Ruig8DBUzvoSz9w9jDIyyEawVb47Y2pKU59/aDV+S
         5cxlMuazDt12K0LJ47fT+oqsLS8byNbTe30GlaT/zCuDVOwgn0lI2O6N3OFy8U9giWZe
         rC2g==
X-Gm-Message-State: AOAM533AYzHeWljvGsJpGNeJb+E7vmsJ4NmryHT7LJr1wFHyIEQ0F2Lt
        cfWtsx+qW5TWDyqNyL8m+VA2sdvTGdYZFeWPW6AoTQ==
X-Google-Smtp-Source: ABdhPJxpifOrRTIWrNclMcMi5TIlNlVUtZ9xQayU435dLvj/vHmmbwiAwaQjf5Yw7ZE3SBLZovvMoXEYa/CpihjGOcA=
X-Received: by 2002:a9d:7cc8:: with SMTP id r8mr5344758otn.233.1607597219783;
 Thu, 10 Dec 2020 02:46:59 -0800 (PST)
MIME-Version: 1.0
References: <00000000000091a3bc05b619d7ed@google.com>
In-Reply-To: <00000000000091a3bc05b619d7ed@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 10 Dec 2020 11:46:48 +0100
Message-ID: <CANpmjNOZYL463VTaw91dRmixF7BHUPe4EjCh38igdE__pjXi4A@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in squashfs_export_iget
To:     syzbot <syzbot+04419e3ff19d2970ea28@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, phillip@squashfs.org.uk,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 at 11:43, syzbot
<syzbot+04419e3ff19d2970ea28@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a9e26cb5 Add linux-next specific files for 20201208
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1674f80f500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e259434a8eaf0206
> dashboard link: https://syzkaller.appspot.com/bug?extid=04419e3ff19d2970ea28
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a6adf500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10457ccb500000
>
> The issue was bisected to:
>
> commit 555f63cd88404e122e8d31d0f925e430bd3f32d9
> Author: Alexander Potapenko <glider@google.com>
> Date:   Fri Dec 4 03:19:29 2020 +0000
>
>     mm, kfence: insert KFENCE hooks for SLUB

This appears to be flaky bisection, and is not due to KFENCE.

It can be reproduced even with CONFIG_KFENCE=n, and also reverting
"mm, kfence: insert KFENCE hooks for SLUB" entirely.

Thanks,
-- Marco

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1619bb7f500000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1519bb7f500000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1119bb7f500000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+04419e3ff19d2970ea28@syzkaller.appspotmail.com
> Fixes: 555f63cd8840 ("mm, kfence: insert KFENCE hooks for SLUB")
>
> loop0: detected capacity change from 264192 to 0
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in squashfs_inode_lookup fs/squashfs/export.c:44 [inline]
> BUG: KASAN: slab-out-of-bounds in squashfs_export_iget+0x274/0x2a0 fs/squashfs/export.c:69
> Read of size 8 at addr ffff88801c6f6e08 by task syz-executor839/8488
>
> CPU: 0 PID: 8488 Comm: syz-executor839 Not tainted 5.10.0-rc7-next-20201208-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:120
>  print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
>  __kasan_report mm/kasan/report.c:396 [inline]
>  kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
>  squashfs_inode_lookup fs/squashfs/export.c:44 [inline]
>  squashfs_export_iget+0x274/0x2a0 fs/squashfs/export.c:69
>  squashfs_fh_to_dentry fs/squashfs/export.c:84 [inline]
>  squashfs_fh_to_dentry+0x78/0xb0 fs/squashfs/export.c:77
>  exportfs_decode_fh_raw+0x127/0x7a0 fs/exportfs/expfs.c:436
>  exportfs_decode_fh+0x38/0x90 fs/exportfs/expfs.c:575
>  do_handle_to_path fs/fhandle.c:152 [inline]
>  handle_to_path fs/fhandle.c:207 [inline]
>  do_handle_open+0x2b6/0x7f0 fs/fhandle.c:223
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x4443d9
> Code: 8d d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd937fcd78 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 00000000004443d9
> RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000005
> RBP: 00000000006cf018 R08: 00007ffd00000015 R09: 00000000004002e0
> R10: 00007ffd937fcc20 R11: 0000000000000246 R12: 0000000000401fc0
> R13: 0000000000402050 R14: 0000000000000000 R15: 0000000000000000
>
> Allocated by task 6500:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
>  kasan_set_track mm/kasan/common.c:47 [inline]
>  set_alloc_info mm/kasan/common.c:405 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:436 [inline]
>  ____kasan_kmalloc.constprop.0+0xa0/0xd0 mm/kasan/common.c:408
>  kmalloc include/linux/slab.h:570 [inline]
>  kzalloc include/linux/slab.h:695 [inline]
>  lsm_cred_alloc security/security.c:534 [inline]
>  security_prepare_creds+0x10e/0x190 security/security.c:1633
>  prepare_creds+0x509/0x730 kernel/cred.c:285
>  access_override_creds fs/open.c:353 [inline]
>  do_faccessat+0x3d7/0x870 fs/open.c:417
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> The buggy address belongs to the object at ffff88801c6f6de8
>  which belongs to the cache kmalloc-8 of size 8
> The buggy address is located 24 bytes to the right of
>  8-byte region [ffff88801c6f6de8, ffff88801c6f6df0)
> The buggy address belongs to the page:
> page:0000000061a643f0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801c6f6de8 pfn:0x1c6f6
> flags: 0xfff00000000200(slab)
> raw: 00fff00000000200 ffffea0000625500 0000000500000005 ffff888010841c80
> raw: ffff88801c6f6de8 000000008066005d 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff88801c6f6d00: fc fc fc fc fb fc fc fc fc fb fc fc fc fc fb fc
>  ffff88801c6f6d80: fc fc fc fb fc fc fc fc fa fc fc fc fc fb fc fc
> >ffff88801c6f6e00: fc fc 00 fc fc fc fc fa fc fc fc fc fb fc fc fc
>                       ^
>  ffff88801c6f6e80: fc 00 fc fc fc fc fa fc fc fc fc fb fc fc fc fc
>  ffff88801c6f6f00: 00 fc fc fc fc fa fc fc fc fc fb fc fc fc fc fb
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
