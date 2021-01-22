Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6762FF92F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbhAVADO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:03:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:23155 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbhAVACt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:02:49 -0500
IronPort-SDR: CtJmk/nv8AHC7EdImCC3KhAhpjIAE0Y4I/TXk7QywW9dHmixTYZSuy/CKm6hnLjV1QeLUJTmPT
 QTluO2m0/T8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="178587193"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="178587193"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 16:02:03 -0800
IronPort-SDR: KCvw4PqwOBIcWa30wlCRaTqttJD7zB98M0tE180MBEv2A3k0NzMy965qQhuVoIjcB35cf17saJ
 jrOaM++QqVhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="356707657"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.145])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2021 16:02:01 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swap: Check nrexceptional of swap cache before being freed
References: <20210120072711.209099-1-ying.huang@intel.com>
        <20210121184456.GB4127393@casper.infradead.org>
Date:   Fri, 22 Jan 2021 08:02:00 +0800
In-Reply-To: <20210121184456.GB4127393@casper.infradead.org> (Matthew Wilcox's
        message of "Thu, 21 Jan 2021 18:44:56 +0000")
Message-ID: <87pn1xsutj.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Jan 20, 2021 at 03:27:11PM +0800, Huang Ying wrote:
>> To catch the error in updating the swap cache shadow entries or their count.
>
> I just resent a patch that removes nrexceptional tracking.
>
> Can you use !mapping_empty() instead?

Sure.  Will use that in the next version.

Best Regards,
Huang, Ying

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
>> 
>> 
