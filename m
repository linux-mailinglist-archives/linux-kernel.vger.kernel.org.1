Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB29C27454A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIVP3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgIVP3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600788576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+znqq/1mdsi7wOUB/8AcbZc8vzFFeZcv/UVcyJu8ZE=;
        b=FUNEOPnf4JQTrEekjAWb57AsaynA2pEZFMFEPyrguwGGhXINADY8wJQrXqr9enc0LHHQMq
        ZHPCsU5L9zeWuiujUmcV92UwtzCglJ3Qpafb7DKa8BDJx9xS0XxrhH2NGi0wxHXG4l0Irk
        8GxZb82pGiNBY7Jeme4n/fw1uxeQno8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-TxlvQt7UOZKor-7F5GvljA-1; Tue, 22 Sep 2020 11:29:35 -0400
X-MC-Unique: TxlvQt7UOZKor-7F5GvljA-1
Received: by mail-qk1-f200.google.com with SMTP id h191so13970544qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+znqq/1mdsi7wOUB/8AcbZc8vzFFeZcv/UVcyJu8ZE=;
        b=TqhzYO+Pn6wJyoYvlwZWyUTOpcyCGEMSsFAbmg3BadVAXlj9y2DqASL2DjZYMD3T18
         u1e8hgo3pxTWyrN95fq8/5Trc6/u31+5ScRcR0YeKrzhWs+JaO+Wq69wlH1/SN1DO0oC
         RPFgnAhYoV36H2qFuqQVx6y8mrhyQxz3A6gvffammQbZSrinlTxUac7HHkqo517ihaPn
         tG7iCPqQLSQWSJzkR3BYOYv7lONsvdu9B8oOCGdMvZ4p8E4oEgDwWptOXhhZBDAAd84E
         PmX/7zrhR/rxhWC5tyZ0PesPEFftL802k67qqRVZU/Ev1smdDS89UG4JvFOT7j1wj40J
         Uvpw==
X-Gm-Message-State: AOAM532xtS0PuxUwshm1HtPMds5BOLG92bMek7b9Y9QO+qAfiIPii5Tu
        x2Wos7EhcHZJetaleT+MfiRMqPxansV3Bo4JfLXSse1RoQ+HzfRPU9HSPjyJmJGjY/byn9VV2KR
        UAQSZcByNMiDBUOQpsKNX+Qj9
X-Received: by 2002:a05:620a:221:: with SMTP id u1mr480388qkm.373.1600788572562;
        Tue, 22 Sep 2020 08:29:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy78sB2fCJXkx7JWis5bFj8k3gO7iGE2Cn/wwM0esofmNDTI3P/csuC3u41DGDIn6gRsT7+gw==
X-Received: by 2002:a05:620a:221:: with SMTP id u1mr480354qkm.373.1600788572230;
        Tue, 22 Sep 2020 08:29:32 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id r24sm12379264qtm.70.2020.09.22.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:29:31 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:29:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
Message-ID: <20200922152929.GE19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-4-peterx@redhat.com>
 <6eb46d4d-8267-4e10-0157-e2ce2be2850d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6eb46d4d-8267-4e10-0157-e2ce2be2850d@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:11:29AM -0700, John Hubbard wrote:
> On 9/21/20 2:17 PM, Peter Xu wrote:
> > There's one special path for copy_one_pte() with swap entries, in which
> > add_swap_count_continuation(GFP_ATOMIC) might fail.  In that case we'll return
> 
> I might be looking at the wrong place, but the existing code seems to call
> add_swap_count_continuation(GFP_KERNEL), not with GFP_ATOMIC?

Ah, I wanted to reference the one in swap_duplicate().

> 
> > the swp_entry_t so that the caller will release the locks and redo the same
> > thing with GFP_KERNEL.
> > 
> > It's confusing when copy_one_pte() must return a swp_entry_t (even if all the
> > ptes are non-swap entries).  More importantly, we face other requirement to
> > extend this "we need to do something else, but without the locks held" case.
> > 
> > Rework the return value into something easier to understand, as defined in enum
> > copy_mm_ret.  We'll pass the swp_entry_t back using the newly introduced union
> 
> I like the documentation here, but it doesn't match what you did in the patch.
> Actually, the documentation had the right idea (enum, rather than #define, for
> COPY_MM_* items). Below...

Yeah actually my very initial version has it as an enum, then I changed it to
macros because I started to want it return negative as errors.  However funnily
in the current version copy_one_pte() won't return an error anymore... So
probably, yes, it should be a good idea to get the enum back.

Also we should be able to drop the negative handling too with copy_ret, though
it should be in the next patch.

> 
> > copy_mm_data parameter.
> > 
> > Another trivial change is to move the reset of the "progress" counter into the
> > retry path, so that we'll reset it for other reasons too.
> > 
> > This should prepare us with adding new return codes, very soon.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/memory.c | 42 +++++++++++++++++++++++++++++-------------
> >   1 file changed, 29 insertions(+), 13 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7525147908c4..1530bb1070f4 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -689,16 +689,24 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> >   }
> >   #endif
> > +#define  COPY_MM_DONE               0
> > +#define  COPY_MM_SWAP_CONT          1
> 
> Those should be enums, so as to get a little type safety and other goodness from
> using non-macro items.
> 
> ...
> > @@ -866,13 +877,18 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >   	pte_unmap_unlock(orig_dst_pte, dst_ptl);
> >   	cond_resched();
> > -	if (entry.val) {
> > -		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0)
> > +	switch (copy_ret) {
> > +	case COPY_MM_SWAP_CONT:
> > +		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
> >   			return -ENOMEM;
> > -		progress = 0;
> 
> Yes. Definitely a little cleaner to reset this above, instead of here.
> 
> > +		break;
> > +	default:
> > +		break;
> 
> I assume this no-op noise is to placate the compiler and/or static checkers. :)

This is (so far) for COPY_MM_DONE.  I normally will cover all cases in a
"switch()" and here "default" is for it.  Even if I covered all the
possibilities, I may still tend to keep one "default" and a WARN_ON_ONCE(1) to
make sure nothing I've missed.  Not sure whether that's the ideal way, though.

Thanks,

-- 
Peter Xu

