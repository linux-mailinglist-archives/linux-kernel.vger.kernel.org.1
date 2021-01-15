Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0527D2F7514
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbhAOJSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:18:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:52238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAOJSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:18:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C0CAAA6F;
        Fri, 15 Jan 2021 09:17:59 +0000 (UTC)
Date:   Fri, 15 Jan 2021 10:17:56 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/3] hugetlb: convert page_huge_active() to
 HPageMigratable flag
Message-ID: <20210115091755.GB4092@linux>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111210152.118394-3-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 01:01:51PM -0800, Mike Kravetz wrote:
> Use the new hugetlb page specific flag to replace the page_huge_active
> interfaces.  By it's name, page_huge_active implied that a huge page
> was on the active list.  However, that is not really what code checking
> the flag wanted to know.  It really wanted to determine if the huge
> page could be migrated.  This happens when the page is actually added
> the page cache and/or task page table.  This is the reasoning behind the
> name change.
> 
> The VM_BUG_ON_PAGE() calls in the interfaces were not really necessary
> as in all case but one we KNOW the page is a hugetlb page.  Therefore,
> they are removed.  In one call to HPageMigratable() is it possible for
> the page to not be a hugetlb page due to a race.  However, the code
> making the call (scan_movable_pages) is inherently racy, and page state
> will be validated later in the migration process.
> 
> Note:  Since HPageMigratable is used outside hugetlb.c, it can not be
> static.  Therefore, a new set of hugetlb page flag macros is added for
> non-static flag functions.

Two things about this one:

I am not sure about the name of this one.
It is true that page_huge_active() was only called by memory-hotplug and all
it wanted to know was whether the page was in-use and so if it made sense
to migrate it, so I see some value in the new PageMigratable flag.

However, not all in-use hugetlb can be migrated, e.g: we might have constraints
when it comes to migrate certain sizes of hugetlb, right?
So setting HPageMigratable to all active hugetlb pages might be a bit misleading?
HPageActive maybe? (Sorry, don't have a replacement)

The other thing is that you are right that scan_movable_pages is racy, but
page_huge_active() was checking if the page had the Head flag set before
retrieving page[1].

Before the page_huge_active() in scan_movable_pages() we have the
if (!PageHuge(page)) check, but could it be that between that check and
the page_huge_active(), the page gets dissolved, and so we are checking
a wrong page[1]? Am I making sense? 


-- 
Oscar Salvador
SUSE L3
