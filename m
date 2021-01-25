Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F170B302549
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbhAYNFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbhAYMzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:55:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5481822472
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611579271;
        bh=muSdZbYe25/mIWxglQ/tueMmO9cwu6bS4BAm065GnLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZchZkQgynlL6P/EY8YRj09modp2VBrpgsrFzLd3ov0p4cpzGukybBn6FivW4ei2Ta
         NcG01pn5xSvVQOqFYb3H3ybX9h2gREPwJ8CQPVNSaZjvFPZgNsi1dtnUoFzBqjKUkz
         UN2WnM9fFepDn9ko2WJFTGanAShD4b3tmOpVJFaUdaOxerKzD2i+D8WAA8M1XhofUx
         Xfd63DF2feOgk3Xpm7H4uezyJw9q8GehOZrmpGVLvpfLTSt6aD69JWg0WGvp1cur0x
         hE6/t6+UN0smNU2ZQYFdPAspqjt98dm9iZSrxEgGQjDGpVrHgIdNYf/FxQTE0DskEw
         uq5ZROx6O03gA==
Received: by mail-ot1-f50.google.com with SMTP id s2so10408027otp.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 04:54:31 -0800 (PST)
X-Gm-Message-State: AOAM530qSDOPcv6jNdOmSMzK/ZQdyDuCpB7nnDGltvvzQ30Qokwr7J6P
        3UqXBOXnIhWY7Zf38OaNWf7cNvXMvVab1FDUgMo=
X-Google-Smtp-Source: ABdhPJy0+Sexz3eSn1pKLYFl+rMqxBENFaHIhcZ3Q200omN0MIgI68Y6qEI57j2QSYMGdUsw7nhr3W2vlvGRhFGVNcI=
X-Received: by 2002:a05:6830:1e2a:: with SMTP id t10mr353989otr.90.1611579270609;
 Mon, 25 Jan 2021 04:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20210125105019.2946057-1-maz@kernel.org> <20210125105019.2946057-19-maz@kernel.org>
In-Reply-To: <20210125105019.2946057-19-maz@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 25 Jan 2021 13:54:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFcc+0At5+9Keo1MF=TeGE9-eOHtSpK7yVy5jzwXt6KCA@mail.gmail.com>
Message-ID: <CAMj1kXFcc+0At5+9Keo1MF=TeGE9-eOHtSpK7yVy5jzwXt6KCA@mail.gmail.com>
Subject: Re: [PATCH v5 18/21] arm64: Move "nokaslr" over to the early
 cpufeature infrastructure
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 11:53, Marc Zyngier <maz@kernel.org> wrote:
>
> Given that the early cpufeature infrastructure has borrowed quite
> a lot of code from the kaslr implementation, let's reimplement
> the matching of the "nokaslr" option with it.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kernel/idreg-override.c | 15 +++++++++++++
>  arch/arm64/kernel/kaslr.c          | 36 ++----------------------------
>  2 files changed, 17 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index cbb8eaa48742..3ccf51b84ba4 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -31,8 +31,22 @@ static const struct ftr_set_desc mmfr1 __initdata = {
>         },
>  };
>
> +extern struct arm64_ftr_override kaslr_feature_override;
> +
> +static const struct ftr_set_desc kaslr __initdata = {

This should be __initconst not __initdata (below too)

> +       .name           = "kaslr",
> +#ifdef CONFIG_RANDOMIZE_BASE
> +       .override       = &kaslr_feature_override,
> +#endif
> +       .fields         = {
> +               { "disabled", 0 },
> +               {}
> +       },
> +};
> +
>  static const struct ftr_set_desc * const regs[] __initdata = {
>         &mmfr1,
> +       &kaslr,
>  };
>
>  static const struct {
> @@ -41,6 +55,7 @@ static const struct {
>  } aliases[] __initdata = {
>         { "kvm-arm.mode=nvhe",          "id_aa64mmfr1.vh=0" },
>         { "kvm-arm.mode=protected",     "id_aa64mmfr1.vh=0" },
> +       { "nokaslr",                    "kaslr.disabled=1" },
>  };
>

This struct now takes up
- ~100 bytes for the characters themselves (which btw are not emitted
into __initdata or __initconst)
- 6x8 bytes for the char pointers
- 6x24 bytes for the RELA relocations that annotate these pointers as
quantities that need to be relocated at boot (on a kernel built with
KASLR)

I know it's only a drop in the ocean, but in this case, where the
struct is statically declared and defined only once, and in the same
place, we could easily turn this into

static const struct {
   char alias[24];
   char param[20];
};

and get rid of all the overhead. The only slightly annoying thing is
that the array sizes need to be kept in sync with the largest instance
appearing in the array, but this is easy when the struct type is
declared in the same place where its only instance is defined.


>  static char *cmdline_contains_option(const char *cmdline, const char *option)
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 5fc86e7d01a1..27f8939deb1b 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -51,39 +51,7 @@ static __init u64 get_kaslr_seed(void *fdt)
>         return ret;
>  }
>
> -static __init bool cmdline_contains_nokaslr(const u8 *cmdline)
> -{
> -       const u8 *str;
> -
> -       str = strstr(cmdline, "nokaslr");
> -       return str == cmdline || (str > cmdline && *(str - 1) == ' ');
> -}
> -
> -static __init bool is_kaslr_disabled_cmdline(void *fdt)
> -{
> -       if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> -               int node;
> -               const u8 *prop;
> -
> -               node = fdt_path_offset(fdt, "/chosen");
> -               if (node < 0)
> -                       goto out;
> -
> -               prop = fdt_getprop(fdt, node, "bootargs", NULL);
> -               if (!prop)
> -                       goto out;
> -
> -               if (cmdline_contains_nokaslr(prop))
> -                       return true;
> -
> -               if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
> -                       goto out;
> -
> -               return false;
> -       }
> -out:
> -       return cmdline_contains_nokaslr(CONFIG_CMDLINE);
> -}
> +struct arm64_ftr_override kaslr_feature_override __initdata;
>
>  /*
>   * This routine will be executed with the kernel mapped at its default virtual
> @@ -126,7 +94,7 @@ u64 __init kaslr_early_init(void)
>          * Check if 'nokaslr' appears on the command line, and
>          * return 0 if that is the case.
>          */
> -       if (is_kaslr_disabled_cmdline(fdt)) {
> +       if (kaslr_feature_override.val & kaslr_feature_override.mask & 0xf) {
>                 kaslr_status = KASLR_DISABLED_CMDLINE;
>                 return 0;
>         }
> --
> 2.29.2
>
