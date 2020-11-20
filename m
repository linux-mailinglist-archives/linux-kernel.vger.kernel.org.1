Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0362BB834
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgKTVRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgKTVRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:17:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E4C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PSvZ/V3hJPQm5eQAOv/bPZGbNpjwCHr1HibjUj9KFYU=; b=kf1qDma2luPsYIqJ/FUFFRoFIn
        m1/WSwGdytFgqwD+TrR++qy82KIODyPULbRDB7bys5Z/AjxMYurrjtxzsuWiaEJ3TbjSPItms1h2M
        +Cxhi80yPG/35YLHTrKWq5onJe+TUTjI8uTdKJmC8b7NY+BRRD4pIRF1P/x8t5nqRLLBaV14/vWQq
        +CCRKQi5I6uYosNQa9lBZu4F41yfyvtCJLHZZ5sQnMbg8uVQNLQHCVAAasto98KULnaGh/CirnpqL
        w0LuYBGi4a68M3m/u50kScjU25A0pcl6IBR/vpG3Sc/FwlsFJdEmo+Rr/xQnwt5BJeDzMEUl+rWtJ
        YXskBatQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kgDmF-0000k7-PU; Fri, 20 Nov 2020 21:17:07 +0000
Date:   Fri, 20 Nov 2020 21:17:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com
Subject: Re: Pinning ZONE_MOVABLE pages
Message-ID: <20201120211707.GC4327@casper.infradead.org>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <9452B231-23F3-48F5-A0E2-D6C5603F87F1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9452B231-23F3-48F5-A0E2-D6C5603F87F1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:59:24PM +0100, David Hildenbrand wrote:
> 
> > Am 20.11.2020 um 21:28 schrieb Pavel Tatashin <pasha.tatashin@soleen.com>:
> > 
> > ﻿Recently, I encountered a hang that is happening during memory hot
> > remove operation. It turns out that the hang is caused by pinned user
> > pages in ZONE_MOVABLE.
> > 
> > Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
> > this is not the case if a user applications such as through dpdk
> > libraries pinned them via vfio dma map. Kernel keeps trying to
> > hot-remove them, but refcnt never gets to zero, so we are looping
> > until the hardware watchdog kicks in.
> > 
> > We cannot do dma unmaps before hot-remove, because hot-remove is a
> > slow operation, and we have thousands for network flows handled by
> > dpdk that we just cannot suspend for the duration of hot-remove
> > operation.
> > 
> 
> Hi!
> 
> It‘s a known problem also for VMs using vfio. I thought about this some while ago an came to the same conclusion: before performing long-term pinnings, we have to migrate pages off the movable zone. After that, it‘s too late.

We can't, though.  VMs using vfio pin their entire address space (right?)
so we end up with basically all of the !MOVABLE memory used for VMs and
the MOVABLE memory goes unused (I'm thinking about the case of a machine
which only hosts VMs and has nothing else to do with its memory).  In
that case, the sysadmin is going to reconfigure ZONE_MOVABLE away, and
now we just don't have any ZONE_MOVABLE.  So what's the point?

ZONE_MOVABLE can also be pinned by mlock() and other such system calls.
The kernel needs to understand that ZONE_MOVABLE memory may not actually
be movable, and skip the unmovable stuff.
