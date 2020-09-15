Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67D126B245
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgIOWoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:44:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35966 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIOPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:54:59 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id C0ECE20A1B0A;
        Tue, 15 Sep 2020 08:48:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0ECE20A1B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600184890;
        bh=GbNvjXtIotnTBVgQShUjpy3PRjg3FpkBOXs/mo4yho0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=q0OQamjlujfpL3CaZpBs0H+t42o65JG6/7LkHnKyEKK2VcoEEz5UVoH9HqOacK+YJ
         c2hcty9QYfWwvY/lZcIxp6+Jtt6EDz5dvz3e8SmBxPFzCMLDrDExgbljN4Yyf9m7K4
         SFCniytE2+51nt9Uarh5u8vho2jvxJggvJ8pbV8o=
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200914143312.GU16999@dhcp22.suse.cz>
 <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
 <20200915081832.GA4649@dhcp22.suse.cz>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <53dd1e2c-f07e-ee5b-51a1-0ef8adb53926@linux.microsoft.com>
Date:   Tue, 15 Sep 2020 08:48:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915081832.GA4649@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2020 1:18 AM, Michal Hocko wrote:
> On Mon 14-09-20 09:57:02, Vijay Balakrishna wrote:
>>
>>
>> On 9/14/2020 7:33 AM, Michal Hocko wrote:
>>> On Thu 10-09-20 13:47:39, Vijay Balakrishna wrote:
>>>> When memory is hotplug added or removed the min_free_kbytes must be
>>>> recalculated based on what is expected by khugepaged.  Currently
>>>> after hotplug, min_free_kbytes will be set to a lower default and higher
>>>> default set when THP enabled is lost. This leaves the system with small
>>>> min_free_kbytes which isn't suitable for systems especially with network
>>>> intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
>>>> soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
>>>> kills.
>>>
>>> Care to explain some more please? The whole point of increasing
>>> min_free_kbytes for THP is to get a larger free memory with a hope that
>>> huge pages will be more likely to appear. While this might help for
>>> other users that need a high order pages it is definitely not the
>>> primary reason behind it. Could you provide an example with some more
>>> data?
>>
>> Thanks Michal.  I haven't looked into THP as part of my investigation, so I
>> cannot comment.
>>
>> In our use case we are hotplug removing ~2GB of 8GB total (on our SoC)
>> during normal reboot/shutdown.  This memory is hotplug hot-added as movable
>> type via systemd late service during start-of-day.
>>
>> In our stress test first we ran into HW WATCHDOG recovery, on enabling
>> kernel watchdog we started seeing soft lockup hung task notices, failure
>> symptons varied, where stack trace of hung tasks sometimes trying to
>> allocate GFP_ATOMIC memory, looping in do_notify_resume, NETDEVICE WATCHDOG
>> timeouts, OOM process kills etc.,  During investigation we reran stress test
>> without hotplug use case.  Surprisingly this run didn't encounter the said
>> problems.  This led to comparing what is different between the two runs,
>> while looking at various globals, studying hotplug code I uncovered the
>> issue of failing to restore min_free_kbytes.  In particular on our 8GB SoC
>> min_free_kbytes went down to 8703 from 22528 after hotplug add.
> 
> Did you try to increase min_free_kbytes manually after hot remove? Btw.

No, in our use case memory hot remove done during shutdown.

> I would consider oom killer invocation due to min_free_kbytes really
> weird behavior. If anything the higher value would cause more memory
> reclaim and potentially oom rather than smaller one.

Yes, we wondered about it too.  One panic stack trace (after many OOM kills)

[330321.174240] Out of memory and no killable processes...
[330321.179658] Kernel panic - not syncing: System is deadlocked on memory
[330321.186489] CPU: 4 PID: 1 Comm: systemd Kdump: loaded Tainted: G 
       O      5.4.51-xxx #1
[330321.196900] Hardware name: Overlake (DT)
[330321.201038] Call trace:
[330321.203660]  dump_backtrace+0x0/0x1d0
[330321.207533]  show_stack+0x20/0x2c
[330321.211048]  dump_stack+0xe8/0x150
[330321.214656]  panic+0x18c/0x3b4
[330321.217901]  out_of_memory+0x4c0/0x6e4
[330321.221863]  __alloc_pages_nodemask+0xbdc/0x1c90
[330321.226722]  alloc_pages_current+0x21c/0x2b0
[330321.231220]  alloc_slab_page+0x1e0/0x7d8
[330321.235361]  new_slab+0x2e8/0x2f8
[330321.238874]  ___slab_alloc+0x45c/0x59c
[330321.242835]  kmem_cache_alloc+0x2d4/0x360
[330321.247065]  getname_flags+0x6c/0x2a8
[330321.250938]  user_path_at_empty+0x3c/0x68
[330321.255168]  do_readlinkat+0x7c/0x17c
[330321.259039]  __arm64_sys_readlinkat+0x5c/0x70
[330321.263627]  el0_svc_handler+0x1b8/0x32c
[330321.267767]  el0_svc+0x10/0x14
[330321.271026] SMP: stopping secondary CPUs
[330321.275382] Starting crashdump kernel...
[330321.279526] Bye!

Then while searching I came across documented warning below.  In above 
instance panic after OOM kills happened after 3+ days of stress run (a 
mixure of ttcp, cpuloadgen and fio).

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/performance_tuning_guide/sect-red_hat_enterprise_linux-performance_tuning_guide-configuration_tools-configuring_system_memory_capacity

Warning

Extreme values can damage your system. Setting min_free_kbytes to an 
extremely low value prevents the system from reclaiming memory, which 
can result in system hangs and OOM-killing processes. However, setting 
min_free_kbytes too high (for example, to 5–10% of total system memory) 
causes the system to enter an out-of-memory state immediately, resulting 
in the system spending too much time reclaiming memory.
