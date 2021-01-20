Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E402FCE32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbhATKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:18:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:57416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbhATJ7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:59:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E0D5AC97;
        Wed, 20 Jan 2021 09:59:10 +0000 (UTC)
Date:   Wed, 20 Jan 2021 10:59:05 +0100
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
Message-ID: <20210120095905.GA4752@localhost.localdomain>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120013049.311822-3-mike.kravetz@oracle.com>
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

Hi Mike,

This comment addresses both this patch and the next one.

Instead of putting the SetHPageMigratable flag spread over the
allocation paths, would it make more sense to place it in
alloc_huge_page before returning the page?
Then we could opencode SetHPageMigratableIfSupported right there.

I might be missing something and this might not be possible, but if it
is, it would look cleaner and more logical to me.


-- 
Oscar Salvador
SUSE L3
