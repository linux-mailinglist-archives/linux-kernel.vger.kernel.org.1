Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0B27ED59
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbgI3Pha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgI3Pha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:37:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05318C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:37:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id db4so1105911qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f33WCIAH8fqh3HtODTce+QpZynRoHkBXlYY23wB6w0M=;
        b=YcRB+jn05sxsPmn29ggeNKLPC35F3Fgeo9dlMcBpeJP7YQggaTEHKer4vn+aKh+04M
         qkz5w7J/ldhj0GuiSB50yI1dDikAkWNQ2ymSRtiJ5DccL392sh4ELzMV4TrEaqnOo9Zl
         QAG/L2FP3uXRmVvGMRpY5Dkj1psjTQAUuHF/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f33WCIAH8fqh3HtODTce+QpZynRoHkBXlYY23wB6w0M=;
        b=m4ESg+hwV/gbzxy4XqIPsJar1B4/VZziULQcJGKuhldEwD5Dzzc9YOb0Yng4nfY96I
         3ypTPJP9xJYEUP/4xqS8rMpJM4XlcPh810DXRSYQugP1GviRNiIoFGj+0Kpojb5mOiuL
         z44gz9PjNjNtjTtPe4dLWz5XiibVol44xMXkd/BTt2h+GWavlkaVsJIrwyIinpT1NRmT
         NBvRIXfFewdIwmBh3N23tIiaahW9X7hDBfsxtgR7imhKz3vuIfwZpgToZRXxCMOxlKD/
         plWaZQldpNT3JaDIrs2FAhiaD6ucj3bIRjkfAr1PPhbYBg/5u3WaQR1cAwOMH8VhCzNo
         uKeA==
X-Gm-Message-State: AOAM530KqPIXAdNS6V5b/KYMARoXl/RWRPvcZIY/HFFBgtlMRKSRYwFC
        nNI4lcG6HjVw2seA3IJcArkTgg==
X-Google-Smtp-Source: ABdhPJwL89nU9VHEeW9R8TLUy2btHOZxU2SW1wrLvLM6oOVg5SrbqHUDuGDJKx5PaLSQppvxqhp/7A==
X-Received: by 2002:ad4:55ec:: with SMTP id bu12mr2988504qvb.0.1601480249018;
        Wed, 30 Sep 2020 08:37:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id v8sm2688643qkb.23.2020.09.30.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:37:00 -0700 (PDT)
Date:   Wed, 30 Sep 2020 11:37:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200930153700.GA1472573@google.com>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:39:53PM +0200, Vlastimil Babka wrote:
> On 9/30/20 12:07 AM, Uladzislau Rezki wrote:
> > On Tue, Sep 29, 2020 at 12:15:34PM +0200, Vlastimil Babka wrote:
> >> On 9/18/20 9:48 PM, Uladzislau Rezki (Sony) wrote:
> >> 
> >> After reading all the threads and mulling over this, I am going to deflect from
> >> Mel and Michal and not oppose the idea of lockless allocation. I would even
> >> prefer to do it via the gfp flag and not a completely separate path. Not using
> >> the exact code from v1, I think it could be done in a way that we don't actually
> >> look at the new flag until we find that pcplist is empty - which should not
> >> introduce overhead to the fast-fast path when pcpclist is not empty. It's more
> >> maintainable that adding new entry points, IMHO.
> >> 
> > Thanks for reading all that from the beginning! It must be tough due to the
> > fact there were lot of messages in the threads, so at least i was lost.
> > 
> > I agree that adding a new entry or separate lock-less function can be considered
> > as something that is hard to maintain. I have a question here. I mean about your
> > different look at it:
> > 
> > <snip>
> > bool is_pcp_cache_empty(gfp_t gfp)
> > {
> >     struct per_cpu_pages *pcp;
> >     struct zoneref *ref;
> >     unsigned long flags;
> >     bool empty;
> > 
> >     ref = first_zones_zonelist(node_zonelist(
> >             numa_node_id(), gfp), gfp_zone(gfp), NULL);
> >     if (!ref->zone)
> >             return true;
> > 
> >     local_irq_save(flags);
> >     pcp = &this_cpu_ptr(ref->zone->pageset)->pcp;
> >     empty = list_empty(&pcp->lists[gfp_migratetype(gfp)]);
> >     local_irq_restore(flags);
> > 
> >     return empty;
> > }
> > 
> > disable_irq();
> > if (!is_pcp_cache_empty(GFP_NOWAIT))
> >     __get_free_page(GFP_NOWAIT);
> > enable_irq();
> > <snip>
> > 
> > Do you mean to have something like above? I mean some extra API
> > function that returns true or false if fast-fast allocation can
> > either occur or not. Above code works just fine and never touches
> > main zone->lock.
> > 
> > i.e. Instead of introducing an extra GFP_LOCKLESS flag or any new
> > extra lock-less function. We could have something that checks a
> > pcp page cache list, thus it can guarantee that a request would
> > be accomplish using fast-fast path.
> 
> No, I meant going back to idea of new gfp flag, but adjust the implementation in
> the allocator (different from what you posted in previous version) so that it
> only looks at the flag after it tries to allocate from pcplist and finds out
> it's empty. So, no inventing of new page allocator entry points or checks such
> as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> affect existing fast paths.

I like the idea of a new flag too :) After all telling the allocator more
about what your context can tolerate, via GFP flags, is not without
precedent.

thanks,

 - Joel

