Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776B82746A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIVQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:29:09 -0400
Received: from foss.arm.com ([217.140.110.172]:46782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgIVQ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:29:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F3D101E;
        Tue, 22 Sep 2020 09:29:06 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FB1B3F718;
        Tue, 22 Sep 2020 09:29:05 -0700 (PDT)
Subject: Re: [PATCH v6 0/7] arm_pmu: Use NMI for perf interrupt
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, sumit.garg@linaro.org, maz@kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
 <20200921135951.GN2139@willie-the-truck>
 <296304b8-aadd-817d-bb12-dc7524b6f0f5@arm.com>
Message-ID: <e7a67a3c-1d09-2413-a1d5-d7f708a30e97@arm.com>
Date:   Tue, 22 Sep 2020 17:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <296304b8-aadd-817d-bb12-dc7524b6f0f5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/20 4:41 PM, Alexandru Elisei wrote:
> Hi Will,
>
> Thank you so much for reviewing the series!
>
> On 9/21/20 2:59 PM, Will Deacon wrote:
>> On Wed, Aug 19, 2020 at 02:34:12PM +0100, Alexandru Elisei wrote:
>>> The series makes the arm_pmu driver use NMIs for the perf interrupt when
>>> NMIs are available on the platform (currently, only arm64 + GICv3). To make
>>> it easier to play with the patches, I've pushed a branch at [1]:
>> This mostly looks good to me, but see some of the comments I left on the
>> code. One other thing I'm not sure about is whether or not we should tell
>> userspace that we're using an NMI for the sampling. Do any other
>> architectures have a conditional NMI?
> I'm not sure about other architectures being able to configure the perf interrupt
> as NMI or a regular interrupt, I'll try to find out. Regardless of what the other
> architecture do, I am of the opinion that we should spell out explicitly when the
> PMU is using pseudo-NMIs, because it makes a huge difference in the accuracy of
> the instrumentation and the overall usefulness of perf.

Coming back to this, looked at what other architectures are doing by grepping for
perf_pmu_register() and going from there, results below. I've found xtensa to
allow both regular IRQs and NMIs for PMU, based on a kernel config option (just
like arm64). However, the description for the config option states clearly the the
PMU IRQ will be an IRQ, while we don't have that for arm64 - the IRQ will be an
NMI automatically if the GIC is configured to use pseudo-NMIs. I think displaying
a message is the right thing to do, I'll do that for v7.

PMU IRQs for other architectures:

* alpha - PMU interrupt is always IRQ.
* arc - optional PMU interrupt; when present it's requested with
request_percpu_irq(); it prints to dmesg when overflow IRQ support has been detected.
* arm - no NMIs.
* c6x - seems like it doesn't have a PMU at all.
* csky - PMU interrupts is always IRQ.
* h8300 - seems like it doesn't have a PMU at all.
* hexagon - seems like it doesn't have a PMU at all.
* ia64 - perfmon interrupt is registered with register_percpu_irq(); it prints the
IRQ number.
* m64k - couldn't find anything resembling a PMU.
* microblaze - seems like it doesn't have a PMU.
* mips - regular IRQ; irq number and if it's shared with the timer interrupt is
printed.
* nds32 - regular IRQ; doesn't print anything regarding IRQ number.
* nios2 - seems like it doesn't have a PMU.
* openrisc - no PMU.
* parisc - no PMU IRQ, free-running counters?
* powerpc - no IRQ for IMC, hv_24x7 and hv_gpci PMUs; looks like for powerpc64,
the PMU interrupt is treated like an NMI if it is taken when interrupts are
"soft-masked", for powerpc32 it's always a regular interrupt; no information
displayed about the interrupt.
* riscv - they use regular IRQs only when multiplexing events; I haven't found any
information displayed about the PMU.
* s390 - no IRQ for cpum_cf_diag and cpm_cf; regular IRQ for cpum_sf; no dmesg output.
* sh - no IRQ.
* sparc - looks like it's always NMI; no information about IRQ is displayed.
* um - no PMU.
* x86 - the PMU interrupt is always a NMI, the lapic is configured to deliver the
PMI as an NMI (in arch/x86/events/core.c::perf_events_lapic_init()). Nothing about
interrupts printed in init_hw_perf_events();
* xtensa - the interrupt can be configurated as an NMI (EXTENSA_FAKE_NMI), but no
information about it is displayed.

Thanks,
Alex
