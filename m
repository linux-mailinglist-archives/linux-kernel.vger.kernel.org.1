Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD62994AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788953AbgJZR7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:59:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:47297 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1782899AbgJZR7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:59:13 -0400
IronPort-SDR: CdHZkKcIQPwbAPDEHVFAzteugPzGnonbY+Xp2M4W/cSt1OKL5R59oISGN1jcdAfnnKZl/sYJIz
 Z9vb3RzSWMOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168064717"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168064717"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 10:59:12 -0700
IronPort-SDR: 8EWBPw+SXox8za3JirZlejjeQ3gkJXH727wAUMMBPFXBrLvXPUvUxcBuoHzLuy4z2i/Yejrx+u
 8XMFgFbywdzg==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="535452787"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.226.224]) ([10.249.226.224])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 10:59:06 -0700
Subject: Re: [PATCH v2 00/15] Introduce threaded trace streaming for basic
 perf record operation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <20201024154309.GA2589351@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <01bad2c4-4188-f5f5-452e-a0ea0672a187@linux.intel.com>
Date:   Mon, 26 Oct 2020 20:59:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024154309.GA2589351@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.10.2020 18:43, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 06:52:43PM +0300, Alexey Budankov wrote:
>>
>> Changes in v2:
>> - explicitly added credit tags to patches 6/15 and 15/15,
>>   additionally to cites [1], [2]
>> - updated description of 3/15 to explicitly mention the reason
>>   to open data directories in read access mode (e.g. for perf report)
>> - implemented fix for compilation error of 2/15
>> - explicitly elaborated on found issues to be resolved for
>>   threaded AUX trace capture
>>
>> v1: https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/
>>
>> Patch set provides threaded trace streaming for base perf record
>> operation. Provided streaming mode (--threads) mitigates profiling
>> data losses and resolves scalability issues of serial and asynchronous
>> (--aio) trace streaming modes on multicore server systems. The patch
>> set is based on the prototype [1], [2] and the most closely relates
>> to mode 3) "mode that creates thread for every monitored memory map".
> 
> so what I liked about the previous code was that you could
> configure how the threads would be created
> 
> default --threads options created thread for each cpu like
> in your change:
> 
>   $ perf record -v --threads ...
>   ...
>   thread 0 monitor: 0 allowed: 0
>   thread 1 monitor: 1 allowed: 1
>   thread 2 monitor: 2 allowed: 2
>   thread 3 monitor: 3 allowed: 3
>   thread 4 monitor: 4 allowed: 4
>   thread 5 monitor: 5 allowed: 5
>   thread 6 monitor: 6 allowed: 6
>   thread 7 monitor: 7 allowed: 7

Yes, it is configurable in the prototype. Even though this patch set
doesn't implement that parameters for --thread option, just because
VTune doesn't have use cases for that yet, it has still been designed
and implemented with that possible extension in mind so it could then
be easily added on top of it.

> 
> 
> then numa based:
> 
>   $ perf record -v --threads=numa ...
>   ...
>   thread 0 monitor: 0-5,12-17 allowed: 0-5,12-17
>   thread 1 monitor: 6-11,18-23 allowed: 6-11,18-23
> 
> 
> socket based:
> 
>   $ perf record -v --threads=socket ...
>   ...
>   thread 0 monitor: 0-7 allowed: 0-7
> 
> 
> core based:
> 
>   $ perf record -v --threads=core ...
>   ...
>   thread 0 monitor: 0,4 allowed: 0,4
>   thread 1 monitor: 1,5 allowed: 1,5
>   thread 2 monitor: 2,6 allowed: 2,6
>   thread 3 monitor: 3,7 allowed: 3,7
> 
> 
> and user configurable:
> 
>   $ perf record -v  --threads=0-3/0:4-7/4 ...
>   ...
>   threads: 0. monitor 0-3, allowed 0
>   threads: 1. monitor 4-7, allowed 4
> 
> 
> so this way you could easily pin threads to cpu/core/socket/numa,
> or to some other cpu of your choice, because this will be always
> game of try and check where I'm not getting LOST events and not
> creating 1000 threads
> 
>  perf record: Add support for threads numa option value
>  perf record: Add support for threads socket option value
>  perf record: Add support for threads core option value
>  perf record: Add support for threads user option value

Makes sense.

Alexei
