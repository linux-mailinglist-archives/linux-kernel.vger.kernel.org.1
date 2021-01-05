Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A542EA4E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 06:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbhAEFdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 00:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbhAEFdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 00:33:54 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA369C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 21:33:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c7so29799162edv.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 21:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oF2GDGKJ22j+kOO4e1xITj1l5oJrdeGhoCxjiiBLDHE=;
        b=B/GtkofxvlekvKu2bmoTMY5y+rva90Yj+V5rgGio8nlFPyLYimwuYmPqNir95GSxyA
         MCAJvpFn6XBK06s0HiX3KT/rjCnmKcZlWdzM8GGT3MC2PExt31bRzlK/SvW3lt5DOzdK
         Ahw9jYbQtwgOxyvDTbH/J97G5ySsykeHsEdKDX08kOBhgJh+Gqx8tG5NwKCeETkeXQLH
         9zYO1ADG3kF+xvX+4qeRyR23XDJ/AGaQ0cwnb9OqDSZJLpvxdGqJJ1cU1gMDzAKtXAcK
         7su6aWP/Fqy6UJiI33x9MxHOqYA6s88u9xmRZNc00H9bVDTtxacOcSNluRiLAeD+lWEZ
         trTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oF2GDGKJ22j+kOO4e1xITj1l5oJrdeGhoCxjiiBLDHE=;
        b=OuzLkPHetf20sA9Klstdh/RgECekjta9A44Uveoo2aBpzQ86Cv29BiAXFcw8ms56l3
         oqnsgIrsUrUG02yDS9pCtzFMk8violSAgpyuE9pX8SGexBqPNWVYJrc1mVieo07q6daN
         ehn28r6YtuePaxmHN5J8pxYUOLBV8rqwAijULJRdpbNkBqMEK/VakfMZDUT1SMiwZ4Wo
         BrXnz/OEpykkr5+lo2KVjKsIaXl/sxuUxxvffSrvjwnRTyN7jgusDnG07RnuAGJQ98BR
         udD1FWSQ3mznsmqr5S+gCzJ3AwzIlxjnvI9sH1alUaIrSgn8ZF+OxSn2n2qQgPrRSOCM
         Zk9A==
X-Gm-Message-State: AOAM533tvekHO/4SUXIZQkjReBzjBryjj/3wZCn+qVCCtJFUSgm5gGRN
        TRMkD1Yue5y2KentjIIZSawfQhAOCYKLPhZpZaKXYg==
X-Google-Smtp-Source: ABdhPJxeBs+rBNKHoRYe+Mb3Xo/i9IMHUIEuriorbpf7SrTOvflcbGjT6T5XYxsSgFnmCL3+yQqDw+3ixGGbAzvCSuY=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr73223647edr.97.1609824792593;
 Mon, 04 Jan 2021 21:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20210104100323.GC13207@dhcp22.suse.cz> <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz> <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz> <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
 <20210104153300.GL13207@dhcp22.suse.cz> <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
 <20210104155931.GN13207@dhcp22.suse.cz>
In-Reply-To: <20210104155931.GN13207@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Jan 2021 21:33:06 -0800
Message-ID: <CAPcyv4jGhvfDeFkY=R9+2QB3vZvRfJ=6s9o29U7msVemGhJjzw@mail.gmail.com>
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

On Mon, Jan 4, 2021 at 7:59 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 04-01-21 16:43:49, David Hildenbrand wrote:
> > On 04.01.21 16:33, Michal Hocko wrote:
> > > On Mon 04-01-21 16:15:23, David Hildenbrand wrote:
> > >> On 04.01.21 16:10, Michal Hocko wrote:
> > > [...]
> > >> Do the physical addresses you see fall into the same section as boot
> > >> memory? Or what's around these addresses?
> > >
> > > Yes I am getting a garbage for the first struct page belonging to the
> > > pmem section [1]
> > > [    0.020161] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x603fffffff]
> > > [    0.020163] ACPI: SRAT: Node 4 PXM 4 [mem 0x6060000000-0x11d5fffffff] non-volatile
> > >
> > > The pfn without the initialized struct page is 0x6060000. This is a
> > > first pfn in a section.
> >
> > Okay, so we're not dealing with the "early section" mess I described,
> > different story.
> >
> > Due to [1], is_mem_section_removable() called
> > pfn_to_page(PHYS_PFN(0x6060000)). page_zone(page) made it crash, as not
> > initialized.
>
> Exactly!
>
> > Let's assume this is indeed a reserved pfn in the altmap. What's the
> > actual address of the memmap?
>
> Not sure what exactly you are asking for but crash says
> crash> kmem -p 6060000
>       PAGE          PHYSICAL      MAPPING       INDEX CNT FLAGS
> fffff8c600181800     6060000                0        0  0 fffffc0000000
>
> > I do wonder what hosts pfn_to_page(PHYS_PFN(0x6060000)) - is it actually
> > part of the actual altmap (i.e. > 0x6060000) or maybe even self-hosted?
>
> I am not really familiar with the pmem so I would need more assistance
> here. I've tried this (shot into the dark):
> crash> struct page.pgmap fffff8c600181800
>       pgmap = 0xfffff8c600181808

Does /proc/iomem show an active namespace in the range? You should be
able to skip ahead to the first pfn in that namespace to find the
first dev_pagemap. I would have expected pfn_to_online_page() to have
saved you here. This address range is section aligned.
