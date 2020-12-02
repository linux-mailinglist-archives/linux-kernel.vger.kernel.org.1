Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040592CBEFF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgLBOGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:06:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:2674 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgLBOGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:06:34 -0500
IronPort-SDR: 8rSQEkp0cpFFZy12qX+lNyw12YuQrOG7X1gx5PVNymU598mHJQA+SY11jUgHOUdZIh7rFc3nlG
 kTrSK6otDAfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="257730209"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="257730209"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 06:04:52 -0800
IronPort-SDR: G7l6JHhoAIF2UNdPdYNAse8N3pasjeamrjFwJM31XrN7HrJWUnsW/4dP4zTcjRg4Q7Y5Q+K7fx
 /ZcPt+ra2/PA==
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="550070268"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.229.109]) ([10.249.229.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 06:04:49 -0800
Subject: Re: [PATCH v2 1/3] Revert "perf session: Fix decompression of
 PERF_RECORD_COMPRESSED records"
To:     Alexei Budankov <abudankov@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>, Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124102919.15312-1-oss@malat.biz> <20201124143645.GD2088148@krava>
 <20201124181519.GA29264@ntb.petris.klfree.czf>
 <20201130114020.GA29476@ntb.petris.klfree.czf>
 <20201201190928.GB3169083@krava>
 <90d5469d-2591-44bf-70c4-edc1b2750935@huawei.com>
 <1ee1c9b6-516f-cee1-1b37-388fb5507cd3@huawei.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <545dfd5b-670a-a215-4484-29fe10b18517@linux.intel.com>
Date:   Wed, 2 Dec 2020 17:04:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1ee1c9b6-516f-cee1-1b37-388fb5507cd3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was able to reproduce "Couldn't allocate memory for decompression" on 32-bit 
perf with long perf.data.

On my side mmap() in perf_session__process_compressed_event() fails with ENOMEM,
due to exceeded memory limit for 32-bit applications.
This happens with or without Petr's patch.

As I can see, these mappings are only released in perf_session__delete().
We should think how to release them early.

On 02.12.2020 0:28, Alexei Budankov wrote:
> 
> Eventually sending to the proper Alexey's address.
> 
> On 02.12.2020 0:04, Alexei Budankov wrote:
>>
>> On 01.12.2020 22:09, Jiri Olsa wrote:
>>> On Mon, Nov 30, 2020 at 12:40:20PM +0100, Petr Malat wrote:
>>>> Hi Jiří,
>>>> were you able to reproduce the issue? I may also upload perf-archive
>>>> if that would help.
>>>
>>> oh yea ;-) seems like those 2 commits you reverted broke 32 bits
>>> perf for data files > 32MB
>>>
>>> but the fix you did does not work for Alexey's test he mentioned
>>> in the commit:
>>>
>>>       $ perf record -z -- some_long_running_workload
>>>       $ perf report --stdio -vv
>>>
>>> it's failing for me with:
>>>
>>> 	# ./perf report
>>> 	Couldn't allocate memory for decompression
>>> 	0xfe6f3a [0x60]: failed to process type: 81 [Operation not permitted]
>>> 	Error:
>>> 	failed to process sample
>>> 	# To display the perf.data header info, please use --header/--header-only options.
>>> 	#
>>>
>>> I think that's why here's special handling for compressed
>>> events, but I'll need to check on that in more detail,
>>> I was hoping for Alexey to answer ;-)
>>
>> Sorry for delay. Alexey Bayduraev could possibly help with that sooner.
>> Alexey, could you please follow up.
>>
>> Thanks,
>> Alexei

Regards,
Alexey
