Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8728A28C789
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 05:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgJMD0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 23:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgJMD0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:26:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C67C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 20:26:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b26so15792974pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hbtKnEJhUFXSLqEQaTLTu991fw6+yx1srZoUsdDGH+w=;
        b=M9aQAyTHDmHBF+liYd1g9/BLjw5FkInD91ZlKgWDqvAhWgLFX0IH4V5cGTgkLIlbq6
         Gp38II+7HP23HrJ9WzCzy0QDKpNmkyxwojeUa8a4KJmOzcrJt6T7shUL2tt7xymhGGSn
         mmUb19hTDHIv8gKU0ZFZtkaujCsZX2+ictkDmCvi4A8clEJ1MAoQglWodN8kKX290BMT
         FWPWUu+P3VWqUYXUWGNU77UeRRQjm/sfznPGIF/rGDAf8QMYSQ//+SRvS8i5YmMh/o/5
         wo2+9ElHMp5w3POXa4G7VJybm1B64acLErI0i7ZQHlVMonUF3SFEAxpHvSTC+GjgRiCL
         Eq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hbtKnEJhUFXSLqEQaTLTu991fw6+yx1srZoUsdDGH+w=;
        b=hI4lL44+kvakCoEUPZW99KZKNqFGAkINysvz+OTK2vUWVSnX/liF0fXGfYmNsucEgr
         LhWi04OhM+hWvaJfW3BORrM621jttKtLGhFp6DrqKpB87QwH2QOqJomsjUsrgV8MAV5+
         4XFFmO1mMAZikVZsb8zy9IvKq/MViQtdtcCRQykeD8DbGjwtgXxP7SqZ4aBGzedyuK5P
         UM4ScrF+Qqu0Y4la63+S/myLbo43+FUe++vAhPymFWnJXTHY8a7Sy6xOb9fMuC0KoiIb
         IYAMjja6A7qZdIWOBDYCc+qru/921ly4AK/sKZK6GNMyUE+TUJgG66c/c+SalPMDtQj2
         gv3Q==
X-Gm-Message-State: AOAM533r4bxbtHbxGYv0e6HrOLWXNxWYnSeLeBLG9EHTPRQJSFeQ0Q4I
        qAB7NBsU0tba1RdlE7us90w=
X-Google-Smtp-Source: ABdhPJw4HEgOYJeLxH6SPSZIfMYhKJR+4KK7W4NbKz65FCXfj+Ue2WCt0LbPvvp1rmoiJtGWwAUY9w==
X-Received: by 2002:a63:1f03:: with SMTP id f3mr14932167pgf.381.1602559570801;
        Mon, 12 Oct 2020 20:26:10 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id s4sm20242196pfu.107.2020.10.12.20.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 20:26:09 -0700 (PDT)
Date:   Mon, 12 Oct 2020 20:26:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm/build: Always handle .ARM.exidx and .ARM.extab
 sections
Message-ID: <20201013032607.GA2091780@ubuntu-m3-large-x86>
References: <20200928224854.3224862-1-natechancellor@gmail.com>
 <CAKwvOd=+98r6F4JjrPEoWX88WQ=B-KMRP2eWojabLk6it3i5KA@mail.gmail.com>
 <CAFP8O3J_Yn8SVD8RR=P5qv=NjdLT0s6JQQM8gWFU-2n0=b1uZg@mail.gmail.com>
 <202010121426.A5FA5E59@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202010121426.A5FA5E59@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:26:52PM -0700, Kees Cook wrote:
> On Mon, Oct 12, 2020 at 02:22:03PM -0700, Fāng-ruì Sòng wrote:
> > On Mon, Oct 12, 2020 at 2:11 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 3:49 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > After turning on warnings for orphan section placement, enabling
> > > > CONFIG_UNWINDER_FRAME_POINTER instead of CONFIG_UNWINDER_ARM causes
> > > > thousands of warnings when clang + ld.lld are used:
> > > >
> > > > $ scripts/config --file arch/arm/configs/multi_v7_defconfig \
> > > >                  -d CONFIG_UNWINDER_ARM \
> > > >                  -e CONFIG_UNWINDER_FRAME_POINTER
> > > > $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=1 defconfig zImage
> > > > ld.lld: warning: init/built-in.a(main.o):(.ARM.extab) is being placed in '.ARM.extab'
> > > > ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > > ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.ref.text) is being placed in '.ARM.extab.ref.text'
> > > > ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > > ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab) is being placed in '.ARM.extab'
> > > > ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > > ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab) is being placed in '.ARM.extab'
> > > > ld.lld: warning: init/built-in.a(do_mounts_initrd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > > ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > > ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab) is being placed in '.ARM.extab'
> > > > ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > > ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab) is being placed in '.ARM.extab'
> > > >
> > > > These sections are handled by the ARM_UNWIND_SECTIONS define, which is
> > > > only added to the list of sections when CONFIG_ARM_UNWIND is set.
> > > > CONFIG_ARM_UNWIND is a hidden symbol that is only selected when
> > > > CONFIG_UNWINDER_ARM is set so CONFIG_UNWINDER_FRAME_POINTER never
> > > > handles these sections. According to the help text of
> > > > CONFIG_UNWINDER_ARM, these sections should be discarded so that the
> > > > kernel image size is not affected.
> > >
> > > My apologies for taking so long to review this.
> > >
> > > I have a suspicion that these come from forcing on configs that
> > > Kconfig/menuconfig would block, and aren't clang or lld specific, yet
> > > are exposed by the new linker warnings for orphan section placement
> > > (good).  That said, we definitely have OEMs in Android land that still
> > > prefer the older unwinder.
> > >
> > > From https://developer.arm.com/documentation/ihi0038/b/ (click
> > > download in top left), section 4.4.1 "Sections" has a note:
> > >
> > > ```
> > > Tables are not required for ABI compliance at the C/Assembler level
> > > but are required for C++.
> > > ```
> > >
> > > Review-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > Please submit to:
> > > https://www.arm.linux.org.uk/developer/patches/add.php

This should go through the tip tree (hence sending it straight to Ingo)
since the patch that this fixes was there. I guess it does not
necessarily matter now that the breakage is in mainline but basing a
set of patches on a non -rc tag is a little taboo I thought so not sure
it is appropriate to go through Russell for now. It is up to the
maintainers though, I will submit it wherever it needs to go.

> > > >
> > > > Fixes: 5a17850e251a ("arm/build: Warn on orphan section placement")
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1152
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  arch/arm/kernel/vmlinux.lds.S | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> > > > index 5f4922e858d0..a2c0d96b0580 100644
> > > > --- a/arch/arm/kernel/vmlinux.lds.S
> > > > +++ b/arch/arm/kernel/vmlinux.lds.S
> > > > @@ -40,6 +40,10 @@ SECTIONS
> > > >                 ARM_DISCARD
> > > >  #ifndef CONFIG_SMP_ON_UP
> > > >                 *(.alt.smp.init)
> > > > +#endif
> > > > +#ifndef CONFIG_ARM_UNWIND
> > > > +               *(.ARM.exidx*)
> > >
> > > I don't think we need the wildcard, as without this line, I see:
> > >
> > > ld.lld: warning: <internal>:(.ARM.exidx) is being placed in '.ARM.exidx'
> > 
> > We may need the wildcard if there are -ffunction-sections builds.
> > In clang, .ARM.exidx* cannot be removed even with -fno-unwind-tables
> > -fno-exceptions.
> 
> Does it need to be:
> 
> 	*(.ARM.exidx) *(.ARM.exidx.*)
> 	*(.ARM.extab) *(.ARM.extab.*)
> 
> ?

I tested the patch and saw no warnings with what I sent. I can change it
to that if it is more proper though!

> > 
> > > though I do see binutils linker scripts use precisely what you have.
> > > So I guess that's fine.
> > >
> > > I guess we can't reuse `ARM_UNWIND_SECTIONS` since the ALIGN and
> > > linker-script-defined-symbols would be weird in a DISCARD clause?
> > >
> > >
> > > > +               *(.ARM.extab*)
> > > >  #endif
> > > >         }
> > > >
> > > >
> > > > base-commit: 6e0bf0e0e55000742a53c5f3b58f8669e0091a11
> > > > --
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAKwvOd%3D%2B98r6F4JjrPEoWX88WQ%3DB-KMRP2eWojabLk6it3i5KA%40mail.gmail.com.
> > 
> > 
> > 
> > -- 
> > 宋方睿
> 
> -- 
> Kees Cook

Cheers,
Nathan
