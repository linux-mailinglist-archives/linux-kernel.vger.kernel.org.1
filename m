Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B760026E809
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIQWQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:16:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:38025 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIQWQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:16:23 -0400
IronPort-SDR: dNWQi4XcCpJ2FZpgB8vSbRA/w+dtGS4bc9/RX1aBd+o6OIQQvTxUa4ONTTZKFTkPU00TOHpjdq
 cOWmv2CIPgQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="160732478"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="160732478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 15:16:19 -0700
IronPort-SDR: N0HWBMh4w03AlXQmXuk6+BkORQkrqbWfTomEICfUR0WZFaOd7ue3XpWS2huC6CpqWBHKRzj8zE
 L8CwKYa8LCkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="303107760"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 17 Sep 2020 15:16:19 -0700
Received: from [10.251.12.27] (kliang2-MOBL.ccr.corp.intel.com [10.251.12.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A6AF45807C9;
        Thu, 17 Sep 2020 15:16:17 -0700 (PDT)
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
 <0e2cd6e4-8016-ccf6-eaff-2b304cf966ee@linux.intel.com>
 <39dd016a-b0ee-c9da-dc21-1b7175e8b5ef@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <88177517-da0c-43d9-4f5c-fb610e66b9e0@linux.intel.com>
Date:   Thu, 17 Sep 2020 18:16:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <39dd016a-b0ee-c9da-dc21-1b7175e8b5ef@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2020 6:02 PM, Dave Hansen wrote:
>> The problem is that the warning from the perf tool usually includes some
>> hints regarding the cause of the warning or possible solution to
>> workaround/fix the warning. What message should we deliver to the users?
>> "Warning: Too many error page size. Address space isolation feature may
>> be enabled, please check"?
> That's not particularly actionable for an end user.  Do any of the perf
> errors just tell them to submit a bug report?  "Excessive number of page
> size lookup errors, please report to..."

Yes, found some perf tool warnings end with "Consider reporting to 
linux-kernel@vger.kernel.org."

I will add a warning "Excessive number of page size lookup errors, 
please report to linux-kernel@vger.kernel.org.", if 90% of the samples 
have the page size 0.

Thanks,
Kan
