Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409862C0EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbgKWPb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389536AbgKWPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:31:54 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:31:53 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mc24so2778884ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIZYbFnYdwj7TViAxEdW/8HWXJPnofI2KBoUzM1Et1w=;
        b=iT+pGSg6Cx/G8/LTFQRRDQok0gvbqLFnc0bXOhWkbrJGuE1Ovbz2uwIfLkpTn01+qJ
         O8rDNv7d1DItT8Qn7hHGy6UWl4YOZfC7ferFvnenKMcRvFEzKh/EBxGDGdKTWRuvLwFw
         9exeVTwUWk9tSVOT2UdJu9RPs2wgkEiTPi2rdIOOq8GO0fz0AZbZICU39aCKWuHMcEno
         yrFGoQKFM2atxvBSq1qrj0Ul7w8vTIfotcZVrJErR5Q9AgnWdimb8kFS49Xr7OiW7/bu
         S0p9FpcguwNpxRluVWWNMfGSW0mXagL7wN0mjWxILNf4GPVXTRmkvGG1HW89NYw1OLpO
         xvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIZYbFnYdwj7TViAxEdW/8HWXJPnofI2KBoUzM1Et1w=;
        b=tJs2XWvgCwHE2f11yzUSSg46Ph/B2tb412Kl90roSPiJDPA7hGuJS7a8jR8fsXfz1z
         GosTjy+tGPnFd7h3tE8+FMnrB2t8AA1yOKQq9gyOcNqLtGbFDT6aVJznXeYAjOmHewMw
         xI038R47t5zc/dzO/qYmjR3OtvcJ0DrGdCchYWzre5fLhvh7hImsMo0/iRk+na0AixVf
         dEJ8ZenHqSZsByMg+jVk+r3GYC+XIKdAJqNLon/DicJQXZf1WMSnQqxJeZb7khg0k35+
         TqhK8wELxEI/jhetX6m4MbYOU1jrgG6mrCFHwDlPMnNG6VHZZp9l9yI8bklTBN4EsI6s
         PX8Q==
X-Gm-Message-State: AOAM530K33J/+f8OPRJ0BkDpKSo/4wAtIOxLszA92zkdh4a8c8E7cV7E
        ftdhoADvZsqTi/k+0wZodVLFASVZH9Nh/x9YmS/zXg==
X-Google-Smtp-Source: ABdhPJxvfdnsQoBDcnwU9RmbQfQCopwizkSh/xOwsvjU8fVDgwdXdrtbw1GyjMWt9G9vgn4um/njtRede6eK4c/lVlY=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr108385ejh.383.1606145512254;
 Mon, 23 Nov 2020 07:31:52 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <alpine.DEB.2.23.453.2011221300100.2830030@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.23.453.2011221300100.2830030@chino.kir.corp.google.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 23 Nov 2020 10:31:16 -0500
Message-ID: <CA+CK2bBkRmm+ex5pfD7s8LGQLYCwO1EHPNeQ+pGW=ztb6AfVqA@mail.gmail.com>
Subject: Re: Pinning ZONE_MOVABLE pages
To:     David Rientjes <rientjes@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've spoken with Stephen Hemminger, and he said that DPDK is moving in
> > the direction of using transparent huge pages instead of HugeTLBs,
> > which means that we need to allow at least anonymous, and anonymous
> > transparent huge pages to come from non-movable zones on demand.
> >
>
> I'd like to know more about this use case, ZONE_MOVABLE is typically a
> great way to optimize for thp availability because, absent memory pinning,
> this memory can always be defragmented.  So the idea is that DPDK will now
> allocate all of its thp from ZONE_NORMAL or only a small subset?  Seems
> like an invitation for oom kill if the sizing of ZONE_NORMAL is
> insufficient.

The idea is to allocate only those THP and anon pages that are long
term pinned from ZONE_NORMAL, the rest can still be allocated from
ZONE_MOVABLE.

>
> > Here is what I am proposing:
> > 1. Add a new flag that is passed through pin_user_pages_* down to
> > fault handlers, and allow the fault handler to allocate from a
> > non-movable zone.
> >
> > Sample function stacks through which this info needs to be passed is this:
> >
> > pin_user_pages_remote(gup_flags)
> >  __get_user_pages_remote(gup_flags)
> >   __gup_longterm_locked(gup_flags)
> >    __get_user_pages_locked(gup_flags)
> >     __get_user_pages(gup_flags)
> >      faultin_page(gup_flags)
> >       Convert gup_flags into fault_flags
> >       handle_mm_fault(fault_flags)
> >
> > From handle_mm_fault(), the stack diverges into various faults,
> > examples include:
> >
> > Transparent Huge Page
> > handle_mm_fault(fault_flags)
> > __handle_mm_fault(fault_flags)
> > Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
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
> > Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
> > handle_pte_fault(vmf)
> > do_anonymous_page(vmf);
> > page = alloc_zeroed_user_highpage_movable(vma, vmf->address); ->
> > replace change this call according to gfp_mask.
> >
>
> This would likely be useful for AMD SEV as well, which requires guest
> pages to be pinned because the encryption algorithm depends on the host
> physical address.  This ensures that plaintext memory for two pages don't
> result in the same ciphertext.
