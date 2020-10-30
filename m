Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209ED29FDEF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 07:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgJ3GoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 02:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgJ3GoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 02:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604040241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYxMylt0sxpBW5aagScW+aC0G3Hu64EJitlvKMN9xxM=;
        b=H2VtgW8w8kypjtaTPUvnQr2XQIW4IEafYzzGKW4D9hDHP0t453VIiKcl/1cYgYA24CRy2d
        VjpWzAJ9v5XFnpJaoBAB+I2Wm8ujhsGJbzrzxLhQGAQcIEbktUmLzu9MRjCgkn8tqB/GIW
        2wSKrAmL/oHNAFOPlTy/tCcrmd002jI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-CN9of5O-Pd6w8RAdv3Ocvg-1; Fri, 30 Oct 2020 02:41:44 -0400
X-MC-Unique: CN9of5O-Pd6w8RAdv3Ocvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32B3034914;
        Fri, 30 Oct 2020 06:41:42 +0000 (UTC)
Received: from [10.36.112.97] (ovpn-112-97.ams2.redhat.com [10.36.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 758B46EF6F;
        Fri, 30 Oct 2020 06:41:39 +0000 (UTC)
Subject: Re: mm/memblock: export memblock_{start/end}_of_DRAM
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
References: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7b50c0fa-bbeb-1041-c05c-2667134044b6@redhat.com>
Date:   Fri, 30 Oct 2020 07:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.10.20 22:29, Sudarshan Rajagopalan wrote:
> Hello all,
> 

Hi!

> We have a usecase where a module driver adds certain memory blocks using
> add_memory_driver_managed(), so that it can perform memory hotplug
> operations on these blocks. In general, these memory blocks aren’t
> something that gets physically added later, but is part of actual RAM
> that system booted up with. Meaning – we set the ‘mem=’ cmdline
> parameter to limit the memory and later add the remaining ones using
> add_memory*() variants.
> 
> The basic idea is to have driver have ownership and manage certain
> memory blocks for hotplug operations.

So, in summary, you're still abusing the memory hot(un)plug 
infrastructure from your driver - just not in a severe way as before. 
And I'll tell you why, so you might understand why exposing this API is 
not really a good idea and why your driver wouldn't - for example - be 
upstream material.

Don't get me wrong, what you are doing might be ok in your context, but 
it's simply not universally applicable in our current model.

Ordinary system RAM works different than many other devices (like PCI 
devices) whereby *something* senses the device and exposes it to the 
system, and some available driver binds to it and owns the memory.

Memory is detected by a driver and added to the system via e.g., 
add_memory_driver_managed(). Memory devices are created and the memory 
is directly handed off to the system, to be used as system RAM as soon 
as memory devices are onlined. There is no driver that "binds" memory 
like other devices - it's rather the core (buddy) that uses/owns that 
memory immediately after device creation.

> 
> For the driver be able to know how much memory was limited and how much
> actually present, we take the delta of ‘bootmem physical end address’
> and ‘memblock_end_of_DRAM’. The 'bootmem physical end address' is
> obtained by scanning the reg values in ‘memory’ DT node and determining
> the max {addr,size}. Since our driver is getting modularized, we won’t
> have access to memblock_end_of_DRAM (i.e. end address of all memory
> blocks after ‘mem=’ is applied).

What you do with "mem=" is force memory detection to ignore some of it's 
detected memory.

> 
> So checking if memblock_{start/end}_of_DRAM() symbols can be exported?
> Also, this information can be obtained by userspace by doing ‘cat
> /proc/iomem’ and greping for ‘System RAM’. So wondering if userspace can

Not correct: with "mem=", cat /proc/iomem only shows *detected* + added 
system RAM, not the unmodified detection.

> have access to such info, can we allow kernel module drivers have access
> by exporting memblock_{start/end}_of_DRAM().
> 
> Or are there any other ways where a module driver can get the end
> address of system memory block?

And here is our problem: You disabled *detection* of that memory by the 
responsible driver (here: core). Now your driver wants to know what 
would have been detected. Assume you have memory hole in that region - 
it would not work by simply looking at start/end. You're driver is not 
the one doing the detection.

Another issue is: when using such memory for KVM guests, there is no 
mechanism that tracks ownership of that memory - imagine another driver 
wanting to use that memory. This really only works in special environments.

Yet another issue: you cannot assume that memblock data will stay around 
after boot. While we do it right now for arm64, that might change at 
some point. This is also one of the reasons why we don't export any real 
memblock data to drivers.


When using "mem=" you have to know the exact layout of your system RAM 
and communicate the right places how that layout looks like manually: 
here, to your driver.

The clean way of doing things today is to allocate RAM and use it for 
guests - e.g., using hugetlb/gigantic pages. As I said, there are other 
techniques coming up to deal with minimizing struct page overhead - if 
that's what you're concerned with (I still don't know why you're 
removing the memory from the host when giving it to the guest).

-- 
Thanks,

David / dhildenb

