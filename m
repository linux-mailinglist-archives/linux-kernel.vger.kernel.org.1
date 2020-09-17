Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5F26E754
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIQVXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:23:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:61846 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgIQVXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:23:40 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 17:23:40 EDT
IronPort-SDR: T0Na8pX+NOmc8zlK6qBBzuWuwjH3Zmpd2JFsjqshrKYAUy9VBxkYqn0M1PsG+/gvO3A3llvZL1
 78Y15QuDthLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147542843"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="147542843"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:16:32 -0700
IronPort-SDR: 7CENmsfUyVNTB/c/ycqvMjEwYhH/7xKDggIpJMzOn7Ts2EC8GErquhceAUhFPMtO+Gf0RAb+j1
 vvRsy9hdOJBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="507893687"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 17 Sep 2020 14:16:31 -0700
Received: from [10.251.12.27] (kliang2-MOBL.ccr.corp.intel.com [10.251.12.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 00EEE5807C9;
        Thu, 17 Sep 2020 14:16:29 -0700 (PDT)
Subject: Re: [PATCH V7 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Dave Hansen <dave.hansen@intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        kirill.shutemov@linux.intel.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
References: <20200917135237.2857-1-kan.liang@linux.intel.com>
 <20200917135237.2857-2-kan.liang@linux.intel.com>
 <13427458-3934-1490-68bb-071be2ae01da@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <40234c70-720e-9c0d-1fc2-ac23c0acf721@linux.intel.com>
Date:   Thu, 17 Sep 2020 17:16:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <13427458-3934-1490-68bb-071be2ae01da@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2020 3:00 PM, Dave Hansen wrote:
> On 9/17/20 6:52 AM, kan.liang@linux.intel.com wrote:
>> +	mm = current->mm;
>> +	if (!mm) {
>> +		/*
>> +		 * For kernel threads and the like, use init_mm so that
>> +		 * we can find kernel memory.
>> +		 */
>> +		mm = &init_mm;
>> +	}
> 
> I think it might be better to use current->active_mm instead of
> current->mm.  Kernel threads can "take over" the mm of the threads that
> switched to them, so they're not actually using all of the page tables
> from the init_mm all the time.
> 
> It's not _common_, thought.  The only time that I think they can diverge
> is when vmalloc PGD sync'ing needs to be done, and there's even an
> effort to remove that.
> 
> But, it's probably more more precise to just use ->active_mm since
> that's what will actually be more consistent with the values loaded into
> CR3.
> 
> I _think_ ->active_mm is always non-NULL, too.
>

Thanks. yes, active_mm looks better here. I will use active_mm to 
replace the mm and &init_mm.

> One last concern as I look at this: I wish it was a bit more
> future-proof.  There are lots of weird things folks are trying to do
> with the page tables, like Address Space Isolation.  For instance, if
> you get a perf NMI when running userspace, current->mm->pgd is
> *different* than the PGD that was in use when userspace was running.
> It's close enough today, but it might not stay that way.  But I can't
> think of any great ways to future proof this code, other than spitting
> out an error message if too many of the page table walks fail when they
> shouldn't.
> 

If the page table walks fail, page size 0 will return. So the worst case 
is that the page size is not available for users, which is not a fatal 
error.

If my understanding is correct, when the above case happens, there is 
nothing we can do for now (because we have no idea what it will become), 
except disabling the page size support and throw an error/warning.

 From the user's perspective, throwing an error message or marking the 
page size unavailable should be the same. I think we may leave the code 
as-is. We can fix the future case later separately.

Thanks,
Kan
