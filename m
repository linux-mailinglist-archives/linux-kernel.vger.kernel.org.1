Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA23045A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393356AbhAZRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:46:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:46104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389756AbhAZIST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:18:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EF21AC4F;
        Tue, 26 Jan 2021 08:17:26 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:17:23 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/5] hugetlb: use page.private for hugetlb specific
 page flags
Message-ID: <20210126081716.GA9519@linux>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122195231.324857-2-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 11:52:27AM -0800, Mike Kravetz wrote:
> As hugetlbfs evolved, state information about hugetlb pages was added.
> One 'convenient' way of doing this was to use available fields in tail
> pages.  Over time, it has become difficult to know the meaning or contents
> of fields simply by looking at a small bit of code.  Sometimes, the
> naming is just confusing.  For example: The PagePrivate flag indicates
> a huge page reservation was consumed and needs to be restored if an error
> is encountered and the page is freed before it is instantiated.  The
> page.private field contains the pointer to a subpool if the page is
> associated with one.
> 
> In an effort to make the code more readable, use page.private to contain
> hugetlb specific page flags.  These flags will have test, set and clear
> functions similar to those used for 'normal' page flags.  More importantly,
> an enum of flag values will be created with names that actually reflect
> their purpose.
> 
> In this patch,
> - Create infrastructure for hugetlb specific page flag functions
> - Move subpool pointer to page[1].private to make way for flags
>   Create routines with meaningful names to modify subpool field
> - Use new HPageRestoreReserve flag instead of PagePrivate
> 
> Conversion of other state information will happen in subsequent patches.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
