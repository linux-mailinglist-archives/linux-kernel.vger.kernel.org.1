Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003DA27EF09
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgI3QX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3QX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:23:57 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F21C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:23:57 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o5so1976799qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooUSvbCCQ9/XhBGfI5xDVoSXEnZoggM8/6CQ7IOBuLU=;
        b=wQ/TGV8c8PlmdEq+jT/W1dX3KDqA/BEHU2VPsDzS1l9twAENIje8FcQ8oS5/64gH0F
         VgLclN+CCwJfNQrntLX0wsuvnN9rTEMcg/2rKplbu4XZmxzWqGiHucWEuOs/WJ3yUkON
         509dZF89GdCgx9Dgq/VDdQU29w4oQUKchFbPDVIeiv2jl9uBfh1DHSXqo0bRMen2epVj
         pQ5WEWZq9t/UnStHrGBW8i0SncvpBwdUR3TSzvd3X77VZX6N2cGWzU/jyEJGW5/MfnS2
         xE6p8yDbSTr4reH0qItRLYeU3dBEleYhqOVhxrolLYN00XymccWwX3KubBNsW0jsA9cQ
         cn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooUSvbCCQ9/XhBGfI5xDVoSXEnZoggM8/6CQ7IOBuLU=;
        b=M1CTA9O8ZxmzHQiJHHiwALwLZ1PB3S7DzJszATQdvzQekNQZa+kas88nkG1NeXst45
         0TKY3RF2paysWxncIlGx7Qqse3YUMg/B0nptMZz0SxopNoRHEhrMMjJsT1zts6Jzc9jI
         0cio6t+RCDrbkIiHB+GHTg+y8hRygZ+6W6hiwDm2KAkbE36HD3QVJNmWFcOkLV0JMbjk
         AHkHTf7NM2a4iB4J4Y1coX+DHIcqKRWGCLIaoqqZaamVR7kD7ndrXn/Rf8aLc2ztO4y4
         6f6JR0SoiZaDOCJe/63mRuV4/QQHcOI7sgAXKrawkadZbSWLfO3bKq83Nxr+1OQio10T
         FtiQ==
X-Gm-Message-State: AOAM530+H/XQ8+YTz8NINBlTarJvy7cGCiraCm64o6slLqsLOfbpE6vn
        ukUClzvnqUBN7UtKmibqZh0ig/28ZR4bo6qUqAt3bA==
X-Google-Smtp-Source: ABdhPJylr1gW0t3ia3PYtP7yp06E3otEfURzAVU4eG0Usov95cnoflHs4AdMplvwO7njKKxiZAVs8HPAG49OHZi0XyI=
X-Received: by 2002:a37:a4c5:: with SMTP id n188mr3467803qke.8.1601483035866;
 Wed, 30 Sep 2020 09:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200927145737.GA4746@zn.tnic> <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
 <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
 <20200928083819.GD1685@zn.tnic> <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic> <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
 <20200928202353.GI1685@zn.tnic> <20200929083336.GA21110@zn.tnic>
 <CACT4Y+bfKwoZe3SC-BKJkOET1GxGp9tCpLzkae8q1sjWYnmgmw@mail.gmail.com> <20200930161711.GH6810@zn.tnic>
In-Reply-To: <20200930161711.GH6810@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Sep 2020 18:23:44 +0200
Message-ID: <CACT4Y+Zc7kD431Aed49U4R6cqzWGAWqEXevnheRHKQRQoEnh7w@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 6:17 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> one more thing I just spotted. The default install of syzkaller here
> runs the guest with this on the kernel command line:
>
> 2020/09/30 17:56:18 running command: qemu-system-x86_64 []string{"-m", "2048",
> "-smp", "2", "-display", ... "-append", "earlyprintk=serial oops=panic ...
>  nmi_watchdog=panic panic_on_warn=1 panic=1 ftrace_dump_on_oops=orig_cpu rodata=n
>                                                                         ^^^^^^^^^^
>
> which basically leaves guest kernel's memory RW and it gets caught
> immediately on vm boot by CONFIG_DEBUG_WX.
>
> This pretty much explains why kernel text can get corrupted with a stray
> pointer write or so. So what's the use case for rodata=n?
>
> [    2.478136] Kernel memory protection disabled.
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Ha!

Here is the answer:
https://github.com/google/syzkaller/blob/master/tools/create-gce-image.sh#L189

# rodata=n: mark_rodata_ro becomes very slow with KASAN (lots of PGDs)

I have some vague memory that there was some debug double checking
that pages are indeed read-only and that debug check was slow, but it
was always executed without rodata=n.

> [    2.478689] x86/mm: Checking user space page tables
> [    2.550163] ------------[ cut here ]------------
> [    2.550736] x86/mm: Found insecure W+X mapping at address entry_SYSCALL_64+0x0/0x29
> [    2.551612] WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:246 note_page+0x81f/0x13a0
> [    2.552577] Kernel panic - not syncing: panic_on_warn set ...
> [    2.553240] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc7+ #5
> [    2.553953] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
> [    2.554922] Call Trace:
> [    2.555233]  dump_stack+0x9c/0xcf
> [    2.555633]  panic+0x250/0x5a0
> [    2.556004]  ? __warn_printk+0xf8/0xf8
> [    2.556450]  ? console_trylock+0xb0/0xb0
> [    2.556914]  ? __warn.cold+0x5/0x44
> [    2.557332]  ? note_page+0x81f/0x13a0
> [    2.557768]  __warn.cold+0x20/0x44
> [    2.558176]  ? note_page+0x81f/0x13a0
> [    2.558641]  report_bug+0x168/0x1b0
> [    2.559059]  handle_bug+0x3c/0x60
> [    2.559458]  exc_invalid_op+0x14/0x40
> [    2.559894]  asm_exc_invalid_op+0x12/0x20
> [    2.560368] RIP: 0010:note_page+0x81f/0x13a0
> [    2.560870] Code: 26 00 80 3d 9a d0 7f 02 00 0f 85 82 f9 ff ff e8 47 3c 26 00 4c 89 e6 48 c7 c7 40 aff
> [    2.562951] RSP: 0000:ffff88800e9f7a90 EFLAGS: 00010282
> [    2.563554] RAX: 0000000000000000 RBX: ffff88800e9f7e00 RCX: 0000000000000000
> [    2.564361] RDX: ffff88800e9edb80 RSI: 0000000000000004 RDI: ffffed1001d3ef44
> [    2.565167] RBP: 0000000000000200 R08: 0000000000000001 R09: 0000000000000003
> [    2.565973] R10: ffffed1001d3eefd R11: 0000000000000001 R12: ffffffff96e00000
> [    2.566780] R13: 00000000000001e3 R14: 0000000000000000 R15: ffff88800e9f7e58
> [    2.567587]  ? __kprobes_text_end+0xb3598/0xb3598
> [    2.568122]  ? __entry_text_end+0x1fea85/0x1fea85
> [    2.568754]  ? __entry_text_end+0x1fea85/0x1fea85
> [    2.569288]  ? __entry_text_end+0x1fea85/0x1fea85
> [    2.569821]  ptdump_hole+0x61/0x90
> [    2.570212]  ? ptdump_pte_entry+0x100/0x100
> [    2.570712]  walk_pgd_range+0xdb8/0x15f0
> [    2.571178]  walk_page_range_novma+0xd9/0x140
> [    2.571689]  ? walk_page_range+0x2b0/0x2b0
> [    2.572171]  ? console_unlock+0x58f/0xb10
> [    2.572644]  ptdump_walk_pgd+0xcd/0x180
> [    2.573099]  ptdump_walk_pgd_level_core+0x13c/0x1b0
> [    2.573663]  ? effective_prot+0xb0/0xb0
> [    2.574117]  ? vprintk_emit+0x214/0x380
> [    2.574601]  ? ptdump_walk_pgd_level_core+0x1b0/0x1b0
> [    2.575186]  ? memtype_copy_nth_element+0x1a0/0x1a0
> [    2.575752]  ? __kprobes_text_end+0xb3598/0xb3598
> [    2.576300]  ? pti_user_pagetable_walk_pmd+0x130/0x460
> [    2.576894]  ? __kprobes_text_end+0xb3598/0xb3598
> [    2.577441]  ? __kprobes_text_end+0xb3598/0xb3598
> [    2.577988]  ? __kprobes_text_end+0xb3598/0xb3598
> [    2.578564]  ? rest_init+0xdd/0xdd
> [    2.578972]  ptdump_walk_user_pgd_level_checkwx.cold+0x31/0x36
> [    2.579640]  pti_finalize+0x7b/0x170
> [    2.580066]  kernel_init+0x5b/0x183
> [    2.580484]  ret_from_fork+0x22/0x30
> [    2.581010] Dumping ftrace buffer:
> [    2.581456]    (ftrace buffer empty)
> ffffffffbfffffff)
> [    2.583137] Rebooting in 1 seconds..
> 2020/09/30 17:56:23 failed to create instance: failed to read from qemu: EOF
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
