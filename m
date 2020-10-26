Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22990299438
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788362AbgJZRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:47:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:18462 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788355AbgJZRrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:47:12 -0400
IronPort-SDR: PjpLfO3tHYZxVRkyP/LJfPVpL0HExFEeduV7pUo9DOPm8YW0tGyZkw+li9nAxITo01SS7NymE7
 CAvsW+6JVErQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147247828"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="147247828"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 10:47:11 -0700
IronPort-SDR: 87IvYXJf/B2GGXjaPxtnWGtPa1UQjFKLKyR4oNmhVg27NzktJpDbJHodHbu/DIxUaOJGwLdxDI
 MtfgvkZdmtUw==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="535449111"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.226.224]) ([10.249.226.224])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 10:47:08 -0700
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a368355b-4bf3-05b8-9fa0-ee3feb58f8bf@linux.intel.com>
Date:   Mon, 26 Oct 2020 20:47:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024154317.GB2589351@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.10.2020 18:43, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 06:57:53PM +0300, Alexey Budankov wrote:
>>
>> Open files located at trace data directory in case read access
>> mode is requested. File are opened and its fds assigned to
>> perf_data dir files especially for loading data directories
>> content in perf report mode.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/data.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
>> index c47aa34fdc0a..6ad61ac6ba67 100644
>> --- a/tools/perf/util/data.c
>> +++ b/tools/perf/util/data.c
>> @@ -321,6 +321,10 @@ static int open_dir(struct perf_data *data)
>>  		return -1;
>>  
>>  	ret = open_file(data);
>> +	if (!ret && perf_data__is_dir(data)) {
>> +		if (perf_data__is_read(data))
>> +			ret = perf_data__open_dir(data);
>> +	}
> 
> perf_data__open_dir is also called from perf_session__new
> is it called twice?

It is not called twice. It is in different branches.
This one is for write and the other one is for read.

Alexei

> 
> jirka
> 
>>  
>>  	/* Cleanup whatever we managed to create so far. */
>>  	if (ret && perf_data__is_write(data))
>> -- 
>> 2.24.1
>>
> 
