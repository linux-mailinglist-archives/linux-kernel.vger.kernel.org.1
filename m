Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC45302D31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbhAYVDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbhAYU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:59:27 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E784DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:58:46 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o16so150626pgg.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ac+iynT2E2B9iCfIXnzbQh6ofAltR0HqroPjqlISkhE=;
        b=W4ZqT+IBFcjzfVQrxZRo8rBfiDB0jlpNOpAlGew/xgH9UVaGF7iv4HalF72EECCHFk
         b72iXQRs938SyygBV27bWmI1oW72YV9sNLLjyzntSOrCgGYsH3AqH0hr2A8iJ1pXv3qr
         DOevI8Qbs5ZjQO6DhhRZ0VPjsyKGGzosH1oqFNjf976GBQNYth5LXq+ftwM1nZW4UuUY
         Ziop045yDwy1BmrUsXJX0Lsxa0XMtl0ZkGWpgeSGS4eM7GSlsLdIZfuY8v9hMR1WSu1M
         e88W5o9Mu1D7A5I8I2rFBi4ixSMu+Xs5AlJlXZRnKJLaRjepd+CE81PR9xnpDQ1qBnyy
         9LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ac+iynT2E2B9iCfIXnzbQh6ofAltR0HqroPjqlISkhE=;
        b=Kw5zrwj5gFG2KtGpIsZ1lfXeOoo8zyIvZsbNrIQNmcnYz2NlGhF4wdoknB//pDyJ8f
         zjoxXswISZ+aA4eM1UNrdDbPuV6hThXKsW5Bh/0n+eM32sbY28yHXGwZdbxlv3mhMxo3
         rVORFwctxOtS+3i+wpSphH3YGNdVVba3ShYyiHp3FQs5DPVv/QXzzNjcfkvzaFF4ogMQ
         TX4tr7lt1E3AWZH6jiqkr7s3U9r6TwKn4fZelKebf/yZJWGhb38Z/1pqqMtg2xuAzsml
         ZA859Mk91PwJNUnh22O1v6I0reEnfS6Hna6EUjs+bayjuWr4wxj2RK42rcMkC0TXZ9K5
         ICxw==
X-Gm-Message-State: AOAM533cPa1cxyljc37eDh2Yj8Jt2xGOZxQ2Ra4ut9aSegIiBOf21DQ3
        h1kEYwAw7k187VU39ml3xECn9STfYzQnvFOYF4I18A==
X-Google-Smtp-Source: ABdhPJxouND+Ojhfh+LOFsJXmZFUVftRu0NAMqAtjsJM4Mdv4gKDNLv6E3vilfO28hNyXm/IHe55t75L2P1E0aFIiqc=
X-Received: by 2002:a63:5701:: with SMTP id l1mr2301794pgb.381.1611608326293;
 Mon, 25 Jan 2021 12:58:46 -0800 (PST)
MIME-Version: 1.0
References: <202101162230.XswE8zOX-lkp@intel.com> <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
 <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net> <88735d3b-1b56-bc8a-2183-1f9549626002@gmx.de>
 <20210125204720.GA28462@ls3530.fritz.box>
In-Reply-To: <20210125204720.GA28462@ls3530.fritz.box>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jan 2021 12:58:35 -0800
Message-ID: <CAKwvOd=RHb5yQj5kKuvt9BnywNUmRtivPu_qebLG8XXDyr8cCA@mail.gmail.com>
Subject: Re: hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
To:     Helge Deller <deller@gmx.de>
Cc:     John David Anglin <dave.anglin@bell.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:47 PM Helge Deller <deller@gmx.de> wrote:
>
> > >> On Sat, Jan 16, 2021 at 6:37 AM kernel test robot <lkp@intel.com> wrote:
> > >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > >>> head:   1d94330a437a573cfdf848f6743b1ed169242c8a
> > >>> commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: Add PGO and AutoFDO input sections
> > >>> date:   5 months ago
> > >>> config: parisc-randconfig-r032-20210116 (attached as .config)
> > >>> compiler: hppa64-linux-gcc (GCC) 9.3.0
> > >>> reproduce (this is a W=1 build):
> > >>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >>>         chmod +x ~/bin/make.cross
> > >>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eff8728fe69880d3f7983bec3fb6cea4c306261f
> > >>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >>>         git fetch --no-tags linus master
> > >>>         git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
> > >>>         # save the attached .config to linux build tree
> > >>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
> > >>>
> > >>> If you fix the issue, kindly add following tag as appropriate
> > >>> Reported-by: kernel test robot <lkp@intel.com>
> > >>>
> > >>> All errors (new ones prefixed by >>):
> > >>>
> > >>>    hppa64-linux-ld: mm/page_alloc.o(.ref.text+0x110): cannot reach unknown
> > >>>    hppa64-linux-ld: mm/memblock.o(.text+0x27c): cannot reach __warn_printk
> > >>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xc4): cannot reach printk
> ....
>
> The problem with this .config is, that both CONFIG_MODULES and
> CONFIG_MLONGCALLS are set to "n".
> The Kconfig autodetection needs fixing to enable CONFIG_MLONGCALLS in
> this case.
>
>
> This patch fixes it for me:
>
> [PATCH] Require -mlong-calls gcc option for !CONFIG_MODULES
>
> When building a kernel without module support, the CONFIG_MLONGCALL
> option needs to be enabled. This patch fixes the autodetection in the
> Kconfig script and uses a far call to preempt_schedule_irq() in
> intr_do_preempt().
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reported-by: kernel test robot <lkp@intel.com>
>
> ---
>
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 78b17621ee4a..278462186ac4 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -202,9 +202,8 @@ config PREFETCH
>         depends on PA8X00 || PA7200
>
>  config MLONGCALLS
> -       bool "Enable the -mlong-calls compiler option for big kernels"
> -       default y if !MODULES || UBSAN || FTRACE
> -       default n
> +       def_bool y if !MODULES || UBSAN || FTRACE
> +       bool "Enable the -mlong-calls compiler option for big kernels" if MODULES && !UBSAN && !FTRACE

^ this looks like the same constraints specified twice?  Am I
understanding that correctly? (I don't understand why this isn't
specified _once_).

>         depends on PA8X00
>         help
>           If you configure the kernel to include many drivers built-in instead
> diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
> index beba9816cc6c..6320f6a8397c 100644
> --- a/arch/parisc/kernel/entry.S
> +++ b/arch/parisc/kernel/entry.S
> @@ -997,10 +997,19 @@ intr_do_preempt:
>         bb,<,n  %r20, 31 - PSW_SM_I, intr_restore
>         nop
>
> -       BL      preempt_schedule_irq, %r2
> -       nop
> +       /* ssm PSW_SM_I done later in intr_restore */
> +#ifdef CONFIG_MLONGCALLS
> +       ldil    L%intr_restore, %r2
> +       load32  preempt_schedule_irq, %r1
> +       bv      %r0(%r1)
> +       ldo     R%intr_restore(%r2), %r2
> +#else
> +       ldil    L%intr_restore, %r2
> +       BL      preempt_schedule_irq
> +       ldo     R%intr_restore(%r2), %r2
> +#endif
> +
>
> -       b,n     intr_restore            /* ssm PSW_SM_I done by intr_restore */
>  #endif /* CONFIG_PREEMPTION */
>
>         /*
>
>


-- 
Thanks,
~Nick Desaulniers
