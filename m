Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D632F2ECBCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbhAGIhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:37:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:41866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbhAGIhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:37:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610008585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPXwJqHFV5mIl7KuT9+L95Z0SylfNmQvUqCvhhsnffk=;
        b=CB6dPKj89gkuU+9605JT8YaOwvzZzR1DcuyDbdxiGqn2J+ewkXdZelmoaaxGB3wwFM+Sw5
        bGVI3DZFtLPC81RIwGqnu+MpfMMNo9sOYSc2/d10sCWuda5vbtLcRjDFKT7ljPa3XXTYfG
        kyI2WT8lQHd71V9gvHlpOnCxxNMRFSw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5CAFAAD26;
        Thu,  7 Jan 2021 08:36:25 +0000 (UTC)
Date:   Thu, 7 Jan 2021 09:36:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mm: hugetlbfs: fix cannot migrate the fallocated
 HugeTLB page
Message-ID: <20210107083622.GA13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-3-songmuchun@bytedance.com>
 <20210106163513.GS13207@dhcp22.suse.cz>
 <7e69a55c-d501-6b42-8225-a677f09fb829@oracle.com>
 <20210106200242.GY13207@dhcp22.suse.cz>
 <b9dcdeb8-6994-55f9-1780-794e17589129@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9dcdeb8-6994-55f9-1780-794e17589129@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 13:07:40, Mike Kravetz wrote:
> On 1/6/21 12:02 PM, Michal Hocko wrote:
> > On Wed 06-01-21 11:30:25, Mike Kravetz wrote:
> >> On 1/6/21 8:35 AM, Michal Hocko wrote:
> >>> On Wed 06-01-21 16:47:35, Muchun Song wrote:
> >>>> Because we only can isolate a active page via isolate_huge_page()
> >>>> and hugetlbfs_fallocate() forget to mark it as active, we cannot
> >>>> isolate and migrate those pages.
> >>>
> >>> I've little bit hard time to understand this initially and had to dive
> >>> into the code to make sense of it. I would consider the following
> >>> wording easier to grasp. Feel free to reuse if you like.
> >>> "
> >>> If a new hugetlb page is allocated during fallocate it will not be
> >>> marked as active (set_page_huge_active) which will result in a later
> >>> isolate_huge_page failure when the page migration code would like to
> >>> move that page. Such a failure would be unexpected and wrong.
> >>> "
> >>>
> >>> Now to the fix. I believe that this patch shows that the
> >>> set_page_huge_active is just too subtle. Is there any reason why we
> >>> cannot make all freshly allocated huge pages active by default?
> >>
> >> I looked into that yesterday.  The primary issue is in page fault code,
> >> hugetlb_no_page is an example.  If page_huge_active is set, then it can
> >> be isolated for migration.  So, migration could race with the page fault
> >> and the page could be migrated before being added to the page table of
> >> the faulting task.  This was an issue when hugetlb_no_page set_page_huge_active
> >> right after allocating and clearing the huge page.  Commit cb6acd01e2e4
> >> moved the set_page_huge_active after adding the page to the page table
> >> to address this issue.
> > 
> > Thanks for the clarification. I was not aware of this subtlety. The
> > existing comment is not helping much TBH. I am still digesting the
> > suggested race. The page is new and exclusive and not visible via page
> > tables yet, so the only source of the migration would be pfn based
> > (hotplug, poisoning), right?
> 
> That is correct.
> 
> 
> > Btw. s@set_page_huge_active@set_page_huge_migrateable@ would help
> > readability IMHO. With a comment explaining that this _has_ to be called
> > after the page is fully initialized.
> 
> Agree, I will add that as a future enhancement.

Thanks!

-- 
Michal Hocko
SUSE Labs
