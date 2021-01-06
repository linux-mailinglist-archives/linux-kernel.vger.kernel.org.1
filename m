Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324492EC466
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhAFUDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:03:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:50830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbhAFUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:03:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609963366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3a7tR4LgdJfkyWZreyLqQVWOCOwyEHlZH8mnUnYD8UA=;
        b=D/9nnc2fF/eBACYFkwK3QCiOazVFoNukSqxqaUHcxBaOUCpnk7H6cUl4B8HhgLcuJQBn6H
        Y6MiIEpjztvIXckPrriG118c6OWc/VuDMHVi3AjXyRfVK/mjE2ms0hfBZvmOnAdYqu7IbQ
        Kl2HfTFhH/MSP/gJ4eV/g384mqOgfsw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2F3BAD19;
        Wed,  6 Jan 2021 20:02:46 +0000 (UTC)
Date:   Wed, 6 Jan 2021 21:02:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mm: hugetlbfs: fix cannot migrate the fallocated
 HugeTLB page
Message-ID: <20210106200242.GY13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-3-songmuchun@bytedance.com>
 <20210106163513.GS13207@dhcp22.suse.cz>
 <7e69a55c-d501-6b42-8225-a677f09fb829@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e69a55c-d501-6b42-8225-a677f09fb829@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 11:30:25, Mike Kravetz wrote:
> On 1/6/21 8:35 AM, Michal Hocko wrote:
> > On Wed 06-01-21 16:47:35, Muchun Song wrote:
> >> Because we only can isolate a active page via isolate_huge_page()
> >> and hugetlbfs_fallocate() forget to mark it as active, we cannot
> >> isolate and migrate those pages.
> > 
> > I've little bit hard time to understand this initially and had to dive
> > into the code to make sense of it. I would consider the following
> > wording easier to grasp. Feel free to reuse if you like.
> > "
> > If a new hugetlb page is allocated during fallocate it will not be
> > marked as active (set_page_huge_active) which will result in a later
> > isolate_huge_page failure when the page migration code would like to
> > move that page. Such a failure would be unexpected and wrong.
> > "
> > 
> > Now to the fix. I believe that this patch shows that the
> > set_page_huge_active is just too subtle. Is there any reason why we
> > cannot make all freshly allocated huge pages active by default?
> 
> I looked into that yesterday.  The primary issue is in page fault code,
> hugetlb_no_page is an example.  If page_huge_active is set, then it can
> be isolated for migration.  So, migration could race with the page fault
> and the page could be migrated before being added to the page table of
> the faulting task.  This was an issue when hugetlb_no_page set_page_huge_active
> right after allocating and clearing the huge page.  Commit cb6acd01e2e4
> moved the set_page_huge_active after adding the page to the page table
> to address this issue.

Thanks for the clarification. I was not aware of this subtlety. The
existing comment is not helping much TBH. I am still digesting the
suggested race. The page is new and exclusive and not visible via page
tables yet, so the only source of the migration would be pfn based
(hotplug, poisoning), right?

Btw. s@set_page_huge_active@set_page_huge_migrateable@ would help
readability IMHO. With a comment explaining that this _has_ to be called
after the page is fully initialized.
-- 
Michal Hocko
SUSE Labs
