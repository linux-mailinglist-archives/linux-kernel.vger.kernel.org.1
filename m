Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA10304327
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404005AbhAZP4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:56:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:63506 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391338AbhAZPfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:35:54 -0500
IronPort-SDR: Ob5DScOtBdrrKuZkjn1D9OxePZP/sfoyHdROiYQ4qkpaKvQvz0Mq5A7rTjDhvj0vJK1/K/P6dA
 5d0GDT9UiNFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="176408591"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="176408591"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:34:03 -0800
IronPort-SDR: BPjtNNW25Uz9rLpwkRMOUS/N/WysfOZTfacmApR844/HAWWNuhe3HlPEN7IwWbTQwdz9yYXkG0
 IFj8FnlFXfig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577822681"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2021 07:34:03 -0800
Received: from [10.254.127.77] (kliang2-MOBL.ccr.corp.intel.com [10.254.127.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8793F5807C8;
        Tue, 26 Jan 2021 07:34:02 -0800 (PST)
Subject: Re: [PATCH 03/12] perf/x86/intel: Add perf core PMU support for
 Sapphire Rapids
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
 <1611088711-17177-4-git-send-email-kan.liang@linux.intel.com>
 <YBAqnSlLUpBHOWRY@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fc560c48-c460-688f-739a-d0068f3d4e55@linux.intel.com>
Date:   Tue, 26 Jan 2021 10:34:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBAqnSlLUpBHOWRY@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2021 9:43 AM, Peter Zijlstra wrote:
> On Tue, Jan 19, 2021 at 12:38:22PM -0800, kan.liang@linux.intel.com wrote:
>> @@ -2319,6 +2474,17 @@ static void __icl_update_topdown_event(struct perf_event *event,
>>   {
>>   	u64 delta, last = 0;
>>   
>> +	/*
>> +	 * Although the unsupported topdown events are not exposed to users,
>> +	 * users may mistakenly use the unsupported events via RAW format.
>> +	 * For example, using L2 topdown event, cpu/event=0x00,umask=0x84/,
>> +	 * on Ice Lake. In this case, the scheduler follows the unknown
>> +	 * event handling and assigns a GP counter to the event.
>> +	 * Check the case, and avoid updating unsupported events.
>> +	 */
>> +	if (event->hw.idx < INTEL_PMC_IDX_FIXED)
>> +		return;
>> +
>>   	delta = icl_get_topdown_value(event, slots, metrics);
>>   	if (last_slots)
>>   		last = icl_get_topdown_value(event, last_slots, last_metrics);
> 
> Is this a separate patch?
> 

I will move it to a separate patch.

Thanks,
Kan
