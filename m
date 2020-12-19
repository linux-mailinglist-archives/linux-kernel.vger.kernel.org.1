Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EDF2DF1B2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 21:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgLSU5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 15:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgLSU5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 15:57:06 -0500
Date:   Sat, 19 Dec 2020 17:56:39 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608411385;
        bh=9fsZJEeIQUUhm4YBKRNbWOgZAX7ecLavuROuXv233no=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=qG+DRAcr+7H5rIQh152/tMq/RAAkmRQwLkeRRMyr+N76vfzoUHPNT/Wp05DuRqR7s
         q5n6Cp6ofr/WglcyllkvcRoCoPgDiGj3HVI2a/5+VQK18Q0AnP8UeMT1Em9nhPI9Vr
         snoVtwbNpDTxf3uRtUzNkENSbxIamMFg1wSsZ+uslL6W5kw0H4JeXeq0DruCix7q9n
         MW355CDkOfLHAjcXlXQMOXxxBZ5/JkIPGPgLa7h41LE1Xv3eUU6EemXe60f4HSZz9f
         kc7R8u0ggk++Jb2zbNPgz2luAHcF2s3n0EoohtM50An9KqHTL1ck2d9mDV7+N4NJCk
         gYTtBWm1ZGCZg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V3 5/9] perf mem: Support data page size
Message-ID: <20201219205639.GB363602@kernel.org>
References: <20201216185805.9981-1-kan.liang@linux.intel.com>
 <20201216185805.9981-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216185805.9981-6-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 16, 2020 at 10:58:01AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Add option --data-page-size in "perf mem" to record/report data page
> size.
> 
> Here are some examples.
> perf mem --phys-data --data-page-size report -D

So I stopped at this cset, it isn't applying to my tree, I'll test what
I have, which is up to the patch before this one and push to Linus, as
the window is closing.

- Arnaldo
 
>  # PID, TID, IP, ADDR, PHYS ADDR, DATA PAGE SIZE, LOCAL WEIGHT, DSRC,
>  # SYMBOL
> 20134 20134 0xffffffffb5bd2fd0 0x016ffff9a274e96a308 0x000000044e96a308
> 4K  1168 0x5080144
> /lib/modules/4.18.0-rc7+/build/vmlinux:perf_ctx_unlock
> 20134 20134 0xffffffffb63f645c 0xffffffffb752b814 0xcfb52b814 2M 225
> 0x26a100142 /lib/modules/4.18.0-rc7+/build/vmlinux:_raw_spin_lock
> 20134 20134 0xffffffffb660300c 0xfffffe00016b8bb0 0x0 4K 0 0x5080144
> /lib/modules/4.18.0-rc7+/build/vmlinux:__x86_indirect_thunk_rax
> 
> perf mem --phys-data --data-page-size report --stdio
> 
>  # To display the perf.data header info, please use
>  # --header/--header-only options.
>  #
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 5K of event 'cpu/mem-loads,ldlat=30/P'
>  # Total weight : 281234
>  # Sort order   :
>  # mem,sym,dso,symbol_daddr,dso_daddr,tlb,locked,phys_daddr,data_page_size
>  #
>  # Overhead       Samples  Memory access             Symbol
>  # Shared Object     Data Symbol                                  Data
>  # Object              TLB access              Locked  Data Physical
>  # Address   Data Page Size
>  # ........  ............  ........................
>  # ................................  ................
>  # ...........................................  .......................
>  # ......................  ......  ......................
>  # ......................
>  #
>     28.54%          1826  L1 or L1 hit              [k]
> __x86_indirect_thunk_rax      [kernel.vmlinux]  [k] 0xffffb0df31b0ff28
> [unknown]                L1 or L2 hit            No      [k]
> 0000000000000000    4K
>      6.02%           256  L1 or L1 hit              [.] touch_buffer
> dtlb              [.] 0x00007ffd50109da8                       [stack]
> L1 or L2 hit            No      [.] 0x000000042454ada8  4K
>      3.23%             5  L1 or L1 hit              [k] clear_huge_page
> [kernel.vmlinux]  [k] 0xffff9a2753b8ce60                       [unknown]
> L1 or L2 hit            No      [k] 0x0000000453b8ce60  2M
>      2.98%             4  L1 or L1 hit              [k] clear_page_erms
> [kernel.vmlinux]  [k] 0xffffb0df31b0fd00                       [unknown]
> L1 or L2 hit            No      [k] 0000000000000000    4K
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-mem.txt |  3 +++
>  tools/perf/builtin-mem.c              | 20 +++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
> index 199ea0f0a6c0..66177511c5c4 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -63,6 +63,9 @@ OPTIONS
>  --phys-data::
>  	Record/Report sample physical addresses
>  
> +--data-page-size::
> +	Record/Report sample data address page size
> +
>  RECORD OPTIONS
>  --------------
>  -e::
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 7d6ee2208709..f3aac85aa9d4 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -30,6 +30,7 @@ struct perf_mem {
>  	bool			dump_raw;
>  	bool			force;
>  	bool			phys_addr;
> +	bool			data_page_size;
>  	int			operation;
>  	const char		*cpu_list;
>  	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> @@ -124,6 +125,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  	if (mem->phys_addr)
>  		rec_argv[i++] = "--phys-data";
>  
> +	if (mem->data_page_size)
> +		rec_argv[i++] = "--data-page-size";
> +
>  	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
>  		e = perf_mem_events__ptr(j);
>  		if (!e->record)
> @@ -173,6 +177,7 @@ dump_raw_samples(struct perf_tool *tool,
>  	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
>  	struct addr_location al;
>  	const char *fmt, *field_sep;
> +	char str[PAGE_SIZE_NAME_LEN];
>  
>  	if (machine__resolve(machine, &al, sample) < 0) {
>  		fprintf(stderr, "problem processing %d event, skipping it.\n",
> @@ -209,6 +214,12 @@ dump_raw_samples(struct perf_tool *tool,
>  			symbol_conf.field_sep);
>  	}
>  
> +	if (mem->data_page_size) {
> +		printf("%s%s",
> +			get_page_size_name(sample->data_page_size, str),
> +			symbol_conf.field_sep);
> +	}
> +
>  	if (field_sep)
>  		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
>  	else
> @@ -273,6 +284,9 @@ static int report_raw_events(struct perf_mem *mem)
>  	if (mem->phys_addr)
>  		printf("PHYS ADDR, ");
>  
> +	if (mem->data_page_size)
> +		printf("DATA PAGE SIZE, ");
> +
>  	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
>  
>  	ret = perf_session__process_events(session);
> @@ -283,7 +297,7 @@ static int report_raw_events(struct perf_mem *mem)
>  }
>  static char *get_sort_order(struct perf_mem *mem)
>  {
> -	bool has_extra_options = mem->phys_addr ? true : false;
> +	bool has_extra_options = (mem->phys_addr | mem->data_page_size) ? true : false;
>  	char sort[128];
>  
>  	/*
> @@ -302,6 +316,9 @@ static char *get_sort_order(struct perf_mem *mem)
>  	if (mem->phys_addr)
>  		strcat(sort, ",phys_daddr");
>  
> +	if (mem->data_page_size)
> +		strcat(sort, ",data_page_size");
> +
>  	return strdup(sort);
>  }
>  
> @@ -447,6 +464,7 @@ int cmd_mem(int argc, const char **argv)
>  		   " between columns '.' is reserved."),
>  	OPT_BOOLEAN('f', "force", &mem.force, "don't complain, do it"),
>  	OPT_BOOLEAN('p', "phys-data", &mem.phys_addr, "Record/Report sample physical addresses"),
> +	OPT_BOOLEAN(0, "data-page-size", &mem.data_page_size, "Record/Report sample data address page size"),
>  	OPT_END()
>  	};
>  	const char *const mem_subcommands[] = { "record", "report", NULL };
> -- 
> 2.17.1
> 

-- 

- Arnaldo
