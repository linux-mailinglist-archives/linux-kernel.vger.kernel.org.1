Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD62A5E9D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgKDHNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:13:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:48326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgKDHNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:13:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604473989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsjH1E5DijPHY6nY3sdqh/ChEhsyzrkj4mfYkA65SOw=;
        b=kwofc55HbttsR4GFljHPnicdRTMPd4AUo7kwLMVK7OmY/QDBgJkz8XLjjzZN9cYy03b3CQ
        MlR9CrfwWqLrvDoHY5gqO5riVrY0ihGZjeAJEL3Y/Qf6l2TvHp2lxN/iJIDeFstyP89ZK5
        jT1ktuP69L+BrHgNuIJ2PeaMn4n3Sh0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1A05AC65;
        Wed,  4 Nov 2020 07:13:08 +0000 (UTC)
Date:   Wed, 4 Nov 2020 08:13:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201104071308.GN21990@dhcp22.suse.cz>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-11-20 14:10:08, Feng Tang wrote:
> Hi,
> 
> This patchset tries to report a problem and get suggestion/review
> for the RFC fix patches.
> 
> We recently got a OOM report, that when user try to bind a docker(container)
> instance to a memory node which only has movable zones, and OOM killing
> still can't solve the page allocation failure.

This is a cpuset node binding right?

> The callstack was:
> 
> 	[ 1387.877565] runc:[2:INIT] invoked oom-killer: gfp_mask=0x500cc2(GFP_HIGHUSER|__GFP_ACCOUNT), order=0, oom_score_adj=0
> 	[ 1387.877568] CPU: 8 PID: 8291 Comm: runc:[2:INIT] Tainted: G        W I E     5.8.2-0.g71b519a-default #1 openSUSE Tumbleweed (unreleased)
> 	[ 1387.877569] Hardware name: Dell Inc. PowerEdge R640/0PHYDR, BIOS 2.6.4 04/09/2020
> 	[ 1387.877570] Call Trace:
> 	[ 1387.877579]  dump_stack+0x6b/0x88
> 	[ 1387.877584]  dump_header+0x4a/0x1e2
> 	[ 1387.877586]  oom_kill_process.cold+0xb/0x10
> 	[ 1387.877588]  out_of_memory.part.0+0xaf/0x230
> 	[ 1387.877591]  out_of_memory+0x3d/0x80
> 	[ 1387.877595]  __alloc_pages_slowpath.constprop.0+0x954/0xa20
> 	[ 1387.877599]  __alloc_pages_nodemask+0x2d3/0x300
> 	[ 1387.877602]  pipe_write+0x322/0x590
> 	[ 1387.877607]  new_sync_write+0x196/0x1b0
> 	[ 1387.877609]  vfs_write+0x1c3/0x1f0
> 	[ 1387.877611]  ksys_write+0xa7/0xe0
> 	[ 1387.877617]  do_syscall_64+0x52/0xd0
> 	[ 1387.877621]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The meminfo log only shows the movable only node, which has plenty
> of free memory. And in our reproducing with 1/2 patch, the normal
> node (has DMA/DMA32/Normal) also has lot of free memory when OOM
> happens. 

OK, so you are bidning to a movable node only and your above request is
for GFP_HIGHUSER which _cannot_ be satisfied from the movable zones
because that memory is not movable. So the system behaves as expected.
Your cpuset is misconfigured IMHO. Movable only nodes come with their
risk and configuration price.

> If we hack to make this (GFP_HIGHUSER|__GFP_ACCOUNT) request get
> a page, and following full docker run (like installing and running
> 'stress-ng' stress test) will see more allocation failures due to
> different kinds of request(gfp_masks). And the 2/2 patch will detect
> such cases that the allowed target nodes only have movable zones
> and loose the binding check, otherwise it will trigger OOM while
> the OOM won't do any help, as the problem is not lack of free memory.

Well, this breaks the cpuset containment, right? I consider this quite
unexpected for something that looks like a misconfiguration. I do agree
that this is unexpected for anybody who is not really familiar with
concept of movable zone but we should probably call out all these
details rather than tweak the existing semantic.

Could you be more specific about the usecase here? Why do you need a
binding to a pure movable node? 
-- 
Michal Hocko
SUSE Labs
