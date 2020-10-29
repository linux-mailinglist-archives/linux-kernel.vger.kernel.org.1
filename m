Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D7729F693
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgJ2VDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:03:38 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:41931 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJ2VDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:03:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604005416; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=wrMdI+4RaPfZPeWzQXW90cx5Z685EYq4/9tTEJkTtvc=;
 b=BV/v+ieETU2Vzk06dQb/3sEQ7d0pb7V1KkfPiQArBoSpE5JpJVhfs3vZZkMwmrQPUncmf6v2
 d3NIlooPMuBb5AzY+Q7WCWf1/Daa+BcXrqBXWRgIoBu/apkZs6kQ6t5UvtGmu9PohiAu9G+i
 8wl8jJvssUg8KAByPpZv5osAe/s=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f9b2dd3dec7e4448e2748fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Oct 2020 21:02:11
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0A3D4C43382; Thu, 29 Oct 2020 21:02:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A0C5C433CB;
        Thu, 29 Oct 2020 21:02:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 29 Oct 2020 14:02:09 -0700
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>, pratikp@codeaurora.org,
        Gavin Shan <gshan@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: arm64: dropping prevent_bootmem_remove_notifier
In-Reply-To: <f125083d-4885-d174-f732-9cd96c45ddb4@arm.com>
References: <de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org>
 <f125083d-4885-d174-f732-9cd96c45ddb4@arm.com>
Message-ID: <57952529a81c6d5ba2521c203dfc54b5@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Anshuman, David,

Thanks for all the detailed explanations for the reasoning to have 
bootmem protected from being removed. Also, I do agree drivers being 
able to mark memory sections isn't the right thing to do.

We went ahead with the approach of using "mem=" as you suggested to 
limit the bootmem and add remaining blocks using 
add_memory_driver_managed() so that driver has ownership of these 
blocks.

We do have some follow-up questions regarding this - will initiate a 
discussion soon.


On 2020-10-18 22:37, Anshuman Khandual wrote:
> Hello Sudarshan,
> 
> On 10/17/2020 04:41 AM, Sudarshan Rajagopalan wrote:
>> 
>> Hello Anshuman,
>> 
>> In the patch that enables memory hot-remove (commit bbd6ec605c0f 
>> ("arm64/mm: Enable memory hot remove")) for arm64, there’s a notifier 
>> put in place that prevents boot memory from being offlined and 
>> removed. Also commit text mentions that boot memory on arm64 cannot be 
>> removed. We wanted to understand more about the reasoning for this. 
>> X86 and other archs doesn’t seem to do this prevention. There’s also 
>> comment in the code that this notifier could be dropped in future if 
>> and when boot memory can be removed.
> 
> Right and till then the notifier cannot be dropped. There was a lot of
> discussions
> around this topic during multiple iterations of memory hot remove
> series. Hence, I
> would just request you to please go through them first. This list here
> is from one
> such series (https://lwn.net/Articles/809179/) but might not be 
> exhaustive.
> 
> -----------------
> On arm64 platform, it is essential to ensure that the boot time 
> discovered
> memory couldn't be hot-removed so that,
> 
> 1. FW data structures used across kexec are idempotent
>    e.g. the EFI memory map.
> 
> 2. linear map or vmemmap would not have to be dynamically split, and 
> can
>    map boot memory at a large granularity
> 
> 3. Avoid penalizing paths that have to walk page tables, where we can 
> be
>    certain that the memory is not hot-removable
> -----------------
> 
> The primary reason being kexec which would need substantial rework 
> otherwise.
> 
>> 
>> The current logic is that only “new” memory blocks which are hot-added 
>> can later be offlined and removed. The memory that system booted up 
>> with cannot be offlined and removed. But there could be many usercases 
>> such as inter-VM memory sharing where a primary VM could offline and 
>> hot-remove a block/section of memory and lend it to secondary VM where 
>> it could hot-add it. And after usecase is done, the reverse happens 
>> where secondary VM hot-removes and gives it back to primary which can 
>> hot-add it back. In such cases, the present logic for arm64 doesn’t 
>> allow this hot-remove in primary to happen.
> 
> That is not true. Each VM could just boot with a minimum boot memory 
> which can
> not be offlined or removed but then a possible larger portion of memory 
> can be
> hot added during the boot process itself, making them available for any 
> future
> inter VM sharing purpose. Hence this problem could easily be solved in 
> the user
> space itself.
> 
>> 
>> Also, on systems with movable zone that sort of guarantees pages to be 
>> migrated and isolated so that blocks can be offlined, this logic also 
>> defeats the purpose of having a movable zone which system can rely on 
>> memory hot-plugging, which say virt-io mem also relies on for fully 
>> plugged memory blocks.
> ZONE_MOVABLE does not really guarantee migration, isolation and 
> removal. There
> are reasons an offline request might just fail. I agree that those 
> reasons are
> normally not platform related but core memory gives platform an 
> opportunity to
> decline an offlining request via a notifier. Hence ZONE_MOVABLE offline 
> can be
> denied. Semantics wise we are still okay.
> 
> This might look bit inconsistent that 
> movablecore/kernelcore/movable_node with
> firmware sending in 'hot pluggable' memory (IIRC arm64 does not really 
> support
> this yet), the system might end up with ZONE_MOVABLE marked boot memory 
> which
> cannot be offlined or removed. But an offline notifier action is 
> orthogonal.
> Hence did not block those kernel command line paths that creates 
> ZONE_MOVABLE
> during boot to preserve existing behavior.
> 
>> 
>> I understand that some region of boot RAM shouldn’t be allowed to be 
>> removed, but such regions won’t be allowed to be offlined in first 
>> place since pages cannot be migrated and isolated, example reserved 
>> pages.
>> 
>> So we’re trying to understand the reasoning for such a prevention put 
>> in place for arm64 arch alone.
> 
> Primary reason being kexec. During kexec on arm64, next kernel's memory 
> map is
> derived from firmware and not from current running kernel. So the next 
> kernel
> will crash if it would access memory that might have been removed in 
> running
> kernel. Until kexec on arm64 changes substantially and takes into 
> account the
> real available memory on the current kernel, boot memory cannot be 
> removed.
> 
>> 
>> One possible way to solve this is by marking the required sections as 
>> “non-early” by removing the SECTION_IS_EARLY bit in its 
>> section_mem_map.
> 
> That is too intrusive from core memory perspective.
> 
>  This puts these sections in the context of “memory hotpluggable”
> which can be offlined-removed and added-onlined which are part of boot
> RAM itself and doesn’t need any extra blocks to be hot added. This way
> of marking certain sections as “non-early” could be exported so that
> module drivers can set the required number of sections as “memory
> hotpluggable”. This could have certain checks put in place to see
> which sections are allowed, example only movable zone sections can be
> marked as “non-early”.
> 
> Giving modules the right to mark memory hotpluggable ? That is too 
> intrusive
> and would still not solve the problem with kexec.
> 
>> 
>> Your thoughts on this? We are also looking for different ways to solve 
>> the problem without having to completely dropping this notifier, but 
>> just putting out the concern here about the notifier logic that is 
>> breaking our usecase which is a generic memory sharing usecase using 
>> memory hotplug feature.
> 
> Completely preventing boot memory offline and removal is essential for 
> kexec
> to work as expected afterwards. As suggested previously, splitting the 
> VM
> memory into boot and non boot chunks during init can help work around 
> this
> restriction effectively in userspace itself and would not require any 
> kernel
> changes.
> 
> - Anshuman


Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
