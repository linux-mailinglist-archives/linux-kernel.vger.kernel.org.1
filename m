Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1201269446
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgINR7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:59:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31075 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgINR7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600106391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M4BeGj8qrSLHzBiuCyEaRzQwXGJLwNAdZKd1NIrOwTs=;
        b=P6Vqdnh13DBdfK4oYubSA9Kbc3n2YtacuYBYYuhVROR5KDWjzDNbc8LnVXQaIgsbW6jEMK
        TSdgphx1p5yw+UpPGPg4OdIWDbiTLZoP1WtJBwqZ2XEjkK6r9BkxBRfaas+jrk9hLLAvwP
        NjErqWNHL0XRsLa1ohj3kf4XL4YfSso=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-xuXjylRdMHOCbfRK8a8jWg-1; Mon, 14 Sep 2020 13:59:49 -0400
X-MC-Unique: xuXjylRdMHOCbfRK8a8jWg-1
Received: by mail-qt1-f197.google.com with SMTP id u6so403152qte.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M4BeGj8qrSLHzBiuCyEaRzQwXGJLwNAdZKd1NIrOwTs=;
        b=fL399FrGSaYRHotH5U2cyvIyw28uzpUY81pkrmGxRH0P849hrQ77vBATOjtFS5M5NI
         nATeKHQAeQ+XmzdvnTRZFoPXp0TC9Z5tgy0zy99Z0dRwi284izAGqpbXWVmQFuDGmZ64
         DNVa+ZBF/1C3a81pv+R7GITvw0zLL+BiW4LALXy+DtLnAK32+JBm/7tKXDJAaizrsT2N
         RrwMxVczG9pbLcW2UTjNg0+xBFehckAfA3J/PGIpzLYmu142CNjiVaf39GtBf4ox8je1
         YsAzDQ3rvMtP3/lKd6huvfOo+9wU7LK9IbNcFQk3mSwNlHrX3THCn/LryfuI+JivBJA5
         KAAQ==
X-Gm-Message-State: AOAM533pP5tkgWO3PLQEMRmFJg97vmSqKtSvci3n9D1Cjz27lesDbkYy
        AXzp6W09A8YUWqCoF0BGfL0C5VJ7Wy9vMuQtiCodmxk1kMLnY7l3rBHW/dJEhDwK5NW2Zqcmq1t
        KrFjEm+ANHUev845Wke758Gwn
X-Received: by 2002:ac8:47d4:: with SMTP id d20mr14107050qtr.199.1600106389131;
        Mon, 14 Sep 2020 10:59:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv44TvLU6fjE8PK/EtRbu1JBfOwZD+ZBNpTMAPsDYtxBlCrRWrenoBvrYnwY0ldJnUxmmvFg==
X-Received: by 2002:ac8:47d4:: with SMTP id d20mr14107035qtr.199.1600106388849;
        Mon, 14 Sep 2020 10:59:48 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id h65sm13867323qtd.58.2020.09.14.10.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 10:59:48 -0700 (PDT)
Date:   Mon, 14 Sep 2020 13:59:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] mm/gup: Remove enfornced COW mechanism
Message-ID: <20200914175946.GC30881@xz-x1>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-4-peterx@redhat.com>
 <20200914142722.GA21906@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914142722.GA21906@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 04:27:24PM +0200, Oleg Nesterov wrote:
> On 08/21, Peter Xu wrote:
> >
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -381,22 +381,13 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
> >  }
> >  
> >  /*
> > - * FOLL_FORCE or a forced COW break can write even to unwritable pte's,
> > - * but only after we've gone through a COW cycle and they are dirty.
> > + * FOLL_FORCE can write to even unwritable pte's, but only
> > + * after we've gone through a COW cycle and they are dirty.
> >   */
> >  static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
> >  {
> > -	return pte_write(pte) || ((flags & FOLL_COW) && pte_dirty(pte));
> > -}
> > -
> > -/*
> > - * A (separate) COW fault might break the page the other way and
> > - * get_user_pages() would return the page from what is now the wrong
> > - * VM. So we need to force a COW break at GUP time even for reads.
> > - */
> > -static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned int flags)
> > -{
> > -	return is_cow_mapping(vma->vm_flags) && (flags & (FOLL_GET | FOLL_PIN));
> > +	return pte_write(pte) ||
> > +		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
> 
> Do we really need to add the FOLL_FORCE check back?
> 
> Afaics, FOLL_COW is only possible if FOLL_FORCE was set.

When I proposed the patch I wanted to add back FOLL_FORCE because the previous
removing of FOLL_FORCE should be related to the enforced COW mechanism where
FOLL_COW can definitely happen without FOLL_FORCE.  So when we want to revert
the enforced COW we definitely need to recover this check too as it was.  I
didn't think deeper than that.

However now I'm a bit confused on why FOLL_COW must be with FOLL_FORCE even
without the enforced COW... Shouldn't FOLL_COW be able to happen even without
FOLL_FORCE (as long as when a page is shared, and the gup is with WRITE
permission)?  Not sure what I've missed, though.

-- 
Peter Xu

