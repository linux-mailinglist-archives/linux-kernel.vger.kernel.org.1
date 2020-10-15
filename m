Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C014728F041
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgJOKfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:35:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:10421 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgJOKfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:35:34 -0400
IronPort-SDR: hlMdchY+/X+fI8crG4KQL6J4ShJw+2lXZfz9zzMyYCH+TJKYHUiZQvRqPB+pRxPXiN7XS+5yys
 XwMy8MQHhyrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="145627809"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="145627809"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 03:35:31 -0700
IronPort-SDR: lQjGGUEqsgtQswHyoput+qtxf27T+lfu8bkMWBBR6q9mHdcH7snrbAdrlz5Y1dsmjhb40oWzMS
 Glcw5YxHhZTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="346812201"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 15 Oct 2020 03:35:30 -0700
Received: from [10.249.224.68] (abudanko-mobl.ccr.corp.intel.com [10.249.224.68])
        by linux.intel.com (Postfix) with ESMTP id 5E1AA5800BD;
        Thu, 15 Oct 2020 03:35:28 -0700 (PDT)
Subject: Re: [PATCH v1 00/15] Introduce threaded trace streaming for basic
 perf record operation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <20201014172700.GA3595702@gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <73ff3e6f-4f5e-9a15-8710-b9b9026e27d4@linux.intel.com>
Date:   Thu, 15 Oct 2020 13:35:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201014172700.GA3595702@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14.10.2020 20:27, Ingo Molnar wrote:
> 
> * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
>>
>> Patch set provides threaded trace streaming for base perf record
>> operation. Provided streaming mode (--threads) mitigates profiling
>> data losses and resolves scalability issues of serial and asynchronous
>> (--aio) trace streaming modes on multicore server systems. The patch
>> set is based on the prototype [1], [2] and the most closely relates
>> to mode 3) "mode that creates thread for every monitored memory map".
>>
>> The threaded mode executes one-to-one mapping of trace streaming threads
>> to mapped data buffers and streaming into per-CPU trace files located
>> at data directory. The data buffers and threads are affined to NUMA
>> nodes and monitored CPUs according to system topology. --cpu option
>> can be used to specify exact CPUs to be monitored.
> 
> Yay! This should really be the default trace capture model everywhere 
> possible.
> 
> Can we do this for perf top too? It's really struggling with lots of cores.
> 
> If on a 64-core system I run just a moderately higher frequency 'perf top' 
> of 1 kHz:
> 
>   perf top -e cycles -F 1000
> 
> perf stays stuck forever in 'Collecting samples...', and I also get a lot 
> of:
> 
>   [548112.871089] Uhhuh. NMI received for unknown reason 31 on CPU 25.
>   [548112.871089] Do you have a strange power saving mode enabled?

Yes, we can. I would only prefer to do it in a separate patch set since
for me this patch set is already complex enough as a single change.
Is it ok?

I would also appreciate if you could clarify, advise or guide on the impact
of this perf top advancement or may be even provide some feedback on this feature adoption to help better justify the effort for my management. 

Gratefully,
Alexei

> 
> Thanks,
> 
> 	Ingo
> 
