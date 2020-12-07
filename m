Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1632D2D1032
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgLGMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:13:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:49440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgLGMN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:13:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607343189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5aTOOY1yDto3hlZWd7sMkEsRnR8D/QRsIEYRP0S3jQ=;
        b=jBO+lhrGUzRYbOAoxA1UXH9qf/XtMGzeReS9iN55wAuBNvNTaz6+xRKs8VHwziT0y73eTI
        C7aCVZHr9IkrnJhXTGqpPMuyRlCuun0XMA8Gl4MxeXRj5N5uRLg9KPyyPtsv8O0fRya1uS
        kkffOn+VWKJgCazdeXzSJNcwruVo5yo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80B41AC90;
        Mon,  7 Dec 2020 12:13:09 +0000 (UTC)
Date:   Mon, 7 Dec 2020 13:13:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        mike.kravetz@oracle.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] prohibit pinning pages in ZONE_MOVABLE
Message-ID: <20201207121307.GG25569@dhcp22.suse.cz>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201204035953.GA17056@js1304-desktop>
 <CA+CK2bCD7XYyJB9TNZZeUMAuntotZopVYNjDXnyVZyzKe2_A1Q@mail.gmail.com>
 <20201204161005.GD5487@ziepe.ca>
 <CA+CK2bCGGoBXg7FbhGMDdWRnePKFgvtsM_PJmA2qtMNsvPMZbg@mail.gmail.com>
 <20201207071238.GA10731@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207071238.GA10731@js1304-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-12-20 16:12:50, Joonsoo Kim wrote:
> On Fri, Dec 04, 2020 at 12:50:56PM -0500, Pavel Tatashin wrote:
> > > > Yes, this indeed could be a problem for some configurations. I will
> > > > add your comment to the commit log of one of the patches.
> > >
> > > It sounds like there is some inherent tension here, breaking THP's
> > > when doing pin_user_pages() is a really nasty thing to do. DMA
> > > benefits greatly from THP.
> > >
> > > I know nothing about ZONE_MOVABLE, is this auto-setup or an admin
> > > option? If the result of this patch is standard systems can no longer
> > > pin > 80% of their memory I have some regression concerns..
> > 
> > ZONE_MOVABLE can be configured via kernel parameter, or when memory
> > nodes are onlined after hot-add; so this is something that admins
> > configure. ZONE_MOVABLE is designed to gurantee memory hot-plug
> 
> Just note, the origin of ZONE_MOVABLE is to provide availability of
> huge page, especially, hugetlb page. AFAIK, not guarantee memory
> hot-plug. See following commit that introduces the ZONE_MOVABLE.
> 
> 2a1e274 Create the ZONE_MOVABLE zone
> 
> > functionality, and not availability of THP, however, I did not know
> > about the use case where some admins might configure ZONE_MOVABLE to
> 
> The usecase is lightly mentioned in previous discussion.
> 
> http://lkml.kernel.org/r/alpine.DEB.2.23.453.2011221300100.2830030@chino.kir.corp.google.com
> 
> Anyway, I agree with your other arguments and this patchset.

Yes, historically the original motivation for the movable zone was to
help creating large pages via compaction. I also do remember Mel
not being particularly happy about that.

The thing is that the movability constrain is just too strict for this
usecases because the movable zone, especially a lot of it, might be
causing similar to lowmem/highmem problems very well known from 32b
world. So an admin had to be always very careful when configuring to not
cause zone pressure problems.

Later on, with a higher demand on the memory hotplug - especially the
hotremove usecases - it has become clear that the only reliable way for
the memory offlining is to rule out any unmovable memory out of the way
and that is why a rather strong properly of movable zone was relied on.

In the end we are in two rather different requirements here. One for
optimization and one for correctness. In this case I would much rather
focus on the correctness aspect.
-- 
Michal Hocko
SUSE Labs
