Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29072F855C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbhAOTZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:25:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbhAOTZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:25:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF5B1235F8;
        Fri, 15 Jan 2021 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610738705;
        bh=HMWOVu+jxa9Wz51UwRxjdmB7PXu3oXqE0Je8SSbJ2RQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=llmE3HM2F+3JlBb6IOFmRtVSpg/RXQoW55Ekw/ouaW1Zfw5f/hXpaZpJSQtQrV7wx
         kwkLZTAafq5upWcwR9wlHT7Y1uWD+foyoXR18CEZ4eanY3LpyvyFQ3T/XvotjzGYI2
         gbuRMQzeUN86ElgHAUW2Ai1xnTnachlyaBBhbhlhYs2bNP78CNRCFSlv3nC71NcQqf
         JFv4OQ4b7dPvb2duno4YrC59Wa79yhzZ0tic5h09JWDSEJY6AAfcKPKyDlgf5OrPMS
         0YMza5PgYOU5QXkLjXwxsZIdVJDgR8UIlCc9/qAzzqejsNTK4IV+hW6+TWQXGuQ5Oi
         ku+aX8X8AnE/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36BF540522; Fri, 15 Jan 2021 16:25:38 -0300 (-03)
Date:   Fri, 15 Jan 2021 16:25:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V4 4/6] perf script: Add support for
 PERF_SAMPLE_CODE_PAGE_SIZE
Message-ID: <20210115192538.GG457607@kernel.org>
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
 <20210105195752.43489-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105195752.43489-5-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 05, 2021 at 11:57:50AM -0800, kan.liang@linux.intel.com escreveu:
> From: Stephane Eranian <eranian@google.com>
> 
> Display sampled code page sizes when PERF_SAMPLE_CODE_PAGE_SIZE was set.
> 
> For example,
> perf script --fields comm,event,ip,code_page_size
>             dtlb mem-loads:uP:            445777 4K
>             dtlb mem-loads:uP:            40f724 4K
>             dtlb mem-loads:uP:            474926 4K
>             dtlb mem-loads:uP:            401075 4K
>             dtlb mem-loads:uP:            401095 4K
>             dtlb mem-loads:uP:            401095 4K
>             dtlb mem-loads:uP:            4010cc 4K
>             dtlb mem-loads:uP:            440b6f 4K
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>

You missed your Signed-off-by, I'm adding it, please ack this change.

- Arnaldo

> ---
>  tools/perf/Documentation/perf-script.txt |  2 +-
>  tools/perf/builtin-script.c              | 13 +++++++++++--
>  tools/perf/util/session.c                |  3 +++
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 44d37210fc8f..60dae302db27 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -118,7 +118,7 @@ OPTIONS
>          comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
>          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
>          brstackinsn, brstackoff, callindent, insn, insnlen, synth, phys_addr,
> -        metric, misc, srccode, ipc, data_page_size.
> +        metric, misc, srccode, ipc, data_page_size, code_page_size.
>          Field list can be prepended with the type, trace, sw or hw,
>          to indicate to which event type the field list applies.
>          e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index edacfa98d073..9e995311a9b8 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -117,6 +117,7 @@ enum perf_output_field {
>  	PERF_OUTPUT_IPC             = 1ULL << 31,
>  	PERF_OUTPUT_TOD             = 1ULL << 32,
>  	PERF_OUTPUT_DATA_PAGE_SIZE  = 1ULL << 33,
> +	PERF_OUTPUT_CODE_PAGE_SIZE  = 1ULL << 34,
>  };
>  
>  struct perf_script {
> @@ -182,6 +183,7 @@ struct output_option {
>  	{.str = "ipc", .field = PERF_OUTPUT_IPC},
>  	{.str = "tod", .field = PERF_OUTPUT_TOD},
>  	{.str = "data_page_size", .field = PERF_OUTPUT_DATA_PAGE_SIZE},
> +	{.str = "code_page_size", .field = PERF_OUTPUT_CODE_PAGE_SIZE},
>  };
>  
>  enum {
> @@ -255,7 +257,7 @@ static struct {
>  			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
>  			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
>  			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR |
> -			      PERF_OUTPUT_DATA_PAGE_SIZE,
> +			      PERF_OUTPUT_DATA_PAGE_SIZE | PERF_OUTPUT_CODE_PAGE_SIZE,
>  
>  		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
>  	},
> @@ -507,6 +509,10 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  	    evsel__check_stype(evsel, PERF_SAMPLE_DATA_PAGE_SIZE, "DATA_PAGE_SIZE", PERF_OUTPUT_DATA_PAGE_SIZE))
>  		return -EINVAL;
>  
> +	if (PRINT_FIELD(CODE_PAGE_SIZE) &&
> +	    evsel__check_stype(evsel, PERF_SAMPLE_CODE_PAGE_SIZE, "CODE_PAGE_SIZE", PERF_OUTPUT_CODE_PAGE_SIZE))
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  
> @@ -2020,6 +2026,9 @@ static void process_event(struct perf_script *script,
>  	if (PRINT_FIELD(DATA_PAGE_SIZE))
>  		fprintf(fp, " %s", get_page_size_name(sample->data_page_size, str));
>  
> +	if (PRINT_FIELD(CODE_PAGE_SIZE))
> +		fprintf(fp, " %s", get_page_size_name(sample->code_page_size, str));
> +
>  	perf_sample__fprintf_ipc(sample, attr, fp);
>  
>  	fprintf(fp, "\n");
> @@ -3519,7 +3528,7 @@ int cmd_script(int argc, const char **argv)
>  		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
>  		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
>  		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,tod,"
> -		     "data_page_size",
> +		     "data_page_size,code_page_size",
>  		     parse_output_fields),
>  	OPT_BOOLEAN('a', "all-cpus", &system_wide,
>  		    "system-wide collection from all CPUs"),
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 357d6b972b9d..492c994c948a 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1312,6 +1312,9 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
>  	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
>  		printf(" .. data page size: %s\n", get_page_size_name(sample->data_page_size, str));
>  
> +	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
> +		printf(" .. code page size: %s\n", get_page_size_name(sample->code_page_size, str));
> +
>  	if (sample_type & PERF_SAMPLE_TRANSACTION)
>  		printf("... transaction: %" PRIx64 "\n", sample->transaction);
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
