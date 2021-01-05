Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6192EAC7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbhAEN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:57:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:59030 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbhAEN5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:57:16 -0500
IronPort-SDR: xhQR7ni/tXEa+7jTEGFvIHb14n+MkyKUmKhpyT//W3Y1wQWTOCkT1+0rGJ+VTo+9K4BTIuIHt7
 YHPJeHgSUB/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="164808793"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="164808793"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 05:55:30 -0800
IronPort-SDR: wNwm/Z/QSI0P+s1OCoJY3ZN/mogxeMpYRV7iN5RIZyc4YzcPbN0+VOTBkytcIgOVaZapE3lD3H
 f/S0QhiAKmng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="462303870"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jan 2021 05:55:29 -0800
Received: from [10.255.229.128] (kliang2-MOBL.ccr.corp.intel.com [10.255.229.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BD2F25808B7;
        Tue,  5 Jan 2021 05:55:28 -0800 (PST)
Subject: Re: [PATCH V3 5/9] perf mem: Support data page size
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
References: <20201216185805.9981-1-kan.liang@linux.intel.com>
 <20201216185805.9981-6-kan.liang@linux.intel.com>
 <20201219205639.GB363602@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <52ba235a-93b9-c556-ca7a-7dd2caf3333c@linux.intel.com>
Date:   Tue, 5 Jan 2021 08:55:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201219205639.GB363602@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/2020 3:56 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 16, 2020 at 10:58:01AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Add option --data-page-size in "perf mem" to record/report data page
>> size.
>>
>> Here are some examples.
>> perf mem --phys-data --data-page-size report -D
> 
> So I stopped at this cset, it isn't applying to my tree, I'll test what
> I have, which is up to the patch before this one and push to Linus, as
> the window is closing.

Hi Arnaldo,

Sorry for the late response. I was on vacation.

I will rebase the rest of the patches on top of your perf/core branch 
and send them out shortly.

Thanks,
Kan

> 
> - Arnaldo
>   
>>   # PID, TID, IP, ADDR, PHYS ADDR, DATA PAGE SIZE, LOCAL WEIGHT, DSRC,
>>   # SYMBOL
>> 20134 20134 0xffffffffb5bd2fd0 0x016ffff9a274e96a308 0x000000044e96a308
>> 4K  1168 0x5080144
>> /lib/modules/4.18.0-rc7+/build/vmlinux:perf_ctx_unlock
>> 20134 20134 0xffffffffb63f645c 0xffffffffb752b814 0xcfb52b814 2M 225
>> 0x26a100142 /lib/modules/4.18.0-rc7+/build/vmlinux:_raw_spin_lock
>> 20134 20134 0xffffffffb660300c 0xfffffe00016b8bb0 0x0 4K 0 0x5080144
>> /lib/modules/4.18.0-rc7+/build/vmlinux:__x86_indirect_thunk_rax
>>
>> perf mem --phys-data --data-page-size report --stdio
>>
>>   # To display the perf.data header info, please use
>>   # --header/--header-only options.
>>   #
>>   #
>>   # Total Lost Samples: 0
>>   #
>>   # Samples: 5K of event 'cpu/mem-loads,ldlat=30/P'
>>   # Total weight : 281234
>>   # Sort order   :
>>   # mem,sym,dso,symbol_daddr,dso_daddr,tlb,locked,phys_daddr,data_page_size
>>   #
>>   # Overhead       Samples  Memory access             Symbol
>>   # Shared Object     Data Symbol                                  Data
>>   # Object              TLB access              Locked  Data Physical
>>   # Address   Data Page Size
>>   # ........  ............  ........................
>>   # ................................  ................
>>   # ...........................................  .......................
>>   # ......................  ......  ......................
>>   # ......................
>>   #
>>      28.54%          1826  L1 or L1 hit              [k]
>> __x86_indirect_thunk_rax      [kernel.vmlinux]  [k] 0xffffb0df31b0ff28
>> [unknown]                L1 or L2 hit            No      [k]
>> 0000000000000000    4K
>>       6.02%           256  L1 or L1 hit              [.] touch_buffer
>> dtlb              [.] 0x00007ffd50109da8                       [stack]
>> L1 or L2 hit            No      [.] 0x000000042454ada8  4K
>>       3.23%             5  L1 or L1 hit              [k] clear_huge_page
>> [kernel.vmlinux]  [k] 0xffff9a2753b8ce60                       [unknown]
>> L1 or L2 hit            No      [k] 0x0000000453b8ce60  2M
>>       2.98%             4  L1 or L1 hit              [k] clear_page_erms
>> [kernel.vmlinux]  [k] 0xffffb0df31b0fd00                       [unknown]
>> L1 or L2 hit            No      [k] 0000000000000000    4K
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> Acked-by: Jiri Olsa <jolsa@redhat.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/Documentation/perf-mem.txt |  3 +++
>>   tools/perf/builtin-mem.c              | 20 +++++++++++++++++++-
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
>> index 199ea0f0a6c0..66177511c5c4 100644
>> --- a/tools/perf/Documentation/perf-mem.txt
>> +++ b/tools/perf/Documentation/perf-mem.txt
>> @@ -63,6 +63,9 @@ OPTIONS
>>   --phys-data::
>>   	Record/Report sample physical addresses
>>   
>> +--data-page-size::
>> +	Record/Report sample data address page size
>> +
>>   RECORD OPTIONS
>>   --------------
>>   -e::
>> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
>> index 7d6ee2208709..f3aac85aa9d4 100644
>> --- a/tools/perf/builtin-mem.c
>> +++ b/tools/perf/builtin-mem.c
>> @@ -30,6 +30,7 @@ struct perf_mem {
>>   	bool			dump_raw;
>>   	bool			force;
>>   	bool			phys_addr;
>> +	bool			data_page_size;
>>   	int			operation;
>>   	const char		*cpu_list;
>>   	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
>> @@ -124,6 +125,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>>   	if (mem->phys_addr)
>>   		rec_argv[i++] = "--phys-data";
>>   
>> +	if (mem->data_page_size)
>> +		rec_argv[i++] = "--data-page-size";
>> +
>>   	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
>>   		e = perf_mem_events__ptr(j);
>>   		if (!e->record)
>> @@ -173,6 +177,7 @@ dump_raw_samples(struct perf_tool *tool,
>>   	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
>>   	struct addr_location al;
>>   	const char *fmt, *field_sep;
>> +	char str[PAGE_SIZE_NAME_LEN];
>>   
>>   	if (machine__resolve(machine, &al, sample) < 0) {
>>   		fprintf(stderr, "problem processing %d event, skipping it.\n",
>> @@ -209,6 +214,12 @@ dump_raw_samples(struct perf_tool *tool,
>>   			symbol_conf.field_sep);
>>   	}
>>   
>> +	if (mem->data_page_size) {
>> +		printf("%s%s",
>> +			get_page_size_name(sample->data_page_size, str),
>> +			symbol_conf.field_sep);
>> +	}
>> +
>>   	if (field_sep)
>>   		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
>>   	else
>> @@ -273,6 +284,9 @@ static int report_raw_events(struct perf_mem *mem)
>>   	if (mem->phys_addr)
>>   		printf("PHYS ADDR, ");
>>   
>> +	if (mem->data_page_size)
>> +		printf("DATA PAGE SIZE, ");
>> +
>>   	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
>>   
>>   	ret = perf_session__process_events(session);
>> @@ -283,7 +297,7 @@ static int report_raw_events(struct perf_mem *mem)
>>   }
>>   static char *get_sort_order(struct perf_mem *mem)
>>   {
>> -	bool has_extra_options = mem->phys_addr ? true : false;
>> +	bool has_extra_options = (mem->phys_addr | mem->data_page_size) ? true : false;
>>   	char sort[128];
>>   
>>   	/*
>> @@ -302,6 +316,9 @@ static char *get_sort_order(struct perf_mem *mem)
>>   	if (mem->phys_addr)
>>   		strcat(sort, ",phys_daddr");
>>   
>> +	if (mem->data_page_size)
>> +		strcat(sort, ",data_page_size");
>> +
>>   	return strdup(sort);
>>   }
>>   
>> @@ -447,6 +464,7 @@ int cmd_mem(int argc, const char **argv)
>>   		   " between columns '.' is reserved."),
>>   	OPT_BOOLEAN('f', "force", &mem.force, "don't complain, do it"),
>>   	OPT_BOOLEAN('p', "phys-data", &mem.phys_addr, "Record/Report sample physical addresses"),
>> +	OPT_BOOLEAN(0, "data-page-size", &mem.data_page_size, "Record/Report sample data address page size"),
>>   	OPT_END()
>>   	};
>>   	const char *const mem_subcommands[] = { "record", "report", NULL };
>> -- 
>> 2.17.1
>>
> 
