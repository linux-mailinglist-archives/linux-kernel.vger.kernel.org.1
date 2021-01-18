Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BEC2FA1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404786AbhARNnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:43:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:16734 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404725AbhARNml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:42:41 -0500
IronPort-SDR: d+iQA7gcngR9R6i30mDQhJ3ibIkuKTk5hvSl1rFVkELGJqpt4c0q2Ym+/8wO/VbHWu4UnNVkAX
 zEnOAZtNqRDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="178888346"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="178888346"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 05:40:47 -0800
IronPort-SDR: ZGAvVgV96vvvYodLz60JaqJJE1Z3LvXlkHoKY1z42HuJh7wvaRWGo7rnTxuKX6PRg7RAL/BuZe
 NKe6SO/GYY3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="500650840"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2021 05:40:46 -0800
Received: from [10.254.79.158] (kliang2-MOBL.ccr.corp.intel.com [10.254.79.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8DD4358072C;
        Mon, 18 Jan 2021 05:40:45 -0800 (PST)
Subject: Re: [PATCH V4 4/6] perf script: Add support for
 PERF_SAMPLE_CODE_PAGE_SIZE
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
 <20210105195752.43489-5-kan.liang@linux.intel.com>
 <20210115192538.GG457607@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cc3557dc-d293-f268-5fc4-03cca8f7b274@linux.intel.com>
Date:   Mon, 18 Jan 2021 08:40:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210115192538.GG457607@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/2021 2:25 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 05, 2021 at 11:57:50AM -0800,kan.liang@linux.intel.com  escreveu:
>> From: Stephane Eranian<eranian@google.com>
>>
>> Display sampled code page sizes when PERF_SAMPLE_CODE_PAGE_SIZE was set.
>>
>> For example,
>> perf script --fields comm,event,ip,code_page_size
>>              dtlb mem-loads:uP:            445777 4K
>>              dtlb mem-loads:uP:            40f724 4K
>>              dtlb mem-loads:uP:            474926 4K
>>              dtlb mem-loads:uP:            401075 4K
>>              dtlb mem-loads:uP:            401095 4K
>>              dtlb mem-loads:uP:            401095 4K
>>              dtlb mem-loads:uP:            4010cc 4K
>>              dtlb mem-loads:uP:            440b6f 4K
>>
>> Acked-by: Namhyung Kim<namhyung@kernel.org>
>> Acked-by: Jiri Olsa<jolsa@redhat.com>
>> Signed-off-by: Stephane Eranian<eranian@google.com>
> You missed your Signed-off-by, I'm adding it, please ack this change.

The patch 4 and 5 are from Stephane. I only made minor changes so that 
the code can be rebased to the latest perf/core branch (c07b45a355ee).

May add a tag as below.

[kan.liang@linux.intel.com: Rebase on top of acme's perf/core branch 
commit c07b45a355ee]
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>


Thanks,
Kan
