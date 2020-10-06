Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FB02847F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgJFHyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:54:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:38224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbgJFHyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:54:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601970873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PtL/QE9wTchzRfp7x1He5ORldnbI5Ri9Nvy/1IWwkW0=;
        b=E+vaR6Uk6ou43BGiPTnRmllcl6ZWccsMtaAPvz5CeW+lucWVz4zFAsHFKL5FUdYTKBV+eY
        ZOlZO/Zw7fu6+f1OUw0WC3v/m/qC1yaAYAem2zkMyumm7lULDZyuVLFdnW1zCNFCmXtL6w
        tNMBqIGJmoA4wKO+F1774VW8T1ZA91U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D0E9ADBB;
        Tue,  6 Oct 2020 07:54:33 +0000 (UTC)
Date:   Tue, 6 Oct 2020 09:54:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC V2] mm/vmstat: Add events for HugeTLB migration
Message-ID: <20201006075432.GA29020@dhcp22.suse.cz>
References: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
 <20201002120422.GE4555@dhcp22.suse.cz>
 <fa6a7ea8-df58-c692-0317-686227de54ca@arm.com>
 <20201005060542.GM4555@dhcp22.suse.cz>
 <308767be-acb3-a170-e64f-3c64a361f26e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308767be-acb3-a170-e64f-3c64a361f26e@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-10-20 08:26:35, Anshuman Khandual wrote:
> 
> 
> On 10/05/2020 11:35 AM, Michal Hocko wrote:
> > On Mon 05-10-20 07:59:12, Anshuman Khandual wrote:
> >>
> >>
> >> On 10/02/2020 05:34 PM, Michal Hocko wrote:
> >>> On Wed 30-09-20 11:30:49, Anshuman Khandual wrote:
> >>>> Add following new vmstat events which will track HugeTLB page migration.
> >>>>
> >>>> 1. HUGETLB_MIGRATION_SUCCESS
> >>>> 2. HUGETLB_MIGRATION_FAILURE
> >>>>
> >>>> It follows the existing semantics to accommodate HugeTLB subpages in total
> >>>> page migration statistics. While here, this updates current trace event
> >>>> 'mm_migrate_pages' to accommodate now available HugeTLB based statistics.
> >>> What is the actual usecase? And how do you deal with the complexity
> >>> introduced by many different hugetlb page sizes. Really, what is the
> >>> point to having such a detailed view on hugetlb migration?
> >>>
> >>
> >> It helps differentiate various page migration events i.e normal, THP and
> >> HugeTLB and gives us more reliable and accurate measurement. Current stats
> >> as per PGMIGRATE_SUCCESS and PGMIGRATE_FAIL are misleading, as they contain
> >> both normal and HugeTLB pages as single entities, which is not accurate.
> > 
> > Yes this is true. But why does it really matter? Do you have a specific
> > example?
> 
> An example which demonstrates that mixing and misrepresentation in these
> stats create some problem ? Well, we could just create one scenario via
> an application with different VMA types and triggering some migrations.
> But the fact remains, that these stats are inaccurate and misleading
> which is very clear and apparent.

This doesn't sound like a proper justification to me.
 
> >> After this change, PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will contain page
> >> migration statistics in terms of normal pages irrespective of whether any
> >> previous migrations until that point involved normal pages, THP or HugeTLB
> >> (any size) pages. At the least, this fixes existing misleading stats with
> >> PGMIGRATE_SUCCESS and PGMIGRATE_FAIL.
> >>
> >> Besides, it helps us understand HugeTLB migrations in more detail. Even
> >> though HugeTLB can be of various sizes on a given platform, these new
> >> stats HUGETLB_MIGRATION_SUCCESS and HUGETLB_MIGRATION_FAILURE give enough
> >> overall insight into HugeTLB migration events.
> > 
> > While true this all is way too vague to add yet another imprecise
> > counter.
> 
> Given that user knows about all HugeTLB mappings it has got, these counters
> are not really vague and could easily be related back.

How can you tell a difference between different hugetlb sizes?

> Moreover this change
> completes the migration stats restructuring which was started with adding
> THP counters. Otherwise it remains incomplete.

Our counters will be always incomplete. Please do realize they are mere
aid rather than a comprihensive toolset to identify the system behavior
to the very detail. We have way too many counters and this particular
ones are not adding much IMHO. At least not from your description which
sounds to me like "Yeah, why not do that although there is no strong
reason, well except that THP already has it so let's do it for hugetlb
as well". I really do not want to deal with yet another report in few
years that somebody wants to distinguish hugetlb migration of different
sizes.

Really, is there any _real_ practical use for these other than "nice,
let's just have it"?
-- 
Michal Hocko
SUSE Labs
