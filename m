Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF742E9A87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbhADQLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:11:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:54636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbhADQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:00:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609775972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2TfnFOGUvyeB9YoMIAEOhEsC9AvA3aFr1YVlOG6Ieo=;
        b=VJgn/Eu4KPx87UZLuqWg8tmdI8kcJ/JImCeLXKaPdpc4JftuKTDkHlvTEqMsygz1D4fbaj
        8j/i4kyaijW3kiNLgIIVEcVzTm0nqy0TQ7HiUwij9ePrn5ShGl5Q16LAkEQa4hBTfrdo0z
        TucpSifh6L8nSmbrg1XfguYnfeU88HM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CD29AE2B;
        Mon,  4 Jan 2021 15:59:32 +0000 (UTC)
Date:   Mon, 4 Jan 2021 16:59:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: uninitialized pmem struct pages
Message-ID: <20210104155931.GN13207@dhcp22.suse.cz>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz>
 <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz>
 <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
 <20210104153300.GL13207@dhcp22.suse.cz>
 <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 16:43:49, David Hildenbrand wrote:
> On 04.01.21 16:33, Michal Hocko wrote:
> > On Mon 04-01-21 16:15:23, David Hildenbrand wrote:
> >> On 04.01.21 16:10, Michal Hocko wrote:
> > [...]
> >> Do the physical addresses you see fall into the same section as boot
> >> memory? Or what's around these addresses?
> > 
> > Yes I am getting a garbage for the first struct page belonging to the
> > pmem section [1]
> > [    0.020161] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x603fffffff]
> > [    0.020163] ACPI: SRAT: Node 4 PXM 4 [mem 0x6060000000-0x11d5fffffff] non-volatile
> > 
> > The pfn without the initialized struct page is 0x6060000. This is a
> > first pfn in a section.
> 
> Okay, so we're not dealing with the "early section" mess I described,
> different story.
> 
> Due to [1], is_mem_section_removable() called
> pfn_to_page(PHYS_PFN(0x6060000)). page_zone(page) made it crash, as not
> initialized.

Exactly!

> Let's assume this is indeed a reserved pfn in the altmap. What's the
> actual address of the memmap?

Not sure what exactly you are asking for but crash says
crash> kmem -p 6060000
      PAGE          PHYSICAL      MAPPING       INDEX CNT FLAGS
fffff8c600181800     6060000                0        0  0 fffffc0000000
 
> I do wonder what hosts pfn_to_page(PHYS_PFN(0x6060000)) - is it actually
> part of the actual altmap (i.e. > 0x6060000) or maybe even self-hosted?

I am not really familiar with the pmem so I would need more assistance
here. I've tried this (shot into the dark):
crash> struct page.pgmap fffff8c600181800
      pgmap = 0xfffff8c600181808
crash> struct -x dev_pagemap 0xfffff8c600181808
struct dev_pagemap {
  altmap = {
    base_pfn = 0xfffff8c600181808, 
    end_pfn = 0xfffff8c600181808, 
    reserve = 0x0, 
    free = 0x0, 
    align = 0x0, 
    alloc = 0xffffffff
  }, 
  res = {
    start = 0x0, 
    end = 0xfffffc0000000, 
    name = 0xfffff8c600181848 "H\030\030", 
    flags = 0xfffff8c600181848, 
    desc = 0x0, 
    parent = 0x0, 
    sibling = 0x0, 
    child = 0xffffffff
  }, 
  ref = 0x0, 
  internal_ref = {
    count = {
      counter = 0xfffffc0000000
    }, 
    percpu_count_ptr = 0xfffff8c600181888, 
    release = 0xfffff8c600181888, 
    confirm_switch = 0x0, 
    force_atomic = 0x0, 
    allow_reinit = 0x0, 
    rcu = {
      next = 0x0, 
      func = 0xffffffff
    }
  }, 
  done = {
    done = 0x0, 
    wait = {
      lock = {
        {
          rlock = {
            raw_lock = {
              {
                val = {
                  counter = 0xc0000000
                }, 
                {
                  locked = 0x0, 
                  pending = 0x0
                }, 
                {
                  locked_pending = 0x0, 
                  tail = 0xc000
                }
              }
            }
          }
        }
      }, 
      head = {
        next = 0xfffff8c6001818c8, 
        prev = 0xfffff8c6001818c8
      }
    }
  }, 
  dev = 0x0, 
  type = 0, 
  flags = 0x0, 
  ops = 0x0
}

Not sure whether this is of any use.
 
> If it's not self-hosted, initializing the relevant memmaps should work
> just fine I guess. Otherwise things get more complicated.

-- 
Michal Hocko
SUSE Labs
