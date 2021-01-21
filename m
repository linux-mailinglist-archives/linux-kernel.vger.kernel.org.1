Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED92FE501
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbhAUI3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:29:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:54702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbhAUI2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:28:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C576AAAE;
        Thu, 21 Jan 2021 08:27:52 +0000 (UTC)
Date:   Thu, 21 Jan 2021 09:27:49 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/5] hugetlb: convert page_huge_active()
 HPageMigratable flag
Message-ID: <20210121082749.GB9553@linux>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120013049.311822-3-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 05:30:46PM -0800, Mike Kravetz wrote:
> Use the new hugetlb page specific flag HPageMigratable to replace the
> page_huge_active interfaces.  By it's name, page_huge_active implied
> that a huge page was on the active list.  However, that is not really
> what code checking the flag wanted to know.  It really wanted to determine
> if the huge page could be migrated.  This happens when the page is actually
> added the page cache and/or task page table.  This is the reasoning behind
> the name change.
> 
> The VM_BUG_ON_PAGE() calls in the *_huge_active() interfaces are not
> really necessary as we KNOW the page is a hugetlb page.  Therefore, they
> are removed.
> 
> The routine page_huge_active checked for PageHeadHuge before testing the
> active bit.  This is unnecessary in the case where we hold a reference or
> lock and know it is a hugetlb head page.  page_huge_active is also called
> without holding a reference or lock (scan_movable_pages), and can race with
> code freeing the page.  The extra check in page_huge_active shortened the
> race window, but did not prevent the race.  Offline code calling
> scan_movable_pages already deals with these races, so removing the check
> is acceptable.  Add comment to racy code.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> -/*
> - * Test to determine whether the hugepage is "active/in-use" (i.e. being linked
> - * to hstate->hugepage_activelist.)
> - *
> - * This function can be called for tail pages, but never returns true for them.
> - */
> -bool page_huge_active(struct page *page)
> -{
> -	return PageHeadHuge(page) && PagePrivate(&page[1]);

This made me think once again.
I wonder if we could ever see a scenario where page[0] is a rightful page while
page[1] is poisoned/unitialized (poison_pages()).
A lot of things would have to happen between the two checks, so I do not see it
possible and as you mentioned earlier, the race is already there.

Just wanted to speak up my mind. 

-- 
Oscar Salvador
SUSE L3
