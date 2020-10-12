Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0B28C3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbgJLVWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgJLVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:22:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7153DC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:22:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t18so9381995plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1m/Wtp4bLQJzWJzF+98Mz8HCrTCEeB/aePRJpnsfT8Q=;
        b=K0BT6MdAMW90cMCcF8NQtHn+IF2KLfiFfFvXPmEUGKfTinu/IC3QaJV5C8sWiqRDHF
         5bXcJwMUDbP9oeB9vaZz48K8i0tjn9FcQCXSSwkvREQMy+MlbGjzvuWTzmYUYuTbblFH
         vJJEXfHQCkBA+tRW+aHIQOYPMxOz+thxmpBKJh+xv+EZ+EO3dEy/KjDPcQsQeXodsg87
         jQGE73Hx4hAXyMxe2TzQiKLn7We3mkCEX59URK1IKOnPIj0jak9G4rCpIqgD7KofuWYT
         UYPLx/z0SAPAy4ldsW0ZuATf5bRAXRKE6Q+haOkcrUFkQhb81dJ5/K5jx3zPM4Uz/Cbt
         AwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1m/Wtp4bLQJzWJzF+98Mz8HCrTCEeB/aePRJpnsfT8Q=;
        b=KnyN0txTomuU5im8TfISA3Mdr/edDEnh00Xlz+wscryQBBjBUyCP82/h+bChLChk8Y
         sZoVAivWYVfkMryZgF2iGuvYHMwSbwKyIdkM3UOOrrmgicwZqLaaHNx+je/U9qkL6N3l
         GWxd2vzaUcvwKB2NsMhoae/T0Qp26wd2UU80nCWoC9AXoeCsZWT0hDYLQbGbSoJK+rDl
         4hCmnVdTo1aBO8kK0XAKAjSAoFnHXBxQ70e4ScipSmIrwHEZgDhUMZloiDa/y5EeAllr
         FnAeOMEFRFXYmt2Jdo4eOms51nHYYdQKzdMx03YM7HT7MSqHoJ0kYwy7hSTsIf2Hp0Z2
         jqDg==
X-Gm-Message-State: AOAM5310yo1yjaQ+TpKEu4X56LhFzm8CADnkRfzSFrHrhhlj8Jbcw+NH
        4M+9VjZKcDDWojz3NH6/a8y1xYleqswDELkfkbezZQ==
X-Google-Smtp-Source: ABdhPJz1X5hl5VmY7SzT6Pl19wJaEjx1v7QKs/u9s2Lk+OUyA5QwmlUo/QklIAr+9butcgqJBvq2YFT1rtzBwcaoqWg=
X-Received: by 2002:a17:902:c1d2:b029:d3:ea72:cdec with SMTP id
 c18-20020a170902c1d2b02900d3ea72cdecmr25764756plc.47.1602537734750; Mon, 12
 Oct 2020 14:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200928224854.3224862-1-natechancellor@gmail.com> <CAKwvOd=+98r6F4JjrPEoWX88WQ=B-KMRP2eWojabLk6it3i5KA@mail.gmail.com>
In-Reply-To: <CAKwvOd=+98r6F4JjrPEoWX88WQ=B-KMRP2eWojabLk6it3i5KA@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 12 Oct 2020 14:22:03 -0700
Message-ID: <CAFP8O3J_Yn8SVD8RR=P5qv=NjdLT0s6JQQM8gWFU-2n0=b1uZg@mail.gmail.com>
Subject: Re: [PATCH] arm/build: Always handle .ARM.exidx and .ARM.extab sections
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 2:11 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Mon, Sep 28, 2020 at 3:49 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > After turning on warnings for orphan section placement, enabling
> > CONFIG_UNWINDER_FRAME_POINTER instead of CONFIG_UNWINDER_ARM causes
> > thousands of warnings when clang + ld.lld are used:
> >
> > $ scripts/config --file arch/arm/configs/multi_v7_defconfig \
> >                  -d CONFIG_UNWINDER_ARM \
> >                  -e CONFIG_UNWINDER_FRAME_POINTER
> > $ make -skj"$(nproc)" ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- LLV=
M=3D1 defconfig zImage
> > ld.lld: warning: init/built-in.a(main.o):(.ARM.extab) is being placed i=
n '.ARM.extab'
> > ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.init.text) is bein=
g placed in '.ARM.extab.init.text'
> > ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.ref.text) is being=
 placed in '.ARM.extab.ref.text'
> > ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab.init.text) is=
 being placed in '.ARM.extab.init.text'
> > ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab) is being pla=
ced in '.ARM.extab'
> > ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab.init.text)=
 is being placed in '.ARM.extab.init.text'
> > ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab) is being =
placed in '.ARM.extab'
> > ld.lld: warning: init/built-in.a(do_mounts_initrd.o):(.ARM.extab.init.t=
ext) is being placed in '.ARM.extab.init.text'
> > ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab.init.text) is=
 being placed in '.ARM.extab.init.text'
> > ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab) is being pla=
ced in '.ARM.extab'
> > ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab.init.text) is=
 being placed in '.ARM.extab.init.text'
> > ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab) is being pla=
ced in '.ARM.extab'
> >
> > These sections are handled by the ARM_UNWIND_SECTIONS define, which is
> > only added to the list of sections when CONFIG_ARM_UNWIND is set.
> > CONFIG_ARM_UNWIND is a hidden symbol that is only selected when
> > CONFIG_UNWINDER_ARM is set so CONFIG_UNWINDER_FRAME_POINTER never
> > handles these sections. According to the help text of
> > CONFIG_UNWINDER_ARM, these sections should be discarded so that the
> > kernel image size is not affected.
>
> My apologies for taking so long to review this.
>
> I have a suspicion that these come from forcing on configs that
> Kconfig/menuconfig would block, and aren't clang or lld specific, yet
> are exposed by the new linker warnings for orphan section placement
> (good).  That said, we definitely have OEMs in Android land that still
> prefer the older unwinder.
>
> From https://developer.arm.com/documentation/ihi0038/b/ (click
> download in top left), section 4.4.1 "Sections" has a note:
>
> ```
> Tables are not required for ABI compliance at the C/Assembler level
> but are required for C++.
> ```
>
> Review-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Please submit to:
> https://www.arm.linux.org.uk/developer/patches/add.php
>
> >
> > Fixes: 5a17850e251a ("arm/build: Warn on orphan section placement")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1152
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  arch/arm/kernel/vmlinux.lds.S | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.ld=
s.S
> > index 5f4922e858d0..a2c0d96b0580 100644
> > --- a/arch/arm/kernel/vmlinux.lds.S
> > +++ b/arch/arm/kernel/vmlinux.lds.S
> > @@ -40,6 +40,10 @@ SECTIONS
> >                 ARM_DISCARD
> >  #ifndef CONFIG_SMP_ON_UP
> >                 *(.alt.smp.init)
> > +#endif
> > +#ifndef CONFIG_ARM_UNWIND
> > +               *(.ARM.exidx*)
>
> I don't think we need the wildcard, as without this line, I see:
>
> ld.lld: warning: <internal>:(.ARM.exidx) is being placed in '.ARM.exidx'

We may need the wildcard if there are -ffunction-sections builds.
In clang, .ARM.exidx* cannot be removed even with -fno-unwind-tables
-fno-exceptions.

> though I do see binutils linker scripts use precisely what you have.
> So I guess that's fine.
>
> I guess we can't reuse `ARM_UNWIND_SECTIONS` since the ALIGN and
> linker-script-defined-symbols would be weird in a DISCARD clause?
>
>
> > +               *(.ARM.extab*)
> >  #endif
> >         }
> >
> >
> > base-commit: 6e0bf0e0e55000742a53c5f3b58f8669e0091a11
> > --
>
>
> --
> Thanks,
> ~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/CAKwvOd%3D%2B98r6F4JjrPEoWX88WQ%3DB-KMRP2eWojabLk6it3i5=
KA%40mail.gmail.com.



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
