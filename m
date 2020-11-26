Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00642C5B08
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404550AbgKZRs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404191AbgKZRs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:48:58 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E692053B;
        Thu, 26 Nov 2020 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606412937;
        bh=F1BSjmQM9ALhiKXa6yBdZ6tAqKerL8aFo9e3Lq9AalE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejaVufY6pvfZdY5Yn58UuwGxGghVSVcg8WfJmEyP/PrVyGJ9DRDGkZHiLm9xhbhM1
         908KiL7hkmM84L37hPHeKo9Npu+evt8Gfwagi7Te/zoy3D9BhYUUps23fHA9eJa0ta
         aL9NkzjdnFfDNfdrdKk7zafRTrfgl1Oildhu81IE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E85A240E29; Thu, 26 Nov 2020 14:48:54 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:48:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 11/25] perf tools: Use struct extra_kernel_map in
 machine__process_kernel_mmap_event
Message-ID: <20201126174854.GC70905@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-12-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-12-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:12PM +0100, Jiri Olsa escreveu:
> Using struct extra_kernel_map in machine__process_kernel_mmap_event,
> to pass mmap details. This way we can used single function for all 3
> mmap versions.

Thanks, applied.

- Arnaldo

 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/machine.c | 62 +++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 15385ea00190..1ae32a81639c 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1581,32 +1581,25 @@ static bool machine__uses_kcore(struct machine *machine)
>  }
>  
>  static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
> -					     union perf_event *event)
> +					     struct extra_kernel_map *xm)
>  {
>  	return machine__is(machine, "x86_64") &&
> -	       is_entry_trampoline(event->mmap.filename);
> +	       is_entry_trampoline(xm->name);
>  }
>  
>  static int machine__process_extra_kernel_map(struct machine *machine,
> -					     union perf_event *event)
> +					     struct extra_kernel_map *xm)
>  {
>  	struct dso *kernel = machine__kernel_dso(machine);
> -	struct extra_kernel_map xm = {
> -		.start = event->mmap.start,
> -		.end   = event->mmap.start + event->mmap.len,
> -		.pgoff = event->mmap.pgoff,
> -	};
>  
>  	if (kernel == NULL)
>  		return -1;
>  
> -	strlcpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
> -
> -	return machine__create_extra_kernel_map(machine, kernel, &xm);
> +	return machine__create_extra_kernel_map(machine, kernel, xm);
>  }
>  
>  static int machine__process_kernel_mmap_event(struct machine *machine,
> -					      union perf_event *event)
> +					      struct extra_kernel_map *xm)
>  {
>  	struct map *map;
>  	enum dso_space_type dso_space;
> @@ -1621,20 +1614,18 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
>  	else
>  		dso_space = DSO_SPACE__KERNEL_GUEST;
>  
> -	is_kernel_mmap = memcmp(event->mmap.filename,
> -				machine->mmap_name,
> +	is_kernel_mmap = memcmp(xm->name, machine->mmap_name,
>  				strlen(machine->mmap_name) - 1) == 0;
> -	if (event->mmap.filename[0] == '/' ||
> -	    (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
> -		map = machine__addnew_module_map(machine, event->mmap.start,
> -						 event->mmap.filename);
> +	if (xm->name[0] == '/' ||
> +	    (!is_kernel_mmap && xm->name[0] == '[')) {
> +		map = machine__addnew_module_map(machine, xm->start,
> +						 xm->name);
>  		if (map == NULL)
>  			goto out_problem;
>  
> -		map->end = map->start + event->mmap.len;
> +		map->end = map->start + xm->end - xm->start;
>  	} else if (is_kernel_mmap) {
> -		const char *symbol_name = (event->mmap.filename +
> -				strlen(machine->mmap_name));
> +		const char *symbol_name = (xm->name + strlen(machine->mmap_name));
>  		/*
>  		 * Should be there already, from the build-id table in
>  		 * the header.
> @@ -1688,18 +1679,17 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
>  		if (strstr(kernel->long_name, "vmlinux"))
>  			dso__set_short_name(kernel, "[kernel.vmlinux]", false);
>  
> -		machine__update_kernel_mmap(machine, event->mmap.start,
> -					 event->mmap.start + event->mmap.len);
> +		machine__update_kernel_mmap(machine, xm->start, xm->end);
>  
>  		/*
>  		 * Avoid using a zero address (kptr_restrict) for the ref reloc
>  		 * symbol. Effectively having zero here means that at record
>  		 * time /proc/sys/kernel/kptr_restrict was non zero.
>  		 */
> -		if (event->mmap.pgoff != 0) {
> +		if (xm->pgoff != 0) {
>  			map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map,
>  							symbol_name,
> -							event->mmap.pgoff);
> +							xm->pgoff);
>  		}
>  
>  		if (machine__is_default_guest(machine)) {
> @@ -1708,8 +1698,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
>  			 */
>  			dso__load(kernel, machine__kernel_map(machine));
>  		}
> -	} else if (perf_event__is_extra_kernel_mmap(machine, event)) {
> -		return machine__process_extra_kernel_map(machine, event);
> +	} else if (perf_event__is_extra_kernel_mmap(machine, xm)) {
> +		return machine__process_extra_kernel_map(machine, xm);
>  	}
>  	return 0;
>  out_problem:
> @@ -1735,7 +1725,14 @@ int machine__process_mmap2_event(struct machine *machine,
>  
>  	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
>  	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
> -		ret = machine__process_kernel_mmap_event(machine, event);
> +		struct extra_kernel_map xm = {
> +			.start = event->mmap2.start,
> +			.end   = event->mmap2.start + event->mmap2.len,
> +			.pgoff = event->mmap2.pgoff,
> +		};
> +
> +		strlcpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
> +		ret = machine__process_kernel_mmap_event(machine, &xm);
>  		if (ret < 0)
>  			goto out_problem;
>  		return 0;
> @@ -1785,7 +1782,14 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
>  
>  	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
>  	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
> -		ret = machine__process_kernel_mmap_event(machine, event);
> +		struct extra_kernel_map xm = {
> +			.start = event->mmap.start,
> +			.end   = event->mmap.start + event->mmap.len,
> +			.pgoff = event->mmap.pgoff,
> +		};
> +
> +		strlcpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
> +		ret = machine__process_kernel_mmap_event(machine, &xm);
>  		if (ret < 0)
>  			goto out_problem;
>  		return 0;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
