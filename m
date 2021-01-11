Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767B72F1D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389564AbhAKR4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:56:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:40940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbhAKR4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:56:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10C21AB3E;
        Mon, 11 Jan 2021 17:55:27 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC 0/3] mm, slab, slub: remove cpu and memory hotplug locks
To:     Christoph Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20210106174029.12654-1-vbabka@suse.cz>
 <alpine.DEB.2.22.394.2101061907330.2652@www.lameter.com>
Message-ID: <91f48b11-b6ff-39ab-947e-341920771e0f@suse.cz>
Date:   Mon, 11 Jan 2021 18:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2101061907330.2652@www.lameter.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/21 8:09 PM, Christoph Lameter wrote:
> On Wed, 6 Jan 2021, Vlastimil Babka wrote:
> 
>> rather accept some wasted memory in scenarios that should be rare anyway (full
>> memory hot remove), as we do the same in other contexts already. It's all RFC
>> for now, as I might have missed some reason why it's not safe.
> 
> Looks good to me. My only concern is the kernel that has hotplug disabled.
> Current code allows the online/offline checks to be optimized away.
> 
> Can this patch be enhanced to do the same?

Thanks, indeed I didn't think about that.
But on closer inspection, there doesn't seem to be need for such enhancement:

- Patch 1 adds the new slab_nodes nodemask, which is basically a copy of
N_NORMAL_MEMORY. Without memory hotplug, the callbacks that would update it
don't occur (maybe are even eliminated as dead code?), other code that uses the
nodemask is unaffected wtf performance, it's just using a different nodemask for
the same operations. The extra memory usage of adding the nodemask is negligible
and not worth complicating the code to distinguish between the new nodemask and
N_NORMAL_MEMORY depending on hotplug being disabled or enabled.

- Patch 1 also restores slab_mutex lock in kmem_cache_shrink(). Commit
03afc0e25f7f removed it because the memory hotplug lock was deemed to be
sufficient replacement, but probably didn't consider the case where hotplug is
disabled and thus the hotplug lock is no-op. Maybe it's safe not to take
slab_mutex in kmem_cache_shrink() in that case, but kmem_cache_shrink() is only
called from a sysfs handler, thus a very cold path anyway.
But, I found out that lockdep complains about it, so I have to rethink this part
anyway... (when kmem_cache_shrink() is called from write to the 'shrink' file we
already have kernfs lock "kn->active#28" and try to lock slab_mutex, but there's
existing dependency in reverse order where in kmem_cache_create() we start with
slab_mutex and sysfs_slab_add takes the kernfs lock, I wonder how this wasn't a
problem before 03afc0e25f7f)

- Patch 2 purely just removes calls to cpu hotplug lock.

- Patch 3 only affects memory hotplug callbacks so nothing to enhance if hotplug
is disabled


