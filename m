Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422FF2D1A6D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLGUUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:20:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:13872 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgLGUUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:20:55 -0500
IronPort-SDR: TUS7moYoyR/pKKdzTGqu2nYrAVgQKdkJ9vUiIJsOoqJrV7FNvJkpobFvqPutOmNhlsCnWi3rrg
 ehjQAQyxwsZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="160813006"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="160813006"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 12:19:08 -0800
IronPort-SDR: eH/0L0lHIKqhbUdOzB+Q5wRjYpj61qppwNzbvIi3jM2xUzElpyrx6dw88rDpNgIlIcNauS80Yd
 W55WsCAB2Fsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="541619292"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2020 12:19:08 -0800
Received: from [10.251.11.130] (kliang2-MOBL.ccr.corp.intel.com [10.251.11.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6BFBC5805B9;
        Mon,  7 Dec 2020 12:19:07 -0800 (PST)
Subject: Re: [PATCH V2 06/12] perf mem: Clean up output format
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
 <20201130172803.2676-7-kan.liang@linux.intel.com>
 <20201204232756.GK3613628@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <978f0cb9-43d6-1ae5-e1ce-5ec4cc9fca12@linux.intel.com>
Date:   Mon, 7 Dec 2020 15:19:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201204232756.GK3613628@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2020 6:27 PM, Jiri Olsa wrote:
> On Mon, Nov 30, 2020 at 09:27:57AM -0800, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>> @@ -172,7 +172,7 @@ dump_raw_samples(struct perf_tool *tool,
>>   {
>>   	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
>>   	struct addr_location al;
>> -	const char *fmt;
>> +	const char *fmt, *field_sep;
>>   
>>   	if (machine__resolve(machine, &al, sample) < 0) {
>>   		fprintf(stderr, "problem processing %d event, skipping it.\n",
>> @@ -186,60 +186,41 @@ dump_raw_samples(struct perf_tool *tool,
>>   	if (al.map != NULL)
>>   		al.map->dso->hit = 1;
>>   
>> -	if (mem->phys_addr) {
>> -		if (symbol_conf.field_sep) {
>> -			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s0x%016"PRIx64
>> -			      "%s%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
>> -		} else {
>> -			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
>> -			      "%s0x%016"PRIx64"%s%5"PRIu64"%s0x%06"PRIx64
>> -			      "%s%s:%s\n";
>> -			symbol_conf.field_sep = " ";
>> -		}
>> -
>> -		printf(fmt,
>> -			sample->pid,
>> -			symbol_conf.field_sep,
>> -			sample->tid,
>> -			symbol_conf.field_sep,
>> -			sample->ip,
>> -			symbol_conf.field_sep,
>> -			sample->addr,
>> -			symbol_conf.field_sep,
>> -			sample->phys_addr,
>> -			symbol_conf.field_sep,
>> -			sample->weight,
>> -			symbol_conf.field_sep,
>> -			sample->data_src,
>> -			symbol_conf.field_sep,
>> -			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
>> -			al.sym ? al.sym->name : "???");
>> +	field_sep = symbol_conf.field_sep;
> 
> hum, what's the point of having field_sep?


To keep the fmt consistent.

The patch divides the "printf(fmt,..." into two part. In the first half 
part, the symbol_conf.field_sep may be modified to " ";
In the second half part, we should not use the modified 
symbol_conf.field_sep for the below check. The field_sep keeps the 
original value and should be used.



> 
>> +	if (field_sep) {
>> +		fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s";
>>   	} else {
>> -		if (symbol_conf.field_sep) {
>> -			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s%"PRIu64
>> -			      "%s0x%"PRIx64"%s%s:%s\n";
>> -		} else {
>> -			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
>> -			      "%s%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
>> -			symbol_conf.field_sep = " ";
>> -		}
>> +		fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64"%s";
>> +		symbol_conf.field_sep = " ";
>> +	}
>> +	printf(fmt,
>> +		sample->pid,
>> +		symbol_conf.field_sep,
>> +		sample->tid,
>> +		symbol_conf.field_sep,
>> +		sample->ip,
>> +		symbol_conf.field_sep,
>> +		sample->addr,
>> +		symbol_conf.field_sep);
>>   
>> -		printf(fmt,
>> -			sample->pid,
>> -			symbol_conf.field_sep,
>> -			sample->tid,
>> -			symbol_conf.field_sep,
>> -			sample->ip,
>> -			symbol_conf.field_sep,
>> -			sample->addr,
>> -			symbol_conf.field_sep,
>> -			sample->weight,
>> -			symbol_conf.field_sep,
>> -			sample->data_src,
>> -			symbol_conf.field_sep,
>> -			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
>> -			al.sym ? al.sym->name : "???");
>> +	if (mem->phys_addr) {
>> +		printf("0x%016"PRIx64"%s",
>> +			sample->phys_addr,
>> +			symbol_conf.field_sep);
>>   	}
>> +
>> +	if (field_sep)
>> +		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
>> +	else
>> +		fmt = "%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
>> +
>> +	printf(fmt,
>> +		sample->weight,
>> +		symbol_conf.field_sep,
>> +		sample->data_src,
>> +		symbol_conf.field_sep,
>> +		al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
>> +		al.sym ? al.sym->name : "???");
>>   out_put:
>>   	addr_location__put(&al);
>>   	return 0;
>> @@ -287,10 +268,12 @@ static int report_raw_events(struct perf_mem *mem)
>>   	if (ret < 0)
>>   		goto out_delete;
>>   
>> +	printf("# PID, TID, IP, ADDR, ");
>> +
>>   	if (mem->phys_addr)
>> -		printf("# PID, TID, IP, ADDR, PHYS ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
>> -	else
>> -		printf("# PID, TID, IP, ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
>> +		printf("PHYS ADDR, ");
>> +
>> +	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
> 
> if phys addr is the only member, can't we just squeeze it via
>    "%s", mem->phys_addr ? "PHYS ADDR" : "",
> like I mentioned in the other reply? and same also above?
> 

The phys addr is not the only member, the next patch (07/12) will add 
data page size as a new member.  So I factor out phys_addr in this and 
the previous patch (05/12).

Thanks,
Kan
