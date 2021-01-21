Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700872FF57E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbhAUUJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:09:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:41460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbhAUITD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:19:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA3ACAAAE;
        Thu, 21 Jan 2021 08:18:21 +0000 (UTC)
Date:   Thu, 21 Jan 2021 09:18:16 +0100
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
Message-ID: <20210121081812.GA9553@linux>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-3-mike.kravetz@oracle.com>
 <20210120095905.GA4752@localhost.localdomain>
 <20210120100023.GB4752@localhost.localdomain>
 <0ef72fcf-7fd6-02f6-6fb5-69a2c5bcf7a4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef72fcf-7fd6-02f6-6fb5-69a2c5bcf7a4@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 01:48:05PM -0800, Mike Kravetz wrote:
> >> This comment addresses both this patch and the next one.
> >>
> >> Instead of putting the SetHPageMigratable flag spread over the
> >> allocation paths, would it make more sense to place it in
> >> alloc_huge_page before returning the page?
> >> Then we could opencode SetHPageMigratableIfSupported right there.
> > 
> > and in putback_active_hugepage.
> 
> 
> Hi Oscar,
> 
> In Muchun's series of hugetlb bug fixes, Michal asked the same question.
> 
> https://lore.kernel.org/linux-mm/7e69a55c-d501-6b42-8225-a677f09fb829@oracle.com/
> 
> The 'short answer' is that the this would allow a page to be migrated
> after allocation but before the page fault code adds it to the page
> cache or page tables.  This actually caused bugs in the past.

Oh, I see. I jumped late into that patchset so I missed some early messages.
Thanks for explaining this again.

-- 
Oscar Salvador
SUSE L3
