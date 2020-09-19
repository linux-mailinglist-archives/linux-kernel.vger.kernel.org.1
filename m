Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43569270951
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 02:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgISAB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 20:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISABz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 20:01:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2995C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 17:01:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w16so8265408qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 17:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=grh61e+nOrFCVDni5tqyXMzviwSliY01KhrfgkSXH/g=;
        b=K/tqPplscJiO9JdaRDQYdAcQZiRBlfBBZSnkF+OJ7ov1BFloe4+aNIz8SuA8dFnu9K
         Gn1HoGj5kOUIXl5lkOUMFNzjJbCszsQCsE7i/qhQCkZU6+sVwIIRxwmQiDbqoAF8ZdJX
         jDq/AiS/u74AnEYEgY9HAaUW3SFhVqA9DKo8RFNVPoRVSvYhKr7tKBZ+vZx/8C4ev1n2
         f7Y5xIeIqOdi9t6fWl3QU26b3/OJZyuKc2e9JmImJc83WB9Fw7USf29+iyfBnlVnRbT0
         vP5PDbSW76+iPNTsdmFI/9IFGs/r9OV48GXpuhOZO6BRLEObBacGtb7vj8XiB+6i8vWh
         91UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=grh61e+nOrFCVDni5tqyXMzviwSliY01KhrfgkSXH/g=;
        b=HqDd+15SGskzDUK1Rbqx93pAywLs/CXf3tbdCCb+krIisLSojyh+MRy+7KxTdYqI/q
         9kNwng+0zv4Tpg7h1qKjqEsou0tacLVmYyT2EVxXIA5kD9cs1dnYrmsvrtYjEIn4b22k
         HWt3Wm7Z/PY1MscQ37YjbGYL8eT3jQnylcRO2YDlwNTN9+dm+h9StfrX0ET2kblKSBZE
         6pSNwvPzd8BmQoVQfpYaHLuy6bbZK8/zSRkoHFswgQfbfJmjYufvNJFqzmn0iWWkQKSk
         vuhj9QTfSnXoKsDTWHziEGNdaULMsvP5RKsPhazTEApv7m+WRdG8iaKnp0bbQk+AZh2g
         7LiQ==
X-Gm-Message-State: AOAM530udyyF8Q3ANwRyhAQrzI5Giu/8joS61OxfZWKo9KuWSdH6ziJJ
        H/aEOYAs9MF441YinEIUgaZ9utDmj8vJyoFP
X-Google-Smtp-Source: ABdhPJwX6w34zNTedzCe9AJKEvH0HflO8G7+wYL8mJEArpwGyrcQYgqtahLqhb1qhLJ3zUZxettihA==
X-Received: by 2002:a37:d10:: with SMTP id 16mr33664048qkn.402.1600473714742;
        Fri, 18 Sep 2020 17:01:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f189sm3163478qkd.20.2020.09.18.17.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:01:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJQK9-001u0r-5J; Fri, 18 Sep 2020 21:01:53 -0300
Date:   Fri, 18 Sep 2020 21:01:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200919000153.GZ8409@ziepe.ca>
References: <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1>
 <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 02:06:23PM -0700, John Hubbard wrote:
> On 9/18/20 1:40 PM, Peter Xu wrote:
> > On Fri, Sep 18, 2020 at 02:32:40PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Sep 18, 2020 at 12:40:32PM -0400, Peter Xu wrote:
> > > 
> > > > Firstly in the draft patch mm->has_pinned is introduced and it's written to 1
> > > > as long as FOLL_GUP is called once.  It's never reset after set.
> > > 
> > > Worth thinking about also adding FOLL_LONGTERM here, at last as long
> > > as it is not a counter. That further limits the impact.
> > 
> > But theoritically we should also trigger COW here for pages even with PIN &&
> > !LONGTERM, am I right?  Assuming that FOLL_PIN is already a corner case.
> > 
> 
> This note, plus Linus' comment about "I'm a normal process, I've never
> done any special rdma page pinning", has me a little worried. Because
> page_maybe_dma_pinned() is counting both short- and long-term pins,
> actually. And that includes O_DIRECT callers.
> 
> O_DIRECT pins are short-term, and RDMA systems are long-term (and should
> be setting FOLL_LONGTERM). But there's no way right now to discern
> between them, once the initial pin_user_pages*() call is complete. All
> we can do today is to count the number of FOLL_PIN calls, not the number
> of FOLL_PIN | FOLL_LONGTERM calls.

My thinking is to hit this issue you have to already be doing
FOLL_LONGTERM, and if some driver hasn't been properly marked and
regresses, the fix is to mark it.

Remember, this use case requires the pin to extend after a system
call, past another fork() system call, and still have data-coherence.

IMHO that can only happen in the FOLL_LONGTERM case as it inhernetly
means the lifetime of the pin is being controlled by userspace, not by
the kernel. Otherwise userspace could not cause new DMA touches after
fork.

Explaining it like that makes me pretty confident it is the right
thing to do, at least for a single bit.

Yes, if we figure out how to do a counter, then the counter can be
everything, but for now, as a rc regression fix, let us limit the
number of impacted cases. Don't need to worry about the unpin problem
because it is never undone.

Jason
