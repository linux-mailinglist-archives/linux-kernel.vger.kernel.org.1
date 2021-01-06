Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087CD2EB6A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbhAFAEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:04:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727618AbhAFAEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:04:06 -0500
X-Greylist: delayed 10563 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 19:04:05 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609891360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OZHaphMQfCY5JmI7daFe9jX4tJF9k61pGXu9/0Ggk+4=;
        b=EGo0RzTgvAlPgiKlPk7Cswh9pDEeXaj9ggTr96jYzjiZUCyCHMbFuVekZ8QZAI2tg0NsxS
        5xXqvs0lq9mVDI4rQzCOnl55X6ZgE0JS9nu/awvCr30Pf6K5Ix9DQjYDR9r5IfzNi0Jz4B
        Ixmf94xQm4fKJDpyZIZ8fRs5ZLVqMIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-pyh1spLwMFmdFRT2HH3AwA-1; Tue, 05 Jan 2021 19:02:36 -0500
X-MC-Unique: pyh1spLwMFmdFRT2HH3AwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8D30800D55;
        Wed,  6 Jan 2021 00:02:34 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F2FA7092E;
        Wed,  6 Jan 2021 00:02:31 +0000 (UTC)
Date:   Tue, 5 Jan 2021 19:02:30 -0500
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
Message-ID: <X/T+FoCr/DoieapR@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com>
 <X/SuBxFfR+bncRhU@redhat.com>
 <15758743-B8E3-48C4-A13B-DFFEBF8AF435@vmware.com>
 <X/TOhyzggcBL64N2@redhat.com>
 <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 09:22:51PM +0000, Nadav Amit wrote:
> It is also about performance due to unwarranted TLB flushes.

If there will be a problem switching to the wait_flush_pending() model
suggested by Peter may not even require changes to the common code in
memory.c since I'm thinking it may not even need to take a failure
path if we plug it in the same place of the tlb flush.

So instead of the flush we could always block there until we read zero
in the atomic, then smp_rmb() and we're ready to start the copy.

So either we flush IPI if we didn't read zero, or we block until we
read zero, the difference is going to be hidden to do_wp_page. All
do_wp_page cares about is that by the time the abstract call returns,
there's no stale TLB left for such pte. If it is achieved by blocking
and waiting or flushing the TLB it doesn't matter too much.

So thinking of how bad the IPI will do, with the improved arm64 tlb
flushing code in production, we keep track of how many simultaneous mm
context there are, specifically to skip the SMP-unscalable TLBI
broadcast on arm64 like we already avoid IPIs on lazy tlbs on x86 (see
x86 tlb_is_not_lazy in native_flush_tlb_others). In other words the
IPI will materialize only if there's more than one thread running
while clear_refs run. All lazy tlbs won't get IPIs on both x86
upstream and arm64 enterprise.

This won't help multithreaded processes that compute from all CPUs at
all times but even multiple vcpu threads aren't always guaranteed to
be running at all times.

My main concern would be an IPI flood that slowdown clear_refs and
UFFDIO_WRITEPROTECT, but an incremental optimization (not required for
correctness) is to have UFFDIO_WRITEPROTECT and clear_refs switch to
lazy tlb mode before they call inc_tlb_flush_pending() and unlazy only
after dec_tlb_flush_pending. So it's possible to at least guarantee
the IPI won't slow down them down.

> In addition, as I stated before, having some clean interfaces that tell
> whether a TLB flush is needed or not would be helpful and simpler to follow.
> For instance, we can have is_pte_prot_demotion(oldprot, newprot) to figure
> out whether a TLB flush is needed in change_pte_range() and avoid
> unnecessary flushes when unprotecting pages with either mprotect() or
> userfaultfd.

When you mentioned this earlier I was thinking what happens then with
flush_tlb_fix_spurious_fault(). The fact it's safe doesn't guarantee
it's a performance win if there's a stream of spurious faults as
result. So it'd need to be checked, especially as in the case of
mprotect where the flush can be deferred and coalesced in a single IPI
at the end so there's not so much to gain from it anyway.

If you can guarantee there won't be a flood suprious wrprotect faults,
then it'll be a nice optimization.

Thanks,
Andrea

