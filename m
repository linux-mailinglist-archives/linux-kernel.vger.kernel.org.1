Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD12F858F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbhAOTcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732707AbhAOTcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:32:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7998323A6C;
        Fri, 15 Jan 2021 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610739126;
        bh=11rh+iGpci1MyV704b+unQYlIoGS+N6jdb7kdepDGkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLTZ82iBMOc6gK9OUinI2DssqIiL6ypzPBpw4Jld7gs67MMzfMsiXCDGDZvjo+eEk
         3ff7JKDB22UkHgqgAafjgtAmfm5j9tQfR/IPlMTxwr7II12L+CdFeZMqoNHOJjALUX
         RdSXwsVAocOJEyi5IAdl1PVawTFMYhu/Dwtmq8nSCH9B0tpt7Rp/dHQSucDKpdsmI4
         NCf4P46wsOHcsm9y4equ2s4LOPMhtIZ9rjYyGXTYjsoiLf/35vZHzRk5wEvSpopZ4R
         PatqFf4eT0ivIrVYS+/P73ocG4CXqY88l6ruGzWr54SXz0wzosvlkY1ItxK4elWTM1
         BnF7eIn++9zTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2DF240522; Fri, 15 Jan 2021 16:32:38 -0300 (-03)
Date:   Fri, 15 Jan 2021 16:32:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V4 5/6] perf report: Add support for
 PERF_SAMPLE_CODE_PAGE_SIZE
Message-ID: <20210115193238.GH457607@kernel.org>
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
 <20210105195752.43489-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105195752.43489-6-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 05, 2021 at 11:57:51AM -0800, kan.liang@linux.intel.com escreveu:
> From: Stephane Eranian <eranian@google.com>
> 
> Add a new sort dimension "code_page_size" for common sort.
> With this option applied, perf can sort and report by sample's code page
> size.

Ditto, adding your:

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
 
> For example,
> perf report --stdio --sort=comm,symbol,code_page_size
>  # To display the perf.data header info, please use
>  # --header/--header-only options.
>  #
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 3K of event 'mem-loads:uP'
>  # Event count (approx.): 1470769
>  #
>  # Overhead  Command  Symbol                        Code Page Size IPC
>  # [IPC Coverage]
>  # ........  .......  ............................  ..............
>  # ....................
>  #
>      69.56%  dtlb     [.] GetTickCount              4K             -
> 
>      17.93%  dtlb     [.] Calibrate                 4K             -
>  -
>      11.40%  dtlb     [.] __gettimeofday            4K             -
>  -
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  tools/perf/Documentation/perf-report.txt |  1 +
>  tools/perf/util/hist.c                   |  2 ++
>  tools/perf/util/hist.h                   |  1 +
>  tools/perf/util/sort.c                   | 26 ++++++++++++++++++++++++
>  tools/perf/util/sort.h                   |  2 ++
>  5 files changed, 32 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 8f7f4e9605d8..e44045842c5c 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -108,6 +108,7 @@ OPTIONS
>  	- period: Raw number of event count of sample
>  	- time: Separate the samples by time stamp with the resolution specified by
>  	--time-quantum (default 100ms). Specify with overhead and before it.
> +	- code_page_size: the code page size of sampled code address (ip)
>  
>  	By default, comm, dso and symbol keys are used.
>  	(i.e. --sort comm,dso,symbol)
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index a08fb9ea411b..6d50379af90e 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -212,6 +212,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  		hists__new_col_len(hists, HISTC_TIME, 16);
>  	else
>  		hists__new_col_len(hists, HISTC_TIME, 12);
> +	hists__new_col_len(hists, HISTC_CODE_PAGE_SIZE, 6);
>  
>  	if (h->srcline) {
>  		len = MAX(strlen(h->srcline), strlen(sort_srcline.se_header));
> @@ -718,6 +719,7 @@ __hists__add_entry(struct hists *hists,
>  		.cpumode = al->cpumode,
>  		.ip	 = al->addr,
>  		.level	 = al->level,
> +		.code_page_size = sample->code_page_size,
>  		.stat = {
>  			.nr_events = 1,
>  			.period	= sample->period,
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 14f66330923d..361108533a56 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -53,6 +53,7 @@ enum hist_column {
>  	HISTC_DSO_TO,
>  	HISTC_LOCAL_WEIGHT,
>  	HISTC_GLOBAL_WEIGHT,
> +	HISTC_CODE_PAGE_SIZE,
>  	HISTC_MEM_DADDR_SYMBOL,
>  	HISTC_MEM_DADDR_DSO,
>  	HISTC_MEM_PHYS_DADDR,
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 80907bc32683..c00934c91b58 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1491,6 +1491,31 @@ struct sort_entry sort_mem_data_page_size = {
>  	.se_width_idx	= HISTC_MEM_DATA_PAGE_SIZE,
>  };
>  
> +static int64_t
> +sort__code_page_size_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	uint64_t l = left->code_page_size;
> +	uint64_t r = right->code_page_size;
> +
> +	return (int64_t)(r - l);
> +}
> +
> +static int hist_entry__code_page_size_snprintf(struct hist_entry *he, char *bf,
> +					  size_t size, unsigned int width)
> +{
> +	char str[PAGE_SIZE_NAME_LEN];
> +
> +	return repsep_snprintf(bf, size, "%-*s", width,
> +			       get_page_size_name(he->code_page_size, str));
> +}
> +
> +struct sort_entry sort_code_page_size = {
> +	.se_header	= "Code Page Size",
> +	.se_cmp		= sort__code_page_size_cmp,
> +	.se_snprintf	= hist_entry__code_page_size_snprintf,
> +	.se_width_idx	= HISTC_CODE_PAGE_SIZE,
> +};
> +
>  static int64_t
>  sort__abort_cmp(struct hist_entry *left, struct hist_entry *right)
>  {
> @@ -1735,6 +1760,7 @@ static struct sort_dimension common_sort_dimensions[] = {
>  	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
>  	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
>  	DIM(SORT_TIME, "time", sort_time),
> +	DIM(SORT_CODE_PAGE_SIZE, "code_page_size", sort_code_page_size),
>  };
>  
>  #undef DIM
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index e50f2b695bc4..cab4172a6ec3 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -106,6 +106,7 @@ struct hist_entry {
>  	u64			transaction;
>  	s32			socket;
>  	s32			cpu;
> +	u64			code_page_size;
>  	u8			cpumode;
>  	u8			depth;
>  
> @@ -229,6 +230,7 @@ enum sort_type {
>  	SORT_CGROUP_ID,
>  	SORT_SYM_IPC_NULL,
>  	SORT_TIME,
> +	SORT_CODE_PAGE_SIZE,
>  
>  	/* branch stack specific sort keys */
>  	__SORT_BRANCH_STACK,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
