Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3400F29EFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgJ2PbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgJ2Pa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:30:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF911C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:21:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d3so219214wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JzHSvmUsV227fQsl4wNt959KTE87kP0KBA8sqcTaQtk=;
        b=ZPvsMX4nw+ff9jknDVrXMuSq3+wAcoKuseGW3S3Y8U2WIl6JkRHjo46QxE4y1FJ+W9
         mwZO4IGK1lo4Kw8dQIBwqtGcnkLb8xuCEWJBn0uszViOY7bQgtKAMB7kwsi8Vup8z4Ks
         Ss4Kvb7pD5g6wwYPyRo5mjVaIQGibcQjI0hmIlku2TnbOvcVNZuM8CC9kwfKJrprBl0P
         jKDbv+agSdPALk3umxC0GE4YpgXO1la4jpyCk4P0q5KCIa/VLylDlEMD4oG/TlP1zaqI
         zHXNSdSWc9HI5yLac98t8PDDAmrp6SEBTW83IZZpYLiba3x8YNKA9/hmg5h3IfgNGfK+
         QkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JzHSvmUsV227fQsl4wNt959KTE87kP0KBA8sqcTaQtk=;
        b=oHS7O+1rCznxNrxLM1HckV5QAawhpvkA4PBeKMzx4ypXRJJ3CNO4s9ZuSGpoJRdqbB
         6LQTFDNM+aeBG1QXsYeICdhrk+IWhK3EAJHIoGpkNfElDC9QiKAXjShTspt/JFjN9516
         c6K5NTG4mJWdG+odidSqaeuQ8NIV2H4g76i6Fmcjru2B5ajQWZ5p82UWi0XNiNUQJ0CM
         Jo9m30TjEZru5J0395/rDLcgxWogURD3GjQ3oNDl61BLePHbKXVJHxKGI2Pm50FKUT2i
         CKmhb8pNcq7kE1Z6S1zWd+JpSzamYxGEnr1re189IH9GepUNoB4BIdjxz+cnD61dBUUn
         O6zQ==
X-Gm-Message-State: AOAM530Ip94gCySChRLal1V2wIX5rOxQ+eTVjxe4//QTUG7pAzzbDdPj
        Kux14UVX2WgjoENgtdnHF3+7MA==
X-Google-Smtp-Source: ABdhPJx1p2SY/MipkhW/f0dmQ/6HAtDeZEqTbAFlKHZreX2asO0rDbAzZbcJTZL6uueIabM80cxCkA==
X-Received: by 2002:a1c:3c44:: with SMTP id j65mr356319wma.13.1603984869372;
        Thu, 29 Oct 2020 08:21:09 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l1sm6546244wrb.1.2020.10.29.08.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:21:08 -0700 (PDT)
Date:   Thu, 29 Oct 2020 15:21:06 +0000
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
Subject: Re: [PATCH v6 6/7] kgdb: roundup: Allow runtime arch specific
 override
Message-ID: <20201029152106.gj66mjnathsdqtoe@holly.lan>
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
 <1603983387-8738-7-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603983387-8738-7-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 08:26:26PM +0530, Sumit Garg wrote:
> Add a new API kgdb_arch_roundup_cpus() for a particular archichecture to
> override default kgdb roundup and if it detects at runtime to not support
> NMI roundup then it can fallback to default implementation using async
> SMP cross-calls.
> 
> Currently such an architecture example is arm64 supporting pseudo NMIs
> feature which is only available on platforms which have support for GICv3
> or later version.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/powerpc/kernel/kgdb.c |  3 ++-
>  arch/sparc/kernel/smp_64.c |  3 ++-
>  arch/x86/kernel/kgdb.c     |  6 ++++--
>  include/linux/kgdb.h       |  5 +++--
>  kernel/debug/debug_core.c  | 10 +++++++++-
>  5 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 4090802..126575d 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -125,9 +125,10 @@ static int kgdb_debugger_ipi(struct pt_regs *regs)
>  }
>  
>  #ifdef CONFIG_SMP
> -void kgdb_roundup_cpus(void)
> +bool kgdb_arch_roundup_cpus(void)
>  {
>  	smp_send_debugger_break();
> +	return true;
>  }
>  #endif
>  
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index e38d8bf..c459c83 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -1014,9 +1014,10 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>  }
>  
>  #ifdef CONFIG_KGDB
> -void kgdb_roundup_cpus(void)
> +bool kgdb_arch_roundup_cpus(void)
>  {
>  	smp_cross_call(&xcall_kgdb_capture, 0, 0, 0);
> +	return true;
>  }
>  #endif
>  
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index ff7878d..1b756d9 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -404,7 +404,8 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
>  
>  #ifdef CONFIG_SMP
>  /**
> - *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
> + *	kgdb_arch_roundup_cpus - Get other CPUs into a holding pattern
> + *				 in an architectural specific manner
>   *
>   *	On SMP systems, we need to get the attention of the other CPUs
>   *	and get them be in a known state.  This should do what is needed
> @@ -414,9 +415,10 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
>   *
>   *	On non-SMP systems, this is not called.
>   */
> -void kgdb_roundup_cpus(void)
> +bool kgdb_arch_roundup_cpus(void)
>  {
>  	apic_send_IPI_allbutself(NMI_VECTOR);
> +	return true;
>  }
>  #endif
>  
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 0d6cf64..f9db5b8 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -200,7 +200,8 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
>  extern void kgdb_call_nmi_hook(void *ignored);
>  
>  /**
> - *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
> + *	kgdb_arch_roundup_cpus - Get other CPUs into a holding pattern
> + *				 in an architectural specific manner
>   *
>   *	On SMP systems, we need to get the attention of the other CPUs
>   *	and get them into a known state.  This should do what is needed
> @@ -210,7 +211,7 @@ extern void kgdb_call_nmi_hook(void *ignored);
>   *
>   *	On non-SMP systems, this is not called.
>   */
> -extern void kgdb_roundup_cpus(void);
> +extern bool kgdb_arch_roundup_cpus(void);
>  
>  /**
>   *	kgdb_arch_set_pc - Generic call back to the program counter
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 1e75a89..27e401c 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -241,13 +241,21 @@ void __weak kgdb_call_nmi_hook(void *ignored)
>  }
>  NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
>  
> -void __weak kgdb_roundup_cpus(void)
> +bool __weak kgdb_arch_roundup_cpus(void)
> +{
> +	return false;

Do we really need to introduce all these boolean return values just to
call a bit of library code when one of the architectures wants to
fallback to a generic implementation?

Why not something more like:

void kgdb_smp_call_nmi_hook(void)
{
    /* original weak version of kgdb_roundup_cpus goes here */
}

void __weak kgdb_roundup_cpus(void)
{
    kgdb_smp_call_nmi_hook();
}

arm64 can now simply call the new library function if a fallback is needed. 

Note that same question applies to the backtrace changes...


Daniel.


> +}
> +
> +static void kgdb_roundup_cpus(void)
>  {
>  	call_single_data_t *csd;
>  	int this_cpu = raw_smp_processor_id();
>  	int cpu;
>  	int ret;
>  
> +	if (kgdb_arch_roundup_cpus())
> +		return;
> +
>  	for_each_online_cpu(cpu) {
>  		/* No need to roundup ourselves */
>  		if (cpu == this_cpu)
> -- 
> 2.7.4
> 
