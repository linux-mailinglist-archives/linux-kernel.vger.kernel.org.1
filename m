Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009E929ED0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgJ2NhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgJ2NhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:37:15 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9E12076E;
        Thu, 29 Oct 2020 13:37:12 +0000 (UTC)
Date:   Thu, 29 Oct 2020 13:37:10 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
Message-ID: <20201029133709.GE10776@gaia>
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
 <jhj7drkrcpr.mognet@arm.com>
 <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
 <20201021110201.00002092@Huawei.com>
 <jhj5z73qkkq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj5z73qkkq.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 11:29:41PM +0100, Valentin Schneider wrote:
> On 21/10/20 12:02, Jonathan Cameron wrote:
> > On Wed, 21 Oct 2020 09:43:21 +0530
> > Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> >> Agreed. Do we really need to match X86 right now ? Do we really have
> >> systems that has 64 nodes ? We should not increase the default node
> >> value and then try to solve some new problems, when there might not
> >> be any system which could even use that. I would suggest increase
> >> NODES_SHIFT value upto as required by a real and available system.
> >
> > I'm not going to give precise numbers on near future systems but it is public
> > that we ship 8 NUMA node ARM64 systems today.  Things will get more
> > interesting as CXL and CCIX enter the market on ARM systems,
> > given chances are every CXL device will look like another NUMA
> > node (CXL spec says they should be presented as such) and you
> > may be able to rack up lots of them.
> >
> > So I'd argue minimum that makes sense today is 16 nodes, but looking forward
> > even a little and 64 is not a great stretch.
> > I'd make the jump to 64 so we can forget about this again for a year or two.
> > People will want to run today's distros on these new machines and we'd
> > rather not have to go around all the distros asking them to carry a patch
> > increasing this count (I assume they are already carrying such a patch
> > due to those 8 node systems)
> 
> I agree that 4 nodes is somewhat anemic; I've had to bump that just to
> run some scheduler tests under QEMU. However I still believe we should
> exercise caution before cranking it too high, especially when seeing things
> like:
> 
>   ee38d94a0ad8 ("page flags: prioritize kasan bits over last-cpuid")
> 
> To give some numbers, a defconfig build gives me:
> 
>   SECTIONS_WIDTH=0 ZONES_WIDTH=2 NODES_SHIFT=2 LAST_CPUPID_SHIFT=(8+8) KASAN_TAG_WIDTH=0
>   BITS_PER_LONG=64 NR_PAGEFLAGS=24
> 
> IOW, we need 18 + NODES_SHIFT <= 40 -> NODES_SHIFT <= 22. That looks to be
> plenty, however this can get cramped fairly easily with any combination of:
> 
>   CONFIG_SPARSEMEM_VMEMMAP=n (-18)
>   CONFIG_IDLE_PAGE_TRACKING=y (-2)
>   CONFIG_KASAN=y + CONFIG_KASAN_SW_TAGS (-8)
> 
> Taking Arnd's above example, a randconfig build picking !VMEMMAP already
> limits the NODES_SHIFT to 4 *if* we want to keep the CPUPID thing within
> the flags (it gets a dedicated field at the tail of struct page
> otherwise). If that is something we don't care too much about, then
> consider my concerns taken care of.

I don't think there's any value in allowing SPARSEMEM_VMEMMAP to be
disabled but the option is in the core mm/Kconfig file. We could make
NODES_SHIFT depend on SPARSEMEM_VMEMMAP (there's DISCONTIGMEM as well
but hopefully that's going away soon).

> One more thing though: NR_CPUS can be cranked up to 4096 but we've only set
> it to 256 IIRC to support the TX2. From that PoV, I'm agreeing with
> Anshuman in that we should set it to match the max encountered on platforms
> that are in use right now.

I agree. Let's bump NODES_SHIFT to 4 now to cover existing platforms. If
distros have a 10-year view, they can always ship a kernel configured to
64 nodes, no need to change Kconfig (distros never ship with defconfig).

It may have an impact on more memory constrained platforms but that's
not what defconfig is about. It should allow existing hardware to run
Linux but not necessarily run it in the most efficient way possible.

-- 
Catalin
