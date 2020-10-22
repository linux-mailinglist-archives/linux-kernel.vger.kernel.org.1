Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2019B2962A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901669AbgJVQXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901662AbgJVQXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:23:38 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A65CC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qx//rllWCp4Aw9Y+j8oLuNI/zBX7cIb9yVaUMv2x7k0=; b=oBZuHDgw4DeXYQPGB8Q+Brmz9
        RAEQbjI7+qzhoYXHsbPL6b4mjeKA71Sqa5q5eprKA04jF5Ay00ZHmkvDUTFnk96GhmUcYGwuOtzBp
        /StxxSD4J8d6nqfLvglLXidTl9pdbbkdNbtlXKr4cfCdG5DIgSR0jnOklIzWbx9QCM2d+gxfYDcUx
        nRNHN6siVg7Sx2YJLl6So1coJl5KNPsLHrfRWrXhN2A4iQx3A1ezC5uzt2hcIPt/N8PODBcd0BvGt
        2KgHJskbg/AQkwyzwgqWCpHpsVMzE4vqMvataxXeG9i24GWPAbJf1JVffWSLMpMquWN4s8Kf+OYE1
        4lux2JiMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49576)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kVdNH-0002I1-1q; Thu, 22 Oct 2020 17:23:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVdNG-0007Xt-Bf; Thu, 22 Oct 2020 17:23:34 +0100
Date:   Thu, 22 Oct 2020 17:23:34 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
Message-ID: <20201022162334.GQ1551@shell.armlinux.org.uk>
References: <20201021225737.739-1-digetx@gmail.com>
 <202010211637.7CFD8435@keescook>
 <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook>
 <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com>
 <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk>
 <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 06:20:40PM +0200, Ard Biesheuvel wrote:
> On Thu, 22 Oct 2020 at 18:11, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Oct 22, 2020 at 06:06:32PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 22 Oct 2020 at 17:57, Dmitry Osipenko <digetx@gmail.com> wrote:
> > > >
> > > > 22.10.2020 10:06, Ard Biesheuvel пишет:
> > > > > On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chromium.org> wrote:
> > > > >>
> > > > >> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko wrote:
> > > > >>> 22.10.2020 02:40, Kees Cook пишет:
> > > > >>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
> > > > >>>>> The vfp_kmode_exception() function now is unreachable using relative
> > > > >>>>> branching in THUMB2 kernel configuration, resulting in a "relocation
> > > > >>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_exception'"
> > > > >>>>> linker error. Let's use long jump in order to fix the issue.
> > > > >>>>
> > > > >>>> Eek. Is this with gcc or clang?
> > > > >>>
> > > > >>> GCC 9.3.0
> > > > >>>
> > > > >>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
> > > > >>>>
> > > > >>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing sections") ?
> > > > >>>> That commit may have implicitly moved the location of .vfp11_veneer,
> > > > >>>> though I thought I had chosen the correct position.
> > > > >>>
> > > > >>> I re-checked that the fixes tag is correct.
> > > > >>>
> > > > >>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > >>>>> ---
> > > > >>>>>  arch/arm/vfp/vfphw.S | 3 ++-
> > > > >>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >>>>>
> > > > >>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> > > > >>>>> index 4fcff9f59947..6e2b29f0c48d 100644
> > > > >>>>> --- a/arch/arm/vfp/vfphw.S
> > > > >>>>> +++ b/arch/arm/vfp/vfphw.S
> > > > >>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> > > > >>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy restore nor FP exceptions
> > > > >>>>>    and     r3, r3, #MODE_MASK      @ are supported in kernel mode
> > > > >>>>>    teq     r3, #USR_MODE
> > > > >>>>> -  bne     vfp_kmode_exception     @ Returns through lr
> > > > >>>>> +  ldr     r1, =vfp_kmode_exception
> > > > >>>>> +  bxne    r1                      @ Returns through lr
> > > > >>>>>
> > > > >>>>>    VFPFMRX r1, FPEXC               @ Is the VFP enabled?
> > > > >>>>>    DBGSTR1 "fpexc %08x", r1
> > > > >>>>
> > > > >>>> This seems like a workaround though? I suspect the vfp11_veneer needs
> > > > >>>> moving?
> > > > >>>>
> > > > >>>
> > > > >>> I don't know where it needs to be moved. Please feel free to make a
> > > > >>> patch if you have a better idea, I'll be glad to test it.
> > > > >>
> > > > >> I might have just been distracted by the common "vfp" prefix. It's
> > > > >> possible that the text section shuffling just ended up being very large,
> > > > >> so probably this patch is right then!
> > > > >>
> > > > >
> > > > > I already sent a fix for this issue:
> > > > >
> > > > > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9018/1
> > > > >
> > > >
> > > > The offending commit contains stable tag, so I assume that fixes tag is
> > > > mandatory. Yours patch misses the fixes tag.
> > >
> > > Russell, mind adding that? Or would you like me to update the patch in
> > > the patch system?
> >
> > Rather than adding the IT, I'm suggesting that we solve it a different
> > way - ensuring that the two bits of code are co-located. There's no
> > reason for them to be separated, and the assembly code entry point is
> > already called indirectly.
> >
> > The problem is the assembly ends up in the .text section which ends up
> > at the start of the binary, but depending on the compiler, functions
> > in .c files end up in their own sections. It would be good if, as
> > Dmitry has shown that it is indeed possible, to have them co-located.
> 
> Why is that better? I provided a minimal fix which has zero impact on
> ARM builds, and minimal impact on Thumb2 builds, given that it retains
> the exact same semantics as before, but using a different opcode.

I think you just described the reason there. Why should we force
everything to use a different opcode when a short jump _should_
suffice?

Your patch may be a single line, but it has a slightly greater
impact than the alternative two line solution.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
