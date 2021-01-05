Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA82EA694
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbhAEI2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbhAEI2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:28:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2887C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 00:27:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id dk8so30221298edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 00:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnuJ3Vz3ccZNW3+yMXMqfuw/KWVCwXk6iFyfNSeYrZM=;
        b=z/BkBKY3AuumYooa3zlwAkRPvbIhktpxqyHO9/Wio7o83beA8aqZsbHK6sYE9J4gmk
         qibjX6GFitZr3nkza0DFB3jP5dIwaRjdoPWZIbMEn00g8HYyFDuERW9/j2hdJmW4/MJr
         I0/19dP901dvPkrXB7dSRGqwHkuxO56RNn3R9PVuGaDmO4G9uTWd4Mva7CXPGVtN/9eL
         D4O3OXwLnALobvPbek7ZoJNWk0JXTNN56RgWsg1vxdBUQit9hvBMD0pQkhOJfqiGEggI
         q19NodP5zSFgNlUTPg3f1342ZpA1ryed/IdKoJpoWS3pPUdbNtNPk4rQi4Nhqg23Facx
         BKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnuJ3Vz3ccZNW3+yMXMqfuw/KWVCwXk6iFyfNSeYrZM=;
        b=B4NvROK7u6uLXHPLRTERCI2QTd6kKBSKoxqg7mu35IPeECu9WSqZsj1iiUbBHV8JIs
         S0uxMmqHzrVqWSPHEGGXV6OEegcTpcBZGmAqhvUi/Bt0n8svos1LQ4Bvzu7Jv33E0GID
         l4dHfigL2cbKk0KwAPikhoGWCusW057rjqfQa+o4aBpI0m0gR3/kqKlu5ljlvlXS7zcw
         6VEL60XaxdRa2pLVDh4S5Vz3x0dLCEtwEi5G4o/tAOwNrDnBCnUP7C8gJE9qfJM1Q59v
         b1Zf4MEi/U8PIxAtu8l3/rY8cnCmqsrHY3vbigmKPSuU6o9Gl9fI/H9prB1tyIvIDMPP
         hoaA==
X-Gm-Message-State: AOAM532WkajNkLBjWO3hg1rdvfjdTm/V1GT0erMbTfWs0MzGyFlfiEz3
        nbKzHNHDdeyQLBJWsDdAP2+fmToFViV8538L0AU1mQ==
X-Google-Smtp-Source: ABdhPJweiOByDSltjQdldcPNJOZmyJ7nHVfo7+pBTlJq628wym3R1tWIfD6vOKBmFIy7kf1qEcuFe4CcP8ZDuZgV06A=
X-Received: by 2002:aa7:cdc3:: with SMTP id h3mr19735149edw.52.1609835261574;
 Tue, 05 Jan 2021 00:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20210104100323.GC13207@dhcp22.suse.cz> <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz> <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz> <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
 <20210104153300.GL13207@dhcp22.suse.cz> <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
 <6106ca7f-3247-0916-3e1e-ad6af17272ea@redhat.com> <20210105080057.GT13207@dhcp22.suse.cz>
 <20210105081654.GU13207@dhcp22.suse.cz>
In-Reply-To: <20210105081654.GU13207@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 5 Jan 2021 00:27:34 -0800
Message-ID: <CAPcyv4jKKWqjgdpi3yiPCaFdfHYzPDrgAc1YvELEPogD3go2PA@mail.gmail.com>
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

On Tue, Jan 5, 2021 at 12:17 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 05-01-21 09:01:00, Michal Hocko wrote:
> > On Mon 04-01-21 16:44:52, David Hildenbrand wrote:
> > > On 04.01.21 16:43, David Hildenbrand wrote:
> > > > On 04.01.21 16:33, Michal Hocko wrote:
> > > >> On Mon 04-01-21 16:15:23, David Hildenbrand wrote:
> > > >>> On 04.01.21 16:10, Michal Hocko wrote:
> > > >> [...]
> > > >>> Do the physical addresses you see fall into the same section as boot
> > > >>> memory? Or what's around these addresses?
> > > >>
> > > >> Yes I am getting a garbage for the first struct page belonging to the
> > > >> pmem section [1]
> > > >> [    0.020161] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x603fffffff]
> > > >> [    0.020163] ACPI: SRAT: Node 4 PXM 4 [mem 0x6060000000-0x11d5fffffff] non-volatile
> > > >>
> > > >> The pfn without the initialized struct page is 0x6060000. This is a
> > > >> first pfn in a section.
> > > >
> > > > Okay, so we're not dealing with the "early section" mess I described,
> > > > different story.
> > > >
> > > > Due to [1], is_mem_section_removable() called
> > > > pfn_to_page(PHYS_PFN(0x6060000)). page_zone(page) made it crash, as not
> > > > initialized.
> > > >
> > > > Let's assume this is indeed a reserved pfn in the altmap. What's the
> > > > actual address of the memmap?
> > > >
> > > > I do wonder what hosts pfn_to_page(PHYS_PFN(0x6060000)) - is it actually
> > > > part of the actual altmap (i.e. > 0x6060000) or maybe even self-hosted?
> > > >
> > > > If it's not self-hosted, initializing the relevant memmaps should work
> > > > just fine I guess. Otherwise things get more complicated.
> > >
> > > Oh, I forgot: pfn_to_online_page() should at least in your example make
> > > sure other pfn walkers are safe. It was just an issue of
> > > is_mem_section_removable().
> >
> > Hmm, I suspect you are right. I haven't put this together, thanks! The memory
> > section is indeed marked offline so pfn_to_online_page would indeed bail
> > out:
> > crash> p (0x6060000>>15)
> > $3 = 3084
> > crash> p mem_section[3084/128][3084 & 127]
> > $4 = {
> >   section_mem_map = 18446736128020054019,
> >   usage = 0xffff902dcf956680,
> >   page_ext = 0x0,
> >   pad = 0
> > }
> > crash> p 18446736128020054019 & (1UL<<2)
> > $5 = 0
> >
> > That makes it considerably less of a problem than I thought!
>
> Forgot to add that those who are running kernels without 53cdc1cb29e8
> ("drivers/base/memory.c: indicate all memory blocks as removable") for
> some reason can fix the crash by the following simple patch.
>
> Index: linux-5.3-users_mhocko_SLE15-SP2_for-next/drivers/base/memory.c
> ===================================================================
> --- linux-5.3-users_mhocko_SLE15-SP2_for-next.orig/drivers/base/memory.c
> +++ linux-5.3-users_mhocko_SLE15-SP2_for-next/drivers/base/memory.c
> @@ -152,9 +152,14 @@ static ssize_t removable_show(struct dev
>                 goto out;
>
>         for (i = 0; i < sections_per_block; i++) {
> -               if (!present_section_nr(mem->start_section_nr + i))
> +               unsigned long nr = mem->start_section_nr + i;
> +               if (!present_section_nr(nr))
>                         continue;
> -               pfn = section_nr_to_pfn(mem->start_section_nr + i);
> +               if (!online_section_nr()) {

I assume that's onlince_section_nr(nr) in the version that compiles?

This makes sense because the memory block size is larger than the
section size. I suspect you have 1GB memory block size on this system,
but since the System RAM and PMEM collide at a 512MB alignment in a
memory block you end up walking the back end of the last 512MB of the
System RAM memory block and run into the offline PMEM section.

So, I don't think it's pfn_to_online_page that necessarily needs to
know how to disambiguate each page, it's things that walk sections and
memory blocks and expects them to be consistent over the span.
