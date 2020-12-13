Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1682D90D1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 23:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgLMVwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 16:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgLMVwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 16:52:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC17C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 13:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XolCovdIf0+CJ356bLijRvmZLeDHWmHhlljxDwlSXzA=; b=ZxfexHHMqdevjvW31qJIsVkGdA
        uh6jYcAgQjS/6VtOl4wfRn5ADo7EwWhvN+yr8xM73sSbeWxw5xFtAzVumPgRx7OZp1EwkUz+fvyqB
        xmgwbRkc3M7RLqyVrz8NYPSiVWW5LUi2aJPn35lI3a+lFoOsWpSTfxE8LjrVNpDhmBLfwpdW1m5YX
        8a7MG7+atObad4QrR5xH/w4R2CG9S2SYuXy1CGtHOEEfTmI2SKaXVyK4xwjLd6STJkVl8VcZnQiWs
        HXdlh8Jgpaby+kt5ESfjy9LAnlxiEeCG4VDuGD0QiC7i8CU2wDbOoOJpwasrz3MZpv6LyyebtF4Do
        Ko2eAcPA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koZHC-0004oC-FC; Sun, 13 Dec 2020 21:51:34 +0000
Date:   Sun, 13 Dec 2020 21:51:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Fix unlock order in s_stop()
Message-ID: <20201213215134.GI2443@casper.infradead.org>
References: <20201213180843.16938-1-longman@redhat.com>
 <20201213183936.GA20007@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213183936.GA20007@pc636>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 07:39:36PM +0100, Uladzislau Rezki wrote:
> On Sun, Dec 13, 2020 at 01:08:43PM -0500, Waiman Long wrote:
> > When multiple locks are acquired, they should be released in reverse
> > order. For s_start() and s_stop() in mm/vmalloc.c, that is not the
> > case.
> > 
> >   s_start: mutex_lock(&vmap_purge_lock); spin_lock(&vmap_area_lock);
> >   s_stop : mutex_unlock(&vmap_purge_lock); spin_unlock(&vmap_area_lock);
> > 
> > This unlock sequence, though allowed, is not optimal. If a waiter is
> > present, mutex_unlock() will need to go through the slowpath of waking
> > up the waiter with preemption disabled. Fix that by releasing the
> > spinlock first before the mutex.
> > 
> > Fixes: e36176be1c39 ("mm/vmalloc: rework vmap_area_lock")
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >  mm/vmalloc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 6ae491a8b210..75913f685c71 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3448,11 +3448,11 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
> >  }
> >  
> >  static void s_stop(struct seq_file *m, void *p)
> > -	__releases(&vmap_purge_lock)
> >  	__releases(&vmap_area_lock)
> > +	__releases(&vmap_purge_lock)
> >  {
> > -	mutex_unlock(&vmap_purge_lock);
> >  	spin_unlock(&vmap_area_lock);
> > +	mutex_unlock(&vmap_purge_lock);
> >  }
> >  
> >  static void show_numa_info(struct seq_file *m, struct vm_struct *v)
> BTW, if navigation over both list is an issue, for example when there
> are multiple heavy readers of /proc/vmallocinfo, i think, it make sense
> to implement RCU safe lists iteration and get rid of both locks.

If we need to iterate the list efficiently, i'd suggest getting rid of
the list and using an xarray instead.  maybe a maple tree, once that code
is better exercised.
