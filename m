Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C237E2FAA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437498AbhARTjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:39:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394049AbhARTjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:39:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 374C6206BE;
        Mon, 18 Jan 2021 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610998700;
        bh=cBQ486UY7isID70nYjz69yNM0gq5TjIAD72CEseIHMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocqcF2V992M/Cc3yZveLbGBd3Uak1g2NCKI2kVhH5mmOzMy/MhIxXSL7aVOIQVihk
         lXloj4EeT30ffQCImxGx2Fxumxz+yJMt2xwJpA+W8XKft/DbYjrY81V/gDR0yZehFo
         I1YiiA4UIJj+3kSLDbCT6Cskc64TZ+lZ2IHAZqvuE9xmcgMLSNZtfGXsZIol2kdbY7
         nDlxg3gsRcQBmdYcG9JK+99XVJrhCwIvdO4aeTI/FhDmc7JtUHEmiSAOiLvPV4O4bm
         SKSEoDpcKq2tbP/27f7P73HqGegTJHT+mXodIxjSct6R/WHABVihIuCuSLmp+r/DgZ
         jTr5ZAvdAZ0zg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 25DAC40CE2; Mon, 18 Jan 2021 16:38:17 -0300 (-03)
Date:   Mon, 18 Jan 2021 16:38:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mark.rutland@arm.com, jolsa@redhat.com,
        kernel-team@fb.com
Subject: Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF programs
Message-ID: <20210118193817.GG12699@kernel.org>
References: <20201229214214.3413833-1-songliubraving@fb.com>
 <20201229214214.3413833-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229214214.3413833-4-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 29, 2020 at 01:42:14PM -0800, Song Liu escreveu:
> Introduce perf-stat -b option, which counts events for BPF programs, like:
> 
> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>      1.487903822            115,200      ref-cycles
>      1.487903822             86,012      cycles
>      2.489147029             80,560      ref-cycles
>      2.489147029             73,784      cycles
>      3.490341825             60,720      ref-cycles
>      3.490341825             37,797      cycles
>      4.491540887             37,120      ref-cycles
>      4.491540887             31,963      cycles
> 
> The example above counts cycles and ref-cycles of BPF program of id 254.
> This is similar to bpftool-prog-profile command, but more flexible.

So trying to get back to this after vacation:

[root@five ~]# perf stat -vvv -e cycles -b 103
Control descriptor is not initialized
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
libbpf: load bpf program failed: Invalid argument
libbpf: -- BEGIN DUMP LOG ---
libbpf:
Cannot recursively attach
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'fentry_XXX'
libbpf: failed to load object 'bpf_prog_profiler_bpf'
libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -4007
bpf_prog_profiler_bpf__load failed
[root@five ~]#

[root@five perf]# tools/bpf/runqslower/.output/
bpftool/    libbpf/     runqslower
[root@five perf]# tools/bpf/runqslower/.output/runqslower
libbpf: elf: skipping unrecognized data section(10) .eh_frame
libbpf: elf: skipping relo section(17) .rel.eh_frame for section(10) .eh_frame
Tracing run queue latency higher than 10000 us
TIME     COMM             PID           LAT(us)

[root@five ~]# bpftool prog
6: tracing  name dump_bpf_map  tag e54c922dfa54f65f  gpl
	loaded_at 2021-01-15T11:14:38-0300  uid 0
	xlated 256B  jited 154B  memlock 4096B  map_ids 3
	btf_id 6
8: tracing  name dump_bpf_prog  tag 4cb5558b902ee92e  gpl
	loaded_at 2021-01-15T11:14:38-0300  uid 0
	xlated 520B  jited 301B  memlock 4096B  map_ids 3
	btf_id 6
80: cgroup_device  tag 8b9c33f36f812014  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 744B  jited 447B  memlock 4096B
81: cgroup_skb  tag 6deef7357e7b4530  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 64B  jited 54B  memlock 4096B
82: cgroup_skb  tag 6deef7357e7b4530  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 64B  jited 54B  memlock 4096B
83: cgroup_device  tag ee0e253c78993a24  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 416B  jited 255B  memlock 4096B
84: cgroup_device  tag e3dbd137be8d6168  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 504B  jited 309B  memlock 4096B
85: cgroup_skb  tag 6deef7357e7b4530  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 64B  jited 54B  memlock 4096B
86: cgroup_skb  tag 6deef7357e7b4530  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 64B  jited 54B  memlock 4096B
87: cgroup_device  tag c8b47a902f1cc68b  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 464B  jited 288B  memlock 4096B
88: cgroup_device  tag 0ecd07b7b633809f  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 496B  jited 307B  memlock 4096B
89: cgroup_skb  tag 6deef7357e7b4530  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 64B  jited 54B  memlock 4096B
90: cgroup_skb  tag 6deef7357e7b4530  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 64B  jited 54B  memlock 4096B
91: cgroup_skb  tag 6deef7357e7b4530  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 64B  jited 54B  memlock 4096B
92: cgroup_skb  tag 6deef7357e7b4530  gpl
	loaded_at 2021-01-17T18:35:22-0300  uid 0
	xlated 64B  jited 54B  memlock 4096B
100: tracing  name handle__sched_w  tag 00ba1f1d332f5a57  gpl
	loaded_at 2021-01-18T16:34:00-0300  uid 0
	xlated 152B  jited 93B  memlock 4096B  map_ids 11,9
	btf_id 248
102: tracing  name handle__sched_w  tag 00ba1f1d332f5a57  gpl
	loaded_at 2021-01-18T16:34:00-0300  uid 0
	xlated 152B  jited 93B  memlock 4096B  map_ids 11,9
	btf_id 248
103: tracing  name handle__sched_s  tag a4ac42153fd49be2  gpl
	loaded_at 2021-01-18T16:34:00-0300  uid 0
	xlated 560B  jited 332B  memlock 4096B  map_ids 11,9,10
	btf_id 248
[root@five ~]# perf stat -vvv -e cycles -b 92
Control descriptor is not initialized
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
prog FD 3 doesn't have valid btf
Failed to get program name for bpf prog 92. Does it have BTF?
[root@five ~]# perf stat -vvv -e cycles -b 103
Control descriptor is not initialized
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
libbpf: load bpf program failed: Invalid argument
libbpf: -- BEGIN DUMP LOG ---
libbpf:
Cannot recursively attach
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'fentry_XXX'
libbpf: failed to load object 'bpf_prog_profiler_bpf'
libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -4007
bpf_prog_profiler_bpf__load failed
[root@five ~]# perf stat -vvv -e cycles -b 102
Control descriptor is not initialized
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
libbpf: load bpf program failed: Invalid argument
libbpf: -- BEGIN DUMP LOG ---
libbpf:
Cannot recursively attach
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'fentry_XXX'
libbpf: failed to load object 'bpf_prog_profiler_bpf'
libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -4007
bpf_prog_profiler_bpf__load failed
[root@five ~]#
[root@five ~]# perf stat -vvv -e cycles -b 6
Control descriptor is not initialized
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
libbpf: load bpf program failed: Invalid argument
libbpf: -- BEGIN DUMP LOG ---
libbpf:
Cannot recursively attach
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'fentry_XXX'
libbpf: failed to load object 'bpf_prog_profiler_bpf'
libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -4007
bpf_prog_profiler_bpf__load failed
[root@five ~]#

So no more segfaults, but still something to look at, I'm pushing my
local perf/core to tmp.perf/core, please take a look.

- Arnaldo
 
> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> programs (monitor-progs) to the target BPF program (target-prog). The
> monitor-progs read perf_event before and after the target-prog, and
> aggregate the difference in a BPF map. Then the user space reads data
> from these maps.
> 
> A new struct bpf_counter is introduced to provide common interface that
> uses BPF programs/maps to count perf events.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/Documentation/perf-stat.txt        |  18 +
>  tools/perf/Makefile.perf                      |   2 +-
>  tools/perf/builtin-stat.c                     |  82 ++++-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf_counter.c                 | 309 ++++++++++++++++++
>  tools/perf/util/bpf_counter.h                 |  72 ++++
>  .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
>  tools/perf/util/evsel.c                       |   9 +
>  tools/perf/util/evsel.h                       |   5 +
>  tools/perf/util/python.c                      |  21 ++
>  tools/perf/util/stat-display.c                |   4 +-
>  tools/perf/util/stat.c                        |   2 +-
>  tools/perf/util/target.c                      |  34 +-
>  tools/perf/util/target.h                      |  10 +
>  14 files changed, 644 insertions(+), 18 deletions(-)
>  create mode 100644 tools/perf/util/bpf_counter.c
>  create mode 100644 tools/perf/util/bpf_counter.h
>  create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 5d4a673d7621a..98a4dfd3b2dc9 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -75,6 +75,24 @@ report::
>  --tid=<tid>::
>          stat events on existing thread id (comma separated list)
>  
> +-b::
> +--bpf-prog::
> +        stat events on existing bpf program id (comma separated list),
> +        requiring root rights. bpftool-prog could be used to find program
> +        id all bpf programs in the system. For example:
> +
> +  # bpftool prog | head -n 1
> +  17247: tracepoint  name sys_enter  tag 192d548b9d754067  gpl
> +
> +  # perf stat -e cycles,instructions --bpf-prog 17247 --timeout 1000
> +
> +   Performance counter stats for 'BPF program(s) 17247':
> +
> +             85,967      cycles
> +             28,982      instructions              #    0.34  insn per cycle
> +
> +        1.102235068 seconds time elapsed
> +
>  ifdef::HAVE_LIBPFM[]
>  --pfm-events events::
>  Select a PMU event using libpfm4 syntax (see http://perfmon2.sf.net)
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d182a2dbb9bbd..8c4e039c3b813 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1015,7 +1015,7 @@ python-clean:
>  
>  SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
>  SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
> -SKELETONS :=
> +SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
>  
>  ifdef BUILD_BPF_SKEL
>  BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 8cc24967bc273..3c054b8d4677c 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -67,6 +67,7 @@
>  #include "util/top.h"
>  #include "util/affinity.h"
>  #include "util/pfm.h"
> +#include "util/bpf_counter.h"
>  #include "asm/bug.h"
>  
>  #include <linux/time64.h>
> @@ -409,12 +410,32 @@ static int read_affinity_counters(struct timespec *rs)
>  	return 0;
>  }
>  
> +static int read_bpf_map_counters(void)
> +{
> +	struct evsel *counter;
> +	int err;
> +
> +	evlist__for_each_entry(evsel_list, counter) {
> +		err = bpf_counter__read(counter);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
>  static void read_counters(struct timespec *rs)
>  {
>  	struct evsel *counter;
> +	int err;
>  
> -	if (!stat_config.stop_read_counter && (read_affinity_counters(rs) < 0))
> -		return;
> +	if (!stat_config.stop_read_counter) {
> +		if (target__has_bpf(&target))
> +			err = read_bpf_map_counters();
> +		else
> +			err = read_affinity_counters(rs);
> +		if (err < 0)
> +			return;
> +	}
>  
>  	evlist__for_each_entry(evsel_list, counter) {
>  		if (counter->err)
> @@ -496,11 +517,22 @@ static bool handle_interval(unsigned int interval, int *times)
>  	return false;
>  }
>  
> -static void enable_counters(void)
> +static int enable_counters(void)
>  {
> +	struct evsel *evsel;
> +	int err;
> +
> +	if (target__has_bpf(&target)) {
> +		evlist__for_each_entry(evsel_list, evsel) {
> +			err = bpf_counter__enable(evsel);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
>  	if (stat_config.initial_delay < 0) {
>  		pr_info(EVLIST_DISABLED_MSG);
> -		return;
> +		return 0;
>  	}
>  
>  	if (stat_config.initial_delay > 0) {
> @@ -518,6 +550,7 @@ static void enable_counters(void)
>  		if (stat_config.initial_delay > 0)
>  			pr_info(EVLIST_ENABLED_MSG);
>  	}
> +	return 0;
>  }
>  
>  static void disable_counters(void)
> @@ -720,7 +753,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	const bool forks = (argc > 0);
>  	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
>  	struct affinity affinity;
> -	int i, cpu;
> +	int i, cpu, err;
>  	bool second_pass = false;
>  
>  	if (forks) {
> @@ -737,6 +770,13 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	if (affinity__setup(&affinity) < 0)
>  		return -1;
>  
> +	if (target__has_bpf(&target)) {
> +		evlist__for_each_entry(evsel_list, counter) {
> +			if (bpf_counter__load(counter, &target))
> +				return -1;
> +		}
> +	}
> +
>  	evlist__for_each_cpu (evsel_list, i, cpu) {
>  		affinity__set(&affinity, cpu);
>  
> @@ -850,7 +890,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	}
>  
>  	if (STAT_RECORD) {
> -		int err, fd = perf_data__fd(&perf_stat.data);
> +		int fd = perf_data__fd(&perf_stat.data);
>  
>  		if (is_pipe) {
>  			err = perf_header__write_pipe(perf_data__fd(&perf_stat.data));
> @@ -876,7 +916,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  	if (forks) {
>  		evlist__start_workload(evsel_list);
> -		enable_counters();
> +		err = enable_counters();
> +		if (err)
> +			return -1;
>  
>  		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
>  			status = dispatch_events(forks, timeout, interval, &times);
> @@ -895,7 +937,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		if (WIFSIGNALED(status))
>  			psignal(WTERMSIG(status), argv[0]);
>  	} else {
> -		enable_counters();
> +		err = enable_counters();
> +		if (err)
> +			return -1;
>  		status = dispatch_events(forks, timeout, interval, &times);
>  	}
>  
> @@ -1085,6 +1129,10 @@ static struct option stat_options[] = {
>  		   "stat events on existing process id"),
>  	OPT_STRING('t', "tid", &target.tid, "tid",
>  		   "stat events on existing thread id"),
> +#ifdef HAVE_BPF_SKEL
> +	OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
> +		   "stat events on existing bpf program id"),
> +#endif
>  	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
>  		    "system-wide collection from all CPUs"),
>  	OPT_BOOLEAN('g', "group", &group,
> @@ -2064,11 +2112,12 @@ int cmd_stat(int argc, const char **argv)
>  		"perf stat [<options>] [<command>]",
>  		NULL
>  	};
> -	int status = -EINVAL, run_idx;
> +	int status = -EINVAL, run_idx, err;
>  	const char *mode;
>  	FILE *output = stderr;
>  	unsigned int interval, timeout;
>  	const char * const stat_subcommands[] = { "record", "report" };
> +	char errbuf[BUFSIZ];
>  
>  	setlocale(LC_ALL, "");
>  
> @@ -2179,6 +2228,12 @@ int cmd_stat(int argc, const char **argv)
>  	} else if (big_num_opt == 0) /* User passed --no-big-num */
>  		stat_config.big_num = false;
>  
> +	err = target__validate(&target);
> +	if (err) {
> +		target__strerror(&target, err, errbuf, BUFSIZ);
> +		pr_warning("%s\n", errbuf);
> +	}
> +
>  	setup_system_wide(argc);
>  
>  	/*
> @@ -2252,8 +2307,6 @@ int cmd_stat(int argc, const char **argv)
>  		}
>  	}
>  
> -	target__validate(&target);
> -
>  	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
>  		target.per_thread = true;
>  
> @@ -2384,9 +2437,10 @@ int cmd_stat(int argc, const char **argv)
>  		 * tools remain  -acme
>  		 */
>  		int fd = perf_data__fd(&perf_stat.data);
> -		int err = perf_event__synthesize_kernel_mmap((void *)&perf_stat,
> -							     process_synthesized_event,
> -							     &perf_stat.session->machines.host);
> +
> +		err = perf_event__synthesize_kernel_mmap((void *)&perf_stat,
> +							 process_synthesized_event,
> +							 &perf_stat.session->machines.host);
>  		if (err) {
>  			pr_warning("Couldn't synthesize the kernel mmap record, harmless, "
>  				   "older tools may produce warnings about this file\n.");
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index e2563d0154eb6..188521f343470 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -135,6 +135,7 @@ perf-y += clockid.o
>  
>  perf-$(CONFIG_LIBBPF) += bpf-loader.o
>  perf-$(CONFIG_LIBBPF) += bpf_map.o
> +perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
>  perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
>  perf-$(CONFIG_LIBELF) += symbol-elf.o
>  perf-$(CONFIG_LIBELF) += probe-file.o
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> new file mode 100644
> index 0000000000000..8c977f038f497
> --- /dev/null
> +++ b/tools/perf/util/bpf_counter.c
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Copyright (c) 2019 Facebook */
> +
> +#include <assert.h>
> +#include <limits.h>
> +#include <unistd.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +#include <linux/err.h>
> +#include <linux/zalloc.h>
> +#include <bpf/bpf.h>
> +#include <bpf/btf.h>
> +#include <bpf/libbpf.h>
> +
> +#include "bpf_counter.h"
> +#include "counts.h"
> +#include "debug.h"
> +#include "evsel.h"
> +#include "target.h"
> +
> +#include "bpf_skel/bpf_prog_profiler.skel.h"
> +
> +static inline void *u64_to_ptr(__u64 ptr)
> +{
> +	return (void *)(unsigned long)ptr;
> +}
> +
> +static void set_max_rlimit(void)
> +{
> +	struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
> +
> +	setrlimit(RLIMIT_MEMLOCK, &rinf);
> +}
> +
> +static struct bpf_counter *bpf_counter_alloc(void)
> +{
> +	struct bpf_counter *counter;
> +
> +	counter = zalloc(sizeof(*counter));
> +	if (counter)
> +		INIT_LIST_HEAD(&counter->list);
> +	return counter;
> +}
> +
> +static int bpf_program_profiler__destroy(struct evsel *evsel)
> +{
> +	struct bpf_counter *counter, *tmp;
> +
> +	list_for_each_entry_safe(counter, tmp,
> +				 &evsel->bpf_counter_list, list) {
> +		list_del_init(&counter->list);
> +		bpf_prog_profiler_bpf__destroy(counter->skel);
> +		free(counter);
> +	}
> +	assert(list_empty(&evsel->bpf_counter_list));
> +
> +	return 0;
> +}
> +
> +static char *bpf_target_prog_name(int tgt_fd)
> +{
> +	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_func_info *func_info;
> +	const struct btf_type *t;
> +	char *name = NULL;
> +	struct btf *btf;
> +
> +	info_linear = bpf_program__get_prog_info_linear(
> +		tgt_fd, 1UL << BPF_PROG_INFO_FUNC_INFO);
> +	if (IS_ERR_OR_NULL(info_linear)) {
> +		pr_debug("failed to get info_linear for prog FD %d\n", tgt_fd);
> +		return NULL;
> +	}
> +
> +	if (info_linear->info.btf_id == 0 ||
> +	    btf__get_from_id(info_linear->info.btf_id, &btf)) {
> +		pr_debug("prog FD %d doesn't have valid btf\n", tgt_fd);
> +		goto out;
> +	}
> +
> +	func_info = u64_to_ptr(info_linear->info.func_info);
> +	t = btf__type_by_id(btf, func_info[0].type_id);
> +	if (!t) {
> +		pr_debug("btf %d doesn't have type %d\n",
> +			 info_linear->info.btf_id, func_info[0].type_id);
> +		goto out;
> +	}
> +	name = strdup(btf__name_by_offset(btf, t->name_off));
> +out:
> +	free(info_linear);
> +	return name;
> +}
> +
> +static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
> +{
> +	struct bpf_prog_profiler_bpf *skel;
> +	struct bpf_counter *counter;
> +	struct bpf_program *prog;
> +	char *prog_name;
> +	int prog_fd;
> +	int err;
> +
> +	prog_fd = bpf_prog_get_fd_by_id(prog_id);
> +	if (prog_fd < 0) {
> +		pr_err("Failed to open fd for bpf prog %u\n", prog_id);
> +		return -1;
> +	}
> +	counter = bpf_counter_alloc();
> +	if (!counter) {
> +		close(prog_fd);
> +		return -1;
> +	}
> +
> +	skel = bpf_prog_profiler_bpf__open();
> +	if (!skel) {
> +		pr_err("Failed to open bpf skeleton\n");
> +		goto err_out;
> +	}
> +
> +	skel->rodata->num_cpu = evsel__nr_cpus(evsel);
> +
> +	bpf_map__resize(skel->maps.events, evsel__nr_cpus(evsel));
> +	bpf_map__resize(skel->maps.fentry_readings, 1);
> +	bpf_map__resize(skel->maps.accum_readings, 1);
> +
> +	prog_name = bpf_target_prog_name(prog_fd);
> +	if (!prog_name) {
> +		pr_err("Failed to get program name for bpf prog %u. Does it have BTF?\n", prog_id);
> +		goto err_out;
> +	}
> +
> +	bpf_object__for_each_program(prog, skel->obj) {
> +		err = bpf_program__set_attach_target(prog, prog_fd, prog_name);
> +		if (err) {
> +			pr_err("bpf_program__set_attach_target failed.\n"
> +			       "Does bpf prog %u have BTF?\n", prog_id);
> +			goto err_out;
> +		}
> +	}
> +	set_max_rlimit();
> +	err = bpf_prog_profiler_bpf__load(skel);
> +	if (err) {
> +		pr_err("bpf_prog_profiler_bpf__load failed\n");
> +		goto err_out;
> +	}
> +
> +	assert(skel != NULL);
> +	counter->skel = skel;
> +	list_add(&counter->list, &evsel->bpf_counter_list);
> +	close(prog_fd);
> +	return 0;
> +err_out:
> +	bpf_prog_profiler_bpf__destroy(skel);
> +	free(counter);
> +	close(prog_fd);
> +	return -1;
> +}
> +
> +static int bpf_program_profiler__load(struct evsel *evsel, struct target *target)
> +{
> +	char *bpf_str, *bpf_str_, *tok, *saveptr = NULL, *p;
> +	u32 prog_id;
> +	int ret;
> +
> +	bpf_str_ = bpf_str = strdup(target->bpf_str);
> +	if (!bpf_str)
> +		return -1;
> +
> +	while ((tok = strtok_r(bpf_str, ",", &saveptr)) != NULL) {
> +		prog_id = strtoul(tok, &p, 10);
> +		if (prog_id == 0 || prog_id == UINT_MAX ||
> +		    (*p != '\0' && *p != ',')) {
> +			pr_err("Failed to parse bpf prog ids %s\n",
> +			       target->bpf_str);
> +			return -1;
> +		}
> +
> +		ret = bpf_program_profiler_load_one(evsel, prog_id);
> +		if (ret) {
> +			bpf_program_profiler__destroy(evsel);
> +			free(bpf_str_);
> +			return -1;
> +		}
> +		bpf_str = NULL;
> +	}
> +	free(bpf_str_);
> +	return 0;
> +}
> +
> +static int bpf_program_profiler__enable(struct evsel *evsel)
> +{
> +	struct bpf_counter *counter;
> +	int ret;
> +
> +	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> +		assert(counter->skel != NULL);
> +		ret = bpf_prog_profiler_bpf__attach(counter->skel);
> +		if (ret) {
> +			bpf_program_profiler__destroy(evsel);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int bpf_program_profiler__read(struct evsel *evsel)
> +{
> +	int num_cpu = evsel__nr_cpus(evsel);
> +	struct bpf_perf_event_value values[num_cpu];
> +	struct bpf_counter *counter;
> +	int reading_map_fd;
> +	__u32 key = 0;
> +	int err, cpu;
> +
> +	if (list_empty(&evsel->bpf_counter_list))
> +		return -EAGAIN;
> +
> +	for (cpu = 0; cpu < num_cpu; cpu++) {
> +		perf_counts(evsel->counts, cpu, 0)->val = 0;
> +		perf_counts(evsel->counts, cpu, 0)->ena = 0;
> +		perf_counts(evsel->counts, cpu, 0)->run = 0;
> +	}
> +	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> +		struct bpf_prog_profiler_bpf *skel = counter->skel;
> +
> +		assert(skel != NULL);
> +		reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> +
> +		err = bpf_map_lookup_elem(reading_map_fd, &key, values);
> +		if (err) {
> +			pr_err("failed to read value\n");
> +			return err;
> +		}
> +
> +		for (cpu = 0; cpu < num_cpu; cpu++) {
> +			perf_counts(evsel->counts, cpu, 0)->val += values[cpu].counter;
> +			perf_counts(evsel->counts, cpu, 0)->ena += values[cpu].enabled;
> +			perf_counts(evsel->counts, cpu, 0)->run += values[cpu].running;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
> +					    int fd)
> +{
> +	struct bpf_prog_profiler_bpf *skel;
> +	struct bpf_counter *counter;
> +	int ret;
> +
> +	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> +		skel = counter->skel;
> +		assert(skel != NULL);
> +
> +		ret = bpf_map_update_elem(bpf_map__fd(skel->maps.events),
> +					  &cpu, &fd, BPF_ANY);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +struct bpf_counter_ops bpf_program_profiler_ops = {
> +	.load       = bpf_program_profiler__load,
> +	.enable	    = bpf_program_profiler__enable,
> +	.read       = bpf_program_profiler__read,
> +	.destroy    = bpf_program_profiler__destroy,
> +	.install_pe = bpf_program_profiler__install_pe,
> +};
> +
> +int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd)
> +{
> +	if (list_empty(&evsel->bpf_counter_list))
> +		return 0;
> +	return evsel->bpf_counter_ops->install_pe(evsel, cpu, fd);
> +}
> +
> +int bpf_counter__load(struct evsel *evsel, struct target *target)
> +{
> +	if (target__has_bpf(target))
> +		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
> +
> +	if (evsel->bpf_counter_ops)
> +		return evsel->bpf_counter_ops->load(evsel, target);
> +	return 0;
> +}
> +
> +int bpf_counter__enable(struct evsel *evsel)
> +{
> +	if (list_empty(&evsel->bpf_counter_list))
> +		return 0;
> +	return evsel->bpf_counter_ops->enable(evsel);
> +}
> +
> +int bpf_counter__read(struct evsel *evsel)
> +{
> +	if (list_empty(&evsel->bpf_counter_list))
> +		return -EAGAIN;
> +	return evsel->bpf_counter_ops->read(evsel);
> +}
> +
> +void bpf_counter__destroy(struct evsel *evsel)
> +{
> +	if (list_empty(&evsel->bpf_counter_list))
> +		return;
> +	evsel->bpf_counter_ops->destroy(evsel);
> +	evsel->bpf_counter_ops = NULL;
> +}
> diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> new file mode 100644
> index 0000000000000..2eca210e5dc16
> --- /dev/null
> +++ b/tools/perf/util/bpf_counter.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_BPF_COUNTER_H
> +#define __PERF_BPF_COUNTER_H 1
> +
> +#include <linux/list.h>
> +
> +struct evsel;
> +struct target;
> +struct bpf_counter;
> +
> +typedef int (*bpf_counter_evsel_op)(struct evsel *evsel);
> +typedef int (*bpf_counter_evsel_target_op)(struct evsel *evsel,
> +					   struct target *target);
> +typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
> +					       int cpu,
> +					       int fd);
> +
> +struct bpf_counter_ops {
> +	bpf_counter_evsel_target_op load;
> +	bpf_counter_evsel_op enable;
> +	bpf_counter_evsel_op read;
> +	bpf_counter_evsel_op destroy;
> +	bpf_counter_evsel_install_pe_op install_pe;
> +};
> +
> +struct bpf_counter {
> +	void *skel;
> +	struct list_head list;
> +};
> +
> +#ifdef HAVE_BPF_SKEL
> +
> +int bpf_counter__load(struct evsel *evsel, struct target *target);
> +int bpf_counter__enable(struct evsel *evsel);
> +int bpf_counter__read(struct evsel *evsel);
> +void bpf_counter__destroy(struct evsel *evsel);
> +int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
> +
> +#else /* HAVE_BPF_SKEL */
> +
> +#include<linux/err.h>
> +
> +static inline int bpf_counter__load(struct evsel *evsel __maybe_unused,
> +				    struct target *target __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static inline int bpf_counter__enable(struct evsel *evsel __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static inline int bpf_counter__read(struct evsel *evsel __maybe_unused)
> +{
> +	return -EAGAIN;
> +}
> +
> +static inline void bpf_counter__destroy(struct evsel *evsel __maybe_unused)
> +{
> +}
> +
> +static inline int bpf_counter__install_pe(struct evsel *evsel __maybe_unused,
> +					  int cpu __maybe_unused,
> +					  int fd __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +#endif /* HAVE_BPF_SKEL */
> +
> +#endif /* __PERF_BPF_COUNTER_H */
> diff --git a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> new file mode 100644
> index 0000000000000..c7cec92d02360
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2020 Facebook
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +/* map of perf event fds, num_cpu * num_metric entries */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(int));
> +} events SEC(".maps");
> +
> +/* readings at fentry */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct bpf_perf_event_value));
> +	__uint(max_entries, 1);
> +} fentry_readings SEC(".maps");
> +
> +/* accumulated readings */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct bpf_perf_event_value));
> +	__uint(max_entries, 1);
> +} accum_readings SEC(".maps");
> +
> +const volatile __u32 num_cpu = 1;
> +
> +SEC("fentry/XXX")
> +int BPF_PROG(fentry_XXX)
> +{
> +	__u32 key = bpf_get_smp_processor_id();
> +	struct bpf_perf_event_value *ptr;
> +	__u32 zero = 0;
> +	long err;
> +
> +	/* look up before reading, to reduce error */
> +	ptr = bpf_map_lookup_elem(&fentry_readings, &zero);
> +	if (!ptr)
> +		return 0;
> +
> +	err = bpf_perf_event_read_value(&events, key, ptr, sizeof(*ptr));
> +	if (err)
> +		return 0;
> +
> +	return 0;
> +}
> +
> +static inline void
> +fexit_update_maps(struct bpf_perf_event_value *after)
> +{
> +	struct bpf_perf_event_value *before, diff, *accum;
> +	__u32 zero = 0;
> +
> +	before = bpf_map_lookup_elem(&fentry_readings, &zero);
> +	/* only account samples with a valid fentry_reading */
> +	if (before && before->counter) {
> +		struct bpf_perf_event_value *accum;
> +
> +		diff.counter = after->counter - before->counter;
> +		diff.enabled = after->enabled - before->enabled;
> +		diff.running = after->running - before->running;
> +
> +		accum = bpf_map_lookup_elem(&accum_readings, &zero);
> +		if (accum) {
> +			accum->counter += diff.counter;
> +			accum->enabled += diff.enabled;
> +			accum->running += diff.running;
> +		}
> +	}
> +}
> +
> +SEC("fexit/XXX")
> +int BPF_PROG(fexit_XXX)
> +{
> +	struct bpf_perf_event_value reading;
> +	__u32 cpu = bpf_get_smp_processor_id();
> +	__u32 one = 1, zero = 0;
> +	int err;
> +
> +	/* read all events before updating the maps, to reduce error */
> +	err = bpf_perf_event_read_value(&events, cpu, &reading, sizeof(reading));
> +	if (err)
> +		return 0;
> +
> +	fexit_update_maps(&reading);
> +	return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "Dual BSD/GPL";
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dc0cfa5f26101..7a5ca00496000 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -25,6 +25,7 @@
>  #include <stdlib.h>
>  #include <perf/evsel.h>
>  #include "asm/bug.h"
> +#include "bpf_counter.h"
>  #include "callchain.h"
>  #include "cgroup.h"
>  #include "counts.h"
> @@ -51,6 +52,10 @@
>  #include <internal/lib.h>
>  
>  #include <linux/ctype.h>
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +#include <bpf/btf.h>
> +#include "rlimit.h"
>  
>  struct perf_missing_features perf_missing_features;
>  
> @@ -247,6 +252,7 @@ void evsel__init(struct evsel *evsel,
>  	evsel->bpf_obj	   = NULL;
>  	evsel->bpf_fd	   = -1;
>  	INIT_LIST_HEAD(&evsel->config_terms);
> +	INIT_LIST_HEAD(&evsel->bpf_counter_list);
>  	perf_evsel__object.init(evsel);
>  	evsel->sample_size = __evsel__sample_size(attr->sample_type);
>  	evsel__calc_id_pos(evsel);
> @@ -1368,6 +1374,7 @@ void evsel__exit(struct evsel *evsel)
>  {
>  	assert(list_empty(&evsel->core.node));
>  	assert(evsel->evlist == NULL);
> +	bpf_counter__destroy(evsel);
>  	evsel__free_counts(evsel);
>  	perf_evsel__free_fd(&evsel->core);
>  	perf_evsel__free_id(&evsel->core);
> @@ -1783,6 +1790,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			FD(evsel, cpu, thread) = fd;
>  
> +			bpf_counter__install_pe(evsel, cpu, fd);
> +
>  			if (unlikely(test_attr__enabled)) {
>  				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
>  						fd, group_fd, flags);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index cd1d8dd431997..8226b1fefa8cf 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -17,6 +17,8 @@ struct cgroup;
>  struct perf_counts;
>  struct perf_stat_evsel;
>  union perf_event;
> +struct bpf_counter_ops;
> +struct target;
>  
>  typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>  
> @@ -127,6 +129,8 @@ struct evsel {
>  	 * See also evsel__has_callchain().
>  	 */
>  	__u64			synth_sample_type;
> +	struct list_head	bpf_counter_list;
> +	struct bpf_counter_ops	*bpf_counter_ops;
>  };
>  
>  struct perf_missing_features {
> @@ -424,4 +428,5 @@ static inline bool evsel__is_dummy_event(struct evsel *evsel)
>  struct perf_env *evsel__env(struct evsel *evsel);
>  
>  int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
> +
>  #endif /* __PERF_EVSEL_H */
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index cc5ade85a33fc..278abecb5bdfc 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -79,6 +79,27 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
>  	return 0;
>  }
>  
> +/*
> + * XXX: All these evsel destructors need some better mechanism, like a linked
> + * list of destructors registered when the relevant code indeed is used instead
> + * of having more and more calls in perf_evsel__delete(). -- acme
> + *
> + * For now, add some more:
> + *
> + * Not to drag the BPF bandwagon...
> + */
> +void bpf_counter__destroy(struct evsel *evsel);
> +int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
> +
> +void bpf_counter__destroy(struct evsel *evsel __maybe_unused)
> +{
> +}
> +
> +int bpf_counter__install_pe(struct evsel *evsel __maybe_unused, int cpu __maybe_unused, int fd __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  /*
>   * Support debug printing even though util/debug.c is not linked.  That means
>   * implementing 'verbose' and 'eprintf'.
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 583ae4f09c5d1..cce7a76d6473c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1045,7 +1045,9 @@ static void print_header(struct perf_stat_config *config,
>  	if (!config->csv_output) {
>  		fprintf(output, "\n");
>  		fprintf(output, " Performance counter stats for ");
> -		if (_target->system_wide)
> +		if (_target->bpf_str)
> +			fprintf(output, "\'BPF program(s) %s", _target->bpf_str);
> +		else if (_target->system_wide)
>  			fprintf(output, "\'system wide");
>  		else if (_target->cpu_list)
>  			fprintf(output, "\'CPU(s) %s", _target->cpu_list);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 8ce1479c98f03..0b3957323f668 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -527,7 +527,7 @@ int create_perf_stat_counter(struct evsel *evsel,
>  	if (leader->core.nr_members > 1)
>  		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
>  
> -	attr->inherit = !config->no_inherit;
> +	attr->inherit = !config->no_inherit && list_empty(&evsel->bpf_counter_list);
>  
>  	/*
>  	 * Some events get initialized with sample_(period/type) set,
> diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
> index a3db13dea937c..0f383418e3df5 100644
> --- a/tools/perf/util/target.c
> +++ b/tools/perf/util/target.c
> @@ -56,6 +56,34 @@ enum target_errno target__validate(struct target *target)
>  			ret = TARGET_ERRNO__UID_OVERRIDE_SYSTEM;
>  	}
>  
> +	/* BPF and CPU are mutually exclusive */
> +	if (target->bpf_str && target->cpu_list) {
> +		target->cpu_list = NULL;
> +		if (ret == TARGET_ERRNO__SUCCESS)
> +			ret = TARGET_ERRNO__BPF_OVERRIDE_CPU;
> +	}
> +
> +	/* BPF and PID/TID are mutually exclusive */
> +	if (target->bpf_str && target->tid) {
> +		target->tid = NULL;
> +		if (ret == TARGET_ERRNO__SUCCESS)
> +			ret = TARGET_ERRNO__BPF_OVERRIDE_PID;
> +	}
> +
> +	/* BPF and UID are mutually exclusive */
> +	if (target->bpf_str && target->uid_str) {
> +		target->uid_str = NULL;
> +		if (ret == TARGET_ERRNO__SUCCESS)
> +			ret = TARGET_ERRNO__BPF_OVERRIDE_UID;
> +	}
> +
> +	/* BPF and THREADS are mutually exclusive */
> +	if (target->bpf_str && target->per_thread) {
> +		target->per_thread = false;
> +		if (ret == TARGET_ERRNO__SUCCESS)
> +			ret = TARGET_ERRNO__BPF_OVERRIDE_THREAD;
> +	}
> +
>  	/* THREAD and SYSTEM/CPU are mutually exclusive */
>  	if (target->per_thread && (target->system_wide || target->cpu_list)) {
>  		target->per_thread = false;
> @@ -109,6 +137,10 @@ static const char *target__error_str[] = {
>  	"PID/TID switch overriding SYSTEM",
>  	"UID switch overriding SYSTEM",
>  	"SYSTEM/CPU switch overriding PER-THREAD",
> +	"BPF switch overriding CPU",
> +	"BPF switch overriding PID/TID",
> +	"BPF switch overriding UID",
> +	"BPF switch overriding THREAD",
>  	"Invalid User: %s",
>  	"Problems obtaining information for user %s",
>  };
> @@ -134,7 +166,7 @@ int target__strerror(struct target *target, int errnum,
>  
>  	switch (errnum) {
>  	case TARGET_ERRNO__PID_OVERRIDE_CPU ...
> -	     TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD:
> +	     TARGET_ERRNO__BPF_OVERRIDE_THREAD:
>  		snprintf(buf, buflen, "%s", msg);
>  		break;
>  
> diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
> index 6ef01a83b24e9..f132c6c2eef81 100644
> --- a/tools/perf/util/target.h
> +++ b/tools/perf/util/target.h
> @@ -10,6 +10,7 @@ struct target {
>  	const char   *tid;
>  	const char   *cpu_list;
>  	const char   *uid_str;
> +	const char   *bpf_str;
>  	uid_t	     uid;
>  	bool	     system_wide;
>  	bool	     uses_mmap;
> @@ -36,6 +37,10 @@ enum target_errno {
>  	TARGET_ERRNO__PID_OVERRIDE_SYSTEM,
>  	TARGET_ERRNO__UID_OVERRIDE_SYSTEM,
>  	TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD,
> +	TARGET_ERRNO__BPF_OVERRIDE_CPU,
> +	TARGET_ERRNO__BPF_OVERRIDE_PID,
> +	TARGET_ERRNO__BPF_OVERRIDE_UID,
> +	TARGET_ERRNO__BPF_OVERRIDE_THREAD,
>  
>  	/* for target__parse_uid() */
>  	TARGET_ERRNO__INVALID_UID,
> @@ -59,6 +64,11 @@ static inline bool target__has_cpu(struct target *target)
>  	return target->system_wide || target->cpu_list;
>  }
>  
> +static inline bool target__has_bpf(struct target *target)
> +{
> +	return target->bpf_str;
> +}
> +
>  static inline bool target__none(struct target *target)
>  {
>  	return !target__has_task(target) && !target__has_cpu(target);
> -- 
> 2.24.1
> 

-- 

- Arnaldo
