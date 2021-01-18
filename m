Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2322FA5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406397AbhARQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:09:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:58790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406078AbhARQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:08:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610986046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JNQs8E/IK8Nde3e0PCSuz8+Pj2HndUD2dN/6u3bCedk=;
        b=GWaRX4IuWfbZ7SJ3piEOKp5lCKRKnVuAMZA0GxbUsuyMiIw769sw7d63xngi+B0XzJ7z1q
        iZd7uzetTEUuA8Pj04XAG8y0FmFg0394YpeSxQ3H3mONYynGJSdsgFrekw7GewRvVsmGkY
        RYDV1qqdOX2EBuFcEeUp3XWI/ljG/4Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 584BEAD19;
        Mon, 18 Jan 2021 16:07:26 +0000 (UTC)
Date:   Mon, 18 Jan 2021 17:07:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: SLUB: percpu partial object count is highly inaccurate, causing
 some memory wastage and maybe also worse tail latencies?
Message-ID: <20210118160722.GG14336@dhcp22.suse.cz>
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
 <alpine.DEB.2.22.394.2101121627490.20570@www.lameter.com>
 <e4d89d4f-62d4-43e3-9dd7-2496e955b437@suse.cz>
 <20210118110319.GC14336@dhcp22.suse.cz>
 <alpine.DEB.2.22.394.2101181537150.69690@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101181537150.69690@www.lameter.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-01-21 15:46:43, Cristopher Lameter wrote:
> On Mon, 18 Jan 2021, Michal Hocko wrote:
> 
> > > Hm this would be similar to recommending a periodical echo > drop_caches
> > > operation. We actually discourage from that (and yeah, some tools do that, and
> > > we now report those in dmesg). I believe the kernel should respond to memory
> > > pressure and not OOM prematurely by itself, including SLUB.
> >
> > Absolutely agreed! Partial caches are a very deep internal
> > implementation detail of the allocator and admin has no bussiness into
> > fiddling with that. This would only lead to more harm than good.
> > Comparision to drop_caches is really exact!
> 
> Really? The maximum allocation here has a upper boundary that depends on
> the number of possible partial per cpu slabs.

And number of cpus and caches...

> There is a worst case
> scenario that is not nice and wastes some memory but it is not an OOM
> situation and the system easily recovers from it.

There is no pro-active shrinking of those when we are close to the OOM
so we still can go and kill a task while there is quite some memory
sitting in a freeable slub caches unless I am missing something.

We have learned about this in a memcg environment on our distribution
kernels where the problem is amplified by the use in memcgs with a small
limit. This is an older kernel and I would expect the current upstream
will behave better with Roman's accounting rework. But still it would be
great if the allocator could manage its caches depending on the memory
demand.

> The slab shrinking is not needed but if you are concerned about reclaiming
> more memory right now then I guess you may want to run the slab shrink
> operation.

Yes, you can do that. In a same way you can shrink the page cache.
Moreover it is really hard to do that somehow inteligently because you
would need to watch the system very closely in order to shrink when it
is really needed. That requires a deep understanding of the allocator.

> Dropping the page cache is bad? Well sometimes you want more free memory
> due to a certain operation that needs to be started and where you do not
> want the overhead of page cache processing.

It is not bad if used properly. My experience is that people have
developed instinct to drop caches whenever something is not quite right
because Internet has recommended that.

-- 
Michal Hocko
SUSE Labs
