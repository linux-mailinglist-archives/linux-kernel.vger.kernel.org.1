Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4A428C3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbgJLVLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgJLVLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:11:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED6C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:11:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b193so14723858pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hznOtUbTWNjEJYZsjBYfp17ENA2WPtrRZnCCOjoEFpg=;
        b=dwXUraXOTIKRcxZp0pwYP1Y3/n3gOd1Dq6LzEx6rfD3EeWGFNXaEVc2LnZ43hGvxhS
         MCb1/J0RxXgroLEIMLgGrEr093nMx28OmuDFOtqPvj5hi9PqBgFKQx5pN/d17e6T9Gom
         itnPlTQvDOsFIAFxUjGZZ0ADAOaU+BmYJJrGsbpuBOP0RyBwwn/8vcthLx+3Ii18Wf37
         nNpSFfPYX1bEUA/b2QAJ1FfgRVbTv6J/FIPcZBazae4+yoCvvYiDkIEQVFXkpRjVDDUP
         SduXSoJr4gUvwbd40c98CqJJLH7WwFhreaNYRthZAvNZzG04IcLR0t0aeLZp8s2TaoQV
         JSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hznOtUbTWNjEJYZsjBYfp17ENA2WPtrRZnCCOjoEFpg=;
        b=bV2UPkhaBdZMZC1fpziMiwfNEGo7GsGuYDhuilz582cgc8E547wvL1+bpFYQVc4WrJ
         f48exwCL2VvEcKGZyY3+ugrpTZyxaH3nuDy5I8BL8HMVQsYUaOL/tny90RmsO0SUt6kr
         yiM7F/6AUOdRigmgO5HLK/o10btlhIAJH8hiIY3genJZXoBt5QcJm30Zy1f9CqjWm+k7
         RgC0G9EaZypTz93cTH+T2qEgsVe4VEp8OR4cCitHRblqZ76qA0pSnVl/j1hqcPuifONU
         RjEPf2QK4ocKIDAJ7Kmf4/P8js5rjHtW8H3rRBbgdoD3IeT+RshFjGuEh7RxTHSrMdbt
         pmdA==
X-Gm-Message-State: AOAM530hIVGQzbWKOklUkf5u2fV3Gn4p3aRSuS0U5+Vx6W9L/MZFFV6V
        NFWh08hfht7CuGeGtWEC+X5R86gn9x2v6+IGPYMXcEnv5+bK/Q==
X-Google-Smtp-Source: ABdhPJyu3P3zLRq+uZnu7lqj2umh8EfmaIu62LLz3wYSgeeoXCTRxn4GjHp2/hWQppyxVuKyZU0ejH+kd3KUvKHRSdw=
X-Received: by 2002:a62:6408:0:b029:154:dde2:a5eb with SMTP id
 y8-20020a6264080000b0290154dde2a5ebmr26213344pfb.30.1602537061565; Mon, 12
 Oct 2020 14:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200928224854.3224862-1-natechancellor@gmail.com>
In-Reply-To: <20200928224854.3224862-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Oct 2020 14:10:50 -0700
Message-ID: <CAKwvOd=+98r6F4JjrPEoWX88WQ=B-KMRP2eWojabLk6it3i5KA@mail.gmail.com>
Subject: Re: [PATCH] arm/build: Always handle .ARM.exidx and .ARM.extab sections
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 3:49 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> After turning on warnings for orphan section placement, enabling
> CONFIG_UNWINDER_FRAME_POINTER instead of CONFIG_UNWINDER_ARM causes
> thousands of warnings when clang + ld.lld are used:
>
> $ scripts/config --file arch/arm/configs/multi_v7_defconfig \
>                  -d CONFIG_UNWINDER_ARM \
>                  -e CONFIG_UNWINDER_FRAME_POINTER
> $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=1 defconfig zImage
> ld.lld: warning: init/built-in.a(main.o):(.ARM.extab) is being placed in '.ARM.extab'
> ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.ref.text) is being placed in '.ARM.extab.ref.text'
> ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab) is being placed in '.ARM.extab'
> ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab) is being placed in '.ARM.extab'
> ld.lld: warning: init/built-in.a(do_mounts_initrd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab) is being placed in '.ARM.extab'
> ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab) is being placed in '.ARM.extab'
>
> These sections are handled by the ARM_UNWIND_SECTIONS define, which is
> only added to the list of sections when CONFIG_ARM_UNWIND is set.
> CONFIG_ARM_UNWIND is a hidden symbol that is only selected when
> CONFIG_UNWINDER_ARM is set so CONFIG_UNWINDER_FRAME_POINTER never
> handles these sections. According to the help text of
> CONFIG_UNWINDER_ARM, these sections should be discarded so that the
> kernel image size is not affected.

My apologies for taking so long to review this.

I have a suspicion that these come from forcing on configs that
Kconfig/menuconfig would block, and aren't clang or lld specific, yet
are exposed by the new linker warnings for orphan section placement
(good).  That said, we definitely have OEMs in Android land that still
prefer the older unwinder.

From https://developer.arm.com/documentation/ihi0038/b/ (click
download in top left), section 4.4.1 "Sections" has a note:

```
Tables are not required for ABI compliance at the C/Assembler level
but are required for C++.
```

Review-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Please submit to:
https://www.arm.linux.org.uk/developer/patches/add.php

>
> Fixes: 5a17850e251a ("arm/build: Warn on orphan section placement")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1152
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm/kernel/vmlinux.lds.S | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 5f4922e858d0..a2c0d96b0580 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -40,6 +40,10 @@ SECTIONS
>                 ARM_DISCARD
>  #ifndef CONFIG_SMP_ON_UP
>                 *(.alt.smp.init)
> +#endif
> +#ifndef CONFIG_ARM_UNWIND
> +               *(.ARM.exidx*)

I don't think we need the wildcard, as without this line, I see:

ld.lld: warning: <internal>:(.ARM.exidx) is being placed in '.ARM.exidx'

though I do see binutils linker scripts use precisely what you have.
So I guess that's fine.

I guess we can't reuse `ARM_UNWIND_SECTIONS` since the ALIGN and
linker-script-defined-symbols would be weird in a DISCARD clause?


> +               *(.ARM.extab*)
>  #endif
>         }
>
>
> base-commit: 6e0bf0e0e55000742a53c5f3b58f8669e0091a11
> --


--
Thanks,
~Nick Desaulniers
