Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812CA2F6DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbhANWBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbhANWBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:01:53 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF9C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:01:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ce17so1727363pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVv6S5EAOTDagu+nMi70jtjXxb9kx3oijm5M+lP6Ygs=;
        b=Y8Aex8dpCPbwIN1oi9AJv6gyfjMobB8p9rVK5PfKWQiaS3lJfKUMAGG9wxhLHcyhlP
         ViUAFbzg93PhfghW8ML1ZY1bEoWz1Q6kIDFf74gryB7hd88cfSqs+QQRAuYDEf5aE6r/
         MYcGlGPKOT2GlcbSQYfCC1azlGGMoF3XVCwtby0k07noSpLONPEMsk9R9El8J+pamakd
         KYgbW7SQ1C7umr32+yCMbk+6+Xs5y056/CSi8qLkJKPTfr9KVaqb9CDJbhk7AyRbivmc
         gfG5DiVY5pUDpK7vrs5jDoQIURR0Vou1jMZaK7i21WKAeFoYyUZKapHVvoayM1RGdIN0
         O5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVv6S5EAOTDagu+nMi70jtjXxb9kx3oijm5M+lP6Ygs=;
        b=lZ+deNlrGym/JCuHy5ZHvGt45QMfhkexVPo606BNw6+aGUGZC2zhvhgO5Zh6DyutYG
         RcLLiTVCW74nXhe50VVyTf3WK7jK/neNTalh0gpUqmVVFhm0HJFp1b0WlORHI/q09bbK
         isqqGZ+LEaj1fvE/f/qSavlISQzYR5bToQAGdMDwWWDWGj3mhHN+1XcEvH6OLa6n0WG8
         I5HaMIXKr+P8YC4YS3tt3B5zVmteZPQq6VFS0rpfJg0dcw8QoOAka8mS8iwOgbfjzvt3
         wdh3Qdv3q9O1hTsBfdwyXf6LoJKFfOQIAFrgTvgeu/BYfCaWgo/tmP/AgRP2TgmLowLM
         XD+w==
X-Gm-Message-State: AOAM531MJe3erJGr/WKi2dCB7mnEml/dEk3oT0rPXDhIxIn/GPWKHWHY
        WmcmAAXAJmdSIxTUa6OO5+5gjUKGJc6af6DYwBwcRw==
X-Google-Smtp-Source: ABdhPJwiDgILumj5bOb/h9JxM/3DEpVFRYSpm30oA/8lQgT6APPqnkSQ/OhBMKdZo/S12674mOJXGECbQyCCcH4pDFE=
X-Received: by 2002:a17:90a:6ba4:: with SMTP id w33mr7202654pjj.32.1610661672195;
 Thu, 14 Jan 2021 14:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20210114211840.GA5617@linux-8ccs> <20210114215416.993167-1-maskray@google.com>
In-Reply-To: <20210114215416.993167-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jan 2021 14:01:01 -0800
Message-ID: <CAKwvOdnG8VP2n0E5UiM+txxN6SJp-MOMfNqawqtrCi04BettHg@mail.gmail.com>
Subject: Re: [PATCH v2] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
To:     Fangrui Song <maskray@google.com>, Jessica Yu <jeyu@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sam Ravnborg <sam@ravnborg.org>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 1:54 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> clang-12 -fno-pic (since
> https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
> can emit `call __stack_chk_fail@PLT` instead of `call __stack_chk_fail`
> on x86.  The two forms should have identical behaviors on x86-64 but the
> former causes GNU as<2.37 to produce an unreferenced undefined symbol
> _GLOBAL_OFFSET_TABLE_.
>
> (On x86-32, there is an R_386_PC32 vs R_386_PLT32 difference but the
> linker behavior is identical as far as Linux kernel is concerned.)
>
> Simply ignore _GLOBAL_OFFSET_TABLE_ for now, like what
> scripts/mod/modpost.c:ignore_undef_symbol does. This also fixes the
> problem for gcc/clang -fpie and -fpic, which may emit `call foo@PLT` for
> external function calls on x86.
>
> Note: ld -z defs and dynamic loaders do not error for unreferenced
> undefined symbols so the module loader is reading too much.  If we ever
> need to ignore more symbols, the code should be refactored to ignore
> unreferenced symbols.
>
> Reported-by: Marco Elver <elver@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1250
> Signed-off-by: Fangrui Song <maskray@google.com>

Thanks for the patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Jessica, would you mind adding when applying:

Cc: <stable@vger.kernel.org>

as I suspect we might want this fixed in stable tree's branches, too.
It might of interest to add:

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=27178

too.

> ---
>  kernel/module.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> ---
> Changes in v2:
> * Fix Marco's email address
> * Add a function ignore_undef_symbol similar to scripts/mod/modpost.c:ignore_undef_symbol
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 4bf30e4b3eaa..278f5129bde2 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2348,6 +2348,20 @@ static int verify_exported_symbols(struct module *mod)
>         return 0;
>  }
>
> +static int ignore_undef_symbol(Elf_Half emachine, const char *name)
> +{
> +       /* On x86, PIC code and Clang non-PIC code may have call foo@PLT. GNU as
> +        * before 2.37 produces an unreferenced _GLOBAL_OFFSET_TABLE_ on x86-64.
> +        * i386 has a similar problem but may not deserve a fix.
> +        *
> +        * If we ever have to ignore many symbols, consider refactoring the code to
> +        * only warn if referenced by a relocation.
> +        */
> +       if (emachine == EM_386 || emachine == EM_X86_64)
> +               return !strcmp(name, "_GLOBAL_OFFSET_TABLE_");
> +       return 0;
> +}
> +
>  /* Change all symbols so that st_value encodes the pointer directly. */
>  static int simplify_symbols(struct module *mod, const struct load_info *info)
>  {
> @@ -2395,8 +2409,10 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
>                                 break;
>                         }
>
> -                       /* Ok if weak.  */
> -                       if (!ksym && ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
> +                       /* Ok if weak or ignored.  */
> +                       if (!ksym &&
> +                           (ELF_ST_BIND(sym[i].st_info) == STB_WEAK ||
> +                            ignore_undef_symbol(info->hdr->e_machine, name)))
>                                 break;
>
>                         ret = PTR_ERR(ksym) ?: -ENOENT;
> --
-- 
Thanks,
~Nick Desaulniers
