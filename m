Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CC6275033
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgIWFNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:13:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:43015 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgIWFNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:13:51 -0400
IronPort-SDR: 7rKLNpeg5Dyww1fNIImmEYY/cQPR+Z/Yh5gyZDw5xsuLAXTD2joJ1LtbXTiXgx9SnmOMhSyFWa
 n93ugt2SWmOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="148536163"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="148536163"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 22:13:51 -0700
IronPort-SDR: fWVFHrh3jdQi9TBRy84Y2llMI6nY6Ouqo+qrEMKnJVDKK5/C8PJ0+HcIEsi4HKK1fndVeJmvts
 K9Ux9TLOeDzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="305232785"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.164])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2020 22:13:50 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
References: <20200922184838.978540-1-aquini@redhat.com>
        <878sd1qllb.fsf@yhuang-dev.intel.com>
        <20200923043459.GL795820@optiplex-lnx>
Date:   Wed, 23 Sep 2020 13:13:49 +0800
In-Reply-To: <20200923043459.GL795820@optiplex-lnx> (Rafael Aquini's message
        of "Wed, 23 Sep 2020 00:34:59 -0400")
Message-ID: <87sgb9oz1u.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Aquini <aquini@redhat.com> writes:

> On Wed, Sep 23, 2020 at 10:21:36AM +0800, Huang, Ying wrote:
>> Hi, Rafael,
>> 
>> Rafael Aquini <aquini@redhat.com> writes:
>> 
>> > The swap area descriptor only gets struct swap_cluster_info *cluster_info
>> > allocated if the swapfile is backed by non-rotational storage.
>> > When the swap area is laid on top of ordinary disk spindles, lock_cluster()
>> > will naturally return NULL.
>> 
>> Thanks for reporting.  But the bug looks strange.  Because in a system
>> with only HDD swap devices, during THP swap out, the swap cluster
>> shouldn't be allocated, as in
>> 
>> shrink_page_list()
>>   add_to_swap()
>>     get_swap_page()
>>       get_swap_pages()
>>         swap_alloc_cluster()
>>
>
> The underlying problem is that swap_info_struct.cluster_info is always NULL 
> on the rotational storage case.

Yes.

> So, it's very easy to follow that constructions 
> like this one, in split_swap_cluster 
>
> ...
>         ci = lock_cluster(si, offset);
>         cluster_clear_huge(ci);
> ...
>
> will go for a NULL pointer dereference, in that case, given that lock_cluster 
> reads:
>
> ...
> 	struct swap_cluster_info *ci;
>         ci = si->cluster_info;
>         if (ci) {
>                 ci += offset / SWAPFILE_CLUSTER;
>                 spin_lock(&ci->lock);
>         }
>         return ci;
> ...

But on HDD, we shouldn't call split_swap_cluster() at all, because we
will not allocate swap cluster firstly.  So, if we run into this,
there should be some other bug, we need to figure it out.

Best Regards,
Huang, Ying
