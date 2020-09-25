Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8566527930C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgIYVN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgIYVN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:13:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601068406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WHhAL9v3zJJ52AUThnEeMCqgRo1b0NgEd5SnfGp+7Wo=;
        b=LGRP+BqoPJe3Zh+Xe8bhkCzZq/7qzkGGxc8Fp5JUj8Ov/xVUBYvNG15aOnKv1Y+JFnya92
        1gHQWlyPllQPhgFEMXDJvuBHceE7ZZ4BV9UbskM5m+0qBws12ZIPmFdo05nzC2g0MKkLmj
        a6KnVkkfG3XylI6bygJzg2XrYSC2LVo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-DT0Mrz_9PjWllEJRKsFqbg-1; Fri, 25 Sep 2020 17:13:24 -0400
X-MC-Unique: DT0Mrz_9PjWllEJRKsFqbg-1
Received: by mail-qt1-f200.google.com with SMTP id m13so3209790qtu.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WHhAL9v3zJJ52AUThnEeMCqgRo1b0NgEd5SnfGp+7Wo=;
        b=Yu/nupQ54dOMLLzBHLn5Lr3uau6iMxZ3/3dmfzv2FC5hbJIkQfMLFfKdkwVNF/2I3c
         wTXWBWBnPVfECtzKu/Rs9im6z87Qx38uxEClYpysXq0d/w348NAHRtrIABIxkMrfIRrW
         4dhDwEWzmLfrqg3zaFkvPB9cUXPvdLNrr75hJ12o8Rnb+LaV1bNid1WvNWXY5xJtPkAr
         DAhv5U4y+PslaslCsBL5VLffDGPDqJIEVmEKGhobyjKopXiRSVhDJhsPOfzE621SjRcA
         9wnG3zLQtgE0xClpOp34pRTuJPukWWZgpQi6e8i8F5seSH5yy1r/0vuPmuYbSaYaWm8A
         Ou+g==
X-Gm-Message-State: AOAM533Kn8HG6+NLH6uzqvd0eg9KO6sr2CQJlAGST3p1fmRU6slRsEyy
        GeOETkZ8wN7fhU7pziTjclWwPFUoS415+eQ7OFC+H2Z7IbLFYiwrad0VVlnEJkPDbO/Ol1VU0w2
        hvPy7GEo5ZLGvWyLF1k/PAGzC
X-Received: by 2002:a37:314:: with SMTP id 20mr2005158qkd.274.1601068404296;
        Fri, 25 Sep 2020 14:13:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHqVj5aglcCns/5Ku4LvgGYnYT271ptwF9LRzLwzk1xcpHU7WkQOIihfzK4WTIQGToHllv4Q==
X-Received: by 2002:a37:314:: with SMTP id 20mr2005137qkd.274.1601068404044;
        Fri, 25 Sep 2020 14:13:24 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id 76sm2498044qkl.127.2020.09.25.14.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:13:23 -0700 (PDT)
Date:   Fri, 25 Sep 2020 17:13:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200925211321.GC188812@xz-x1>
References: <20200923002735.GN19098@xz-x1>
 <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1>
 <20200924165152.GE9916@ziepe.ca>
 <20200924175531.GH79898@xz-x1>
 <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1>
 <20200924183953.GG9916@ziepe.ca>
 <20200924213010.GL79898@xz-x1>
 <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:56:05PM -0700, Linus Torvalds wrote:
> So I think we can simply add a
> 
>         if (page_mapcount(page) != 1)
>                 return false;
> 
> to page_maybe_dma_pinned(), and that very naturally protects against
> the "is the page count perhaps elevated due to a lot of forking?"

How about the MAP_SHARED case where the page is pinned by some process but also
shared (so mapcount can be >1)?

> And honestly, since this is all getting fairly late in the rc, and it
> took longer than I thought, I think we should do the GFP_ATOMIC
> approach for now - not great, but since it only triggers for this case
> that really should never happen anyway, I think it's probably the best
> thing for 5.9, and we can improve on things later.

Sorry for that.  Maybe I should have moved even faster.

Would the ATOMIC version always work?  I mean, I thought it could fail anytime,
so any fork() can start to fail for the tests too.

PS. I do plan to post a GFP_KERNEL version soon today, no matter for this
release or the next one.

-- 
Peter Xu

