Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164552954CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 00:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506721AbgJUW3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 18:29:49 -0400
Received: from foss.arm.com ([217.140.110.172]:41576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506714AbgJUW3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 18:29:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85DFF31B;
        Wed, 21 Oct 2020 15:29:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CED33F66B;
        Wed, 21 Oct 2020 15:29:46 -0700 (PDT)
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com> <jhj7drkrcpr.mognet@arm.com> <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com> <20201021110201.00002092@Huawei.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        patches@amperecomputing.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
In-reply-to: <20201021110201.00002092@Huawei.com>
Date:   Wed, 21 Oct 2020 23:29:41 +0100
Message-ID: <jhj5z73qkkq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 21/10/20 12:02, Jonathan Cameron wrote:
> On Wed, 21 Oct 2020 09:43:21 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Agreed. Do we really need to match X86 right now ? Do we really have
>> systems that has 64 nodes ? We should not increase the default node
>> value and then try to solve some new problems, when there might not
>> be any system which could even use that. I would suggest increase
>> NODES_SHIFT value upto as required by a real and available system.
>
> I'm not going to give precise numbers on near future systems but it is public
> that we ship 8 NUMA node ARM64 systems today.  Things will get more
> interesting as CXL and CCIX enter the market on ARM systems,
> given chances are every CXL device will look like another NUMA
> node (CXL spec says they should be presented as such) and you
> may be able to rack up lots of them.
>
> So I'd argue minimum that makes sense today is 16 nodes, but looking forward
> even a little and 64 is not a great stretch.
> I'd make the jump to 64 so we can forget about this again for a year or two.
> People will want to run today's distros on these new machines and we'd
> rather not have to go around all the distros asking them to carry a patch
> increasing this count (I assume they are already carrying such a patch
> due to those 8 node systems)
>

I agree that 4 nodes is somewhat anemic; I've had to bump that just to
run some scheduler tests under QEMU. However I still believe we should
exercise caution before cranking it too high, especially when seeing things
like:

  ee38d94a0ad8 ("page flags: prioritize kasan bits over last-cpuid")

To give some numbers, a defconfig build gives me:

  SECTIONS_WIDTH=0 ZONES_WIDTH=2 NODES_SHIFT=2 LAST_CPUPID_SHIFT=(8+8) KASAN_TAG_WIDTH=0
  BITS_PER_LONG=64 NR_PAGEFLAGS=24

IOW, we need 18 + NODES_SHIFT <= 40 -> NODES_SHIFT <= 22. That looks to be
plenty, however this can get cramped fairly easily with any combination of:

  CONFIG_SPARSEMEM_VMEMMAP=n (-18)
  CONFIG_IDLE_PAGE_TRACKING=y (-2)
  CONFIG_KASAN=y + CONFIG_KASAN_SW_TAGS (-8)

Taking Arnd's above example, a randconfig build picking !VMEMMAP already
limits the NODES_SHIFT to 4 *if* we want to keep the CPUPID thing within
the flags (it gets a dedicated field at the tail of struct page
otherwise). If that is something we don't care too much about, then
consider my concerns taken care of.


One more thing though: NR_CPUS can be cranked up to 4096 but we've only set
it to 256 IIRC to support the TX2. From that PoV, I'm agreeing with
Anshuman in that we should set it to match the max encountered on platforms
that are in use right now.

> Jonathan
>
>>
>> >
>> >>       depends on NEED_MULTIPLE_NODES
>> >>       help
>> >>         Specify the maximum number of NUMA Nodes available on the target
>> >
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
