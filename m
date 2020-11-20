Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFAB2BB6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 21:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgKTU2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgKTU2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:28:24 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9F2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:28:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id y17so14600569ejh.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=C2+Om1iIS7SDk2zlxSKIOz8Ahx5egILl43SxFs0HB/8=;
        b=Nx+WiLu9FunBPwZt7+wY6Ng4MUP2xGGW/GY9jvlh1w6+8EjqHJEFRZYgx8WTB2p0mX
         wc61KHahpfZXfN/zWA17BbDtl4Mvs4yxZ1DGzYyTyWPASDwHYg7+Gsx13C+zZhlBWI/d
         j3Ll1ENgs9gPPeRmSmkylGcb9YJVansAMW+KogIudTowTAdCdJVFxnem+1Dt3pMpD6Lh
         lSogdpxCTH/Lqs9Z7XwuwRBDL89EPKqFTEmGPt1KJAkmvXylzEr1BnI2XO53074Z2mpu
         uk7KwDYAGUpFcO1FM9+hcS1tPOLs6io5ZjXoK6IDaRrkiTHwRIjDdKDCXRiAICAeYJV7
         ZkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=C2+Om1iIS7SDk2zlxSKIOz8Ahx5egILl43SxFs0HB/8=;
        b=hajbfn29yBFA/K5U0BeWVD2IjGLBFDSPaUgCNzvhQZgc3Qb37gEpHRkxN1cUAJs+tv
         2sSoUFYhVg8IbdDuUCDNDTvIyIUWGa2yNcchf+ds12XPXu1u8Onxp73eME+lCc2uPOlM
         LcEWKkzaxVKBtuO2B6giVcm7sg134/nnHtUzSAeoUptVveXoqfxhI6bGjQy5oMjDy3UR
         LZE2dId+YdeXiZpuEFroWSmV9fLttmANe+lkjRm2NsGNgsl0Nq9c7BEBa4GnL000cc1i
         JDTlfm6Bc2DHrINZoYa2nlJHHNteXyc3/xRM665GQW3i5l+L8SlUFgnzdWW0bMmTIjaL
         SAbA==
X-Gm-Message-State: AOAM532QRq0wCg6/K3L76LQkpLLxQauU5RmpLG9ACJhIwAJJYlXxq18u
        K9gTEr7ds1WH/ae0LKNTDV8NHxRoJojambW+719JKw==
X-Google-Smtp-Source: ABdhPJyXLCpYiOYdP512p/IvxNXIuaAsgTsA/gUCfUH4rHtjojj/tfSwglLF4TVa+xWdBwCU5jASeelXOwb4lO/9g0A=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr33589487ejh.383.1605904102943;
 Fri, 20 Nov 2020 12:28:22 -0800 (PST)
MIME-Version: 1.0
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 20 Nov 2020 15:27:46 -0500
Message-ID: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
Subject: Pinning ZONE_MOVABLE pages
To:     linux-mm <linux-mm@kvack.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I encountered a hang that is happening during memory hot
remove operation. It turns out that the hang is caused by pinned user
pages in ZONE_MOVABLE.

Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
this is not the case if a user applications such as through dpdk
libraries pinned them via vfio dma map. Kernel keeps trying to
hot-remove them, but refcnt never gets to zero, so we are looping
until the hardware watchdog kicks in.

We cannot do dma unmaps before hot-remove, because hot-remove is a
slow operation, and we have thousands for network flows handled by
dpdk that we just cannot suspend for the duration of hot-remove
operation.

The solution is for dpdk to allocate pages from a zone below
ZONE_MOVAVLE, i.e. ZONE_NORMAL/ZONE_HIGHMEM, but this is not possible.
There is no user interface that we have that allows applications to
select what zone the memory should come from.

I've spoken with Stephen Hemminger, and he said that DPDK is moving in
the direction of using transparent huge pages instead of HugeTLBs,
which means that we need to allow at least anonymous, and anonymous
transparent huge pages to come from non-movable zones on demand.

Here is what I am proposing:
1. Add a new flag that is passed through pin_user_pages_* down to
fault handlers, and allow the fault handler to allocate from a
non-movable zone.

Sample function stacks through which this info needs to be passed is this:

pin_user_pages_remote(gup_flags)
 __get_user_pages_remote(gup_flags)
  __gup_longterm_locked(gup_flags)
   __get_user_pages_locked(gup_flags)
    __get_user_pages(gup_flags)
     faultin_page(gup_flags)
      Convert gup_flags into fault_flags
      handle_mm_fault(fault_flags)

From handle_mm_fault(), the stack diverges into various faults,
examples include:

Transparent Huge Page
handle_mm_fault(fault_flags)
__handle_mm_fault(fault_flags)
Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
create_huge_pmd(vmf);
do_huge_pmd_anonymous_page(vmf);
mm_get_huge_zero_page(vma->vm_mm); -> flag is lost, so flag from
vmf.gfp_mask should be passed as well.

There are several other similar paths in a transparent huge page, also
there is a named path where allocation is based on filesystems, and
the flag should be honored there as well, but it does not have to be
added at the same time.

Regular Pages
handle_mm_fault(fault_flags)
__handle_mm_fault(fault_flags)
Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
handle_pte_fault(vmf)
do_anonymous_page(vmf);
page = alloc_zeroed_user_highpage_movable(vma, vmf->address); ->
replace change this call according to gfp_mask.

The above only take care of the case if user application faults on the
page during pinning time, but there are also cases where pages already
exist.

2. Add an internal move_pages_zone() similar to move_pages() syscall
but instead of migrating to a different NUMA node, migrate pages from
ZONE_MOVABLE to another zone.
Call move_pages_zone() on demand prior to pinning pages from
vfio_pin_map_dma() for instance.

3. Perhaps, it also makes sense to add madvise() flag, to allocate
pages from non-movable zone. When a user application knows that it
will do DMA mapping, and pin pages for a long time, the memory that it
allocates should never be migrated or hot-removed, so make sure that
it comes from the appropriate place.
The benefit of adding madvise() flag is that we won't have to deal
with slow page migration during pin time, but the disadvantage is that
we would need to change the user interface.

Before I start working on the above approaches, I would like to get an
opinion from the community on an appropriate path forward for this
problem. If what I described sounds reasonable, or if there are other
ideas on how to address the problem that I am seeing.

Thank you,
Pasha
