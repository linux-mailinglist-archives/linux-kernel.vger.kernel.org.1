Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3A28E9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgJOBRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbgJOBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:17:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDD8C045708
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:17:38 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j8so2275092ilk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gRUP5okLmkN2g8HT3wDw7jtbqT5ZCqE5twgUzt6/004=;
        b=Axt5o00Pp6mgZRePuxQ5jTc1tIKAoWXVLza1VeaVWSk6EHkD9m3LvdYCBhVdhLLgoB
         EQRKLb094zduDRN9Wgbho3j6WZQDmrKDR7znzAacxGZQxfgFDC0HAzPe8hwst1K0uiLT
         MJVf9n3dWZ0RalrPKjJj/UZkTZ+8406R/J3fLX5ybJUNt+xLfuyN1t4YZe3JntgAuiB2
         FipSBtW0NeTqwAgrpMsn3HBEbu47epCFqA+lT0fkyRsFFdEC2PtJIWJRjEb1va8tDGCK
         AwQUbhWsIw9nEef0g5BPYmAf6qPLpwcG91sq19Erz9RfJL6FcUJpH+0DHCFGq6vGs2re
         nwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gRUP5okLmkN2g8HT3wDw7jtbqT5ZCqE5twgUzt6/004=;
        b=K17W/aq8mpGoRzbsa64xTPwpqsPWiPOQ+ntuZ/gHxJqhXjm7l9OnHFyweUwTqcRieQ
         39a7UlsB47g2pqE7yVEY9WDAVuoWaMgGdvHUjeSCGkgECkegnw/WUJFhZghWMxXhzrKo
         q/CDlspsl+eloArB3keuql5KmFMwN6ECSy4noEOS/rFSs372h2tsdZmGuV6YkgCh9ReA
         qwlhuKS0HwdxxuiItHpI4ODN5LMbsnlQX1+vZPP4DT8YE+O/Tq3+oPQBQFUfJ4957rmj
         2ME9cHbfCse+i6mzlB8yGME9LZ5DGu8Kc09GurhwNtEp+aPZPjbc3YhpEFVH9fm2tch+
         sN2A==
X-Gm-Message-State: AOAM530MK45u+yRd38AY43sr+RIM+MZFbBbewYlDMO+bpgpPNGnU5ZtB
        FUmCJcB8Mc3aLcuijv9Vi3+l7hjn6w==
X-Google-Smtp-Source: ABdhPJwmPHN+xkaMEX00WKdHeJam3q4KuADGTGUWoOIWFo6TRZqa0MG79tQKSWB3WJHYAYtmTO/owA==
X-Received: by 2002:a92:ca92:: with SMTP id t18mr1413551ilo.287.1602724657601;
        Wed, 14 Oct 2020 18:17:37 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id o17sm1148985ila.47.2020.10.14.18.17.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Oct 2020 18:17:33 -0700 (PDT)
Date:   Wed, 14 Oct 2020 21:17:30 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] arm64: ipi_nmi: Add support for NMI backtrace
Message-ID: <20201015011730.mbhbxr2zgjfe2zen@gabell>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-6-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602673931-28782-6-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:42:11PM +0530, Sumit Garg wrote:
> Enable NMI backtrace support on arm64 using IPI turned as an NMI
> leveraging pseudo NMIs support. It is now possible for users to get a
> backtrace of a CPU stuck in hard-lockup using magic SYSRQ.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/include/asm/irq.h |  6 ++++++
>  arch/arm64/kernel/ipi_nmi.c  | 12 +++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index b2b0c64..e840bf1 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -6,6 +6,12 @@
>  
>  #include <asm-generic/irq.h>
>  
> +#ifdef CONFIG_SMP
> +extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
> +					   bool exclude_self);
> +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> +#endif
> +
>  struct pt_regs;
>  
>  static inline int nr_legacy_irqs(void)
> diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> index e0a9e03..e1dc19d 100644
> --- a/arch/arm64/kernel/ipi_nmi.c
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kgdb.h>
> +#include <linux/nmi.h>
>  #include <linux/smp.h>
>  
>  #include <asm/nmi.h>
> @@ -25,12 +26,21 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask)
>  	__ipi_send_mask(ipi_desc, mask);
>  }
>  
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> +{
> +	nmi_trigger_cpumask_backtrace(mask, exclude_self,
> +				      arch_send_call_nmi_func_ipi_mask);
> +}
> +
>  static irqreturn_t ipi_nmi_handler(int irq, void *data)
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> -	ipi_kgdb_nmicallback(cpu, get_irq_regs());
> +	if (nmi_cpu_backtrace(get_irq_regs()))
> +		goto out;
>  
> +	ipi_kgdb_nmicallback(cpu, get_irq_regs());
> +out:
>  	return IRQ_HANDLED;
>  }
>  
> -- 

It works well. Please feel free to add:

        Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa
