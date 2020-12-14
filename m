Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D192DA275
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 22:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503612AbgLNVRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 16:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgLNVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 16:17:33 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE7C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:16:53 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f16so17210299otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6f8m1ssHwXG9JNfNkbWg5A0BGB7gO6er1DG8qgB1GbU=;
        b=lQtFHlz+McBNdaTM9p3vvq/RNx3aW3GUOVEPN8x9M3UPEHpq4L2jEg48d1ycfeCGJv
         WQXIZOV0/JdW2XUwDinnlyZUjL6HFk21AC2WlUWcwXA1Yq8CdcnbfPkr34iPmAL1rcPe
         KIOtpFe8UcpiaN1oKrRxsA+MRHKS2J9cGhxbsoKpHQCyJskEh9JKXyYUJG77U7GYfn5F
         Zti+9gbrfQZ7TyIyEU2y0H5NwCds/b9QmEet+7hzUwaQSI2fCUFywiOFGggTXdNnFNpg
         69CbsJlhFWHzpYvqAtMRXhTWYkhBkbqGn/zNg3t9ELS0MlKIa3QypXfIGSTHxh/nBjKu
         2+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6f8m1ssHwXG9JNfNkbWg5A0BGB7gO6er1DG8qgB1GbU=;
        b=VkVkJMiWUWX8D56L/WRc4CCsbjB8+wLX4/M2UWTDt3z9TzWTvxDtHE062+BcXxLfP5
         oZKEKRKpx47coLzL9viPaHjeRMM7xNjG66R6u8UUNj09g7BTEwV6idgT1e/vU0+3JrCK
         EKuk6SjenUFq4wWPdakV9VVMw0mVBPJWP22KKTkCrKBO0QuDoh/wxXbWPJFv1uHcSOTk
         XcajyPxWsSYIl5DUlZW9Xn+VjeJMOQwki3NdN39/6hf9UQLHGzNZD5CMf+TZUrLa7Atx
         dLUua+ProEcEnChz8rQm6nZk88RZ/mZCfu+rj0BD8GWTnAJB61OVXIoSAPtyddJUAzrv
         Cvag==
X-Gm-Message-State: AOAM533XJDue641wCuOhEURNfCc3A5vwYyK04PG2WB2z9zfwPmzlNzgV
        PPUWftPwBFya/GU+2auN0Y3IlA==
X-Google-Smtp-Source: ABdhPJyLBlt1Orysb4nvb3lC1nALltH2pQLJJ86aKWyzG5xYPWANVcsxbZnzG87CdsOKa8BPNOjfUQ==
X-Received: by 2002:a05:6830:1482:: with SMTP id s2mr21216866otq.296.1607980612567;
        Mon, 14 Dec 2020 13:16:52 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f67sm4603670otb.60.2020.12.14.13.16.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 14 Dec 2020 13:16:51 -0800 (PST)
Date:   Mon, 14 Dec 2020 13:16:39 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Rik van Riel <riel@surriel.com>, hughd@google.com,
        xuyu@linux.alibaba.com, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz,
        mhocko@suse.com
Subject: Re: [PATCH v6 0/3] mm,thp,shm: limit shmem THP alloc gfp_mask
In-Reply-To: <20201124194925.623931-1-riel@surriel.com>
Message-ID: <alpine.LSU.2.11.2012141226350.1925@eggly.anvils>
References: <20201124194925.623931-1-riel@surriel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020, Rik van Riel wrote:

> The allocation flags of anonymous transparent huge pages can be controlled
> through the files in /sys/kernel/mm/transparent_hugepage/defrag, which can
> help the system from getting bogged down in the page reclaim and compaction
> code when many THPs are getting allocated simultaneously.
> 
> However, the gfp_mask for shmem THP allocations were not limited by those
> configuration settings, and some workloads ended up with all CPUs stuck
> on the LRU lock in the page reclaim code, trying to allocate dozens of
> THPs simultaneously.
> 
> This patch applies the same configurated limitation of THPs to shmem
> hugepage allocations, to prevent that from happening.
> 
> This way a THP defrag setting of "never" or "defer+madvise" will result
> in quick allocation failures without direct reclaim when no 2MB free
> pages are available.
> 
> With this patch applied, THP allocations for tmpfs will be a little
> more aggressive than today for files mmapped with MADV_HUGEPAGE,
> and a little less aggressive for files that are not mmapped or
> mapped without that flag.
> 
> v6: make khugepaged actually obey tmpfs mount flags
> v5: reduce gfp mask further if needed, to accomodate i915 (Matthew Wilcox)
> v4: rename alloc_hugepage_direct_gfpmask to vma_thp_gfp_mask (Matthew Wilcox)
> v3: fix NULL vma issue spotted by Hugh Dickins & tested
> v2: move gfp calculation to shmem_getpage_gfp as suggested by Yu Xu

Andrew, please don't rush

mmthpshmem-limit-shmem-thp-alloc-gfp_mask.patch
mmthpshm-limit-gfp-mask-to-no-more-than-specified.patch
mmthpshmem-make-khugepaged-obey-tmpfs-mount-flags.patch

to Linus in your first wave of mmotm->5.11 sendings.
Or, alternatively, go ahead and send them to Linus, but
be aware that I'm fairly likely to want adjustments later.

Sorry for limping along so far behind, but I still have more
re-reading of the threads to do, and I'm still investigating
why tmpfs huge=always becomes so ineffective in my testing with
these changes, even if I ramp up from default defrag=madvise to
defrag=always:
                    5.10   mmotm
thp_file_alloc   4641788  216027
thp_file_fallback 275339 8895647

I've been looking into it off and on for weeks (gfp_mask wrangling is
not my favourite task! so tend to find higher priorities to divert me);
hoped to arrive at a conclusion before merge window, but still have
nothing constructive to say yet, hence my silence so far.

Above's "a little less aggressive" appears understatement at present.
I respect what Rik is trying to achieve here, and I may end up
concluding that there's nothing better to be done than what he has.
My kind of hugepage-thrashing-in-low-memory may be so remote from
normal usage, and could be skirting the latency horrors we all want
to avoid: but I haven't reached that conclusion yet - the disparity
in effectiveness still deserves more investigation.

(There's also a specific issue with the gfp_mask limiting: I have
not yet reviewed the allowing and denying in detail, but it looks
like it does not respect the caller's GFP_ZONEMASK - the gfp in
shmem_getpage_gfp() and shmem_read_mapping_page_gfp() is there to
satisfy the gma500, which wanted to use shmem but could only manage
DMA32.  I doubt it wants THPS, but shmem_enabled=force forces them.)

Thanks,
Hugh
