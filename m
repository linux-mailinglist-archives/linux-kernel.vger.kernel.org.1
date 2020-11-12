Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395922B087C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgKLPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbgKLPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605195354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kY0AiU5FU6oVbA1XAM3cZ9/C4ZQ8vxNIxYPcv88wzRE=;
        b=Oroe8ImBD3hkine5eJJdhlFnAf1huWVIfoPEc4QfO10kCptIY4quo5CFpd0PjlJq+R7EMn
        Mmx1ez3mgcfvRCXmZbZMk4ALLYvcJW1RHu6ObVGk9XeYzCxVJ8uSFf3fLfqLrh27ubhMvr
        S8orhWVlNrB9g3t83BrCU9vyYlwbg9Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-oP9_ShvENbiNErrPTynYjg-1; Thu, 12 Nov 2020 10:35:52 -0500
X-MC-Unique: oP9_ShvENbiNErrPTynYjg-1
Received: by mail-wr1-f71.google.com with SMTP id l5so2086358wrn.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kY0AiU5FU6oVbA1XAM3cZ9/C4ZQ8vxNIxYPcv88wzRE=;
        b=UqNXaRJ+vuwIYX/k9EafZS40FKHaSObMcW7JoysOaqma7DEBiENkWzHDonl5byXrqp
         EosxL2W1UtqrVPsMSxWbHJbQPC9I2CLnr9/Ow/VLq3cYGyiaK8Q92uif/99Vz1fYW4UR
         uBKr6pCeg5WvqrjrhWuuHLIqMPmCRshp/8NVUb/mQ3mlI64MF/pwdjiCKLhvcIJ4/vbj
         VGvC5BdlqV/twMCsfM4G7yxvCh5F086OgBMGcNqtPqnnTsja9tXiHWsQxF1cgkP5JhKf
         SgFwsvDzTpA4zlMK9h6R57ehyy1+M2NzZgL17An5285cG/2pLpEhmsgJmNgAAjV7VVvN
         xFuA==
X-Gm-Message-State: AOAM5303z6XsSjZOaDIJGGXlA6b+nB82xY9ouyqooGy3GAu/IRCehyTO
        POKVgiEIVECYHceJqrP0UvHSuPFzwYIKafxG+GSTBlJEmdUBNKs/tNIoiBkXoh/x7XEM0pV5Et9
        gSEj44wkIZ8+E7KdQQ7OHoPU6
X-Received: by 2002:a5d:5308:: with SMTP id e8mr60523wrv.299.1605195350613;
        Thu, 12 Nov 2020 07:35:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyX+g1Xxy4OaSz6R8CmLM779s2IPaL2uIDtQKDL0WAaJDiYdwAr+Qec54DwIygNSmyCPc/rjA==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr60496wrv.299.1605195350447;
        Thu, 12 Nov 2020 07:35:50 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 60sm4066744wrs.69.2020.11.12.07.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:35:49 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 06/17] x86/hyperv: allocate output arg pages if required
In-Reply-To: <20201105165814.29233-7-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-7-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:35:48 +0100
Message-ID: <87a6vmy4dn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> When Linux runs as the root partition, it will need to make hypercalls
> which return data from the hypervisor.
>
> Allocate pages for storing results when Linux runs as the root
> partition.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v2: Address Vitaly's comments
> ---
>  arch/x86/hyperv/hv_init.c       | 35 ++++++++++++++++++++++++++++-----
>  arch/x86/include/asm/mshyperv.h |  1 +
>  2 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 533fe9e887f2..7a2e37f025b0 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -45,6 +45,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>  void  __percpu **hyperv_pcpu_input_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  
> +void  __percpu **hyperv_pcpu_output_arg;
> +EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
> +
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> @@ -77,12 +80,19 @@ static int hv_cpu_init(unsigned int cpu)
>  	void **input_arg;
>  	struct page *pg;
>  
> -	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> +	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
>  	if (unlikely(!pg))
>  		return -ENOMEM;
> +
> +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	*input_arg = page_address(pg);
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = page_address(pg + 1);
> +	}
>  
>  	hv_get_vp_index(msr_vp_index);
>  
> @@ -209,14 +219,23 @@ static int hv_cpu_die(unsigned int cpu)
>  	unsigned int new_cpu;
>  	unsigned long flags;
>  	void **input_arg;
> -	void *input_pg = NULL;
> +	void *pg;
>  
>  	local_irq_save(flags);
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	input_pg = *input_arg;
> +	pg = *input_arg;
>  	*input_arg = NULL;
> +
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = NULL;
> +	}
> +
>  	local_irq_restore(flags);
> -	free_page((unsigned long)input_pg);
> +
> +	free_page((unsigned long)pg);
>  

Hm, but in case we've allocated output_arg, don't we need to do
	free_pages((unsigned long)pg, 1);

instead?

>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> @@ -350,6 +369,12 @@ void __init hyperv_init(void)
>  
>  	BUG_ON(hyperv_pcpu_input_arg == NULL);
>  
> +	/* Allocate the per-CPU state for output arg for root */
> +	if (hv_root_partition) {
> +		hyperv_pcpu_output_arg = alloc_percpu(void *);
> +		BUG_ON(hyperv_pcpu_output_arg == NULL);
> +	}
> +
>  	/* Allocate percpu VP index */
>  	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
>  				    GFP_KERNEL);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ac2b0d110f03..62d9390f1ddf 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -76,6 +76,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
> +extern void  __percpu  **hyperv_pcpu_output_arg;
>  
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {

-- 
Vitaly

