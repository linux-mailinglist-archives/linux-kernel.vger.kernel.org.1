Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD8275857
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIWNBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWNBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600866108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9YBlT3EvuezrkgbgwTKtVPkbq/M4DSApbdGRGuPKZmU=;
        b=HOZSFkLeOF6ZSnS/CzrWazQGoCiV5RW7ViFccrC2/yW0BPr5xqLIirozKX9VZAORzDD1CH
        DhYhipVRgvUonRcb9oJxrEpqoNOxYcIPYgGn9+/rUNmj0T/3GfQechzEb9vzbnN2bpfURn
        ZESg9CYC3BtKvnX6ZkMiCbooXXajb9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-HceP2J3VOyyV9JZAKQWjLQ-1; Wed, 23 Sep 2020 09:01:45 -0400
X-MC-Unique: HceP2J3VOyyV9JZAKQWjLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CE711882FBC;
        Wed, 23 Sep 2020 13:01:43 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F96E75120;
        Wed, 23 Sep 2020 13:01:41 +0000 (UTC)
Date:   Wed, 23 Sep 2020 09:01:38 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer
 dereference
Message-ID: <20200923130138.GM795820@optiplex-lnx>
References: <20200922184838.978540-1-aquini@redhat.com>
 <878sd1qllb.fsf@yhuang-dev.intel.com>
 <20200923043459.GL795820@optiplex-lnx>
 <87sgb9oz1u.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgb9oz1u.fsf@yhuang-dev.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 01:13:49PM +0800, Huang, Ying wrote:
> Rafael Aquini <aquini@redhat.com> writes:
> 
> > On Wed, Sep 23, 2020 at 10:21:36AM +0800, Huang, Ying wrote:
> >> Hi, Rafael,
> >> 
> >> Rafael Aquini <aquini@redhat.com> writes:
> >> 
> >> > The swap area descriptor only gets struct swap_cluster_info *cluster_info
> >> > allocated if the swapfile is backed by non-rotational storage.
> >> > When the swap area is laid on top of ordinary disk spindles, lock_cluster()
> >> > will naturally return NULL.
> >> 
> >> Thanks for reporting.  But the bug looks strange.  Because in a system
> >> with only HDD swap devices, during THP swap out, the swap cluster
> >> shouldn't be allocated, as in
> >> 
> >> shrink_page_list()
> >>   add_to_swap()
> >>     get_swap_page()
> >>       get_swap_pages()
> >>         swap_alloc_cluster()
> >>
> >
> > The underlying problem is that swap_info_struct.cluster_info is always NULL 
> > on the rotational storage case.
> 
> Yes.
> 
> > So, it's very easy to follow that constructions 
> > like this one, in split_swap_cluster 
> >
> > ...
> >         ci = lock_cluster(si, offset);
> >         cluster_clear_huge(ci);
> > ...
> >
> > will go for a NULL pointer dereference, in that case, given that lock_cluster 
> > reads:
> >
> > ...
> > 	struct swap_cluster_info *ci;
> >         ci = si->cluster_info;
> >         if (ci) {
> >                 ci += offset / SWAPFILE_CLUSTER;
> >                 spin_lock(&ci->lock);
> >         }
> >         return ci;
> > ...
> 
> But on HDD, we shouldn't call split_swap_cluster() at all, because we
> will not allocate swap cluster firstly.  So, if we run into this,
> there should be some other bug, we need to figure it out.
>

split_swap_cluster() gets called by split_huge_page_to_list(),
if the page happens to be in the swapcache, and it will always
go that way, regardless the backing storage type:

...
            __split_huge_page(page, list, end, flags);
            if (PageSwapCache(head)) {
                    swp_entry_t entry = { .val = page_private(head) };

                    ret = split_swap_cluster(entry);
            } else
                    ret = 0;
...

The problem is not about allocating the swap_cluster -- it's obviously
not allocated in these cases. The problem is that on rotational
storage you don't even have the base structure that allows you to
keep the swap clusters (cluster_info does not get allocated, at all,
so si->cluster_info is always NULL)

You can argue about other bugs all you want, it doesn't change
the fact that this code is incomplete as it sits, because it 
misses checking for a real case where lock_cluster() will return NULL.


