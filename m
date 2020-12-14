Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC992D9A03
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437163AbgLNObb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:31:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:50770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbgLNObW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:31:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607956229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUY6eHvF0hm7t3R1gw9rif3wuaCt6bfVpTqXElvOz3M=;
        b=Y7X6h872zSTm3SEcrwaV2YbCYszx3s2DSHO4VzfOLxaTCQOSakvdkAG9BC16HWzgbuuH0F
        XtyTJxb4nVjHkyBFbSaJsRZEj5jtl69FipuB3oXqfpFeqA2Bs9JE7/hXg+5NVoRbvKb36n
        ogIopudl0LUiMzt6KdQZCjIUOosflE4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEA76AFA7;
        Mon, 14 Dec 2020 14:30:28 +0000 (UTC)
Date:   Mon, 14 Dec 2020 15:30:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201214143027.GH32193@dhcp22.suse.cz>
References: <20201211235005.GE5487@ziepe.ca>
 <2D10D596-3159-483C-81B4-CD187806ED46@redhat.com>
 <20201214133603.GF5487@ziepe.ca>
 <69beec6b-8518-aa47-5a08-fd5f85cf9430@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69beec6b-8518-aa47-5a08-fd5f85cf9430@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-12-20 15:21:21, David Hildenbrand wrote:
> On 14.12.20 14:36, Jason Gunthorpe wrote:
> > On Sat, Dec 12, 2020 at 08:29:11AM +0100, David Hildenbrand wrote:
> > 
> >>> Racing with another GUP in another thread is also not reasonable, so
> >>> failing to isolate can't be a failure
> >>
> >> Having VMs with multiple vfio containers is certainly realistic, and
> >> optimizing in user space to do vfio mappings concurrently doesn‘t
> >> sound too crazy to me. But I haven‘t checked if vfio common code
> >> already handles such concurrency.
> > 
> > There is a lot more out there than vfio.. RDMA already does concurrent
> > pin_user_pages in real apps
> 
> I actually misread your comment. I think we both agree that temporary
> isolation failures must not lead to a failure.

Yes, isolation failures are ephemeral. I believe that the migration
should start distinguishing between these and hard failures.
-- 
Michal Hocko
SUSE Labs
