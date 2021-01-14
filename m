Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BAE2F59EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 05:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbhANEcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 23:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbhANEcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 23:32:22 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8C4C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:31:41 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id p5so4671401oif.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JpVnzwXDtkHwenpkUE21vZW7L/3kV39UhMH2nbmFqWM=;
        b=blug7ajAa4fgIPSwbXBLHxHwHiV9Qvfp5d6NtwgJBghtC9xEuMxvbuYSM+uNcpJ4yv
         WEEqy/x4Qs9hKoiZUTYaBk152lxV95Dv5r//cXWFE7rZhqZ5Mip2eJZlS/e8Cv0gLxV6
         XEA/ZDoodq0Ic83FCJPuuEFjIlyzAMdYyG+RUwIq2dUnMKUCgf6Ths9d2SmoYJnieaOl
         atdKKkK3GmHjh55E9xyp+7Ww3EmcUtrhssgT1pLVl9dtIBQ9AxtQ7R/ntTd0YKiSVi8/
         nVP8eodhJ9IwgRGInQZFBICbe8j0Z7PTx0e2TlVSuWUD8hM1FGwlABqt0NKsP7d6KiWN
         FAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JpVnzwXDtkHwenpkUE21vZW7L/3kV39UhMH2nbmFqWM=;
        b=iM8e3SYUytrJDq75FCLPJpTboI6bdi8QWe2ghLyzOaVZN1BZ6td2McYykIK123XWkz
         IWtP2HftejPJyk2J4wp4QMusBuSuS2B+F7OhPSROyu6qq1IK+d03h2ceGmBr/Mw0Ir/0
         ZtKXhK0SBHTR5R9pfuIWOmWccsJBnGa8XbbGm+UAOCFPXcXLukokr+1VgjacJFxwTxX2
         iWxxkL8lKRGxdjioRfmfHGIgapAkK8QtacLMik6L0VmVv/h6tzOdgjyXIUyAHVhsuelR
         VqumOIhEzlOG0aOqE0g3Hei2cPkAA6R29nOf5UmAbBGEBs141ObXdd6RxUhox9Lxq9uK
         QskQ==
X-Gm-Message-State: AOAM530wurhQ348pVEAdNi5rThUo5v8YSH2mw4ouz8wBFv1tMPQARMCL
        3LhoGjagd548D509EuWOyIDadw==
X-Google-Smtp-Source: ABdhPJzPPGAlo4IKNDwvJg9HpgNIDt7ESoLbeCmOrKt0BADqAxkIOsbmR8aY4eREXFuBKl5Ppwwpzg==
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr1543795oic.47.1610598699830;
        Wed, 13 Jan 2021 20:31:39 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x31sm861435otb.4.2021.01.13.20.31.38
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 13 Jan 2021 20:31:39 -0800 (PST)
Date:   Wed, 13 Jan 2021 20:31:23 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Suleiman Souhlal <suleiman@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: madvise(MADV_REMOVE) deadlocks on shmem THP
In-Reply-To: <X/+7dkbhNtAVV+wd@google.com>
Message-ID: <alpine.LSU.2.11.2101132000500.4777@eggly.anvils>
References: <X/+7dkbhNtAVV+wd@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021, Sergey Senozhatsky wrote:

> Hi,
> 
> We are running into lockups during the memory pressure tests on our
> boards, which essentially NMI panic them. In short the test case is
> 
> - THP shmem
>     echo advise > /sys/kernel/mm/transparent_hugepage/shmem_enabled
> 
> - And a user-space process doing madvise(MADV_HUGEPAGE) on new mappings,
>   and madvise(MADV_REMOVE) when it wants to remove the page range
> 
> The problem boils down to the reverse locking chain:
> 	kswapd does
> 
> 		lock_page(page) -> down_read(page->mapping->i_mmap_rwsem)
> 
> 	madvise() process does
> 
> 		down_write(page->mapping->i_mmap_rwsem) -> lock_page(page)
> 
> 
> 
> CPU0                                                       CPU1
> 
> kswapd                                                     vfs_fallocate()
>  shrink_node()                                              shmem_fallocate()
>   shrink_active_list()                                       unmap_mapping_range()
>    page_referenced() << lock page:PG_locked >>                unmap_mapping_pages()  << down_write(mapping->i_mmap_rwsem) >>
>     rmap_walk_file()                                           zap_page_range_single()
>      down_read(mapping->i_mmap_rwsem) << W-locked on CPU1>>     unmap_page_range()
>       rwsem_down_read_failed()                                   __split_huge_pmd()
>        __rwsem_down_read_failed_common()                          __lock_page()  << PG_locked on CPU0 >>
>         schedule()                                                 wait_on_page_bit_common()
>                                                                     io_schedule()

Very interesting, Sergey: many thanks for this report.

There is no doubt that kswapd is right in its lock ordering:
__split_huge_pmd() is in the wrong to be attempting lock_page().

Which used not to be done, but was added in 5.8's c444eb564fb1 ("mm:
thp: make the THP mapcount atomic against __split_huge_pmd_locked()").

Which explains why this deadlock was not seen years ago: that
surprised me at first, since the case you show to reproduce it is good,
but I'd expect more common ways in which that deadlock could show up.

And your report is remarkably timely too: I have two other reasons
for looking at that change at the moment (I'm currently catching up
with recent discussion of page_count versus mapcount when deciding
COW page reuse).

I won't say more tonight, but should have more to add tomorrow.

Hugh
