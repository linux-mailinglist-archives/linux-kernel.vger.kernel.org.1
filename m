Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A16290C67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411128AbgJPTqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390223AbgJPTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:46:06 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F144C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:46:06 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id o18so3664906edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20IL8ocrh2wprehg8ASuhDRjd5nXj9FjmJS+hWeQuVs=;
        b=K8iCqJO/qnGAtl1mzPI2HgUzmTALEKJibrHuHN2gJrfCh730JhAaPfN4aSz3QLwoOL
         IbIGBqwa2KKsbbzAgn9bA+RtnUKYYce8Emed4uYzxqJlbMJM/OqP56ASXYvZ9+UIKTeM
         6o2tn8AzhGXcVr2pzVq1jdU27iDpVELpb5t5YmlFOeVrU9BzWAGUI7UEZ9VzF02UOTg2
         VUsRbEZ1/vD9VZrLgg3HGM8Gc6+dtJO1iE9NunhiCugniIogqOFjVeXLK26JmdWKmJrA
         lkCzOomTPEglqw2jjcsZkgbT/4i3GEgzFVi82cLkLfWjFQb1coOXDv/vHS6OfweeZxAe
         39sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20IL8ocrh2wprehg8ASuhDRjd5nXj9FjmJS+hWeQuVs=;
        b=HoToJFiF3mCrOsbYDNPC4At7ECQTI2Tvu79NdmDmOEW3ZBn90ODNmh/y3qwz1VwJzq
         37TeqSo5E1bK2D3DEINVUBaVqnpyaHFcItNXrnXkWHO3QyigzbC0aVkUhUK2i8lNkckQ
         /RUHurEhH46jBAJ1NF9+rfbF5s3OTytPyqfgb0lq5MIT1EFBbevkdLACrsWMH04c5hRk
         EF8WpzHkc7+pWe0d580Zpch+/PyW+0JBDFDMfuzFGhL1oqqmrNtvYRZboP0KzqxkELat
         wIPZYgi+pOp6pdafRAbyBQJPRCCFm8+IK4qx/RU8vVGoJT/Z7vmCpAMn/WgnBPw/IcqG
         6Dgw==
X-Gm-Message-State: AOAM533Cv31pmCRv4rV4sG0L/91wVKyFvD06JRkYIpNqd+q75iSgZ1Z6
        +Z27FUhN/Vjsy6smyN2Lcxx4i7cwxLJqLta4FHw7QA==
X-Google-Smtp-Source: ABdhPJxqQd/k2+z8B0nAJDfuD7O3LXnygC6FLQmHll7m9lWevCnRns80LEs3rBMri7ZclIA8/R3LIyB9aGEBJCFxToE=
X-Received: by 2002:a05:6402:7c8:: with SMTP id u8mr5910021edy.153.1602877564755;
 Fri, 16 Oct 2020 12:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201016180907.171957-1-mcroce@linux.microsoft.com> <20201016180907.171957-2-mcroce@linux.microsoft.com>
In-Reply-To: <20201016180907.171957-2-mcroce@linux.microsoft.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 16 Oct 2020 15:45:28 -0400
Message-ID: <CA+CK2bAO+z8jMCwiHa4gsBEmUJJW-wysuEHbG-wev1McWW+=9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] reboot: fix overflow parsing reboot cpu number
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 2:09 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> Limit the CPU number to num_possible_cpus(), because setting it
> to a value lower than INT_MAX but higher than NR_CPUS produces the
> following error on reboot and shutdown:
>
>     BUG: unable to handle page fault for address: ffffffff90ab1bb0
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 1c09067 P4D 1c09067 PUD 1c0a063 PMD 0
>     Oops: 0000 [#1] SMP
>     CPU: 1 PID: 1 Comm: systemd-shutdow Not tainted 5.9.0-rc8-kvm #110
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
>     RIP: 0010:migrate_to_reboot_cpu+0xe/0x60
>     Code: ea ea 00 48 89 fa 48 c7 c7 30 57 f1 81 e9 fa ef ff ff 66 2e 0f 1f 84 00 00 00 00 00 53 8b 1d d5 ea ea 00 e8 14 33 fe ff 89 da <48> 0f a3 15 ea fc bd 00 48 89 d0 73 29 89 c2 c1 e8 06 65 48 8b 3c
>     RSP: 0018:ffffc90000013e08 EFLAGS: 00010246
>     RAX: ffff88801f0a0000 RBX: 0000000077359400 RCX: 0000000000000000
>     RDX: 0000000077359400 RSI: 0000000000000002 RDI: ffffffff81c199e0
>     RBP: ffffffff81c1e3c0 R08: ffff88801f41f000 R09: ffffffff81c1e348
>     R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>     R13: 00007f32bedf8830 R14: 00000000fee1dead R15: 0000000000000000
>     FS:  00007f32bedf8980(0000) GS:ffff88801f480000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffffff90ab1bb0 CR3: 000000001d057000 CR4: 00000000000006a0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>     __do_sys_reboot.cold+0x34/0x5b
>     ? vfs_writev+0x92/0xc0
>     ? do_writev+0x52/0xd0
>     do_syscall_64+0x2d/0x40
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     RIP: 0033:0x7f32bfaaecd3
>     Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 89 81 0c 00 f7 d8
>     RSP: 002b:00007fff6265fb58 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
>     RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f32bfaaecd3
>     RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
>     RBP: 0000000000000000 R08: 0000000000008020 R09: 00007fff6265ef60
>     R10: 00007f32bedf8830 R11: 0000000000000202 R12: 0000000000000000
>     R13: 0000557bba2c51c0 R14: 0000000000000000 R15: 00007fff6265fbc8
>     CR2: ffffffff90ab1bb0
>     ---[ end trace b813e80157136563 ]---
>     RIP: 0010:migrate_to_reboot_cpu+0xe/0x60
>     Code: ea ea 00 48 89 fa 48 c7 c7 30 57 f1 81 e9 fa ef ff ff 66 2e 0f 1f 84 00 00 00 00 00 53 8b 1d d5 ea ea 00 e8 14 33 fe ff 89 da <48> 0f a3 15 ea fc bd 00 48 89 d0 73 29 89 c2 c1 e8 06 65 48 8b 3c
>     RSP: 0018:ffffc90000013e08 EFLAGS: 00010246
>     RAX: ffff88801f0a0000 RBX: 0000000077359400 RCX: 0000000000000000
>     RDX: 0000000077359400 RSI: 0000000000000002 RDI: ffffffff81c199e0
>     RBP: ffffffff81c1e3c0 R08: ffff88801f41f000 R09: ffffffff81c1e348
>     R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>     R13: 00007f32bedf8830 R14: 00000000fee1dead R15: 0000000000000000
>     FS:  00007f32bedf8980(0000) GS:ffff88801f480000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffffff90ab1bb0 CR3: 000000001d057000 CR4: 00000000000006a0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
>     Kernel Offset: disabled
>     ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
>
> Fixes: 1b3a5d02ee07 ("reboot: move arch/x86 reboot= handling to generic kernel")
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
