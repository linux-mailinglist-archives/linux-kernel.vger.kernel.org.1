Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2E2F8B24
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 05:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbhAPEZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 23:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAPEZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 23:25:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37E3C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 20:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=He/hT/oQkPJQm2nleWl8RWqaTlTD1mTAFB541L6qdLg=; b=j2dUSnMHdwizBxQ4XGAN//H+Cw
        e3FgwsjZ1iNtuThBhEGVfkbmMzJ5LLXzRYKO23EtPJpXfURl27L4XXYgVqY4rduYqEvZi7OMMdHqO
        75hA0CR8o8SvKgmZ+pD7JvDNOT11eUqa+qaplNG5TsZBOYh8A1CgDMTXt+eovvSemeW+mUkg8hHE2
        NpZkIW2ghP8sUKCA4g5C2/ENW1UqU7c82hG0E8P6K5y6stVD8479smctgMpmo8/hy3xHax/jLZlG+
        opsHsz9bNAQV+Mdo5g99788t9qK8e9MpqNq+kqTw0/ILvNVEq6lTRv3b7wriPHYzaypZMebhVVs8T
        UvuLaEJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l0d8K-009qWA-9K; Sat, 16 Jan 2021 04:24:22 +0000
Date:   Sat, 16 Jan 2021 04:24:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] hugetlb: convert page_huge_active() to HP_Migratable
 flag
Message-ID: <20210116042416.GA2260413@casper.infradead.org>
References: <20210116003105.182918-1-mike.kravetz@oracle.com>
 <20210116003105.182918-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116003105.182918-3-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 04:31:02PM -0800, Mike Kravetz wrote:
> +++ b/fs/hugetlbfs/inode.c
> @@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  
> -		set_page_huge_active(page);
> +		hugetlb_set_page_flag(page, HP_Migratable);

I had understood the request to be more like ...

		SetHPageMigratable(page);

> +++ b/include/linux/hugetlb.h
> @@ -480,9 +480,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * HP_Restore_Reserve - Set when a hugetlb page consumes a reservation at
>   *	allocation time.  Cleared when page is fully instantiated.  Free
>   *	routine checks flag to restore a reservation on error paths.
> + * HP_Migratable - Set after a newly allocated page is added to the page
> + *	cache and/or page tables.  Indicates the page is a candidate for
> + *	migration.
>   */
>  enum hugetlb_page_flags {
>  	HP_Restore_Reserve = 0,
> +	HP_Migratable,
>  };

and name these HPG_restore_reserve and HPG_migratable

and generate the calls to hugetlb_set_page_flag etc from macros, eg:

#define TESTHPAGEFLAG(uname, lname)					\
static __always_inline bool HPage##uname(struct page *page)		\
{ return test_bit(HPG_##lname, &page->private); }
...
#define HPAGEFLAG(uname, lname)						\
	TESTHPAGEFLAG(uname, lname)					\
	SETHPAGEFLAG(uname, lname)					\
	CLEARHPAGEFLAG(uname, lname)

HPAGEFLAG(RestoreReserve, restore_reserve)
HPAGEFLAG(Migratable, migratable)

just to mirror page-flags.h more closely.
