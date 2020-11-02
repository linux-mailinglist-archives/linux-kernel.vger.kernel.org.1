Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1422A2F9D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKBQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgKBQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:21:13 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F839C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:21:13 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id k9so11949694qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Lpr4CBLha20HQqxlhXNSA8BtMmymsEInJVoKBpe5r0=;
        b=jiNIyQ/3PFCSdLX6ugfJegoJfHHnVBTjhaw81/66xW0rZL3RjMbV7RgPF7572ECozM
         u2/cQEMXeCTptr+OQ+oJxCEy63cRiG3E6LfpGQ212ge6VOpQllkh28hXirv+8g34+2us
         bLi0V71XOcL50R2UO/mhjwp+RdwSG0LR5GoTAUdGQQNrvL1Yc/U8Y+s4UUFUD/7WdbiT
         pykwiXMb50V/bbCfK+oRW0FPHJRw8Mui/Iip2JfaXep/9CFqFyVDDrQs2iNJploIkFUK
         pX5iIJp5Kwk8Kk3nOyxVD2s+IApkGSfYp7pIDbDBqWjrM2138/jJjZLZbQTcDRU98K5L
         kBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Lpr4CBLha20HQqxlhXNSA8BtMmymsEInJVoKBpe5r0=;
        b=VFWm9YcfKVjB15lRd/riKvvHb3iitgA+wp01JJdMOwfsISYu+AYaeYKBb4IBsrBUX7
         Dxce9DL9d4i9UbMQOZut8WxaMxcwht+dBnYJk8RYf4ql7EhjEFYnbK0PgMNcg3C8IMsd
         7f662WMgA16KbZpcBX8T1CX2Po787in3g7nn73y4D0uEGDi3r3NBpnmhYCWHaJne0HT1
         L1IwSzmUltrFcnnD0mHQmw811lF0s6b8Q4eZGCXAPREs3DFyodA52R7KGg2bdgMF4qPI
         TMD7J/+uf5gxQuWTQ4GHJAWlwxhP9rF+fzc0pRxpifwAA24n5Np/MJF56nh/bmCUJbeU
         GvQw==
X-Gm-Message-State: AOAM530HFnIiMf9JlS0YjWy6zcA9UH9/uJZ4XECN5fvZGI38gouj3eLA
        WkvwxPywxE7oNUm8aZWYjw==
X-Google-Smtp-Source: ABdhPJwwOFt8TQzK9DM2mazQemEZvdOg6ct13ts4qWeveZlNnq65HE/KB2TcMcsxEQCiLV9ocByz1w==
X-Received: by 2002:a37:7104:: with SMTP id m4mr15673359qkc.252.1604334072928;
        Mon, 02 Nov 2020 08:21:12 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id t8sm8466845qtb.97.2020.11.02.08.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 08:21:12 -0800 (PST)
Date:   Mon, 2 Nov 2020 11:21:10 -0500
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
Subject: Re: [PATCH v7 5/7] arm64: ipi_nmi: Add support for NMI backtrace
Message-ID: <20201102162110.vmedu2g63yvdwh7m@gabell>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
 <1604317487-14543-6-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604317487-14543-6-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:14:45PM +0530, Sumit Garg wrote:
> Enable NMI backtrace support on arm64 using IPI turned as an NMI
> leveraging pseudo NMIs support. It is now possible for users to get a
> backtrace of a CPU stuck in hard-lockup using magic SYSRQ.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/include/asm/irq.h |  6 ++++++
>  arch/arm64/kernel/ipi_nmi.c  | 18 ++++++++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index b2b0c64..ef018a8 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -6,6 +6,12 @@
>  
>  #include <asm-generic/irq.h>
>  
> +#ifdef CONFIG_SMP
> +extern bool arch_trigger_cpumask_backtrace(const cpumask_t *mask,
> +					   bool exclude_self);
> +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> +#endif
> +
>  struct pt_regs;
>  
>  static inline int nr_legacy_irqs(void)
> diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> index a945dcf..597dcf7 100644
> --- a/arch/arm64/kernel/ipi_nmi.c
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/nmi.h>
>  #include <linux/smp.h>
>  
>  #include <asm/nmi.h>
> @@ -31,11 +32,24 @@ void arm64_send_nmi(cpumask_t *mask)
>  	__ipi_send_mask(ipi_nmi_desc, mask);
>  }
>  
> +bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> +{
> +	if (!ipi_nmi_desc)
> +		return false;
> +
> +	nmi_trigger_cpumask_backtrace(mask, exclude_self, arm64_send_nmi);
> +
> +	return true;
> +}
> +
>  static irqreturn_t ipi_nmi_handler(int irq, void *data)
>  {
> -	/* nop, NMI handlers for special features can be added here. */
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	if (nmi_cpu_backtrace(get_irq_regs()))
> +		ret = IRQ_HANDLED;
>  
> -	return IRQ_NONE;
> +	return ret;
>  }
>  
>  void dynamic_ipi_setup(int cpu)
> -- 

It works well with sysrq l trigger.
Please feel free to add:

	Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa
