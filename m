Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6567E2B67E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgKQOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:51:17 -0500
Received: from foss.arm.com ([217.140.110.172]:59454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbgKQOvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:51:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE9A101E;
        Tue, 17 Nov 2020 06:51:15 -0800 (PST)
Received: from [10.57.59.185] (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50DE73F718;
        Tue, 17 Nov 2020 06:51:14 -0800 (PST)
Subject: Re: [PATCH 04/13 v4] perf tools: Replace aggregation ID with a struct
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20201113172654.989-1-james.clark@arm.com>
 <20201113172654.989-5-james.clark@arm.com> <20201115211753.GD1081385@krava>
From:   James Clark <james.clark@arm.com>
Message-ID: <a3547b9f-e294-ea58-c262-f1a256c3c9d0@arm.com>
Date:   Tue, 17 Nov 2020 16:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201115211753.GD1081385@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/2020 23:17, Jiri Olsa wrote:
> On Fri, Nov 13, 2020 at 07:26:45PM +0200, James Clark wrote:
> 
> SNIP
> 
>> @@ -754,7 +766,7 @@ static void print_aggr_thread(struct perf_stat_config *config,
>>  	FILE *output = config->output;
>>  	int nthreads = perf_thread_map__nr(counter->core.threads);
>>  	int ncpus = perf_cpu_map__nr(counter->core.cpus);
>> -	int thread, sorted_threads, id;
>> +	int thread, sorted_threads;
>>  	struct perf_aggr_thread_value *buf;
>>  
>>  	buf = sort_aggr_thread(counter, nthreads, ncpus, &sorted_threads, _target);
>> @@ -767,13 +779,12 @@ static void print_aggr_thread(struct perf_stat_config *config,
>>  		if (prefix)
>>  			fprintf(output, "%s", prefix);
>>  
>> -		id = buf[thread].id;
> 
> would it be less changes in here if you kept id with new type?

Yes it did turn out with almost no changes by just changing the type.

James

> 
> jirka
> 
>>  		if (config->stats)
>> -			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
>> +			printout(config, buf[thread].id, 0, buf[thread].counter, buf[thread].uval,
>>  				 prefix, buf[thread].run, buf[thread].ena, 1.0,
>> -				 &config->stats[id]);
>> +				 &config->stats[buf[thread].id.id]);
>>  		else
>> -			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
>> +			printout(config, buf[thread].id, 0, buf[thread].counter, buf[thread].uval,
>>  				 prefix, buf[thread].run, buf[thread].ena, 1.0,
>>  				 &rt_stat);
>>  		fputc('\n', output);
> 
> SNIP
> 
