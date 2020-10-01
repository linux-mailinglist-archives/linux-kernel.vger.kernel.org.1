Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AFF2809A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbgJAVuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733191AbgJAVun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:50:43 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B1C21D92
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601589042;
        bh=76o5IWY0IjEXulXQPFJbRhNDDvLFQbEd3W7KfG4VVzQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F/AbhBklTEaoJTrxlE28WYn134NeK+ItLT5KGSjSOWgumyyPk90OtPCXVNwOxDOPF
         IGwJhLToUWHhbPKercPHmh+7VdP/vhFxOP5dN2HxhmjNZhR3pJuHtliCkGZ4jNPjqk
         uiXt0Izcohrli6QHsKe8LEE9m5T+IP5R+3sIf+jE=
Received: by mail-wr1-f43.google.com with SMTP id z1so366522wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:50:41 -0700 (PDT)
X-Gm-Message-State: AOAM531qGGR87BV8cZ9E4DOmbcYCa7AJLFMgB8Ay1tZWO1aVjrV89a/R
        ER9TRddxP48/tQFY10TRCZNkSp/KZKbzc00STMqTpg==
X-Google-Smtp-Source: ABdhPJwz02u+tA81G85f6eUcbq3fJ/XxlDI2vCgAc1BLqJbu1PPjTrJSIZlFAS9dQr64CgMfW5bdcqm4f4MZL0XuKYc=
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr11023133wrb.70.1601589040533;
 Thu, 01 Oct 2020 14:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201001205819.27879-1-krisman@collabora.com> <20201001205819.27879-7-krisman@collabora.com>
In-Reply-To: <20201001205819.27879-7-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 1 Oct 2020 14:50:29 -0700
X-Gmail-Original-Message-ID: <CALCETrW4FivPZg5W8MrrJznsX4O-WNhHCHm-PkskGD0LvxxTvQ@mail.gmail.com>
Message-ID: <CALCETrW4FivPZg5W8MrrJznsX4O-WNhHCHm-PkskGD0LvxxTvQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] x86: elf: Use e_machine to select
 setup_additional_pages for x32
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
> Since TIF_X32 is going away, avoid using it to find the ELF type when
> choosing which additional pages to set up.
>
> According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
> have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
> differentiate a x32 object from a IA32 object when executing
> start_thread in compat mode.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  arch/x86/entry/vdso/vma.c  | 21 ++++++++++++---------
>  arch/x86/include/asm/elf.h | 11 ++++++++---
>  2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 9185cb1d13b9..7a3cda8294a3 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -412,22 +412,25 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  }
>
>  #ifdef CONFIG_COMPAT
> -int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
> -                                      int uses_interp)
> +int compat_arch_setup_additional_pages_ia32(struct linux_binprm *bprm,
> +                                           int uses_interp)
>  {
> -#ifdef CONFIG_X86_X32_ABI
> -       if (test_thread_flag(TIF_X32)) {
> -               if (!vdso64_enabled)
> -                       return 0;
> -               return map_vdso_randomized(&vdso_image_x32);
> -       }
> -#endif
>  #ifdef CONFIG_IA32_EMULATION
>         return load_vdso32();
>  #else
>         return 0;
>  #endif
>  }
> +
> +int compat_arch_setup_additional_pages_x32(struct linux_binprm *bprm,
> +                                          int uses_interp)
> +{
> +#ifdef CONFIG_X86_X32_ABI
> +       if (vdso64_enabled)
> +               return map_vdso_randomized(&vdso_image_x32);
> +#endif
> +       return 0;
> +}
>  #endif
>  #else
>  int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 33c1c9be2e07..4d91f5b1079f 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -388,9 +388,14 @@ struct linux_binprm;
>  #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
>  extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>                                        int uses_interp);
> -extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
> -                                             int uses_interp);
> -#define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
> +extern int compat_arch_setup_additional_pages_ia32(struct linux_binprm *bprm,
> +                                                  int uses_interp);
> +extern int compat_arch_setup_additional_pages_x32(struct linux_binprm *bprm,
> +                                                 int uses_interp);
> +
> +#define compat_arch_setup_additional_pages                             \
> +       ((elf_ex->e_machine == EM_X86_64) ?                             \
> +        compat_arch_setup_additional_pages_x32 : compat_arch_setup_additional_pages_ia32)
>

As in the previous patch, can you wire up the new argument for real, please?
