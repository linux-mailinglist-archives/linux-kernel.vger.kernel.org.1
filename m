Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FBD2A85B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgKESJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:09:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:37324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKESJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:09:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604599741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7cOppDpyfBKeoQYClynSGZyit3U2NJyO9+gCgZ5R5hc=;
        b=M7kfwesP0WEild1yzy9eqnKbdAvhZfYFNlzpricF29uyyZ5hDeBnUh/jzpPQcdVMiCz/n+
        /Q7MrryNJQRiL8Pb/BwPaiqk0hkAHQc8vRQwI4aZPSWQFuNwY+7ItdQF/dsNvqVwpmHQd7
        SGibdX7kadqw43aFdDxP9DMiQoVOUvg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0DF6AB8F;
        Thu,  5 Nov 2020 18:09:00 +0000 (UTC)
Date:   Thu, 5 Nov 2020 19:09:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/3] reboot: fix overflow parsing reboot cpu number
Message-ID: <20201105180900.GH1602@alley>
References: <20201103214025.116799-1-mcroce@linux.microsoft.com>
 <20201103214025.116799-3-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103214025.116799-3-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-11-03 22:40:24, Matteo Croce wrote:
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  kernel/reboot.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 8fbba433725e..af6f23d8bea1 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -558,6 +558,13 @@ static int __init reboot_setup(char *str)
>  				reboot_cpu = simple_strtoul(str+3, NULL, 0);
>  			else
>  				*mode = REBOOT_SOFT;
> +			if (reboot_cpu >= num_possible_cpus()) {
> +				pr_err("Ignoring the CPU number in reboot= option. "
> +				       "CPU %d exceeds possible cpu number %d\n",

./scripts/checkpatch.pl used to complain that printk() format parameter should stay
on a single line (ignoring 80 char limit). It helps when people are
trying to find which code printed a particular message.

It is not a big deal here because %d does not allow to search the
entire message anyway.

I am not sure if Andrew would like to get this fixed. In both cases:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
