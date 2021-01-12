Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB202F3352
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbhALOyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:54:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:54204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733044AbhALOyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:54:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610463206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6uCA0bR0UPyfjRf0IGWsHK+lZA/GA9OSf48psytri08=;
        b=t7FHH0CVf//EC3qCB50EVuwV2I9siSGuX/p/JkGWdsSXgJb+YNDZOdN6cipYj0iORT1ztO
        ZS8ykZHKyMukMUquaxLkdZQrEfYYlnHjU+TEB70wL6X53z+Vnly7bmF6kPR/PX6cnB4g+t
        bChXigk/QOBrAIynhNLufOoKleu5ea4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 698A6AC24;
        Tue, 12 Jan 2021 14:53:26 +0000 (UTC)
Date:   Tue, 12 Jan 2021 15:53:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
Message-ID: <20210112145325.GS22493@dhcp22.suse.cz>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com>
 <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com>
 <20210112112709.GO22493@dhcp22.suse.cz>
 <d00da0ca-8a2b-f144-b455-2887fd269ed7@redhat.com>
 <20210112121643.GP22493@dhcp22.suse.cz>
 <20210112142337.GR22493@dhcp22.suse.cz>
 <52ec4899-80df-4cbe-41f1-e0a29e838afa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ec4899-80df-4cbe-41f1-e0a29e838afa@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-01-21 15:41:02, David Hildenbrand wrote:
> On 12.01.21 15:23, Michal Hocko wrote:
> > On Tue 12-01-21 13:16:45, Michal Hocko wrote:
> > [...]
> >> Well, currently pool pages are not migrateable but you are right that
> >> this is likely something that we will need to look into in the future
> >> and this optimization would stand in the way.
> > 
> > After some more thinking I believe I was wrong in my last statement.
> > This optimization shouldn't have any effect on pages on the pool as
> > those stay at reference count 0 and they cannot be isolated either
> > (clear_page_huge_active before it is enqueued).
> > 
> > That being said, the migration code would still have to learn about
> > about this pages but that is out of scope of this discussion.
> > 
> > Sorry about the confusion from my side.
> > 
> 
> At this point I am fairly confused what's working at what's not :D

heh, tell me something about that. Hugetlb is a maze full of land mines.

> I think this will require more thought, on how to teach
> alloc_contig_range() (and eventually in some cases offline_pages()?) to
> do the right thing.

Well, offlining sort of works because it retries both migrates and
dissolves. It can fail with the later due to reservations but that can
be expected. We can still try harder to rellocate/rebalance per numa
pools to keep the reservation but I strongly suspect nobody has noticed
this to be a problem so there we are.

-- 
Michal Hocko
SUSE Labs
