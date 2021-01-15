Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19AE2F74CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbhAOJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:01:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbhAOJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610701182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2L9yzM5LJmwEO/nUBz4NvmNEiJLnioU/dsXzw7Xd5A=;
        b=RuQstlgcLc/7ryGvfHGM4fPRXAq9csg75h1O316+mzGypkN6THz3/AzlA4A6O1dIxvD3QB
        5mkFV5yPRTD5IPkWMniBBfhJn9/cLetGPa004LXE0SbHTAAkXWOF9UMKenWTOdAazz3L7y
        BSnfscAuEwTXZbpViulDt6w6vk1XPUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-MYXvcpmQPYq3qO-QYdWOdw-1; Fri, 15 Jan 2021 03:59:38 -0500
X-MC-Unique: MYXvcpmQPYq3qO-QYdWOdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 980ED1572D;
        Fri, 15 Jan 2021 08:59:35 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 428FA77718;
        Fri, 15 Jan 2021 08:59:24 +0000 (UTC)
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
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
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <20210110004435.26382-1-aarcange@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <bb071419-bf40-c5ed-4b2d-d5eb03031b0a@redhat.com>
Date:   Fri, 15 Jan 2021 09:59:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210110004435.26382-1-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.21 01:44, Andrea Arcangeli wrote:
> Hello Andrew and everyone,
> 
> Once we agree that COW page reuse requires full accuracy, the next
> step is to re-apply 17839856fd588f4ab6b789f482ed3ffd7c403e1f and to
> return going in that direction.


After stumbling over the heated discussion around this, I wanted to
understand the details and the different opinions. I tried to summarize
in my simple words (bear with me) what happened and how I think we can
proceed from here. Maybe that helps.

====

What happened:

1) We simplified handling of faults on write-protected pages (page table
entries): we changed the logic when we can reuse a page ("simply
unprotecting it"), and when we have to copy it instead (COW). The
essence of the simplification is, that we only reuse a page if we are
the only single user of the page, meaning page_count(page) == 1, and the
page is mapped into a single process (page_mapcount(page) == 1);
otherwise we copy it. Simple.

2) The old code was complicated and there are GUP (e.g., RDMA, VFIO)
cases that were broken in various ways in the old code already: most
prominently fork(). As one example, it would have been possible for
mprotect(READ) memory to still get modified by GUP users like RDMA.
Write protection (AFAIU via any mechanism) after GUP pinned a page was
not effective; the page was not copied.

3) Speculative pagecache reference can temporarily bump up the
page_count(page), resulting in false positives. We could see
page_count(page) > 1, although we're the single instance that actually
uses a page. In the simplified code, we might copy a page although not
necessary (I cannot tell how often that actually happens).

4) clear_refs(4) ("measure approximately how much memory a process is
using"), uffd-wp (let's call it "lightweight write-protection, handling
the actual fault in user space"), and mprotect(READ) all write-protect
page table entries to generate faults on next write access. With the
simplified code, we will COW whenever we find the page_count(page) > 1.

The simplification seemed to regress clear_refs and uffdio-wp code
(AFAIU in case of uffd-wp, it results in memory corruption). But looks
like we can mostly fix it by adding more extensive locking.

5) Mechanisms like GUP (AFAIU including Direct I/O) also takes
references on pages, increasing page_count(). With the simplification,
we might now end up copying a page, although there is "somewhat" only a
single user/"process" involved.

One example is RDMA: if we read memory using RDMA and mprotect(READ)
such memory, we might end up copying the underlying page on the next
write: suddenly, RDMA is disconnected and will no longer read what is
getting written. Not to mention, we consume more memory. AFAIU, other
examples include direct I/O (e.g., write() with O_DIRECT).

AFAIU, a more extreme case is probably VFIO: A VM with VFIO (e.g.,
passthrough of a PCI device) can essentially be corrupted by "echo 4 >
/proc/[pid]/clear_refs".

6) While some people think it is okay to break GUP further, as it is
already broken in various other ways, other people think this is
changing something that used to work (AFAIU a user-visible change) with
little benefit.

7) There is no easy way to detect if a page really was pinned: we might
have false positives. Further, there is no way to distinguish if it was
pinned with FOLL_WRITE or not (R vs R/W). To perform reliable tracking
we most probably would need more counters, which we cannot fit into
struct page. (AFAIU, for huge pages it's easier).

However, AFAIU, even being able to detect if (and how) a page was pinned
would not completely help to solve the puzzle.

8) We have a vmsplice security issue that has to be fixed by touching
the code in question. A forked child process can read memory content of
its parent, which was modified by the parent after fork. AFAIU, the fix
will further lock us in into the direction of the code we are heading.

9) The simplification is part of v5.10, which is a LTS release. AFAIU,
that one needs fixing, too.



I see the following possible directions we can head

A) Keep the simplification. Try fixing the fallout. Keep the GUP cases
broken or make mprotect() fail when detecting such a scenario;
AFAIU, both are user-visible changes.

B) Keep the simplification. Try fixing the fallout. Fix GUP cases that
used to work; AFAIU fixing this is the hard/impossible part, and is
undesired by some people..

C) Revert the simplification for now. Go back to the drawing board and
use what we learned to come up with a simplification that (all?  )
people are happy with.

D) Revert the simplification: turns out the code could not get
simplified to this extend. We learned a lot, though.

======

Please let me know in case I messed up anything and/or missed important
points.

-- 
Thanks,

David / dhildenb

