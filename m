Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50ED2FCC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbhATH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:56:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:35846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbhATHys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:54:48 -0500
IronPort-SDR: TV6Lj900pyLmdo/66O7/cWCmG6nA3Z4aiySvaE9+xWczp5mSGhey50aUkhBo1HrVa2m+V6XJne
 EWFkOzoMj+jQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="240600750"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="240600750"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 23:54:07 -0800
IronPort-SDR: TToS1xbmD5KXL6u7aIH++681gRiINd4wSqoCGaIChWKbqYfrMcC0DuWnfRuxuBZ+2wJ5mQc7Hp
 d0OCr7xmDUuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="466995394"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.145])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 23:54:04 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swap: Check nrexceptional of swap cache before being freed
References: <20210120072711.209099-1-ying.huang@intel.com>
        <20210120074652.GA9371@dhcp22.suse.cz>
Date:   Wed, 20 Jan 2021 15:54:04 +0800
In-Reply-To: <20210120074652.GA9371@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 20 Jan 2021 08:46:52 +0100")
Message-ID: <87v9bst55v.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 20-01-21 15:27:11, Huang Ying wrote:
>> To catch the error in updating the swap cache shadow entries or their count.
>
> What is the error?

There's no error in the current code.  But we will change the related
code in the future.  So this checking will help us to prevent error in
the future.  I will change the patch description to make it more clear.

> Can it happens in the real life? Why do we need this
> patch? Is crashing the kernel the right way to handle the situation?

Emm... The mistake to update swap shadow entries will hurt performance,
but will not trigger functionality bug.  So it may be better to use
VM_WARN_ON_ONCE().

Best Regards,
Huang, Ying


>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
>> Cc: Johannes Weiner <hannes@cmpxchg.org>,
>> Cc: Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
>> Cc: Mel Gorman <mgorman@techsingularity.net>,
>> Cc: Michal Hocko <mhocko@kernel.org>,
>> Cc: Dan Williams <dan.j.williams@intel.com>,
>> Cc: Christoph Hellwig <hch@lst.de>, Ilya Dryomov <idryomov@gmail.com>,
>> ---
>>  mm/swap_state.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index d0d417efeecc..240a4f97594a 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -703,7 +703,12 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
>>  
>>  void exit_swap_address_space(unsigned int type)
>>  {
>> -	kvfree(swapper_spaces[type]);
>> +	int i;
>> +	struct address_space *spaces = swapper_spaces[type];
>> +
>> +	for (i = 0; i < nr_swapper_spaces[type]; i++)
>> +		VM_BUG_ON(spaces[i].nrexceptional);
>> +	kvfree(spaces);
>>  	nr_swapper_spaces[type] = 0;
>>  	swapper_spaces[type] = NULL;
>>  }
>> -- 
>> 2.29.2
