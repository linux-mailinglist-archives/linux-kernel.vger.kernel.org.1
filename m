Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4118626835B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 06:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgINEFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 00:05:54 -0400
Received: from foss.arm.com ([217.140.110.172]:58374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgINEFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 00:05:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 799661045;
        Sun, 13 Sep 2020 21:05:52 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B12343F718;
        Sun, 13 Sep 2020 21:05:49 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/hotplug: Improve memory offline event notifier
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <1598241869-28416-1-git-send-email-anshuman.khandual@arm.com>
 <20200911140603.GB12835@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <fb62eba1-bc8a-3cc9-eca3-fe929e365f46@arm.com>
Date:   Mon, 14 Sep 2020 09:35:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200911140603.GB12835@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2020 07:36 PM, Catalin Marinas wrote:
> Hi Anshuman,
> 
> On Mon, Aug 24, 2020 at 09:34:29AM +0530, Anshuman Khandual wrote:
>> This brings about three different changes to the sole memory event notifier
>> for arm64 platform and improves it's robustness while also enhancing debug
>> capabilities during potential memory offlining error conditions.
>>
>> This moves the memory notifier registration bit earlier in the boot process
>> from device_initcall() to setup_arch() which will help in guarding against
>> potential early boot memory offline requests.
>>
>> This enables MEM_OFFLINE memory event handling. It will help intercept any
>> possible error condition such as if boot memory some how still got offlined
>> even after an expilicit notifier failure, potentially by a future change in
>> generic hotplug framework. This would help detect such scenarious and help
>> debug further.
>>
>> It also adds a validation function which scans entire boot memory and makes
>> sure that early memory sections are online. This check is essential for the
>> memory notifier to work properly as it cannot prevent boot memory offlining
>> if they are not online to begin with. But this additional sanity check is
>> enabled only with DEBUG_VM.
> 
> Could you please split this in separate patches rather than having a
> single one doing three somewhat related things?

Sure, will do.

> 
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -376,6 +376,14 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>>  			"This indicates a broken bootloader or old kernel\n",
>>  			boot_args[1], boot_args[2], boot_args[3]);
>>  	}
>> +
>> +	/*
>> +	 * Register the memory notifier which will prevent boot
>> +	 * memory offlining requests - early enough. But there
>> +	 * should not be any actual offlinig request till memory
>> +	 * block devices are initialized with memory_dev_init().
>> +	 */
>> +	memory_hotremove_notifier();
> 
> Why can this not be an early_initcall()? As you said, memory_dev_init()
> is called much later, after the SMP was initialised.

This proposal moves memory_hotremove_notifier() to setup_arch() because it
could and there is no harm in calling this too early than required for now.
But in case generic MM sequence of events during memory init changes later,
this notifier will still work.

IIUC, the notifier chain registration can be called very early in the boot
process without much problem. There are some precedence on other platforms.

1. arch/s390/mm/init.c   		  - In device_initcall() via s390_cma_mem_init()
2. arch/s390/mm/setup.c  		  - In setup_arch() via reserve_crashkernel()
3. arch/powerpc/platforms/pseries/cmm.c   - In module_init() via cmm_init()
4. arch/powerpc/platforms/pseries/iommu.c - via iommu_init_early_pSeries()
					    via pSeries_init()
				            via pSeries_probe() aka ppc_md.porbe()
					    via probe_machine()
					    via setup_arch()

> 
> You could even combine this with validate_bootmem_online_state() in a
> single early_initcall() which, after checking, registers the notifier.
> 

Yes, that will be definitely simpler but there might be still some value
in having this registration in setup_arch() which guard against future
generic MM changes while keeping it separate from the sanity check i.e
validate_bootmem_online_state() which is enabled only with DEBUG_VM. But
will combine both in early_initcall() with some name changes if that is
preferred.
