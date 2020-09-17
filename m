Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A142826DB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIQMMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:12:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgIQMMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:12:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600344735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucEs7xhP0dgoIWRnrrSIRIUkhZCMqR/nH039Ku6cb1o=;
        b=YD2zY32TxbNO83mB6zCatekaG2tvrJJ22TwfnOx5ZSHNv/Bv08RPi08w+QKaXp8GfbmeHR
        fl20t1k+GrRYFndA00YWb1b5IGjot8fLyyEIxX76nILvkc2svFyxZmAP0nvsQ4hf2NUVC2
        uE903qUvE3xkoSXgOCFiWkKJr/1BfPRTU7SOuFy0ZE+kDhvwG2n5HOA+MILX4e1iqD5tX6
        E48q2UDINNkeTS3SRdvUfqp8XVl82tRVzfd4F8yIhkqdHPsjg4aBSk38NkPTKBjupv4S2M
        SAKcY4/E3U/S/a7Cnbk32FAD7LVaGeGXeNQ0PXJyPLLlJQC9IenfXH2ISVhDZw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C44BB215;
        Thu, 17 Sep 2020 12:12:49 +0000 (UTC)
Date:   Thu, 17 Sep 2020 14:12:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
Message-ID: <20200917121213.GC29887@dhcp22.suse.cz>
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200914143312.GU16999@dhcp22.suse.cz>
 <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
 <20200915081832.GA4649@dhcp22.suse.cz>
 <53dd1e2c-f07e-ee5b-51a1-0ef8adb53926@linux.microsoft.com>
 <20200916065306.GB18998@dhcp22.suse.cz>
 <32b73685-48f2-b6dd-f000-8ea52cfee70a@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32b73685-48f2-b6dd-f000-8ea52cfee70a@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-09-20 11:28:40, Vijay Balakrishna wrote:
[...]
> OOM splat below.  I see we had kmem leak detection turned on here.  We
> haven't run stress with kmem leak detection since uncovereing low
> min_free_kbytes.  During investigation we wanted to make sure there is no
> kmem leaks, we didn't find significant leaks detected.
> 
> [330319.766059] systemd invoked oom-killer:
> gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=1, oom_score_adj=0

[...]
> [330319.861064] Mem-Info:
> [330319.863519] active_anon:60744 inactive_anon:109226 isolated_anon:0
>                  active_file:6418 inactive_file:3869 isolated_file:2
>                  unevictable:0 dirty:8 writeback:1 unstable:0
>                  slab_reclaimable:34660 slab_unreclaimable:795718
>                  mapped:1256 shmem:165765 pagetables:689 bounce:0
>                  free:340962 free_pcp:4672 free_cma:0

The memory consumption is predominantely in slab (unreclaimable). Only
~8% of the memory is on LRUs (anonymous + file). Slab (both reclaimable
and unreclaimable) is ~40%. So there is still a lot of memory
unaccounted (direct users of the page allocator). This would partially
explain why the oom killer is not able to make progress and eventually
panics because it is the kernel which is blowing the memory consumption.

There is still ~1G free memory but the problem is that this is a
GFP_KERNEL request which is not allowed to consume Movable memory.
Zone normal is depleted and therefore it cannot satisfy this request
even when there are some order-1 pages available.

> [330319.928124] Node 0 Normal free:12652kB min:14344kB low:19092kB=20
> high:23840kB active_anon:55340kB inactive_anon:60276kB active_file:60kB
> inactive_file:128kB unevictable:0kB writepending:4kB present:6220656kB
> managed:4750196kB mlocked:0kB kernel_stack:9568kB pagetables:2756kB
> bounce:0kB free_pcp:10056kB local_pcp:1376kB free_cma:0kB
[...]
> [330319.996879] Node 0 Normal: 3138*4kB (UME) 38*8kB (UM) 0*16kB 0*32kB
> 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12856kB

I do not see the state of swap in the oom splat so I assume you have
swap disabled. If that is the case then the memory reclaim cannot really
do much for this request. There is almost no page cache to reclaim.

That being said I do not see how a increased min_free_kbytes could help
for this particular OOM situation. If there is really any relation it is
more of a unintended side effect.

[...]
> > > Extreme values can damage your system. Setting min_free_kbytes to an
> > > extremely low value prevents the system from reclaiming memory, which can
> > > result in system hangs and OOM-killing processes. However, setting
> > > min_free_kbytes too high (for example, to 5–10% of total system memory)
> > > causes the system to enter an out-of-memory state immediately, resulting in
> > > the system spending too much time reclaiming memory.
> > 
> > The auto tuned value should never reach such a low value to cause
> > problems.
> 
> The auto tuned value is incorrect post hotplug memory operation, in our use
> case memoy hot add occurs very early during boot.
 
Define incorrect. What are the actual values? Have you tried to increase
the value manually after the hotplug?

-- 
Michal Hocko
SUSE Labs
