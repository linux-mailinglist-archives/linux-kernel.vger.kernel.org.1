Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B322EB4CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbhAEVV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbhAEVV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:21:27 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433BEC061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:20:47 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q5so1053676ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u+ZT4HxbDxfxUGC5c/Q91A3nU2OM/lFz9H4kD6bvZuM=;
        b=vhXNTinADSl1u981fwoGMHTYdCc5RZP3bzWs1lUklnHsIG7YTctJnN0X41ouu/Bu0q
         9OmJNE+DdOOYoDOd482v7/mTYTFuNUExrEtCaNmRiKU09i+KdZqHj43BnXfCRv3i7BlE
         vPkhehPuexMZjDA3akjvnLpPw91m8WKMm4CsDcUdKHkTAV1fTwBn2sFuDreQuqhyr5yE
         pFUuQu7mqr5fcy0myZssrgnwMdjreoKp+EemdyalXp7h/vYXdHXmLX+dHP3gdpuCGaoF
         oznVjWz9AjBMyHYM8fowZk4S0Ba9U1K9qeimzD2xSwJBLy49hc8kvDdU8w++KsSzV7u6
         vq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u+ZT4HxbDxfxUGC5c/Q91A3nU2OM/lFz9H4kD6bvZuM=;
        b=BfHoolOiGawASmprFeuNCsb7o3cZRi33X1aQAMdsQuc+Lmcua7DuR43AR9/yezr12j
         aOn0QSpduys07v1sfBxSFdrQTqqIqnaIPy3H/B5W/E7jPOWTtzqXkUzefeNLKPVlSW2B
         NKcIzibFLHmOj9P9BKmHN4+6QyRkd6jwqlUuzO+7buGtuJlLiZPseSp1JQNL+U46xOYl
         P4APIlRGiK7sC1YXQ7h4eF2W6Pn8lIQyie46s3Vgo+Un+I1gryzcsniH6rHx8j3bmRog
         RRcyvvQGTmOjnTd6aiNdcDNQZpr6lpkKw/gzzLK5h1OjlIy8YQuPJmGwCx2BDTu3s5+d
         +gjg==
X-Gm-Message-State: AOAM531Sqa+no8XXCKWL6bZusZVdFpkPmDXcHg9w3ihtwk+eTqN0RSuQ
        gcCUGOrrFND6iU+Cvoy8Q8EgyA==
X-Google-Smtp-Source: ABdhPJzvtx6pQMhELCMxqlagYJSUbMneZ5J0QfIdMYok+a5PclWUB6NtnF+5BGDwPmjBu7NOjkLRkQ==
X-Received: by 2002:a92:60b:: with SMTP id x11mr510925ilg.11.1609881646425;
        Tue, 05 Jan 2021 13:20:46 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id a10sm181329ioc.43.2021.01.05.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 13:20:45 -0800 (PST)
Date:   Tue, 5 Jan 2021 14:20:41 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <namit@vmware.com>
Cc:     linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] fs/task_mmu: acquire mmap_lock for write on
 soft-dirty cleanup
Message-ID: <X/TYKbzWblUk97oq@google.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com>
 <X/SuBxFfR+bncRhU@redhat.com>
 <15758743-B8E3-48C4-A13B-DFFEBF8AF435@vmware.com>
 <X/TOhyzggcBL64N2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/TOhyzggcBL64N2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 03:39:35PM -0500, Andrea Arcangeli wrote:
> On Tue, Jan 05, 2021 at 07:26:43PM +0000, Nadav Amit wrote:
> > > On Jan 5, 2021, at 10:20 AM, Andrea Arcangeli <aarcange@redhat.com> wrote:
> > > 
> > > On Fri, Dec 25, 2020 at 01:25:29AM -0800, Nadav Amit wrote:
> > >> Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
> > > 
> > > Targeting a backport down to 2013 when nothing could wrong in practice
> > > with page_mapcount sounds backwards and unnecessarily risky.
> > > 
> > > In theory it was already broken and in theory
> > > 09854ba94c6aad7886996bfbee2530b3d8a7f4f4 is absolutely perfect and the
> > > previous code of 2013 is completely wrong, but in practice the code
> > > from 2013 worked perfectly until Aug 21 2020.
> > 
> > Well… If you consider the bug that Will recently fixed [1], then soft-dirty
> > was broken (for a different, yet related reason) since 0758cd830494
> > ("asm-generic/tlb: avoid potential double flush”).
> > 
> > This is not to say that I argue that the patch should be backported to 2013,
> > just to say that memory corruption bugs can be unnoticed.
> > 
> > [1] https://patchwork.kernel.org/project/linux-mm/patch/20201210121110.10094-2-will@kernel.org/
> 
> Is this a fix or a cleanup?
> 
> The above is precisely what I said earlier that tlb_gather had no
> reason to stay in clear_refs and it had to use inc_tlb_flush_pending
> as mprotect, but it's not a fix? Is it? I suggested it as a pure
> cleanup. So again no backport required. The commit says fix this but
> it means "clean this up".
> 
> Now there are plenty of bugs can go unnoticed for decades, including
> dirtycow and the very bug that allowed the fork child to attack the
> parent with vmsplice that ultimately motivated the
> page_mapcount->page_count in do_wp_page in Aug 2020.
> 
> Now let's take another example:
> 7066f0f933a1fd707bb38781866657769cff7efc which also was found by
> source review only and never happened in practice, and unlike dirtycow
> and the vmsplice attack on parent was not reproducible even at will
> after it was found (even then it wouldn't be reproducible
> exploitable). So you can take 7066f0f933a1fd707bb38781866657769cff7efc
> as the example of theoretical issue that might still crash the kernel
> if unlucky. So before 7066f0f933a1fd707bb38781866657769cff7efc, things
> worked by luck but not reliably so.
> 
> How are all those above relevant here?
> 
> In my view none of the above is relevant.
> 
> As I already stated this specific issue, for both uffd-wp and
> clear_refs wasn't even a theoretical bug before 2020 Aug, it is not
> like 7066f0f933a1fd707bb38781866657769cff7efc, and it's not like
> https://patchwork.kernel.org/project/linux-mm/patch/20201210121110.10094-2-will@kernel.org/
> which appears a pure cleanup and doesn't need backporting to any
> tree.
> 
> The uffd-wp clear_refs corruption mathematically could not happen
> before Aug 2020, it worked by luck too, but unlike
> 7066f0f933a1fd707bb38781866657769cff7efc reliably so.
> 
> Philosophically I obviously agree the bug originated in 2013, but the
> stable trees don't feel research material that would care about such a
> intellectual detail.
> 
> So setting a Fixes back to 2013 that would go mess with all stable
> tree by actively backporting a performance regressions to clear_refs
> that can break runtime performance to fix a philosophical issue that
> isn't even a theoretical issue, doesn't sound ideal to me.
> 
> > To summarize my action items based your (and others) feedback on both
> > patches:
> > 
> > 1. I will break the first patch into two different patches, one with the
> > “optimization” for write-unprotect, based on your feedback. It will not
> > be backported.
> >
> > 2. I will try to add a patch to avoid TLB flushes on
> > userfaultfd-writeunprotect. It will also not be backported.
> 
> I think 1 and 2 above could be in the same patch. Mixing an uffd-wp optimization with the
> actual fix the memory corruption wasn't ideal, but doing the same
> optimization to both wrprotect and un-wrprotect in the same patch
> sounds ideal. The commit explanation would be identical and it can be
> de-duplicated this way.
> 
> I'd suggest to coordinate with Peter on that, since I wasn't planning
> to work on this if somebody else offered to do it.

I probably could post something based on the local flush idea we
discussed, but it won't be in this month. It seems to me there is
much has to be done, e.g., auditing all clearing of the writable &
the dirty bits, document the exactly steps when clearing them to
prevent similar problems in the future. I'd be happy to review
your patches too if you could have them sooner.

Meanwhile, Nadav, my reviewed-by on your patch stands, since it's
straightforward and safe for backport.

> > 3. Let me know if you want me to use your version of testing
> > mm_tlb_flush_pending() and conditionally flushing, wait for new version fro
> > you or Peter or to go with taking mmap_lock for write.
> 
> Yes, as you suggested, I'm trying to clean it up and send a new
> version.
> 
> Ultimately my view is there are an huge number of cases where
> mmap_write_lock or some other heavy lock that will require
> occasionally to block on I/O is beyond impossible not to take. Even
> speculative page faults only attack the low hanging anon memory and
> there's still MADV_DONTNEED/FREE and other stuff that may have to run
> in parallel with UFFDIO_WRITEPROTECT and clear_refs, not just page
> faults.
> 
> As a reminder: the only case when modifying the vmas is allowed under
> mmap_read_lock (I already tried once to make it safer by adding
> READ_ONCE/WRITE_ONCE but wasn't merged see
> https://www.spinics.net/lists/linux-mm/msg173420.html), is when
> updating vm_end/vm_start in growsdown/up, where the vma is extended
> down or up in the page fault under only mmap_read_lock.
> 
> I'm doing all I can to document and make it more explicit the
> complexity we deal with in the code (as well as reducing the gcc
> dependency in emitting atomic writes to update vm_end/vm_start, as we
> should do in ptes as well in theory). As you may notice in the
> feedback from the above submission not all even realized that we're
> modifying vmas already under mmap_read_lock. So it'd be great to get
> help to merge that READ_ONCE/WRITE_ONCE cleanup that is still valid
> and pending for merge but it needs forward porting.
> 
> This one, for both soft dirty and uffd_wrprotect, is a walk in the
> park to optimize in comparison to the vma modifications.
> 
> From my point of view in fact, doing the tlb flush or the wait on the
> atomic to be released, does not increase kernel complexity compared to
> what we had until now.
> 
> I think we already had this complexity before Aug 2020, but we didn't
> realize it, and that's why thing then broke in clear_refs in Aug 2020
> because of an unrelated change that finally exposed the complexity.
> 
> By handling the race so that we stop depending on an undocumented
> page_mapcount dependency, we won't be increasing complexity, we'll be
> merely documenting the complexity we already had to begin with, so
> that it'll be less likely to bite us again in the future if it's
> handled explicitly.
> 
> Thanks,
> Andrea
> 
