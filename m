Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40992CCB6B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgLCBIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLCBIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:08:51 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ECFC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 17:08:11 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id dm12so214312qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ujXQeS5YHJuwp8X77KQyBVTIqxYGrywvie1/2UIiLw=;
        b=n47Z/lVS8IkfhPvBmVGqKOFdz4FVCTLn1dvgHz9kp+Gkj3E6aBxNjIPFp20KlR1kZl
         zMP5CkJ8446G5WpJQJx2ZMSmKE2DS1yuSuyfO0mUdBYgdUT5g9VcrpLMHQkfu754qbQW
         ntk9CX4/QqPw4fdDGujCG/qgWaVOA64vX3aZXwTGVr5zECFZulRl5zLoT0sADwTr0hFS
         qQk+L+F+wqxNRKT5D9fX0PKzmrpvPNkuWeMH5MoGky167OsHceYdANRqdtEfVHlsuFll
         QUgpBz7HDkrnBkiCckun9TrlpD+iGiMeQDKaZ8nv+YLq03KH6wa0M4GSfsqMgUZ01EiW
         IA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ujXQeS5YHJuwp8X77KQyBVTIqxYGrywvie1/2UIiLw=;
        b=uHD47HUMAGjFtPVwjryDAqAjYVcRcS8uYNnBtpC2Z3gBmrc/V64+SZ9Yd4/FNd3x9R
         WCstoOzGEAkMIg+XDeJArhZjmkrieJ51bROK0scQHBufKDbBg6GVVffpQOIgDtDXd1nZ
         la2irmWtswcfQzlUbbjKcHQe6mzVwiy72alip/F460GDNDm3PWHOnkNHzWeJ5lFthmFx
         YBroYt2dRoGnfO3krl7HEauiFmQkouMritiVPJt+QtOOxIv6x2YSwHJlnrITlsJVjakN
         de1c3fD2xyNCZvGTTn2phKol6incUdaklZ2c5sMq7w/hOC8bx3ewUusWuufP83MiaWV3
         RFqA==
X-Gm-Message-State: AOAM531hSNkQuPB+P+3yBcYULeJRACwzfrOTM+hI1xbs4v9ipAxyZMbP
        qv+qLCJHuZi6Hb/t4EENjxSFjw==
X-Google-Smtp-Source: ABdhPJxxdFVazo1Bis5kAqf6NL1JQXtbPnvdZ2iWy7MFyBP7nrhTkf9GMiTj7Sblf63mVZlCBx9eDQ==
X-Received: by 2002:ad4:4051:: with SMTP id r17mr977961qvp.39.1606957690812;
        Wed, 02 Dec 2020 17:08:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y189sm523255qka.30.2020.12.02.17.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 17:08:10 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkd6P-005HUP-Ch; Wed, 02 Dec 2020 21:08:09 -0400
Date:   Wed, 2 Dec 2020 21:08:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201203010809.GQ5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:19:45PM -0500, Pavel Tatashin wrote:
> > It is a good moment to say, I really dislike how this was implemented
> > in the first place.
> >
> > Scanning the output of gup just to do the is_migrate_movable() test is
> > kind of nonsense and slow. It would be better/faster to handle this
> > directly while gup is scanning the page tables and adding pages to the
> > list.
> 
> Hi Jason,
> 
> I assume you mean to migrate pages as soon as they are followed and
> skip those that are faulted, as we already know that faulted pages are
> allocated from nomovable zone.
> 
> The place would be:
> 
> __get_user_pages()
>       while(more pages)
>           get_gate_page()
>           follow_hugetlb_page()
>           follow_page_mask()
> 
>           if (!page)
>                faultin_page()
> 
>           if (page && !faulted && (gup_flags & FOLL_LONGTERM) )
>                 check_and_migrate this page

Either here or perhaps even lower down the call chain when the page is
captured, similar to how GUP fast would detect it. (how is that done
anyhow?)

> I looked at that function, and I do not think the code will be cleaner
> there, as that function already has a complicated loop.  

That function is complicated for its own reasons.. But complicated is
not the point here..

> The only drawback with the current approach that I see is that
> check_and_migrate_movable_pages() has to check once the faulted
> pages.

Yes

> This is while not optimal is not horrible. 

It is.

> The FOLL_LONGTERM should not happen too frequently, so having one
> extra nr_pages loop should not hurt the performance. 

FOLL_LONGTERM is typically used with very large regions, for instance
we are benchmarking around the 300G level. It takes 10s of seconds for
get_user_pages to operate. There are many inefficiencies in this
path. This extra work of re-scanning the list is part of the cost.

Further, having these special wrappers just for FOLL_LONGTERM has a
spill over complexity on the entire rest of the callchain up to here,
we now have endless wrappers and varieties of function calls that
generally are happening because the longterm path needs to end up in a
different place than other paths.

IMHO this is due to the lack of integration with the primary loop
above

> Also, I checked and most of the users of FOLL_LONGTERM pin only one
> page at a time. Which means the extra loop is only to check a single
> page.

Er, I don't know what you checked but those are not the cases I
see. Two big users are vfio and rdma. Both are pinning huge ranges of
memory in very typical use cases.

> However, those changes can come after this series. The current series
> fixes a bug where hot-remove is not working with making minimal amount
> of changes, so it is easy to backport it to stable kernels.

This is a good point, good enough that you should probably continue as
is

Jason
