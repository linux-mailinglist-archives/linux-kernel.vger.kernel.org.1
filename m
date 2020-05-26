Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961DA1BE2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgD2Pjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 11:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgD2Pjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:39:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01CBC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:39:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e25so3115214ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qP3I6OPRVWktvzkLiuD0CRDumnj0JjO4b9VfB41a1Gg=;
        b=Av56D6yt+xBIXmC+kkn2QjTa6cXAqFcY2i0P234NzbBxlJGw51PW6TFOIwMUy2fJsf
         yqbKnIiU2BsuH1oz2LImBIjciM0jjzzHA2bWIFs99MigbHTNPdwc61euBXbFOI98aEoE
         +qcfQWleDUj3wviEzHoApiiIeqLu2H7MXV8mZEwYiuUghh56+/fL31/Z+1ExBkjaMY93
         mM2/7D8ofSQJBXR+jEbTfCU4dFWdX9X6WnkNeafCWZdC2N95GIm6XRHZAONMnDq/DJsr
         5DSATLf8PG6yZq3QcUh98cb1Ml74AJkXtAtpkbhRO9/h2FFeleCFdwrZqWwr3NyrokcO
         VcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qP3I6OPRVWktvzkLiuD0CRDumnj0JjO4b9VfB41a1Gg=;
        b=Ln8QTDWjxhAoRzlKd2y4Px8UxPo9tnaW4PIy/mKkD4bqfCfLtaE64RTrVr465c0RKJ
         W5iwmUKu6LIDseGf7CFZt+lN/6oLWsz2uXtQRQhDwFoF3Fje7kSkBVxEQTwQxRNuNZJr
         Vwo2mOlytU+NwAeQTyxGNkgesmVtD5pIYbFSI0w3FWInxgEQtI0SGEIyKXBAmb1Fl+HI
         AIUDjSP4nQbKLq3bNheU8JPYQzqCdkiRXpg1LzT2g9kNlO9WvTjcl7YWG8J7m9FhUIPs
         IzhXG0pyiY7izvJVTFGoyM0de3hm6Djc6gcRiARZ6w86249MtjkXdNt8pYm/vxcb9MCv
         /gGA==
X-Gm-Message-State: AGi0Pua2y9K/AYRO9LRGj8Hz+cI4JhbSpQq3rdtgEf0IXHevD6AyNd4I
        ha1Zb6v1DweRt74hGj6AmtLLv4jw/OY=
X-Google-Smtp-Source: APiQypK1xFR5litchNV0f6pAe9wwsLoR7dp/Vk/RX6+WG2yQC5hmTjx30oqeL3LDl+iUDS/VE4Yhgw==
X-Received: by 2002:a2e:330f:: with SMTP id d15mr2686948ljc.250.1588174792271;
        Wed, 29 Apr 2020 08:39:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i20sm3151493lfe.15.2020.04.29.08.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 08:39:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E045B1021F9; Wed, 29 Apr 2020 18:40:02 +0300 (+03)
Date:   Wed, 29 Apr 2020 18:40:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/25] Large pages in the page cache
Message-ID: <20200429154002.n3mq2ysz37puf73y@box>
References: <20200429133657.22632-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 06:36:32AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This patch set does not pass xfstests.  Test at your own risk.  It is
> based on the readahead rewrite which is in Andrew's tree.  The large
> pages somehow manage to fall off the LRU, so the test VM quickly runs
> out of memory and freezes.  To reproduce:
> 
> # mkfs.xfs /dev/sdb && mount /dev/sdb /mnt && dd if=/dev/zero bs=1M count=2048 of=/mnt/bigfile && sync && sleep 2 && sync && echo 1 >/proc/sys/vm/drop_caches 
> # /host/home/willy/kernel/xarray-2/tools/vm/page-types | grep thp
> 0x0000000000401800	       511        1  ___________Ma_________t____________________	mmap,anonymous,thp
> 0x0000000000405868	         1        0  ___U_lA____Ma_b_______t____________________	uptodate,lru,active,mmap,anonymous,swapbacked,thp
> # dd if=/mnt/bigfile of=/dev/null bs=2M count=5
> # /host/home/willy/kernel/xarray-2/tools/vm/page-types | grep thp
> 0x0000000000400000	      2516        9  ______________________t____________________	thp
> 0x0000000000400028	         1        0  ___U_l________________t____________________	uptodate,lru,thp
> 0x000000000040006c	       106        0  __RU_lA_______________t____________________	referenced,uptodate,lru,active,thp

Note that you have 107 pages on LRU. It is only head pages. With order-5
pages it is over 13MiB.

Looks like everything is fine.

> 0x0000000000400228	         1        0  ___U_l___I____________t____________________	uptodate,lru,reclaim,thp
> 0x0000000000401800	       511        1  ___________Ma_________t____________________	mmap,anonymous,thp
> 0x0000000000405868	         1        0  ___U_lA____Ma_b_______t____________________	uptodate,lru,active,mmap,anonymous,swapbacked,thp
> 
> 
> The principal idea here is that a large part of the overhead in dealing
> with individual pages is that there's just so darned many of them.  We
> would be better off dealing with fewer, larger pages, even if they don't
> get to be the size necessary for the CPU to use a larger TLB entry.
> 
> Matthew Wilcox (Oracle) (24):
>   mm: Allow hpages to be arbitrary order
>   mm: Introduce thp_size
>   mm: Introduce thp_order
>   mm: Introduce offset_in_thp
>   fs: Add a filesystem flag for large pages
>   fs: Introduce i_blocks_per_page
>   fs: Make page_mkwrite_check_truncate thp-aware
>   fs: Support THPs in zero_user_segments
>   bio: Add bio_for_each_thp_segment_all
>   iomap: Support arbitrarily many blocks per page
>   iomap: Support large pages in iomap_adjust_read_range
>   iomap: Support large pages in read paths
>   iomap: Support large pages in write paths
>   iomap: Inline data shouldn't see large pages
>   xfs: Support large pages
>   mm: Make prep_transhuge_page return its argument
>   mm: Add __page_cache_alloc_order
>   mm: Allow large pages to be added to the page cache
>   mm: Allow large pages to be removed from the page cache
>   mm: Remove page fault assumption of compound page size
>   mm: Add DEFINE_READAHEAD
>   mm: Make page_cache_readahead_unbounded take a readahead_control
>   mm: Make __do_page_cache_readahead take a readahead_control
>   mm: Add large page readahead
> 
> William Kucharski (1):
>   mm: Align THP mappings for non-DAX
> 
>  drivers/nvdimm/btt.c    |   4 +-
>  drivers/nvdimm/pmem.c   |   6 +-
>  fs/ext4/verity.c        |   4 +-
>  fs/f2fs/verity.c        |   4 +-
>  fs/iomap/buffered-io.c  | 110 ++++++++++++++++--------------
>  fs/jfs/jfs_metapage.c   |   2 +-
>  fs/xfs/xfs_aops.c       |   4 +-
>  fs/xfs/xfs_super.c      |   2 +-
>  include/linux/bio.h     |  13 ++++
>  include/linux/bvec.h    |  23 +++++++
>  include/linux/fs.h      |   1 +
>  include/linux/highmem.h |  15 +++--
>  include/linux/huge_mm.h |  25 +++++--
>  include/linux/mm.h      |  97 ++++++++++++++-------------
>  include/linux/pagemap.h |  62 ++++++++++++++---
>  mm/filemap.c            |  60 ++++++++++++-----
>  mm/highmem.c            |  62 ++++++++++++++++-
>  mm/huge_memory.c        |  49 ++++++--------
>  mm/internal.h           |  13 ++--
>  mm/memory.c             |   7 +-
>  mm/page_io.c            |   2 +-
>  mm/page_vma_mapped.c    |   4 +-
>  mm/readahead.c          | 145 ++++++++++++++++++++++++++++++----------
>  23 files changed, 485 insertions(+), 229 deletions(-)
> 
> -- 
> 2.26.2
> 

-- 
 Kirill A. Shutemov
