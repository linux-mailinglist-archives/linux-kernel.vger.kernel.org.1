Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F24F28E060
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgJNMQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:16:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:20179 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgJNMQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:16:09 -0400
IronPort-SDR: lnyp2N+RW0OkdlYJ8kUOOE0Ups7qKbyQXqQmR7C6oj22f5O8sfPzn39JfWLw5Qkcvm1Cp6xx4U
 9UcB1hyrzvWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="153034534"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="153034534"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 05:15:59 -0700
IronPort-SDR: KkKbzaWrKgP0O0Gr3EU0t9940e87Jgzw7Cdg2ojYSuUk/HP8RTysCtangNg1p17grSqiw/Lhlw
 tH7JzL0ubXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="318635763"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2020 05:15:59 -0700
Received: from [10.249.230.73] (abudanko-mobl.ccr.corp.intel.com [10.249.230.73])
        by linux.intel.com (Postfix) with ESMTP id 01FC9580967;
        Wed, 14 Oct 2020 05:15:54 -0700 (PDT)
Subject: Re: [PATCH v1 00/15] Introduce threaded trace streaming for basic
 perf record operation
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <20201013162006.GJ1063281@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3ea3ee09-9b59-f172-22a5-d5196498caf5@linux.intel.com>
Date:   Wed, 14 Oct 2020 15:15:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201013162006.GJ1063281@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.10.2020 19:20, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 12, 2020 at 11:50:29AM +0300, Alexey Budankov escreveu:
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
>>
>> Basic analysis of data directories is provided for perf report mode.
>> Raw dump (-D) and aggregated reports are available for data directories,
>> still with no memory consumption optimizations. However data directories
>> collected with --compression-level option enabled can be analyzed with
>> little less memory because trace files are unmaped from tool process
>> memory after loading collected data.
>>
>> Provided streaming mode is available with Zstd compression/decompression
>> (--compression-level) and handling of external commands (--control).
>> AUX area tracing, related and derived modes like --snapshot or
>> --aux-sample are not enabled. --switch-output, --switch-output-event, 
>> --switch-max-files and --timestamp-filename options are not enabled.
> 
> Would be interesting to spell out what are the difficulties to have
> those options working with this threaded mode, as I expect that once
> this is all reviewed and tested we should switch to it by default, no?

At the moment I am not sure about this as the default mode. It all depends
on specifics of HW configuration and workload to be monitored and analyzed.
On middle and small sized systems --aio could still fit better from HW/OS
resource consumption perspective.

Initial intent to enable AUX area tracing faced the need to define some
(optimal?) way to store index data at data directory, thus left aside of
this first step to bring threaded trace streaming into Perf tool.
--switch-output-* and --timestamp-filename use cases are not yet clear
for data directories and thus look like features of the second order.

Addressing all that issues in a single patch set looks too much. Proper
way to have it all in is step-by-step. Also I should say that it is aside
of the scope of current Intel VTune specific needs.

Alexei
