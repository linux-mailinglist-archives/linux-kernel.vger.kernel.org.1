Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90046277B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 23:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIXVaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 17:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXVaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 17:30:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600983016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHZX7ZQSsiuVO3F0KOGNC6cDMHJGjkdiBXGbF9uY1qg=;
        b=QA8iFnBsTpDuqDUBF6x5PhYYn9jxu9KXWbbwUrr+tittjzhlw3fF+/NSh7s1ScB9sX6pZX
        2h+AUw6EBJWX+ho/dg823Un8+uNKxhWo/al1jWoimuSudTK3b+dJdzV/bAtSV5JinEg0GO
        JBIS/UxLjJfs28bCQig1E1qjXIEE4Os=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-wGqAQgnKMDaZpkmAzR5QPQ-1; Thu, 24 Sep 2020 17:30:14 -0400
X-MC-Unique: wGqAQgnKMDaZpkmAzR5QPQ-1
Received: by mail-qv1-f71.google.com with SMTP id w8so355025qvt.18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GHZX7ZQSsiuVO3F0KOGNC6cDMHJGjkdiBXGbF9uY1qg=;
        b=pz+9chyIHjvGETVDb/qhqOYNaxIMbYqzgxqYn94V1zBlpgN9NWKYei0rowo4Jj2BZy
         +aJHD9XKs8qJzUBlzyqjj06D+evxn00/6cj6wr3HeOy5XZj3H6D1eMwAGkDygYUw5iHe
         MYCpGtrK+b1xYNRM+h4SwskHjpBjCTkO+g3o7e1zb9jxDaIWtPBM6DwJCzHtfcZXeYuM
         LBKlwegIEZhEJBsYQPrZ4PyIRYVeHFXrKi7hkNtVlRg8QZQZxU+aojx8fsud5Y9/cbmu
         DtXdcIv5AC2ahcs+i5juhB4ePlQnRA2dqaJSJLYRgu6jYDkAhqYHlCzlcDMVXvCrufFF
         PX7w==
X-Gm-Message-State: AOAM53126X6L1ITogeWYVYEI5j1p4C5ZlgSC0wRUBTsQriq7VaIQ9cgn
        Xw2sjJVCZEyoiq9r3DvQUKfn+EdbQG3Yl+rRCfs8MqUuB0cbAdoW7CzIaxJTbcVAbr+Ot4WdtUD
        eRtS2OhKUYDjx5dfF3rbcwAPP
X-Received: by 2002:a05:620a:546:: with SMTP id o6mr1197904qko.296.1600983013477;
        Thu, 24 Sep 2020 14:30:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGdv9aQEFGeLxroRNPZ6s4EbIA5GgM4mhynzklei3yx+Gk8JqoQYvZjf7XJEiBcK/q3FcaCw==
X-Received: by 2002:a05:620a:546:: with SMTP id o6mr1197874qko.296.1600983013220;
        Thu, 24 Sep 2020 14:30:13 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id c28sm610766qtk.18.2020.09.24.14.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 14:30:12 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:30:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200924213010.GL79898@xz-x1>
References: <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1>
 <20200924165152.GE9916@ziepe.ca>
 <20200924175531.GH79898@xz-x1>
 <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1>
 <20200924183953.GG9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924183953.GG9916@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 03:39:53PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 24, 2020 at 02:34:18PM -0400, Peter Xu wrote:
> 
> > > >        // RDONLY gup
> > > >        pin_user_pages(buf, !WRITE);
> > > >        // pte of buf duplicated on both sides
> > > >        fork();
> > > >        mprotect(buf, WRITE);
> > > >        *buf = 1;
> > > >        // buf page replaced as cow triggered
> > > > 
> > > > Currently when fork() we'll happily share a pinned read-only page with the
> > > > child by copying the pte directly.  
> > > 
> > > Why? This series prevents that, the page will be maybe_dma_pinned, so
> > > fork() will copy it.
> > 
> > With the extra mprotect(!WRITE), I think we'll see a !pte_write() entry.  Then
> > it'll not go into maybe_dma_pinned() at all since cow==false.
> 
> Hum that seems like a problem in this patch, we still need to do the
> DMA pinned logic even if the pte is already write protected.

Yes I agree.  I'll take care of that in the next version too.

-- 
Peter Xu

