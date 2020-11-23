Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5400F2C0FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389874AbgKWQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbgKWQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:07:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r22so9003739edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27zCzsugV+PXTs9+xhojLQOGiVY+wvfQyM1MNClymK4=;
        b=UHx0tOO+ym/Yp91KlLEqkdPump6vUEu4pcxmRAdpFaTDJqp3F+IVqNSvwUd/jhgO/z
         22TP6WibIeeGx8zZjSQWm6CJ7DFURRnwxBXxlFZCozs3By7lr+VvrDR1AVqTT95UJqvO
         0L9Ea3bo41/3p3LhTLVMl7+iixeNmOdoS2J8+omZOIGBeCR3vs8QQyuzQXwFEaIQNxue
         HZ23rJ1UrAErc87Dqb5pym+K0F9pds7w9HVtg9IXvrTh6pUj7IlTyX4BXGovfYCEmqeK
         3Dxfh3RZrBatnCroZXcp3vT9gHQa5IHwv53LMeXUdVEPLDyT2o9wBjTm8Zl45UaznEj+
         2bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27zCzsugV+PXTs9+xhojLQOGiVY+wvfQyM1MNClymK4=;
        b=F4ZdfScyb+eKLh8aoDgDNA1CRstcDIx0CSEdfasbWzXB3uLFLZvF8/3jDcoHrQml3X
         OyTzrJZDpJ1eHAl3sh/SfjW5Xg6JnnOxkEvqEtASk8IZfB0S3nOJ++ftMLsPOrdqfaG4
         Y9vaH09NO9jnummwKcSirnvcmV09SsN4FS0qn82WK0qqRwtRKiaQVwSC2jYP2Ghns2Gy
         7CSQz96hDOYvbmnBYqKqak/NJ7W+pS+dBcu1hWw9iA8u39+FRRmuyfMJO1afg4N+HEkG
         NNkLqeb4N8Nd+YeTX1mUNTR7Y5BvbeGSNt0Vs/16GToulhtTGiLXWAAZANYz3vLcwRBg
         f3nQ==
X-Gm-Message-State: AOAM531Qr42m3L4v8YZQDk+o63vAxEr5f3+MdpD1fckoJ8ytYnw/kCG1
        q3C3JLWlYGnfy/XrlzuvS6iSivP4PViG6q6NDRHFmw==
X-Google-Smtp-Source: ABdhPJzibqdMYOIBhGjXJUdhIDh+R5QQF/GtkyqW0c/+s7q9WBHklh2YBBrwkgRfcW4nMORl7O2gEVd2dHDJIzPGON8=
X-Received: by 2002:a05:6402:a53:: with SMTP id bt19mr46981153edb.26.1606147617545;
 Mon, 23 Nov 2020 08:06:57 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <20201123090129.GD27488@dhcp22.suse.cz>
In-Reply-To: <20201123090129.GD27488@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 23 Nov 2020 11:06:21 -0500
Message-ID: <CA+CK2bCD8_x5cBUOksAzat_O4G8-PoLp378zN1mxKMcmyV8dAw@mail.gmail.com>
Subject: Re: Pinning ZONE_MOVABLE pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 4:01 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 15:27:46, Pavel Tatashin wrote:
> > Recently, I encountered a hang that is happening during memory hot
> > remove operation. It turns out that the hang is caused by pinned user
> > pages in ZONE_MOVABLE.
> >
> > Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
> > this is not the case if a user applications such as through dpdk
> > libraries pinned them via vfio dma map.
>
> Long term or effectively time unbound pinning on zone movable is
> fundamentaly broken. The sole reason of ZONE_MOVABLE existence is to
> guarantee migrateability. If the cosumer of this memory cannot guarantee
> that then it shouldn't use __GFP_MOVABLE in the first place.

Exactly, this is what I am trying to solve, and started this thread to
figure out what is the best approach to address this problem.

>
> > Kernel keeps trying to
> > hot-remove them, but refcnt never gets to zero, so we are looping
> > until the hardware watchdog kicks in.
>
> Yeah, the existing offlining behavior doesn't stop trying because the
> current implementation of the migration cannot tell a diffence between
> short and long term failures. Maybe the recent ref count for long term
> pinning can be used to help out there.
>
> Anyway, I am wondering what do you mean by watchdog firing. The
> operation should trigger neither of soft, hard or hung detectors.

You are right, the hot-remove is killable operation. In our case,
however, systemd stops petting watchdog during kexec reboot to ensure
that reboot finishes, however, because we hot-remove memory during
shutdown, and kernel is unable to hot-remove memory within 60s we get
a watchdog reset.

>
> > We cannot do dma unmaps before hot-remove, because hot-remove is a
> > slow operation, and we have thousands for network flows handled by
> > dpdk that we just cannot suspend for the duration of hot-remove
> > operation.
> >
> > The solution is for dpdk to allocate pages from a zone below
> > ZONE_MOVAVLE, i.e. ZONE_NORMAL/ZONE_HIGHMEM, but this is not possible.
> > There is no user interface that we have that allows applications to
> > select what zone the memory should come from.
>
> Our existing interface is __GFP_MOVABLE. It is a responsibility of the
> driver to know whether the resulting memory is migratable. Users
> shouldn't even have to think about that.

Sure, so let's migrate, and fault memory from drivers when long term
pinning. Which is 1 and 2 in my proposal.

> > I've spoken with Stephen Hemminger, and he said that DPDK is moving in
> > the direction of using transparent huge pages instead of HugeTLBs,
> > which means that we need to allow at least anonymous, and anonymous
> > transparent huge pages to come from non-movable zones on demand.
>
> You can migrate before pinning.

Yes.

>
> > Here is what I am proposing:
> > 1. Add a new flag that is passed through pin_user_pages_* down to
> > fault handlers, and allow the fault handler to allocate from a
> > non-movable zone.
>
> gup already tries to deal with long term pins on CMA regions and migrate
> to a non CMA region. Have a look at __gup_longterm_locked. Migrating of
> the movable zone sounds like a reasonable solution to me.

Yes, CMA is doing something similar, but it is migrating before
pinning from CMA to movable zone to avoid fragmentation of CMA. What
we need to do is migrate before pinning to a non-movable zone for all
pages.

>
> > 2. Add an internal move_pages_zone() similar to move_pages() syscall
> > but instead of migrating to a different NUMA node, migrate pages from
> > ZONE_MOVABLE to another zone.
> > Call move_pages_zone() on demand prior to pinning pages from
> > vfio_pin_map_dma() for instance.
>
> Why is the existing migration API insufficient?

Here I am talking about internal implementation not user API. We do
not have a function that migrates pages in a user address space from
one zone to another zone. We only have a function that is exposed as a
syscall that migrates pages from one node to another node.

>
> > 3. Perhaps, it also makes sense to add madvise() flag, to allocate
> > pages from non-movable zone. When a user application knows that it
> > will do DMA mapping, and pin pages for a long time, the memory that it
> > allocates should never be migrated or hot-removed, so make sure that
> > it comes from the appropriate place.
> > The benefit of adding madvise() flag is that we won't have to deal
> > with slow page migration during pin time, but the disadvantage is that
> > we would need to change the user interface.
>
> No, the MOVABLE_ZONE like other zone types are internal implementation
> detail of the MM. I do not think we want to expose that to the userspace
> and carve this into stone.

What I mean here is allowing users to guarantee that the page's PA is
going to stay the same. Sort of a stronger mlock. Mlock only
guarantees that the page is not swapped, but something like
MADV_PINNED would guarantee that page is not going to be swapped and
also not migrated. If a user determines the PA of that page, that PA
is going to stay the same throughout the life of the page. This is not
exposing internal implementation in any way, this guarantee could be
honored in various ways: i.e. pinned or allocating from ZONE_NORMAL.
The fact that we would honor it by allocating memory from ZONE_NORMAL
is implementation detail that would not be exposed to the user.

This is from DPDK's description:
https://software.intel.com/content/www/us/en/develop/articles/memory-in-dpdk-part-1-general-concepts.html

"
Whenever a memory area is made available for DPDK to use, DPDK figures
out its physical address by asking the kernel at that time. Since DPDK
uses pinned memory, generally in the form of huge pages, the physical
address of the underlying memory area is not expected to change, so
the hardware can rely on those physical addresses to be valid at all
times, even if the memory itself is not used for some time. DPDK then
uses these physical addresses when preparing I/O transactions to be
done by the hardware, and configures the hardware in such a way that
the hardware is allowed to initiate DMA transactions itself. This
allows DPDK to avoid needless overhead and to perform I/O entirely
from user space.
"

I just think it is inefficient to first allocate memory from
ZONE_MOVABLE, and later migrate it to ZONE_NORMAL.

That said, I agree, we probably should not be adding a new flag at
least as part of this work.
