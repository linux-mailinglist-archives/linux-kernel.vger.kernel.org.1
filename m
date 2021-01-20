Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB262FCE02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbhATKQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:16:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:52242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbhATJbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:31:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23BB8AAAE;
        Wed, 20 Jan 2021 09:30:22 +0000 (UTC)
Date:   Wed, 20 Jan 2021 10:30:15 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/5] hugetlb: use page.private for hugetlb specific
 page flags
Message-ID: <20210120093015.GA4194@localhost.localdomain>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120013049.311822-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 05:30:45PM -0800, Mike Kravetz wrote:
> + * Macros to create test, set and clear function definitions for
> + * hugetlb specific page flags.
> + */
> +#ifdef CONFIG_HUGETLB_PAGE
> +#define TESTHPAGEFLAG(uname, flname)				\
> +static inline int HPage##uname(struct page *page)		\
> +	{ BUILD_BUG_ON(sizeof_field(struct page, private) *	\
> +			BITS_PER_BYTE < __NR_HPAGEFLAGS);	\
> +	return test_bit(HPG_##flname, &(page->private)); }
> +
> +#define SETHPAGEFLAG(uname, flname)				\
> +static inline void SetHPage##uname(struct page *page)		\
> +	{ set_bit(HPG_##flname, &(page->private)); }
> +
> +#define CLEARHPAGEFLAG(uname, flname)				\
> +static inline void ClearHPage##uname(struct page *page)		\
> +	{ clear_bit(HPG_##flname, &(page->private)); }
> +#else
> +#define TESTHPAGEFLAG(uname, flname)				\
> +static inline int HPage##uname(struct page *page)		\
> +	{ BUILD_BUG_ON(sizeof_field(struct page, private) *	\
> +			BITS_PER_BYTE < __NR_HPAGEFLAGS);	\
> +	return 0 }

You missed a ";" right there.

I might be missing something, but I do not think we need a BUILD_BUG_ON there
when CONFIG_HUGETLB_PAGE is not set?
Actually, would make more sense to move the BUILD_BUG_ON from above to
hugetlb_init?

Other than that, looks good to me, and I think it is a great improvment
towards readability and maintability.

-- 
Oscar Salvador
SUSE L3
