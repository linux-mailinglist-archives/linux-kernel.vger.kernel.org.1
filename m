Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E24277738
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgIXQvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgIXQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:51:54 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 09:51:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id p65so3527651qtd.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2HIyXx3s73LRrQkm+2xnUYOIMGnUAb5vPH458q/eHM0=;
        b=Gq2CkCU/WyZ8U9hNjFyGbyFkvcjO2IImWCtlNVUwFsk4OSpRT2+Ky4ZbxhcCDzjD6B
         oYjO45xmtz0QBGgkzoUXJHwwvYWyJCHHI0ppI7NyH8Y75C1KnRCfOlMBfol31Sx+U2P0
         b4euqbEfeTluR4QA0tF55NF3HBeiudHAz7KH/Qye52L5i8LUQE9QW4Dcho02AmXs4HAJ
         9bL19BsXzDzayge1UqgbS0l8ooJ1QIAM0qYBDK4mxzv3JmQg5bhz2hEXMgiXhCaAhbNi
         YMCUviz/wBdE+prxnw9QtQtC4IUoGSeelRDljLQljzo1CKEQYeADvKz8s3jYvKmdfpF2
         UcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2HIyXx3s73LRrQkm+2xnUYOIMGnUAb5vPH458q/eHM0=;
        b=gmyDSek2WjgxkidwC6DK+ln3NusJunBlqV2OdposL7VwSbefhKJkilwaZmSTIcEKGO
         xhvU6MxGPfHC+Gbw4Y040DXtjT3BP/YCf/ofvUgC/U4VriRTy7BFB8Rsin7iTf+VRx9Z
         HrcW8rixftD/8c1NKqVkWTwGuE8k/yB15LM0TFyiDirh4M0+AbRw1mWQbhC7hKF9mhN9
         P65ZHRNk+omV0KHvhydbSpBzu/PfL/1K5eWTdHBORhT5+oy/+nC3Bif+qwLA08G3MbWg
         p8WUWO9eoX9y5kDWWAeLgafrTPx7hLXbckV7rA8fehuGrxrmW7UXZIJ9ruCWtAGg7lVH
         btcQ==
X-Gm-Message-State: AOAM530ts6/1GJDTOc494I38hzqPIvy04WYTRGMRcqeFJJpbjFnuvqxA
        8pRr/QrRrrZFIyHNoILebsIc/g==
X-Google-Smtp-Source: ABdhPJxCjmf5BK+Jx3OZvHqqLVtzy1xfkcJEWZVBAiNudjZaGbj8d6kJUM9EMXaX9ojj8gbHS+RhuQ==
X-Received: by 2002:ac8:6ec2:: with SMTP id f2mr482171qtv.159.1600966313832;
        Thu, 24 Sep 2020 09:51:53 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c28sm62266qtk.18.2020.09.24.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 09:51:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kLUTI-000NmG-1K; Thu, 24 Sep 2020 13:51:52 -0300
Date:   Thu, 24 Sep 2020 13:51:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200924165152.GE9916@ziepe.ca>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924143517.GD79898@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:35:17AM -0400, Peter Xu wrote:

> If so, I'd hope you won't disagree that I still move the get_page() out of the
> "if (wp)".  Not only it's a shared operation no matter whether "if (wp)" or
> not, but I'm afraid it would confuse future readers on a special ordering on
> the get_page() and the wrprotect(), especially with the comment above.

Sure, you could add a comment before the page_maybe_dma_pinned that it
could be fused with get_page()

> Yes.  It's kind of related here on whether we can still use wrprotect() to
> guard against fast-gup, though.  So my understanding is that we should still at
> least need the other patch [1] that I proposed in the other thread to force
> break-cow for read-only gups (that patch is not only for fast-gup, of course).

Probably, I haven't intensively studied that patch, and it should go
along with edits to some of the callers..

> But I agree that should be another bigger topic.  I hope we don't need to pick
> that patch up someday by another dma report on read-only pinned pages...

In RDMA we found long ago that read only pins don't work well, I think
most other places are likely the same - the problems are easy enough
to hit. Something like your COW break patch on read is really needed
to allow read-only GUP.

> Regarding the solution here, I think we can also cover read-only fast-gup too
> in the future - IIUC what we need to do is to make it pte_protnone() instead of
> pte_wrprotect(), then in the fault handler we should identify this special
> pte_protnone() against numa balancing (change_prot_numa()).  I think it should
> work fine too, iiuc, because I don't think we should migrate a page at all if
> it's pinned for any reason...

With your COW breaking patch the read only fast-gup should break the
COW because of the write protect, just like for the write side. Not
seeing why we need to do something more?

Jason
