Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EE826E63A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIQUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIQUGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:06:40 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4BEC061355
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:06:40 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j3so1651778qvi.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Q1qejjjhezfyiurKJRhlDxB+DXAgXxFnb9TedTa7L4=;
        b=lcRgZ5GzpJ04pDPiF882GvGQfA2klPwdj72TcNSCwqEw7IIEOzRf1pXGmBCRxdByGn
         ZWILbFyH5h5Ta8bppvRX+L9ZRICb1mWgtPJygZk1EKPsj6r/MAzLelBVl8cLBeYtHyH3
         /3vsvX2OX8dryVJtfjjDzZvTbdEwkpwD59PpIZbA/E6lJO6me1kJwS3tyKHzxBiAIwfJ
         Pe/e2mKvSQH0zN04VtLbscoqrBNtuoKgeObD+sjm+uwH+XFb7qPHR4wQSzhsg6E+ZoYb
         Rlm7sR59h57IQ3F+Hja05Bmrnqm/3RwZyUn2nQRoejUm1fTynhjzSShvJScutXEAm/SJ
         jaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Q1qejjjhezfyiurKJRhlDxB+DXAgXxFnb9TedTa7L4=;
        b=lKDNSR02E/wqBeADx32mZ6QMTtiRv/KJqr1saPNYY4lPZ/Oy2BS92Gkqv6qdxgd3FA
         9F6mEX5BIlirGQ9YS30NwtZR9AOoO9otN6t5NHGOS471SCWqlPpwElqIDQcm+9HmJUWQ
         KxVYiDBZPv8Bwnjc9ncqNTN830rFiRFZuTLC6zDZSPm+Pzl+anlEz76VUfTYOUw9XR/B
         kPHPMABgKssUcJTA4iqX9BDmnpEh1SeztVkSjnIFe/B/Bcc88t4l/oWRDSy0lxUyX1nK
         0faQW5WCG4rElKrkNlenqT3wDhp+cWF84hhtMyvI1FhlrHLMtMtV6AsDNpfB3q/eUEaX
         YaFg==
X-Gm-Message-State: AOAM532Zmhsaol8xnk2VXjkZFMLGsxIwKLhuxfnSEkj8uCdv6bHk1cNG
        lZphW8p9uxCq7U7fq5NYVhKh4g==
X-Google-Smtp-Source: ABdhPJxuZnt5wzjBKuVgR/rcdMf+nNahk7ll2ZTJLpD1Brk0GLK2cYvnAB3V+7hnzlBYIm81lj3K7g==
X-Received: by 2002:a0c:d443:: with SMTP id r3mr30442508qvh.20.1600373199344;
        Thu, 17 Sep 2020 13:06:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w59sm574671qtd.1.2020.09.17.13.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 13:06:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJ0Aw-000lCJ-5W; Thu, 17 Sep 2020 17:06:38 -0300
Date:   Thu, 17 Sep 2020 17:06:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20200917200638.GM8409@ziepe.ca>
References: <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1>
 <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:42:11PM -0700, Linus Torvalds wrote:

> Because the whole "do page pinning without MADV_DONTFORK and then fork
> the area" is I feel a very very invalid load. It sure as hell isn't
> something we should care about performance for, and in fact it is
> something we should very well warn for exactly to let people know
> "this process is doing bad things".

It is easy for things like iouring that can just allocate the queue
memory they care about and MADV_DONTFORK it.

Other things work more like O_DIRECT - the data it is working on is
arbtiary app memory, not controlled in anyway.

In RDMA we have this ugly scheme were we automatically call
MADV_DONTFORK on the virtual address and hope it doesn't explode. It
is very hard to call MADV_DONTFORK if you don't control the
allocation. Don't want to break huge pages, have to hope really really
hard that a fork doesn't need that memory. Hope you don't run out of
vmas beause it causes a vma split. So ugly. So much overhead.

Considering almost anything can do a fork() - we've seen app authors
become confused. They say stuff is busted, support folks ask if they
use fork, author says no.. Investigation later shows some hidden
library did system() or whatever.

In this case the tests that found this failed because they were
written in Python and buried in there was some subprocess.call().

I would prefer the kernel consider it a valid work load with the
semantics the sketch patch shows..

> Is there possibly somethign else we can filter on than just
> GUP_PIN_COUNTING_BIAS? Because it could be as simple as just marking
> the vma itself and saying "this vma has had a page pinning event done
> on it".

We'd have to give up pin_user_pages_fast() to do that as we can't fast
walk and get vmas?

Hmm, there are many users. I remember that the hfi1 folks really
wanted the fast version for some reason..

> Because if we only start copying the page *iff* the vma is marked by
> that "this vma had page pinning" _and_ the page count is bigger than
> GUP_PIN_COUNTING_BIAS, than I think we can rest pretty easily knowing
> that we aren't going to hit some regular old-fashioned UNIX server
> cases with a lot of forks..

Agree

Given that this is a user visible regression, it is nearly rc6, what
do you prefer for next steps? 

Sorting out this for fork, especially if it has the vma change is
probably more than a weeks time.

Revert this patch and try again next cycle?

Thanks,
Jason
