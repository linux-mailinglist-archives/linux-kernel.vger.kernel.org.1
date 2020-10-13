Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969F228D0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgJMO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:57:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:46886 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388986AbgJMO5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:57:46 -0400
IronPort-SDR: jdD7tUMi5mj/7+7Y+X/Gsqr5EapinvbwHp+GiGwI5NMPAUKOvlmiUUIBLAwuJEeiTSQEXrP5mB
 HrtPRphjtGLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162457984"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="162457984"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 07:57:45 -0700
IronPort-SDR: E2ZndqU/Eh2zCZTPskutF2k1BHjy8PtSBHGjoLoEJijrtWmrN0n1AQVSXvf3GEERde9qmeIaCg
 +iWJEny8D88w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="356176863"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2020 07:57:44 -0700
Received: from [10.252.134.17] (kliang2-MOBL.ccr.corp.intel.com [10.252.134.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 52391580814;
        Tue, 13 Oct 2020 07:57:43 -0700 (PDT)
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <877drz1qbc.fsf@mpe.ellerman.id.au> <20201012084829.GA1151@willie-the-truck>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
Date:   Tue, 13 Oct 2020 10:57:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201012084829.GA1151@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2020 4:48 AM, Will Deacon wrote:
> On Sat, Oct 10, 2020 at 12:28:39AM +1100, Michael Ellerman wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>>> Patch 4 makes it all far worse by exposing it to pretty much everybody.
>>>
>>> Now, I think we can fix at least the user mappings with the below delta,
>>> but if archs are using non-page-table MMU sizes we'll need arch helpers.
>>>
>>> ARM64 is in that last boat.
>>
>> I think we probably need it to be weak so we can provide our own
>> version.
> 
> I guess the same thing applies to us, but I can't really tell how accurate
> this stuff needs to be for userspace. If it's trying to use the page-table
> configuration to infer properties of the TLB, that's never going to be
> reliable because the TLB can choose both to split and coalesce entries
> as long as software can't tell.
> 

Hi Peter,

It looks like everybody wants a __weak function. If so, I guess we 
should drop the generic code in this patch. For X86, we have existing 
functions to retrieve the page level and the page size. I think we don't 
need the generic code either.
https://lkml.kernel.org/r/1549648509-12704-2-git-send-email-kan.liang@linux.intel.com/

Should I send a V10 patch to drop the generic code and implement an X86 
specific perf_get_page_size()? Will, Michael, and others can implement 
their version later separately.

Thanks,
Kan
