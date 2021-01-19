Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9DE2FC381
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbhASWbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731394AbhASWbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:31:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DD0123108;
        Tue, 19 Jan 2021 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611095426;
        bh=yAqlB78ErDWWhhmH/0yKRS96H7Q0Oz2UGDyvg2p8lKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iO9P5AE7FhkKDwUse5LUxLcLbZ+FIVDtGVK1vdrtoETZfjh6BXc3Jr1Z5yhx78Twc
         zQ9rPEPyf9lJNOWQweRUnqFeDb16vzDAJIwIrt8RAboDz+6sa9lEd1G1eGS55cwqkg
         5oK4PSyly+v60mxr1qlSQRJQtDcyL8XDOLpc6/W/AHHH3I/ttzSZ/neMvABTH/iJHu
         CPVyNCdO8Z06sYMi+vHW2y1m3fsHBn1WKX5Wwr54lnut/3AhZdZ/AqorQqx0x9gaMW
         /nXRPsfJsoKE9LlmsfxnVvhQmcpnchnsohxHEsXtqrKcEsls0oqTNn2wPFwOfUKoGn
         BwA5IKn95ZHxg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E05E40CE2; Tue, 19 Jan 2021 19:30:22 -0300 (-03)
Date:   Tue, 19 Jan 2021 19:30:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF programs
Message-ID: <20210119223021.GO12699@kernel.org>
References: <20201229214214.3413833-1-songliubraving@fb.com>
 <20201229214214.3413833-4-songliubraving@fb.com>
 <20210118193817.GG12699@kernel.org>
 <379919CC-594F-40C5-A10E-97E048F73AE2@fb.com>
 <20210119143143.GJ12699@kernel.org>
 <20210119144249.GK12699@kernel.org>
 <20210119163123.GM12699@kernel.org>
 <417ABE57-E527-4944-BE16-35AB92D071E9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417ABE57-E527-4944-BE16-35AB92D071E9@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 19, 2021 at 09:54:50PM +0000, Song Liu escreveu:
> 
> 
> > On Jan 19, 2021, at 8:31 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Tue, Jan 19, 2021 at 11:42:49AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Tue, Jan 19, 2021 at 11:31:44AM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> Em Tue, Jan 19, 2021 at 12:48:19AM +0000, Song Liu escreveu:
> >>>>> On Jan 18, 2021, at 11:38 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>>> We are looking at two issues:
> >>>> 1. Cannot recursively attach;
> >>>> 2. prog FD 3 doesn't have valid btf. 
> >> 
> >>>> #1 was caused by the verifier disallowing attaching fentry/fexit program 
> >>>> to program with type BPF_PROG_TYPE_TRACING (in bpf_check_attach_target). 
> >>>> This constraint was added when we only had fentry/fexit in the TRACING
> >>>> type. We have extended the TRACING type to many other use cases, like 
> >>>> "tp_btf/", "fmod_ret" and "iter/". Therefore, it is good time to revisit 
> >>>> this constraint. I will work on this. 
> >> 
> >>>> For #2, we require the target program to have BTF. I guess we won't remove
> >>>> this requirement.
> >> 
> >>>> While I work on improving #1, could you please test with some kprobe 
> >>>> programs? For example, we can use fileslower.py from bcc. 
> >> 
> >>> Sure, and please consider improving the error messages to state what you
> >>> described above.
> >> 
> >> Terminal 1:
> >> 
> >> [root@five perf]# perf trace -e 5sec.c
> >> ^C
> >> [root@five perf]# cat 5sec.c
> >> #include <bpf.h>
> >> 
> >> #define NSEC_PER_SEC	1000000000L
> >> 
> >> int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
> >> {
> >> 	return sec / NSEC_PER_SEC == 5;
> >> }
> >> 
> >> license(GPL);
> >> [root@five perf]# perf trace -e 5sec.c/max-stack=16/
> >>     0.000 sleep/3739435 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -1743337312, rqtp: 5000000000)
> >>                                       hrtimer_nanosleep ([kernel.kallsyms])
> >>                                       common_nsleep ([kernel.kallsyms])
> >>                                       __x64_sys_clock_nanosleep ([kernel.kallsyms])
> >>                                       do_syscall_64 ([kernel.kallsyms])
> >>                                       entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
> >>                                       __clock_nanosleep_2 (/usr/lib64/libc-2.32.so)
> >> 
> >> 
> >> Terminal 2:
> >> 
> >> [root@five ~]# perf stat -e cycles -b 180 -I 1000
> >> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> >> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> >> perf: util/bpf_counter.c:227: bpf_program_profiler__read: Assertion `skel != NULL' failed.
> >> Aborted (core dumped)
> > 
> > Out to lunch, will continue later, but this may help you figure this out
> > till then :)
> > 
> > Starting program: /root/bin/perf stat -e cycles -b 244 -I 1000
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib64/libthread_db.so.1".
> > 
> > Breakpoint 1, bpf_program_profiler_load_one (evsel=0xce02c0, prog_id=244) at util/bpf_counter.c:96
> > 96	{
> > (gdb) n
> > 104		prog_fd = bpf_prog_get_fd_by_id(prog_id);
> > (gdb) 
> > 105		if (prog_fd < 0) {
> > (gdb) 
> > 109		counter = bpf_counter_alloc();
> > (gdb) 
> > 110		if (!counter) {
> > (gdb) n
> > 115		skel = bpf_prog_profiler_bpf__open();
> > (gdb) p counter
> > $9 = (struct bpf_counter *) 0xce09e0
> > (gdb) p *counter
> > $10 = {skel = 0x0, list = {next = 0xce09e8, prev = 0xce09e8}}
> > (gdb) p *counter
> > $11 = {skel = 0x0, list = {next = 0xce09e8, prev = 0xce09e8}}
> > (gdb) n
> > libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > 116		if (!skel) {
> > (gdb) 
> > 121		skel->rodata->num_cpu = evsel__nr_cpus(evsel);
> > (gdb) 
> > 123		bpf_map__resize(skel->maps.events, evsel__nr_cpus(evsel));
> > (gdb) 
> > 124		bpf_map__resize(skel->maps.fentry_readings, 1);
> > (gdb) 
> > 125		bpf_map__resize(skel->maps.accum_readings, 1);
> > (gdb) 
> > 127		prog_name = bpf_target_prog_name(prog_fd);
> > (gdb) 
> > 128		if (!prog_name) {
> > (gdb) 
> > 133		bpf_object__for_each_program(prog, skel->obj) {
> > (gdb) 
> > 134			err = bpf_program__set_attach_target(prog, prog_fd, prog_name);
> > (gdb) 
> > 135			if (err) {
> > (gdb) 
> > 133		bpf_object__for_each_program(prog, skel->obj) {
> > (gdb) p evsel
> > $12 = (struct evsel *) 0xce02c0
> > (gdb) p evsel->name
> > $13 = 0xce04e0 "cycles"
> > (gdb) n
> > 134			err = bpf_program__set_attach_target(prog, prog_fd, prog_name);
> > (gdb) 
> > 135			if (err) {
> > (gdb) 
> > 133		bpf_object__for_each_program(prog, skel->obj) {
> > (gdb) 
> > 141		set_max_rlimit();
> > (gdb) 
> > 142		err = bpf_prog_profiler_bpf__load(skel);
> > (gdb) 
> > 143		if (err) {
> > (gdb) 
> > 148		assert(skel != NULL);
> > (gdb) 
> > 149		counter->skel = skel;
> > (gdb) 
> > 150		list_add(&counter->list, &evsel->bpf_counter_list);
> > (gdb) c
> > Continuing.
> > 
> > Breakpoint 4, bpf_program_profiler__install_pe (evsel=0xce02c0, cpu=0, fd=3) at util/bpf_counter.c:247
> > 247	{
> > (gdb) n
> > 252		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> > (gdb) 
> > 253			skel = counter->skel;
> > (gdb) watch counter->skel
> > Hardware watchpoint 6: counter->skel
> > (gdb) p counter->skel
> > $14 = (void *) 0xce0a00
> > (gdb) n
> > 254			assert(skel != NULL);
> > (gdb) p skel
> > $15 = (struct bpf_prog_profiler_bpf *) 0xce0a00
> > (gdb) c
> > Continuing.
> > 
> > Hardware watchpoint 6: counter->skel
> > 
> > Old value = (void *) 0xce0a00
> > New value = (void *) 0x0
> > 0x00000000005cf45e in bpf_program_profiler__install_pe (evsel=0xce02c0, cpu=0, fd=3) at util/bpf_counter.c:252
> > 252		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> 
> So it was the list operation that set counter->skel to NULL? I am really confused...

Yep, I'm confused as well and trying to reproduce this, but got
sidetracked...

- Arnaldo
 
> Song
> 
> > (gdb) info b
> > Num     Type           Disp Enb Address            What
> > 1       breakpoint     keep y   0x00000000005ceb44 in bpf_program_profiler_load_one at util/bpf_counter.c:96
> > 	breakpoint already hit 1 time
> > 2       breakpoint     keep y   0x00000000005cef2e in bpf_program_profiler__enable at util/bpf_counter.c:192
> > 3       breakpoint     keep y   0x00000000005cf00a in bpf_program_profiler__read at util/bpf_counter.c:208
> > 4       breakpoint     keep y   0x00000000005cf3ba in bpf_program_profiler__install_pe at util/bpf_counter.c:247
> > 	breakpoint already hit 1 time
> > 5       breakpoint     keep y   0x00000000005ce8d4 in bpf_program_profiler__destroy at util/bpf_counter.c:47
> > 6       hw watchpoint  keep y                      counter->skel
> > 	breakpoint already hit 1 time
> > (gdb) p evsel
> > $16 = (struct evsel *) 0xce02c0
> > (gdb) bt
> > #0  0x00000000005cf45e in bpf_program_profiler__install_pe (evsel=0xce02c0, cpu=0, fd=3) at util/bpf_counter.c:252
> > #1  0x00000000005cf4f3 in bpf_counter__install_pe (evsel=0xce02c0, cpu=0, fd=3) at util/bpf_counter.c:276
> > #2  0x00000000004f3ef1 in evsel__open_cpu (evsel=0xce02c0, cpus=0xce0500, threads=0xce75c0, start_cpu=0, end_cpu=1) at util/evsel.c:1792
> > #3  0x00000000004f4aa7 in evsel__open_per_cpu (evsel=0xce02c0, cpus=0xce0500, cpu=0) at util/evsel.c:1996
> > #4  0x000000000057f6f2 in create_perf_stat_counter (evsel=0xce02c0, config=0xa97860 <stat_config>, target=0xa97660 <target>, cpu=0) at util/stat.c:568
> > #5  0x0000000000435d96 in __run_perf_stat (argc=0, argv=0x7fffffffdb60, run_idx=0) at builtin-stat.c:790
> > #6  0x00000000004367e3 in run_perf_stat (argc=0, argv=0x7fffffffdb60, run_idx=0) at builtin-stat.c:1001
> > #7  0x0000000000439e35 in cmd_stat (argc=0, argv=0x7fffffffdb60) at builtin-stat.c:2415
> > #8  0x00000000004cf058 in run_builtin (p=0xaabe00 <commands+288>, argc=7, argv=0x7fffffffdb60) at perf.c:312
> > #9  0x00000000004cf2c5 in handle_internal_command (argc=7, argv=0x7fffffffdb60) at perf.c:364
> > #10 0x00000000004cf40c in run_argv (argcp=0x7fffffffd9ac, argv=0x7fffffffd9a0) at perf.c:408
> > #11 0x00000000004cf7d8 in main (argc=7, argv=0x7fffffffdb60) at perf.c:538
> > (gdb) n
> > 261		return 0;
> > 
> 

-- 

- Arnaldo
