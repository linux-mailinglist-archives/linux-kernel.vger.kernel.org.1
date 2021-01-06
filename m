Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE182EBD37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 12:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAFLiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 06:38:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:35802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbhAFLiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:38:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609933084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7Nwai2b36E4PhjVqMjGa8YBAPAahmnOcM2dSGchQYc=;
        b=f9M8+8NJbvL9i4aGj8NPFHBx549GQTh/WlzgJUZxSHClZvzf8cQDu4Ofc4+gaM2s7EBQMV
        DpyApGDOAtoNf0WC7+z1ljZt3O5w8lHBt2PDNV1slYLbzFuFZ4JC7/AGeAq1u5847Mm2iy
        qaK2+UhBgMn31EM7qxH9bGz1SZ5G0QQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCDB2AA35;
        Wed,  6 Jan 2021 11:38:04 +0000 (UTC)
Date:   Wed, 6 Jan 2021 12:38:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section
 collisions
Message-ID: <20210106113804.GL13207@dhcp22.suse.cz>
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <785b9095-eca4-8100-33ea-6ae84e02a92e@redhat.com>
 <20210106104255.GK13207@dhcp22.suse.cz>
 <7d7c5dc4-7784-5dcc-fc00-4fe99f0a4a90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7c5dc4-7784-5dcc-fc00-4fe99f0a4a90@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 12:22:57, David Hildenbrand wrote:
> On 06.01.21 11:42, Michal Hocko wrote:
> > On Wed 06-01-21 10:56:19, David Hildenbrand wrote:
> > [...]
> >> Note that this is not sufficient in the general case. I already
> >> mentioned that we effectively override an already initialized memmap.
> >>
> >> ---
> >>
> >> [        SECTION             ]
> >> Before:
> >> [ ZONE_NORMAL ][    Hole     ]
> >>
> >> The hole has some node/zone (currently 0/0, discussions ongoing on how
> >> to optimize that to e.g., ZONE_NORMAL in this example) and is
> >> PG_reserved - looks like an ordinary memory hole.
> >>
> >> After memremap:
> >> [ ZONE_NORMAL ][ ZONE_DEVICE ]
> >>
> >> The already initialized memmap was converted to ZONE_DEVICE. Your
> >> slowpath will work.
> >>
> >> After memunmap (no poisioning):
> >> [ ZONE_NORMAL ][ ZONE_DEVICE ]
> >>
> >> The slow path is no longer working. pfn_to_online_page() might return
> >> something that is ZONE_DEVICE.
> >>
> >> After memunmap (poisioning):
> >> [ ZONE_NORMAL ][ POISONED    ]
> >>
> >> The slow path is no longer working. pfn_to_online_page() might return
> >> something that will BUG_ON via page_to_nid() etc.
> >>
> >> ---
> >>
> >> Reason is that pfn_to_online_page() does no care about sub-sections. And
> >> for now, it didn't had to. If there was an online section, it either was
> >>
> >> a) Completely present. The whole memmap is initialized to sane values.
> >> b) Partially present. The whole memmap is initialized to sane values.
> >>
> >> memremap/memunmap messes with case b)
> > 
> > I do not see we ever clear the newly added flag and my understanding is
> > that the subsection removed would lead to get_dev_pagemap returning a
> > NULL. Which would obviously need to be checked for pfn_to_online_page.
> > Or do I miss anything and the above is not the case and we could still
> > get false positives?
> 
> See my example above ("After memunmap").
> 
> We're still in the slow pathg. pfn_to_online_page() will return a struct
> page as get_dev_pagemap() is now  NULL.

Yeah, my bad. I have clearly misread the patch. We would need som other
means than relying on get_dev_pagemap if it doesn't survive the
memunmap. :/
-- 
Michal Hocko
SUSE Labs
