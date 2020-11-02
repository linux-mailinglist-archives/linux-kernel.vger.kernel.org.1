Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1642A26D0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgKBJTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgKBJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:19:07 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B201C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 01:19:06 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n18so13653144wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 01:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lJEHmFBd3cbPOId3itPZgdyXvG8tbcQnOFRnmR4UTeM=;
        b=FplHk9O/3Aabvuq0TjN3j50JQhWdJC4NEcRFbKJD2Y129gdpW0LkBRrboK4kB8EMqU
         7CATJTqx6uwzh16XQT+EYIlFQS5Vlxlq27FU41zTXxMDj2Is7t5up4B88gOkNY5Ljk7N
         umYwxyT6zrolEnTdPSD+KDMbFK75DjJxrH7xdAcX7ZBr5sjdrno14/IuuUf5S7MHG6FJ
         +WBCkEddonUskiIhEM0aC2Wlf+HI9OWZ3tXAtFNpxZPqot0aOm8L0o7V8WkqgLlXoO3r
         WwGIKdws5nFZ5Nxq74lthS47tvfZV9fUOKVxxqoyipyNgIDcuvCG0vgmz6V4gGb+aoSf
         1FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lJEHmFBd3cbPOId3itPZgdyXvG8tbcQnOFRnmR4UTeM=;
        b=eBxoeNAZsC5bdnOKWGnYdVD8ntePWsMLyMK2K7aFAFn2bDkscWx8wlP8/y0AgHkaf2
         f/JD9+QzDw6rjRNE3cun3I2jxa1wpd4e6ylDXUdK7+OvsoZ41ugEvT2AKtSuC/3FfCuL
         IHccodWvGaNntzu6wzendcbqJsm8PIsP48xiTiaKqYVdVFaHUV/pl3DgzQtzu9doq6iN
         A3bnhVPHv/Vt+k7UArCFtuRWUoQXFr4vhogK5EGeGT2Xb/fGKaDPwtT/T1TCY+ee9Dfs
         o8gX5s8PiehWdrvIBpmclEEoG1eUNCCYvz0HxJiZpA6rvjJj1ls2Ag+9GxFw+GnbziPZ
         DJGA==
X-Gm-Message-State: AOAM5339QoNl5uZXrnxjrNmPpB1dcloJ76E9FbxRPRYVrVd/SHW6kXh3
        isP3AwpGhwGAsoAwLNIQQAiZTg==
X-Google-Smtp-Source: ABdhPJyT2/vlBNWplhw7RnadVnFPjUWs2R99EVOUZkdoO+TTy4Q7kTWiCScY9h/WA2u/o1tcM8BwOw==
X-Received: by 2002:a05:6000:3:: with SMTP id h3mr17931164wrx.215.1604308744638;
        Mon, 02 Nov 2020 01:19:04 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z19sm3725087wmk.12.2020.11.02.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:19:03 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:19:01 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
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
Subject: Re: [PATCH v6 6/7] kgdb: roundup: Allow runtime arch specific
 override
Message-ID: <20201102091901.fkxdp2wyiycdhtjm@holly.lan>
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
 <1603983387-8738-7-git-send-email-sumit.garg@linaro.org>
 <20201029152106.gj66mjnathsdqtoe@holly.lan>
 <CAFA6WYOcCj=_G67QGN=8McHWvunoggN7tho9_VueH763U9K=_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOcCj=_G67QGN=8McHWvunoggN7tho9_VueH763U9K=_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 11:48:53AM +0530, Sumit Garg wrote:
> On Thu, 29 Oct 2020 at 20:51, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Thu, Oct 29, 2020 at 08:26:26PM +0530, Sumit Garg wrote:
> > > Add a new API kgdb_arch_roundup_cpus() for a particular archichecture to
> > > override default kgdb roundup and if it detects at runtime to not support
> > > NMI roundup then it can fallback to default implementation using async
> > > SMP cross-calls.
> > >
> > > Currently such an architecture example is arm64 supporting pseudo NMIs
> > > feature which is only available on platforms which have support for GICv3
> > > or later version.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  arch/powerpc/kernel/kgdb.c |  3 ++-
> > >  arch/sparc/kernel/smp_64.c |  3 ++-
> > >  arch/x86/kernel/kgdb.c     |  6 ++++--
> > >  include/linux/kgdb.h       |  5 +++--
> > >  kernel/debug/debug_core.c  | 10 +++++++++-
> > >  5 files changed, 20 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> > > index 4090802..126575d 100644
> > > --- a/arch/powerpc/kernel/kgdb.c
> > > +++ b/arch/powerpc/kernel/kgdb.c
> > > @@ -125,9 +125,10 @@ static int kgdb_debugger_ipi(struct pt_regs *regs)
> > >  }
> > >
> > >  #ifdef CONFIG_SMP
> > > -void kgdb_roundup_cpus(void)
> > > +bool kgdb_arch_roundup_cpus(void)
> > >  {
> > >       smp_send_debugger_break();
> > > +     return true;
> > >  }
> > >  #endif
> > >
> > > diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> > > index e38d8bf..c459c83 100644
> > > --- a/arch/sparc/kernel/smp_64.c
> > > +++ b/arch/sparc/kernel/smp_64.c
> > > @@ -1014,9 +1014,10 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
> > >  }
> > >
> > >  #ifdef CONFIG_KGDB
> > > -void kgdb_roundup_cpus(void)
> > > +bool kgdb_arch_roundup_cpus(void)
> > >  {
> > >       smp_cross_call(&xcall_kgdb_capture, 0, 0, 0);
> > > +     return true;
> > >  }
> > >  #endif
> > >
> > > diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> > > index ff7878d..1b756d9 100644
> > > --- a/arch/x86/kernel/kgdb.c
> > > +++ b/arch/x86/kernel/kgdb.c
> > > @@ -404,7 +404,8 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
> > >
> > >  #ifdef CONFIG_SMP
> > >  /**
> > > - *   kgdb_roundup_cpus - Get other CPUs into a holding pattern
> > > + *   kgdb_arch_roundup_cpus - Get other CPUs into a holding pattern
> > > + *                            in an architectural specific manner
> > >   *
> > >   *   On SMP systems, we need to get the attention of the other CPUs
> > >   *   and get them be in a known state.  This should do what is needed
> > > @@ -414,9 +415,10 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
> > >   *
> > >   *   On non-SMP systems, this is not called.
> > >   */
> > > -void kgdb_roundup_cpus(void)
> > > +bool kgdb_arch_roundup_cpus(void)
> > >  {
> > >       apic_send_IPI_allbutself(NMI_VECTOR);
> > > +     return true;
> > >  }
> > >  #endif
> > >
> > > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > > index 0d6cf64..f9db5b8 100644
> > > --- a/include/linux/kgdb.h
> > > +++ b/include/linux/kgdb.h
> > > @@ -200,7 +200,8 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
> > >  extern void kgdb_call_nmi_hook(void *ignored);
> > >
> > >  /**
> > > - *   kgdb_roundup_cpus - Get other CPUs into a holding pattern
> > > + *   kgdb_arch_roundup_cpus - Get other CPUs into a holding pattern
> > > + *                            in an architectural specific manner
> > >   *
> > >   *   On SMP systems, we need to get the attention of the other CPUs
> > >   *   and get them into a known state.  This should do what is needed
> > > @@ -210,7 +211,7 @@ extern void kgdb_call_nmi_hook(void *ignored);
> > >   *
> > >   *   On non-SMP systems, this is not called.
> > >   */
> > > -extern void kgdb_roundup_cpus(void);
> > > +extern bool kgdb_arch_roundup_cpus(void);
> > >
> > >  /**
> > >   *   kgdb_arch_set_pc - Generic call back to the program counter
> > > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > > index 1e75a89..27e401c 100644
> > > --- a/kernel/debug/debug_core.c
> > > +++ b/kernel/debug/debug_core.c
> > > @@ -241,13 +241,21 @@ void __weak kgdb_call_nmi_hook(void *ignored)
> > >  }
> > >  NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
> > >
> > > -void __weak kgdb_roundup_cpus(void)
> > > +bool __weak kgdb_arch_roundup_cpus(void)
> > > +{
> > > +     return false;
> >
> > Do we really need to introduce all these boolean return values just to
> > call a bit of library code when one of the architectures wants to
> > fallback to a generic implementation?
> >
> > Why not something more like:
> >
> > void kgdb_smp_call_nmi_hook(void)
> > {
> >     /* original weak version of kgdb_roundup_cpus goes here */
> > }
> >
> > void __weak kgdb_roundup_cpus(void)
> > {
> >     kgdb_smp_call_nmi_hook();
> > }
> >
> > arm64 can now simply call the new library function if a fallback is needed.
> >
> 
> Makes sense, I will use this approach instead.
> 
> > Note that same question applies to the backtrace changes...
> 
> In case of backtrace, there are already multiple APIs wrapping
> arch_trigger_cpumask_backtrace() as follows:
> 
> - trigger_all_cpu_backtrace()
> - trigger_allbutself_cpu_backtrace()
> - trigger_cpumask_backtrace()
> - trigger_single_cpu_backtrace()
> 
> And each of them already return a boolean and have corresponding
> different fallback mechanisms. So we can't have a common fallback API
> from arch specific code and instead need to extend that boolean return
> to arch specific code that is implemented as part of patch #4.

Understood. Thanks.


Daniel.
