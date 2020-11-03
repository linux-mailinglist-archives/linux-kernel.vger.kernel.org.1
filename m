Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32062A4593
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgKCMxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:53:23 -0500
Received: from z5.mailgun.us ([104.130.96.5]:53046 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgKCMxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:53:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604408001; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3euWrf7R06QN8CqTw6UG20KChFG7Q3BWaZnvp+cCPsk=;
 b=qEy66a110kOQzhSYQnntAS1WnPUrCW6IK0j/ecw8GrU6wHcaixAQiZ+johE9IDN3WY2NaeQU
 ZC7rR4ZQjcswgzfH/OXhGbyHKZszw50GE6rg4whaktq3E2Y5DEvecIy9UvmwdN7ZVRCLN8au
 3CuCHutKJ8E0vnqRAFbAVSGanp0=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fa152c075bebe827ae70af3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 12:53:20
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 234BFC433A0; Tue,  3 Nov 2020 02:15:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FF0FC43382;
        Tue,  3 Nov 2020 02:15:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 02 Nov 2020 18:15:43 -0800
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: mm/memblock: export memblock_{start/end}_of_DRAM
In-Reply-To: <7b50c0fa-bbeb-1041-c05c-2667134044b6@redhat.com>
References: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
 <7b50c0fa-bbeb-1041-c05c-2667134044b6@redhat.com>
Message-ID: <8ddfc74f0bd529ad78bd2e2d0b95a6c6@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-29 23:41, David Hildenbrand wrote:
> On 29.10.20 22:29, Sudarshan Rajagopalan wrote:
>> Hello all,
>> 
> 
> Hi!
> 

Hi David.. thanks for the response as always.

>> We have a usecase where a module driver adds certain memory blocks 
>> using
>> add_memory_driver_managed(), so that it can perform memory hotplug
>> operations on these blocks. In general, these memory blocks aren’t
>> something that gets physically added later, but is part of actual RAM
>> that system booted up with. Meaning – we set the ‘mem=’ cmdline
>> parameter to limit the memory and later add the remaining ones using
>> add_memory*() variants.
>> 
>> The basic idea is to have driver have ownership and manage certain
>> memory blocks for hotplug operations.
> 
> So, in summary, you're still abusing the memory hot(un)plug
> infrastructure from your driver - just not in a severe way as before.
> And I'll tell you why, so you might understand why exposing this API
> is not really a good idea and why your driver wouldn't - for example -
> be upstream material.
> 
> Don't get me wrong, what you are doing might be ok in your context,
> but it's simply not universally applicable in our current model.
> 
> Ordinary system RAM works different than many other devices (like PCI
> devices) whereby *something* senses the device and exposes it to the
> system, and some available driver binds to it and owns the memory.
> 
> Memory is detected by a driver and added to the system via e.g.,
> add_memory_driver_managed(). Memory devices are created and the memory
> is directly handed off to the system, to be used as system RAM as soon
> as memory devices are onlined. There is no driver that "binds" memory
> like other devices - it's rather the core (buddy) that uses/owns that
> memory immediately after device creation.
> 

I see.. and I agree that drivers are meant to *sense* that something 
changed or newly added, so that driver can check if it's the one 
responsible or compatible for handling this entity and binds to it. So I 
guess what it boils down to is - a driver that uses memory hotplug 
_cannot_ add/remove or have ownership of memblock boot memory, but for 
the newly added RAM blocks later on.

I was trying to mimic the detecting and adding of extra RAM by limiting 
the System RAM with "mem=XGB" as though system booted with XGB of boot 
memory and later add the remaining blocks (force detection and adding) 
using add_memorY-driver_manager(). This remaining blocks are calculated 
by 'physical end addr of boot memory' - 'memblock_end_of_DRAM'. The 
"physical end addr of boot memory" i.e. the actual RAM that bootloader 
informs to kernel can be obtained by scanning the 'memory' DT node.

>> 
>> For the driver be able to know how much memory was limited and how 
>> much
>> actually present, we take the delta of ‘bootmem physical end address’
>> and ‘memblock_end_of_DRAM’. The 'bootmem physical end address' is
>> obtained by scanning the reg values in ‘memory’ DT node and 
>> determining
>> the max {addr,size}. Since our driver is getting modularized, we won’t
>> have access to memblock_end_of_DRAM (i.e. end address of all memory
>> blocks after ‘mem=’ is applied).
> 
> What you do with "mem=" is force memory detection to ignore some of
> it's detected memory.
> 
>> 
>> So checking if memblock_{start/end}_of_DRAM() symbols can be exported?
>> Also, this information can be obtained by userspace by doing ‘cat
>> /proc/iomem’ and greping for ‘System RAM’. So wondering if userspace 
>> can
> 
> Not correct: with "mem=", cat /proc/iomem only shows *detected* +
> added system RAM, not the unmodified detection.
> 

That's correct - I meant 'memblock_end_of_DRAM' along with "mem=" can be 
calculated using 'cat /proc/iomem' which shows "detected plus added" 
System RAM, and not the remaining undetected one which got stripped off 
due to "mem=XGB". Basically, 'memblock_end_of_DRAM' address with 
'mem=XGB' is {end addr of boot RAM - XGB}.. which would be same as end 
address of "System RAM" showed in /proc/iomem.

The reasoning for this is - if userspace can have access to such info 
and calculate the memblock end address, why not let drivers have this 
info using memblock_end_of_DRAM()?

>> have access to such info, can we allow kernel module drivers have 
>> access
>> by exporting memblock_{start/end}_of_DRAM().
>> 
>> Or are there any other ways where a module driver can get the end
>> address of system memory block?
> 
> And here is our problem: You disabled *detection* of that memory by
> the responsible driver (here: core). Now your driver wants to know
> what would have been detected. Assume you have memory hole in that
> region - it would not work by simply looking at start/end. You're
> driver is not the one doing the detection.
> 

Regarding the memory hole - the driver can inspect the 'memory' DT node 
that kernel gets from ABL from RAM partition table if any such holes 
exist or not. I agree that if such holes exists, hot adding will fail 
since it needs block size to be added.
The same issue will arise if a RAM slot is added and a driver senses it 
and it only knows the start/end of this RAM slot (though such holes 
generally doesn't exists in RAM slots).

This is again something specific to our target which we make sure there 
are no such holes in the top most memory which is stripped off by "mem=" 
and later added by the driver. I agree this is not universal upstream 
material type, but its a method that drivers can utilize.

> Another issue is: when using such memory for KVM guests, there is no
> mechanism that tracks ownership of that memory - imagine another
> driver wanting to use that memory. This really only works in special
> environments.
> 
> Yet another issue: you cannot assume that memblock data will stay
> around after boot. While we do it right now for arm64, that might
> change at some point. This is also one of the reasons why we don't
> export any real memblock data to drivers.
> 
> 
> When using "mem=" you have to know the exact layout of your system RAM
> and communicate the right places how that layout looks like manually:
> here, to your driver.
> 

I agree the issues mentioned here with this approach are valid from 
upstream POV, but we aren't trying to make a generic driver for this 
usecase and upstream it, but rather have it tailor made for our usecase 
alone where we know the layout of the System RAM (max bootmemory, no 
holes etc) and we utilize "mem=" and memory hotplug so that driver can 
add and have ownership of the remaining memory for later hotplug 
operations.

> The clean way of doing things today is to allocate RAM and use it for
> guests - e.g., using hugetlb/gigantic pages. As I said, there are
> other techniques coming up to deal with minimizing struct page
> overhead - if that's what you're concerned with (I still don't know
> why you're removing the memory from the host when giving it to the
> guest).

The overhead of strut page with hugetlb is valid, but we have other 
usecases outside of inter-VM sharing where we rely on memory 
hotplugging. In general, we want a way to be able to add/remove and 
offline/online a memory which is part of boot. With all the tools 
available - "mem=", "/proc/iomem", "memory" DT node and memory hotplug 
framework, a driver can still be able to achieve this and these tools 
that are present now does allow it.

Keeping the interVM memory sharing aside, would it be okay if 
memblock_end_of_DRAM() be exported? Like I mentioned before, there can 
be a userspace service that calculates this using 'cat /proc/iomem' and 
have it delivered to driver via a sysfs node. So I dont see any harm in 
exporting this info to driver. I agree other memblock info shouldn't be 
exposed outside to drivers. But I see no harm for 
memblock_end_of_DRAM().

I will be glad to share more info about the usecase where we use this 
approach if that would help, and I can check and get back on how much we 
can share since this is a proprietary usecase for Qualcomm.


Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
