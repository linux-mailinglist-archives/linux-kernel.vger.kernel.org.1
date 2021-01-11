Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED912F17BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbhAKOMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbhAKOM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:12:26 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4FEC06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:11:45 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id y22so3704145ljn.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZReoOwflH9bo7F+gPMdBMhNPvju0+jhg+phHdqxtW9U=;
        b=bbuae7i0ajVSZs/iE1GxJS5JTwYsINPj50ZdGUxE8FoqN7c/ITb936oHhlK0+HrIG4
         eUpaYUbVGgplw/D+vDub5l/FTKPXs9IvB+44IXU/4bS7bhCHcI3u3gXrt0ur2/2hOU/e
         oe4rj+MEcQDpceTKAaaqkgBd0oNsV2JkHKZFXU98u1kRdxXDtKPcqYSA7eerbF/5IuM0
         9S5xCvWno6qF4y/4oLvDqOGG1E+m6xW1z5Zea2iFihtRoI55+j2qOoGclCbeg7VD+Ws5
         1qy4ESog4Jg16KYQQee2aEwiNqAm47G/orZksLVspkrI9h7t3ssHlKUY3J/VM9dfsQwb
         q/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZReoOwflH9bo7F+gPMdBMhNPvju0+jhg+phHdqxtW9U=;
        b=jMef5Fc20b+PnfQ4TX38AESpjWRXplYvfhJDFE07aG3kH9d/Gezk9lfYhhAa1x56ZE
         cj2XhudN6JvpVHc/5198RDaZPy6Dt2Q3OqqQphp7ZtxKbatjYS9wiX1P8hKLYvNKPamH
         o3mmpmH1nbxi7YvH65vWeGSYnYauTwn5Q8d9gpnyhiY6l+UeNglgMll+NXHPog6PB+o4
         nWBtrxYhNP4D5JYAvlb5TFnbZkgwCTZBvBfctdqWH0CIVNNNEwEJBe4bs9gY992kRPQc
         LxpI3KSih2dZ3ddyD8ZnzjIlYTehC1164n6dtUN0FDs8zPdUMC+i2/XtTbo7OeIHHWCr
         WpKw==
X-Gm-Message-State: AOAM532IZxN2aA2KoQMpIJeZAqf7bKffpFcsyV7mbOldVDNLnqEgh/Q5
        q1XnnURtxvZjaLfRPMJUqv/8fA==
X-Google-Smtp-Source: ABdhPJwz/2c/lBqYKtQvgp5ukYJ1MrpG+yfHbeuPoqGm/F7I13cJ0at60TMTPhYSKPvLK/IGSK8Pbw==
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr7897396ljr.124.1610374304175;
        Mon, 11 Jan 2021 06:11:44 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t28sm3512091ljo.45.2021.01.11.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:11:43 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E898F102238; Mon, 11 Jan 2021 17:11:47 +0300 (+03)
Date:   Mon, 11 Jan 2021 17:11:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210111141147.wzk5rvycsiitnnrt@box>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <20210110004435.26382-2-aarcange@redhat.com>
 <X/psTXZp9xNgX3gE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/psTXZp9xNgX3gE@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 09:54:05PM -0500, Andrea Arcangeli wrote:
> Hello,
> 
> On Sat, Jan 09, 2021 at 07:44:35PM -0500, Andrea Arcangeli wrote:
> > allowing a child to corrupt memory in the parent. That's a problem
> > that could happen not-maliciously too. So the scenario described
> 
> I updated the above partly quoted sentence since in the previous
> version it didn't have full accuracy:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=fc5a76b1c14e5e6cdc64ece306fc03773662d98a
> 
> "However since a single transient GUP pin on a tail page, would elevate
> the page_count for all other tail pages (unlike the mapcount which is
> subpage granular), the COW page reuse inaccuracy would then cross
> different vmas and the effect would happen at a distance in vma of
> different processes. A single GUP pin taken on a subpage mapped in a
> different process could trigger 511 false positive COWs copies in the
> local process, after a fork()."
> 
> This a best effort to try to document all side effects, but it'd be
> great to hear from Kirill too on the above detail to have
> confirmation.

Yes, this side effect is possible. But I wouldn't worry about too much. If
it routinely happens in a real workloads (I doubt it does), the workload
can tune it with MADV_NOHUGEPAGE/MADV_DONTFORK/MADV_WIPEONFORK or
something.

-- 
 Kirill A. Shutemov
