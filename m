Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CA2EBCA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbhAFKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:43:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:35446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbhAFKns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:43:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609929781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GG7/WfWjFg7HmMqm1r9UvZA47ZQRvGK/QFKsgnLBag8=;
        b=Nqjs9A6doM4Eyhsu2K3pyah9DaBWnDmoT/2f/7WDonwvLvK1MClOhL4McUr6SxQ/TL/DSc
        m3il7pMsPj6HyQr1r3keyPBv9JCgqhculoghp9vBYfNNsuaJzq53zYs6xn+JXM4+kBxpSH
        y7q7ThejLj8/zKA3m8jWjg8/J964dUY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4FAFABC4;
        Wed,  6 Jan 2021 10:43:01 +0000 (UTC)
Date:   Wed, 6 Jan 2021 11:42:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section
 collisions
Message-ID: <20210106104255.GK13207@dhcp22.suse.cz>
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <785b9095-eca4-8100-33ea-6ae84e02a92e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785b9095-eca4-8100-33ea-6ae84e02a92e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 10:56:19, David Hildenbrand wrote:
[...]
> Note that this is not sufficient in the general case. I already
> mentioned that we effectively override an already initialized memmap.
> 
> ---
> 
> [        SECTION             ]
> Before:
> [ ZONE_NORMAL ][    Hole     ]
> 
> The hole has some node/zone (currently 0/0, discussions ongoing on how
> to optimize that to e.g., ZONE_NORMAL in this example) and is
> PG_reserved - looks like an ordinary memory hole.
> 
> After memremap:
> [ ZONE_NORMAL ][ ZONE_DEVICE ]
> 
> The already initialized memmap was converted to ZONE_DEVICE. Your
> slowpath will work.
> 
> After memunmap (no poisioning):
> [ ZONE_NORMAL ][ ZONE_DEVICE ]
> 
> The slow path is no longer working. pfn_to_online_page() might return
> something that is ZONE_DEVICE.
> 
> After memunmap (poisioning):
> [ ZONE_NORMAL ][ POISONED    ]
> 
> The slow path is no longer working. pfn_to_online_page() might return
> something that will BUG_ON via page_to_nid() etc.
> 
> ---
> 
> Reason is that pfn_to_online_page() does no care about sub-sections. And
> for now, it didn't had to. If there was an online section, it either was
> 
> a) Completely present. The whole memmap is initialized to sane values.
> b) Partially present. The whole memmap is initialized to sane values.
> 
> memremap/memunmap messes with case b)

I do not see we ever clear the newly added flag and my understanding is
that the subsection removed would lead to get_dev_pagemap returning a
NULL. Which would obviously need to be checked for pfn_to_online_page.
Or do I miss anything and the above is not the case and we could still
get false positives?

> Well have to further tweak pfn_to_online_page(). You'll have to also
> check pfn_section_valid() *at least* on the slow path. Less-hacky would
> be checking it also in the "somehwat-faster" path - that would cover
> silently overriding a memmap that's visible via pfn_to_online_page().
> Might slow down things a bit.
> 
> 
> Not completely opposed to this, but I would certainly still prefer just
> avoiding this corner case completely instead of patching around it. Thanks!

Well, I would love to have no surprises either. So far there was not
actual argument why the pmem reserved space cannot be fully initialized.
On the other hand making sure that pfn_to_online_page sounds like the
right thing to do. And having an explicit check for zone device there in
a slow path makes sense to me.
-- 
Michal Hocko
SUSE Labs
