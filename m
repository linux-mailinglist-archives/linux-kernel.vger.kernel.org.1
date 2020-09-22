Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7021E273AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgIVGZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbgIVGZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:25:22 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B97623A9F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600755921;
        bh=cqAe/xvYS1mKuUzouttPZql96UUUGsOLKDqLlQHN2fE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EtYfDgdBAPbP8TWKG8ogioyyv2hNt8kTWC8+g/UxDQCcGPrJrj7FW5xapAMC5Gkd8
         91qi/JafAXKnQLAeyj+jrs2czqVkVEgRjHZcRiYSaOxTVhFO7Mzf9khlgve2OCtB3t
         UnpWlFVMOtqao6dtxVNt5u/RTG5XMBE9773uHIKo=
Received: by mail-ot1-f49.google.com with SMTP id a2so14602989otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:25:21 -0700 (PDT)
X-Gm-Message-State: AOAM533lBgU1w+EGEMOfpaLCm0HY+7dRWSH7cOb9QaW5s3aB6RxSBKE1
        3M7w7l+TAgLHt9tx6eqcgNmntsr1u8qlytFTvwQ=
X-Google-Smtp-Source: ABdhPJzzIMjrpFZf7tW8i3GVrgOWyDkDIbg2SZA3bBZky8u+QkYObueHgvcCao0HML0mkFCtzxaW4n9zExlg4+V/2Ro=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr2003546otk.77.1600755920735;
 Mon, 21 Sep 2020 23:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid>
In-Reply-To: <20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Sep 2020 08:25:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH4XUS7g8FMZ1noboyZB28B08MTzjEGKpUVLZPAbq1wQA@mail.gmail.com>
Message-ID: <CAMj1kXH4XUS7g8FMZ1noboyZB28B08MTzjEGKpUVLZPAbq1wQA@mail.gmail.com>
Subject: Re: [PATCH] arm64: crypto: Add an option to assume NEON XOR is the fastest
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 at 02:27, Douglas Anderson <dianders@chromium.org> wrote:
>
> On every boot time we see messages like this:
>
> [    0.025360] calling  calibrate_xor_blocks+0x0/0x134 @ 1
> [    0.025363] xor: measuring software checksum speed
> [    0.035351]    8regs     :  3952.000 MB/sec
> [    0.045384]    32regs    :  4860.000 MB/sec
> [    0.055418]    arm64_neon:  5900.000 MB/sec
> [    0.055423] xor: using function: arm64_neon (5900.000 MB/sec)
> [    0.055433] initcall calibrate_xor_blocks+0x0/0x134 returned 0 after 29296 usecs
>
> As you can see, we spend 30 ms on every boot re-confirming that, yet
> again, the arm64_neon implementation is the fastest way to do XOR.
> ...and the above is on a system with HZ=1000.  Due to the way the
> testing happens, if we have HZ defined to something slower it'll take
> much longer.  HZ=100 means we spend 300 ms on every boot re-confirming
> a fact that will be the same for every bootup.
>
> Trying to super-optimize the xor operation makes a lot of sense if
> you're using software RAID, but the above is probably not worth it for
> most Linux users because:
> 1. Quite a few arm64 kernels are built for embedded systems where
>    software raid isn't common.  That means we're spending lots of time
>    on every boot trying to optimize something we don't use.
> 2. Presumably, if we have neon, it's faster than alternatives.  If
>    it's not, it's not expected to be tons slower.
> 3. Quite a lot of arm64 systems are big.LITTLE.  This means that the
>    existing test is somewhat misguided because it's assuming that test
>    results on the boot CPU apply to the other CPUs in the system.
>    This is not necessarily the case.
>
> Let's add a new config option that allows us to just use the neon
> functions (if present) without benchmarking.
>
> NOTE: One small side effect is that on an arm64 system _without_ neon
> we'll end up testing the xor_block_8regs_p and xor_block_32regs_p
> versions of the function.  That's presumably OK since we already test
> all those when KERNEL_MODE_NEON is disabled.
>
> ALSO NOTE: presumably the way to do better than this is to add some
> sort of per-CPU-core lookup table and jump to a per-CPU-core-specific
> XOR function each time xor is called.  Without seeing evidence that
> this would really help someone, though, that doesn't seem worth it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

On the two arm64 machines that I happen to have running right now, I get

SynQuacer (Cortex-A53)

    8regs     :  1917.000 MB/sec
    32regs    :  2270.000 MB/sec
    arm64_neon:  2053.000 MB/sec

ThunderX2

    8regs     : 10170.000 MB/sec
    32regs    : 12051.000 MB/sec
    arm64_neon: 10948.000 MB/sec

so your assertion is not entirely valid.

If the system does not need XOR, it is free not to load the module, so
there is no reason it has to affect the boot time.

What we /can/ do is remove 8regs - arm64 has plenty of registers so I
don't think it will ever be the fastest.



> ---
>
>  arch/arm64/Kconfig           | 15 +++++++++++++++
>  arch/arm64/include/asm/xor.h |  5 +++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 64ae5e4eb814..fc18df45a5f8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -306,6 +306,21 @@ config SMP
>  config KERNEL_MODE_NEON
>         def_bool y
>
> +menuconfig FORCE_NEON_XOR_IF_AVAILABLE
> +       bool "Assume neon is fastest for xor if the CPU supports it"
> +       default y
> +       depends on KERNEL_MODE_NEON
> +       help
> +         Normally the kernel will run through several different XOR
> +         algorithms at boot, timing them on the boot processor to see
> +         which is fastest. This can take quite some time. On many
> +         machines it's expected that, if NEON is available, it's going
> +         to provide the fastest implementation. If you set this option
> +         we'll skip testing this every boot and just assume NEON is the
> +         fastest if present. Setting this option will speed up your
> +         boot but you might end up with a less-optimal xor
> +         implementation.
> +
>  config FIX_EARLYCON_MEM
>         def_bool y
>
> diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
> index 947f6a4f1aa0..1acb290866ab 100644
> --- a/arch/arm64/include/asm/xor.h
> +++ b/arch/arm64/include/asm/xor.h
> @@ -57,6 +57,10 @@ static struct xor_block_template xor_block_arm64 = {
>         .do_4   = xor_neon_4,
>         .do_5   = xor_neon_5
>  };
> +#ifdef CONFIG_FORCE_NEON_XOR_IF_AVAILABLE
> +#define XOR_SELECT_TEMPLATE(FASTEST) \
> +       (cpu_has_neon() ? &xor_block_arm64 : FASTEST)
> +#else /* ! CONFIG_FORCE_NEON_XOR_IF_AVAILABLE */
>  #undef XOR_TRY_TEMPLATES
>  #define XOR_TRY_TEMPLATES           \
>         do {        \
> @@ -66,5 +70,6 @@ static struct xor_block_template xor_block_arm64 = {
>                         xor_speed(&xor_block_arm64);\
>                 } \
>         } while (0)
> +#endif /* ! CONFIG_FORCE_NEON_XOR_IF_AVAILABLE */
>
>  #endif /* ! CONFIG_KERNEL_MODE_NEON */
> --
> 2.28.0.681.g6f77f65b4e-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
