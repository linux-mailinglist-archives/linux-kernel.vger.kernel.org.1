Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0652F532A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbhAMTOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:14:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:60376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbhAMTOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:14:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B342ACF4;
        Wed, 13 Jan 2021 19:14:12 +0000 (UTC)
To:     Jann Horn <jannh@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: SLUB: percpu partial object count is highly inaccurate, causing
 some memory wastage and maybe also worse tail latencies?
Message-ID: <2f0f46e8-2535-410a-1859-e9cfa4e57c18@suse.cz>
Date:   Wed, 13 Jan 2021 20:14:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 12:12 AM, Jann Horn wrote:
> [This is not something I intend to work on myself. But since I
> stumbled over this issue, I figured I should at least document/report
> it, in case anyone is willing to pick it up.]
> 
> Hi!

Hi, thanks for saving me a lot of typing!

...

> This means that in practice, SLUB actually ends up keeping as many
> **pages** on the percpu partial lists as it intends to keep **free
> objects** there.

Yes, I concluded the same thing.

...

> I suspect that this may have also contributed to the memory wastage
> problem with memory cgroups that was fixed in v5.9
> (https://lore.kernel.org/linux-mm/20200623174037.3951353-1-guro@fb.com/);
> meaning that servers with lots of CPU cores running pre-5.9 kernels
> with memcg and systemd (which tends to stick every service into its
> own memcg) might be even worse off.

Very much yes. Investigating an increase of kmemcg usage of a workload between
an older kernel with SLAB and 5.3-based kernel with SLUB led us to find the same
issue as you did. It doesn't help that slabinfo (global or per-memcg) is also
inaccurate as it cannot count free objects on per-cpu partial slabs and thus
reports them as active. I was aware that some empty slab pages might linger on
per-cpu lists, but only after seeing how many were freed after "echo 1 >
.../shrink" made me realize the extent of this.

> It also seems unsurprising to me that flushing ~30 pages out of the
> percpu partial caches at once with IRQs disabled would cause tail
> latency spikes (as noted by Joonsoo Kim and Christoph Lameter in
> commit 345c905d13a4e "slub: Make cpu partial slab support
> configurable").
> 
> At first I thought that this wasn't a significant issue because SLUB
> has a reclaim path that can trim the percpu partial lists; but as it
> turns out, that reclaim path is not actually wired up to the page
> allocator's reclaim logic. The SLUB reclaim stuff is only triggered by
> (very rare) subsystem-specific calls into SLUB for specific slabs and
> by sysfs entries. So in userland processes will OOM even if SLUB still
> has megabytes of entirely unused pages lying around.

Yeah, we considered to wire the shrinking to memcg OOM, but it's a poor
solution. I'm considering introducing a proper shrinker that would be registered
and work like other shrinkers for reclaimable caches. Then we would make it
memcg-aware in our backport - upstream after v5.9 doesn't need that obviously.

> It might be a good idea to figure out whether it is possible to
> efficiently keep track of a more accurate count of the free objects on

As long as there are some inuse objects, it shouldn't matter much if the slab is
sitting on per-cpu partial list or per-node list, as it can't be freed anyway.
It becomes a real problem only after the slab become fully free. If we detected
that in __slab_free() also for already-frozen slabs, we would need to know which
CPU this slab belongs to (currently that's not tracked afaik), and send it an
IPI to do some light version of unfreeze_partials() that would only remove empty
slabs. The trick would be not to cause too many IPI's by this, obviously :/

Actually I'm somewhat wrong above. If a CPU and per-node partial list runs out
of free objects, it's wasteful to allocate new slabs if almost-empty slabs sit
on another CPU's per-node partial list.

> percpu partial lists; and if not, maybe change the accounting to
> explicitly track the number of partial pages, and use limits that are

That would be probably the simplest solution. Maybe sufficient  upstream where
the wastage only depends on number of caches and not memcgs. For pre-5.9 I also
considered limiting the number of pages only for the per-memcg clones :/
Currently writing to the /sys/.../<cache>/cpu_partial file is propagated to all
the clones and root cache.

> more appropriate for that? And perhaps the page allocator reclaim path
> should also occasionally rip unused pages out of the percpu partial
> lists?

That would be best done by the a shrinker?

BTW, SLAB does this by reaping of its per-cpu and shared arrays by timers (which
works, but is not ideal) They also can't grow that large like this.


