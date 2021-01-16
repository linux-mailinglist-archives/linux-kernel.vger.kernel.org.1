Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0942F8D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 13:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbhAPMHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 07:07:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:38852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbhAPMHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 07:07:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13E4AAD2B;
        Sat, 16 Jan 2021 12:06:32 +0000 (UTC)
Date:   Sat, 16 Jan 2021 13:06:28 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] hugetlb: convert page_huge_active() to HP_Migratable
 flag
Message-ID: <20210116120628.GA3024@localhost.localdomain>
References: <20210116003105.182918-1-mike.kravetz@oracle.com>
 <20210116003105.182918-3-mike.kravetz@oracle.com>
 <20210116042416.GA2260413@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116042416.GA2260413@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 04:24:16AM +0000, Matthew Wilcox wrote:
> and name these HPG_restore_reserve and HPG_migratable
> 
> and generate the calls to hugetlb_set_page_flag etc from macros, eg:
> 
> #define TESTHPAGEFLAG(uname, lname)					\
> static __always_inline bool HPage##uname(struct page *page)		\
> { return test_bit(HPG_##lname, &page->private); }
> ...
> #define HPAGEFLAG(uname, lname)						\
> 	TESTHPAGEFLAG(uname, lname)					\
> 	SETHPAGEFLAG(uname, lname)					\
> 	CLEARHPAGEFLAG(uname, lname)
> 
> HPAGEFLAG(RestoreReserve, restore_reserve)
> HPAGEFLAG(Migratable, migratable)
> 
> just to mirror page-flags.h more closely.

That is on me.
I thought that given the low number of flags, we coud get away with:

hugetlb_{set,test,clear}_page_flag(page, flag)

and call it from the code.
But some of the flags need to be set/tested outside hugetlb code, so
it indeed looks nicer and more consistent to follow page-flags.h convention.

Sorry for the noise.

-- 
Oscar Salvador
SUSE L3
