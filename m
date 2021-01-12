Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EFE2F3B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393139AbhALTsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389021AbhALTsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:48:50 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED160C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:48:09 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id h1so1455736qvy.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uREbXCwcyfpXNTx7ee7MudJLRW7UlYdjL+1cYZJdpQ8=;
        b=VBloEoCXCTkXhKEoW6IimofV0vg//Z0tXPoFnD6d5P94UevYTSdCMdq3LpxHSjRomX
         ProBumOzdn1ADj+XaPlwbnPOszyLly/YhmI79DIYyxrOnUUuUEIrgwOtFG/dBOIWi9eF
         nuu6nW0Kp+46ypeKukLzOpH4mqYWonf7ji/d8eKn2HKwUDNi3LvuEUx7bZ5qsL0ufKE9
         kSKZSUtMg7qij3kLitiVEy4DBY9dlt1HQH5VoIJpNulRRXo3lS6k1zM7hv/mprTcH1yc
         /cR1A7M9TdQkuMaB97kg9iAXvPsf4HOydPsIsA0bpAvS0JcziMziwUg/xSDNVJ1CSY9l
         6pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uREbXCwcyfpXNTx7ee7MudJLRW7UlYdjL+1cYZJdpQ8=;
        b=is8OeecvnUZ5mJI1Vi78Ogyj19QBlGPWrUQFApBomnqGuzXfoi+5Yxc7uqqvV0rMeT
         0kB/JgHa86Yfq0dm6Q94Yy+NzRvazhyJCMpsQ6lxuyDCDHuQzhs5U1ZobdlCXcdvbpf7
         3cWUcGLBwTDM/03EgXmfgqz12Gkrp58/sU4S4KI3eH/R+qQnfYbJaVk7xeq5CLPMgdl2
         gn92HnoZ+kXA0kkP/Atus7LxNSRz3MMaPKbatGpdJ8kYjVgN3xanQH0O8IxcOoptIilL
         E/3IVRm0p9bnIDM92c6ZzEXXDf4U+RA0NANBrma50EDZ8iY91e86jTXvZxaQqGHK6xTf
         93yA==
X-Gm-Message-State: AOAM5310HxH7quY4Kgv8muED39qcWkIdGOL3rJ2oZXDCjNNw+HfeiBbt
        iicJW6qtyz7yoLEJGu6LSOhkwg==
X-Google-Smtp-Source: ABdhPJz+8gfNtuW49ZpsrzT6yhcw5t3/fcuKUGjyGq53djXPi27K1yuRkXL9Tq4gN1F/yyzwMxEOcg==
X-Received: by 2002:a0c:ac43:: with SMTP id m3mr1099634qvb.37.1610480889261;
        Tue, 12 Jan 2021 11:48:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:1fb4])
        by smtp.gmail.com with ESMTPSA id y9sm1709017qtm.96.2021.01.12.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:48:08 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:45:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <X/38ZwyOE96SAfa9@cmpxchg.org>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210112170322.GA99586@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112170322.GA99586@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:03:22AM -0800, Roman Gushchin wrote:
> On Tue, Jan 12, 2021 at 11:30:11AM -0500, Johannes Weiner wrote:
> > When a value is written to a cgroup's memory.high control file, the
> > write() context first tries to reclaim the cgroup to size before
> > putting the limit in place for the workload. Concurrent charges from
> > the workload can keep such a write() looping in reclaim indefinitely.
> > 
> > In the past, a write to memory.high would first put the limit in place
> > for the workload, then do targeted reclaim until the new limit has
> > been met - similar to how we do it for memory.max. This wasn't prone
> > to the described starvation issue. However, this sequence could cause
> > excessive latencies in the workload, when allocating threads could be
> > put into long penalty sleeps on the sudden memory.high overage created
> > by the write(), before that had a chance to work it off.
> > 
> > Now that memory_high_write() performs reclaim before enforcing the new
> > limit, reflect that the cgroup may well fail to converge due to
> > concurrent workload activity. Bail out of the loop after a few tries.
> > 
> > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > Cc: <stable@vger.kernel.org> # 5.8+
> > Reported-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/memcontrol.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 605f671203ef..63a8d47c1cd3 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6275,7 +6275,6 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> >  
> >  	for (;;) {
> >  		unsigned long nr_pages = page_counter_read(&memcg->memory);
> > -		unsigned long reclaimed;
> >  
> >  		if (nr_pages <= high)
> >  			break;
> > @@ -6289,10 +6288,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> >  			continue;
> >  		}
> >  
> > -		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> > -							 GFP_KERNEL, true);
> > +		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> > +					     GFP_KERNEL, true);
> >  
> > -		if (!reclaimed && !nr_retries--)
> > +		if (!nr_retries--)
> 
> Shouldn't it be (!reclaimed || !nr_retries) instead?
> 
> If reclaimed == 0, it probably doesn't make much sense to retry.

We usually allow nr_retries worth of no-progress reclaim cycles to
make up for intermittent reclaim failures.

The difference to OOMs/memory.max is that we don't want to loop
indefinitely on forward progress, but we should allow the usual number
of no-progress loops.
