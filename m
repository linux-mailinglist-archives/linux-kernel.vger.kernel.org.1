Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33352CA350
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgLANAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgLANAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:00:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A/weu5pnukRhVU7q8jWcuRe0AHdNtgBdrJmzM8pOUaI=; b=cKgT78pHn6uvtONlR4vcFaVwdR
        Hf39+E3MvAJ68bTfkwNKPj3aL1fG7L3wFOviVqulK4jg0FKvT17Uch3XUoFhVRcZZ1eDUU3fPIEic
        2biLL0Vs9O5/F1JK2YF9LSHK8LcTYSIjt69OIqKZiFhAAZA3OUO4eNi0aV0Zb/6Lu1x5Yn4PDj4kG
        aSu5ZMfXdBKD0boQp5dNkB8g0Iz36cmdUjPKC3EbqiN4Sl8V5if5msDtm5J0rGPEk6HDOQE2iVhvm
        OoJoxQaiCsHlnfH/57jilzyS4AWy6xxstVL1WBIpr5UzOOKBO/75/LJN2Qt9ZE496Sr2Z60LaLUfZ
        hiwv88og==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk5Ff-0006aN-P1; Tue, 01 Dec 2020 12:59:27 +0000
Date:   Tue, 1 Dec 2020 12:59:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <20201201125927.GB11935@casper.infradead.org>
References: <20201130230603.46187-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130230603.46187-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:06:03PM -0500, Peter Xu wrote:
> Faulting around for reads are in most cases helpful for the performance so that
> continuous memory accesses may avoid another trip of page fault.  However it
> may not always work as expected.
> 
> For example, userfaultfd registered regions may not be the best candidate for
> pre-faults around the reads.
> 
> For missing mode uffds, fault around does not help because if the page cache
> existed, then the page should be there already.  If the page cache is not
> there, nothing else we can do, either.  If the fault-around code is destined to
> be helpless for userfault-missing vmas, then ideally we can skip it.

This sounds like you're thinking of a file which has exactly one user.
If there are multiple processes mapping the same file, then no, there's
no reason to expect a page to be already present in the page table,
just because it's present in the page cache.

> For wr-protected mode uffds, errornously fault in those pages around could lead
> to threads accessing the pages without uffd server's awareness.  For example,
> when punching holes on uffd-wp registered shmem regions, we'll first try to
> unmap all the pages before evicting the page cache but without locking the
> page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
> before shmem_truncate_range()).  When fault-around happens near a hole being
> punched, we might errornously fault in the "holes" right before it will be
> punched.  Then there's a small window before the page cache was finally
> dropped, and after the page will be writable again (NOTE: the uffd-wp protect
> information is totally lost due to the pre-unmap in shmem_fallocate(), so the
> page can be writable within the small window).  That's severe data loss.

This still doesn't make sense.  If the page is Uptodate in the page
cache, then userspace gets to access it.  If you don't want the page to
be accessible, ClearPageUptodate().  read() can also access it if it's
marked Uptodate.  A write fault on a page will call the filesystem's
page_mkwrite() and you can block it there.

