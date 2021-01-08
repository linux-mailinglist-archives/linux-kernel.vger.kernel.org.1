Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE82EEA14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbhAHABv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:01:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:14571 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbhAHABu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:01:50 -0500
IronPort-SDR: y3pvJRvcja4b/As7ZPsneiUrehH6aiaXGFLUjlT5pbr7bVCau3opOL5A3HNSPg4nPQi1ZHhe+0
 lfaOQgaz+kZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="165206445"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="165206445"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 16:00:04 -0800
IronPort-SDR: 6JFQMRWF/KBXXX0hd/QgIrgA7QCfQXw80JWsEERH3iTsHJHY72M1OCYy4cu7O0i0qi74F2aSQI
 XHWEnKaPTtcA==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="379909949"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.31.120]) ([10.255.31.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 16:00:02 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/vt-d: Remove unused dma map/unmap trace events
To:     Will Deacon <will@kernel.org>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-3-baolu.lu@linux.intel.com>
 <20210105190443.GB12182@willie-the-truck>
 <8bf33c93-3154-e832-1197-891c684d6ded@linux.intel.com>
 <20210107144049.GB3413@willie-the-truck>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ab546a36-2403-f400-a354-edfd21795e0d@linux.intel.com>
Date:   Fri, 8 Jan 2021 08:00:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107144049.GB3413@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2021/1/7 22:40, Will Deacon wrote:
> On Wed, Jan 06, 2021 at 09:14:22AM +0800, Lu Baolu wrote:
>> On 2021/1/6 3:04, Will Deacon wrote:
>>> On Thu, Dec 31, 2020 at 08:53:21AM +0800, Lu Baolu wrote:
>>>> With commit c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to
>>>> the iommu ops"), the trace events for dma map/unmap have no users any
>>>> more. Remove them so that they don't show up under
>>>> /sys/kernel/debug/tracing/events/intel_iommu. The users should use the
>>>> map/unmap traces defined in the iommu core from now on.
>>>>
>>>> Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>    include/trace/events/intel_iommu.h | 119 -----------------------------
>>>>    1 file changed, 119 deletions(-)
>>>
>>> Is this needed in 5.11, or can it wait until 5.12?
>>
>> It's necessary for 5.11 as far as I can see. Without this, users still
>> see the events under /sys/kernel/debug/tracing/events/intel_iommu, but
>> they will get nothing traced even they enable the events.
> 
> I'm just a bit wary about breaking userspace by removing them altogether,
> although I see that there's plenty of precedent for removing events from
> the include/trace/events directory, so it's probably fine.
> 
> However, the patch as-is results in this warning for me:
> 
>   | In file included from include/trace/define_trace.h:102,
>   |                  from include/trace/events/intel_iommu.h:22,
>   |                  from drivers/iommu/intel/trace.c:14:
>   | include/trace/trace_events.h:27:23: warning: ‘str__intel_iommu__trace_system_name’ defined but not used [-Wunused-const-variable=]
>   |    27 | #define __app__(x, y) str__##x##y
>   |       |                       ^~~~~
>   | include/trace/trace_events.h:28:21: note: in expansion of macro ‘__app__’
>   |    28 | #define __app(x, y) __app__(x, y)
>   |       |                     ^~~~~~~
>   | include/trace/trace_events.h:30:29: note: in expansion of macro ‘__app’
>   |    30 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
>   |       |                             ^~~~~
>   | include/trace/trace_events.h:33:20: note: in expansion of macro ‘TRACE_SYSTEM_STRING’
>   |    33 |  static const char TRACE_SYSTEM_STRING[] = \
>   |       |                    ^~~~~~~~~~~~~~~~~~~
>   | include/trace/trace_events.h:36:1: note: in expansion of macro ‘TRACE_MAKE_SYSTEM_STR’
>   |    36 | TRACE_MAKE_SYSTEM_STR();
>   |       | ^~~~~~~~~~~~~~~~~~~~~
> 
> so I'll drop this for now.

Okay, I will rework this. Thanks!

> 
> Will
> 

Best regards,
baolu
