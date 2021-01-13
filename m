Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1143B2F49CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbhAMLPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:15:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:42284 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbhAMLPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:15:30 -0500
IronPort-SDR: i4yMyrfLqYNeTywb5IobYinT4X/oDmP08dLmYQeiH7A2cuDITJ7PK0TX0sWhgFuzXiH3un3rx+
 9zqsU1dUMx6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="165862791"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="165862791"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:13:49 -0800
IronPort-SDR: GmAM/i5R61hb8NxYgDEqZuOpRnjbczA38Z9k1eNZ4tN9qowY61kjGRBYoTSpoqEQjeuBMucovY
 JELjplp0AUJQ==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="381806146"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.225.249]) ([10.249.225.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:13:46 -0800
Subject: Re: [PATCH v2 2/6] perf evsel: Introduce an observed performance
 device
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
 <20201223130320.3930-3-alexander.antonov@linux.intel.com>
 <CAM9d7cikD68d0iAiFQ2A6J5tDqM-jphqQUjLAV0vQZqH7Mi37A@mail.gmail.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <1c42b0c5-2731-ff9c-0b8b-4becf8ecef07@linux.intel.com>
Date:   Wed, 13 Jan 2021 14:13:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cikD68d0iAiFQ2A6J5tDqM-jphqQUjLAV0vQZqH7Mi37A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/2021 11:44 AM, Namhyung Kim wrote:
> Hi,
>
> On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
> <alexander.antonov@linux.intel.com> wrote:
>> Adding evsel::perf_device void pointer.
>>
>> For performance monitoring purposes, an evsel can have a related device.
>> These changes allow to attribute, for example, I/O performance metrics
>> to IIO stack.
>>
>> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
>> ---
>>   tools/perf/util/evsel.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 79a860d8e3ee..c346920f477a 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -127,6 +127,7 @@ struct evsel {
>>           * See also evsel__has_callchain().
>>           */
>>          __u64                   synth_sample_type;
>> +       void                    *perf_device;
> Maybe we can use the existing 'priv' field.
>
> Thanks,
> Namhyung

Hello Namhyung,

Looks like the 'priv' field isn't used in this case. I suppose it can be
re-used in iiostat mode.

Thanks,
Alexander
>
>>   };
>>
>>   struct perf_missing_features {
>> --
>> 2.19.1
>>
