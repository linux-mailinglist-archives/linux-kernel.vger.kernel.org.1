Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F62A4BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgKCQvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCQvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:51:43 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A364F20709;
        Tue,  3 Nov 2020 16:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604422302;
        bh=ltFWbwZrKzlRod8Ro/4wG6vMt94SJxaRjMtj1TLMLYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQdZwz6qSkFP7g8HiqaXmRItKdiuPmA3b/89ZigFPfM+QNyFJ7qO4NcRNf830wSRS
         R+sL56de+WHAQIIJx3bhWqgcQQLsgy2ccFyTuOhz/Pbr9c4FY60sCCbbw7rbb9asSx
         sKgdTAe6PpIiHcbikl84KlDdGFr90ZoCWhA3rSuo=
Date:   Tue, 3 Nov 2020 18:51:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: mm/memblock: export memblock_{start/end}_of_DRAM
Message-ID: <20201103165134.GL4879@kernel.org>
References: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
 <20201030083842.GA4319@kernel.org>
 <ad242b868a291223218a33c05d6729fd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad242b868a291223218a33c05d6729fd@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:51:25PM -0800, Sudarshan Rajagopalan wrote:
> On 2020-10-30 01:38, Mike Rapoport wrote:
> > On Thu, Oct 29, 2020 at 02:29:27PM -0700, Sudarshan Rajagopalan wrote:
> > > Hello all,
> > > 
> > > We have a usecase where a module driver adds certain memory blocks
> > > using
> > > add_memory_driver_managed(), so that it can perform memory hotplug
> > > operations on these blocks. In general, these memory blocks aren’t
> > > something
> > > that gets physically added later, but is part of actual RAM that
> > > system
> > > booted up with. Meaning – we set the ‘mem=’ cmdline parameter to
> > > limit the
> > > memory and later add the remaining ones using add_memory*() variants.
> > > 
> > > The basic idea is to have driver have ownership and manage certain
> > > memory
> > > blocks for hotplug operations.
> > > 
> > > For the driver be able to know how much memory was limited and how
> > > much
> > > actually present, we take the delta of ‘bootmem physical end
> > > address’ and
> > > ‘memblock_end_of_DRAM’. The 'bootmem physical end address' is
> > > obtained by
> > > scanning the reg values in ‘memory’ DT node and determining the max
> > > {addr,size}. Since our driver is getting modularized, we won’t have
> > > access
> > > to memblock_end_of_DRAM (i.e. end address of all memory blocks after
> > > ‘mem=’
> > > is applied).
> > > 
> > > So checking if memblock_{start/end}_of_DRAM() symbols can be
> > > exported? Also,
> > > this information can be obtained by userspace by doing ‘cat
> > > /proc/iomem’ and
> > > greping for ‘System RAM’. So wondering if userspace can have access
> > > to such
> > > info, can we allow kernel module drivers have access by exporting
> > > memblock_{start/end}_of_DRAM().
> > 
> > These functions cannot be exported not because we want to hide this
> > information from the modules but because it is unsafe to use them.
> > On most architecturs these functions are __init so they are discarded
> > after boot anyway. Beisdes, the memory configuration known to memblock
> > might be not accurate in many cases as David explained in his reply.
> > 
> 
> I don't see how information contained in memblock_{start/end}_of_DRAM() is
> considered hidden if the information can be obtained using 'cat
> /proc/iomem'. The memory resource manager adds these blocks either in
> "System RAM", "reserved", "Kernel data/code" etc. Inspecting this, one could
> determine whats the start and end of memblocks.

I'm not saying that the memblock data is considered hidden. On most
systems it is simply not present after boot. And even if it is not
discarded, it might be not accurate on any arch except arm64.

> I agree on the part that its __init annotated and could be removed after
> boot. This is something that the driver can be vary of too.
> 
> > > Or are there any other ways where a module driver can get the end
> > > address of
> > > system memory block?
> > 
> > What do you mean by "system memory block"? There could be a lot of
> > interpretations if you take into account memory hotplug, "mem=" option,
> > reserved and firmware memory.
> 
> I meant the physical end address of memblock. The equivalent of
> memblock_end_of_DRAM.

> > I'd suggest you to describe the entire use case in more detail. Having
> > the complete picture would help finding a proper solution.
> 
> The usecase in general is have a way to add/remove and online/offline
> certain memory blocks which are part of boot. We do this by limiting the
> memory using "mem=" and latter add the remaining blocks using
> add_memory_driver_mamanaged().

I think such infrastructure should be a part of core mm rather than
external out-of-tree driver.

> Sudarshan
> 
-- 
Sincerely yours,
Mike.
