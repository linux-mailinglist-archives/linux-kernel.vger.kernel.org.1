Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0382F86CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbhAOUis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:38:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:53806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbhAOUiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:38:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1724ADC1;
        Fri, 15 Jan 2021 20:38:05 +0000 (UTC)
Date:   Fri, 15 Jan 2021 21:38:03 +0100
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
Message-ID: <20210115203803.GB3322@localhost.localdomain>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-3-mike.kravetz@oracle.com>
 <20210115091755.GB4092@linux>
 <d98039ef-8489-6d8c-a323-44e3f0d8acee@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d98039ef-8489-6d8c-a323-44e3f0d8acee@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 09:43:36AM -0800, Mike Kravetz wrote:
> > Before the page_huge_active() in scan_movable_pages() we have the
> > if (!PageHuge(page)) check, but could it be that between that check and
> > the page_huge_active(), the page gets dissolved, and so we are checking
> > a wrong page[1]? Am I making sense? 
> 
> Yes, you are making sense.
> 
> The reason I decided to drop the check is because it does not eliminate the
> race.  Even with that check in page_huge_active, the page could be dissolved
> between that check and check of page[1].  There really is no way to eliminate
> the race without holding a reference to the page (or hugetlb_lock).  That
> check in page_huge_active just shortens the race window.

Yeah, you are right, the race already exists.
Anyway, do_migrate_range should take care of making sure what it is
handling, so I think we are good.

-- 
Oscar Salvador
SUSE L3
