Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3462809A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbgJAVtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJAVtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:49:42 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D1A2177B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 21:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601588982;
        bh=6/33owwRi5A7FNKzkkiUdJvvFMmIQNDCM+CvjlAcElY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BS+VwNksm+Izlsdnlf3ZUdWncUhsTErPQl10AGJ8FSyBAkLgqr6N1uAypC7PYP+f0
         7d4VVLUHZ4gEfuc5g7ccLgjBM4Xk9jwBToFZOLN5cNI7B4PGRCczrNiHdlj6V8s1z8
         gW6Y5OZWuEfob38snFMoaGjY1/08DnKhHPRj30iU=
Received: by mail-wr1-f52.google.com with SMTP id j2so340700wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:49:41 -0700 (PDT)
X-Gm-Message-State: AOAM5322M7d5N3ZU+YX8LcdvhB3v6lASemihrzWAQPLrPN3sz3ZhAq21
        JEwuTH05J8kZA3EOpWrRmi+kGp5GnDS5M78q/zReRA==
X-Google-Smtp-Source: ABdhPJy08zx7EFM9Zzjkij4vwZV7ukFXxeyn8MyPYxiVmJlaKl3n7NLOG2W/8E07JIknS49kmlp3xkwLg2/1M3bRJpg=
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr11100849wrn.257.1601588980460;
 Thu, 01 Oct 2020 14:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201001205819.27879-1-krisman@collabora.com> <20201001205819.27879-6-krisman@collabora.com>
In-Reply-To: <20201001205819.27879-6-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 1 Oct 2020 14:49:28 -0700
X-Gmail-Original-Message-ID: <CALCETrWJFUahjX09Z-6zzmmX_EfTQa2L=DhOYdcR36gViWZmdw@mail.gmail.com>
Message-ID: <CALCETrWJFUahjX09Z-6zzmmX_EfTQa2L=DhOYdcR36gViWZmdw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] x86: elf: Use e_machine to select start_thread for x32
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:59 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Since TIF_X32 is going away, avoid using it to find the ELF type on
> compat_start_thread
>
> According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
> have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
> differentiate a x32 object from a IA32 object when executing
> start_thread in compat mode.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  arch/x86/include/asm/elf.h   | 11 +++++++++--
>  arch/x86/kernel/process_64.c | 11 +++++++----
>  2 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 9220efc65d78..33c1c9be2e07 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -186,8 +186,15 @@ static inline void elf_common_init(struct thread_struct *t,
>  #define        COMPAT_ELF_PLAT_INIT(regs, load_addr)           \
>         elf_common_init(&current->thread, regs, __USER_DS)
>
> -void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp);
> -#define compat_start_thread compat_start_thread
> +void compat_start_thread_ia32(struct pt_regs *regs, u32 new_ip, u32 new_sp);
> +void compat_start_thread_x32(struct pt_regs *regs, u32 new_ip, u32 new_sp);
> +#define compat_start_thread(regs, new_ip, new_sp)                      \
> +do {                                                                   \
> +       if (elf_ex->e_machine == EM_X86_64)                             \
> +               compat_start_thread_x32(regs, new_ip, new_sp);          \
> +       else                                                            \
> +               compat_start_thread_ia32(regs, new_ip, new_sp);         \
> +} while (0)

This is evil -- it looks like a real function, but it's not.  Can you
instead add a const struct elf32_hdr *elf_ex parameter to all the
compat_start_thread implementations?  There appear to be only four of
them in the whole kernel.  For patches like this, it should be fine to
do it all as one patch as long as you Cc all the arch maintainers.

--Andy
