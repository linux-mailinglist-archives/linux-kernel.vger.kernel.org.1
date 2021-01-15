Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBAE2F7E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbhAOOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:36:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:7609 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731576AbhAOOgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:36:50 -0500
IronPort-SDR: gjHZIlOCddXYaurNM9Kjmg87YbKOH1MfruPil6OgMSAmZzTIc3AA3kdU+D9JbpRV87nnTpk3zc
 vkHWXG7XqwZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="165640361"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="165640361"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 06:35:04 -0800
IronPort-SDR: ATa+yG739o+UtxOSWB/MgrBB0TUM9LSfvWVeKqlrrE5nVfKvCtSMtNC35DvNZsEjGIQxu8qKy+
 gC/zzNxfiqTg==
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="382682114"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.226.58]) ([10.249.226.58])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 06:35:02 -0800
Subject: Re: [PATCH v2 5/6] perf stat: Enable iiostat mode for x86 platforms
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
 <20201223130320.3930-6-alexander.antonov@linux.intel.com>
 <CAM9d7cgQC7ap6sDympEoNAtFxNy_ibtW3phMDLh-VmzSDB7FXQ@mail.gmail.com>
 <358dd76f-c6ec-b894-14be-659df0802c87@linux.intel.com>
 <CAM9d7cjuX8AHpL6hs5AHObOPCjExLg1_GHN-vDdi4hYQmrC5dQ@mail.gmail.com>
 <20f98862-9087-0368-7124-19a8f2b54db9@linux.intel.com>
 <CAM9d7cjueVS_MJZxuADi-xw=EWXgncZ++jGDewamxZF8CkvhRw@mail.gmail.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <913f2743-b5dd-f7e0-1bd0-d3c1d2ad1c7c@linux.intel.com>
Date:   Fri, 15 Jan 2021 17:34:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjueVS_MJZxuADi-xw=EWXgncZ++jGDewamxZF8CkvhRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/15/2021 10:33 AM, Namhyung Kim wrote:
> On Fri, Jan 15, 2021 at 1:41 AM Alexander Antonov
> <alexander.antonov@linux.intel.com> wrote:
>> On 1/14/2021 6:39 AM, Namhyung Kim wrote:
>>> On Wed, Jan 13, 2021 at 9:08 PM Alexander Antonov
>>> <alexander.antonov@linux.intel.com> wrote:
>>>> On 1/6/2021 12:02 PM, Namhyung Kim wrote:
>>>>> On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
>>>>>> diff --git a/tools/perf/perf-iiostat.sh b/tools/perf/perf-iiostat.sh
>>>>>> new file mode 100644
>>>>>> index 000000000000..2c5168d2550b
>>>>>> --- /dev/null
>>>>>> +++ b/tools/perf/perf-iiostat.sh
>>>>>> @@ -0,0 +1,12 @@
>>>>>> +#!/bin/bash
>>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>>> +# perf iiostat
>>>>>> +# Alexander Antonov <alexander.antonov@linux.intel.com>
>>>>>> +
>>>>>> +if [[ "$1" == "show" ]] || [[ "$1" =~ ([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})(,)? ]]; then
>>>>>> +        DELIMITER="="
>>>>>> +else
>>>>>> +        DELIMITER=" "
>>>>>> +fi
>>>>>> +
>>>>>> +perf stat --iiostat$DELIMITER$*
>>>>> Why is this needed?
>>>>>
>>>>> Thanks,
>>>>> Namhyung
>>>> Arnaldo raised question relates to format of 'perf stat --iiostat'
>>>> subcommand
>>>> and explained how it can be changed to 'perf iiostat' through the aliases
>>>> mechanism in perf.
>>> Yeah, I know that.  What I'm asking is the DELIMITER part.
>>>
>>> Thanks,
>>> Namhyung
>> I'm using DELIMITER to resolve two different cases for format of iiostat
>> command:
>> The first one is the command with an option for iiostat mode, for example:
>> 'perf iiostat show' which should be converted to 'perf stat
>> --iiostat=show' or
>> 'perf iiostat 0000:ae,0000:5d' to 'perf stat --iiostat=0000:ae,0000:5d'.
>> The second is the command without any option for iiostat: 'perf iiostat
>> -I 1000'
>> should be converted to 'perf stat --iiostat -I 1000'.
> Can't we simply use a whitespace ?
We need to use the equal sign to pass arguments to iiostat mode.

Thanks,
Alexander
