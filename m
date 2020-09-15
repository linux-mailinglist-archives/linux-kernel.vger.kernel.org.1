Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98D726A0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgIOI0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgIOIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:10:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB07C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:10:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t138so3418958qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+JVatOz5/Dh/xyAg85UUTlc2Kova9GVo8Ydw6vbee8g=;
        b=nIyTzeIBrWUervNx+ZYSIQs3H/l6i7vwus2Ha3I8FVsJWME+6Q6zBuLHukcO1Xcij/
         j5R4e/ZCmOxtNw9oAWHeZq7ZmEeuOE1wVGnjbF/JEFb/h3Gpyr0zY82TI5IU8HJa3iwt
         wI+5RRixk+oQKYUF3g9xUmcY8v+Lbh/cTzjxMNENwyG+h/fSBMLQK4/VS47P+Igi7oZ1
         9UckvC1TShzWV6/MknJfpHzSm2rh16Zq6E3B4Oi9mvYBkd/oM5Ats+6fyFmiLQab2Du2
         7pn/Dd1cLCSugZFKNESH19JPHq/CXBJqNAhX10PcHYs8QaZCnL/QDibmKOhKsKMRnISA
         U9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+JVatOz5/Dh/xyAg85UUTlc2Kova9GVo8Ydw6vbee8g=;
        b=e5PjZ1NXRLw23e+3ykP0CVi7klVRWwxjXfn2708yq85yGz9pOmsqlYDoBkgLWGYiZS
         pAmoddPNvTGd0MXuxNZdAchM2v74XYuMG/Fj6bkXn/em4r3aI7jI08Bnxzjou+cSBlTI
         LX64+XuSySeIft0+tBeAwsv3ILAMMazNlb5rgGQezqw8jl7/y6tsnXQJgUePDR2n4sus
         37FoNcLuXGhrgWOK89kj5um+ErxGJIhGJP4m2/oPfqlYiI+qrI3q2jOucyfht7izVm3V
         hxrWwOU1lpTUJn8snIhDFIoYaPdcOyN7Ee8qntZqLHlsLje2Av3tq92stE4X3dZT1RBB
         glqQ==
X-Gm-Message-State: AOAM532wR11u9e+VlwhHu9JCVVG4jqMqvz+J8q6hDD8wvWbFEt0PYvPU
        bd/UvTKWpRa682m5/sCEoXqvSQ==
X-Google-Smtp-Source: ABdhPJyS7xJTZfyWz8c4kNJtOicW4XfjWeOIR89eyPboMltYWj+TUMAFVzJOuE70LfMxUb5VQs5eUg==
X-Received: by 2002:a37:a602:: with SMTP id p2mr16652323qke.254.1600157410569;
        Tue, 15 Sep 2020 01:10:10 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u4sm15673927qkk.68.2020.09.15.01.10.06
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 15 Sep 2020 01:10:08 -0700 (PDT)
Date:   Tue, 15 Sep 2020 01:10:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Return head pages from find_*_entry
In-Reply-To: <20200910183318.20139-1-willy@infradead.org>
Message-ID: <alpine.LSU.2.11.2009150059310.1550@eggly.anvils>
References: <20200910183318.20139-1-willy@infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020, Matthew Wilcox (Oracle) wrote:

> This patch series started out as part of the THP patch set, but it has
> some nice effects along the way and it seems worth splitting it out and
> submitting separately.
> 
> Currently find_get_entry() and find_lock_entry() return the page
> corresponding to the requested index, but the first thing most callers do
> is find the head page, which we just threw away.  As part of auditing
> all the callers, I found some misuses of the APIs and some plain
> inefficiencies that I've fixed.
> 
> The diffstat is unflattering, but I added more kernel-doc and a new wrapper.
> 
> v2:
>  - Rework how shmem_getpage_gfp() handles getting a head page back from
>    find_lock_entry()
>  - Renamed find_get_swap_page() to find_get_incore_page()
>  - Make sure find_get_incore_page() doesn't return a head page
>  - Fix the missing include of linux/shmem_fs.h
>  - Move find_get_entry and find_lock_entry prototypes to mm/internal.h
>  - Rename thp_valid_index() to thp_contains()
>  - Fix thp_contains() for hugetlbfs and swapcache
>  - Add find_lock_head() wrapper around pagecache_get_page()
> 
> Matthew Wilcox (Oracle) (8):
>   mm: Factor find_get_incore_page out of mincore_page
>   mm: Use find_get_incore_page in memcontrol
>   mm: Optimise madvise WILLNEED
>   proc: Optimise smaps for shmem entries
>   i915: Use find_lock_page instead of find_lock_entry
>   mm: Convert find_get_entry to return the head page
>   mm/shmem: Return head page from find_lock_entry
>   mm: Add find_lock_head
> 
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  4 +--
>  fs/proc/task_mmu.c                        |  8 +----
>  include/linux/pagemap.h                   | 43 +++++++++++++++++-----
>  include/linux/swap.h                      |  7 ++++
>  mm/filemap.c                              | 44 +++++++++++------------
>  mm/internal.h                             |  3 ++
>  mm/madvise.c                              | 21 ++++++-----
>  mm/memcontrol.c                           | 24 ++-----------
>  mm/mincore.c                              | 28 ++-------------
>  mm/shmem.c                                | 20 +++++------
>  mm/swap_state.c                           | 32 +++++++++++++++++
>  11 files changed, 127 insertions(+), 107 deletions(-)
> 
> -- 
> 2.28.0

I was testing mmotm today (plus the shmem.c and swap_state.c
fixes that you posted, but I did not try the madvise.c one) -
my usual tmpfs swapping loads (plus hyperactive khugepaged to
maximize the THPs).  It behaved well, no problems found.

But I probably won't get to try your series of 12 for a few days.

Hugh
