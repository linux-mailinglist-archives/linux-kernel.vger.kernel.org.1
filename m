Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCC32D3EEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgLIJhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:37:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:52180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgLIJhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:37:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 039D4AC94;
        Wed,  9 Dec 2020 09:36:22 +0000 (UTC)
Date:   Wed, 9 Dec 2020 10:36:19 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v3 1/4] mm,memory_hotplug: Add
 mhp_supports_memmap_on_memory
Message-ID: <20201209093608.GA30590@linux>
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-2-osalvador@suse.de>
 <c5b82d52-f1be-0701-e36b-49aae4bb5cdb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b82d52-f1be-0701-e36b-49aae4bb5cdb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:36:54AM +0100, David Hildenbrand wrote:
> Instead of adding these arch callbacks, what about a config option
> 
> ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> 
> that gets selected by the archs with CONFIG_SPARSEMEM_VMEMMAP ?
> 
> The mhp_supports_memmap_on_memory() becomes even more trivial.

I think that would not be enough.
E.g: s390x supports CONFIG_SPARSEMEM_VMEMMAP but it does not support
altmap (and maybe other arches I did not check too).
That is why I was careful in choosing the ones that a) supports
CONFIG_SPARSEMEM_VMEMMAP and b) support altmap

> > Note that mhp_memmap_on_memory kernel boot option will be added in
> > a coming patch.
> 
> I think it makes sense to
> 
> a) separate off the arch changes into separate patches, clarifying why
> it can be used. Move this patches to the end of the series.
> 
> b) Squashing the remainings into patch #2

Ok, I can do that.

> > +/*
> > + * We want memmap (struct page array) to be self contained.
> > + * To do so, we will use the beginning of the hot-added range to build
> > + * the page tables for the memmap array that describes the entire range.
> > + * Only selected architectures support it with SPARSE_VMEMMAP.
> 
> You might want to add how the caller can calculate the necessary size
> and that that this calculated piece of memory to be added will be
> accessed before onlining these pages. This is e.g., relevant if
> virtio-mem, the hyper-v balloon, or xen balloon would want to use this
> mechanism. Also, it's somewhat incompatible with standby memory where
> memory cannot be accessed prior to onlining. So pointing that access out
> might be valuable.

Sure, I will be more verbose.

> You can simplify to
> 
> return arch_support_memmap_on_memory() &&
>        IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>        size == memory_block_size_bytes();

Yeah, thanks ;-)

-- 
Oscar Salvador
SUSE L3
