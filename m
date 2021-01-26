Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB4303A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404041AbhAZKZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:25:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:10854 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbhAZB3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:29:48 -0500
IronPort-SDR: 1QTFv+R7FBFqXBzBTm4rZLDFSor4822j9ERpl0WIhdWGzhl4mrhd/UoUGcWDaVpkvzEwocG60/
 VPGtZIiUF1ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="241357462"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="241357462"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:30 -0800
IronPort-SDR: Vl5O5lRyuX+4dPcq04mBs0y4dhKi+CBikSSu35wxdEQDo6WnKFzvdlF4f87Lz8ePxEZM9DObEv
 PcCH+93JCJTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="393571480"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2021 16:41:30 -0800
Subject: [RFC][PATCH 00/13] [v5] Migrate Pages in lieu of discard
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:11 -0800
Message-Id: <20210126003411.2AC51464@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The full series is also available here:

	https://github.com/hansendc/linux/tree/automigrate-20210122

The meat of this patch is in:

	[PATCH 08/13] mm/migrate: demote pages during reclaim

Which also has the most changes since the last post.  This version is
mostly to address review comments from Yang Shi and Oscar Salvador.
Review comments are documented in the individual patch changelogs.

This also contains a few prerequisite patches that fix up an issue
with the vm.zone_reclaim_mode sysctl ABI.

--

We're starting to see systems with more and more kinds of memory such
as Intel's implementation of persistent memory.

Let's say you have a system with some DRAM and some persistent memory.
Today, once DRAM fills up, reclaim will start and some of the DRAM
contents will be thrown out.  Allocations will, at some point, start
falling over to the slower persistent memory.

That has two nasty properties.  First, the newer allocations can end
up in the slower persistent memory.  Second, reclaimed data in DRAM
are just discarded even if there are gobs of space in persistent
memory that could be used.

This set implements a solution to these problems.  At the end of the
reclaim process in shrink_page_list() just before the last page
refcount is dropped, the page is migrated to persistent memory instead
of being dropped.

While I've talked about a DRAM/PMEM pairing, this approach would
function in any environment where memory tiers exist.

This is not perfect.  It "strands" pages in slower memory and never
brings them back to fast DRAM.  Other things need to be built to
promote hot pages back to DRAM.

This is also all based on an upstream mechanism that allows
persistent memory to be onlined and used as if it were volatile:

	http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com

== Open Issues ==

 * For cpusets and memory policies that restrict allocations
   to PMEM, is it OK to demote to PMEM?  Do we need a cgroup-
   level API to opt-in or opt-out of these migrations?

--

Changes since (automigrate-20200818):
 * Fall back to normal reclaim when demotion fails
 * Fix some compile issues, when page migration and NUMA are off

Changes since (automigrate-20201007):
 * separate out checks for "can scan anon LRU" from "can actually
   swap anon pages right now".  Previous series conflated them
   and may have been overly aggressive scanning LRU
 * add MR_DEMOTION to tracepoint header
 * remove unnecessary hugetlb page check

Changes since (https://lwn.net/Articles/824830/):
 * Use higher-level migrate_pages() API approach from Yang Shi's
   earlier patches.
 * made sure to actually check node_reclaim_mode's new bit
 * disabled migration entirely before introducing RECLAIM_MIGRATE
 * Replace GFP_NOWAIT with explicit __GFP_KSWAPD_RECLAIM and
   comment why we want that.
 * Comment on effects of that keep multiple source nodes from
   sharing target nodes

Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
Cc: Huang Ying <ying.huang@intel.com>

