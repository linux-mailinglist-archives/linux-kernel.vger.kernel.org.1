Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1F52EA61A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbhAEHlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:41:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:37162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbhAEHlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:41:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609832453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P7COg91NEwnP/uoCOSBzJuMmSS7WoPNptWSZsUU3f/o=;
        b=EgoV3I74xEMcKMjMn8KSvPeJlhAkzWHkNZaQLGiBRNeJIO6Alplk6EH2ruegnoHQvvBMgg
        2Bqc9PoIiiuGaWSwqibh6awULQORFO22w9Za4LKdSFqgoiu0osr4d+0cdvodYvpqEHsLqx
        iitl2vtvJ3rH85xTolJbWwD8ByKKRKU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5993AAA35;
        Tue,  5 Jan 2021 07:40:53 +0000 (UTC)
Date:   Tue, 5 Jan 2021 08:40:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: uninitialized pmem struct pages
Message-ID: <20210105074052.GQ13207@dhcp22.suse.cz>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz>
 <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz>
 <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
 <20210104153300.GL13207@dhcp22.suse.cz>
 <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
 <20210104155931.GN13207@dhcp22.suse.cz>
 <CAPcyv4jGhvfDeFkY=R9+2QB3vZvRfJ=6s9o29U7msVemGhJjzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jGhvfDeFkY=R9+2QB3vZvRfJ=6s9o29U7msVemGhJjzw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 21:33:06, Dan Williams wrote:
> On Mon, Jan 4, 2021 at 7:59 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Not sure what exactly you are asking for but crash says
> > crash> kmem -p 6060000
> >       PAGE          PHYSICAL      MAPPING       INDEX CNT FLAGS
> > fffff8c600181800     6060000                0        0  0 fffffc0000000
> >
> > > I do wonder what hosts pfn_to_page(PHYS_PFN(0x6060000)) - is it actually
> > > part of the actual altmap (i.e. > 0x6060000) or maybe even self-hosted?
> >
> > I am not really familiar with the pmem so I would need more assistance
> > here. I've tried this (shot into the dark):
> > crash> struct page.pgmap fffff8c600181800
> >       pgmap = 0xfffff8c600181808
> 
> Does /proc/iomem show an active namespace in the range?

Any tips how I dig that out from the crash dump?

> You should be
> able to skip ahead to the first pfn in that namespace to find the
> first dev_pagemap. I would have expected pfn_to_online_page() to have
> saved you here. This address range is section aligned.

Well, the affected code in this case was 
	end_pfn = min(start_pfn + nr_pages,
                        zone_end_pfn(page_zone(pfn_to_page(start_pfn))));
where start_pfn was the first pfn of a memory section. This code was
completely unaware of zone device or dev_pagemap like most others pfn
walkers. It just wanted to get bounds for the zone but it stumbled over
uninitialized zone/node.
-- 
Michal Hocko
SUSE Labs
