Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197782A5ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgKDHib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:38:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:46629 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgKDHia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:38:30 -0500
IronPort-SDR: S+oqRQZw/RNEDkkEscSVwKdMnHQMjcBt6KB3K6lVSf31iPYaKhIESFWEC9iA2e6nwrKNn1f2gy
 bdw8gB/9b9VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="166588585"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="166588585"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 23:38:29 -0800
IronPort-SDR: u89hwRaUEsfKRGPc8AYg8bExJWNvym2UgFlbu8aAIna32R+DXsaUtej9cZ9klzR6N6Eoy11v1B
 WkxmkwXE1zMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="538805719"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by orsmga005.jf.intel.com with ESMTP; 03 Nov 2020 23:38:27 -0800
Date:   Wed, 4 Nov 2020 15:38:26 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201104073826.GA15700@shbuild999.sh.intel.com>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
 <20201104071308.GN21990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104071308.GN21990@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thanks for the prompt review!

On Wed, Nov 04, 2020 at 08:13:08AM +0100, Michal Hocko wrote:
> On Wed 04-11-20 14:10:08, Feng Tang wrote:
> > Hi,
> > 
> > This patchset tries to report a problem and get suggestion/review
> > for the RFC fix patches.
> > 
> > We recently got a OOM report, that when user try to bind a docker(container)
> > instance to a memory node which only has movable zones, and OOM killing
> > still can't solve the page allocation failure.
> 
> This is a cpuset node binding right?

Yes.

A simple test command is 'docker run -it --cpuset-mems 3 ubuntu:latest'
while the node 3 is a movable only PMEM node.
 
> > The callstack was:
> > 
> > 	[ 1387.877565] runc:[2:INIT] invoked oom-killer: gfp_mask=0x500cc2(GFP_HIGHUSER|__GFP_ACCOUNT), order=0, oom_score_adj=0
> > 	[ 1387.877568] CPU: 8 PID: 8291 Comm: runc:[2:INIT] Tainted: G        W I E     5.8.2-0.g71b519a-default #1 openSUSE Tumbleweed (unreleased)
> > 	[ 1387.877569] Hardware name: Dell Inc. PowerEdge R640/0PHYDR, BIOS 2.6.4 04/09/2020
> > 	[ 1387.877570] Call Trace:
> > 	[ 1387.877579]  dump_stack+0x6b/0x88
> > 	[ 1387.877584]  dump_header+0x4a/0x1e2
> > 	[ 1387.877586]  oom_kill_process.cold+0xb/0x10
> > 	[ 1387.877588]  out_of_memory.part.0+0xaf/0x230
> > 	[ 1387.877591]  out_of_memory+0x3d/0x80
> > 	[ 1387.877595]  __alloc_pages_slowpath.constprop.0+0x954/0xa20
> > 	[ 1387.877599]  __alloc_pages_nodemask+0x2d3/0x300
> > 	[ 1387.877602]  pipe_write+0x322/0x590
> > 	[ 1387.877607]  new_sync_write+0x196/0x1b0
> > 	[ 1387.877609]  vfs_write+0x1c3/0x1f0
> > 	[ 1387.877611]  ksys_write+0xa7/0xe0
> > 	[ 1387.877617]  do_syscall_64+0x52/0xd0
> > 	[ 1387.877621]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > The meminfo log only shows the movable only node, which has plenty
> > of free memory. And in our reproducing with 1/2 patch, the normal
> > node (has DMA/DMA32/Normal) also has lot of free memory when OOM
> > happens. 
> 
> OK, so you are bidning to a movable node only and your above request is
> for GFP_HIGHUSER which _cannot_ be satisfied from the movable zones
> because that memory is not movable. So the system behaves as expected.
> Your cpuset is misconfigured IMHO. Movable only nodes come with their
> risk and configuration price.

Aha, this is what we told the reporter at first. Their platform is 2S
platform, and each socket has one DRAM node + one persistent memory node,
and we suggested to bind the docker to one DRAM + one PMEM node.

> > If we hack to make this (GFP_HIGHUSER|__GFP_ACCOUNT) request get
> > a page, and following full docker run (like installing and running
> > 'stress-ng' stress test) will see more allocation failures due to
> > different kinds of request(gfp_masks). And the 2/2 patch will detect
> > such cases that the allowed target nodes only have movable zones
> > and loose the binding check, otherwise it will trigger OOM while
> > the OOM won't do any help, as the problem is not lack of free memory.
> 
> Well, this breaks the cpuset containment, right? I consider this quite
> unexpected for something that looks like a misconfiguration. I do agree
> that this is unexpected for anybody who is not really familiar with
> concept of movable zone but we should probably call out all these
> details rather than tweak the existing semantic.

Yes, it does break the cpuset containment 

> Could you be more specific about the usecase here? Why do you need a
> binding to a pure movable node? 

One common configuration for a platform is small size of DRAM plus huge
size of PMEM (which is slower but cheaper), and my guess of their use
is to try to lead the bulk of user space allocation (GFP_HIGHUSER_MOVABLE)
to PMEM node, and only let DRAM be used as less as possible. 

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
