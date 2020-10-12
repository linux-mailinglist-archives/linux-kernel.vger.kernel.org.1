Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0E28C3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgJLV04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgJLV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:26:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C4BC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:26:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u24so15682094pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DshweHF2Lcb/utD4pDzDKL8NA4Ub2idEznn/U60w5+0=;
        b=nuz+J7fbVhR0LUGXN8lOA9z1HodxCcgMcKObvNwZsGdW2bOEGRG2z0aLMYYkuUSiPg
         hnvgZcYV5VoEZqeP/nyuxBsrskPuRdnCFDOq66NGq0Xq6TirgU4wxL4ZNznNM3ole17P
         pwfUDUnjmXGtuHIvsGnQUKkMkwTGun/Uk/veg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DshweHF2Lcb/utD4pDzDKL8NA4Ub2idEznn/U60w5+0=;
        b=PEJMD3NgVCH1jKTISbluhIPNKs8vhlTP0pgLFRE6VwHB15pRisJ3yrkAtrPu9tb1HT
         6QmF7c69W/Ka3KV9pVVigRO4q1QK0Wjr6isbYjRO3dfxaqu29ukRxFv075XMJupQ0/F/
         +swriXqvsOuJlTB+20xCv0coO0iU0fUjisHP33sAFtliyqmF7zU+pNWYs5YMb+rsSJtL
         ecT3+nICyRyIKP8Qbns1fOoH+h5xELyGVn/+4zeem2ZW5PhvmXjBzlgI3uY2q6i+799w
         yLdzVj4d6vWeY8rCDGxILTIaARaC7452JwAiRlA3X7gm97nfnhWG7O5fgNCeUNjPE0Yc
         /tMw==
X-Gm-Message-State: AOAM532ZJDpm3y+X7rjZ5J+8Tf7jRQNKclu6oZtrVniTmOvBfS9jej3Z
        8DNk7gDZM8drXcmXB5TY8KPsHQ==
X-Google-Smtp-Source: ABdhPJydgD7aNMc9YvgoC3Db36t9aF0HJPF5vX/QdGEwOOIqOIqqYD7nUuRwtjbG7AJMCMNY8exgxA==
X-Received: by 2002:a63:f803:: with SMTP id n3mr14515274pgh.231.1602538014115;
        Mon, 12 Oct 2020 14:26:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j24sm5270519pjn.9.2020.10.12.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 14:26:53 -0700 (PDT)
Date:   Mon, 12 Oct 2020 14:26:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm/build: Always handle .ARM.exidx and .ARM.extab
 sections
Message-ID: <202010121426.A5FA5E59@keescook>
References: <20200928224854.3224862-1-natechancellor@gmail.com>
 <CAKwvOd=+98r6F4JjrPEoWX88WQ=B-KMRP2eWojabLk6it3i5KA@mail.gmail.com>
 <CAFP8O3J_Yn8SVD8RR=P5qv=NjdLT0s6JQQM8gWFU-2n0=b1uZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3J_Yn8SVD8RR=P5qv=NjdLT0s6JQQM8gWFU-2n0=b1uZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:22:03PM -0700, Fāng-ruì Sòng wrote:
> On Mon, Oct 12, 2020 at 2:11 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Mon, Sep 28, 2020 at 3:49 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > After turning on warnings for orphan section placement, enabling
> > > CONFIG_UNWINDER_FRAME_POINTER instead of CONFIG_UNWINDER_ARM causes
> > > thousands of warnings when clang + ld.lld are used:
> > >
> > > $ scripts/config --file arch/arm/configs/multi_v7_defconfig \
> > >                  -d CONFIG_UNWINDER_ARM \
> > >                  -e CONFIG_UNWINDER_FRAME_POINTER
> > > $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=1 defconfig zImage
> > > ld.lld: warning: init/built-in.a(main.o):(.ARM.extab) is being placed in '.ARM.extab'
> > > ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > ld.lld: warning: init/built-in.a(main.o):(.ARM.extab.ref.text) is being placed in '.ARM.extab.ref.text'
> > > ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > ld.lld: warning: init/built-in.a(do_mounts.o):(.ARM.extab) is being placed in '.ARM.extab'
> > > ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > ld.lld: warning: init/built-in.a(do_mounts_rd.o):(.ARM.extab) is being placed in '.ARM.extab'
> > > ld.lld: warning: init/built-in.a(do_mounts_initrd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > ld.lld: warning: init/built-in.a(initramfs.o):(.ARM.extab) is being placed in '.ARM.extab'
> > > ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
> > > ld.lld: warning: init/built-in.a(calibrate.o):(.ARM.extab) is being placed in '.ARM.extab'
> > >
> > > These sections are handled by the ARM_UNWIND_SECTIONS define, which is
> > > only added to the list of sections when CONFIG_ARM_UNWIND is set.
> > > CONFIG_ARM_UNWIND is a hidden symbol that is only selected when
> > > CONFIG_UNWINDER_ARM is set so CONFIG_UNWINDER_FRAME_POINTER never
> > > handles these sections. According to the help text of
> > > CONFIG_UNWINDER_ARM, these sections should be discarded so that the
> > > kernel image size is not affected.
> >
> > My apologies for taking so long to review this.
> >
> > I have a suspicion that these come from forcing on configs that
> > Kconfig/menuconfig would block, and aren't clang or lld specific, yet
> > are exposed by the new linker warnings for orphan section placement
> > (good).  That said, we definitely have OEMs in Android land that still
> > prefer the older unwinder.
> >
> > From https://developer.arm.com/documentation/ihi0038/b/ (click
> > download in top left), section 4.4.1 "Sections" has a note:
> >
> > ```
> > Tables are not required for ABI compliance at the C/Assembler level
> > but are required for C++.
> > ```
> >
> > Review-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Please submit to:
> > https://www.arm.linux.org.uk/developer/patches/add.php
> >
> > >
> > > Fixes: 5a17850e251a ("arm/build: Warn on orphan section placement")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1152
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  arch/arm/kernel/vmlinux.lds.S | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> > > index 5f4922e858d0..a2c0d96b0580 100644
> > > --- a/arch/arm/kernel/vmlinux.lds.S
> > > +++ b/arch/arm/kernel/vmlinux.lds.S
> > > @@ -40,6 +40,10 @@ SECTIONS
> > >                 ARM_DISCARD
> > >  #ifndef CONFIG_SMP_ON_UP
> > >                 *(.alt.smp.init)
> > > +#endif
> > > +#ifndef CONFIG_ARM_UNWIND
> > > +               *(.ARM.exidx*)
> >
> > I don't think we need the wildcard, as without this line, I see:
> >
> > ld.lld: warning: <internal>:(.ARM.exidx) is being placed in '.ARM.exidx'
> 
> We may need the wildcard if there are -ffunction-sections builds.
> In clang, .ARM.exidx* cannot be removed even with -fno-unwind-tables
> -fno-exceptions.

Does it need to be:

	*(.ARM.exidx) *(.ARM.exidx.*)
	*(.ARM.extab) *(.ARM.extab.*)

?

> 
> > though I do see binutils linker scripts use precisely what you have.
> > So I guess that's fine.
> >
> > I guess we can't reuse `ARM_UNWIND_SECTIONS` since the ALIGN and
> > linker-script-defined-symbols would be weird in a DISCARD clause?
> >
> >
> > > +               *(.ARM.extab*)
> > >  #endif
> > >         }
> > >
> > >
> > > base-commit: 6e0bf0e0e55000742a53c5f3b58f8669e0091a11
> > > --
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAKwvOd%3D%2B98r6F4JjrPEoWX88WQ%3DB-KMRP2eWojabLk6it3i5KA%40mail.gmail.com.
> 
> 
> 
> -- 
> 宋方睿

-- 
Kees Cook
