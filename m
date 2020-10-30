Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA532A002D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgJ3Iiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3Iiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:38:51 -0400
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FB62075E;
        Fri, 30 Oct 2020 08:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604047130;
        bh=5pnaYeg0slp/C6LJW0tZt7NwF2KtZxhAKuysRfnP6vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gub5VpJy/YKwwNSXMPAehOYKrC3ZbBRzR+owx6+zxhiDElhexw2Rjmwo8LSt+G9qO
         DphIEXohytWWawhFH2y7mnynjSHE/ZNRtpKmHZYAKratdTBUOeJ5Hpd2U+St3EbTf2
         fhtkkWeIaBP95rcXFwQ1RMEiJd1jZPaJUolALiSE=
Date:   Fri, 30 Oct 2020 10:38:42 +0200
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
Message-ID: <20201030083842.GA4319@kernel.org>
References: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 02:29:27PM -0700, Sudarshan Rajagopalan wrote:
> Hello all,
> 
> We have a usecase where a module driver adds certain memory blocks using
> add_memory_driver_managed(), so that it can perform memory hotplug
> operations on these blocks. In general, these memory blocks aren’t something
> that gets physically added later, but is part of actual RAM that system
> booted up with. Meaning – we set the ‘mem=’ cmdline parameter to limit the
> memory and later add the remaining ones using add_memory*() variants.
> 
> The basic idea is to have driver have ownership and manage certain memory
> blocks for hotplug operations.
> 
> For the driver be able to know how much memory was limited and how much
> actually present, we take the delta of ‘bootmem physical end address’ and
> ‘memblock_end_of_DRAM’. The 'bootmem physical end address' is obtained by
> scanning the reg values in ‘memory’ DT node and determining the max
> {addr,size}. Since our driver is getting modularized, we won’t have access
> to memblock_end_of_DRAM (i.e. end address of all memory blocks after ‘mem=’
> is applied).
> 
> So checking if memblock_{start/end}_of_DRAM() symbols can be exported? Also,
> this information can be obtained by userspace by doing ‘cat /proc/iomem’ and
> greping for ‘System RAM’. So wondering if userspace can have access to such
> info, can we allow kernel module drivers have access by exporting
> memblock_{start/end}_of_DRAM().

These functions cannot be exported not because we want to hide this
information from the modules but because it is unsafe to use them.
On most architecturs these functions are __init so they are discarded
after boot anyway. Beisdes, the memory configuration known to memblock
might be not accurate in many cases as David explained in his reply.

> Or are there any other ways where a module driver can get the end address of
> system memory block?
 
What do you mean by "system memory block"? There could be a lot of
interpretations if you take into account memory hotplug, "mem=" option,
reserved and firmware memory.

I'd suggest you to describe the entire use case in more detail. Having
the complete picture would help finding a proper solution.

> Sudarshan
> 

--
Sincerely yours,
Mike.
