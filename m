Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0407526B46B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgIOXXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgIOXWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 19:22:41 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286C1C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:22:41 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q4so4701876ils.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4H2qVK4w547uV3EqUqVyJ9uKvMaqmmH5qAQ7XSG/+SE=;
        b=cT+m4/Sflfb21KpiBS3nTulUK8OLY6yo61bKQZVdoFM6SCxUKhElw2KyKlIXFrchpg
         fM38fIst4G/Olouvu2xJ5zaByp/vzngH0K1TAQEQOKfT+x1+9J499/TFGqjSlfVCT+9B
         8WfUF2eA9JlcI9Cex3U9paNzZ4oJNVENJ2jIpd+kRGh1mvVzdJMcTgVKlgJqJ3WzwaQC
         N+r9LCHtTTxzrVFd1vZ/UWT1ZO8zgj0MABs2LzgjMBzxhnSrRdZEXuoth+x4F+xEDalA
         7K62jfybhHLd9VwXk0dqdv85dP2lXuQ33/PT+FFfsN3tlxwslG0HNidXSDXOZcuO1HvY
         K+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4H2qVK4w547uV3EqUqVyJ9uKvMaqmmH5qAQ7XSG/+SE=;
        b=uWyposumR+BU/pX1cNrJJ+CVNwahOUbY2o/5TOPMFqJYiKDTk8fvuvyzy1NAXefq4K
         J9mEQmfkywGJflX/SEHdUFmsjpAka7Zr2WYQSgy05GyIExYyzEyH8gpBwFeiGGIgOUi2
         fnM5JK2MBngQxZxf+j9nM5AWTMkdCNI3FdgKxU97RkGHNtPxCGlw4hCnQjRFf/9V6kmr
         2T7jN/8XRLM3SjWovjRLBD3iZbHKlTdaaLyWCZinkvUJ4PRfZmiG3mqM3U2bLxsHwGXg
         oS+6cUAKuWKpIsBVTlRbFeWgPM4pVlr2rIz6J0wvEOfOaO9+VnoSGRBNnxaWvEsKPIhr
         n9EA==
X-Gm-Message-State: AOAM532HH5PdVmHfPI79BSgBhgBOTFv7x5Zdw/zRUHEk7k3gSJ9EiqHR
        3d35GCz1Dx8VafiLSQukHXpesw==
X-Google-Smtp-Source: ABdhPJy5sWk6NAbW8AaJioc5f7jA1q5VOQMgOXwcVU+NB3JLXVbl3BCKxo6FPyXMBhrMw296gGWhsQ==
X-Received: by 2002:a92:194b:: with SMTP id e11mr18171975ilm.43.1600212160225;
        Tue, 15 Sep 2020 16:22:40 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id m5sm606593ilc.79.2020.09.15.16.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 16:22:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIKHW-006itc-FP; Tue, 15 Sep 2020 20:22:38 -0300
Date:   Tue, 15 Sep 2020 20:22:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200915232238.GO1221970@ziepe.ca>
References: <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
 <20200915145040.GA2949@xz-x1>
 <20200915160553.GJ1221970@ziepe.ca>
 <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915213330.GE2949@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 05:33:30PM -0400, Peter Xu wrote:

> > RDMA doesn't ever use !WRITE
> > 
> > I'm guessing #5 is the issue, just with a different ordering. If the
> > #3 pin_user_pages() preceeds the #2 fork, don't we get to the same #5?
> 
> Right, but only if without MADV_DONTFORK?

Yes, results are that MADV_DONTFORK resolves the issue for initial
tests. I should know if a bigger test suite passes in a few days.
 
> > > If this is a problem, we may still need the fix patch (maybe not as urgent as
> > > before at least).  But I'd like to double confirm, just in case I miss some
> > > obvious facts above.
> > 
> > I'm worred that the sudden need to have MAD_DONTFORK is going to be a
> > turn into a huge regression. It already blew up our first level of
> > synthetic test cases. I'm worried what we will see when the
> > application suite is run in a few months :\
> 
> For my own preference I'll consider changing kernel behavior if the impact is
> still under control (the performance report of 30%+ boost is also attractive
> after the simplify-cow patch).  The other way is to maintain the old reuse
> logic forever, that'll be another kind of burden.  Seems no easy way on either
> side...

It seems very strange that a physical page exclusively owned by a
process can become copied if pin_user_pages() is active and the
process did fork() at some point. 

Could the new pin_user_pages() logic help here? eg the
GUP_PIN_COUNTING_BIAS stuff?

Could the COW code consider a refcount of GUP_PIN_COUNTING_BIAS + 1 as
being owned by the current mm and not needing COW? The DMA pin would
be 'invisible' for COW purposes?

Perhaps an ideal thing would be to have fork() not set the write
protect on pages that have GUP_PIN_COUNTING_BIAS (ie are under DMA),
instead immediately copy during fork(). Then we don't get into this
situation and also don't need MADV_DONTFORK anymore (yay!!). Feels like
this could be low cost as fork() must already be touching the
refcount?

It looks like RDMA, media, vfio, vdpa, io_uring (!!) and xdp all use
FOLL_LONGTERM and may be at regression risk.

I can't say at this point the scope of the problem with RDMA.
*Technicaly* apps forking without MADV_DONTFORK are against the
defined programming model, but since the old kernel didn't fail
robustly there could be misses. FWIW the failure is catastrophic, the
app just breaks completely.

io_uring seems like something that would have interest to mix with
fork.. I see mentions of MADV_DONTFORK in io_uring documentation,
however it is not documented as a 'if you ever call fork() you have to
use this API'. That seems worrying.

> > > IMHO it worked because the page to do RDMA has mapcount==1, so it was reused
> > > previously just as-is even after the fork without MADV_DONTFORK and after the
> > > child quits.
> > 
> > That would match the results we see.. So this patch changes things so
> > it is not re-used as-is, but replaced with Y?
> 
> Yes. The patch lets "replaced with Y" (cow) happen earlier at step #3.  Then
> with MADV_DONTFORK, reuse should not happen any more.

?? Step #3 is pin_user_pages(), why would that replace with COW?

Thanks,
Jason
