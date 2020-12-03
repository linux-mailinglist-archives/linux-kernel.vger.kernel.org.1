Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA42CDBAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbgLCRA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLCRAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:00:25 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3060C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:59:39 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y197so2712133qkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=czCu/+Tdgj/CLWty8jG8WgsaqrGCer09a2DoA0MYkto=;
        b=iI/YbaGZiZ8ezNWZOKHS1I8abWcFF48J8hDgAiBc1iV1xvnRFycyNHx0DmucGWUZkg
         iMbmMGmTJHsdPtbLBbYpJtSTma4kqX8nBM1e6RTU5HKvkkDRRRxMMjxRXlKK9QR5lnkN
         ixMb+RHtG1ARvnFnCvl0SLgmNsC5Xp9R8eFShakOgeSd6KAK74b+GKfMVZF8EUDzqs6B
         m7jFQKoWvQo/M/yUolxPNMuj+DRKHeBF5lfMB+/tzaH8BIIAZO1aoaPadreT2NiW/kSg
         F9ac9Y7Sl2O5PiDS07CC2kNhepqik2Or7e5S7ryXA8yfZFngrJ9ovtmFcwJXt/r0ro2q
         Ipxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=czCu/+Tdgj/CLWty8jG8WgsaqrGCer09a2DoA0MYkto=;
        b=dCXveEerlDhLhM7sHj4/G3OktxXfPgQZO/0gvioL2POKBh+meazb+zFXg3mdtS1R++
         uKQV7XhYNRPdqIl/R5UnjRslIZKAJ5gejNSjO+KdIiI6bO33bzNlZicDEslrpa1SbZP2
         rJ5faM4chyRnxW6MhSkbeczUgPQk2201wUX+nVTMmIDroFmnmAjs8Zyc73jbuqKkvLTw
         nVLwOHG9lMFQDzKr2iIFMxlZY49+vBkGWk8t535HymVOgtH85Toe0Oamr1qH6VNJUb7p
         rpZZKafqMqJXkPKb5HKUJVbZOYLy7QOhEi7PBMXtYd1GdEyw4EaiPSwOAL+Z0X1idjY7
         TyNg==
X-Gm-Message-State: AOAM533RW/G6PPK3KA1Zm78+G4l46em/7MAE6K3w2n1pWcX4lQZCQkeT
        6SY+NoVoE1IqhnZUzdoC91UNlA==
X-Google-Smtp-Source: ABdhPJw8kYBhMi7M0265TZ6ENGwpBqQw4QVMxtcpBHnWeF52m3QaSmOMSpYEDN/V4gxx/ShI0p8CCA==
X-Received: by 2002:a05:620a:624:: with SMTP id 4mr3709568qkv.351.1607014779195;
        Thu, 03 Dec 2020 08:59:39 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n81sm483955qka.76.2020.12.03.08.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:59:38 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkrxB-005YNk-9T; Thu, 03 Dec 2020 12:59:37 -0400
Date:   Thu, 3 Dec 2020 12:59:37 -0400
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
Message-ID: <20201203165937.GU5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca>
 <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca>
 <CA+CK2bA=Ahd4E=ebdJ7uwxPyQ1AEy_hxA+Tx+yAi92JcZsQsfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA=Ahd4E=ebdJ7uwxPyQ1AEy_hxA+Tx+yAi92JcZsQsfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:40:15AM -0500, Pavel Tatashin wrote:
> > Looking at this code some more.. How is it even correct?
> >
> > 1633                            if (!isolate_lru_page(head)) {
> > 1634                                    list_add_tail(&head->lru, &cma_page_list);
> >
> > Here we are only running under the read side of the mmap sem so multiple
> > GUPs can be calling that sequence in parallel. I don't see any
> > obvious exclusion that will prevent corruption of head->lru. The first
> > GUP thread to do isolate_lru_page() will ClearPageLRU() and the second
> > GUP thread will be a NOP for isolate_lru_page().
> >
> > They will both race list_add_tail and other list ops. That is not OK.
> 
> Good question. I studied it, and I do not see how this is OK. Worse,
> this race is also exposable as a syscall instead of via driver: two
> move_pages() run simultaneously. Perhaps in other places?
> 
> move_pages()
>   kernel_move_pages()
>     mmget()
>     do_pages_move()
>       add_page_for_migratio()
>          mmap_read_lock(mm);
>          list_add_tail(&head->lru, pagelist); <- Not protected

When this was CMA only it might have been rarer to trigger, but this
move stuff sounds like it makes it much more broadly, eg on typical
servers with RDMA exposed/etc

Seems like it needs fixing as part of this too :\

Page at a time inside the gup loop could address both concerns, unsure
about batching performance here though..

Jason
