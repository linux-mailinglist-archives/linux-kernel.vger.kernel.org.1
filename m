Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47652A24EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgKBHAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgKBHAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:00:01 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808D6C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 23:00:01 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id f9so16034849lfq.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+XrbFe95lhlmoO1jxJAYeqcLTSX+HLUCIq1p8ctluo=;
        b=LZ71Tgk9nMGd2ZWC7FJqsuBzrWWF68BI6ujrE0QLNc5AlU/uOQYLsyV3xMPMhHACtA
         gMW5w1tQR0MmzGdBljnfcV9ipagBmR/40NFY56dyjOwpp5YR5fChicwVZT9xLvZFd4oL
         uDMgHEPtBvlYN0AHy8k2FBa9pWhtTLW+bbqWvrctqAWyGdHtIBAq6bNrmZiUP0VmSgdu
         WCuNzcVlSUVHcQ9haZN7k8ffHSzCTdO/aWhYmobrso1nKPX59Nhtmr1DoxwXU5OjBk+P
         EiLupArqfmt6Q3M+OVgNbv9I1xPaBP3rjVxRJVsGNddaVD75h+YS/ZVCZZm/ORaeD6Lo
         rD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+XrbFe95lhlmoO1jxJAYeqcLTSX+HLUCIq1p8ctluo=;
        b=G2hQf2/5S4pXlQXJWiYmCnmiA49a1RmCL8dicxUAbDDKCXAFmhXKGtIp0wKm2dW0Rk
         /kgAvuUY/MqEZinnqMD1AeNLi7aPtm+KK3LIe/F7Bd1qefNQBIHl3Y3asMv1jpLkKNyF
         l40Gw13OiRYPp1im4zICza6QScO8YinMLBG7e/1TUtDKekrs0mQHLouiMVLDCg11sgu+
         k75v+gc0lC01p7wSUGUmphZf963elwGpFcJ5uRee9sIafKqyYzEowbF8LqHnVeyznaWA
         Gos08qo7OGU8O/p1BoulDUJqJgOp2NF4oz3996YMeU1LeXHcPDQRlBjTjz5Is7qAliOs
         HOZw==
X-Gm-Message-State: AOAM533Z4bDgeyexGF+WEYuEVbhDppxOetnaP/r6Vbpsmf2xh63u86FS
        0vibS9eBPtBkvnrnWyqORoJA0zyO8Ck7KkjTJEawiZCLSg2/sg==
X-Google-Smtp-Source: ABdhPJyi9O1vrGK1LsMrHwA72XdsBK2WzU4SSnDVEBWijqQ/tCFtG5WKvsVEWkRzjPNCj3tJCwMX2YvWYeLrchESkQ0=
X-Received: by 2002:ac2:46cc:: with SMTP id p12mr4949695lfo.283.1604300399964;
 Sun, 01 Nov 2020 22:59:59 -0800 (PST)
MIME-Version: 1.0
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
 <1603983387-8738-8-git-send-email-sumit.garg@linaro.org> <20201029162234.a5czyjy4eyto6aa4@holly.lan>
 <20201029163921.dibail374cwwonvo@holly.lan>
In-Reply-To: <20201029163921.dibail374cwwonvo@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 2 Nov 2020 12:29:48 +0530
Message-ID: <CAFA6WYP1VOgNFuh+E0BOB3T5v+Brf3jCQsKf8iVTTMje6Mte9g@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] arm64: kgdb: Roundup cpus using IPI as NMI
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        "David S. Miller" <davem@davemloft.net>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 at 22:09, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Oct 29, 2020 at 04:22:34PM +0000, Daniel Thompson wrote:
> > On Thu, Oct 29, 2020 at 08:26:27PM +0530, Sumit Garg wrote:
> > > arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> > > leveraged to roundup CPUs which are stuck in hard lockup state with
> > > interrupts disabled that wouldn't be possible with a normal IPI.
> > >
> > > So instead switch to roundup CPUs using IPI turned as NMI. And in
> > > case a particular arm64 platform doesn't supports pseudo NMIs,
> > > it will switch back to default kgdb CPUs roundup mechanism.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  arch/arm64/include/asm/kgdb.h |  9 +++++++++
> > >  arch/arm64/kernel/ipi_nmi.c   |  5 +++++
> > >  arch/arm64/kernel/kgdb.c      | 35 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 49 insertions(+)
> > >
> > > diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
> > > index 21fc85e..c3d2425 100644
> > > --- a/arch/arm64/include/asm/kgdb.h
> > > +++ b/arch/arm64/include/asm/kgdb.h
> > > @@ -24,6 +24,15 @@ static inline void arch_kgdb_breakpoint(void)
> > >  extern void kgdb_handle_bus_error(void);
> > >  extern int kgdb_fault_expected;
> > >
> > > +#ifdef CONFIG_KGDB
> > > +extern bool kgdb_ipi_nmicallback(int cpu, void *regs);
> > > +#else
> > > +static inline bool kgdb_ipi_nmicallback(int cpu, void *regs)
> > > +{
> > > +   return false;
> > > +}
> > > +#endif
> > > +
> > >  #endif /* !__ASSEMBLY__ */
> > >
> > >  /*
> > > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> > > index 597dcf7..6ace182 100644
> > > --- a/arch/arm64/kernel/ipi_nmi.c
> > > +++ b/arch/arm64/kernel/ipi_nmi.c
> > > @@ -8,6 +8,7 @@
> > >
> > >  #include <linux/interrupt.h>
> > >  #include <linux/irq.h>
> > > +#include <linux/kgdb.h>
> > >  #include <linux/nmi.h>
> > >  #include <linux/smp.h>
> > >
> > > @@ -45,10 +46,14 @@ bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> > >  static irqreturn_t ipi_nmi_handler(int irq, void *data)
> > >  {
> > >     irqreturn_t ret = IRQ_NONE;
> > > +   unsigned int cpu = smp_processor_id();
> > >
> > >     if (nmi_cpu_backtrace(get_irq_regs()))
> > >             ret = IRQ_HANDLED;
> > >
> > > +   if (kgdb_ipi_nmicallback(cpu, get_irq_regs()))
> > > +           ret = IRQ_HANDLED;
> > > +
> > >     return ret;
> >
> > It would be better to declare existing return value for
> > kgdb_nmicallback() to be dangerously stupid and fix it so it returns an
> > irqreturn_t (that's easy since most callers do not need to check the
> > return value).
> >
> > Then this code simply becomes:
> >
> >       return kgdb_nmicallback(cpu, get_irq_regs());
>
> Actually, reflecting on this maybe it is better to keep kgdb_nmicallin()
> and kgdb_nmicallback() aligned w.r.t. return codes (even if they are a
> little unusual).
>
> I'm still not sure why we'd keep kgdb_ipi_nmicallback() though.
> kgdb_nmicallback() is intended to be called from arch code...
>

I added kgdb_ipi_nmicallback() just to add a check for "kgdb_active"
prior to entry into kgdb as here we are sharing NMI among backtrace
and kgdb.

But after your comments, I looked carefully into kgdb_nmicallback()
and I see the "raw_spin_is_locked(&dbg_master_lock)" check as well. So
it looked sufficient to me for calling kgdb_nmicallback() directly
from the arch code and hence I will remove kgdb_ipi_nmicallback() in
the next version.

>
> Daniel.
>
>
> >
> >
> > >  }
> > >
> > > diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> > > index 1a157ca3..c26e710 100644
> > > --- a/arch/arm64/kernel/kgdb.c
> > > +++ b/arch/arm64/kernel/kgdb.c
> > > @@ -17,6 +17,7 @@
> > >
> > >  #include <asm/debug-monitors.h>
> > >  #include <asm/insn.h>
> > > +#include <asm/nmi.h>
> > >  #include <asm/traps.h>
> > >
> > >  struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
> > > @@ -353,3 +354,37 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
> > >     return aarch64_insn_write((void *)bpt->bpt_addr,
> > >                     *(u32 *)bpt->saved_instr);
> > >  }
> > > +
> > > +bool kgdb_ipi_nmicallback(int cpu, void *regs)
> > > +{
> > > +   if (atomic_read(&kgdb_active) != -1) {
> > > +           kgdb_nmicallback(cpu, regs);
> > > +           return true;
> > > +   }
> > > +
> > > +   return false;
> > > +}
> >
> > I *really* don't like this function.
> >
> > If the return code of kgdb_nmicallback() is broken then fix it, don't
> > just wrap it and invent a new criteria for the return code.
> >
> > To be honest I don't actually think the logic in kgdb_nmicallback() is
> > broken. As mentioned above the return value has a weird definition (0
> > for "handled it OK" and 1 for "nothing for me to do") but the logic to
> > calculate the return code looks OK.
> >

Makes sense, will remove it instead.

> >
> > > +
> > > +static void kgdb_smp_callback(void *data)
> > > +{
> > > +   unsigned int cpu = smp_processor_id();
> > > +
> > > +   if (atomic_read(&kgdb_active) != -1)
> > > +           kgdb_nmicallback(cpu, get_irq_regs());
> > > +}
> >
> > This is Unused. I presume it is litter from a previous revision of the
> > code and can be deleted?
> >

Yeah.

> >
> > > +
> > > +bool kgdb_arch_roundup_cpus(void)
> > > +{
> > > +   struct cpumask mask;
> > > +
> > > +   if (!arm64_supports_nmi())
> > > +           return false;
> > > +
> > > +   cpumask_copy(&mask, cpu_online_mask);
> > > +   cpumask_clear_cpu(raw_smp_processor_id(), &mask);
> > > +   if (cpumask_empty(&mask))
> > > +           return false;
> >
> > Why do we need to fallback if there is no work to do? There will still
> > be no work to do when we call the fallback.

Okay, won't switch back to fallback mode here.

-Sumit

> >
> >
> > Daniel.
