Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2F2EB4FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbhAEVog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbhAEVoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609882987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=45VfqpcohiVmcpJsrhmwiMtIV0TA5yv5gJG2CjfKxSo=;
        b=Log45AwVsAIGkiTY6VgFtm+2ApCRRh7FpaZufmQwkp0/8Upu4xz799rS7xR0qiqv7soWXP
        war40/UOH5nRGFERcuFqTcEvDbqcuCI2RLBN8BvCSprh1Msv85d/1XkY9XdS0WA8stbyAH
        YmhaQgj4GwgBjxwUmCbXchQg1NxglWQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-TKj8xLN2P2-lGc8yeZVqqA-1; Tue, 05 Jan 2021 16:43:03 -0500
X-MC-Unique: TKj8xLN2P2-lGc8yeZVqqA-1
Received: by mail-qt1-f200.google.com with SMTP id v9so751267qtw.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45VfqpcohiVmcpJsrhmwiMtIV0TA5yv5gJG2CjfKxSo=;
        b=mmg6icsbpEVTwAuIZv/0geaapSnSNFOzlGXueg8MEDfND9l6NiHgEH6fbnTOqseYbX
         /9vbEJXLLqayLMCnezsR/O+35qrFTJSPqqEf5rK1vhY1lHL4V4MSsqBJ47A9Yd9MOsZl
         0oMqbxTVjw1L7kSdMqBuukJkrwk3Eg0wyLJHttDZGZWgnk5MB9QTmCYVNI3QXgDG/5BA
         tQQCx2A6zOAQn0J5P+yeRUxU4yIhRngi3ZPi2/TWu4GWpDmoX0zEXtpHBwv/uaS4urZK
         XTdlGZC3JIB11k/P2iWpIVdhpK2FosIMX1nlrNKqM+R/rT5opjt28nUGNUQpy4q/MQTe
         MUbg==
X-Gm-Message-State: AOAM531hPQVaIhT5Yuz04QZTyQ6iSeeuj6OsfwyoWkBZFWIkm6KhscHY
        KtgNVjjGv4zH8CgcMV3SJE+d9wCVzBQv/yptU/Ep63rGcrweD6iNR8jxdl31rKVWFB/2bBy4rqN
        pKpKVl4pL6nLHQVugBg5D+U+B
X-Received: by 2002:aed:2183:: with SMTP id l3mr1424506qtc.75.1609882983346;
        Tue, 05 Jan 2021 13:43:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiipSQoGXaCt4060scNPWjbGWYRsUdMzJxQbwaboNuzaTu8Uqm6e3uy3sSB2pDS7Ux7Ed3ww==
X-Received: by 2002:aed:2183:: with SMTP id l3mr1424493qtc.75.1609882983088;
        Tue, 05 Jan 2021 13:43:03 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id f17sm224790qtv.68.2021.01.05.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 13:43:02 -0800 (PST)
Date:   Tue, 5 Jan 2021 16:43:00 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <20210105214300.GG149908@xz-x1>
References: <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
 <X/N4aqRgyxffhMSs@redhat.com>
 <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
 <X/OCMalFYnDdGnch@redhat.com>
 <2844ACC1-8908-494C-B411-3C69B27A1730@vmware.com>
 <X/SzzjREaoR9u7Ua@redhat.com>
 <BABCB1DE-C41E-4C3E-90D1-5893585FB68A@vmware.com>
 <X/TB6ztitnESl3qZ@redhat.com>
 <91523A61-1AF8-48F9-8650-D313032E550C@vmware.com>
 <X/TU04nu/WdFRS3m@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/TU04nu/WdFRS3m@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 04:06:27PM -0500, Andrea Arcangeli wrote:
> The postcopy live snapshoitting was the #1 use case so it's hard not
> to mention it, but there's still other interesting userland use cases
> of uffd-wp with various users already testing it in their apps, that
> may ultimately become more prevalent, who knows.

That's true.  AFAIU umap [1] uses uffd-wp for their computings already.  I
didn't really measure how far it can go, but currently the library is highly
concurrent, for example, there're quite a few macros that can tune the
parallelism of the library [2]:

  UMAP_PAGE_FILLERS This is the number of worker threads that will perform read
  operations from the backing store (including read-ahead) for a specific umap
  region.

  UMAP_PAGE_EVICTORS This is the number of worker threads that will perform
  evictions of pages. Eviction includes writing to the backing store if the
  page is dirty and telling the operating system that the page is no longer
  needed.

The write lock means at least all the evictor threads will be serialized,
immediately makes UMAP_PAGE_EVICTORS meaningless... not to mention all the rest
of read lock takers (filler threads, worker threads, etc.).  So if it happens,
I bet LLNL will suddenly observe a drastic drop after upgrading the kernel..

I don't know why umap didn't hit the tlb issue already.  It seems to me that
issues may only trigger with COW right after a stalled tlb so COW is the only
one affected (or, is it?) while umap may not use cow that lot by accident.  But
I could be completely wrong on that.

[1] https://github.com/LLNL/umap
[2] https://llnl-umap.readthedocs.io/en/develop/environment_variables.html

-- 
Peter Xu

