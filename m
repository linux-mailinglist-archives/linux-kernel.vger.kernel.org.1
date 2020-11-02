Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED12A24B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 07:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgKBGTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 01:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKBGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 01:19:10 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB6C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 22:19:10 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 184so15892633lfd.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 22:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOizdv8Buv6FfQDjIz+DCkY2/qLkv4EBJXrU3sSnCWs=;
        b=yC26OzffaiSXuxD3Yv3sgbPJK3Y6JOG5O1docyb2L7i9Fusu3SZVvPjm1SFL6QmlQo
         gKg8kmbm+baIFlSZGvEojmKv/moocE3VvivuOLidCzkhuTl81R+xiTcW0wN9w4zUEyKk
         +NOg638xGq5V89dcOGjCepuD7f3H54SNnwkk0pvaXbSfBHPYlpDcU+2glYbbDnITAnRv
         dW8HjUa8iYuhhrd8V8NNa5vcffS0r6qI3yeFfQnJtGd/xuwDz66CsVIqzXt3COTZ/x+3
         lUsiJj8EzHi7IGwXAA2SqYvExzHB4sQ+MvmgCk9hJblZ3clBXKvK38cpazY5fXTxzPir
         yY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOizdv8Buv6FfQDjIz+DCkY2/qLkv4EBJXrU3sSnCWs=;
        b=jWm8TBXZel9bt4eOSe9NOJgKOe8YLwNwjL2Q4FVgF8b9kOdijcxy5C99VuKIOh8ny1
         hLZHo3U1DyYwxx5AowtBiaLePwq63vewWbRzHLm3Vh6Bp59frZsflIsr95VRV7ov4rMC
         q8gpLPZrcKJBPKVaQbhZFN2vw6OSVU5uYPS0U0FslyhrsHqw0m7vdWhO44GeL0yel8/z
         OuqpjMA5yXN71jmgzGSd3JCB3NgBrXHt0xUp+rzIV5pu+qns2D2qMjM1Ajm1rI0NvvU7
         1FfhEk6OnkPl9Dswo9fjEj6J51JFtvlCjx+sGU1mOrkhC0+QhUjX8nz3dqyelM14hCK1
         6JJA==
X-Gm-Message-State: AOAM530DN9lzKLJeeLG95aGpdACZ4bTayH0QDPqnvwsRTUqkYaL2q5es
        HaKmi1LLNTKGSVUNUbBk6XFIAlG4Qn87cmGreL92Kw==
X-Google-Smtp-Source: ABdhPJyKErojm2uwnAv6KZ5/QPOe9e59v8XvwLaZBI6MqngV7Fl1vO/+e/CfWbVp59RoX2NQQqTQh9W6XnQTuDGh3+I=
X-Received: by 2002:a19:e20f:: with SMTP id z15mr4551104lfg.273.1604297948806;
 Sun, 01 Nov 2020 22:19:08 -0800 (PST)
MIME-Version: 1.0
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
 <1603983387-8738-7-git-send-email-sumit.garg@linaro.org> <20201029152106.gj66mjnathsdqtoe@holly.lan>
In-Reply-To: <20201029152106.gj66mjnathsdqtoe@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 2 Nov 2020 11:48:53 +0530
Message-ID: <CAFA6WYOcCj=_G67QGN=8McHWvunoggN7tho9_VueH763U9K=_g@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] kgdb: roundup: Allow runtime arch specific override
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

On Thu, 29 Oct 2020 at 20:51, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Oct 29, 2020 at 08:26:26PM +0530, Sumit Garg wrote:
> > Add a new API kgdb_arch_roundup_cpus() for a particular archichecture to
> > override default kgdb roundup and if it detects at runtime to not support
> > NMI roundup then it can fallback to default implementation using async
> > SMP cross-calls.
> >
> > Currently such an architecture example is arm64 supporting pseudo NMIs
> > feature which is only available on platforms which have support for GICv3
> > or later version.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/powerpc/kernel/kgdb.c |  3 ++-
> >  arch/sparc/kernel/smp_64.c |  3 ++-
> >  arch/x86/kernel/kgdb.c     |  6 ++++--
> >  include/linux/kgdb.h       |  5 +++--
> >  kernel/debug/debug_core.c  | 10 +++++++++-
> >  5 files changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> > index 4090802..126575d 100644
> > --- a/arch/powerpc/kernel/kgdb.c
> > +++ b/arch/powerpc/kernel/kgdb.c
> > @@ -125,9 +125,10 @@ static int kgdb_debugger_ipi(struct pt_regs *regs)
> >  }
> >
> >  #ifdef CONFIG_SMP
> > -void kgdb_roundup_cpus(void)
> > +bool kgdb_arch_roundup_cpus(void)
> >  {
> >       smp_send_debugger_break();
> > +     return true;
> >  }
> >  #endif
> >
> > diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> > index e38d8bf..c459c83 100644
> > --- a/arch/sparc/kernel/smp_64.c
> > +++ b/arch/sparc/kernel/smp_64.c
> > @@ -1014,9 +1014,10 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
> >  }
> >
> >  #ifdef CONFIG_KGDB
> > -void kgdb_roundup_cpus(void)
> > +bool kgdb_arch_roundup_cpus(void)
> >  {
> >       smp_cross_call(&xcall_kgdb_capture, 0, 0, 0);
> > +     return true;
> >  }
> >  #endif
> >
> > diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> > index ff7878d..1b756d9 100644
> > --- a/arch/x86/kernel/kgdb.c
> > +++ b/arch/x86/kernel/kgdb.c
> > @@ -404,7 +404,8 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
> >
> >  #ifdef CONFIG_SMP
> >  /**
> > - *   kgdb_roundup_cpus - Get other CPUs into a holding pattern
> > + *   kgdb_arch_roundup_cpus - Get other CPUs into a holding pattern
> > + *                            in an architectural specific manner
> >   *
> >   *   On SMP systems, we need to get the attention of the other CPUs
> >   *   and get them be in a known state.  This should do what is needed
> > @@ -414,9 +415,10 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
> >   *
> >   *   On non-SMP systems, this is not called.
> >   */
> > -void kgdb_roundup_cpus(void)
> > +bool kgdb_arch_roundup_cpus(void)
> >  {
> >       apic_send_IPI_allbutself(NMI_VECTOR);
> > +     return true;
> >  }
> >  #endif
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 0d6cf64..f9db5b8 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -200,7 +200,8 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
> >  extern void kgdb_call_nmi_hook(void *ignored);
> >
> >  /**
> > - *   kgdb_roundup_cpus - Get other CPUs into a holding pattern
> > + *   kgdb_arch_roundup_cpus - Get other CPUs into a holding pattern
> > + *                            in an architectural specific manner
> >   *
> >   *   On SMP systems, we need to get the attention of the other CPUs
> >   *   and get them into a known state.  This should do what is needed
> > @@ -210,7 +211,7 @@ extern void kgdb_call_nmi_hook(void *ignored);
> >   *
> >   *   On non-SMP systems, this is not called.
> >   */
> > -extern void kgdb_roundup_cpus(void);
> > +extern bool kgdb_arch_roundup_cpus(void);
> >
> >  /**
> >   *   kgdb_arch_set_pc - Generic call back to the program counter
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 1e75a89..27e401c 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -241,13 +241,21 @@ void __weak kgdb_call_nmi_hook(void *ignored)
> >  }
> >  NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
> >
> > -void __weak kgdb_roundup_cpus(void)
> > +bool __weak kgdb_arch_roundup_cpus(void)
> > +{
> > +     return false;
>
> Do we really need to introduce all these boolean return values just to
> call a bit of library code when one of the architectures wants to
> fallback to a generic implementation?
>
> Why not something more like:
>
> void kgdb_smp_call_nmi_hook(void)
> {
>     /* original weak version of kgdb_roundup_cpus goes here */
> }
>
> void __weak kgdb_roundup_cpus(void)
> {
>     kgdb_smp_call_nmi_hook();
> }
>
> arm64 can now simply call the new library function if a fallback is needed.
>

Makes sense, I will use this approach instead.

> Note that same question applies to the backtrace changes...

In case of backtrace, there are already multiple APIs wrapping
arch_trigger_cpumask_backtrace() as follows:

- trigger_all_cpu_backtrace()
- trigger_allbutself_cpu_backtrace()
- trigger_cpumask_backtrace()
- trigger_single_cpu_backtrace()

And each of them already return a boolean and have corresponding
different fallback mechanisms. So we can't have a common fallback API
from arch specific code and instead need to extend that boolean return
to arch specific code that is implemented as part of patch #4.

If you do have any better ideas then do let me know.

-Sumit

>
>
> Daniel.
>
>
> > +}
> > +
> > +static void kgdb_roundup_cpus(void)
> >  {
> >       call_single_data_t *csd;
> >       int this_cpu = raw_smp_processor_id();
> >       int cpu;
> >       int ret;
> >
> > +     if (kgdb_arch_roundup_cpus())
> > +             return;
> > +
> >       for_each_online_cpu(cpu) {
> >               /* No need to roundup ourselves */
> >               if (cpu == this_cpu)
> > --
> > 2.7.4
> >
