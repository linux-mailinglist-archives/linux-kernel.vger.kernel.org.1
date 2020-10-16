Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B129E290C35
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410825AbgJPTZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393104AbgJPTZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:25:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9524C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:25:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so2045538pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OXk1jfBaMHbzQu0BqQr7WofN8pSj9l5vUka1ouSx6Wc=;
        b=GgLiO+wxevsX71YQYXp7fxr+ivsispxIh7DFqcdnGRxSfJDAPCPhNUhIDg/vyuD0bo
         VYNmS8+YRoxz5z0zU2lC8HKdQhqJ3Jw/bW21rEQoWJc1/gmhKHkDJ87TQZrnE8X7C2CB
         IyvCl7dqXHv4kDczugYjPhlUVbui404ozz0io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OXk1jfBaMHbzQu0BqQr7WofN8pSj9l5vUka1ouSx6Wc=;
        b=YTWOknqwclFqAE7LeKqLBDX4GZDUaFdGqnTeetzfCRaU0nKP9HfMUng2K3hKwm+1z8
         /F1Ced4QZGr8we+kRy9wAOS8VZlWNPg6M/c0ezWCJ7VNudTPhB12crqQvaOPTC94nVbs
         I6LNwwh9YWoYMbEu8ZtMtrSnXh1BnWBX3ZGj+WfsgCY+WWvpEaUzlTrPY4KLc6T4GaI+
         K8Pzxc8hW3R/z6ERK7vB5v8iyO8VKhgLjp8AkYiT9qefHpD6zlZms6i9LDjmUg7JZ8qQ
         QRSk5y8kiXuo0uYEgcKcWo3tvWm0D/ZUWlfM2Ln4C+cjGj4yjJkg4sBpaOXUJiTiyTRi
         UC/g==
X-Gm-Message-State: AOAM531wKyRkErXkVUj4yVcrxctW9K+iZdWisuCuwtZtDViAv0BaZFUg
        veC+ZTGYgzjFa8r0mmjo0kCRzuBgaPMlfg==
X-Google-Smtp-Source: ABdhPJx94/o/V5/ZWeAagrf96SWc3/wMDS0CxIjbADfA4+9mpVLezx3y3aVEvNSFSsQoBhbJaeZDHg==
X-Received: by 2002:a17:902:be0c:b029:d2:8ceb:f39c with SMTP id r12-20020a170902be0cb02900d28cebf39cmr5538086pls.71.1602876357089;
        Fri, 16 Oct 2020 12:25:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 78sm3661187pfz.211.2020.10.16.12.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 12:25:56 -0700 (PDT)
Date:   Fri, 16 Oct 2020 12:25:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] reboot: fix overflow parsing reboot cpu number
Message-ID: <202010161225.393710E4@keescook>
References: <20201016180907.171957-1-mcroce@linux.microsoft.com>
 <20201016180907.171957-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016180907.171957-2-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 08:09:06PM +0200, Matteo Croce wrote:
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
