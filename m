Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9127663A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 04:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgIXCJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 22:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726281AbgIXCJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 22:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600913375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pr+TFvgT15Y3MIUsJ7R07JPi6Z9CSwvWJeXmktBGVqc=;
        b=Jx+DaF4LkIQzsGWVTCay8BnYL5Rkv4ZPg38v40Djp1CfuhIZTGgY34GIMYAw+2uEMbcuYo
        J/+s7SYRrtvbL+9o+iqcKa1LHw7hTZXQkZKGAXpQn8pxR+IzlTj5i2hr1NtclmL+ePPhe3
        kdujLAZaDg8ifzxmWI6fknRG9QeV9q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-b-Cy_P4sOhGY6UhuTZlcEA-1; Wed, 23 Sep 2020 22:09:34 -0400
X-MC-Unique: b-Cy_P4sOhGY6UhuTZlcEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3DF0801AF7;
        Thu, 24 Sep 2020 02:09:32 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7E6060BF1;
        Thu, 24 Sep 2020 02:09:31 +0000 (UTC)
Date:   Wed, 23 Sep 2020 22:09:28 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer
 dereference
Message-ID: <20200924020928.GC1023012@optiplex-lnx>
References: <20200922184838.978540-1-aquini@redhat.com>
 <878sd1qllb.fsf@yhuang-dev.intel.com>
 <20200923043459.GL795820@optiplex-lnx>
 <87sgb9oz1u.fsf@yhuang-dev.intel.com>
 <20200923130138.GM795820@optiplex-lnx>
 <87blhwng5f.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blhwng5f.fsf@yhuang-dev.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 08:59:40AM +0800, Huang, Ying wrote:
> Rafael Aquini <aquini@redhat.com> writes:
> 
> > On Wed, Sep 23, 2020 at 01:13:49PM +0800, Huang, Ying wrote:
> >> Rafael Aquini <aquini@redhat.com> writes:
> >> 
> >> > On Wed, Sep 23, 2020 at 10:21:36AM +0800, Huang, Ying wrote:
> >> >> Hi, Rafael,
> >> >> 
> >> >> Rafael Aquini <aquini@redhat.com> writes:
> >> >> 
> >> >> > The swap area descriptor only gets struct swap_cluster_info *cluster_info
> >> >> > allocated if the swapfile is backed by non-rotational storage.
> >> >> > When the swap area is laid on top of ordinary disk spindles, lock_cluster()
> >> >> > will naturally return NULL.
> >> >> 
> >> >> Thanks for reporting.  But the bug looks strange.  Because in a system
> >> >> with only HDD swap devices, during THP swap out, the swap cluster
> >> >> shouldn't be allocated, as in
> >> >> 
> >> >> shrink_page_list()
> >> >>   add_to_swap()
> >> >>     get_swap_page()
> >> >>       get_swap_pages()
> >> >>         swap_alloc_cluster()
> >> >>
> >> >
> >> > The underlying problem is that swap_info_struct.cluster_info is always NULL 
> >> > on the rotational storage case.
> >> 
> >> Yes.
> >> 
> >> > So, it's very easy to follow that constructions 
> >> > like this one, in split_swap_cluster 
> >> >
> >> > ...
> >> >         ci = lock_cluster(si, offset);
> >> >         cluster_clear_huge(ci);
> >> > ...
> >> >
> >> > will go for a NULL pointer dereference, in that case, given that lock_cluster 
> >> > reads:
> >> >
> >> > ...
> >> > 	struct swap_cluster_info *ci;
> >> >         ci = si->cluster_info;
> >> >         if (ci) {
> >> >                 ci += offset / SWAPFILE_CLUSTER;
> >> >                 spin_lock(&ci->lock);
> >> >         }
> >> >         return ci;
> >> > ...
> >> 
> >> But on HDD, we shouldn't call split_swap_cluster() at all, because we
> >> will not allocate swap cluster firstly.  So, if we run into this,
> >> there should be some other bug, we need to figure it out.
> >>
> >
> > split_swap_cluster() gets called by split_huge_page_to_list(),
> > if the page happens to be in the swapcache, and it will always
> > go that way, regardless the backing storage type:
> >
> > ...
> >             __split_huge_page(page, list, end, flags);
> >             if (PageSwapCache(head)) {
> >                     swp_entry_t entry = { .val = page_private(head) };
> >
> >                     ret = split_swap_cluster(entry);
> >             } else
> >                     ret = 0;
> > ...
> >
> > The problem is not about allocating the swap_cluster -- it's obviously
> > not allocated in these cases. The problem is that on rotational
> > storage you don't even have the base structure that allows you to
> > keep the swap clusters (cluster_info does not get allocated, at all,
> > so si->cluster_info is always NULL)
> >
> > You can argue about other bugs all you want, it doesn't change
> > the fact that this code is incomplete as it sits, because it 
> > misses checking for a real case where lock_cluster() will return NULL.
> 
> I don't want to argue about anything.  I just want to fix the bug.  The
> fix here will hide the real bug instead of fixing it.  For the situation
> you described (PageSwapCache() returns true for a THP backed by a normal
> swap entry (not swap cluster)), we will run into other troubles too.  So
> we need to find the root cause and fix it.
>

The bug here is quite simple: split_swap_cluster() misses checking for 
lock_cluster() returning NULL before committing to change cluster_info->flags.

The fundamental problem has nothing to do with allocating, or not allocating 
a swap cluster, but it has to do with the fact that the THP deferred split scan
can transiently race with swapcache insertion, and the fact that when you run 
your swap area on rotational storage cluster_info is _always_ NULL. 
split_swap_cluster() needs to check for lock_cluster() returning NULL because 
that's one possible case, and it clearly fails to do so. 

Run a workload that cause multiple THP COW, and add a memory hogger to create 
memory pressure so you'll force the reclaimers to kick the registered
shrinkers. The trigger is not heavy swapping, and that's probably why
most swap test cases don't hit it. The window is tight, but you will get the 
NULL pointer dereference.

Regardless you find furhter bugs, or not, this patch is needed to correct a
blunt coding mistake.

