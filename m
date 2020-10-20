Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661E02939AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 13:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392674AbgJTLSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 07:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391207AbgJTLSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:18:16 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C758322404;
        Tue, 20 Oct 2020 11:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603192695;
        bh=2qnYnLk0zJvDuNzY1+fnwuJKS+83hTZg+127pZd/L48=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fvaDeVXK8LzzgZcqRwloQEBDUr1ntce3eaLBO60GaANnX4ya6mAXxQq5BL/h3dXls
         NBrLZnQB1pZx+2dia75dMLVezlxHhAGpbxzWmTqMpUBeuRmTwHs+0lX1yJxfgsGpFD
         FHg8mpftGtGTmJkT34NzFv3G6zlZJfFMUlRC5EFY=
Received: by mail-lf1-f41.google.com with SMTP id l2so1638395lfk.0;
        Tue, 20 Oct 2020 04:18:14 -0700 (PDT)
X-Gm-Message-State: AOAM531TlydtS5iJrdYN7pAvucRot5T07niR2IWNXN6psqQ+hTsAofqg
        m1TFrpgS8cGK6BGrNW1PjmCtHCtLKWDg8WuoKkw=
X-Google-Smtp-Source: ABdhPJwW+vXwK7G03grNqoHw6wozDHXTLytfvm0cndSoeB4M6pAipr9ERbQd/e29GdM/7EUpUPiasGURODvQoKDRrlc=
X-Received: by 2002:a19:6b10:: with SMTP id d16mr716908lfa.121.1603192692785;
 Tue, 20 Oct 2020 04:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <1602918377-23573-1-git-send-email-guoren@kernel.org>
 <1602918377-23573-10-git-send-email-guoren@kernel.org> <CAOnJCU+oTRcJ2p8WQDX5P-EsOHmkn3kP9s54VQa+iw2wXDvzkg@mail.gmail.com>
In-Reply-To: <CAOnJCU+oTRcJ2p8WQDX5P-EsOHmkn3kP9s54VQa+iw2wXDvzkg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 20 Oct 2020 19:18:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSU+M+b+bn5zH_EyE7Ksh=5+ZkO8LkAn=Tm-p45CgYW1w@mail.gmail.com>
Message-ID: <CAJF2gTSU+M+b+bn5zH_EyE7Ksh=5+ZkO8LkAn=Tm-p45CgYW1w@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] riscv: Fixup lockdep_assert_held(&text_mutex) in patch_insn_write
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 2:54 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Sat, Oct 17, 2020 at 12:07 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > It will cause warning messages:
> > echo function_graph > /sys/kernel/debug/tracing/current_tracer
> > [   47.691397] ------------[ cut here ]------------
> > [   47.692899] WARNING: CPU: 0 PID: 11 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x182/0x19a
> > [   47.694483] Modules linked in:
> > [   47.695754] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.9.0-11367-g1054335 #132
> > [   47.698228] epc: ffffffe000204530 ra : ffffffe00020452c sp : ffffffe0023ffc20 gp : ffffffe0013e1fe0 tp : ffffffe0023e4e00 t0 : 0000000000000000
> > [   47.701872]  t1 : 000000000000000e t2 : 000000000000001b s0 : ffffffe0023ffc70 s1 : ffffffe000206850 a0 : 0000000000000000 a1 : ffffffffffffffff
> > [   47.705550]  a2 : 0000000000000000 a3 : ffffffe03af7c5e8 a4 : 0000000000000000 a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000000150b02d8
> > [   47.709159]  s2 : 0000000000000008 s3 : 0000000000000858 s4 : ffffffe0023ffc98 s5 : 0000000000000850 s6 : 0000000000000003 s7 : 0000000000000002
> > [   47.714135]  s8 : 0000000000000004 s9 : 0000000000000001 s10: 0000000000000001 s11: 0000000000000003 t3 : ffffffffffffe000 t4 : 0000000000d86254
> > [   47.716574]  t5 : 0000000000000005 t6 : 0000000000040000status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
> > [   47.720019] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.9.0-11367-g1054335 #132
> > [   47.722074] Call Trace:
> > [   47.722561] [<ffffffe000203c88>] walk_stackframe+0x0/0xc2
> > [   47.724608] [<ffffffe000b2020a>] show_stack+0x46/0x52
> > [   47.726246] [<ffffffe000b23c24>] dump_stack+0x90/0xb6
> > [   47.727672] [<ffffffe00020c9c4>] __warn+0x98/0xfa
> > [   47.729131] [<ffffffe0005f4be0>] report_bug+0xaa/0x11e
> > [   47.730624] [<ffffffe000203b74>] do_trap_break+0x96/0xfe
> > [   47.732448] [<ffffffe000201daa>] ret_from_exception+0x0/0x14
> > [   47.734341] [<ffffffe00020452c>] patch_insn_write+0x17e/0x19a
> > [   47.737235] irq event stamp: 39
> > [   47.738521] hardirqs last  enabled at (39): [<ffffffe000201d0a>] _save_context+0xa2/0xe6
> > [   47.741055] hardirqs last disabled at (38): [<ffffffe0002c2404>] multi_cpu_stop+0x130/0x166
> > [   47.743551] softirqs last  enabled at (0): [<ffffffe00020a4d2>] copy_process+0x430/0x1316
> > [   47.746031] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [   47.748617] ---[ end trace 88a1054faa6524ef ]---
> >
> > Because the path of stop_machine(__ftrace_modify_code)->
> > ftrace_modify_all_code->...->patch_insn_write has no pair of
> > lock&unlock text_mutex, so we shouldn't put assert here.
> >
>
> What platform are you testing ? We are seeing a crash while enabling
> any of the tracers multiple times
> on Qemu/HiFive Unleashed.
I use qemu for testing. I've changed dynamic ftrace mechanism from
mcount to -fpatchable-entry.

The problem is made by the lockdep checking of text_mutex.

>
> http://lists.infradead.org/pipermail/linux-riscv/2020-October/002354.html
>
> As per the thread, Zong agreed to take a look into that.
> @Zong Li : Do you have any update regarding the ftrace issue.
>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  arch/riscv/kernel/patch.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 0b55287..2ee5063 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -55,13 +55,6 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
> >         bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> >         int ret;
> >
> > -       /*
> > -        * Before reaching here, it was expected to lock the text_mutex
> > -        * already, so we don't need to give another lock here and could
> > -        * ensure that it was safe between each cores.
> > -        */
> > -       lockdep_assert_held(&text_mutex);
> > -
> >         if (across_pages)
> >                 patch_map(addr + len, FIX_TEXT_POKE1);
> >
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
