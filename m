Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC89292DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgJSSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730857AbgJSSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:54:36 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E2FC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:54:35 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z2so1288935ilh.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2jWFfexdEDtBs2gfOXBbLGLdiOa+LTYwZ8t0Hf50aI=;
        b=JlQ9cG/yAPjE1oRino9Ot4VwHkBF+HDA8uJqkjp+tCCfIbq1LZBxFO3nmlTgDGiRgc
         O6lMduG3Rjn04ohMMV4Iaycqd4TlujJhVdHrZZYwQLkvi+lZzqsXGmty+VqzwaLg9n4J
         lYUwJZjZE4DAT71qHcQ85586gf8egO1rwVWCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2jWFfexdEDtBs2gfOXBbLGLdiOa+LTYwZ8t0Hf50aI=;
        b=r+Bx/RMiEMtaNxvpBASTvOysvNdQAZmX7tde339HO/2KgLdQNdZYczv35QPDPsVU0w
         RaTnT1QRsU/jJtqwuWu+Avvi/DPv7HHy5fSB3yOxVsTIcE+P/qFIT21Y7ObqckcjOQH4
         F7QPCKHg4YDXvvQvg4fcVR7bG1+BgQbowiSFIl3vWgRsG2rELhl+kGuudUqFnltYI3FJ
         EYreGEd9wPaY61ZMq+YqWS17Du00NSbBGcFjwjrc8KKnvo5WgDMCJvqjp1AWEqAhErBL
         VE3O3nM8uAJDvd/WXX7K63MaQuiuRmbDnPnPCOZz33S7mkOMYVv3R+3TF/GMBWWhmRhV
         /uBg==
X-Gm-Message-State: AOAM532lhy4oxuOjkYkmeybwn9dAhgO3PI20KZ1Z2kwLrLvDmz16iolz
        f8BHYt6Gc9dJodRCvBrwuZ5AAj8m9mmtNl63qa1f
X-Google-Smtp-Source: ABdhPJyb4PiVcwv1NkNj9aDJ/FpCHM6dnsTKUq/tHGd1tg2kp/35Pn9JvsV5zP5l+EX8LkrfBx7zhVJp6sbJMpGmIv8=
X-Received: by 2002:a92:1801:: with SMTP id 1mr793536ily.219.1603133674949;
 Mon, 19 Oct 2020 11:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <1602918377-23573-1-git-send-email-guoren@kernel.org> <1602918377-23573-10-git-send-email-guoren@kernel.org>
In-Reply-To: <1602918377-23573-10-git-send-email-guoren@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 19 Oct 2020 11:54:24 -0700
Message-ID: <CAOnJCU+oTRcJ2p8WQDX5P-EsOHmkn3kP9s54VQa+iw2wXDvzkg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] riscv: Fixup lockdep_assert_held(&text_mutex) in patch_insn_write
To:     Guo Ren <guoren@kernel.org>, Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, mhiramat@kernel.org,
        Alan Kao <alankao@andestech.com>, rostedt@goodmis.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 12:07 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> It will cause warning messages:
> echo function_graph > /sys/kernel/debug/tracing/current_tracer
> [   47.691397] ------------[ cut here ]------------
> [   47.692899] WARNING: CPU: 0 PID: 11 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x182/0x19a
> [   47.694483] Modules linked in:
> [   47.695754] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.9.0-11367-g1054335 #132
> [   47.698228] epc: ffffffe000204530 ra : ffffffe00020452c sp : ffffffe0023ffc20 gp : ffffffe0013e1fe0 tp : ffffffe0023e4e00 t0 : 0000000000000000
> [   47.701872]  t1 : 000000000000000e t2 : 000000000000001b s0 : ffffffe0023ffc70 s1 : ffffffe000206850 a0 : 0000000000000000 a1 : ffffffffffffffff
> [   47.705550]  a2 : 0000000000000000 a3 : ffffffe03af7c5e8 a4 : 0000000000000000 a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000000150b02d8
> [   47.709159]  s2 : 0000000000000008 s3 : 0000000000000858 s4 : ffffffe0023ffc98 s5 : 0000000000000850 s6 : 0000000000000003 s7 : 0000000000000002
> [   47.714135]  s8 : 0000000000000004 s9 : 0000000000000001 s10: 0000000000000001 s11: 0000000000000003 t3 : ffffffffffffe000 t4 : 0000000000d86254
> [   47.716574]  t5 : 0000000000000005 t6 : 0000000000040000status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
> [   47.720019] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.9.0-11367-g1054335 #132
> [   47.722074] Call Trace:
> [   47.722561] [<ffffffe000203c88>] walk_stackframe+0x0/0xc2
> [   47.724608] [<ffffffe000b2020a>] show_stack+0x46/0x52
> [   47.726246] [<ffffffe000b23c24>] dump_stack+0x90/0xb6
> [   47.727672] [<ffffffe00020c9c4>] __warn+0x98/0xfa
> [   47.729131] [<ffffffe0005f4be0>] report_bug+0xaa/0x11e
> [   47.730624] [<ffffffe000203b74>] do_trap_break+0x96/0xfe
> [   47.732448] [<ffffffe000201daa>] ret_from_exception+0x0/0x14
> [   47.734341] [<ffffffe00020452c>] patch_insn_write+0x17e/0x19a
> [   47.737235] irq event stamp: 39
> [   47.738521] hardirqs last  enabled at (39): [<ffffffe000201d0a>] _save_context+0xa2/0xe6
> [   47.741055] hardirqs last disabled at (38): [<ffffffe0002c2404>] multi_cpu_stop+0x130/0x166
> [   47.743551] softirqs last  enabled at (0): [<ffffffe00020a4d2>] copy_process+0x430/0x1316
> [   47.746031] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   47.748617] ---[ end trace 88a1054faa6524ef ]---
>
> Because the path of stop_machine(__ftrace_modify_code)->
> ftrace_modify_all_code->...->patch_insn_write has no pair of
> lock&unlock text_mutex, so we shouldn't put assert here.
>

What platform are you testing ? We are seeing a crash while enabling
any of the tracers multiple times
on Qemu/HiFive Unleashed.

http://lists.infradead.org/pipermail/linux-riscv/2020-October/002354.html

As per the thread, Zong agreed to take a look into that.
@Zong Li : Do you have any update regarding the ftrace issue.

> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/kernel/patch.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 0b55287..2ee5063 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -55,13 +55,6 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
>         bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
>         int ret;
>
> -       /*
> -        * Before reaching here, it was expected to lock the text_mutex
> -        * already, so we don't need to give another lock here and could
> -        * ensure that it was safe between each cores.
> -        */
> -       lockdep_assert_held(&text_mutex);
> -
>         if (across_pages)
>                 patch_map(addr + len, FIX_TEXT_POKE1);
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
