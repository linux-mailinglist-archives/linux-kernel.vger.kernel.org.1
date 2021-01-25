Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C5E3025AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbhAYNst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:48:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:43740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbhAYNoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:44:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5330DB9A3;
        Mon, 25 Jan 2021 11:20:15 +0000 (UTC)
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@linux.ibm.com>
Cc:     Christoph Lameter <cl@linux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
 <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
 <20210123051607.GC2587010@in.ibm.com>
 <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <66652406-25e4-a9e7-45a1-8ad14d2e8a36@suse.cz>
Date:   Mon, 25 Jan 2021 12:20:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/21 1:32 PM, Vincent Guittot wrote:
>> PowerPC PowerNV Host: (160 cpus)
>> num_online_cpus 1 num_present_cpus 160 num_possible_cpus 160 nr_cpu_ids 160
>>
>> PowerPC pseries KVM guest: (-smp 16,maxcpus=160)
>> num_online_cpus 1 num_present_cpus 16 num_possible_cpus 160 nr_cpu_ids 160
>>
>> That's what I see on powerpc, hence I thought num_present_cpus() could
>> be the correct one to use in slub page order calculation.
> 
> num_present_cpus() is set to 1 on arm64 until secondaries cpus boot
> 
> arm64 224cpus acpi host:
> num_online_cpus 1 num_present_cpus 1 num_possible_cpus 224 nr_cpu_ids 224
> arm64 8cpus DT host:
> num_online_cpus 1 num_present_cpus 1 num_possible_cpus 8 nr_cpu_ids 8
> arm64 8cpus qemu-system-aarch64 (-smp 8,maxcpus=256)
> num_online_cpus 1 num_present_cpus 1 num_possible_cpus 8 nr_cpu_ids 8

I would have expected num_present_cpus to be 224, 8, 8, respectively.

> Then present and online increase to num_possible_cpus once all cpus are booted
> 
>>
>> >
>> > What about heuristic:
>> > - num_online_cpus() > 1 - we trust that and use it
>> > - otherwise nr_cpu_ids
>> > Would that work? Too arbitrary?
>>
>> Looking at the following snippet from include/linux/cpumask.h, it
>> appears that num_present_cpus() should be reasonable compromise
>> between online and possible/nr_cpus_ids to use here.
>>
>> /*
>>  * The following particular system cpumasks and operations manage
>>  * possible, present, active and online cpus.
>>  *
>>  *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
>>  *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
>>  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
>>  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
>>  *
>>  *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
>>  *
>>  *  The cpu_possible_mask is fixed at boot time, as the set of CPU id's
>>  *  that it is possible might ever be plugged in at anytime during the
>>  *  life of that system boot.  The cpu_present_mask is dynamic(*),
>>  *  representing which CPUs are currently plugged in.  And
>>  *  cpu_online_mask is the dynamic subset of cpu_present_mask,
>>  *  indicating those CPUs available for scheduling.
>>  *
>>  *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
>>  *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
>>  *  ACPI reports present at boot.
>>  *
>>  *  If HOTPLUG is enabled, then cpu_present_mask varies dynamically,
>>  *  depending on what ACPI reports as currently plugged in, otherwise
>>  *  cpu_present_mask is just a copy of cpu_possible_mask.
>>  *
>>  *  (*) Well, cpu_present_mask is dynamic in the hotplug case.  If not
>>  *      hotplug, it's a copy of cpu_possible_mask, hence fixed at boot.
>>  */
>>
>> So for host systems, present is (usually) equal to possible and for
> 
> But "cpu_present_mask varies dynamically,  depending on what ACPI
> reports as currently plugged in"
> 
> So it should varies when secondaries cpus are booted

Hm, but booting the secondaries is just a software (kernel) action? They are
already physically there, so it seems to me as if the cpu_present_mask is not
populated correctly on arm64, and it's just a mirror of cpu_online_mask?
