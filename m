Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55C29F1B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgJ2Qj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgJ2Qj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:39:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE46CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:39:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a72so440743wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/X0z9D5StzrR2gJv46EfC2VHnTfH4ML+qlpUJ/1iF+I=;
        b=DmLKqeKyk0dqGc6t7dPQVA0wlU3ut9WP5Rh3yL4ePCErzgdlGOIuiBAVWy6JE02iO8
         qmZz6QNdCCV6XoAl2wE00TWDN6gmpfTQFRyYFg5NfjZrx+2pA4hevSRi9C77jyGcxpNX
         EdzsLd2OkS7pXMGPsSBQAJUDczyBgJfq4oEDXYULZGP+D81NE8g3x7DgNMUe0MBgVy9r
         XJ7ay86U/4IeAevtZ9dW1JZK4z0s39CGt06HXG+JxTcOieqcQoek+pC5S+ZuCj80RdFg
         lGNZMD5d/iJpmwFM3fn6CJduPDJEFZgmzrKSq1sIg93bD+iCs20yNHBcYYdvNAfqM7vX
         mvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/X0z9D5StzrR2gJv46EfC2VHnTfH4ML+qlpUJ/1iF+I=;
        b=MhD4Bamdt80fZrJYux/9AJWZDAiLWvrhqbCnOYbNGX3ne40QZjwxYSX8k7shcF0kuc
         88S9T3YyKY++82IiSdG8d1XRYKL6bVmPUYu/azQHreN5rsEjGyEq/UnKgBrWH6EZ/Ee6
         Gydm0Jsz3sNZ2NbsKnmQE0jsFhSKVeoWnhVup6k3K7HBuY9SixXjnX376tXX5lXeGrsP
         GUNaMRUO0UGydVww6UgS8xYvRSGQaG1tb96iMJ35BCassQSjWjCOKWOB3v0n0RpKdqlq
         +FbPM2dTyw4wtt2S8t6frQ1ptmMzLhaHyQtp25CbidJFCD4h8E6RKZ/+Gy55zhxRnPIo
         sRAA==
X-Gm-Message-State: AOAM531JU6epFj7N3KaaXERI9BqnyiKEwqrzOiHhCQbUb6YObLSHCUGI
        /caMxZzBhnWVvCqRZN05txlh9w==
X-Google-Smtp-Source: ABdhPJz8+N82idWXZIRdsSVKS2zkCkaLcMs+xln99ZpAybHKOEuFmSsokWfjx79UtnD64dnI0P9hEA==
X-Received: by 2002:a1c:3c44:: with SMTP id j65mr756676wma.13.1603989564464;
        Thu, 29 Oct 2020 09:39:24 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z6sm607926wmi.1.2020.10.29.09.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:39:23 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:39:21 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/7] arm64: kgdb: Roundup cpus using IPI as NMI
Message-ID: <20201029163921.dibail374cwwonvo@holly.lan>
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
 <1603983387-8738-8-git-send-email-sumit.garg@linaro.org>
 <20201029162234.a5czyjy4eyto6aa4@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029162234.a5czyjy4eyto6aa4@holly.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 04:22:34PM +0000, Daniel Thompson wrote:
> On Thu, Oct 29, 2020 at 08:26:27PM +0530, Sumit Garg wrote:
> > arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> > leveraged to roundup CPUs which are stuck in hard lockup state with
> > interrupts disabled that wouldn't be possible with a normal IPI.
> > 
> > So instead switch to roundup CPUs using IPI turned as NMI. And in
> > case a particular arm64 platform doesn't supports pseudo NMIs,
> > it will switch back to default kgdb CPUs roundup mechanism.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/include/asm/kgdb.h |  9 +++++++++
> >  arch/arm64/kernel/ipi_nmi.c   |  5 +++++
> >  arch/arm64/kernel/kgdb.c      | 35 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 49 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
> > index 21fc85e..c3d2425 100644
> > --- a/arch/arm64/include/asm/kgdb.h
> > +++ b/arch/arm64/include/asm/kgdb.h
> > @@ -24,6 +24,15 @@ static inline void arch_kgdb_breakpoint(void)
> >  extern void kgdb_handle_bus_error(void);
> >  extern int kgdb_fault_expected;
> >  
> > +#ifdef CONFIG_KGDB
> > +extern bool kgdb_ipi_nmicallback(int cpu, void *regs);
> > +#else
> > +static inline bool kgdb_ipi_nmicallback(int cpu, void *regs)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  #endif /* !__ASSEMBLY__ */
> >  
> >  /*
> > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> > index 597dcf7..6ace182 100644
> > --- a/arch/arm64/kernel/ipi_nmi.c
> > +++ b/arch/arm64/kernel/ipi_nmi.c
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > +#include <linux/kgdb.h>
> >  #include <linux/nmi.h>
> >  #include <linux/smp.h>
> >  
> > @@ -45,10 +46,14 @@ bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> >  static irqreturn_t ipi_nmi_handler(int irq, void *data)
> >  {
> >  	irqreturn_t ret = IRQ_NONE;
> > +	unsigned int cpu = smp_processor_id();
> >  
> >  	if (nmi_cpu_backtrace(get_irq_regs()))
> >  		ret = IRQ_HANDLED;
> >  
> > +	if (kgdb_ipi_nmicallback(cpu, get_irq_regs()))
> > +		ret = IRQ_HANDLED;
> > +
> >  	return ret;
> 
> It would be better to declare existing return value for
> kgdb_nmicallback() to be dangerously stupid and fix it so it returns an
> irqreturn_t (that's easy since most callers do not need to check the
> return value).
> 
> Then this code simply becomes:
> 
> 	return kgdb_nmicallback(cpu, get_irq_regs());

Actually, reflecting on this maybe it is better to keep kgdb_nmicallin()
and kgdb_nmicallback() aligned w.r.t. return codes (even if they are a
little unusual).

I'm still not sure why we'd keep kgdb_ipi_nmicallback() though.
kgdb_nmicallback() is intended to be called from arch code...


Daniel.


> 
> 
> >  }
> >  
> > diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> > index 1a157ca3..c26e710 100644
> > --- a/arch/arm64/kernel/kgdb.c
> > +++ b/arch/arm64/kernel/kgdb.c
> > @@ -17,6 +17,7 @@
> >  
> >  #include <asm/debug-monitors.h>
> >  #include <asm/insn.h>
> > +#include <asm/nmi.h>
> >  #include <asm/traps.h>
> >  
> >  struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
> > @@ -353,3 +354,37 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
> >  	return aarch64_insn_write((void *)bpt->bpt_addr,
> >  			*(u32 *)bpt->saved_instr);
> >  }
> > +
> > +bool kgdb_ipi_nmicallback(int cpu, void *regs)
> > +{
> > +	if (atomic_read(&kgdb_active) != -1) {
> > +		kgdb_nmicallback(cpu, regs);
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> 
> I *really* don't like this function.
> 
> If the return code of kgdb_nmicallback() is broken then fix it, don't
> just wrap it and invent a new criteria for the return code.
> 
> To be honest I don't actually think the logic in kgdb_nmicallback() is
> broken. As mentioned above the return value has a weird definition (0
> for "handled it OK" and 1 for "nothing for me to do") but the logic to
> calculate the return code looks OK.
> 
> 
> > +
> > +static void kgdb_smp_callback(void *data)
> > +{
> > +	unsigned int cpu = smp_processor_id();
> > +
> > +	if (atomic_read(&kgdb_active) != -1)
> > +		kgdb_nmicallback(cpu, get_irq_regs());
> > +}
> 
> This is Unused. I presume it is litter from a previous revision of the
> code and can be deleted?
> 
> 
> > +
> > +bool kgdb_arch_roundup_cpus(void)
> > +{
> > +	struct cpumask mask;
> > +
> > +	if (!arm64_supports_nmi())
> > +		return false;
> > +
> > +	cpumask_copy(&mask, cpu_online_mask);
> > +	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
> > +	if (cpumask_empty(&mask))
> > +		return false;
> 
> Why do we need to fallback if there is no work to do? There will still
> be no work to do when we call the fallback.
> 
> 
> Daniel.
