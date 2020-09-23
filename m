Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF4275C44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgIWPpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:45:03 -0400
Received: from foss.arm.com ([217.140.110.172]:49442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIWPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:45:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5854F113E;
        Wed, 23 Sep 2020 08:45:02 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E76AA3F718;
        Wed, 23 Sep 2020 08:45:00 -0700 (PDT)
Subject: Re: [PATCH v6 6/7] arm_pmu: Introduce pmu_irq_ops
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        swboyd@chromium.org, sumit.garg@linaro.org,
        Julien Thierry <julien.thierry@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
 <20200819133419.526889-7-alexandru.elisei@arm.com>
 <20200921135510.GM2139@willie-the-truck>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <48af8175-3908-8de3-783f-c61522e9c6fc@arm.com>
Date:   Wed, 23 Sep 2020 16:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921135510.GM2139@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 9/21/20 2:55 PM, Will Deacon wrote:
> On Wed, Aug 19, 2020 at 02:34:18PM +0100, Alexandru Elisei wrote:
>> From: Julien Thierry <julien.thierry@arm.com>
>>
>> Currently the PMU interrupt can either be a normal irq or a percpu irq.
>> Supporting NMI will introduce two cases for each existing one. It becomes
>> a mess of 'if's when managing the interrupt.
>>
>> Define sets of callbacks for operations commonly done on the interrupt. The
>> appropriate set of callbacks is selected at interrupt request time and
>> simplifies interrupt enabling/disabling and freeing.
>>
>> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> ---
>>  drivers/perf/arm_pmu.c | 86 ++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 70 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index df352b334ea7..17e5952d21e4 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -26,8 +26,46 @@
>>  
>>  #include <asm/irq_regs.h>
>>  
>> +static int armpmu_count_irq_users(const int irq);
>> +
>> +struct pmu_irq_ops {
>> +	void (*enable_pmuirq)(unsigned int irq);
>> +	void (*disable_pmuirq)(unsigned int irq);
>> +	void (*free_pmuirq)(unsigned int irq, int cpu, void __percpu *devid);
>> +};
>> +
>> +static void armpmu_free_pmuirq(unsigned int irq, int cpu, void __percpu *devid)
>> +{
>> +	free_irq(irq, per_cpu_ptr(devid, cpu));
>> +}
>> +
>> +static const struct pmu_irq_ops pmuirq_ops = {
>> +	.enable_pmuirq = enable_irq,
>> +	.disable_pmuirq = disable_irq_nosync,
>> +	.free_pmuirq = armpmu_free_pmuirq
>> +};
>> +
>> +static void armpmu_enable_percpu_pmuirq(unsigned int irq)
>> +{
>> +	enable_percpu_irq(irq, IRQ_TYPE_NONE);
>> +}
>> +
>> +static void armpmu_free_percpu_pmuirq(unsigned int irq, int cpu,
>> +				   void __percpu *devid)
>> +{
>> +	if (armpmu_count_irq_users(irq) == 1)
>> +		free_percpu_irq(irq, devid);
>> +}
>> +
>> +static const struct pmu_irq_ops percpu_pmuirq_ops = {
>> +	.enable_pmuirq = armpmu_enable_percpu_pmuirq,
>> +	.disable_pmuirq = disable_percpu_irq,
>> +	.free_pmuirq = armpmu_free_percpu_pmuirq
>> +};
>> +
>>  static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>>  static DEFINE_PER_CPU(int, cpu_irq);
>> +static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
> Would it make sense to put this in a structure alongside the irq?
It doesn't really work, because we need the irq number to be percpu for
armpmu_free_irq() to work correctly. If we have a percpu pointer to a struct, the
first cpu that frees the irq will set it to 0, and all subsequent CPUs that share
the same struct will read 0 as the irq number, which will trigger the WARN_ON and
then return early.
>
>>  
>>  static inline u64 arm_pmu_event_max_period(struct perf_event *event)
>>  {
>> @@ -544,6 +582,19 @@ static int armpmu_count_irq_users(const int irq)
>>  	return count;
>>  }
>>  
>> +static const struct pmu_irq_ops *armpmu_find_irq_ops(int irq)
>> +{
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		if (per_cpu(cpu_irq, cpu) == irq
>> +		    && per_cpu(cpu_irq_ops, cpu))
>> +			return per_cpu(cpu_irq_ops, cpu);
>> +	}
> nit, but you could make this a bit more readable:
>
> 	struct pmu_irq_ops *ops = NULL;
>
> 	for_each_possible_cpu(cpu) {
> 		if (per_cpu(cpu_irq, cpu) != irq)
> 			continue;
>
> 		ops = per_cpu(cpu_irq_ops, cpu);
> 		if (ops)
> 			break;
> 	}
>
> 	return ops;

That looks better, I will change it.

Thanks,
Alex
