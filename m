Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F22867C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgJGSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJGSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:53:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63585C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:53:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 67so3514075iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KO+y56HHfRTV4+PXqtIIHy8g7bN2Nwji1Pf2rJWSLag=;
        b=TFWyYwTG2ftpwcDpT3thFrPNd4YAfiL7KKwnFvVpUScgwpFr0U4+pgptwNqGLNqeb2
         qhD+yHUpmO++xypu2uNSTIkizdBRwOu/53UqrajQXqlx2GMOjaWzFrEmCDK1dkmJbKnD
         M5wT3UVCZan8ECu9cMsA7ZwVbrGsFaQTczyhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KO+y56HHfRTV4+PXqtIIHy8g7bN2Nwji1Pf2rJWSLag=;
        b=BugIRZ6euGqPA0a2L9wBA8FIwXbwsE5AM9SqFhNpKOHimsandiTeWo0Rq+k4Wr5SFN
         Pe9cDFhCS8xFc9zHn0vlZ8NOsiVBXmvpcL3dU9SpoXrDujj9cBG00N83Av/OIDlL8qrD
         r/zz0WwAOuKbjqhQ8C+j8Wysx6B+MvVvpek1t/liU61Do1bz5lDFafX3atiDniaS2ZSk
         NtdyqKcGWi7sRCSQCTa9H9cL6iPiSMJ4ce9FhY6sRElto8yg2jbXjQUAdcROEbsMvnY6
         ARa5XS+STqEFtdxhuCvxrYol6VJQyTQtxPWbivLHmLeRImWpuNaQ7ONmeft1UhCtghq/
         v4EQ==
X-Gm-Message-State: AOAM5302VrVHOXkL90WwmE6+18k0VD+okssJnMXGUIWEjU4inZ9XAlCj
        zz95PoQcpVZPnxWcN26J+GvysolLn95vP+GvNKkG
X-Google-Smtp-Source: ABdhPJy3N9QPqRCm7vLTFezp9RQysmNIo7Crh7+Nm/22ezXbo2bA99nLfCG8eETLCtYOvNYzMeS4MwgaKVOOJ9Nf+DE=
X-Received: by 2002:a05:6602:18a:: with SMTP id m10mr3309246ioo.174.1602096789625;
 Wed, 07 Oct 2020 11:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <1602083313-19239-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1602083313-19239-1-git-send-email-guoren@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 7 Oct 2020 11:52:58 -0700
Message-ID: <CAOnJCUK03L_n51N8CwekAa4QuVtUr75Cv6zfLabZCCgr0Jdgyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "riscv: Fixup static_obj() fail"
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, aurelien@aurel32.net,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 8:09 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This reverts commit 6184358da0004c8fd940afda6c0a0fa4027dc911.
>
> It will cause bootup failure with HARDENED_USERCOPY.
>
> As Aurelien has reported:
>
> [    3.484586] AppArmor: AppArmor sha1 policy hashing enabled
> [    4.749835] Freeing unused kernel memory: 492K
> [    4.752017] Run /init as init process
> [    4.753571] usercopy: Kernel memory overwrite attempt detected to kernel text (offset 507879, size 11)!
> [    4.754838] ------------[ cut here ]------------
> [    4.755651] kernel BUG at mm/usercopy.c:99!
> [    4.756445] Kernel BUG [#1]
> [    4.756815] Modules linked in:
> [    4.757542] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.8.0-1-riscv64 #1 Debian 5.8.7-1
> [    4.758372] epc: ffffffe0003b5120 ra : ffffffe0003b5120 sp : ffffffe07f783ca0
> [    4.758960]  gp : ffffffe000cc7230 tp : ffffffe07f77cec0 t0 : ffffffe000cdafc0
> [    4.759772]  t1 : 0000000000000064 t2 : 0000000000000000 s0 : ffffffe07f783cf0
> [    4.760534]  s1 : ffffffe00095d780 a0 : 000000000000005b a1 : 0000000000000020
> [    4.761309]  a2 : 0000000000000005 a3 : 0000000000000000 a4 : ffffffe000c1f340
> [    4.761848]  a5 : ffffffe000c1f340 a6 : 0000000000000000 a7 : 0000000000000087
> [    4.762684]  s2 : ffffffe000941848 s3 : 000000000007bfe7 s4 : 000000000000000b
> [    4.763500]  s5 : 0000000000000000 s6 : ffffffe00091cc00 s7 : fffffffffffff000
> [    4.764376]  s8 : 0000003ffffff000 s9 : ffffffe0769f3200 s10: 000000000000000b
> [    4.765208]  s11: ffffffe07d548c40 t3 : 0000000000000000 t4 : 000000000001dcd0
> [    4.766059]  t5 : ffffffe000cc8510 t6 : ffffffe000cd64aa
> [    4.766712] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
> [    4.768308] ---[ end trace 1f8e733e834d4c3e ]---
> [    4.769129] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    4.770070] SMP: stopping secondary CPUs
> [    4.771110] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  arch/riscv/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index f3586e3..e6f8016 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -22,7 +22,6 @@ SECTIONS
>         /* Beginning of code and text segment */
>         . = LOAD_OFFSET;
>         _start = .;
> -       _stext = .;
>         HEAD_TEXT_SECTION
>         . = ALIGN(PAGE_SIZE);
>
> @@ -55,6 +54,7 @@ SECTIONS
>         . = ALIGN(SECTION_ALIGN);
>         .text : {
>                 _text = .;
> +               _stext = .;
>                 TEXT_TEXT
>                 SCHED_TEXT
>                 CPUIDLE_TEXT
> --
> 2.7.4
>

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
