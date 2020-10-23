Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8A2970CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465123AbgJWNnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:43:11 -0400
Received: from foss.arm.com ([217.140.110.172]:53096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S375453AbgJWNnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:43:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1FE01FB;
        Fri, 23 Oct 2020 06:43:09 -0700 (PDT)
Received: from [10.57.50.191] (unknown [10.57.50.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 777713F66B;
        Fri, 23 Oct 2020 06:43:08 -0700 (PDT)
Subject: Re: [PATCH v4] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller
To:     Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        patches@amperecomputing.com, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1603235425-29442-1-git-send-email-tuanphan@os.amperecomputing.com>
 <5c24da3f-4fa3-79ad-0c0d-9b4828ebf684@arm.com>
 <1EC85DEF-8E0C-42B9-9B01-DA897147B1F7@amperemail.onmicrosoft.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c4b8a58e-ca55-21ec-5a0d-50ab995a1d68@arm.com>
Date:   Fri, 23 Oct 2020 14:43:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <1EC85DEF-8E0C-42B9-9B01-DA897147B1F7@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-22 22:46, Tuan Phan wrote:
[...]
>>> +#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)			\
>>> +	((((attr)->cfg) >> lo) & GENMASK(hi - lo, 0))
>>
>> As per the buildbot report, GENMASK_ULL() would be appropriate when the other side is a u64 (although either way this does look a lot like reinventing FIELD_GET()...)
> 
> I will add (COMPILE_TEST && 64BIT) to Kconfig so it should fix the buildbot report.

Huh? The left-hand side of the "&" expression will always be a u64 here, 
which is unsigned long long. Regardless of whether an unsigned long on 
the right-hand side happens to be the same size, you have a semantic 
type mismatch, which is trivial to put right. I can't comprehend why 
introducing a fake build dependency to hide this would seem like a 
better idea than making a tiny change to make the code 100% correct and 
robust with zero practical impact :/

Sure, you only copied this from the SPE driver; that doesn't mean it was 
ever correct, simply that the mismatch was hidden since that driver *is* 
tightly coupled to one particular CPU ISA.

[...]
>>> +static irqreturn_t dmc620_pmu_handle_irq(int irq_num, void *data)
>>> +{
>>> +	struct dmc620_pmu_irq *irq = data;
>>> +	struct dmc620_pmu *dmc620_pmu;
>>> +	irqreturn_t ret = IRQ_NONE;
>>> +
>>> +	rcu_read_lock();
>>> +	list_for_each_entry_rcu(dmc620_pmu, &irq->pmus_node, pmus_node) {
>>> +		unsigned long status;
>>> +		struct perf_event *event;
>>> +		unsigned int idx;
>>> +
>>> +		/*
>>> +		 * HW doesn't provide a control to atomically disable all counters.
>>> +		 * To prevent race condition, disable all events before continuing
>>> +		 */
>>
>> I'm still doubtful that this doesn't introduce more inaccuracy overall than whatever it's trying to avoid... :/
> 
> It think it does. By disabling all counters, you make sure overflow status not change at the same time you are clearing
> it(by writing zero) after reading all counters.

Urgh, *now* I get what the race is - we don't have a proper 
write-1-to-clear interrupt status register, so however much care we take 
in writing back to the overflow register there's always *some* risk of 
wiping out a new event when writing back, unless we ensure that no new 
overflows can occur *before* reading the status. What a horrible piece 
of hardware design... :(

Perhaps it's worth expanding the comment a little more, since apparently 
it's not super-obvious.

[...]
>>> +	/*
>>> +	 * We must NOT create groups containing mixed PMUs, although software
>>> +	 * events are acceptable.
>>> +	 */
>>> +	if (event->group_leader->pmu != event->pmu &&
>>> +			!is_software_event(event->group_leader))
>>> +		return -EINVAL;
>>> +
>>> +	for_each_sibling_event(sibling, event->group_leader) {
>>> +		if (sibling->pmu != event->pmu &&
>>> +				!is_software_event(sibling))
>>> +			return -EINVAL;
>>> +	}
>>
>> As before, if you can't start, stop, or read multiple counters atomically, you can't really support groups of events for this PMU either. It's impossible to measure accurate ratios with a variable amount of skew between individual counters.
> 
> Can you elaborate more? The only issue I know is we can’t stop all counters of same PMU atomically in IRQ handler to prevent race condition.  But it can be fixed by manually disable each counter. Other than that, every counters are working independently.

The point of groups is to be able to count two or more events for the 
exact same time period, in order to measure ratios between them 
accurately. ->add, ->del, ->read, etc. are still called one at a time 
for each event in the group, but those calls are made as part of a 
transaction, which for most drivers is achieved by perf core calling 
->pmu_disable and ->pmu_enable around the other calls. Since this driver 
doesn't have enable/disable functionality, the individual events will 
count for different lengths of time depending on what order those calls 
are made in (which is not necessarily constant), and how long each one 
takes. Thus you'll end up with an indeterminate amount of error between 
what each count represents, and the group is not really any more 
accurate than if the events were simply scheduled independently, which 
is not how it's supposed to work.

Come to think of it, you're also not validating that groups are even 
schedulable - try something like:

   perf stat -e 
'{arm_dmc620_10008c000/clk_cycle_count/,arm_dmc620_10008c000/clk_request/,arm_dmc620_10008c000/clk_upload_stall/}' 
sleep 5

and observe perf core being very confused and unhappy when ->add starts 
failing for a group that ->event_init said was OK, since 3 events won't 
actually fit into the 2 available counters.

As I said before, I think you probably would be able to make groups work 
with some careful hooking up of snapshot functionality to ->start_txn 
and ->commit_txn, but to start with it'll be an awful lot simpler to 
just be honest and reject them.

[...]
>>> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>>> +				  "%s_%llx", DMC620_PMUNAME,
>>> +				  (res->start) >> DMC620_PA_SHIFT);
>>
>> res->start doesn't need parentheses, however I guess it might need casting to u64 to solve the build warning (I'm not sure there's any nicer way, unfortunately).
> 
> I will remove those parentheses, we don’t need u64 as build warning only applies when it runs compiling test with 32bit.

As above, deliberately hacking the build for the sake of not fixing 
clearly dodgy code is crazy. The only correct format specifier for an 
expression of type phys_addr_t/resource_size_t is "%pa"; if you want to 
use a different format then explicitly converting the argument to a type 
appropriate for that format (either via a simple cast or an intermediate 
variable) is indisputably correct, regardless of whether you might 
happen to get away with an implicit conversion sometimes.

The whole point of maximising COMPILE_TEST coverage is to improve code 
quality in order to avoid this exact situation, wherein someone copies a 
pattern from an existing driver only to discover that it's not actually 
as robust as it should be.

Robin.
