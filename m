Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0029223F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 07:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgJSFh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 01:37:57 -0400
Received: from foss.arm.com ([217.140.110.172]:49570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgJSFh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 01:37:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51F8AD6E;
        Sun, 18 Oct 2020 22:37:56 -0700 (PDT)
Received: from [10.163.77.151] (unknown [10.163.77.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C64353F719;
        Sun, 18 Oct 2020 22:37:52 -0700 (PDT)
Subject: Re: arm64: dropping prevent_bootmem_remove_notifier
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Suren Baghdasaryan <surenb@google.com>, pratikp@codeaurora.org,
        Gavin Shan <gshan@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
References: <de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f125083d-4885-d174-f732-9cd96c45ddb4@arm.com>
Date:   Mon, 19 Oct 2020 11:07:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudarshan,

On 10/17/2020 04:41 AM, Sudarshan Rajagopalan wrote:
> 
> Hello Anshuman,
> 
> In the patch that enables memory hot-remove (commit bbd6ec605c0f ("arm64/mm: Enable memory hot remove")) for arm64, there’s a notifier put in place that prevents boot memory from being offlined and removed. Also commit text mentions that boot memory on arm64 cannot be removed. We wanted to understand more about the reasoning for this. X86 and other archs doesn’t seem to do this prevention. There’s also comment in the code that this notifier could be dropped in future if and when boot memory can be removed.

Right and till then the notifier cannot be dropped. There was a lot of discussions
around this topic during multiple iterations of memory hot remove series. Hence, I
would just request you to please go through them first. This list here is from one
such series (https://lwn.net/Articles/809179/) but might not be exhaustive.

-----------------
On arm64 platform, it is essential to ensure that the boot time discovered
memory couldn't be hot-removed so that,

1. FW data structures used across kexec are idempotent
   e.g. the EFI memory map.

2. linear map or vmemmap would not have to be dynamically split, and can
   map boot memory at a large granularity

3. Avoid penalizing paths that have to walk page tables, where we can be
   certain that the memory is not hot-removable
-----------------

The primary reason being kexec which would need substantial rework otherwise.

> 
> The current logic is that only “new” memory blocks which are hot-added can later be offlined and removed. The memory that system booted up with cannot be offlined and removed. But there could be many usercases such as inter-VM memory sharing where a primary VM could offline and hot-remove a block/section of memory and lend it to secondary VM where it could hot-add it. And after usecase is done, the reverse happens where secondary VM hot-removes and gives it back to primary which can hot-add it back. In such cases, the present logic for arm64 doesn’t allow this hot-remove in primary to happen.

That is not true. Each VM could just boot with a minimum boot memory which can
not be offlined or removed but then a possible larger portion of memory can be
hot added during the boot process itself, making them available for any future
inter VM sharing purpose. Hence this problem could easily be solved in the user
space itself.

> 
> Also, on systems with movable zone that sort of guarantees pages to be migrated and isolated so that blocks can be offlined, this logic also defeats the purpose of having a movable zone which system can rely on memory hot-plugging, which say virt-io mem also relies on for fully plugged memory blocks.
ZONE_MOVABLE does not really guarantee migration, isolation and removal. There
are reasons an offline request might just fail. I agree that those reasons are
normally not platform related but core memory gives platform an opportunity to
decline an offlining request via a notifier. Hence ZONE_MOVABLE offline can be
denied. Semantics wise we are still okay.

This might look bit inconsistent that movablecore/kernelcore/movable_node with
firmware sending in 'hot pluggable' memory (IIRC arm64 does not really support
this yet), the system might end up with ZONE_MOVABLE marked boot memory which
cannot be offlined or removed. But an offline notifier action is orthogonal.
Hence did not block those kernel command line paths that creates ZONE_MOVABLE
during boot to preserve existing behavior.

> 
> I understand that some region of boot RAM shouldn’t be allowed to be removed, but such regions won’t be allowed to be offlined in first place since pages cannot be migrated and isolated, example reserved pages.
> 
> So we’re trying to understand the reasoning for such a prevention put in place for arm64 arch alone.

Primary reason being kexec. During kexec on arm64, next kernel's memory map is
derived from firmware and not from current running kernel. So the next kernel
will crash if it would access memory that might have been removed in running
kernel. Until kexec on arm64 changes substantially and takes into account the
real available memory on the current kernel, boot memory cannot be removed.

> 
> One possible way to solve this is by marking the required sections as “non-early” by removing the SECTION_IS_EARLY bit in its section_mem_map.

That is too intrusive from core memory perspective.

 This puts these sections in the context of “memory hotpluggable” which can be offlined-removed and added-onlined which are part of boot RAM itself and doesn’t need any extra blocks to be hot added. This way of marking certain sections as “non-early” could be exported so that module drivers can set the required number of sections as “memory hotpluggable”. This could have certain checks put in place to see which sections are allowed, example only movable zone sections can be marked as “non-early”.

Giving modules the right to mark memory hotpluggable ? That is too intrusive
and would still not solve the problem with kexec.

> 
> Your thoughts on this? We are also looking for different ways to solve the problem without having to completely dropping this notifier, but just putting out the concern here about the notifier logic that is breaking our usecase which is a generic memory sharing usecase using memory hotplug feature.

Completely preventing boot memory offline and removal is essential for kexec
to work as expected afterwards. As suggested previously, splitting the VM
memory into boot and non boot chunks during init can help work around this
restriction effectively in userspace itself and would not require any kernel
changes.

- Anshuman
