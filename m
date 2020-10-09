Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8F289BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391100AbgJIWXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 18:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387542AbgJIWXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:23:22 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69FFC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 15:23:20 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c13so11767050oiy.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 15:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Xfvh23nsFhdOAwjXTF5OSDmVXedEc81TbeoYKAL0kNY=;
        b=lh/6y8Dnke8lKCfFOufel5NfiYvOpCawa8hm6OT672bczO/yUm+YypNSvyVrYbA3ki
         H5gjiBQsPRgrJwVCTDAOyTzcgEsaD8u6n7Ui7jTWydAG/lm81VeAK+rqEe/6z19P4ugL
         7kbop8EJZokKXVTg7xpRC0kc7HyKb/O/kxb68gcq313TTkqOmEG10vBnNNVevJlhk0Gt
         7ccCwjAdbJnktFvKxUF8a1aMwqghjVSH7BUt0A/tJvOgqnWI2wZXBi8qD9mJ/1O0UagA
         65WvNujRnsrUdbi6FuVMV75zHz5/7XwWihwSTJb+dj4/RcZmRbI8rwgxdQwlCLGDu+3k
         4RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Xfvh23nsFhdOAwjXTF5OSDmVXedEc81TbeoYKAL0kNY=;
        b=gTUwcih2gmt/gaf8M00p6Ju/kA+0UQgohi8xa828645iOf0eLUaTp5mqEnjZwlWF0Z
         U1ML+lAUiKs1PzCsgPhftuXV+3JOdncDSFuVqHYuhZe8KLDwzsWgvgujaZgWax+KK53K
         dYzVnBcPwHrIpBLA+eB91//9BS8da+0yi6wO8lKOmMBEYY0qdjo4/piKVocv8LfQlAwF
         PbWC+I+vtRzqFh74TUIVcYCF5VxFZgq3dCmh0fe/rr1ZkM3fKdUFDRh5SPVupjX7ESad
         QasWqWNqUXpsnUO0y8+A88mQgFn9Rtc/afBQvllPKGcoLOTvsnr37oWTqYulPbaCD+Dq
         M0FA==
X-Gm-Message-State: AOAM530Ob9FZ2YEONPkZxbey1tEvzN0ZA51o3euA3cKgYM3bTtOfKuDH
        n0QeAWpOJdnx0t7A3TwWEapaPw==
X-Google-Smtp-Source: ABdhPJx+JyZPLP8+OUUbayFGe+b0GRvSN/9xjqV8gLRV6L9OkuaBMsrITRFCyjUrFp/lausQfDIufA==
X-Received: by 2002:aca:1105:: with SMTP id 5mr4030194oir.46.1602282199834;
        Fri, 09 Oct 2020 15:23:19 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a16sm6705145otk.39.2020.10.09.15.23.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 09 Oct 2020 15:23:18 -0700 (PDT)
Date:   Fri, 9 Oct 2020 15:23:03 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     Hugh Dickins <hughd@google.com>, Qian Cai <cai@lca.pw>,
        js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 7/8] mm/mempolicy: use a standard migration target
 allocation callback
In-Reply-To: <68e09cac-d2d9-9ddf-6e10-0b8cc0befe82@oracle.com>
Message-ID: <alpine.LSU.2.11.2010091521460.12013@eggly.anvils>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com> <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com> <20200708012044.GC992@lca.pw> <alpine.LSU.2.11.2010071833100.2214@eggly.anvils> <cf715524-f30d-634f-2a05-e02c4e52e675@oracle.com>
 <alpine.LSU.2.11.2010082216250.10228@eggly.anvils> <68e09cac-d2d9-9ddf-6e10-0b8cc0befe82@oracle.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020, Mike Kravetz wrote:
> On 10/8/20 10:50 PM, Hugh Dickins wrote:
> > 
> > It's a problem I've faced before in tmpfs, keeping a hold on the
> > mapping while page lock is dropped.  Quite awkward: igrab() looks as
> > if it's the right thing to use, but turns out to give no protection
> > against umount.  Last time around, I ended up with a stop_eviction
> > count in the shmem inode, which shmem_evict_inode() waits on if
> > necessary.  Something like that could be done for hugetlbfs too,
> > but I'd prefer to do it without adding extra, if there is a way.
> 
> Thanks.

I failed to come up with anything neater than a stop_eviction count
in the hugetlbfs inode.

But that's not unlike a very special purpose rwsem added into the
hugetlbfs inode: and now that you're reconsidering how i_mmap_rwsem
got repurposed, perhaps you will end up with an rwsem of your own in
the hugetlbfs inode.

So I won't distract you with a stop_eviction patch unless you ask:
that's easy, what you're looking into is hard - good luck!

Hugh

> >>
> >> As mentioned above, I hope all this can be removed.
> > 
> > If you continue to nest page lock inside i_mmap_rwsem for hugetlbfs,
> > then I think that part of hugetlb_page_mapping_lock_write() has to
> > remain.  I'd much prefer that hugetlbfs did not reverse the usual
> > nesting, but accept that you had reasons for doing it that way.
> 
> Yes, that is necessary with the change to lock order.
> 
> Yesterday I found another issue/case to handle in the hugetlb COW code
> caused by the difference in lock nesting.  As a result, I am rethinking
> the decision to change the locking order.
> 
> The primary reason for changing the lock order was to make the hugetlb
> page fault code not have to worry about pte pointers changing.  The issue
> is that the pte pointer you get (or create) while walking the table
> without the page table lock could go away due to unsharing the PMD.  We
> can walk the table again after acquiring the lock and validate and possibly
> retry.  However, the backout code in this area which previously had to
> deal with truncation as well, was quite fragile and did not work in all
> corner cases.  This was mostly due to lovely huge page reservations.
> I thought that adding more complexity to the backout code was going to
> cause more issues.  Changing the locking order eliminated the pte pointer
> race as well as truncation.  However, it created new locking issues. :(
> 
> In parallel to working the locking issue, I am also exploring enhanced
> backout code to handle all the needed cases.
> -- 
> Mike Kravetz
