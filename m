Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7AC2F4B06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbhAMMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:09:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:13282 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbhAMMJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:09:51 -0500
IronPort-SDR: U6xqBCBBtgtzqCW+FfI/7ValS5MeB0wEiSu1/r/+R3yFSuTPX2ym6OA+cFmkNAVGRkSCd6FKa1
 qfGk3Kf42S4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157968807"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="157968807"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 04:08:06 -0800
IronPort-SDR: V0B5KThw3Fe8dmOjk4cKpmQmjVRLkZ8jZqsIs/QlwmY01qpmLdGclpU9xtxEL6ZpyGHW+ZwVkF
 Nn6O44vNYjSw==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="381822469"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.225.249]) ([10.249.225.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 04:08:02 -0800
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
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <358dd76f-c6ec-b894-14be-659df0802c87@linux.intel.com>
Date:   Wed, 13 Jan 2021 15:08:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgQC7ap6sDympEoNAtFxNy_ibtW3phMDLh-VmzSDB7FXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/2021 12:02 PM, Namhyung Kim wrote:
> On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
> <alexander.antonov@linux.intel.com> wrote:
>> This functionality is based on recently introduced sysfs attributes
>> for Intel® Xeon® Scalable processor family (code name Skylake-SP):
>> Commit bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to
>> IIO PMON mapping")
>>
>> Mode is intended to provide four I/O performance metrics in MB per each
>> IIO stack:
>>   - Inbound Read: I/O devices below IIO stack read from the host memory
>>   - Inbound Write: I/O devices below IIO stack write to the host memory
>>   - Outbound Read: CPU reads from I/O devices below IIO stack
>>   - Outbound Write: CPU writes to I/O devices below IIO stack
>>
>> Each metric requiries only one IIO event which increments at every 4B
>> transfer in corresponding direction. The formulas to compute metrics
>> are generic:
>>      #EventCount * 4B / (1024 * 1024)
> Hmm.. maybe we can do this with JSON metrics, no?
Do you mean to add metrics to *-metrics.json file?
Looks like it's possible but in this case JSON file should be updated 
for each
new enabled platform and calculations will be the same.
I would prefer to leave it as is because perf will work without changing of
userspace part once IIO sysfs attributes are added for new platforms.
>
>> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
>> ---
>>   tools/perf/Documentation/perf-iiostat.txt |  89 ++++++
>>   tools/perf/Makefile.perf                  |   5 +-
>>   tools/perf/arch/x86/util/Build            |   1 +
>>   tools/perf/arch/x86/util/iiostat.c        | 337 ++++++++++++++++++++++
>>   tools/perf/command-list.txt               |   1 +
>>   tools/perf/perf-iiostat.sh                |  12 +
>>   6 files changed, 444 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/perf/Documentation/perf-iiostat.txt
>>   create mode 100644 tools/perf/perf-iiostat.sh
>>
>> diff --git a/tools/perf/Documentation/perf-iiostat.txt b/tools/perf/Documentation/perf-iiostat.txt
>> new file mode 100644
>> index 000000000000..38b5697b0d85
>> --- /dev/null
>> +++ b/tools/perf/Documentation/perf-iiostat.txt
>> @@ -0,0 +1,89 @@
>> +perf-iiostat(1)
>> +===============
>> +
>> +NAME
>> +----
>> +perf-iiostat - Show I/O performance metrics
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'perf iiostat' show
>> +'perf iiostat' <ports> -- <command> [<options>]
>> +
>> +DESCRIPTION
>> +-----------
>> +Mode is intended to provide four I/O performance metrics per each IIO
>> +stack (PCIe root port):
>> +
>> +- Inbound Read   - I/O devices below IIO stack read from the host memory, in MB
>> +
>> +- Inbound Write  - I/O devices below IIO stack write to the host memory, in MB
>> +
>> +- Outbound Read  - CPU reads from I/O devices below IIO stack, in MB
>> +
>> +- Outbound Write - CPU writes to I/O devices below IIO stack, in MB
>> +
>> +OPTIONS
>> +-------
>> +<command>...::
>> +       Any command you can specify in a shell.
>> +
>> +show::
>> +       List all IIO stacks.
> I'd prefer 'list' for this, but not a strong opinion..
The 'list' is fine for me as well.
>
>> +
>> +<ports>::
>> +       Select the root ports for monitoring. Comma-separated list is supported.
>> +
>> +EXAMPLES
>> +--------
>> +
>> +1. List all IIO stacks (example for 2-S platform):
>> +
>> +   $ perf iiostat show
>> +   S0-uncore_iio_0<0000:00>
>> +   S1-uncore_iio_0<0000:80>
>> +   S0-uncore_iio_1<0000:17>
>> +   S1-uncore_iio_1<0000:85>
>> +   S0-uncore_iio_2<0000:3a>
>> +   S1-uncore_iio_2<0000:ae>
>> +   S0-uncore_iio_3<0000:5d>
>> +   S1-uncore_iio_3<0000:d7>
>> +
>> +2. Collect metrics for all I/O stacks:
>> +
>> +   $ perf iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
>> +   357708+0 records in
>> +   357707+0 records out
>> +   375083606016 bytes (375 GB, 349 GiB) copied, 215.974 s, 1.7 GB/s
>> +
>> +    Performance counter stats for 'system wide':
>> +
>> +      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
>> +   0000:00                    1                    0                    2                    3
>> +   0000:80                    0                    0                    0                    0
>> +   0000:17               352552                   43                    0                   21
>> +   0000:85                    0                    0                    0                    0
>> +   0000:3a                    3                    0                    0                    0
>> +   0000:ae                    0                    0                    0                    0
>> +   0000:5d                    0                    0                    0                    0
>> +   0000:d7                    0                    0                    0                    0
>> +
>> +3. Collect metrics for comma-separated list of I/O stacks:
>> +
>> +   $ perf iiostat 0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
>> +   357708+0 records in
>> +   357707+0 records out
>> +   375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s
>> +
>> +    Performance counter stats for 'system wide':
>> +
>> +      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
>> +   0000:17               358559                   44                    0                   22
>> +   0000:3a                    3                    2                    0                    0
>> +
>> +        197.081983474 seconds time elapsed
>> +
>> +SEE ALSO
>> +--------
>> +linkperf:perf-stat[1]
>> \ No newline at end of file
> [SNIP]
>> diff --git a/tools/perf/perf-iiostat.sh b/tools/perf/perf-iiostat.sh
>> new file mode 100644
>> index 000000000000..2c5168d2550b
>> --- /dev/null
>> +++ b/tools/perf/perf-iiostat.sh
>> @@ -0,0 +1,12 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# perf iiostat
>> +# Alexander Antonov <alexander.antonov@linux.intel.com>
>> +
>> +if [[ "$1" == "show" ]] || [[ "$1" =~ ([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})(,)? ]]; then
>> +        DELIMITER="="
>> +else
>> +        DELIMITER=" "
>> +fi
>> +
>> +perf stat --iiostat$DELIMITER$*
> Why is this needed?
>
> Thanks,
> Namhyung
Arnaldo raised question relates to format of 'perf stat --iiostat' 
subcommand
and explained how it can be changed to 'perf iiostat' through the aliases
mechanism in perf.

Thank you,
Alexander
>
>> \ No newline at end of file
>> --
>> 2.19.1
>>
