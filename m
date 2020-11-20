Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9B2BB89E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgKTVye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKTVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:54:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C1FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:54:33 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id k9so98695ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BdGxZHHmNWUjxqYGOe+E7s2xXNJsvySUdvnv2lEf71E=;
        b=X7MLb6Q6fRECqWHpGN/RhKmYjHYauDLrSBvyd3prItB4mnb08UyJgAUVNo7NujpNDb
         kUaFG/GtH+ofG3FrxNu4EsTUDLUWtQ8HMEKRcMkZvEGkJP+SYaYMtSK/GP13TrP78HNB
         OGHs2r/zoDEfWLprdi64t0CfJQwI/miuV7r3NlEsXYMne1Y7NQLujpcX6FVi0sjmt8yJ
         RNt3qI2W5xvpe7EZg9JLzt1D67oSCCdb/nQNp29/WtbOxGrRH0vmc+dKy2uFSBEvSORd
         Ne4RW1OcCI+1n9QMw+Gk4dEes4uWXz/cpuPpZHaopPiWhiZnj1I69mf/vxEdJqwBFcHP
         76Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BdGxZHHmNWUjxqYGOe+E7s2xXNJsvySUdvnv2lEf71E=;
        b=a2APOPywcLkPJ6mctjSnrcLfDbZuE0OSQniTJ9C9nLAoQLaOjWYXAsnmr6JHZCTMP1
         B7s7CRS0/O7YNz/Otn7rcFL4Ti6sMAoMn9KOgGJiCL4xFyIZ81Sy3okDfVGnMLiBeZBQ
         GINSt0ydp8YzOJ0tmnpiu/13SGIfhC0uqcyVHDVyN3iWmB1UO6Hh+/o1ApiyD/OM3jT8
         j7X0TBrDNV8OnhqvSsHKKv/OQG7unvzG6gueGJKG+SrrqwmtAPuTOBZcE6eQkTLgQIdi
         a9qarJ0XKFZomLJglFPU4J6Fn7JBH9IlHdrdE0W4MXEfjYVnP6FOiwqrdgZC52cUOHVP
         pjFQ==
X-Gm-Message-State: AOAM533NDDSEWeKoR1xWlwnB8ftekl1NdNIo4BjVkDOwtnJW4ax4KMWQ
        DUwMmiLfVKckp4amYciW8CuLpjC9B2XcOiX9t7AdXQ==
X-Google-Smtp-Source: ABdhPJyE2b/0YtawlbtxEUnWGo0jKy4x0sab3BacEj+0/c6kKxXAnmdvCPHRiJBllOsf974BtGexofusrunUiAvykHo=
X-Received: by 2002:a17:906:1458:: with SMTP id q24mr36056793ejc.541.1605909272243;
 Fri, 20 Nov 2020 13:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20201120211707.GC4327@casper.infradead.org> <9C8F0E5D-2D42-4BA5-A5B5-9E049E1BE862@redhat.com>
In-Reply-To: <9C8F0E5D-2D42-4BA5-A5B5-9E049E1BE862@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 20 Nov 2020 16:53:56 -0500
Message-ID: <CA+CK2bC9u3pAi0tEOyobUUEFnX1J3us=mxmwvnmzCkudq_MhxQ@mail.gmail.com>
Subject: Re: Pinning ZONE_MOVABLE pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:34 PM David Hildenbrand <david@redhat.com> wrote:
>
>
> > Am 20.11.2020 um 22:17 schrieb Matthew Wilcox <willy@infradead.org>:
> >
> > =EF=BB=BFOn Fri, Nov 20, 2020 at 09:59:24PM +0100, David Hildenbrand wr=
ote:
> >>
> >>>> Am 20.11.2020 um 21:28 schrieb Pavel Tatashin <pasha.tatashin@soleen=
.com>:
> >>>
> >>> =EF=BB=BFRecently, I encountered a hang that is happening during memo=
ry hot
> >>> remove operation. It turns out that the hang is caused by pinned user
> >>> pages in ZONE_MOVABLE.
> >>>
> >>> Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
> >>> this is not the case if a user applications such as through dpdk
> >>> libraries pinned them via vfio dma map. Kernel keeps trying to
> >>> hot-remove them, but refcnt never gets to zero, so we are looping
> >>> until the hardware watchdog kicks in.
> >>>
> >>> We cannot do dma unmaps before hot-remove, because hot-remove is a
> >>> slow operation, and we have thousands for network flows handled by
> >>> dpdk that we just cannot suspend for the duration of hot-remove
> >>> operation.
> >>>
> >>
> >> Hi!
> >>
> >> It=E2=80=98s a known problem also for VMs using vfio. I thought about =
this some while ago an came to the same conclusion: before performing long-=
term pinnings, we have to migrate pages off the movable zone. After that, i=
t=E2=80=98s too late.
> >
> > We can't, though.  VMs using vfio pin their entire address space (right=
?)
> > so we end up with basically all of the !MOVABLE memory used for VMs and
> > the MOVABLE memory goes unused (I'm thinking about the case of a machin=
e
> > which only hosts VMs and has nothing else to do with its memory).  In
> > that case, the sysadmin is going to reconfigure ZONE_MOVABLE away, and
> > now we just don't have any ZONE_MOVABLE.  So what's the point?
>
> When the guest is using an vIOMMU, it will only pin what=E2=80=98s curren=
tly mapped by the guest into the vIOMMU. Otherwise: yes.

Right, not all guest memory needs to be pinned, so ZONE_MOVABLE can
still be used for a vast amount of allocations.

>
> If you assume all memory will be used for VMs with vfio, then yes: no ZON=
E_MOVABLE, no memory hotunplug. If its=E2=80=98s only some VMs, it=E2=80=98=
s a different story.

Sounds like in such an extreme case it is reasonable to assume no
hot-plug. But, when you have 8G, and need to remove 2G movable zone,
but can't guarantee it even if you have 6G of free mem, this is
unreasonable.

>
> >
> > ZONE_MOVABLE can also be pinned by mlock() and other such system calls.
>
> Mlocked pages can be migrated, no? They are simply not swappable iirc.

Yes, mlocked they are simply in memory, but the content of the pages
can be migrated to a different place in RAM.

>
> > The kernel needs to understand that ZONE_MOVABLE memory may not actuall=
y
> > be movable, and skip the unmovable stuff.
> >
>
> Then you don=E2=80=98t have unplug guarantees. Memory unplug broken by de=
sign. Then there is no point in optimizing that case at all and tell custom=
ers =E2=80=9Evfio and memory hotunplug is incompatible=E2=80=9C. The only u=
gly thing is the endless loop.

Right, if memory in ZONE_MOVABLE is not guaranteed to be movable, we
can never guarantee memory hot-remove even when we have a lot of free
memory to migrate to.

>
