Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04F52EC467
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbhAFUDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbhAFUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:03:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB2FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 12:03:02 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ga15so6732937ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qo74SNxBRzE7jEcHLiGlvWl2XU+3/X3BlAwXU5Tlukc=;
        b=v6wWef2R9dxJyWPfJ27SmbgkvLAgJTLJrR8TGAZY0TVKm5mjjrpyGwFC1+p+wEjk3K
         bx80Q1irXT/aw/6p0iFQGF9LdAzwGpc+WHZ/uV+oFrVOOpPxImw8wSy0gCakoYhmLYRj
         vu+uiZW2GjsF2XsB09pGc9nHgVUd/9aHwAEw42JaGyF7p1TAAXFCmp9rx0epW1387AaS
         0bo2Zldk52ppJRBpy2IUeDFr3DPE6XOEkrOFrJzP60LqeffanhcYIvWtE7PdKyR0rd3b
         AGJGT8viZOu6JQOD4r/7UtXTooi48AHGT6o2SzubUEIuRh+Ma7hyk71x3dktuEQHol6t
         rUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qo74SNxBRzE7jEcHLiGlvWl2XU+3/X3BlAwXU5Tlukc=;
        b=jL57ErbfitWZb6Bk+RGcl6LLPDNjYxcMXyievZUtLxTGCmCFnPARp9i8FuRv1n4yr7
         DMPCG/BBUdTQQv59g0iG5fwspIkanKXQqMVF67/FKRYFhafwjDSEZPJNp8VAze8bQmDf
         1rXqV5WRj5WH7/2xUL9lrhN9fCvbb5YUDHq/rtGNxS4VzBawPWHnyX25Sv7Rgj/zbX7G
         sJ0GhDgaSmz6yXTb2KQFK5SBEDUX4GVvAHegM0F5hd8H0M4iq+z9vEi2cnILHlrW+AlL
         3pB/6rDB62LDD+4C4JwoOv7Zg+f/cPUzBnEG57htAQSuJRN08/Niqg8mcnXRcLGRGLrU
         QrUQ==
X-Gm-Message-State: AOAM5303wY8LsDz6bhJenP27dAUEzmaieET+cPqURGZ58d7tJ9MNI9fU
        rxg4+YxDyAm6nYhkXLL37o4mBuxVToSLVtbII5lkWA==
X-Google-Smtp-Source: ABdhPJz/eZOahwvUGIhOCo6IyZBDGJON3yP3sTwT45bJBjf/sI20Gv0PBTTRmCDg9BekHP/oVX9aYsXHKIcRN7kQ5wE=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr4030704ejc.418.1609963381149;
 Wed, 06 Jan 2021 12:03:01 -0800 (PST)
MIME-Version: 1.0
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <785b9095-eca4-8100-33ea-6ae84e02a92e@redhat.com> <20210106104255.GK13207@dhcp22.suse.cz>
 <7d7c5dc4-7784-5dcc-fc00-4fe99f0a4a90@redhat.com>
In-Reply-To: <7d7c5dc4-7784-5dcc-fc00-4fe99f0a4a90@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Jan 2021 12:02:49 -0800
Message-ID: <CAPcyv4iN4t2P_rQS23E7Bb-eLUAt389Y5t4X-yoRQrxvsN3DWQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section collisions
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 3:23 AM David Hildenbrand <david@redhat.com> wrote:
>
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
>
> Yet page_zone(page) will either
> - BUG_ON (memmap was poisoned)
> - return ZONE_DEVICE zone (memmap not poisoned when memunmapping)
>
> As I said, can be tackled by checking for pfn_section_valid() at least
> on the slow path. Ideally also on the fast path.

Good eye, I glazed over that the existing pfn_section_valid() check in
pfn_valid() is obviated by early_section(). I'll respin with a
standalone pfn_section_valid() gate in pfn_to_online_page().

>
> >
> >> Well have to further tweak pfn_to_online_page(). You'll have to also
> >> check pfn_section_valid() *at least* on the slow path. Less-hacky would
> >> be checking it also in the "somehwat-faster" path - that would cover
> >> silently overriding a memmap that's visible via pfn_to_online_page().
> >> Might slow down things a bit.
> >>
> >>
> >> Not completely opposed to this, but I would certainly still prefer just
> >> avoiding this corner case completely instead of patching around it. Thanks!
> >
> > Well, I would love to have no surprises either. So far there was not
> > actual argument why the pmem reserved space cannot be fully initialized.
>
> Yes, I'm still hoping Dan can clarify that.

Complexity and effective utility (once pfn_to_online_page() is fixed)
are the roadblocks in my mind. The altmap is there to allow for PMEM
capacity to be used as memmap space, so there would need to be code to
break that circular dependency and allocate a memmap for the metadata
space from DRAM and the rest of the memmap space for the data capacity
from pmem itself. That memmap-for-pmem-metadata will still represent
offline pages. So once pfn_to_online_page() is fixed, what pfn-walker
is going to be doing pfn_to_page() on PMEM metadata? Secondly, there
is a PMEM namespace mode called "raw" that eschews DAX and 'struct
page' for pmem and just behaves like a memory-backed block device. The
end result is still that pfn walkers need to discover if a PMEM pfn
has a page, so I don't see what "sometimes there's an
memmap-for-pmem-metadata" buys us?

>
> > On the other hand making sure that pfn_to_online_page sounds like the
> > right thing to do. And having an explicit check for zone device there in
> > a slow path makes sense to me.
>
> As I said, I'd favor to simplify and just get rid of the special case,
> instead of coming up with increasingly complex ways to deal with it.
> pfn_to_online_page() used to be simple, essentially checking a single
> flag was sufficient in most setups.

I think the logic to throw away System RAM that might collide with
PMEM and soft-reserved memory within a section is on the order of the
same code complexity as the patch proposed here, no? Certainly the
throw-away concept itself is easier to grasp, but I don't think that
would be reflected in the code patch to achieve it... willing to be
proved wrong with a patch.
