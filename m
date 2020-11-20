Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF412BB8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgKTWGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:06:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgKTWGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605909971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbFV32ygDz7qsaJYh4yraORMBM+FGxbd+GP8M8kteqw=;
        b=QesuM10cSiM3kTAJrvhRjCtZwMyATtUrJcoPyY9pgkY3hztHTYnYMOTJJupxED6MQvZNGU
        DNj8d16k0A83UxLr0vGgyM2owX2ij51PYTKQjewoAmD3P3VpRJ61YyGO9iBdeFDViGkn2y
        ujecetQZEBviKHSV2mdEaLt7Qq/KgNs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-R_pCn-JcOHOTaPSd2Bbx9Q-1; Fri, 20 Nov 2020 17:06:09 -0500
X-MC-Unique: R_pCn-JcOHOTaPSd2Bbx9Q-1
Received: by mail-wr1-f69.google.com with SMTP id g5so3882972wrp.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FbFV32ygDz7qsaJYh4yraORMBM+FGxbd+GP8M8kteqw=;
        b=TdUDupCshHaRQu+B/6OivBwRhj0ktbkelADYyd3AFHuCNi8iyz4fPbIT2q6meDp9Or
         +6cNEupkHWT2jiQqHzyn0wzC8WE9aSxEj5mgd0kXKHUMN9WTGAButI37pZ4nOEpRUKWb
         kyVTLU2FwWsWjhkFNp1fzqhKnNjUiK3uWDiK6AZUtoshCFVDWCPJ+IF7tyGQs5mLEUyQ
         Vvh435VPPUUbtWU5Kx00sKLquYplpI8TVLsoOLuMxix4cuYVTMQfgcMmysevl7cH7v1L
         ak0R5rW8JZPTo5iisR/QQpYvLk0AIzeM/cc352026am0WqhzUXdPf/L+3Vsb4ymeDEoF
         Dx9Q==
X-Gm-Message-State: AOAM5329ZM6g3qKwBE23+LOYVUxsapyx6qjc6L/jQdPSizI6+3qKVmaa
        XMDUbUE7viTFhhBTzOHIrT741uX7UFB7Bw2aEcckxpj9xMPrbA5m+Gk/Ip7kGSNTHX1JGkhb+b2
        e7cdKxI2LCuq9bO0rGZeKQo4l
X-Received: by 2002:a7b:c309:: with SMTP id k9mr11829404wmj.14.1605909966921;
        Fri, 20 Nov 2020 14:06:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEM98LDUf+EVjrqARV7ebgtFqhhBe1exDpHAefUWWWQXX/9FolmyIU3Y2xaV0me8hxWz9M/w==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr11829394wmj.14.1605909966648;
        Fri, 20 Nov 2020 14:06:06 -0800 (PST)
Received: from [192.168.3.114] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id e6sm5879095wme.27.2020.11.20.14.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 14:06:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Pinning ZONE_MOVABLE pages
Date:   Fri, 20 Nov 2020 23:06:05 +0100
Message-Id: <C7D46852-8A95-4337-BAB6-294DE2243EEA@redhat.com>
References: <CA+CK2bABKyd1xvpOXjcGxsAzxTvZsiutkCAPm-FUmseFFaRqNQ@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
In-Reply-To: <CA+CK2bABKyd1xvpOXjcGxsAzxTvZsiutkCAPm-FUmseFFaRqNQ@mail.gmail.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 20.11.2020 um 22:58 schrieb Pavel Tatashin <pasha.tatashin@soleen.com>:=

>=20
> =EF=BB=BFOn Fri, Nov 20, 2020 at 3:59 PM David Hildenbrand <david@redhat.c=
om> wrote:
>>=20
>>=20
>>>> Am 20.11.2020 um 21:28 schrieb Pavel Tatashin <pasha.tatashin@soleen.co=
m>:
>>>=20
>>> =EF=BB=BFRecently, I encountered a hang that is happening during memory h=
ot
>>> remove operation. It turns out that the hang is caused by pinned user
>>> pages in ZONE_MOVABLE.
>>>=20
>>> Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
>>> this is not the case if a user applications such as through dpdk
>>> libraries pinned them via vfio dma map. Kernel keeps trying to
>>> hot-remove them, but refcnt never gets to zero, so we are looping
>>> until the hardware watchdog kicks in.
>>>=20
>>> We cannot do dma unmaps before hot-remove, because hot-remove is a
>>> slow operation, and we have thousands for network flows handled by
>>> dpdk that we just cannot suspend for the duration of hot-remove
>>> operation.
>>>=20
>>=20
>> Hi!
>>=20
>> It=E2=80=98s a known problem also for VMs using vfio. I thought about thi=
s some while ago an came to the same conclusion: before performing long-term=
 pinnings, we have to migrate pages off the movable zone. After that, it=E2=80=
=98s too late.
>>=20
>> What happens when we can=E2=80=98t migrate (OOM on !MOVABLE memory, short=
-term pinning)? TBD.
>>=20
>>> The solution is for dpdk to allocate pages from a zone below
>>> ZONE_MOVAVLE, i.e. ZONE_NORMAL/ZONE_HIGHMEM, but this is not possible.
>>> There is no user interface that we have that allows applications to
>>> select what zone the memory should come from.
>>>=20
>>> I've spoken with Stephen Hemminger, and he said that DPDK is moving in
>>> the direction of using transparent huge pages instead of HugeTLBs,
>>> which means that we need to allow at least anonymous, and anonymous
>>> transparent huge pages to come from non-movable zones on demand.
>>>=20
>>> Here is what I am proposing:
>>> 1. Add a new flag that is passed through pin_user_pages_* down to
>>> fault handlers, and allow the fault handler to allocate from a
>>> non-movable zone.
>>>=20
>>> Sample function stacks through which this info needs to be passed is thi=
s:
>>>=20
>>> pin_user_pages_remote(gup_flags)
>>> __get_user_pages_remote(gup_flags)
>>> __gup_longterm_locked(gup_flags)
>>>  __get_user_pages_locked(gup_flags)
>>>   __get_user_pages(gup_flags)
>>>    faultin_page(gup_flags)
>>>     Convert gup_flags into fault_flags
>>>     handle_mm_fault(fault_flags)
>>>=20
>>> =46rom handle_mm_fault(), the stack diverges into various faults,
>>> examples include:
>>>=20
>>> Transparent Huge Page
>>> handle_mm_fault(fault_flags)
>>> __handle_mm_fault(fault_flags)
>>> Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask=

>>> create_huge_pmd(vmf);
>>> do_huge_pmd_anonymous_page(vmf);
>>> mm_get_huge_zero_page(vma->vm_mm); -> flag is lost, so flag from
>>> vmf.gfp_mask should be passed as well.
>>>=20
>>> There are several other similar paths in a transparent huge page, also
>>> there is a named path where allocation is based on filesystems, and
>>> the flag should be honored there as well, but it does not have to be
>>> added at the same time.
>>>=20
>>> Regular Pages
>>> handle_mm_fault(fault_flags)
>>> __handle_mm_fault(fault_flags)
>>> Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask=

>>> handle_pte_fault(vmf)
>>> do_anonymous_page(vmf);
>>> page =3D alloc_zeroed_user_highpage_movable(vma, vmf->address); ->
>>> replace change this call according to gfp_mask.
>>>=20
>>> The above only take care of the case if user application faults on the
>>> page during pinning time, but there are also cases where pages already
>>> exist.
>>>=20
>>> 2. Add an internal move_pages_zone() similar to move_pages() syscall
>>> but instead of migrating to a different NUMA node, migrate pages from
>>> ZONE_MOVABLE to another zone.
>>> Call move_pages_zone() on demand prior to pinning pages from
>>> vfio_pin_map_dma() for instance.
>>>=20
>>> 3. Perhaps, it also makes sense to add madvise() flag, to allocate
>>> pages from non-movable zone. When a user application knows that it
>>> will do DMA mapping, and pin pages for a long time, the memory that it
>>> allocates should never be migrated or hot-removed, so make sure that
>>> it comes from the appropriate place.
>>> The benefit of adding madvise() flag is that we won't have to deal
>>> with slow page migration during pin time, but the disadvantage is that
>>> we would need to change the user interface.
>>>=20
>>=20
>> Hm, I am not sure we want to expose these details. What would be the sema=
ntics? =E2=80=9EMight pin=E2=80=9C? Hm, not sure.
>=20
> The semantic would be PA must not change, something that DPDK
> currently excpects from huge pages, which by the way is not true, as
> huge pages are migratable.
>=20
>>=20
>> Assume you start a fresh VM via QEMU with vfio. When we start mapping gue=
st memory via vfio, that=E2=80=98s usually the time memory will get populate=
d. Not really much has to be migrated. I think this is even true during live=
 migration.
>>=20
>> I think selective DMA pinning (e.g., vIOMMU in QEMU) is different, where w=
e keep pinning/unpinning on demand. But I guess even here, we will often reu=
se some pages over and over again.
>>=20
>>=20
>>> Before I start working on the above approaches, I would like to get an
>>> opinion from the community on an appropriate path forward for this
>>> problem. If what I described sounds reasonable, or if there are other
>>> ideas on how to address the problem that I am seeing.
>>=20
>> At least 1 and 2 sound sane. 3 is TBD - but it=E2=80=98s a pure optimizat=
ion, so it can wait.
>=20
> Makes sense, I am also worried about 3, but most of madvise() flags
> are for pure optimization purposes: MADV_HUGEPAGE, MADV_SEQUENTIAL,
> MADV_WILLNEED etc.

BTW, I assume we should also directly tackle migrating pages off CMA regions=
 when pinning, I guess quite some people will be interested in that as well.=


Have a nice weekend and thanks for looking into this issue :)=

