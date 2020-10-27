Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2880029B438
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 16:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784664AbgJ0O70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:59:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:14268 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750352AbgJ0Oo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:44:28 -0400
IronPort-SDR: mOtLsr6ZgZE6OuXm230X0/qBx4w1PPYsKFt3Rr5tWiy/XVOMyCuE7apv8BFc9KhBGsxdPsgXtE
 QL2x7mNkmwYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168190518"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="168190518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 07:44:27 -0700
IronPort-SDR: hsoRYjJQyVtX1UKR/2PZR1k3Sbc/yfQbywyRP1Uc+KKF8hPUdlN/oIqXvXOsOZAywJmqZA9DDn
 Udp72D9/Z8tw==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="535819778"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.227.194]) ([10.249.227.194])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 07:44:25 -0700
Subject: Re: [PATCH v2 03/15] perf data: open data directory in read access
 mode
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
 <dc78ce8b-664c-45b9-ad44-4faaeb5d544f@linux.intel.com>
 <20201024154317.GB2589351@krava>
 <a368355b-4bf3-05b8-9fa0-ee3feb58f8bf@linux.intel.com>
 <20201027115907.GC2900849@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4cec05bd-039a-7a27-04b9-81cd046f2675@linux.intel.com>
Date:   Tue, 27 Oct 2020 17:44:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027115907.GC2900849@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.10.2020 14:59, Jiri Olsa wrote:
> On Mon, Oct 26, 2020 at 08:47:06PM +0300, Alexey Budankov wrote:
>>
>> On 24.10.2020 18:43, Jiri Olsa wrote:
>>> On Wed, Oct 21, 2020 at 06:57:53PM +0300, Alexey Budankov wrote:
>>>>
>>>> Open files located at trace data directory in case read access
>>>> mode is requested. File are opened and its fds assigned to
>>>> perf_data dir files especially for loading data directories
>>>> content in perf report mode.
>>>>
>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> ---
>>>>  tools/perf/util/data.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
>>>> index c47aa34fdc0a..6ad61ac6ba67 100644
>>>> --- a/tools/perf/util/data.c
>>>> +++ b/tools/perf/util/data.c
>>>> @@ -321,6 +321,10 @@ static int open_dir(struct perf_data *data)
>>>>  		return -1;
>>>>  
>>>>  	ret = open_file(data);
>>>> +	if (!ret && perf_data__is_dir(data)) {
>>>> +		if (perf_data__is_read(data))
>>>> +			ret = perf_data__open_dir(data);
>>>> +	}
>>>
>>> perf_data__open_dir is also called from perf_session__new
>>> is it called twice?
>>
>> It is not called twice. It is in different branches.
>> This one is for write and the other one is for read.
> 
> hum, is that right?
> 
> 	# ./perf record --threads 
> 	^C[ perf record: Woken up 15 times to write data ]
> 	[ perf record: Captured and wrote 1.421 MB perf.data (515 samples) ]
> 
> 	# gdb ./perf
> 	GNU gdb (GDB) Fedora 9.1-6.fc32
> 
> 	(gdb) b perf_data__open_dir
> 	Breakpoint 1 at 0x5b4753: file util/data.c, line 72.
> 
> 	(gdb) r --no-pager report --stdio
> 	Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf --no-pager report --stdio
> 
> 	Breakpoint 1, perf_data__open_dir (data=0x7fffffffb0e0) at util/data.c:72
> 	72      {
> 	(gdb) bt
> 	#0  perf_data__open_dir (data=0x7fffffffb0e0) at util/data.c:72
> 	#1  0x00000000005b538d in open_dir (data=0x7fffffffb0e0) at util/data.c:326
> 	#2  0x00000000005b546d in perf_data__open (data=0x7fffffffb0e0) at util/data.c:351
> 	#3  0x00000000005627e8 in perf_session__new (data=0x7fffffffb0e0, repipe=false, tool=0x7fffffffb220) at util/session.c:210
> 	#4  0x000000000045a572 in cmd_report (argc=0, argv=0x7fffffffd7a8) at builtin-report.c:1372
> 	#5  0x00000000004f49ec in run_builtin (p=0xaadab0 <commands+240>, argc=2, argv=0x7fffffffd7a8) at perf.c:312
> 	#6  0x00000000004f4c59 in handle_internal_command (argc=2, argv=0x7fffffffd7a8) at perf.c:364
> 	#7  0x00000000004f4da0 in run_argv (argcp=0x7fffffffd5ec, argv=0x7fffffffd5e0) at perf.c:408
> 	#8  0x00000000004f516c in main (argc=2, argv=0x7fffffffd7a8) at perf.c:538
> 
> 	(gdb) c
> 	Continuing.
> 
> 	Breakpoint 1, perf_data__open_dir (data=0x7fffffffb0e0) at util/data.c:72
> 	72      {
> 	(gdb) bt
> 	#0  perf_data__open_dir (data=0x7fffffffb0e0) at util/data.c:72
> 	#1  0x0000000000562883 in perf_session__new (data=0x7fffffffb0e0, repipe=false, tool=0x7fffffffb220) at util/session.c:234
> 	#2  0x000000000045a572 in cmd_report (argc=0, argv=0x7fffffffd7a8) at builtin-report.c:1372
> 	#3  0x00000000004f49ec in run_builtin (p=0xaadab0 <commands+240>, argc=2, argv=0x7fffffffd7a8) at perf.c:312
> 	#4  0x00000000004f4c59 in handle_internal_command (argc=2, argv=0x7fffffffd7a8) at perf.c:364
> 	#5  0x00000000004f4da0 in run_argv (argcp=0x7fffffffd5ec, argv=0x7fffffffd5e0) at perf.c:408
> 	#6  0x00000000004f516c in main (argc=2, argv=0x7fffffffd7a8) at perf.c:538
> 
> 
> AFAICS the second (current) call to perf_data__open_dir will
> do the job, because the call you added still does not see
> directory with proper version and will bail out on call to
>   perf_data__is_single_file
> 
> perf_session__open call will read headers and update dir version
> so the current perf_data__open_dir will open the directory

Tested once again. Now it looks like this patch is redundant
since dir is already opened by the existing code.
Thanks for pointing this out!

Alexei

> 
> jirka
> 
