Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217532F86B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbhAOUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:30:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:50090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733254AbhAOUaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:30:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02CDBB945;
        Fri, 15 Jan 2021 20:29:19 +0000 (UTC)
Date:   Fri, 15 Jan 2021 21:29:15 +0100
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
Message-ID: <20210115202915.GA3322@localhost.localdomain>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-3-mike.kravetz@oracle.com>
 <20210115091755.GB4092@linux>
 <d98039ef-8489-6d8c-a323-44e3f0d8acee@oracle.com>
 <41ca9f90-63e3-f991-3f78-433f77250527@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ca9f90-63e3-f991-3f78-433f77250527@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:05:29PM -0800, Mike Kravetz wrote:
> I went back and took a closer look.  Migration is the reason the existing
> page_huge_active interfaces were introduced.  And, the only use of the
> page_huge_active check is to determine if a page can be migrated.  So,
> I think 'Migratable' may be the most suitable name.

Ok, I did not know that. Let us stick with 'Migratable' then.

> To address the concern about not all hugetlb sizes are migratable, we can
> just make a check before setting the flag.  This should even help in the
> migration/offline paths as we will know sooner if the page can be
> migrated or not.

This sounds like a good idea to me.

> We can address naming in the 'migrating free hugetlb pages' issue when
> that code is written.

Sure, it was just a suggestion as when I though about that something
like 'InUse' or 'Active' made more sense to me, but your point is valid.

Sorry for the confusion.

About that alloc_contig_range topic, I would like to take a look unless
someone is already on it or about to be.

Thanks Mike for the time ;-)


-- 
Oscar Salvador
SUSE L3
