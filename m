Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5186E2F4C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbhAMNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:55:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:57736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbhAMNz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:55:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9664DAC24;
        Wed, 13 Jan 2021 13:54:46 +0000 (UTC)
Date:   Wed, 13 Jan 2021 14:54:44 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] hugetlb: use page.private for hugetlb specific
 page flags
Message-ID: <20210113135439.GA29271@linux>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111210152.118394-2-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 01:01:50PM -0800, Mike Kravetz wrote:
> As hugetlbfs evolved, state information about hugetlb pages was added.
> One 'convenient' way of doing this was to use available fields in tail
> pages.  Over time, it has become difficult to know the meaning or contents
> of fields simply be looking at a small bit of code.  Sometimes, the
> naming is just confusing.  For example: The PagePrivate flag indicates
> a huge page reservation was consumed and needs to be restored if an error
> is encountered and the page is freed before it is instantiated.  The
> page.private field contains the pointer to a subpool if the page is
> associated with one.
> 
> In an effort to make the code more readable, use page.private to contain
> hugetlb specific flags.  These flags will have test, set and clear functions
> similar to those used for 'normal' page flags.  More importantly, the
> flags will have names which actually reflect their purpose.
> 
> In this patch,
> - Create infrastructure for huge page flag functions
> - Move subpool pointer to page[1].private to make way for flags
>   Create routines with meaningful names to modify subpool field
> - Use new HPageRestoreReserve reserve flag instead of PagePrivate
> 
> Conversion of other state information will happen in subsequent patches.

I like this idea, it would make the code much easier to follow, and together
with Muchun's gathering indiscrete index hugetlb code will start looking less
scarier.

I do have a question below:

> +enum htlb_page_flags {
> +	HPAGE_RestoreReserve = 0,
> +};
> +
> +/*
> + * Macros to create function definitions for hpage flags
> + */
> +#define TESTHPAGEFLAG(flname)					\
> +static inline int HPage##flname(struct page *page)		\
> +	{ return test_bit(HPAGE_##flname, &(page->private)); }
> +
> +#define SETHPAGEFLAG(flname)					\
> +static inline void SetHPage##flname(struct page *page)		\
> +	{ set_bit(HPAGE_##flname, &(page->private)); }
> +
> +#define CLEARHPAGEFLAG(flname)					\
> +static inline void ClearHPage##flname(struct page *page)	\
> +	{ clear_bit(HPAGE_##flname, &(page->private)); }
> +
> +#define HPAGEFLAG(flname)					\
> +	TESTHPAGEFLAG(flname)					\
> +	SETHPAGEFLAG(flname)					\
> +	CLEARHPAGEFLAG(flname)
> +
> +HPAGEFLAG(RestoreReserve)

I have mixed feelings about this.
Could we have a single function that sets/clears the bit/flag?
e.g:

 static inline void hugetlb_set_flag(struct page *p, page_flag)
 {
         set_bit(flag, &(page->private));
 }

etc.
It would look less of an overkill?
 
-- 
Oscar Salvador
SUSE L3
