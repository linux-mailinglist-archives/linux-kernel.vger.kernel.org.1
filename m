Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9B28BE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403949AbgJLQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:52:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:35518 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390622AbgJLQwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:52:44 -0400
IronPort-SDR: qEZ5V7PJxKLSqDAGOeNV/xaWEaEXJEJd9jw552v9zm73L8pRqa6xvTLiOxIZK9t9jlySLRmjve
 nL+s0FoIrLXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165829527"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="165829527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 09:52:42 -0700
IronPort-SDR: WQON228o5cjV2jjXjJk4CHWOjmpm3P1PQKLPFSKHztBmmW1qef5lTNKM/dEf+fk+ESqMSmyxtx
 StT9W4+ygdBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="299341621"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 12 Oct 2020 09:52:41 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id 112715807A3;
        Mon, 12 Oct 2020 09:52:35 -0700 (PDT)
Subject: Re: [PATCH v1 03/15] perf data: open data directory in read access
 mode
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <9ac7f12e-f5a4-dd91-a19a-bb7e5be27636@linux.intel.com>
 <20201012160339.GB466880@tassilo.jf.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <49bfe810-f1cc-b1c6-67d3-b0a746552fd6@linux.intel.com>
Date:   Mon, 12 Oct 2020 19:52:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201012160339.GB466880@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.10.2020 19:03, Andi Kleen wrote:
> On Mon, Oct 12, 2020 at 11:55:07AM +0300, Alexey Budankov wrote:
>>
>> Open files located at data directory in case of read access mode.
> 
> Need some rationale. Is this a bug fix? Did the case not matter
> before?

This is not a bug fix. The case didn't matter before.

> 
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
>>  
>>  	/* Cleanup whatever we managed to create so far. */
>>  	if (ret && perf_data__is_write(data))
>> -- 
>> 2.24.1

Alexei

