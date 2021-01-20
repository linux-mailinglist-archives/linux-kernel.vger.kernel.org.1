Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3942FDBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbhATU5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389209AbhATNu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:50:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E7F323357;
        Wed, 20 Jan 2021 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611150617;
        bh=/6kRwnbdoF99AQ+f2cCyCodkHRzzmgx4kfuKnlYbadk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3mloA1ggscDAk91e0b9BemNFTeDRAPNO8iJBfRS/MFLKzo2IC8xlwXq4CdQoq3c+
         wT9ZFgY2vC95CGFQfKFIRAFZdCyoIWSUKhh8EzSL8Q9GNnXH6FiObrUK0orCKotro3
         xAxAby10NxW7UonfW6ewoPOKKHXP9mscIQjrDPZjo88x4UJ3kDodmTI39qEQYsEvKM
         OEXp/tWaReNpMU6FOdm+kvisY3y+23GC2MH0aTy9EN6Z4lDv1he5dIT9vo0GxH4jWF
         drRiOQW/+s69ffzv247OB7U8PHaZL5I5ZtxHSG5AuB0fdCjOqPqeW6ZQEaMd3XoCLu
         9iWNnTLrmRJCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 822FF40CE2; Wed, 20 Jan 2021 10:50:13 -0300 (-03)
Date:   Wed, 20 Jan 2021 10:50:13 -0300
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
Message-ID: <20210120135013.GT12699@kernel.org>
References: <20201229214214.3413833-4-songliubraving@fb.com>
 <20210118193817.GG12699@kernel.org>
 <379919CC-594F-40C5-A10E-97E048F73AE2@fb.com>
 <20210119143143.GJ12699@kernel.org>
 <20210119144249.GK12699@kernel.org>
 <20210119163123.GM12699@kernel.org>
 <417ABE57-E527-4944-BE16-35AB92D071E9@fb.com>
 <20210119223021.GO12699@kernel.org>
 <20210120123727.GR12699@kernel.org>
 <20210120130137.GS12699@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120130137.GS12699@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 20, 2021 at 10:01:37AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 20, 2021 at 09:37:27AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Breakpoint 3, bpf_program_profiler__read (evsel=0xce02c0) at util/bpf_counter.c:208
> > 208	{
> > (gdb) c
> > Continuing.
> > 
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x00000000005cf34b in bpf_program_profiler__read (evsel=0x0) at util/bpf_counter.c:224
> > 224		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> > (gdb) p evsel
> > $55 = (struct evsel *) 0x0
> > (gdb) bt
> > #0  0x00000000005cf34b in bpf_program_profiler__read (evsel=0x0) at util/bpf_counter.c:224
> > #1  0x0000000000000000 in ?? ()
> > (gdb) bt
> > #0  0x00000000005cf34b in bpf_program_profiler__read (evsel=0x0) at util/bpf_counter.c:224
> > #1  0x0000000000000000 in ?? ()
> > (gdb)
> > (gdb) info threads
> >   Id   Target Id                                  Frame
> > * 1    Thread 0x7ffff647f900 (LWP 1725711) "perf" 0x00000000005cf34b in bpf_program_profiler__read (evsel=0x0) at util/bpf_counter.c:224
> > (gdb)

[root@five perf]# bpftool prog | grep ^244: -A100
244: kprobe  name hrtimer_nanosle  tag 0e77bacaf4555f83  gpl
	loaded_at 2021-01-19T13:04:03-0300  uid 0
	xlated 80B  jited 49B  memlock 4096B
	btf_id 360
486: tracing  name fentry_XXX  tag 51a406116b7e2f01  gpl
	loaded_at 2021-01-20T10:36:29-0300  uid 0
	xlated 160B  jited 98B  memlock 4096B  map_ids 367,366,369
	btf_id 489
488: tracing  name fexit_XXX  tag a0cbac3880048978  gpl
	loaded_at 2021-01-20T10:36:29-0300  uid 0
	xlated 416B  jited 242B  memlock 4096B  map_ids 366,367,368,369
	btf_id 489
[root@five perf]#

[root@five perf]# bpftool map
3: array  name iterator.rodata  flags 0x480
	key 4B  value 98B  max_entries 1  memlock 4096B
	btf_id 6  frozen
366: perf_event_array  name events  flags 0x0
	key 4B  value 4B  max_entries 24  memlock 4096B
367: percpu_array  name fentry_readings  flags 0x0
	key 4B  value 24B  max_entries 1  memlock 4096B
368: percpu_array  name accum_readings  flags 0x0
	key 4B  value 24B  max_entries 1  memlock 4096B
369: array  name bpf_prog.rodata  flags 0x480
	key 4B  value 4B  max_entries 1  memlock 4096B
	btf_id 489  frozen
[root@five perf]#

So sizeof(struct bpf_perf_event_value) == 24 and it is a per-cpu array, the
machine has 24 cpus, why is the kernel thinking it has more and end up zeroing
entries after the 24 cores? Some percpu map subtlety (or obvious thing ;-\) I'm
missing?

Checking lookups into per cpu maps in sample code now...

Breakpoint 2, bpf_program_profiler__read (evsel=0xce02c0) at util/bpf_counter.c:230
230			values[num_cpu].counter = 111111;
(gdb) del 2
(gdb) b 233
Breakpoint 3 at 0x5cf270: file util/bpf_counter.c, line 233.
(gdb) c
Continuing.

Breakpoint 3, bpf_program_profiler__read (evsel=0xce02c0) at util/bpf_counter.c:233
233			err = bpf_map_lookup_elem(reading_map_fd, &key, values);
(gdb) p values[num_cpu].running
$4 = 333333
(gdb) c
Continuing.

Breakpoint 1, bpf_program_profiler__read (evsel=0xce02c0) at util/bpf_counter.c:239
239			for (cpu = 0; cpu < num_cpu; cpu++) {
(gdb) p values[num_cpu].running
$5 = 0
(gdb) list -10
224		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
225			struct bpf_prog_profiler_bpf *skel = counter->skel;
226	
227			assert(skel != NULL);
228			reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
229	
230			values[num_cpu].counter = 111111;
231			values[num_cpu].enabled = 222222;
232			values[num_cpu].running = 333333;
233			err = bpf_map_lookup_elem(reading_map_fd, &key, values);
(gdb) 
234			if (err) {
235				pr_err("failed to read value\n");
236				return err;
237			}
238	
239			for (cpu = 0; cpu < num_cpu; cpu++) {
240				perf_counts(evsel->counts, cpu, 0)->val += values[cpu].counter;
241				perf_counts(evsel->counts, cpu, 0)->ena += values[cpu].enabled;
242				perf_counts(evsel->counts, cpu, 0)->run += values[cpu].running;
243			}
(gdb) 
 
> (gdb) run stat -e cycles -b 244 -I 1000
> Starting program: /root/bin/perf stat -e cycles -b 244 -I 1000
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> 
> Breakpoint 1, read_bpf_map_counters () at builtin-stat.c:414
> 414	{
> (gdb) c
> Continuing.
> 
> Breakpoint 2, bpf_program_profiler__read (evsel=0xce02c0) at util/bpf_counter.c:224
> 224		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> (gdb) bt
> #0  bpf_program_profiler__read (evsel=0xce02c0) at util/bpf_counter.c:224
> #1  0x00000000005cf648 in bpf_counter__read (evsel=0xce02c0) at util/bpf_counter.c:300
> #2  0x0000000000434e46 in read_bpf_map_counters () at builtin-stat.c:419
> #3  0x0000000000434ecb in read_counters (rs=0x7fffffff9530) at builtin-stat.c:433
> #4  0x00000000004351f3 in process_interval () at builtin-stat.c:498
> #5  0x00000000004352b9 in handle_interval (interval=1000, times=0x7fffffff9618) at builtin-stat.c:513
> #6  0x0000000000435859 in dispatch_events (forks=false, timeout=0, interval=1000, times=0x7fffffff9618) at builtin-stat.c:676
> #7  0x00000000004365f1 in __run_perf_stat (argc=0, argv=0x7fffffffdb60, run_idx=0) at builtin-stat.c:944
> #8  0x00000000004367e3 in run_perf_stat (argc=0, argv=0x7fffffffdb60, run_idx=0) at builtin-stat.c:1001
> #9  0x0000000000439e35 in cmd_stat (argc=0, argv=0x7fffffffdb60) at builtin-stat.c:2415
> #10 0x00000000004cf058 in run_builtin (p=0xaabe00 <commands+288>, argc=7, argv=0x7fffffffdb60) at perf.c:312
> #11 0x00000000004cf2c5 in handle_internal_command (argc=7, argv=0x7fffffffdb60) at perf.c:364
> #12 0x00000000004cf40c in run_argv (argcp=0x7fffffffd9ac, argv=0x7fffffffd9a0) at perf.c:408
> #13 0x00000000004cf7d8 in main (argc=7, argv=0x7fffffffdb60) at perf.c:538
> (gdb) n
> 225			struct bpf_prog_profiler_bpf *skel = counter->skel;
> (gdb) n
> 227			assert(skel != NULL);
> (gdb) n
> 228			reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> (gdb) p skel->maps.accum_readings
> $16 = (struct bpf_map *) 0xce7400
> (gdb) p *skel->maps.accum_readings
> $17 = {name = 0xce7580 "accum_readings", fd = 7, sec_idx = 6, sec_offset = 56, map_ifindex = 0, inner_map_fd = -1, def = {type = 6, key_size = 4, value_size = 24, max_entries = 1, map_flags = 0}, numa_node = 0, btf_var_idx = 2, btf_key_type_id = 0, btf_value_type_id = 0,
>   btf_vmlinux_value_type_id = 0, priv = 0x0, clear_priv = 0x0, libbpf_type = LIBBPF_MAP_UNSPEC, mmaped = 0x0, st_ops = 0x0, inner_map = 0x0, init_slots = 0x0, init_slots_sz = 0, pin_path = 0x0, pinned = false, reused = false}
> (gdb) n
> 230			err = bpf_map_lookup_elem(reading_map_fd, &key, values);
> (gdb) n
> 231			if (err) {
> (gdb) p evsel
> $18 = (struct evsel *) 0x0
> (gdb)
> 
> So at this point is stack corruption when doing the bpf lookup on this
> Ryzen system with 12 cores/24 threads:
> 
> [root@five ~]# bpftool prog | tail -4
> 244: kprobe  name hrtimer_nanosle  tag 0e77bacaf4555f83  gpl
> 	loaded_at 2021-01-19T13:04:03-0300  uid 0
> 	xlated 80B  jited 49B  memlock 4096B
> 	btf_id 360
> [root@five ~]# perf stat -e cycles -b 244 -I 1000
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> #           time             counts unit events
>      1.246867591             37,371      cycles
>      2.247955619             33,652      cycles
>      3.249017879             38,983      cycles
>      4.250083954             49,546      cycles
>      5.251150241             57,319      cycles
>      6.252221407             44,170      cycles
>      7.253279040             34,691      cycles
>      8.254333356             48,195      cycles
> ^C     9.009242074             41,320      cycles
> 
> [root@five ~]#
> 
> This is with this hack:
> 
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 8c977f038f497fc1..f227fd09d33794b5 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -207,7 +207,7 @@ static int bpf_program_profiler__enable(struct evsel *evsel)
>  static int bpf_program_profiler__read(struct evsel *evsel)
>  {
>  	int num_cpu = evsel__nr_cpus(evsel);
> -	struct bpf_perf_event_value values[num_cpu];
> +	struct bpf_perf_event_value values[num_cpu * 2];
>  	struct bpf_counter *counter;
>  	int reading_map_fd;
>  	__u32 key = 0;
> 
> 
> --------------------------
> 
> Now to check the proper fix...
> 
> Works with all the events, etc, we need to remove that nnoying warning
> about .eh_frame (is this solved in the bpf tree?)
> 
> [root@five ~]# perf stat -b 244 -I 1000
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> #           time             counts unit events
>      3.624452622               0.12 msec cpu-clock                 #    0.000 CPUs utilized          
>      3.624452622                  0      context-switches          #    0.000 K/sec                  
>      3.624452622                  0      cpu-migrations            #    0.000 K/sec                  
>      3.624452622                  0      page-faults               #    0.000 K/sec                  
>      3.624452622            302,518      cycles                    #    2.468 GHz                      (83.41%)
>      3.624452622             26,101      stalled-cycles-frontend   #    8.63% frontend cycles idle     (81.05%)
>      3.624452622             96,327      stalled-cycles-backend    #   31.84% backend cycles idle      (80.58%)
>      3.624452622            269,500      instructions              #    0.89  insn per cycle         
>      3.624452622                                                   #    0.36  stalled cycles per insn  (81.81%)
>      3.624452622             55,003      branches                  #  448.667 M/sec                    (86.94%)
>      3.624452622                467      branch-misses             #    0.85% of all branches          (77.18%)
>      4.625690606               0.11 msec cpu-clock                 #    0.000 CPUs utilized          
>      4.625690606                  0      context-switches          #    0.000 K/sec                  
>      4.625690606                  0      cpu-migrations            #    0.000 K/sec                  
>      4.625690606                  0      page-faults               #    0.000 K/sec                  
>      4.625690606            290,093      cycles                    #    2.535 GHz                      (79.46%)
>      4.625690606             28,274      stalled-cycles-frontend   #    9.75% frontend cycles idle     (79.47%)
>      4.625690606            101,772      stalled-cycles-backend    #   35.08% backend cycles idle      (84.05%)
>      4.625690606            261,867      instructions              #    0.90  insn per cycle         
>      4.625690606                                                   #    0.39  stalled cycles per insn  (86.38%)
>      4.625690606             55,334      branches                  #  483.473 M/sec                    (82.58%)
>      4.625690606                373      branch-misses             #    0.67% of all branches          (88.59%)
>      5.626686730               0.14 msec cpu-clock                 #    0.000 CPUs utilized          
>      5.626686730                  0      context-switches          #    0.000 K/sec                  
>      5.626686730                  0      cpu-migrations            #    0.000 K/sec                  
>      5.626686730                  0      page-faults               #    0.000 K/sec                  
>      5.626686730            369,810      cycles                    #    2.574 GHz                      (79.77%)
>      5.626686730             32,212      stalled-cycles-frontend   #    8.71% frontend cycles idle     (76.00%)
>      5.626686730            122,778      stalled-cycles-backend    #   33.20% backend cycles idle      (81.49%)
>      5.626686730            275,699      instructions              #    0.75  insn per cycle         
>      5.626686730                                                   #    0.45  stalled cycles per insn  (78.39%)
>      5.626686730             58,135      branches                  #  404.716 M/sec                    (73.61%)
>      5.626686730                588      branch-misses             #    1.01% of all branches          (71.01%)
>      6.627688626               0.14 msec cpu-clock                 #    0.000 CPUs utilized          
>      6.627688626                  0      context-switches          #    0.000 K/sec                  
>      6.627688626                  0      cpu-migrations            #    0.000 K/sec                  
>      6.627688626                  0      page-faults               #    0.000 K/sec                  
>      6.627688626            358,906      cycles                    #    2.543 GHz                      (81.90%)
>      6.627688626             26,411      stalled-cycles-frontend   #    7.36% frontend cycles idle     (80.87%)
>      6.627688626            129,526      stalled-cycles-backend    #   36.09% backend cycles idle      (77.72%)
>      6.627688626            278,756      instructions              #    0.78  insn per cycle         
>      6.627688626                                                   #    0.46  stalled cycles per insn  (70.31%)
>      6.627688626             56,514      branches                  #  400.448 M/sec                    (80.53%)
>      6.627688626                687      branch-misses             #    1.22% of all branches          (75.74%)
>      7.628688818               0.15 msec cpu-clock                 #    0.000 CPUs utilized          
>      7.628688818                  0      context-switches          #    0.000 K/sec                  
>      7.628688818                  0      cpu-migrations            #    0.000 K/sec                  
>      7.628688818                  0      page-faults               #    0.000 K/sec                  
>      7.628688818            384,382      cycles                    #    2.574 GHz                      (84.08%)
>      7.628688818             27,148      stalled-cycles-frontend   #    7.06% frontend cycles idle     (81.82%)
>      7.628688818            128,434      stalled-cycles-backend    #   33.41% backend cycles idle      (82.29%)
>      7.628688818            270,693      instructions              #    0.70  insn per cycle         
>      7.628688818                                                   #    0.47  stalled cycles per insn  (83.58%)
>      7.628688818             57,277      branches                  #  383.614 M/sec                    (81.68%)
>      7.628688818                756      branch-misses             #    1.32% of all branches          (85.39%)
> ^C     7.934955676               0.05 msec cpu-clock                 #    0.000 CPUs utilized          
>      7.934955676                  0      context-switches          #    0.000 K/sec                  
>      7.934955676                  0      cpu-migrations            #    0.000 K/sec                  
>      7.934955676                  0      page-faults               #    0.000 K/sec                  
>      7.934955676            126,813      cycles                    #    2.626 GHz                      (77.14%)
>      7.934955676              9,424      stalled-cycles-frontend   #    7.43% frontend cycles idle     (87.96%)
>      7.934955676             44,506      stalled-cycles-backend    #   35.10% backend cycles idle      (82.43%)
>      7.934955676             86,383      instructions              #    0.68  insn per cycle         
>      7.934955676                                                   #    0.52  stalled cycles per insn  (86.26%)
>      7.934955676             17,491      branches                  #  362.222 M/sec                    (87.10%)
>      7.934955676                247      branch-misses             #    1.41% of all branches          (76.62%)
> 
> [root@five ~]#

-- 

- Arnaldo
