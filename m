Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F583284F96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgJFQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:12:36 -0400
Received: from foss.arm.com ([217.140.110.172]:51306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFQMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:12:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977B111B3;
        Tue,  6 Oct 2020 09:12:34 -0700 (PDT)
Received: from [10.37.12.66] (unknown [10.37.12.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2EC83F66B;
        Tue,  6 Oct 2020 09:12:32 -0700 (PDT)
Subject: Re: [PATCH] perf: arm_spe: Use Inner Shareable DSB when draining the
 buffer
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
References: <20201006150520.161985-1-alexandru.elisei@arm.com>
 <87ft6r4bgd.wl-maz@kernel.org>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <8fa8af94-ab08-b43a-95e4-55a13de09efe@arm.com>
Date:   Tue, 6 Oct 2020 17:13:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87ft6r4bgd.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thank you for having a look at the patch!

On 10/6/20 4:32 PM, Marc Zyngier wrote:
> Hi Alex,
>
> On Tue, 06 Oct 2020 16:05:20 +0100,
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>> From ARM DDI 0487F.b, page D9-2807:
>>
>> "Although the Statistical Profiling Extension acts as another observer in
>> the system, for determining the Shareability domain of the DSB
>> instructions, the writes of sample records are treated as coming from the
>> PE that is being profiled."
>>
>> Similarly, on page D9-2801:
>>
>> "The memory type and attributes that are used for a write by the
>> Statistical Profiling Extension to the Profiling Buffer is taken from the
>> translation table entries for the virtual address being written to. That
>> is:
>> - The writes are treated as coming from an observer that is coherent with
>>   all observers in the Shareability domain that is defined by the
>>   translation tables."
>>
>> All the PEs are in the Inner Shareable domain, use a DSB ISH to make sure
>> writes to the profiling buffer have completed.
> I'm a bit sceptical of this change. The SPE writes are per-CPU, and
> all we are trying to ensure is that the CPU we are running on has
> drained its own queue of accesses.
>
> The accesses being made within the IS domain doesn't invalidate the
> fact that they are still per-CPU, because "the writes of sample
> records are treated as coming from the PE that is being profiled.".
>
> So why should we have an IS-wide synchronisation for accesses that are
> purely local?

I think I might have misunderstood how perf spe works. Below is my original train
of thought.

In the buffer management event interrupt we drain the buffer, and if the buffer is
full, we call arm_spe_perf_aux_output_end() -> perf_aux_output_end(). The comment
for perf_aux_output_end() says "Commit the data written by hardware into the ring
buffer by adjusting aux_head and posting a PERF_RECORD_AUX into the perf buffer.
It is the pmu driver's responsibility to observe ordering rules of the hardware,
so that all the data is externally visible before this is called." My conclusion
was that after we drain the buffer, the data must be visible to all CPUs.

From the definition of non-shareable memory (ARM DDI0487F.b, page B2-155):

"For Normal memory locations, the Non-shareable attribute identifies Normal memory
that is likely to be accessed only by a single PE. A location in Normal memory
with the Non-shareable attribute does not require the hardware to make data
accesses by different observers coherent, unless the memory is Non-cacheable."

Linux configures all memory to be Inner Shareable (SH[1:0] = 0b11), *not*
Non-shareable (SH[1:0] = 0b00). I think that the DSB NSH doesn't really do
anything, because the PE will not do any accesses to Non-shareable memory, and we
end up breaking the assumption of perf_aux_output_end().

Did I make a mistake in my reasoning?

Thanks,
Alex
