Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17192EA6EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbhAEJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:06:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:34506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbhAEJGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:06:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609837515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qfme980tm+tduA+38jzvx8uWWteTxfFCLjGWZG/RRP0=;
        b=iEDDIRAYACNIiw4EjMLe0VxZmvSdJSAFVNqcUBAiXlEWGZYwjJ+DtzggW5rWVdH5G0SG1e
        nHIjeCdzPIgwHaZBwmogrdrsdOtsQfoxZ65wFuDddUou8yH9/oyiEiFEa5mbchmiPsa4Y8
        xc1XY6rblgm6Iov6Fsl+cuI5vtoXSGk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE016AA35;
        Tue,  5 Jan 2021 09:05:14 +0000 (UTC)
Date:   Tue, 5 Jan 2021 10:05:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: uninitialized pmem struct pages
Message-ID: <20210105090513.GX13207@dhcp22.suse.cz>
References: <20210104151005.GK13207@dhcp22.suse.cz>
 <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
 <20210104153300.GL13207@dhcp22.suse.cz>
 <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
 <6106ca7f-3247-0916-3e1e-ad6af17272ea@redhat.com>
 <20210105080057.GT13207@dhcp22.suse.cz>
 <20210105081654.GU13207@dhcp22.suse.cz>
 <CAPcyv4jKKWqjgdpi3yiPCaFdfHYzPDrgAc1YvELEPogD3go2PA@mail.gmail.com>
 <20210105084224.GV13207@dhcp22.suse.cz>
 <CAPcyv4jYJdmRRhDCaT1j-s2pij3OnML7muWjgJRe9s65ujjZFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jYJdmRRhDCaT1j-s2pij3OnML7muWjgJRe9s65ujjZFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-01-21 00:57:43, Dan Williams wrote:
> On Tue, Jan 5, 2021 at 12:42 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 05-01-21 00:27:34, Dan Williams wrote:
> > > On Tue, Jan 5, 2021 at 12:17 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Tue 05-01-21 09:01:00, Michal Hocko wrote:
> > > > > On Mon 04-01-21 16:44:52, David Hildenbrand wrote:
> > > > > > On 04.01.21 16:43, David Hildenbrand wrote:
> > > > > > > On 04.01.21 16:33, Michal Hocko wrote:
> > > > > > >> On Mon 04-01-21 16:15:23, David Hildenbrand wrote:
> > > > > > >>> On 04.01.21 16:10, Michal Hocko wrote:
> > > > > > >> [...]
> > > > > > >>> Do the physical addresses you see fall into the same section as boot
> > > > > > >>> memory? Or what's around these addresses?
> > > > > > >>
> > > > > > >> Yes I am getting a garbage for the first struct page belonging to the
> > > > > > >> pmem section [1]
> > > > > > >> [    0.020161] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x603fffffff]
> > > > > > >> [    0.020163] ACPI: SRAT: Node 4 PXM 4 [mem 0x6060000000-0x11d5fffffff] non-volatile
> > > > > > >>
> > > > > > >> The pfn without the initialized struct page is 0x6060000. This is a
> > > > > > >> first pfn in a section.
> > > > > > >
> > > > > > > Okay, so we're not dealing with the "early section" mess I described,
> > > > > > > different story.
> > > > > > >
> > > > > > > Due to [1], is_mem_section_removable() called
> > > > > > > pfn_to_page(PHYS_PFN(0x6060000)). page_zone(page) made it crash, as not
> > > > > > > initialized.
> > > > > > >
> > > > > > > Let's assume this is indeed a reserved pfn in the altmap. What's the
> > > > > > > actual address of the memmap?
> > > > > > >
> > > > > > > I do wonder what hosts pfn_to_page(PHYS_PFN(0x6060000)) - is it actually
> > > > > > > part of the actual altmap (i.e. > 0x6060000) or maybe even self-hosted?
> > > > > > >
> > > > > > > If it's not self-hosted, initializing the relevant memmaps should work
> > > > > > > just fine I guess. Otherwise things get more complicated.
> > > > > >
> > > > > > Oh, I forgot: pfn_to_online_page() should at least in your example make
> > > > > > sure other pfn walkers are safe. It was just an issue of
> > > > > > is_mem_section_removable().
> > > > >
> > > > > Hmm, I suspect you are right. I haven't put this together, thanks! The memory
> > > > > section is indeed marked offline so pfn_to_online_page would indeed bail
> > > > > out:
> > > > > crash> p (0x6060000>>15)
> > > > > $3 = 3084
> > > > > crash> p mem_section[3084/128][3084 & 127]
> > > > > $4 = {
> > > > >   section_mem_map = 18446736128020054019,
> > > > >   usage = 0xffff902dcf956680,
> > > > >   page_ext = 0x0,
> > > > >   pad = 0
> > > > > }
> > > > > crash> p 18446736128020054019 & (1UL<<2)
> > > > > $5 = 0
> > > > >
> > > > > That makes it considerably less of a problem than I thought!
> > > >
> > > > Forgot to add that those who are running kernels without 53cdc1cb29e8
> > > > ("drivers/base/memory.c: indicate all memory blocks as removable") for
> > > > some reason can fix the crash by the following simple patch.
> > > >
> > > > Index: linux-5.3-users_mhocko_SLE15-SP2_for-next/drivers/base/memory.c
> > > > ===================================================================
> > > > --- linux-5.3-users_mhocko_SLE15-SP2_for-next.orig/drivers/base/memory.c
> > > > +++ linux-5.3-users_mhocko_SLE15-SP2_for-next/drivers/base/memory.c
> > > > @@ -152,9 +152,14 @@ static ssize_t removable_show(struct dev
> > > >                 goto out;
> > > >
> > > >         for (i = 0; i < sections_per_block; i++) {
> > > > -               if (!present_section_nr(mem->start_section_nr + i))
> > > > +               unsigned long nr = mem->start_section_nr + i;
> > > > +               if (!present_section_nr(nr))
> > > >                         continue;
> > > > -               pfn = section_nr_to_pfn(mem->start_section_nr + i);
> > > > +               if (!online_section_nr()) {
> > >
> > > I assume that's onlince_section_nr(nr) in the version that compiles?
> >
> > Yup.
> >
> > > This makes sense because the memory block size is larger than the
> > > section size. I suspect you have 1GB memory block size on this system,
> > > but since the System RAM and PMEM collide at a 512MB alignment in a
> > > memory block you end up walking the back end of the last 512MB of the
> > > System RAM memory block and run into the offline PMEM section.
> >
> > Sections are 128MB and memory blocks are 2GB on this system.
> >
> > > So, I don't think it's pfn_to_online_page that necessarily needs to
> > > know how to disambiguate each page, it's things that walk sections and
> > > memory blocks and expects them to be consistent over the span.
> >
> > Well, memory hotplug code is hard wired to sparse memory model so in
> > this particular case asking about the section is ok. But pfn walkers
> > shouldn't really care and only rely on pfn_to_online_page. But that will
> > do the right thing here. So we are good as long as the section is marked
> > properly. But this would become a problem as soon as the uninitialized
> > pages where sharing the same memory section as David pointed out.
> > pfn_to_online_page would then return something containing garbage. So we
> > should still think of a way to either initialize all those pages or make
> > sure pfn_to_online_page recognizes them. The former is preferred IMHO.
> 
> The former would not have saved the crash in this case because
> pfn_to_online_page() is not used in v5.3:removable_show() that I can
> see, nor some of the other paths that might walk pfns and the wrong
> thing with ZONE_DEVICE.

If the page was initialized properly, and by that I mean also have it
reserved, then the old code would have properly reported is as not
removable.

> However, I do think pfn_to_online_page() should be reliable, and I
> prefer to just brute force add a section flag to indicate whether the
> section might be ZONE_DEVICE polluted and fallback to the
> get_dev_pagemap() slow-path in that case.

Do we have some spare room to hold that flag in a section?

> ...but it would still require hunting to find the places where
> pfn_to_online_page() is missing for assumptions like this crash which
> assumed memblock-online + section-present == section-online.

Yes, but most users should be using pfn_to_online_page already.

-- 
Michal Hocko
SUSE Labs
