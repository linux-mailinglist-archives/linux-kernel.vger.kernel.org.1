Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B62EA4B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 06:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbhAEFSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 00:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbhAEFSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 00:18:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5DBC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 21:17:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ga15so7561565ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 21:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcFSD5GHAbaS8VvEAZ8NF7Sjb+bUfn5rHvZZbFTP7AM=;
        b=CqjuMGhK42wN45/GqYXctaAsigALljUCT4oQ7sVeqyUZCISObPnyzAkPsJHjOgciep
         N5y1XiiAwWk9QyV/RWd6BkWueyAsbWyJqXY1QkOVr4soLc9A5gfX+Zn7ghiMa4rhohnX
         QAG5bcWxxFs7gCY8Q6VFGao0xIviRuse/Pmyl23bM0yWvzYfeA2TShMWdQgNEclIT9e2
         C4SucHJuAnDItHfOX3R4GDirKhcGOQ4XxcpDcUku83MwqkFmtnrnT/ObABKldPN2LIju
         VhtSWjLF5891gQAOAqzTSdJOfi6rSzuX9O00f0KbvPQL/dbkcx8O4mQbxwzo8ahVNxkV
         oeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcFSD5GHAbaS8VvEAZ8NF7Sjb+bUfn5rHvZZbFTP7AM=;
        b=kxtXeNperA/S7H9khGn+BBFIbxdSrMVUJw5U9SQsDv58tsPB3D/or9wV2YhDaKx06H
         SBKPoLVVWu5/RoUj7YPGYTX1c87oWVZjdoFw+2wtaieX70eppQk+Z1z5Nf8CPRsRW/Ig
         wOUSndqKQm3KhYJ6Hbman4ghTj2c9uhTIjenu2JU8at34CND+MCCJmrceuvVjk3jq/hA
         cg8sG5gRCaWuw0JavjXakPM0ufsoTPiRf2eKdggZdWDRKKMoJFYg55j7Le8VqEUQWQn9
         x45N7Nh1F/QimyX+7fyMqhqYV7kaGg3aHAsUYsdM3lbxUNYJCT0kP5hmU3Q6hkUbrdze
         ETsQ==
X-Gm-Message-State: AOAM530JprUhCx8GxupUApUPh/3mbaN7N4Va+og2xCDDPpAgKp1sRmc8
        78h7Sxxu+gB5EcNfLsTRyei49vR9cW41d01zgiO1mA==
X-Google-Smtp-Source: ABdhPJx30FGLFHLC2+/jei5co/InKjv7z75q5tabnOf2IwlLk2q1MwnVsHT1K6tW+xXx7k/7/Nf+K45dkK3Q8Z4+oh8=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr69875260ejc.472.1609823870446;
 Mon, 04 Jan 2021 21:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20210104100323.GC13207@dhcp22.suse.cz> <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
In-Reply-To: <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Jan 2021 21:17:43 -0800
Message-ID: <CAPcyv4h6mdKrwpqXfO0e_=sKjB-pY5KbP9ii+tQyFsK5bPkb=A@mail.gmail.com>
Subject: Re: uninitialized pmem struct pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 2:45 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 04.01.21 11:03, Michal Hocko wrote:
> > Hi,
> > back in March [1] you have recommended 53cdc1cb29e8
> > ("drivers/base/memory.c: indicate all memory blocks as removable") to be
> > backported to stable trees and that has led to a more general discussion
> > about the current state of pfn walkers wrt. uninitialized pmem struct
> > pages. We haven't concluded any specific solution for that except for a
> > general sentiment that pfn_to_online_page should be able to catch those.
> > I might have missed any follow ups on that but I do not think we have
> > landed on any actual solution in the end. Have I just missed any followups?
>
> Thanks for raising this issue. It's still on my list of "broken and
> non-trivial to fix" things.
>
> So, as far as I recall, we still have the following two issues remaining:
>
> 1. pfn_to_online_page() false positives
>
> The semantics of pfn_to_online_page() were broken with sub-section
> hot-add in corner cases.

The motivation for that backport was for pre-subsection kernels. When
onlining pmem that collides with the same section as System-RAM we may
have a situation like:

|--               SECTION                   -- |
|-- System RAM      --        PMEM          -- |
|-- pfn_valid()     --     PMEM metadata    -- |

So problem 0. is just System RAM + PMEM collisions independent of
sub-section support.

>
> If we have ZONE_DEVICE hot-added memory that overlaps in a section with
> boot memory, this memory section will contain parts ZONE_DEVICE memory
> and parts !ZONE_DEVICE memory. This can happen in sub-section
> granularity (2MB IIRC). pfn_to_online_page() will succeed on ZONE_DEVICE
> memory parts as the whole section is marked as online. Bad.
>
> One instance where this is still an issue is
> mm/memory-failure.c:memory_failure() and
> mm/memory-failure.c:soft_offline_page(). I thought for a while about
> "fixing" these, but to me it felt like fixing pfn_to_online_page() is
> actually the right approach.

This is complicated by MEMORY_DEVICE_PRIVATE that I believe wants to
say "yes" to pfn_to_online_page().

>
> But worse, before ZONE_DEVICE hot-add
> 1. The whole section memmap does already exist (early sections always
> have a full memmap for the whole section)
> 2. The whole section memmap is initialized (although eventually with
> dummy node/zone 0/0 for memory holes until that part is fixed) and might
> be accessed by pfn walkers.
>
> So when hotadding ZONE_DEVICE we are modifying already existing and
> visible memmaps. Bad.

Where does the rewrite of a dummy page entry matter in practice? It
would certainly be exceedingly Bad if in-use 'struct page' instances
we're rewritten. You're only alleging the former, correct?

>
>
> 2. Deferred init of ZONE_DEVICE ranges
>
> memmap_init_zone_device() runs after the ZONE_DEVICE zone was resized
> and outside the memhp lock. I did not follow if the use of
> get_dev_pagemap() actually makes sure that memmap_init_zone_device() in
> pagemap_range() actually completed. I don't think it does.
>
> >
> > Is anybody working on that?
> >
>
> I believe Dan mentioned somewhere that he wants to see a real instance
> of this producing a BUG before actually moving forward with a fix. I
> might be wrong.

I think I'm missing an argument for the user-visible effects of the
"Bad." statements above. I think soft_offline_page() is a candidate
for a local fix because mm/memory-failure.c already has a significant
amount of page-type specific knowledge. So teaching it "yes" for
MEMORY_DEVICE_PRIVATE-ZONE_DEVICE and "no" for other ZONE_DEVICE seems
ok to me.

>
>
> We might tackle 1. by:
>
> a) [worked-around] doing get_dev_pagemap() before pfn_to_online_page() -
> just plain ugly.
>
> b) [worked-around] using a sub-section online-map and extending
> pfn_to_online_page(). IMHO ugly to fix this corner case.
>
> c) [worked-around] extending pfn_to_online_page() by zone checks. IMHO racy.
>
> d) fixed by not allowing ZONE_DEVICE and !ZONE_DEVICE within a single
> section. In the worst case, don't add partially present sections that
> have big holes in the beginning/end. Like, if there is a 128MB section
> with 126MB of memory followed by a 2MB hole, don't add that memory to
> Linux with CONFIG_ZONE_DEVICE. Might turn some memory unusable, but
> well, it would be the price to pay for simplicity. Being able to hotadd
> PMEM is more important than using each and every last MB of memory.

The collisions that are out there in the wild are 64MB System RAM
followed by 64MB of PMEM. If you're suggesting reducing System RAM
that collides with PMEM that's a consideration. It can't go the other
way because there are deployed configurations that have persistent
data there. Reducing System RAM runs into the problem of how early
does the kernel know that it's bordering ZONE_DEVICE. It's not just
PMEM, it's also EFI_MEMORY_SP (Linux Soft Reserved) memory.

> e) decrease the section size and drop sub-section hotadd support. As
> sub-section hotadd is 2MB and MAX_ORDER - 1 corresponds 4MB, this is
> mostly impossible. Worse on aarch64 with 64k base pages - 1024MB
> sections and MAX_ORDER - 1 corresponds 512MB. I think this is not feasible.

f) Teach the places where pfn_to_online_page() gives the wrong answer
how to handle ZONE_DEVICE. Like:

a78986aae9b2 KVM: MMU: Do not treat ZONE_DEVICE pages as being reserved
