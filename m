Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A9D2CF2BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgLDRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgLDRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:07:14 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FA9C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:06:33 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id x25so6072809qkj.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yxAmVc2QQ1kqXeoN6NMvTUxhZg3wMao28Ew3b7+TbUA=;
        b=nLfIL7HT4+HDXrJwtmNfVAGkfNNK5cLKL8KuoszavQzEFPsuSpM4oGnh3lOW/moDFg
         +6DdD70b3VZ1CJlgMfm7jvlSkdxn8DWM4zRT8F3vMIEJ6IGWNmOQFB1F4t4lQjL6SXZ2
         B4WGwfNUJ07BleEZwbikj+/SCmlU0yOUho+6rAm02hZYv6PRZYqSM3c4s5qe4T1kwj61
         dlckspN2FDSiJRO0oIsrjjAQmB5+6hqQUWDD2Pv6a1mI4mkLrlJwQJ1gPfBS3l0gprMc
         AOFaRcTTzu+G+/S0182YIG8QpqDXcKErWjg4QRbr4IF5moIaku97EiWit8BQzdxfLYM0
         pwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yxAmVc2QQ1kqXeoN6NMvTUxhZg3wMao28Ew3b7+TbUA=;
        b=Nr3WBUy24EoZuRDkKyiA0Wmh6kABCOfLeW+N8o//fLu9SUct2EoVrqOTIGIRNTez63
         +fTiQWEFKGiePI7gy/GGJFPVBq4KlezUIOm1IYGTbwYsl2MgZVbmepCLBWBla5+7ACQR
         31oU8OSo7VROGkovZ+QuVjrDN/YVgNMLxsFUFWCuZW0mm6bo7SeKz3AxPGnYflkmCVKY
         07fkEfiCk2jjvM/5PQ5sPu7anhUyMft7MLlRlKuEp69KshFMdX/omcCrPgeaExzbhMr+
         UGnNq4V/zwHTDPl5eJnqa3664o+Hx10Qv7j1tZ6k33vGCUub1xTk3JuME84RhwWVqFM/
         Gvow==
X-Gm-Message-State: AOAM5329kIy1LCRMAfXQVzLGpg6ZVCzVhFI1bWjgCkt9wX+hQ+/iL/6W
        ljSPt5l08B6lcv53JL+B4WcdnA==
X-Google-Smtp-Source: ABdhPJyaQhk9DU4DugWw5rvCGLbK9uolHWpvzkXM71/KtCR4eZfYRDjn/eQYKdM+e93qFBCsxl6hjA==
X-Received: by 2002:a37:ac0a:: with SMTP id e10mr9905009qkm.264.1607101593185;
        Fri, 04 Dec 2020 09:06:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b14sm5022528qtx.36.2020.12.04.09.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:06:31 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1klEXP-005wQZ-4t; Fri, 04 Dec 2020 13:06:31 -0400
Date:   Fri, 4 Dec 2020 13:06:31 -0400
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
Message-ID: <20201204170631.GE5487@ziepe.ca>
References: <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca>
 <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca>
 <CA+CK2bA=Ahd4E=ebdJ7uwxPyQ1AEy_hxA+Tx+yAi92JcZsQsfA@mail.gmail.com>
 <20201203165937.GU5487@ziepe.ca>
 <CA+CK2bBRqK6_ZOkTbz8qe4Gz6T5pwt-KjJQ0+NzYOC1qO1sPMg@mail.gmail.com>
 <CA+CK2bAErUyg26UNKQJwaZ7wsv4+qv4Ws58Vdmv+QZfLDyrkeQ@mail.gmail.com>
 <20201203193607.GV5487@ziepe.ca>
 <CA+CK2bA18wXtETPpz4eeX02oagg1fyW=yNuN4UZVpBW0V4A1CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA18wXtETPpz4eeX02oagg1fyW=yNuN4UZVpBW0V4A1CQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:24:56AM -0500, Pavel Tatashin wrote:
> On Thu, Dec 3, 2020 at 2:36 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Dec 03, 2020 at 02:15:36PM -0500, Pavel Tatashin wrote:
> >
> > > I studied some more, and I think this is not a race:
> > > list_add_tail(&head->lru, &cma_page_list) is called only when
> > > isolate_lru_page(head) succeeds.
> > > isolate_lru_page(head) succeeds only when PageLRU(head) is true.
> > > However, in this function we also clear LRU flag before returning
> > > success.
> > > This means, that if we race with another thread, the other thread
> > > won't get to unprotected list_add_tail(&head->lru, &cma_page_list)
> > > until head is is back on LRU list.
> >
> > Oh interesting, I totally didn't see how that LRU stuff is
> > working. So.. this creates a ridiculously expensive spin lock? Not
> > broken, but yikes :|
> 
> Not really a spin lock, the second thread won't be able to isolate
> this page, and will skip migration of this page.

It looks like the intent is that it will call gup again, then goto
check_again, and once again try to isolate the LRU. ie it loops.

If it gets to a point where all the CMA pages fail to isolate then it
simply exits with success as the cma_page_list will be empty.

Is this a bug? It seems like a bug, the invariant here is to not
return with a CMA page, so why do we have a path that does return with
a CMA page?

Jason
