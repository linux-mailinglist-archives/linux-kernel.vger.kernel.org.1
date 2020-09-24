Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A3B276773
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 05:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIXDvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 23:51:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:9325 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgIXDvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 23:51:20 -0400
IronPort-SDR: v9G9PJcYY0+oVFFsA4TAdMnlsG+v5GMkPkzwdRWrKtCtv+f2R8WdJ7/L0CsJ8UWutW0mpF2rjG
 1/TYexz65wyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="222669056"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="222669056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 20:51:20 -0700
IronPort-SDR: /vdPfafdgz10DNSJUl57elBKogSPucIkbKjcXpCfEiLS9x1pZggY8NCPz8TsTriZMaOyZUpYeh
 tsX1C/EYEWVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="511430514"
Received: from unknown (HELO yhuang-dev) ([10.239.159.65])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2020 20:51:18 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
In-Reply-To: <20200924020928.GC1023012@optiplex-lnx> (Rafael Aquini's message
        of "Wed, 23 Sep 2020 22:09:28 -0400")
References: <20200922184838.978540-1-aquini@redhat.com>
        <878sd1qllb.fsf@yhuang-dev.intel.com>
        <20200923043459.GL795820@optiplex-lnx>
        <87sgb9oz1u.fsf@yhuang-dev.intel.com>
        <20200923130138.GM795820@optiplex-lnx>
        <87blhwng5f.fsf@yhuang-dev.intel.com>
        <20200924020928.GC1023012@optiplex-lnx>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Thu, 24 Sep 2020 11:51:17 +0800
Message-ID: <877dsjessq.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Aquini <aquini@redhat.com> writes:
> The bug here is quite simple: split_swap_cluster() misses checking for
> lock_cluster() returning NULL before committing to change cluster_info->flags.

I don't think so.  We shouldn't run into this situation firstly.  So the
"fix" hides the real bug instead of fixing it.  Just like we call
VM_BUG_ON_PAGE(!PageLocked(head), head) in split_huge_page_to_list()
instead of returning if !PageLocked(head) silently.

> The fundamental problem has nothing to do with allocating, or not allocating
> a swap cluster, but it has to do with the fact that the THP deferred split scan
> can transiently race with swapcache insertion, and the fact that when you run
> your swap area on rotational storage cluster_info is _always_ NULL.
> split_swap_cluster() needs to check for lock_cluster() returning NULL because
> that's one possible case, and it clearly fails to do so.

If there's a race, we should fix the race.  But the code path for
swapcache insertion is,

add_to_swap()
  get_swap_page() /* Return if fails to allocate */
  add_to_swap_cache()
    SetPageSwapCache()

While the code path to split THP is,

split_huge_page_to_list()
  if PageSwapCache()
    split_swap_cluster()

Both code paths are protected by the page lock.  So there should be some
other reasons to trigger the bug.

And again, for HDD, a THP shouldn't have PageSwapCache() set at the
first place.  If so, the bug is that the flag is set and we should fix
the setting.

> Run a workload that cause multiple THP COW, and add a memory hogger to create
> memory pressure so you'll force the reclaimers to kick the registered
> shrinkers. The trigger is not heavy swapping, and that's probably why
> most swap test cases don't hit it. The window is tight, but you will get the
> NULL pointer dereference.

Do you have a script to reproduce the bug?

> Regardless you find furhter bugs, or not, this patch is needed to correct a
> blunt coding mistake.

As above.  I don't agree with that.

Best Regards,
Huang, Ying
