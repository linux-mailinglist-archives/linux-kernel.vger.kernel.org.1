Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE22A2F8C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgKBQTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKBQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:19:12 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CC4C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:19:12 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id x20so11969299qkn.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0pEoN6nA2G5BwCWY5vt/4u6N5GAY+FHaERnVlmnWlFc=;
        b=ids55hsOUjO+6VoaZMpKbVpzBQuFZC5w5OP9fvCm26FtQUSlg1oYAQn422GCTSEuEz
         k8kDHldTdzq9aQ2bVpClvpY66jgz5jY1pmlieeryNEOSlEW3VPi5Kx1lSJGqKm2FAHP6
         GRAS04E0lisWteoPc9/HqspO+Z1Zq8hp6donW4pPpuSuEZJ7hSPRkKE+yhum9I0Cowmu
         U+zVWfYdkANcgFGNrrZIT1rcbbAsiLAyb7wGJpdPF/xy5PkagbT1VNoU+/xrPUBiM/Rm
         uV0WXNsuDmQvowgnMIl5xFbJQRwhIzdrzVO2cFxad7/+Gu57osydu5/NR9P1nP7dmhfw
         3efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0pEoN6nA2G5BwCWY5vt/4u6N5GAY+FHaERnVlmnWlFc=;
        b=FpMr6iPhyw19oG0dhuffH4XzmzouCRq8UHQdT/nSygp5XV0oyl8ClLT5uDJNoztP+S
         y4u59pOGllBAP37FJ540d3Q9cy95lWkM+jVwQmNCv0ZQUqUje3ZN/3E2Y+oj68xLY/02
         qGBrP/gumxxJvjm+csvbRHCwaY5ZCtVtsTa6Q/JXFARLCE/D32tCsqeXeJ49vJFQ7rkJ
         v/rnX/NxB48QnIwhyWtxfEKzglMWyFkHJdXiaWGOjRuOfRVy61gT7j78babKQcnVix7i
         MI3sd8YNcn8m7Xih6fBn0O46MEMX7BeDxvqZ78hEtNVM7vc13gVUD1ITGBjH8vy0YFIH
         +Vfg==
X-Gm-Message-State: AOAM531STiFaVH0Ql/CgYHh1Z46/cevZtBQhMHBINjM1z5GymD2g/I/F
        bsCAJYkIGvj4NgZis01ZVg==
X-Google-Smtp-Source: ABdhPJw3/h/FxAUapjnE6hrGy28Ybn8PhKKPWyeveHzA/4XbaQbjZSNBF3IMSL5R1XYdsJoz3PG1wA==
X-Received: by 2002:a37:7f03:: with SMTP id a3mr15397645qkd.72.1604333951668;
        Mon, 02 Nov 2020 08:19:11 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id r14sm5203206qtu.25.2020.11.02.08.19.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 08:19:11 -0800 (PST)
Date:   Mon, 2 Nov 2020 11:19:08 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        daniel.thompson@linaro.org, linux-arm-kernel@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, jason.wessel@windriver.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] arm64: smp: Assign and setup an IPI as NMI
Message-ID: <20201102161908.ayn7vff7tyduzlj2@gabell>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
 <1604317487-14543-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604317487-14543-4-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:14:43PM +0530, Sumit Garg wrote:
> Assign an unused IPI which can be turned as NMI using ipi_nmi framework.
> Also, invoke corresponding dynamic IPI setup/teardown APIs.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 82e75fc..2e118e2 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -43,6 +43,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/mmu_context.h>
> +#include <asm/nmi.h>
>  #include <asm/numa.h>
>  #include <asm/processor.h>
>  #include <asm/smp_plat.h>
> @@ -962,6 +963,8 @@ static void ipi_setup(int cpu)
>  
>  	for (i = 0; i < nr_ipi; i++)
>  		enable_percpu_irq(ipi_irq_base + i, 0);
> +
> +	dynamic_ipi_setup(cpu);
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -974,6 +977,8 @@ static void ipi_teardown(int cpu)
>  
>  	for (i = 0; i < nr_ipi; i++)
>  		disable_percpu_irq(ipi_irq_base + i);
> +
> +	dynamic_ipi_teardown(cpu);
>  }
>  #endif
>  
> @@ -995,6 +1000,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>  		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
>  	}
>  
> +	if (n > nr_ipi)
> +		set_smp_dynamic_ipi(ipi_base + nr_ipi);
> +
>  	ipi_irq_base = ipi_base;
>  
>  	/* Setup the boot CPU immediately */
> -- 

Looks good to me. Please feel free to add:

	Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa
