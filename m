Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD222BB8A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgKTV6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTV6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:58:47 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF0AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:58:46 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f20so14911145ejz.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y1rvmFcStb3IwDGyDbyGSvlrh0dChpQofi4qUAyQRxM=;
        b=bLErYg9l/27BgLPb+5S2FG/hoNnfB36OfIIe9bEGdR3W73pu2KL4Mv9kSUEzd0VZx8
         bvQxBqVeSPCJB/uEs9seQhCBFRV0OXBhR5GuDfyqVA5TCHhz9xrwqipiOC7g0QY/9+Hr
         2/Yuv7WYxAk3D4+Py6wehQVTko0gbrKrXne0SycyuHpvQFt9R9s83Y7Ge2SQ7wyON3o6
         X3bbgxn2/opBcPBcfDitKwwkVP3QiK7YHMw5UvqomsiG1JFonJhZNKTHoICOPpI6Xykb
         qWL6ysDPxUJq0alZ+gY8t+6T9DeekcO+jdkVncozqQ+kzkLOyLkXZF+qnTtGHkC82BRE
         BLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y1rvmFcStb3IwDGyDbyGSvlrh0dChpQofi4qUAyQRxM=;
        b=i8HLT2/RwG5LFs0SX8+UXUnRMucWKQMhrXUgs59rO3/bSe+3ZVs+YD+Ay6xBRxWxmw
         RsldTAnEZqs8cjIAkzD4nifpemXA/p/Sf2C67OUUuWkAx5AIbGUZEo/uXP4LPp4yaVUp
         LChK9OzV/r5QAG0pEHTV6ieBE1YVksQ2Ryw2HdLPifUDvPZHrrvsP9kbgE31EfuqIA89
         kNPwLbf7uvYJ3XAit09xDlnKR9qOdkkIighc7Wy98bOw7dQd0ZqoDrIeLlp0Nk1wa8b3
         j8fdcF79bk9g7aceG33z0oNdygHqe6rvRYHCYA4D0KwRwy6KM/Ar/PJqhY7XVTD4v03Y
         XuAQ==
X-Gm-Message-State: AOAM532XNaxmaf54XyICsKdDgi395h+ffk4nWVsybrjYeSPMj9p8ZOf7
        xHJb6rz4mpjyS0iH2NDjLwnFebBdqns8aWosA8ZYOQ==
X-Google-Smtp-Source: ABdhPJyLBHALUB0GjsxdBg35ZwjvJH09CUBo3U/5lKxrZQoqo2TBI06bajEz20AlENSblPn/FMsr2JQcpiTdfp0XFe0=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr33851711ejh.383.1605909525393;
 Fri, 20 Nov 2020 13:58:45 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <9452B231-23F3-48F5-A0E2-D6C5603F87F1@redhat.com>
In-Reply-To: <9452B231-23F3-48F5-A0E2-D6C5603F87F1@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 20 Nov 2020 16:58:09 -0500
Message-ID: <CA+CK2bABKyd1xvpOXjcGxsAzxTvZsiutkCAPm-FUmseFFaRqNQ@mail.gmail.com>
Subject: Re: Pinning ZONE_MOVABLE pages
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>,
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

On Fri, Nov 20, 2020 at 3:59 PM David Hildenbrand <david@redhat.com> wrote:
>
>
> > Am 20.11.2020 um 21:28 schrieb Pavel Tatashin <pasha.tatashin@soleen.co=
m>:
> >
> > =EF=BB=BFRecently, I encountered a hang that is happening during memory=
 hot
> > remove operation. It turns out that the hang is caused by pinned user
> > pages in ZONE_MOVABLE.
> >
> > Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
> > this is not the case if a user applications such as through dpdk
> > libraries pinned them via vfio dma map. Kernel keeps trying to
> > hot-remove them, but refcnt never gets to zero, so we are looping
> > until the hardware watchdog kicks in.
> >
> > We cannot do dma unmaps before hot-remove, because hot-remove is a
> > slow operation, and we have thousands for network flows handled by
> > dpdk that we just cannot suspend for the duration of hot-remove
> > operation.
> >
>
> Hi!
>
> It=E2=80=98s a known problem also for VMs using vfio. I thought about thi=
s some while ago an came to the same conclusion: before performing long-ter=
m pinnings, we have to migrate pages off the movable zone. After that, it=
=E2=80=98s too late.
>
> What happens when we can=E2=80=98t migrate (OOM on !MOVABLE memory, short=
-term pinning)? TBD.
>
> > The solution is for dpdk to allocate pages from a zone below
> > ZONE_MOVAVLE, i.e. ZONE_NORMAL/ZONE_HIGHMEM, but this is not possible.
> > There is no user interface that we have that allows applications to
> > select what zone the memory should come from.
> >
> > I've spoken with Stephen Hemminger, and he said that DPDK is moving in
> > the direction of using transparent huge pages instead of HugeTLBs,
> > which means that we need to allow at least anonymous, and anonymous
> > transparent huge pages to come from non-movable zones on demand.
> >
> > Here is what I am proposing:
> > 1. Add a new flag that is passed through pin_user_pages_* down to
> > fault handlers, and allow the fault handler to allocate from a
> > non-movable zone.
> >
> > Sample function stacks through which this info needs to be passed is th=
is:
> >
> > pin_user_pages_remote(gup_flags)
> > __get_user_pages_remote(gup_flags)
> >  __gup_longterm_locked(gup_flags)
> >   __get_user_pages_locked(gup_flags)
> >    __get_user_pages(gup_flags)
> >     faultin_page(gup_flags)
> >      Convert gup_flags into fault_flags
> >      handle_mm_fault(fault_flags)
> >
> > From handle_mm_fault(), the stack diverges into various faults,
> > examples include:
> >
> > Transparent Huge Page
> > handle_mm_fault(fault_flags)
> > __handle_mm_fault(fault_flags)
> > Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mas=
k
> > create_huge_pmd(vmf);
> > do_huge_pmd_anonymous_page(vmf);
> > mm_get_huge_zero_page(vma->vm_mm); -> flag is lost, so flag from
> > vmf.gfp_mask should be passed as well.
> >
> > There are several other similar paths in a transparent huge page, also
> > there is a named path where allocation is based on filesystems, and
> > the flag should be honored there as well, but it does not have to be
> > added at the same time.
> >
> > Regular Pages
> > handle_mm_fault(fault_flags)
> > __handle_mm_fault(fault_flags)
> > Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mas=
k
> > handle_pte_fault(vmf)
> > do_anonymous_page(vmf);
> > page =3D alloc_zeroed_user_highpage_movable(vma, vmf->address); ->
> > replace change this call according to gfp_mask.
> >
> > The above only take care of the case if user application faults on the
> > page during pinning time, but there are also cases where pages already
> > exist.
> >
> > 2. Add an internal move_pages_zone() similar to move_pages() syscall
> > but instead of migrating to a different NUMA node, migrate pages from
> > ZONE_MOVABLE to another zone.
> > Call move_pages_zone() on demand prior to pinning pages from
> > vfio_pin_map_dma() for instance.
> >
> > 3. Perhaps, it also makes sense to add madvise() flag, to allocate
> > pages from non-movable zone. When a user application knows that it
> > will do DMA mapping, and pin pages for a long time, the memory that it
> > allocates should never be migrated or hot-removed, so make sure that
> > it comes from the appropriate place.
> > The benefit of adding madvise() flag is that we won't have to deal
> > with slow page migration during pin time, but the disadvantage is that
> > we would need to change the user interface.
> >
>
> Hm, I am not sure we want to expose these details. What would be the sema=
ntics? =E2=80=9EMight pin=E2=80=9C? Hm, not sure.

The semantic would be PA must not change, something that DPDK
currently excpects from huge pages, which by the way is not true, as
huge pages are migratable.

>
> Assume you start a fresh VM via QEMU with vfio. When we start mapping gue=
st memory via vfio, that=E2=80=98s usually the time memory will get populat=
ed. Not really much has to be migrated. I think this is even true during li=
ve migration.
>
> I think selective DMA pinning (e.g., vIOMMU in QEMU) is different, where =
we keep pinning/unpinning on demand. But I guess even here, we will often r=
euse some pages over and over again.
>
>
> > Before I start working on the above approaches, I would like to get an
> > opinion from the community on an appropriate path forward for this
> > problem. If what I described sounds reasonable, or if there are other
> > ideas on how to address the problem that I am seeing.
>
> At least 1 and 2 sound sane. 3 is TBD - but it=E2=80=98s a pure optimizat=
ion, so it can wait.

Makes sense, I am also worried about 3, but most of madvise() flags
are for pure optimization purposes: MADV_HUGEPAGE, MADV_SEQUENTIAL,
MADV_WILLNEED etc.

>
> Thanks!
>
> >
> > Thank you,
> > Pasha
> >
>
