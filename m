Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21C2F85B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbhAOTsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:48:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbhAOTsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610740028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqTXrqY5WOpLVbfIkQazPRNF8DOg7J3nam2cFtoi1LU=;
        b=cXLUFklEXzNiSYQcZgcq6xjhVpcikBxr2TH/FiNSKpLhOkEqInxiaI54zC8Buuaf/Lqhu3
        gIxLjr6xVS1N1pQtYpdH9ZupKSvIrtsc5Hct1Yxty0hjCJW30YeuKb22Tc+Swv/WKtrQLC
        hsqPWb6qEBwvL4V/El4dc7hrZmxvsgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-lwD9702uPka_VHursUlkEQ-1; Fri, 15 Jan 2021 14:47:06 -0500
X-MC-Unique: lwD9702uPka_VHursUlkEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CF7D18C89E4;
        Fri, 15 Jan 2021 19:47:03 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFDFD60BF3;
        Fri, 15 Jan 2021 19:46:49 +0000 (UTC)
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <bb071419-bf40-c5ed-4b2d-d5eb03031b0a@redhat.com>
 <20210115183721.GG4605@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a21e6fdf-5cac-6fda-242e-7909af96027a@redhat.com>
Date:   Fri, 15 Jan 2021 20:46:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210115183721.GG4605@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 7) There is no easy way to detect if a page really was pinned: we might
>> have false positives. Further, there is no way to distinguish if it was
>> pinned with FOLL_WRITE or not (R vs R/W). To perform reliable tracking
>> we most probably would need more counters, which we cannot fit into
>> struct page. (AFAIU, for huge pages it's easier).
> 
> I think this is the real issue. We can only store so much information,
> so we have to decide which things work and which things are broken. So
> far someone hasn't presented a way to record everything at least..

I do wonder how many (especially long-term) GUP readers/writers we have
to expect, and especially, support for a single base page. Do we have a
rough estimate?

With RDMA, I would assume we only need a single one (e.g., once RDMA
device; I'm pretty sure I'm wrong, sounds too easy).
With VFIO I guess we need one for each VFIO container (~ in the worst
case one for each passthrough device).
With direct I/O, vmsplice and other GUP users ?? No idea.

If we could somehow put a limit on the #GUP we support, and fail further
GUP (e.g., -EAGAIN?) once a limit is reached, we could partition the
refcount into something like (assume max #15 GUP READ and #15 GUP R/W,
which is most probably a horribly bad choice)

[ GUP READ ][ GUP R/W ] [  ordinary ]
31  ...  28 27  ...  24 23   ....   0

But due to saturate handling in "ordinary", we would lose further 2 bits
(AFAIU), leaving us "only" 22 bits for "ordinary". Now, I have no idea
how many bits we actually need in practice.

Maybe we need less for GUP READ, because most users want GUP R/W? No idea.

Just wild ideas. Most probably that has already been discussed, and most
probably people figured that it's impossible :)

-- 
Thanks,

David / dhildenb

