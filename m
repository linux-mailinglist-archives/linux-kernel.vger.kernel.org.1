Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91DF272658
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgIUNzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUNzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:55:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2492084C;
        Mon, 21 Sep 2020 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600696516;
        bh=giup4Dg5WhpWJ857PpfPZHU63m06kkHcvu6+1h1OTGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7krJPdjhg+bDMgb1GVhKtpKbKGCt2WMKioDi8bjOQhDdP+tN2VRUVawBcplmHqRv
         ITVPksJ7H1kyELjQqLg+2bW3krseriR1pBihUVKjeV7ym6Qs2LqGtC0nTmhIcYUmk/
         SSChRCFTfvuO7Ns8kaiJEEo5SJ0icrtDusNJm3qE=
Date:   Mon, 21 Sep 2020 14:55:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        swboyd@chromium.org, sumit.garg@linaro.org,
        Julien Thierry <julien.thierry@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 6/7] arm_pmu: Introduce pmu_irq_ops
Message-ID: <20200921135510.GM2139@willie-the-truck>
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
 <20200819133419.526889-7-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819133419.526889-7-alexandru.elisei@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:34:18PM +0100, Alexandru Elisei wrote:
> From: Julien Thierry <julien.thierry@arm.com>
> 
> Currently the PMU interrupt can either be a normal irq or a percpu irq.
> Supporting NMI will introduce two cases for each existing one. It becomes
> a mess of 'if's when managing the interrupt.
> 
> Define sets of callbacks for operations commonly done on the interrupt. The
> appropriate set of callbacks is selected at interrupt request time and
> simplifies interrupt enabling/disabling and freeing.
> 
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 86 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index df352b334ea7..17e5952d21e4 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -26,8 +26,46 @@
>  
>  #include <asm/irq_regs.h>
>  
> +static int armpmu_count_irq_users(const int irq);
> +
> +struct pmu_irq_ops {
> +	void (*enable_pmuirq)(unsigned int irq);
> +	void (*disable_pmuirq)(unsigned int irq);
> +	void (*free_pmuirq)(unsigned int irq, int cpu, void __percpu *devid);
> +};
> +
> +static void armpmu_free_pmuirq(unsigned int irq, int cpu, void __percpu *devid)
> +{
> +	free_irq(irq, per_cpu_ptr(devid, cpu));
> +}
> +
> +static const struct pmu_irq_ops pmuirq_ops = {
> +	.enable_pmuirq = enable_irq,
> +	.disable_pmuirq = disable_irq_nosync,
> +	.free_pmuirq = armpmu_free_pmuirq
> +};
> +
> +static void armpmu_enable_percpu_pmuirq(unsigned int irq)
> +{
> +	enable_percpu_irq(irq, IRQ_TYPE_NONE);
> +}
> +
> +static void armpmu_free_percpu_pmuirq(unsigned int irq, int cpu,
> +				   void __percpu *devid)
> +{
> +	if (armpmu_count_irq_users(irq) == 1)
> +		free_percpu_irq(irq, devid);
> +}
> +
> +static const struct pmu_irq_ops percpu_pmuirq_ops = {
> +	.enable_pmuirq = armpmu_enable_percpu_pmuirq,
> +	.disable_pmuirq = disable_percpu_irq,
> +	.free_pmuirq = armpmu_free_percpu_pmuirq
> +};
> +
>  static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>  static DEFINE_PER_CPU(int, cpu_irq);
> +static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);

Would it make sense to put this in a structure alongside the irq?

>  
>  static inline u64 arm_pmu_event_max_period(struct perf_event *event)
>  {
> @@ -544,6 +582,19 @@ static int armpmu_count_irq_users(const int irq)
>  	return count;
>  }
>  
> +static const struct pmu_irq_ops *armpmu_find_irq_ops(int irq)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (per_cpu(cpu_irq, cpu) == irq
> +		    && per_cpu(cpu_irq_ops, cpu))
> +			return per_cpu(cpu_irq_ops, cpu);
> +	}

nit, but you could make this a bit more readable:

	struct pmu_irq_ops *ops = NULL;

	for_each_possible_cpu(cpu) {
		if (per_cpu(cpu_irq, cpu) != irq)
			continue;

		ops = per_cpu(cpu_irq_ops, cpu);
		if (ops)
			break;
	}

	return ops;

Will
