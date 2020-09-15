Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61026A8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgIOPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727206AbgIOOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600181446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IeOuE/eucNmDyKjklVh+oXew31k55u++qjTKn6Ndgk=;
        b=gBYypW99VCLkB9J7hbDUpVSDE0UI2Oh5Kof4At1YoZthkanz02d8iJxrXCkKBgPYSK1dgK
        1fs5PekIPcE/0x8JZ43gKxZr2N+sfG/+658CGz0NgaxrBOqfISwKJ8zMZmTGjG76Tdww0c
        Xxwc8nRTXbM83g3WnNmsP/1WxzMijC0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-_Bi83ftLMHG6lT810vCYQA-1; Tue, 15 Sep 2020 10:50:44 -0400
X-MC-Unique: _Bi83ftLMHG6lT810vCYQA-1
Received: by mail-qv1-f72.google.com with SMTP id h9so2333762qvr.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0IeOuE/eucNmDyKjklVh+oXew31k55u++qjTKn6Ndgk=;
        b=b50a9K8FpuobiOxvMCdsxAdvxnyAbtAGHQc6KBtptqjqpoBHLRMivBSXFd0ILfItx3
         MzbQYd8zjfth12G4UhOGaBbfJmZXh6JAO7QdBkuFvaLYiBg49t8HeECAHxz65xuE51Qq
         Brz+a8rqATy33lo0b+nrvR3Nb9tnwb5KnMJJRDFOkBV3dLMQxrOGVXqpK6H0UdyDl09f
         6kGI0Mxb0BRagPC9rXeZm7xWp4xHWzCiHb91coTfFPP6PUQrdDuCxmjHK11ypAfArJV0
         mFIfSqXun9tL3FT8Ek3pz5asU2TtfK57RK2jLQ/rBUu/fbRV9N5qRw2D3WKIliYs3dw8
         uC+A==
X-Gm-Message-State: AOAM530TxPaacceAlw7KYHouQ1eXRQMj02Y60uw4AexCZ6erW4ln0BsB
        z/1zZWedAmfRM4Ce6MjEiq7lWFgm5XTKgI0bbqQgwhKa7QpgR3UfSMQn3q6/gvyqI5pG5UkA4nt
        kSwET7Qnhem8f+ztlnIigHYim
X-Received: by 2002:a37:a607:: with SMTP id p7mr17981471qke.118.1600181443290;
        Tue, 15 Sep 2020 07:50:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX89VeEcyYah7vIMd6ubVQ5qehawQV+yskQYeFf8uxjnN6Ls8a2jrU0yhVlUOW3iBrQR8l0g==
X-Received: by 2002:a37:a607:: with SMTP id p7mr17981446qke.118.1600181443033;
        Tue, 15 Sep 2020 07:50:43 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id f24sm8179157qka.5.2020.09.15.07.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 07:50:42 -0700 (PDT)
Date:   Tue, 15 Sep 2020 10:50:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20200915145040.GA2949@xz-x1>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1>
 <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com>
 <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914232851.GH1221970@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I prepared another version of the FOLL_PIN enforced cow patch attached, just in
case it would still be anything close to useful (though now I highly doubt it
considering below...).  I took care of !USERFAULTFD as suggested by Leon, and
also the fast gup path.

However...

On Mon, Sep 14, 2020 at 08:28:51PM -0300, Jason Gunthorpe wrote:
> Yes, this stuff does pin_user_pages_fast() and MADV_DONTFORK
> together. It sets FOLL_FORCE and FOLL_WRITE to get an exclusive copy
> of the page and MADV_DONTFORK was needed to ensure that a future fork
> doesn't establish a COW that would break the DMA by moving the
> physical page over to the fork. DMA should stay with the process that
> called pin_user_pages_fast() (Is MADV_DONTFORK still needed with
> recent years work to GUP/etc? It is a pretty terrible ancient thing)

... Now I'm more confused on what has happened.

If we're with FORCE|WRITE, iiuc it should guarantee that the page will trigger
COW during gup even if it is shared, so no problem on the gup side.  Then I'm
quite confused on why the write bit is not set when cow triggered.

E.g., in wp_page_copy(), if I'm not wrong, the write bit is only controlled by
(besides the fix patch, though I believe the rdma test should have nothing to
do with uffd-wp after all so it should be the same anyways):

        entry = maybe_mkwrite(pte_mkdirty(entry), vma);

It means, as long as the rdma region has VM_WRITE set (which I think of no
reason on why it shouldn't...), then it should have the write bit in the COWed
page entry.  If so, the page should be stable and I don't undersdand why
another COW could even trigger and how the code path in the "trial cow" patch
is triggered.

Or, the VMA is without VM_WRITE due to some reason?  Sorry I probably know
nothing about RDMA, more information on that side might help too. E.g., is the
hardware going to walk the software process page table too when doing RDMA (or
is IOMMU page table used, or none)?

Thanks,

-- 
Peter Xu

