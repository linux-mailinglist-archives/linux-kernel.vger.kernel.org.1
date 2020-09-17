Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD64026E7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIQV6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:58:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:37620 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIQV6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:58:34 -0400
IronPort-SDR: Wp70aLAER7WXO5lZ2rD3tA3IATmTKwn8GMAzjBDdkJatDxGbalcIaFCxblKQ1oGRIwK5c/x4lC
 o7azx8gTDlwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157199024"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="157199024"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:58:30 -0700
IronPort-SDR: Ca8Hem+FxDJNoV9dVI/jkRUmPoYnRxHZpv/JuB6Y3NSln1D3PxhnBSoOUiN5eerlkrNmFDOcjY
 dUtH7qk/smVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="339583464"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 17 Sep 2020 14:58:29 -0700
Received: from [10.251.12.27] (kliang2-MOBL.ccr.corp.intel.com [10.251.12.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9163C580699;
        Thu, 17 Sep 2020 14:58:28 -0700 (PDT)
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
 <40234c70-720e-9c0d-1fc2-ac23c0acf721@linux.intel.com>
 <04f59f3b-2e53-8774-8333-63dfc5b8e6a9@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <0e2cd6e4-8016-ccf6-eaff-2b304cf966ee@linux.intel.com>
Date:   Thu, 17 Sep 2020 17:58:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <04f59f3b-2e53-8774-8333-63dfc5b8e6a9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2020 5:24 PM, Dave Hansen wrote:
> On 9/17/20 2:16 PM, Liang, Kan wrote:
>>> One last concern as I look at this: I wish it was a bit more
>>> future-proof.  There are lots of weird things folks are trying to do
>>> with the page tables, like Address Space Isolation.  For instance, if
>>> you get a perf NMI when running userspace, current->mm->pgd is
>>> *different* than the PGD that was in use when userspace was running.
>>> It's close enough today, but it might not stay that way.  But I can't
>>> think of any great ways to future proof this code, other than spitting
>>> out an error message if too many of the page table walks fail when they
>>> shouldn't.
>>>
>>
>> If the page table walks fail, page size 0 will return. So the worst case
>> is that the page size is not available for users, which is not a fatal
>> error.
> 
> Right, it's not a fatal error.  It will just more or less silently break
> this feature.
> 
>> If my understanding is correct, when the above case happens, there is
>> nothing we can do for now (because we have no idea what it will become),
>> except disabling the page size support and throw an error/warning.
>>
>>  From the user's perspective, throwing an error message or marking the
>> page size unavailable should be the same. I think we may leave the code
>> as-is. We can fix the future case later separately.
> 
> The only thing I can think of is to record the number of consecutive
> page walk errors without a success.  Occasional failures are OK and
> expected, such as if reclaim zeroes a PTE and a later perf event goes
> and looks at it.  But a *LOT* of consecutive errors indicates a real
> problem somewhere.
> 
> Maybe if you have 10,000 or 1,000,000 successive walk failures, you do a
> WARN_ON_ONCE().

The user space perf tool looks like a better place for this kind of 
warning. The perf tool knows the total number of the samples. It also 
knows the number of the page size 0 samples. We can set a threshold, 
e.g., 90%. If 90% of the samples have the page size 0, perf tool will 
throw out a warning message.

The problem is that the warning from the perf tool usually includes some 
hints regarding the cause of the warning or possible solution to 
workaround/fix the warning. What message should we deliver to the users?
"Warning: Too many error page size. Address space isolation feature may 
be enabled, please check"?


Thanks,
Kan

