Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33DE276C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgIXJAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIXJAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:00:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED89C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:00:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 94D5029B8B9
Subject: Re: [PATCH v3 16/16] ARM: Remove custom IRQ stat accounting
To:     Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kernelci-results@groups.io
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-17-maz@kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <aa8ff875-bee8-26f8-46b0-df579f2067a7@collabora.com>
Date:   Thu, 24 Sep 2020 10:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901144324.1071694-17-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 01/09/2020 15:43, Marc Zyngier wrote:
> Let's switch the arm code to the core accounting, which already
> does everything we need.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm/include/asm/hardirq.h | 17 -----------------
>  arch/arm/kernel/smp.c          | 20 ++++----------------
>  2 files changed, 4 insertions(+), 33 deletions(-)

This appears to be causing a NULL pointer dereference on
beaglebone-black, it got bisected automatically several times.
None of the other platforms in the KernelCI labs appears to be
affected.

Here's the error in the full job log, with next-20200923:

  https://storage.staging.kernelci.org/kernelci/staging.kernelci.org/staging-20200924.0/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beaglebone-black.html#L460

and some meta-data:

  https://staging.kernelci.org/test/case/id/5f6bea67f724eb1b34dce584/

The full bisection report is available here:

  https://groups.io/g/kernelci-results-staging/message/2094

I've also run it again with a debug build to locate the problem,
see below.


> diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
> index 7a88f160b1fb..b95848ed2bc7 100644
> --- a/arch/arm/include/asm/hardirq.h
> +++ b/arch/arm/include/asm/hardirq.h
> @@ -6,29 +6,12 @@
>  #include <linux/threads.h>
>  #include <asm/irq.h>
>  
> -/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
> -#define NR_IPI	7
> -
>  typedef struct {
>  	unsigned int __softirq_pending;
> -#ifdef CONFIG_SMP
> -	unsigned int ipi_irqs[NR_IPI];
> -#endif
>  } ____cacheline_aligned irq_cpustat_t;
>  
>  #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
>  
> -#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
> -#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
> -
> -#ifdef CONFIG_SMP
> -u64 smp_irq_stat_cpu(unsigned int cpu);
> -#else
> -#define smp_irq_stat_cpu(cpu)	0
> -#endif
> -
> -#define arch_irq_stat_cpu	smp_irq_stat_cpu
> -
>  #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
>  
>  #endif /* __ASM_HARDIRQ_H */
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index d51e64955a26..aead847ac8b9 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -65,6 +65,7 @@ enum ipi_msg_type {
>  	IPI_CPU_STOP,
>  	IPI_IRQ_WORK,
>  	IPI_COMPLETION,
> +	NR_IPI,
>  	/*
>  	 * CPU_BACKTRACE is special and not included in NR_IPI
>  	 * or tracable with trace_ipi_*
> @@ -529,27 +530,16 @@ void show_ipi_list(struct seq_file *p, int prec)
>  	unsigned int cpu, i;
>  
>  	for (i = 0; i < NR_IPI; i++) {
> +		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);

It looks like irq_desc_get_irq() gets called with a NULL
pointer (well, 0x0000001c):

(gdb) l *0xc030ef38
0xc030ef38 is in show_ipi_list (../include/linux/irqdesc.h:123).
118		return container_of(data->common, struct irq_desc, irq_common_data);
119	}
120	
121	static inline unsigned int irq_desc_get_irq(struct irq_desc *desc)
122	{
123		return desc->irq_data.irq;
124	}
125	
126	static inline struct irq_data *irq_desc_get_irq_data(struct irq_desc *desc)
127	{

Full job log: https://lava.baylibre.com/scheduler/job/142375#L727

I haven't looked any further but hopefully this should be a good
enough clue to find the root cause.  I don't know if you have a
platform at hand to reproduce the issue, please let me know if
you need some help with debugging or testing a fix.

Hope this helps,
Guillaume


>  		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
>  
>  		for_each_online_cpu(cpu)
> -			seq_printf(p, "%10u ",
> -				   __get_irq_stat(cpu, ipi_irqs[i]));
> +			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
>  
>  		seq_printf(p, " %s\n", ipi_types[i]);
>  	}
>  }
>  
> -u64 smp_irq_stat_cpu(unsigned int cpu)
> -{
> -	u64 sum = 0;
> -	int i;
> -
> -	for (i = 0; i < NR_IPI; i++)
> -		sum += __get_irq_stat(cpu, ipi_irqs[i]);
> -
> -	return sum;
> -}
> -
>  void arch_send_call_function_ipi_mask(const struct cpumask *mask)
>  {
>  	smp_cross_call(mask, IPI_CALL_FUNC);
> @@ -630,10 +620,8 @@ static void do_handle_IPI(int ipinr)
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> -	if ((unsigned)ipinr < NR_IPI) {
> +	if ((unsigned)ipinr < NR_IPI)
>  		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
> -		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
> -	}
>  
>  	switch (ipinr) {
>  	case IPI_WAKEUP:
> 

