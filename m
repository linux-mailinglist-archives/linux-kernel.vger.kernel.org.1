Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20FD2F662A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbhANQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:43:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:50417 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbhANQns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:43:48 -0500
IronPort-SDR: MrRIM6UxgSgob59hePHYcCrY5NtlS/dXuK2mmgBP0QfrN2MGqMDKHzkLLTZG0YDIFfUsaxHncq
 W5uQRO2VW+uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178489179"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="178489179"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 08:41:35 -0800
IronPort-SDR: +5KIU+xfNsh18q/Q0Essm6+uCVm4HO6B5iYLITBnzN3rWS5ekz90+aM9KvC6qheRcMJHmJ88JE
 iiFieRJ/FiGg==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="353964485"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.226.96]) ([10.249.226.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 08:41:32 -0800
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
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <20f98862-9087-0368-7124-19a8f2b54db9@linux.intel.com>
Date:   Thu, 14 Jan 2021 19:41:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjuX8AHpL6hs5AHObOPCjExLg1_GHN-vDdi4hYQmrC5dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/2021 6:39 AM, Namhyung Kim wrote:
> On Wed, Jan 13, 2021 at 9:08 PM Alexander Antonov
> <alexander.antonov@linux.intel.com> wrote:
>>
>> On 1/6/2021 12:02 PM, Namhyung Kim wrote:
>>> On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
>>> <alexander.antonov@linux.intel.com> wrote:
>>>> This functionality is based on recently introduced sysfs attributes
>>>> for Intel® Xeon® Scalable processor family (code name Skylake-SP):
>>>> Commit bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to
>>>> IIO PMON mapping")
>>>>
>>>> Mode is intended to provide four I/O performance metrics in MB per each
>>>> IIO stack:
>>>>    - Inbound Read: I/O devices below IIO stack read from the host memory
>>>>    - Inbound Write: I/O devices below IIO stack write to the host memory
>>>>    - Outbound Read: CPU reads from I/O devices below IIO stack
>>>>    - Outbound Write: CPU writes to I/O devices below IIO stack
>>>>
>>>> Each metric requiries only one IIO event which increments at every 4B
>>>> transfer in corresponding direction. The formulas to compute metrics
>>>> are generic:
>>>>       #EventCount * 4B / (1024 * 1024)
>>> Hmm.. maybe we can do this with JSON metrics, no?
>> Do you mean to add metrics to *-metrics.json file?
>> Looks like it's possible but in this case JSON file should be updated
>> for each
>> new enabled platform and calculations will be the same.
>> I would prefer to leave it as is because perf will work without changing of
>> userspace part once IIO sysfs attributes are added for new platforms.
> OK.
>
>>>> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
>>>> ---
> [SNIP]
>>>> diff --git a/tools/perf/perf-iiostat.sh b/tools/perf/perf-iiostat.sh
>>>> new file mode 100644
>>>> index 000000000000..2c5168d2550b
>>>> --- /dev/null
>>>> +++ b/tools/perf/perf-iiostat.sh
>>>> @@ -0,0 +1,12 @@
>>>> +#!/bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# perf iiostat
>>>> +# Alexander Antonov <alexander.antonov@linux.intel.com>
>>>> +
>>>> +if [[ "$1" == "show" ]] || [[ "$1" =~ ([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})(,)? ]]; then
>>>> +        DELIMITER="="
>>>> +else
>>>> +        DELIMITER=" "
>>>> +fi
>>>> +
>>>> +perf stat --iiostat$DELIMITER$*
>>> Why is this needed?
>>>
>>> Thanks,
>>> Namhyung
>> Arnaldo raised question relates to format of 'perf stat --iiostat'
>> subcommand
>> and explained how it can be changed to 'perf iiostat' through the aliases
>> mechanism in perf.
> Yeah, I know that.  What I'm asking is the DELIMITER part.
>
> Thanks,
> Namhyung
I'm using DELIMITER to resolve two different cases for format of iiostat 
command:
The first one is the command with an option for iiostat mode, for example:
'perf iiostat show' which should be converted to 'perf stat 
--iiostat=show' or
'perf iiostat 0000:ae,0000:5d' to 'perf stat --iiostat=0000:ae,0000:5d'.
The second is the command without any option for iiostat: 'perf iiostat 
-I 1000'
should be converted to 'perf stat --iiostat -I 1000'.

Thanks,
Alexander
