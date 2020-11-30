Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E162C8044
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgK3ItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:49:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:33348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgK3ItI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:49:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606726101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ts1SlZ5Kb9agqt+MNolM33QUi9fKSB+A4isf8i7vob4=;
        b=sxT61S95dX4v0Rxx7yRNohGN8JYykb2qodCV0vNL1NBr1J1bYuqL6h5tZWj4AjgXULtN79
        V8DzWHIkfFr6co9IBCU1ym2qKY29LMgbmnxSeS1rfBhj3942plZuKYy+a4E4dRbWDvbNxb
        XBmDv4/zIjR2DoxoTVcqU7huHVm9AaM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 935D1AC95;
        Mon, 30 Nov 2020 08:48:21 +0000 (UTC)
Date:   Mon, 30 Nov 2020 09:48:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@intel.com, ying.huang@intel.com,
        andi.kleen@intel.com
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
Message-ID: <20201130084820.GB17338@dhcp22.suse.cz>
References: <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
 <20201104081546.GB10052@dhcp22.suse.cz>
 <20201112122844.GA11000@shbuild999.sh.intel.com>
 <20201112141654.GC12240@dhcp22.suse.cz>
 <20201113073436.GA113119@shbuild999.sh.intel.com>
 <20201120114424.GA103521@shbuild999.sh.intel.com>
 <20201125062445.GA51005@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125062445.GA51005@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-11-20 14:24:45, Feng Tang wrote:
[...]
> I think we finally found the trick :), further debugging shows it
> is not related to the alignment inside one cacheline, but the
> adjacency of 2 adjacent cacheliens (2N and 2N+1, one pair of 128 bytes).
> 
> For structure mem_cgroup, member 'vmstats_local', 'vmstats_percpu'
> sit in one cacheline, while 'vmstats[]' sits in the next cacheline,
> and when 'adjacent cacheline prefetch" is enabled, if these 2 lines
> sit in one pair (128 btyes), say 2N and 2N+1, then there seems to
> be some kind of false sharing, and if they sit in 2 pairs, say
> 2N-1 and 2N then it's fine.
> 
> And with the following patch to relayout these members, the regression
> is restored and event better. while reducing 64 bytes of sizeof
> 'struct mem_cgroup'
> 
> 	parent_commit	Waiman's_commit		+relayout patch
> 
> result	187K		145K			200K
> 
> Also, if we disable the hw prefetch feature, the Waiman's commit
> and its parent commit will have no performance difference.
> 
> Thanks,
> Feng
> 
> >From 2e63af34fa4853b2dd9669867c37a3cf07f7a505 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Wed, 25 Nov 2020 13:22:21 +0800
> Subject: [PATCH] mm: memcg: relayout structure mem_cgroup to avoid cache
>  interfereing
> 
> 0day reported one -22.7% regression for will-it-scale page_fault2
> case [1] on a 4 sockets 144 CPU platform, and bisected to it to be
> caused by Waiman's optimization (commit bd0b230fe1) of saving one
> 'struct page_counter' space for 'struct mem_cgroup'.
> 
> Initially we thought it was due to the cache alignment change introduced
> by the patch, but further debug shows that it is due to some hot data
> members ('vmstats_local', 'vmstats_percpu', 'vmstats') sit in 2 adjacent
> cacheline (2N and 2N+1 cacheline), and when adjacent cache line prefetch
> is enabled, it triggers an "extended level" of cache false sharing for
> 2 adjacent cache lines.
> 
> So exchange the 2 member blocks, while keeping mostly the original
> cache alignment, which can restore and even enhance the performance,
> and save 64 bytes of space for 'struct mem_cgroup' (from 2880 to 2816,
> with 0day's default RHEL-8.3 kernel config)
> 
> [1]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> 
> Fixes: bd0b230fe145 ("mm/memcg: unify swap and memsw page counters")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Sorry for a late reply. This is indeed surprising! I was really
expecting page counter to be the culprit. Anyway this rearrangement 
looks ok as well. moving_account related stuff is still after padding
which is good because this rare operation shouldn't really interfere
with the rest of the structure. Btw. now you made me look into the
history and I have noticed e81bf9793b18 ("mem_cgroup: make sure
moving_account, move_lock_task and stat_cpu in the same cacheline") so
this is not the first time we are dealing with a regression here.

Linus has already merged the patch but for the record
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks a lot for pursuing this!

-- 
Michal Hocko
SUSE Labs
