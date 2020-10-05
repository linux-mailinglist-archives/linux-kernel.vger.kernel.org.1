Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44D283046
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 08:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgJEGFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 02:05:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgJEGFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 02:05:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601877943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8PfrCBAkG4RHSNenftpNrKV45oZN++KpOv1lY8RxhI=;
        b=AMSlD23DVkzj83p2mRqdOShIUP2CnlG0OuXztm6X6sOhuignShWgnHp41MVLkRkUNA9JTi
        VFqh6BwQajMt+oH4+OV8IieUgyR6MWsaNrrdfS/nt4rKTqKZBN10RHMvPiYwr203frAZZA
        2PALxEKSSGVm4wtsL15KHaot2kfgOqY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15145ABD1;
        Mon,  5 Oct 2020 06:05:43 +0000 (UTC)
Date:   Mon, 5 Oct 2020 08:05:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC V2] mm/vmstat: Add events for HugeTLB migration
Message-ID: <20201005060542.GM4555@dhcp22.suse.cz>
References: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
 <20201002120422.GE4555@dhcp22.suse.cz>
 <fa6a7ea8-df58-c692-0317-686227de54ca@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6a7ea8-df58-c692-0317-686227de54ca@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-10-20 07:59:12, Anshuman Khandual wrote:
> 
> 
> On 10/02/2020 05:34 PM, Michal Hocko wrote:
> > On Wed 30-09-20 11:30:49, Anshuman Khandual wrote:
> >> Add following new vmstat events which will track HugeTLB page migration.
> >>
> >> 1. HUGETLB_MIGRATION_SUCCESS
> >> 2. HUGETLB_MIGRATION_FAILURE
> >>
> >> It follows the existing semantics to accommodate HugeTLB subpages in total
> >> page migration statistics. While here, this updates current trace event
> >> 'mm_migrate_pages' to accommodate now available HugeTLB based statistics.
> > What is the actual usecase? And how do you deal with the complexity
> > introduced by many different hugetlb page sizes. Really, what is the
> > point to having such a detailed view on hugetlb migration?
> >
> 
> It helps differentiate various page migration events i.e normal, THP and
> HugeTLB and gives us more reliable and accurate measurement. Current stats
> as per PGMIGRATE_SUCCESS and PGMIGRATE_FAIL are misleading, as they contain
> both normal and HugeTLB pages as single entities, which is not accurate.

Yes this is true. But why does it really matter? Do you have a specific
example?

> After this change, PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will contain page
> migration statistics in terms of normal pages irrespective of whether any
> previous migrations until that point involved normal pages, THP or HugeTLB
> (any size) pages. At the least, this fixes existing misleading stats with
> PGMIGRATE_SUCCESS and PGMIGRATE_FAIL.
> 
> Besides, it helps us understand HugeTLB migrations in more detail. Even
> though HugeTLB can be of various sizes on a given platform, these new
> stats HUGETLB_MIGRATION_SUCCESS and HUGETLB_MIGRATION_FAILURE give enough
> overall insight into HugeTLB migration events.

While true this all is way too vague to add yet another imprecise
counter.

-- 
Michal Hocko
SUSE Labs
