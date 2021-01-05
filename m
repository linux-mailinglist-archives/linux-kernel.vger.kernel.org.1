Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EED2EB45C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbhAEUlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729238AbhAEUlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609879186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHIi+l3FG0nhdsSSuK7zUGCj1PycEMR6ZGSMpfFshzU=;
        b=Py/ZpJYzSS8D8czPFhNn4IoAUdWqEBFWmFqxLMJ4TyZMjLdAn6V7DCJlBN4i4c5eXlRi/v
        Gj2Wi7hkRWe2HKlZyymGqAWsLkPrGUhxXqgH+b6RS4as0L3tdUClMqsh64Q9v3FEdXNCZM
        M+BrNdBXbBsDRz+I2I9HPivfvAXJXYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-lVsPWadQOce_OP8wMG30Qg-1; Tue, 05 Jan 2021 15:39:44 -0500
X-MC-Unique: lVsPWadQOce_OP8wMG30Qg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 130B0800D62;
        Tue,  5 Jan 2021 20:39:42 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAD8171C9A;
        Tue,  5 Jan 2021 20:39:35 +0000 (UTC)
Date:   Tue, 5 Jan 2021 15:39:35 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] fs/task_mmu: acquire mmap_lock for write on
 soft-dirty cleanup
Message-ID: <X/TOhyzggcBL64N2@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com>
 <X/SuBxFfR+bncRhU@redhat.com>
 <15758743-B8E3-48C4-A13B-DFFEBF8AF435@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15758743-B8E3-48C4-A13B-DFFEBF8AF435@vmware.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:26:43PM +0000, Nadav Amit wrote:
> > On Jan 5, 2021, at 10:20 AM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> > 
> > On Fri, Dec 25, 2020 at 01:25:29AM -0800, Nadav Amit wrote:
> >> Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
> > 
> > Targeting a backport down to 2013 when nothing could wrong in practice
> > with page_mapcount sounds backwards and unnecessarily risky.
> > 
> > In theory it was already broken and in theory
> > 09854ba94c6aad7886996bfbee2530b3d8a7f4f4 is absolutely perfect and the
> > previous code of 2013 is completely wrong, but in practice the code
> > from 2013 worked perfectly until Aug 21 2020.
> 
> Well… If you consider the bug that Will recently fixed [1], then soft-dirty
> was broken (for a different, yet related reason) since 0758cd830494
> ("asm-generic/tlb: avoid potential double flush”).
> 
> This is not to say that I argue that the patch should be backported to 2013,
> just to say that memory corruption bugs can be unnoticed.
> 
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20201210121110.10094-2-will@kernel.org/

Is this a fix or a cleanup?

The above is precisely what I said earlier that tlb_gather had no
reason to stay in clear_refs and it had to use inc_tlb_flush_pending
as mprotect, but it's not a fix? Is it? I suggested it as a pure
cleanup. So again no backport required. The commit says fix this but
it means "clean this up".

Now there are plenty of bugs can go unnoticed for decades, including
dirtycow and the very bug that allowed the fork child to attack the
parent with vmsplice that ultimately motivated the
page_mapcount->page_count in do_wp_page in Aug 2020.

Now let's take another example:
7066f0f933a1fd707bb38781866657769cff7efc which also was found by
source review only and never happened in practice, and unlike dirtycow
and the vmsplice attack on parent was not reproducible even at will
after it was found (even then it wouldn't be reproducible
exploitable). So you can take 7066f0f933a1fd707bb38781866657769cff7efc
as the example of theoretical issue that might still crash the kernel
if unlucky. So before 7066f0f933a1fd707bb38781866657769cff7efc, things
worked by luck but not reliably so.

How are all those above relevant here?

In my view none of the above is relevant.

As I already stated this specific issue, for both uffd-wp and
clear_refs wasn't even a theoretical bug before 2020 Aug, it is not
like 7066f0f933a1fd707bb38781866657769cff7efc, and it's not like
https://patchwork.kernel.org/project/linux-mm/patch/20201210121110.10094-2-will@kernel.org/
which appears a pure cleanup and doesn't need backporting to any
tree.

The uffd-wp clear_refs corruption mathematically could not happen
before Aug 2020, it worked by luck too, but unlike
7066f0f933a1fd707bb38781866657769cff7efc reliably so.

Philosophically I obviously agree the bug originated in 2013, but the
stable trees don't feel research material that would care about such a
intellectual detail.

So setting a Fixes back to 2013 that would go mess with all stable
tree by actively backporting a performance regressions to clear_refs
that can break runtime performance to fix a philosophical issue that
isn't even a theoretical issue, doesn't sound ideal to me.

> To summarize my action items based your (and others) feedback on both
> patches:
> 
> 1. I will break the first patch into two different patches, one with the
> “optimization” for write-unprotect, based on your feedback. It will not
> be backported.
>
> 2. I will try to add a patch to avoid TLB flushes on
> userfaultfd-writeunprotect. It will also not be backported.

I think 1 and 2 above could be in the same patch. Mixing an uffd-wp optimization with the
actual fix the memory corruption wasn't ideal, but doing the same
optimization to both wrprotect and un-wrprotect in the same patch
sounds ideal. The commit explanation would be identical and it can be
de-duplicated this way.

I'd suggest to coordinate with Peter on that, since I wasn't planning
to work on this if somebody else offered to do it.

> 3. Let me know if you want me to use your version of testing
> mm_tlb_flush_pending() and conditionally flushing, wait for new version fro
> you or Peter or to go with taking mmap_lock for write.

Yes, as you suggested, I'm trying to clean it up and send a new
version.

Ultimately my view is there are an huge number of cases where
mmap_write_lock or some other heavy lock that will require
occasionally to block on I/O is beyond impossible not to take. Even
speculative page faults only attack the low hanging anon memory and
there's still MADV_DONTNEED/FREE and other stuff that may have to run
in parallel with UFFDIO_WRITEPROTECT and clear_refs, not just page
faults.

As a reminder: the only case when modifying the vmas is allowed under
mmap_read_lock (I already tried once to make it safer by adding
READ_ONCE/WRITE_ONCE but wasn't merged see
https://www.spinics.net/lists/linux-mm/msg173420.html), is when
updating vm_end/vm_start in growsdown/up, where the vma is extended
down or up in the page fault under only mmap_read_lock.

I'm doing all I can to document and make it more explicit the
complexity we deal with in the code (as well as reducing the gcc
dependency in emitting atomic writes to update vm_end/vm_start, as we
should do in ptes as well in theory). As you may notice in the
feedback from the above submission not all even realized that we're
modifying vmas already under mmap_read_lock. So it'd be great to get
help to merge that READ_ONCE/WRITE_ONCE cleanup that is still valid
and pending for merge but it needs forward porting.

This one, for both soft dirty and uffd_wrprotect, is a walk in the
park to optimize in comparison to the vma modifications.

From my point of view in fact, doing the tlb flush or the wait on the
atomic to be released, does not increase kernel complexity compared to
what we had until now.

I think we already had this complexity before Aug 2020, but we didn't
realize it, and that's why thing then broke in clear_refs in Aug 2020
because of an unrelated change that finally exposed the complexity.

By handling the race so that we stop depending on an undocumented
page_mapcount dependency, we won't be increasing complexity, we'll be
merely documenting the complexity we already had to begin with, so
that it'll be less likely to bite us again in the future if it's
handled explicitly.

Thanks,
Andrea

