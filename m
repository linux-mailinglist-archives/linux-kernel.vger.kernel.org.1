Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95C227092B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 01:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRXbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 19:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgIRXbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 19:31:48 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D19621734
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 23:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600471907;
        bh=njgQr9zeF3cr3Cz2b4XdGx4jq2rxOAQmX6ygJVwIX3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=06Tl3PXMu2ikpnUvxnV3JZw9+yZIsc9Md2BTHPJ9oxf9iQgxSkI9H2prFfP7w+6Fn
         CYCjrMt4lzYT9v01hvk9bFz65Gvcuz3k4qlZByl769x7QoFwYFGUzamc/AY5U/pEWo
         UoZjFIdEn1a3nM5IITDLi8zVjNXYGWQpQwGMvbD4=
Received: by mail-wm1-f53.google.com with SMTP id e17so6750414wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 16:31:47 -0700 (PDT)
X-Gm-Message-State: AOAM533ccBaxSDnVXFKbrzBJEp4Fr8CHmCe0WlMc9gt4T8bqFNg9UjHc
        YxPSKBCziK6O+eCXUakxE/aGmY/z5Z1zT7Q+ijy7Pw==
X-Google-Smtp-Source: ABdhPJyq877SqJ3Y1fUzs8U3IKESF/+UtCQ5kte00FuX7v9wTQbhKD5kzWP2qfAN3psFdFnvIlxWVMcmHwd5GKHBbdk=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr17789951wmc.176.1600471905814;
 Fri, 18 Sep 2020 16:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000762dee05af9ccd01@google.com>
In-Reply-To: <000000000000762dee05af9ccd01@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 18 Sep 2020 16:31:33 -0700
X-Gmail-Original-Message-ID: <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
Message-ID: <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
Subject: Re: WARNING in ex_handler_uaccess
To:     syzbot <syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 2:01 PM syzbot
<syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    10b82d51 Merge branch 'for-5.9-fixes' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13fb6b07900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=773ee8ece5f19a24
> dashboard link: https://syzkaller.appspot.com/bug?extid=ea3a78a71705faf41d77
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com
>
> WARNING: CPU: 2 PID: 6875 at arch/x86/mm/extable.c:77 ex_handler_uaccess+0xba/0xe0 arch/x86/mm/extable.c:77
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 2 PID: 6875 Comm: io_uring-sq Not tainted 5.9.0-rc5-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x198/0x1fd lib/dump_stack.c:118
>  panic+0x382/0x7fb kernel/panic.c:231
>  __warn.cold+0x20/0x4b kernel/panic.c:600
>  report_bug+0x1bd/0x210 lib/bug.c:198
>  handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> RIP: 0010:ex_handler_uaccess+0xba/0xe0 arch/x86/mm/extable.c:77
> Code: 1d 5c 30 fa 09 31 ff 89 de e8 e2 ae 40 00 84 db 75 80 e8 b9 b2 40 00 48 c7 c7 e0 1a 69 88 c6 05 3c 30 fa 09 01 e8 a8 ee 10 00 <0f> 0b e9 61 ff ff ff 48 89 df e8 87 7a 81 00 eb 87 e8 10 7b 81 00
> RSP: 0018:ffffc9000e03f6c8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88801b420400 RSI: ffffffff815f5a85 RDI: fffff52001c07ecb
> RBP: ffffc9000e03f7b8 R08: 0000000000000001 R09: ffffffff8ce2daef
> R10: 000000000000143b R11: 0000000000000000 R12: ffffffff89b3f410
> R13: 000000000000000d R14: 0000000000000000 R15: 0000000000000000
>  fixup_exception+0x9a/0xca arch/x86/mm/extable.c:166
>  __exc_general_protection arch/x86/kernel/traps.c:557 [inline]
>  exc_general_protection+0xeb/0x2e0 arch/x86/kernel/traps.c:524
>  asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:532
> RIP: 0010:check_zeroed_user+0xd7/0x260 lib/usercopy.c:65
> Code: ab 00 00 00 e8 6a 61 d4 fd 48 89 ee 48 89 df e8 5f 5d d4 fd 48 39 eb 0f 87 92 00 00 00 e8 51 61 d4 fd 0f 01 cb 0f ae e8 31 ed <49> 8b 1e 31 ff 89 ee e8 9d 5d d4 fd 85 ed 75 6d e8 34 61 d4 fd 31
> RSP: 0018:ffffc9000e03f860 EFLAGS: 00050246
> RAX: 0000000000000000 RBX: 2000024020012545 RCX: ffffffff83a1de61
> RDX: ffff88801b420400 RSI: ffffffff83a1de6f RDI: 0000000000000006
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8b34a68f
> R10: 2000024020012545 R11: 0000000000000000 R12: 0000000000000000
> R13: 000000000001232d R14: 2000024020000218 R15: 0000000000000000
>  copy_struct_from_user include/linux/uaccess.h:310 [inline]
>  io_openat2_prep fs/io_uring.c:3560 [inline]

Hi Aleksa-

check_zeroed_user() looks buggy.  It does:

       if (!user_access_begin(from, size))
               return -EFAULT;

       unsafe_get_user(val, (unsigned long __user *) from, err_fault);

This is wrong if size < sizeof(unsigned long) -- you read outside the
area you verified using user_access_begin().  The code down below in
the loop appears to have the same bug.

I'm not sure what the right fix is.  Even changing the
user_access_begin() isn't going to fix it, because you have a second
bug: this over-read can also get -EFAULT and fail a perfectly valid
syscall if the zeroed region is unaligned and butts up to the end of a
vma.  For example, if you do a syscall that has a checked zeroed
region that's exactly one byte long at the last byte of a page, you'll
-EFAULT.  Whoops.

I don't *think* this is a major security bug, but it does give
malicious userspace a trivial way to generate WARN messages on x86_64.
(Although I admit I'm a wee bit confused as to how this actually
triggered the #GP warning -- maybe the address check is a bit looser
than it could be.  We don't actually allow tasks the allocate the
topmost lower-half canonical address.)
