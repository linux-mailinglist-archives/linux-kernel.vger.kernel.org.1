Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD74D2E00D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgLUTPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgLUTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:15:31 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0AC061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:14:51 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s21so6965091pfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzo/MfTCuEzeZ+aBdIfqWlbxinkOGPQuFxT7Er5XPmM=;
        b=RnJD9TXQTqvGFRecAZlM8BhpacAzQupBr8AeYz+u4bqjVtDZ4Dc5DrMVVqJUprFxf1
         yZYzWXXDqmz0VyYkUtyTlz+a7yvO/bJn8VyzPG2DNbp+4+FeyjGU6REmkgX5MM3nuN1R
         ek5NH6LKin3YU90A7lTj2wR3AHSEOWzbHMmNdp5DD+qKbXQFU4o4lpTnAuXSXwUjFmA0
         zx/DI5ZbEatfqiRfgfaNNUAEVuMHSKA3yrLdXyNoyBrPuwo8T7rpIQ4Vc4FeRtG/lXkf
         dU2452lzeb4J/uAA1JyYAbjobZBrEU1BcKYWd1W6bNWQa7ar5HmOmv3HAfU7a+WIisxI
         HHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzo/MfTCuEzeZ+aBdIfqWlbxinkOGPQuFxT7Er5XPmM=;
        b=frpfz8S3M/lMReQdBPA2jYQ65dHaLNsvBaTGqcgMpzG7HSU8oJD/4eYWuE1OYUn/n/
         WK8y/5+/PfDtg2ugi3YD97GeKSfvtdJWqVQxUpRV1Ei5UZODiCs0yaGlo2rhpSOtkp46
         ODla3hyxcGigmpKlRUvy7jJzUvOzu9I0eTStSaTCOQ14BhD6vujliGLoTaLY2yxkpfUP
         1hGyeDHbCoS5uwTFMDebIHhgRMguoovD3HhC1/c13wxswG1J9JTbwlBiH7o35OZKfypz
         mmVskc7K2N2CNylTDrNnxW/+L/YY4wfdkBsRM7m3wTxlac58YilbIAPEyNbJLvbnp/dH
         92JA==
X-Gm-Message-State: AOAM533i6jDZRdIQs42z8T3FM8iN5haQAJmrggQp4IC7JSHYAxTLNx5f
        ZzidsD0wJhM7vWS9D0AvDHlNkVck64NhK8J7T+XIjw==
X-Google-Smtp-Source: ABdhPJzeOkM2j27bztsXZZg81HYxLkLq0cOoCfFGphKJXQGiLfqjgZn34TikMUUM5xN1yaqahsfH5Gq+hje8lkzQrJE=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr16700013pfy.15.1608578090769; Mon, 21
 Dec 2020 11:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20200903023056.3914690-1-nivedita@alum.mit.edu>
In-Reply-To: <20200903023056.3914690-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Dec 2020 11:14:39 -0800
Message-ID: <CAKwvOdm8qUpueOdO7e-rQotO5UynrgU2TZ9DEe=O4f9eU5EY0g@mail.gmail.com>
Subject: Re: [PATCH] x86/cmdline: Disable jump tables for cmdline.c
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 7:31 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> When CONFIG_RETPOLINE is disabled, Clang uses a jump table for the
> switch statement in cmdline_find_option (jump tables are disabled when
> CONFIG_RETPOLINE is enabled). This function is called very early in boot
> from sme_enable() if CONFIG_AMD_MEM_ENCRYPT is enabled. At this time,

Hi Arvind, sorry I missed this when you first sent it.  I'm going
through and mass deleting my inbox (email bankruptcy) but noticed
this.  I couldn't reproduce jump tables in cmdline_find_option with
CONFIG_RETPOLINE disabled but CONFIG_AMD_MEM_ENCRYPT on today's
linux-next. Can you please confirm that this is still an issue? I will
reread the disassembly, but it looks like a bunch of cmp/test+jumps.

> the kernel is still executing out of the identity mapping, but the jump
> table will contain virtual addresses.
>
> Fix this by disabling jump tables for cmdline.c when AMD_MEM_ENCRYPT is
> enabled.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index d46fff11f06f..aa067859a70b 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -24,7 +24,7 @@ ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_cmdline.o = -pg
>  endif
>
> -CFLAGS_cmdline.o := -fno-stack-protector
> +CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
>  endif
>
>  inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200903023056.3914690-1-nivedita%40alum.mit.edu.



-- 
Thanks,
~Nick Desaulniers
