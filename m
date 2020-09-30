Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ED027EB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgI3Omn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:42:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:53894 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgI3Omn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:42:43 -0400
IronPort-SDR: jcRoI6q5SGmoDIK/6abdi1VB7I6Kh25udhnZq4yTEJqJ3If5t4ZiOrdzgQQt7QjkCim6j6gpGK
 ZrgMgUr6UZbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="247188301"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="247188301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 07:42:42 -0700
IronPort-SDR: UoY+gP3YeAAFCcBqgTkKLX15Btld3HEbt6FeqVgXAaTx0FHtAsUUmMXWae7kd7cAYBwZsAlTl2
 CqM8ZjKSfolA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="339111960"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2020 07:42:42 -0700
Received: from [10.255.228.167] (kliang2-MOBL.ccr.corp.intel.com [10.255.228.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9670B58033E;
        Wed, 30 Sep 2020 07:42:40 -0700 (PDT)
Subject: Re: [PATCH V8 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        kirill.shutemov@linux.intel.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>
References: <20200921152653.3924-1-kan.liang@linux.intel.com>
 <20200921152653.3924-2-kan.liang@linux.intel.com>
 <CABPqkBRYzXH-76BZ3DdxYp7bdyPcr3_WxuxOsJw=1YPE9EwZaw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4e974520-6d0f-68af-7eb8-fa52d95ba77b@linux.intel.com>
Date:   Wed, 30 Sep 2020 10:42:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABPqkBRYzXH-76BZ3DdxYp7bdyPcr3_WxuxOsJw=1YPE9EwZaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2020 3:15 AM, Stephane Eranian wrote:
>> +static u64 perf_get_page_size(unsigned long addr)
>> +{
>> +       unsigned long flags;
>> +       u64 size;
>> +
>> +       if (!addr)
>> +               return 0;
>> +
>> +       /*
>> +        * Software page-table walkers must disable IRQs,
>> +        * which prevents any tear down of the page tables.
>> +        */
>> +       local_irq_save(flags);
>> +
>> +       size = __perf_get_page_size(current->active_mm, addr);
>> +
> When I tested on my kernel, it panicked because I suspect
> current->active_mm could be NULL. Adding a check for NULL avoided the
> problem. But I suspect this is not the correct solution.
> 

I guess the NULL active_mm should be a rare case. If so, I think it's 
not bad to add a check and return 0 page size.


Thanks,
Kan
