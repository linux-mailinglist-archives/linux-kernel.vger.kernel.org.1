Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224402EA6D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbhAEI6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbhAEI6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:58:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88646C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 00:57:51 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ce23so40246489ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 00:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzN2o2LdBqrUYg8vvHhs6dHiXB1i+wevas9zOqN/X00=;
        b=B+SbppEJZY5i8jO/nmkf2E7nH16EDj8jES6Xtbzp3wjTjHnYlFrTJCXJcUZrF6Ba7e
         A5tHYzNYH/2Sv06M4WhaKv1+OPhP5tjWVAByRsYJPDV3hBp1s9HPqJyDaYvenNQ40y33
         +/tRXRmsd926ojJUtTog0H6ZKQOa/qGMzME5Cpn4xfWQr6cbmFN2ghzrmsG2lc+kTsH+
         FOiQoynxF6H7K/08dR9K32Z9HpeCPbIAsT2/NwQvkxP3tHmNm1QhCoaiG5U2u6qHWu+6
         2mFIUyn1AgJoZ2URClW81pBRRXHURSLTjSKobxuECtJ5jbnhEviHzb+O328KWa5zBaIi
         yTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzN2o2LdBqrUYg8vvHhs6dHiXB1i+wevas9zOqN/X00=;
        b=uio81B1xv5E7o45kvSZI+V2SzxU+rKD9Bg9emLxECEH8ZngWQT3B8Db5GaXFZjMAhv
         44f3GrwKXM1HFbGF4RD4RKLySM6mYtcAxzZe7KASN2TuZMwSLDjhRTVT6imE2TLnbkxH
         kkUxjCz8vZ3n5naSf9oZ3ZgcAt6u3MNqB9mCyJGRsmukMjtx7q/5/kzUrZE6LTOEBA3+
         qusQ4asdQP0Qub53pfbhwPgiegehVruEdaGMzGy5k5iG6g7TrErOCGx0Z/lO09sc2ktC
         CXSgN+YftVSlVcW05KJ6PNwzsUEoP+UjO0QAWx2IaodWrKLm7b6qPGYyL1KJCFBx4/7y
         FqKA==
X-Gm-Message-State: AOAM5329sRfBam/znhVelSyEX0FGaIpPE8pw7drpIm4kwViecI0W27Qr
        2v1papqVOojeOJ6EHdxUdeX/wrCca2BuicjW/YHkMA==
X-Google-Smtp-Source: ABdhPJxesbVcOI40YNDHTbOdMG4nAy1fJbekG96SQZE18PfwJjGgBoI6OrKUJfmOct4SdjXl2qpD7BpzlLaZYnqXBW4=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr70396089ejc.472.1609837070212;
 Tue, 05 Jan 2021 00:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20210104142624.GI13207@dhcp22.suse.cz> <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz> <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
 <20210104153300.GL13207@dhcp22.suse.cz> <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
 <6106ca7f-3247-0916-3e1e-ad6af17272ea@redhat.com> <20210105080057.GT13207@dhcp22.suse.cz>
 <20210105081654.GU13207@dhcp22.suse.cz> <CAPcyv4jKKWqjgdpi3yiPCaFdfHYzPDrgAc1YvELEPogD3go2PA@mail.gmail.com>
 <20210105084224.GV13207@dhcp22.suse.cz>
In-Reply-To: <20210105084224.GV13207@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 5 Jan 2021 00:57:43 -0800
Message-ID: <CAPcyv4jYJdmRRhDCaT1j-s2pij3OnML7muWjgJRe9s65ujjZFw@mail.gmail.com>
Subject: Re: uninitialized pmem struct pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 12:42 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 05-01-21 00:27:34, Dan Williams wrote:
> > On Tue, Jan 5, 2021 at 12:17 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 05-01-21 09:01:00, Michal Hocko wrote:
> > > > On Mon 04-01-21 16:44:52, David Hildenbrand wrote:
> > > > > On 04.01.21 16:43, David Hildenbrand wrote:
> > > > > > On 04.01.21 16:33, Michal Hocko wrote:
> > > > > >> On Mon 04-01-21 16:15:23, David Hildenbrand wrote:
> > > > > >>> On 04.01.21 16:10, Michal Hocko wrote:
> > > > > >> [...]
> > > > > >>> Do the physical addresses you see fall into the same section as boot
> > > > > >>> memory? Or what's around these addresses?
> > > > > >>
> > > > > >> Yes I am getting a garbage for the first struct page belonging to the
> > > > > >> pmem section [1]
> > > > > >> [    0.020161] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x603fffffff]
> > > > > >> [    0.020163] ACPI: SRAT: Node 4 PXM 4 [mem 0x6060000000-0x11d5fffffff] non-volatile
> > > > > >>
> > > > > >> The pfn without the initialized struct page is 0x6060000. This is a
> > > > > >> first pfn in a section.
> > > > > >
> > > > > > Okay, so we're not dealing with the "early section" mess I described,
> > > > > > different story.
> > > > > >
> > > > > > Due to [1], is_mem_section_removable() called
> > > > > > pfn_to_page(PHYS_PFN(0x6060000)). page_zone(page) made it crash, as not
> > > > > > initialized.
> > > > > >
> > > > > > Let's assume this is indeed a reserved pfn in the altmap. What's the
> > > > > > actual address of the memmap?
> > > > > >
> > > > > > I do wonder what hosts pfn_to_page(PHYS_PFN(0x6060000)) - is it actually
> > > > > > part of the actual altmap (i.e. > 0x6060000) or maybe even self-hosted?
> > > > > >
> > > > > > If it's not self-hosted, initializing the relevant memmaps should work
> > > > > > just fine I guess. Otherwise things get more complicated.
> > > > >
> > > > > Oh, I forgot: pfn_to_online_page() should at least in your example make
> > > > > sure other pfn walkers are safe. It was just an issue of
> > > > > is_mem_section_removable().
> > > >
> > > > Hmm, I suspect you are right. I haven't put this together, thanks! The memory
> > > > section is indeed marked offline so pfn_to_online_page would indeed bail
> > > > out:
> > > > crash> p (0x6060000>>15)
> > > > $3 = 3084
> > > > crash> p mem_section[3084/128][3084 & 127]
> > > > $4 = {
> > > >   section_mem_map = 18446736128020054019,
> > > >   usage = 0xffff902dcf956680,
> > > >   page_ext = 0x0,
> > > >   pad = 0
> > > > }
> > > > crash> p 18446736128020054019 & (1UL<<2)
> > > > $5 = 0
> > > >
> > > > That makes it considerably less of a problem than I thought!
> > >
> > > Forgot to add that those who are running kernels without 53cdc1cb29e8
> > > ("drivers/base/memory.c: indicate all memory blocks as removable") for
> > > some reason can fix the crash by the following simple patch.
> > >
> > > Index: linux-5.3-users_mhocko_SLE15-SP2_for-next/drivers/base/memory.c
> > > ===================================================================
> > > --- linux-5.3-users_mhocko_SLE15-SP2_for-next.orig/drivers/base/memory.c
> > > +++ linux-5.3-users_mhocko_SLE15-SP2_for-next/drivers/base/memory.c
> > > @@ -152,9 +152,14 @@ static ssize_t removable_show(struct dev
> > >                 goto out;
> > >
> > >         for (i = 0; i < sections_per_block; i++) {
> > > -               if (!present_section_nr(mem->start_section_nr + i))
> > > +               unsigned long nr = mem->start_section_nr + i;
> > > +               if (!present_section_nr(nr))
> > >                         continue;
> > > -               pfn = section_nr_to_pfn(mem->start_section_nr + i);
> > > +               if (!online_section_nr()) {
> >
> > I assume that's onlince_section_nr(nr) in the version that compiles?
>
> Yup.
>
> > This makes sense because the memory block size is larger than the
> > section size. I suspect you have 1GB memory block size on this system,
> > but since the System RAM and PMEM collide at a 512MB alignment in a
> > memory block you end up walking the back end of the last 512MB of the
> > System RAM memory block and run into the offline PMEM section.
>
> Sections are 128MB and memory blocks are 2GB on this system.
>
> > So, I don't think it's pfn_to_online_page that necessarily needs to
> > know how to disambiguate each page, it's things that walk sections and
> > memory blocks and expects them to be consistent over the span.
>
> Well, memory hotplug code is hard wired to sparse memory model so in
> this particular case asking about the section is ok. But pfn walkers
> shouldn't really care and only rely on pfn_to_online_page. But that will
> do the right thing here. So we are good as long as the section is marked
> properly. But this would become a problem as soon as the uninitialized
> pages where sharing the same memory section as David pointed out.
> pfn_to_online_page would then return something containing garbage. So we
> should still think of a way to either initialize all those pages or make
> sure pfn_to_online_page recognizes them. The former is preferred IMHO.

The former would not have saved the crash in this case because
pfn_to_online_page() is not used in v5.3:removable_show() that I can
see, nor some of the other paths that might walk pfns and the wrong
thing with ZONE_DEVICE.

However, I do think pfn_to_online_page() should be reliable, and I
prefer to just brute force add a section flag to indicate whether the
section might be ZONE_DEVICE polluted and fallback to the
get_dev_pagemap() slow-path in that case.

...but it would still require hunting to find the places where
pfn_to_online_page() is missing for assumptions like this crash which
assumed memblock-online + section-present == section-online.
