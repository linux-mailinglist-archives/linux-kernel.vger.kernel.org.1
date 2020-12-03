Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED22CCEB5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 06:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgLCFhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 00:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgLCFhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 00:37:40 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA249C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 21:36:59 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id b18so736846ots.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 21:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9cw/bjqotF2vwQmETaOHufIj7nZd76v7wUjUpgL4QyE=;
        b=kNzEbJ/RtYRjNF8qQ577G5fUf/dItIJhDicyhOkL6p8Hw/ONcBdmiwFQrDhKoBvEG/
         hpB7FWNfD/8eb1w2wO4oUtthh7jEI9L2ebxQgcPv/ggDBeQxANSL6Tee/YeZOO92ECsg
         8WCV3Z8Pi44W8Qhg5B9MaGGOIbTU5B32PBkW34Nyx12jHOe1uqZal1R6qxGbTVsTK2os
         rSjU1qyUxGmbpUzycKEmPqxa0NZPzBLnPeuFhdNaQjJ9bYyWWfZ02dC7a/SguGu1TErg
         Y0RrNGeYLsUbsaUjyBN7PER/VSTou2gBUEQVBUJDYhb1LsxP5ygBocRVb3qOWwytvxIn
         lOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9cw/bjqotF2vwQmETaOHufIj7nZd76v7wUjUpgL4QyE=;
        b=Rlekwyn3io3Wq0LGEhElkvSMTLTbk8MG748K064Vx+fu7LzvnWyOHLKKvtjVAgTKno
         WJF2aGbIc1E+r1a2+kDyHAs33ptf5W3Nzz7fjtePjYs1TIqr8VYg6jdN7niDU6/9QSry
         ANXWW4wDixBU7dcFjiLNt+OXXyBGucMIbshFjkMuHT8YO0m2tJV3kns6oKljzWjDgAk+
         LQu9Upeq2FRuIsaNzjOfyAOsftCmL/rW7LpAJlgGSwEd2Ng3M8ISVSJpVif0p6JgpN25
         rg44RCUAhVbl1KwklPtHi1dDxKHnbtlWrek4tnjGZAOll8sbAEpLDwstRz2X/7ZIcd73
         1UQA==
X-Gm-Message-State: AOAM533JEBwcMCuB8p+GDfMNHxdkrRWJ07naCbU3UqOfFPMD5JktPKJ3
        JcjJHEdvxbi5jsBGNpNFHCEdgw==
X-Google-Smtp-Source: ABdhPJxkE5M9jbZNtgHUOQe8EXbxGoVtxKmZFcrrGGYHPCcUpVVlB0nDWwo3S98JqAEJL+l1zOeiBg==
X-Received: by 2002:a9d:6d05:: with SMTP id o5mr1008914otp.158.1606973818985;
        Wed, 02 Dec 2020 21:36:58 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i24sm9382ood.0.2020.12.02.21.36.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2020 21:36:58 -0800 (PST)
Date:   Wed, 2 Dec 2020 21:36:45 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
In-Reply-To: <20201202234117.GD108496@xz-x1>
Message-ID: <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
References: <20201130230603.46187-1-peterx@redhat.com> <20201201125927.GB11935@casper.infradead.org> <20201201223033.GG3277@xz-x1> <X8bZk3jTGU8QyJWc@redhat.com> <alpine.LSU.2.11.2012021410260.4989@eggly.anvils> <20201202234117.GD108496@xz-x1>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020, Peter Xu wrote:
> On Wed, Dec 02, 2020 at 02:37:33PM -0800, Hugh Dickins wrote:
> > On Tue, 1 Dec 2020, Andrea Arcangeli wrote:
> > > 
> > > Any suggestions on how to have the per-vaddr per-mm _PAGE_UFFD_WP bit
> > > survive the pte invalidates in a way that remains associated to a
> > > certain vaddr in a single mm (so it can shoot itself in the foot if it
> > > wants, but it can't interfere with all other mm sharing the shmem
> > > file) would be welcome...
> > 
> > I think it has to be a new variety of swap-like non_swap_entry() pte,
> > see include/linux/swapops.h.  Anything else would be more troublesome.
> > 
> > Search for non_swap_entry and for migration_entry, to find places that 
> > might need to learn about this new variety.
> > 
> > IIUC you only need a single value, no need to carve out another whole
> > swp_type: could probably be swp_offset 0 of any swp_type other than 0.
> > 
> > Note that fork's copy_page_range() does not "copy ptes where a page
> > fault will fill them correctly", so would in effect put a pte_none
> > into the child where the parent has this uffd_wp entry.  I don't know
> > anything about uffd versus fork, whether that would pose a problem.
> 
> Thanks for the idea, Hugh!
> 
> I thought about something similar today, but instead of swap entries, I was
> thinking about constantly filling in a pte with a value of "_PAGE_PROTNONE |
> _PAGE_UFFD_WP" when e.g. we'd like to zap a page with shmem+uffd-wp. I feel
> like the fundamental idea is similar - we can somehow keep the pte with uffd-wp
> information even if zapped/swapped-out, so as long as the shmem access will
> fruther trap into the fault handler, then we can operate on that pte and read
> that information out, like recover that pte into a normal pte (with swap/page
> cache, and vma/addr information, we'll be able to) and then we can retry the
> fault.

Yes, I think that should work too: I can't predict which way would cause
less trouble.

We usually tend to keep away from protnone games, because NUMA balancing
use of protnone is already confusing enough.

But those ptes will be pte_present(), so you must provide a pfn, and I
think if you use the zero_pfn, vm_normal_page() will return false on it,
and avoid special casing (and reference counting) it in various places.

Hugh
