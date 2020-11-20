Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1F2BB80A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgKTU7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:59:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728785AbgKTU7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605905970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSLf/WlQJWBrU02a2h4kDWJCO9pKj+WmhYlJwGHEn9w=;
        b=PhiUxnDbAnMhKXnN5WZUzkHzMQGUGVSd50Eby2+BFZLY2tJbvb1TQuhfJEkxC0dKcfUvY5
        RHa0ZZxakIu0BuVEy9gOqjX5kRRgRG43y54PhiKOxZTBcEGLZmlA1/nt1Z0Zgyajc1SrRX
        MX7AJHfFuCrg/7WRsldzcUPOlO+GNqQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-3V4yPK_qPO2FJc0ilgf8cg-1; Fri, 20 Nov 2020 15:59:28 -0500
X-MC-Unique: 3V4yPK_qPO2FJc0ilgf8cg-1
Received: by mail-wm1-f69.google.com with SMTP id s10so3343961wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cSLf/WlQJWBrU02a2h4kDWJCO9pKj+WmhYlJwGHEn9w=;
        b=WIRFSihfsPJhHWztNGxyu4iJE2sUMgpTmQwnBAcasdZwgg4kKGtZKXnrtT1pEN3Sax
         qMxHrHdKB/kuTQWjvFg54BC7XJhxKgpIzUg9gCWousUMiC69IGRpLbIIbonAk/oTvKnf
         +Q36QboGVpVeatqkYNCebvFt8SNBrfdVgsQtT4A22QYI8pVGct92+84M0LSDHBgL7ol2
         h+aPTNaSzPbYZaANg/ZC8BkroSJ+KBiJb3UvHsy/jb3VufaXFJOxP+31uVwfo00eH1Vk
         8wh/DypuPiEdMlubQtLbJ4vam+IEQVafYJKKWXOLyxu7vea6KlAWQMkK80wJPXpybAME
         O+5Q==
X-Gm-Message-State: AOAM532+hP+N/83dbsCEjvsfLRwKIm1a2zFxo38IPIhgGY51+F3//30c
        Pz9SuIy9xiN7vfWDWM7/66ZJyHQHOCUbqpPBUPIcNrVnMbCEDyZekWFh3fydgvNZgXUfxP/foH4
        036jz+G7zJfB6dC5vpVvZWXtQ
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr18890781wrv.95.1605905967520;
        Fri, 20 Nov 2020 12:59:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5zDhABuQAy3XxTVyIfjRSi0E/FNkPCjNeHbjwG6xEg4YJcX6pZwCRNbNHck/nBVmhpF0qlA==
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr18890752wrv.95.1605905967242;
        Fri, 20 Nov 2020 12:59:27 -0800 (PST)
Received: from [192.168.3.114] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id b145sm6008814wmd.0.2020.11.20.12.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:59:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Pinning ZONE_MOVABLE pages
Date:   Fri, 20 Nov 2020 21:59:24 +0100
Message-Id: <9452B231-23F3-48F5-A0E2-D6C5603F87F1@redhat.com>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com
In-Reply-To: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 20.11.2020 um 21:28 schrieb Pavel Tatashin <pasha.tatashin@soleen.com>:=

>=20
> =EF=BB=BFRecently, I encountered a hang that is happening during memory ho=
t
> remove operation. It turns out that the hang is caused by pinned user
> pages in ZONE_MOVABLE.
>=20
> Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
> this is not the case if a user applications such as through dpdk
> libraries pinned them via vfio dma map. Kernel keeps trying to
> hot-remove them, but refcnt never gets to zero, so we are looping
> until the hardware watchdog kicks in.
>=20
> We cannot do dma unmaps before hot-remove, because hot-remove is a
> slow operation, and we have thousands for network flows handled by
> dpdk that we just cannot suspend for the duration of hot-remove
> operation.
>=20

Hi!

It=E2=80=98s a known problem also for VMs using vfio. I thought about this s=
ome while ago an came to the same conclusion: before performing long-term pi=
nnings, we have to migrate pages off the movable zone. After that, it=E2=80=98=
s too late.

What happens when we can=E2=80=98t migrate (OOM on !MOVABLE memory, short-te=
rm pinning)? TBD.

> The solution is for dpdk to allocate pages from a zone below
> ZONE_MOVAVLE, i.e. ZONE_NORMAL/ZONE_HIGHMEM, but this is not possible.
> There is no user interface that we have that allows applications to
> select what zone the memory should come from.
>=20
> I've spoken with Stephen Hemminger, and he said that DPDK is moving in
> the direction of using transparent huge pages instead of HugeTLBs,
> which means that we need to allow at least anonymous, and anonymous
> transparent huge pages to come from non-movable zones on demand.
>=20
> Here is what I am proposing:
> 1. Add a new flag that is passed through pin_user_pages_* down to
> fault handlers, and allow the fault handler to allocate from a
> non-movable zone.
>=20
> Sample function stacks through which this info needs to be passed is this:=

>=20
> pin_user_pages_remote(gup_flags)
> __get_user_pages_remote(gup_flags)
>  __gup_longterm_locked(gup_flags)
>   __get_user_pages_locked(gup_flags)
>    __get_user_pages(gup_flags)
>     faultin_page(gup_flags)
>      Convert gup_flags into fault_flags
>      handle_mm_fault(fault_flags)
>=20
> =46rom handle_mm_fault(), the stack diverges into various faults,
> examples include:
>=20
> Transparent Huge Page
> handle_mm_fault(fault_flags)
> __handle_mm_fault(fault_flags)
> Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
> create_huge_pmd(vmf);
> do_huge_pmd_anonymous_page(vmf);
> mm_get_huge_zero_page(vma->vm_mm); -> flag is lost, so flag from
> vmf.gfp_mask should be passed as well.
>=20
> There are several other similar paths in a transparent huge page, also
> there is a named path where allocation is based on filesystems, and
> the flag should be honored there as well, but it does not have to be
> added at the same time.
>=20
> Regular Pages
> handle_mm_fault(fault_flags)
> __handle_mm_fault(fault_flags)
> Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
> handle_pte_fault(vmf)
> do_anonymous_page(vmf);
> page =3D alloc_zeroed_user_highpage_movable(vma, vmf->address); ->
> replace change this call according to gfp_mask.
>=20
> The above only take care of the case if user application faults on the
> page during pinning time, but there are also cases where pages already
> exist.
>=20
> 2. Add an internal move_pages_zone() similar to move_pages() syscall
> but instead of migrating to a different NUMA node, migrate pages from
> ZONE_MOVABLE to another zone.
> Call move_pages_zone() on demand prior to pinning pages from
> vfio_pin_map_dma() for instance.
>=20
> 3. Perhaps, it also makes sense to add madvise() flag, to allocate
> pages from non-movable zone. When a user application knows that it
> will do DMA mapping, and pin pages for a long time, the memory that it
> allocates should never be migrated or hot-removed, so make sure that
> it comes from the appropriate place.
> The benefit of adding madvise() flag is that we won't have to deal
> with slow page migration during pin time, but the disadvantage is that
> we would need to change the user interface.
>=20

Hm, I am not sure we want to expose these details. What would be the semanti=
cs? =E2=80=9EMight pin=E2=80=9C? Hm, not sure.

Assume you start a fresh VM via QEMU with vfio. When we start mapping guest m=
emory via vfio, that=E2=80=98s usually the time memory will get populated. N=
ot really much has to be migrated. I think this is even true during live mig=
ration.

I think selective DMA pinning (e.g., vIOMMU in QEMU) is different, where we k=
eep pinning/unpinning on demand. But I guess even here, we will often reuse s=
ome pages over and over again.


> Before I start working on the above approaches, I would like to get an
> opinion from the community on an appropriate path forward for this
> problem. If what I described sounds reasonable, or if there are other
> ideas on how to address the problem that I am seeing.

At least 1 and 2 sound sane. 3 is TBD - but it=E2=80=98s a pure optimization=
, so it can wait.

Thanks!

>=20
> Thank you,
> Pasha
>=20

