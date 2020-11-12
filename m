Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604A62B08E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgKLPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:51:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728184AbgKLPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605196275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QL/CTH82iZSekxz8n80Vq7IhnT/Ojwm8sJF1/GEIh+M=;
        b=WoiAvrD2HLMHnt+HKj5p1htJaCfnqGooR98Jkj5woG5FLlo0iIeFrlYOpp1QrdDI03/fyz
        dWvH2HiB2nCCCRJ4cPRY7TGsLlOniTzKMuhAtZgoq9Socn/L+YFBAY9ALU5SiXBUFMGC3t
        3RCfdHOpQieqwh+vV7JJvEdk04vsH34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-OyrSxx9NNDaIyBWlvXMGGw-1; Thu, 12 Nov 2020 10:51:13 -0500
X-MC-Unique: OyrSxx9NNDaIyBWlvXMGGw-1
Received: by mail-wm1-f71.google.com with SMTP id o81so1905535wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QL/CTH82iZSekxz8n80Vq7IhnT/Ojwm8sJF1/GEIh+M=;
        b=uD0iCD3XW8VzGVaK+WuRWSuxkEZjK6doVpCwxn4WbWYvaFQlJwIVo4VKdh0oxRweAm
         BTaH4825an9DyYTulxGMZ1E3OT2+zr0W9qNl4/SLijJMJmRXlyF+7nxH9SrWoydjNRCN
         j+fMlaQwLRLB6KCQ4kG4FTMRdNV0gLIW+6wcfQwEGJSVzE7mOVN4Nf9qZFhAbF+rvPkt
         U6MX+wYjtpvDssYOkn3XXtqZCZ7e9QtervcQi+LQTd8vUw/eMa1WnKE61uWylBMpxbf4
         EeA+BhyBIjOMt0c0lerHFCBLNJXlrTwi4MYKDX8HrHG5nMC8H40B9uUkCIQvlabd5vQY
         NTJA==
X-Gm-Message-State: AOAM532/N3xrF/qo5FkOjS0mG8S3c3vTFbf9urd2I6EvD3WSnEu2O40H
        Xi2NP1uiBkbb6kEg/HM1P7CNIufcGUgWEk/iUadTwvuHvcTwrhWEagMPkU+AT6rP353QVaTQPBG
        onHxiYYkxssG4h/6ymZMa5SaN
X-Received: by 2002:adf:92e7:: with SMTP id 94mr150206wrn.271.1605196272241;
        Thu, 12 Nov 2020 07:51:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIkgCQ/CEFnm6mgolj9Md8yhKfvt/BSxAV3t4aQvN6BbPAwQHEcFa7uwCHjrI24Bq+wVN5dg==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr150145wrn.271.1605196271920;
        Thu, 12 Nov 2020 07:51:11 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a15sm7482066wrn.75.2020.11.12.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:51:11 -0800 (PST)
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
Subject: Re: [PATCH v2 08/17] x86/hyperv: handling hypercall page setup for
 root
In-Reply-To: <20201105165814.29233-9-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-9-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:51:09 +0100
Message-ID: <874kluy3o2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> When Linux is running as the root partition, the hypercall page will
> have already been setup by Hyper-V. Copy the content over to the
> allocated page.
>
> The suspend, resume and cleanup paths remain untouched because they are
> not supported in this setup yet.

What about adding BUG_ONs there then?

>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 73b0fb851f76..9fcaf741be99 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -25,6 +25,7 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <linux/highmem.h>
>  
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -438,8 +439,35 @@ void __init hyperv_init(void)
>  
>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	hypercall_msr.enable = 1;
> -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +
> +	if (hv_root_partition) {
> +		struct page *pg;
> +		void *src, *dst;
> +
> +		/*
> +		 * For the root partition, the hypervisor will set up its
> +		 * hypercall page. The hypervisor guarantees it will not show
> +		 * up in the root's address space. The root can't change the
> +		 * location of the hypercall page.
> +		 *
> +		 * Order is important here. We must enable the hypercall page
> +		 * so it is populated with code, then copy the code to an
> +		 * executable page.
> +		 */
> +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +
> +		pg = vmalloc_to_page(hv_hypercall_pg);
> +		dst = kmap(pg);
> +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
> +				MEMREMAP_WB);
> +		BUG_ON(!(src && dst));
> +		memcpy(dst, src, PAGE_SIZE);

Super-nit: while on x86 PAGE_SIZE always matches HV_HYP_PAGE_SIZE, would
it be more accurate to use the later here?

> +		memunmap(src);
> +		kunmap(pg);
> +	} else {
> +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	}
>  
>  	/*
>  	 * Ignore any errors in setting up stimer clockevents

-- 
Vitaly

