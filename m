Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E562F737F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbhAOHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOHEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:04:43 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61968C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:04:03 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id b24so7705911otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZuzVr+TgXPqb7ivDtim3E40dPuUOJv5AgOFr5mOA50=;
        b=dd0tjJF73TWEftnKndgklHUfD2jKKb//MFrpjyBgGFXyjxIbMFf/dTVyDuLXDarPQm
         NlPlhZFkX8ijBW1NxdfE7oOI27GQPlUDFfy4oQ/kOlh2PgAK3T012gccnE9o+lJ/+UR7
         U2LDMlzNDM0dgAdZHV7Gi0VHwVy1PMnNDSWFNlPZV1vQf3qa5YE6RAouFR2WztIR4If4
         0L7qAc60fCg32yrihP1EzVkLGCm8YFsKCht5CTYeAIBhbSivUoQB6/+Dc4qeQpKDS7BY
         KiUkHKDl4WFKyehJW6VuHO2BnjoxFKUrkHQm5JgnEMAizv5EnZCjNQ1ypNNStrpPWrNQ
         ofSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZuzVr+TgXPqb7ivDtim3E40dPuUOJv5AgOFr5mOA50=;
        b=cVilAzPvhbwA5j8B8OzsneYyopRcTXLUaAjs/WEVfuP3dyvMtiiTlCct/mwH31vabR
         H8U3tqV1g8w7R/tOamZPEVmG1z6Ycz4DNknKMR5KHVYyy+TVmyzfBiAbbmkC15aeeINC
         szEGUNjSCgNMuiHcuxafS+Oe3Qcx92nVlHT1el3XRHQESF/VNPu24CKtBs/KkKrU32tw
         JOcscGPUVI5kPsdEFT8NahEXWsFssNu6rt4mBXQ7vR9eosA9pqrr4tS1XZ3GcQzoU/d9
         wAFYKn8NwIghdza1IsSVPSc2XgPWoizhXuLyCGNkK7QCASWZkSqozjaYKFkgjI+sWGRG
         PblQ==
X-Gm-Message-State: AOAM531b/2QWgkpYywMjh8VjR6qIuuzcIazBrJNL+gO+jlVCaOWMaz9B
        vlAiAMoOfSfWRLoMF+a+aGF0SEfbr1D0J4TjejZasQ==
X-Google-Smtp-Source: ABdhPJyZVuwU+rk7VghzOedHHAoEnLPn+FmDE3Zz6fzgVoDG5hqFT6Mp1fWckxdU8hMvhERDzVXw1EUlvGilKeWPG48=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr7591335ots.251.1610694242544;
 Thu, 14 Jan 2021 23:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20210114211840.GA5617@linux-8ccs> <20210114215416.993167-1-maskray@google.com>
In-Reply-To: <20210114215416.993167-1-maskray@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 15 Jan 2021 08:03:51 +0100
Message-ID: <CANpmjNOrD76O2_Zpwo5RJ2d12gczuQpG9bJkXYLY_sOVeEVZGQ@mail.gmail.com>
Subject: Re: [PATCH v2] module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for
 undefined symbols
To:     Fangrui Song <maskray@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 at 22:54, Fangrui Song <maskray@google.com> wrote:
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

Tested-by: Marco Elver <elver@google.com>

Thank you for the patch!

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

Why not 'bool' return-type?

> +{
> +       /* On x86, PIC code and Clang non-PIC code may have call foo@PLT. GNU as

Not sure if checkpatch.pl warns about this, but this multi-line
comment does not follow the normal kernel-style (see elsewhere in
file):

/*
 * ...
 */

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
> 2.30.0.296.g2bfb1c46d8-goog
>
