Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF02295033
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444175AbgJUPws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:52:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:50406 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444167AbgJUPws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:52:48 -0400
IronPort-SDR: XhS8x7fTfG4zyOW4JL6P93WpBLg+/KxWnsXsPWZkaJ37NQEQhiRUAPUBsjHDdl4nNGv+/DkOWW
 CXMd/55Hsmmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="147246982"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="147246982"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 08:52:47 -0700
IronPort-SDR: K9xcoNShMDyvxM+4LTVX8pQ9GN9AYe5pGH2WNk+/+9jO8+NwcJ5R1L72XUe+2HKCjfuhay6PHH
 q7NoZEHkCNZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="392762195"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 21 Oct 2020 08:52:47 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 04791580720;
        Wed, 21 Oct 2020 08:52:44 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 00/15] Introduce threaded trace streaming for basic perf
 record operation
Organization: Intel Corp.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Date:   Wed, 21 Oct 2020 18:52:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes in v2:
- explicitly added credit tags to patches 6/15 and 15/15,
  additionally to cites [1], [2]
- updated description of 3/15 to explicitly mention the reason
  to open data directories in read access mode (e.g. for perf report)
- implemented fix for compilation error of 2/15
- explicitly elaborated on found issues to be resolved for
  threaded AUX trace capture

v1: https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/

Patch set provides threaded trace streaming for base perf record
operation. Provided streaming mode (--threads) mitigates profiling
data losses and resolves scalability issues of serial and asynchronous
(--aio) trace streaming modes on multicore server systems. The patch
set is based on the prototype [1], [2] and the most closely relates
to mode 3) "mode that creates thread for every monitored memory map".

The threaded mode executes one-to-one mapping of trace streaming threads
to mapped data buffers and streaming into per-CPU trace files located
at data directory. The data buffers and threads are affined to NUMA
nodes and monitored CPUs according to system topology. --cpu option
can be used to specify exact CPUs to be monitored.

Basic analysis of data directories is provided for perf report mode.
Raw dump (-D) and aggregated reports are available for data directories,
still with no memory consumption optimizations. However data directories
collected with --compression-level option enabled can be analyzed with
little less memory because trace files are unmaped from tool process
memory after loading collected data.

Provided streaming mode is available with Zstd compression/decompression
(--compression-level) and handling of external commands (--control).
AUX area tracing, related and derived modes like --snapshot or
--aux-sample are not enabled. --switch-output, --switch-output-event, 
--switch-max-files and --timestamp-filename options are not enabled.
Threaded trace streaming is not enabled for pipe mode. Initial intent
to enable AUX area tracing faced the need to define some optimal way
to store index data in data directory, thus left aside. --switch-output-*
and --timestamp-filename use cases are not clear for data directories.

Asynchronous(--aio) trace streaming and affinity (--affinity) modes
are mutually exclusive to threaded streaming mode.

See testing results and validation examples below.

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

---
Alexey Budankov (15):
  perf session: introduce trace file path to be shown in raw trace dump
  perf report: output trace file name in raw trace dump
  perf data: open data directory in read access mode
  perf session: move reader object definition to header file
  perf session: introduce decompressor into trace reader object
  perf session: load data directory into tool process memory
  perf record: introduce trace file, compressor and stats in mmap object
  perf record: write trace data into mmap trace files
  perf record: introduce thread specific objects for trace streaming
  perf record: manage thread specific data array
  perf evlist: introduce evlist__ctlfd_update() to update ctl fd status
  perf record: introduce thread local variable for trace streaming
  perf record: stop threads in the end of trace streaming
  perf record: start threads in the beginning of trace streaming
  perf record: introduce --threads command line option

 tools/perf/Documentation/perf-record.txt |   7 +
 tools/perf/builtin-inject.c              |   3 +-
 tools/perf/builtin-record.c              | 514 +++++++++++++++++++++--
 tools/perf/util/data.c                   |   4 +
 tools/perf/util/evlist.c                 |  16 +
 tools/perf/util/evlist.h                 |   1 +
 tools/perf/util/mmap.c                   |   6 +
 tools/perf/util/mmap.h                   |   5 +
 tools/perf/util/ordered-events.h         |   1 +
 tools/perf/util/record.h                 |   1 +
 tools/perf/util/session.c                | 150 ++++---
 tools/perf/util/session.h                |  28 ++
 tools/perf/util/tool.h                   |   3 +-
 13 files changed, 637 insertions(+), 102 deletions(-)

---
Testing results:

 $ perf test
 1: vmlinux symtab matches kallsyms                                 : Skip
 2: Detect openat syscall event                                     : Ok
 3: Detect openat syscall event on all cpus                         : Ok
 4: Read samples using the mmap interface                           : Ok
 5: Test data source output                                         : Ok
 6: Parse event definition strings                                  : Ok
 7: Simple expression parser                                        : Ok
 8: PERF_RECORD_* events & perf_sample fields                       : Ok
 9: Parse perf pmu format                                           : Ok
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
11: DSO data read                                                   : Ok
12: DSO data cache                                                  : Ok
13: DSO data reopen                                                 : FAILED!
14: Roundtrip evsel->name                                           : Ok
15: Parse sched tracepoints fields                                  : Ok
16: syscalls:sys_enter_openat event fields                          : Ok
17: Setup struct perf_event_attr                                    : Ok
18: Match and link multiple hists                                   : Ok
19: 'import perf' in python                                         : FAILED!
20: Breakpoint overflow signal handler                              : Ok
21: Breakpoint overflow sampling                                    : Ok
22: Breakpoint accounting                                           : Ok
23: Watchpoint                                                      :
23.1: Read Only Watchpoint                                          : Skip
23.2: Write Only Watchpoint                                         : Ok
23.3: Read / Write Watchpoint                                       : Ok
23.4: Modify Watchpoint                                             : Ok
24: Number of exit events of a simple workload                      : Ok
25: Software clock events period values                             : Ok
26: Object code reading                                             : Ok
27: Sample parsing                                                  : Ok
28: Use a dummy software event to keep tracking                     : Ok
29: Parse with no sample_id_all bit set                             : Ok
30: Filter hist entries                                             : Ok
31: Lookup mmap thread                                              : Ok
32: Share thread maps                                               : Ok
33: Sort output of hist entries                                     : Ok
34: Cumulate child hist entries                                     : Ok
35: Track with sched_switch                                         : Ok
36: Filter fds with revents mask in a fdarray                       : Ok
37: Add fd to a fdarray, making it autogrow                         : Ok
38: kmod_path__parse                                                : Ok
39: Thread map                                                      : Ok
40: LLVM search and compile                                         :
40.1: Basic BPF llvm compile                                        : Skip
40.2: kbuild searching                                              : Skip
40.3: Compile source for BPF prologue generation                    : Skip
40.4: Compile source for BPF relocation                             : Skip
41: Session topology                                                : Ok
42: BPF filter                                                      :
42.1: Basic BPF filtering                                           : Skip
42.2: BPF pinning                                                   : Skip
42.3: BPF prologue generation                                       : Skip
42.4: BPF relocation checker                                        : Skip
43: Synthesize thread map                                           : Ok
44: Remove thread map                                               : Ok
45: Synthesize cpu map                                              : Ok
46: Synthesize stat config                                          : Ok
47: Synthesize stat                                                 : Ok
48: Synthesize stat round                                           : Ok
49: Synthesize attr update                                          : Ok
50: Event times                                                     : Ok
51: Read backward ring buffer                                       : Ok
52: Print cpu map                                                   : Ok
53: Merge cpu map                                                   : Ok
54: Probe SDT events                                                : Ok
55: is_printable_array                                              : Ok
56: Print bitmap                                                    : Ok
57: perf hooks                                                      : Ok
58: builtin clang support                                           : Skip (not compiled in)
59: unit_number__scnprintf                                          : Ok
60: mem2node                                                        : Ok
61: time utils                                                      : Ok
62: Test jit_write_elf                                              : Ok
63: Test libpfm4 support                                            : Skip (not compiled in)
64: Test api io                                                     : Ok
65: maps__merge_in                                                  : Ok
66: Demangle Java                                                   : Ok
67: Parse and process metrics                                       : Ok
68: PE file support                                                 : Ok
69: Event expansion for cgroups                                     : Ok
70: x86 rdpmc                                                       : Ok
71: Convert perf time to TSC                                        : Ok
72: DWARF unwind                                                    : Ok
73: x86 instruction decoder - new instructions                      : Ok
74: Intel PT packet decoder                                         : Ok
75: x86 bp modify                                                   : Ok
76: Check open filename arg using perf trace + vfs_getname          : FAILED!
77: Add vfs_getname probe to get syscall args filenames             : FAILED!
78: probe libc's inet_pton & backtrace it with ping                 : Ok
79: Use vfs_getname probe to get syscall args filenames             : FAILED!
80: Zstd perf.data compression/decompression                        : Ok
81: Check Arm CoreSight trace data recording and synthesized samples: Skip

Validation:

  $ tools/perf/perf record --threads --compression-level=3 -e cycles,instructions -- ../../bench/matrix/linux/matrix.gcc.g.O3
  Addr of buf1 = 0x7f8af24ae010
  Offs of buf1 = 0x7f8af24ae180
  Addr of buf2 = 0x7f8af04ad010
  Offs of buf2 = 0x7f8af04ad1c0
  Addr of buf3 = 0x7f8aee4ac010
  Offs of buf3 = 0x7f8aee4ac100
  Addr of buf4 = 0x7f8aec4ab010
  Offs of buf4 = 0x7f8aec4ab140
  Threads #: 8 Pthreads
  Matrix size: 2048
  Using multiply kernel: multiply1
  Execution time = 24.579 seconds
  [ perf record: Woken up 972 times to write data ]
  [ perf record: Captured and wrote 11.280 MB perf.data (403 samples), compressed (original 66.670 MB, ratio is 5.926) ]

  $ perf report --header --stats
  # ========
  # captured on    : Wed Oct  7 19:07:50 2020
  # header version : 1
  # data offset    : 504
  # data size      : 30056
  # feat offset    : 30560
  # hostname : nntvtune39
  # os release : 5.8.8-100.fc31.x86_64
  # perf version : 4.13.rc5.gdf19b1347b82
  # arch : x86_64
  # nrcpus online : 8
  # nrcpus avail : 8
  # cpudesc : Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
  # cpuid : GenuineIntel,6,94,3
  # total memory : 16119484 kB
  # cmdline : /root/abudanko/kernel/acme/tools/perf/perf record --threads --compression-level=3 -e cycles,instructions -- ../../bench  /matrix/linux/matrix.gcc.g.O3 
  # event : name = cycles, , id = { 54562, 54563, 54564, 54565, 54566, 54567, 54568, 54569 }, size = 120, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ID|>
  # event : name = instructions, , id = { 54570, 54571, 54572, 54573, 54574, 54575, 54576, 54577 }, size = 120, config = 0x1, { sample_period, sample_freq } = 4000, sample_ty>
  # sibling sockets : 0-7
  # sibling dies    : 0-7
  # sibling threads : 0,4
  # sibling threads : 1,5
  # sibling threads : 2,6
  # sibling threads : 3,7
  # CPU 0: Core ID 0, Die ID 0, Socket ID 0
  # CPU 1: Core ID 1, Die ID 0, Socket ID 0
  # CPU 2: Core ID 2, Die ID 0, Socket ID 0
  # CPU 3: Core ID 3, Die ID 0, Socket ID 0
  # CPU 4: Core ID 0, Die ID 0, Socket ID 0
  # CPU 5: Core ID 1, Die ID 0, Socket ID 0
  # CPU 6: Core ID 2, Die ID 0, Socket ID 0
  # CPU 7: Core ID 3, Die ID 0, Socket ID 0
  # node0 meminfo  : total = 16119484 kB, free = 933088 kB
  # node0 cpu list : 0-7
  # pmu mappings: intel_pt = 8, software = 1, power = 19, uprobe = 7, uncore_imc = 11, cpu = 4, cstate_core = 17, uncore_cbox_2 = 14, breakpoint = 5, uncore_cbox_0 = 12, trac>
  # CPU cache info:
  #  L1 Data                 32K [0,4]
  #  L1 Instruction          32K [0,4]
  #  L1 Data                 32K [1,5]
  #  L1 Instruction          32K [1,5]
  #  L1 Data                 32K [1,5]
  #  L1 Instruction          32K [1,5]
  #  L1 Data                 32K [2,6]
  #  L1 Instruction          32K [2,6]
  #  L1 Data                 32K [3,7]
  #  L1 Instruction          32K [3,7]
  #  L2 Unified             256K [0,4]
  #  L2 Unified             256K [1,5]
  #  L2 Unified             256K [2,6]
  #  L2 Unified             256K [3,7]
  #  L3 Unified            8192K [0-7]
  # time of first sample : 0.000000
  # time of last sample : 0.000000
  # sample duration :      0.000 ms
  # memory nodes (nr 1, block size 0x8000000):
  #    0 [16G]: 0-23,32-135
  # directory data version : 1
  # bpf_prog_info 835: bpf_prog_6deef7357e7b4530 addr 0xffffffffc07c5138 size 66
  # bpf_prog_info 836: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0804558 size 66
  # bpf_prog_info 837: bpf_prog_84efc2eecc454ca6 addr 0xffffffffc080804c size 373
  # bpf_prog_info 838: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0817f50 size 66
  # bpf_prog_info 839: bpf_prog_6deef7357e7b4530 addr 0xffffffffc082aee8 size 66
  # bpf_prog_info 840: bpf_prog_5a2b06eab81b8f51 addr 0xffffffffc082c0fc size 1132
  # bpf_prog_info 841: bpf_prog_8a642ed2819e9acc addr 0xffffffffc0aac380 size 62
  # bpf_prog_info 842: bpf_prog_8a642ed2819e9acc addr 0xffffffffc0d4c970 size 62
  # bpf_prog_info 843: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0d4e8bc size 66
  # bpf_prog_info 844: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0d5050c size 66
  # bpf_prog_info 845: bpf_prog_3ff695c0afc2579c addr 0xffffffffc0d56098 size 1552
  # bpf_prog_info 846: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0d58364 size 66
  # bpf_prog_info 847: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0d6ec00 size 66
  # compressed : Zstd, level = 3, ratio = 6
  # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
  # missing features: TRACING_DATA BUILD_ID BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID CLOCK_DATA 
  # ========
  #
  Aggregated stats:
           TOTAL events:    1457107
            MMAP events:         98
            LOST events:          0
            COMM events:          2
            EXIT events:          6
        THROTTLE events:          0
      UNTHROTTLE events:          0
            FORK events:          8
            READ events:          0
          SAMPLE events:    1456388
           MMAP2 events:          7
             AUX events:          0
    ITRACE_START events:          0
    LOST_SAMPLES events:          0
          SWITCH events:          0
 SWITCH_CPU_WIDE events:          0
      NAMESPACES events:          0
         KSYMBOL events:         13
       BPF_EVENT events:         13
          CGROUP events:        166
       TEXT_POKE events:          0
            ATTR events:          0
      EVENT_TYPE events:          0
    TRACING_DATA events:          0
        BUILD_ID events:          0
  FINISHED_ROUND events:          0
        ID_INDEX events:          0
   AUXTRACE_INFO events:          0
        AUXTRACE events:          0
  AUXTRACE_ERROR events:          0
      THREAD_MAP events:          1
         CPU_MAP events:          1
     STAT_CONFIG events:          0
            STAT events:          0
      STAT_ROUND events:          0
    EVENT_UPDATE events:          0
       TIME_CONV events:          1
         FEATURE events:          0
      COMPRESSED events:        403

  $ tools/perf/perf record --threads --compression-level=3 -g --call-graph dwarf,1024 -e cycles,instructions -- ../../bench/matrix/linux/matrix.gcc.g.O3
  Addr of buf1 = 0x7f15e8b89010
  Offs of buf1 = 0x7f15e8b89180
  Addr of buf2 = 0x7f15e6b88010
  Offs of buf2 = 0x7f15e6b881c0
  Addr of buf3 = 0x7f15e4b87010
  Offs of buf3 = 0x7f15e4b87100
  Addr of buf4 = 0x7f15e2b86010
  Offs of buf4 = 0x7f15e2b86140
  Threads #: 8 Pthreads
  Matrix size: 2048
  Using multiply kernel: multiply1
  Execution time = 24.281 seconds
  [ perf record: Woken up 6923 times to write data ]
  [ perf record: Captured and wrote 34.933 MB perf.data (10414 samples), compressed (original 1728.795 MB, ratio is 49.530) ]

  $ perf report --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 708K of event 'cycles'
  # Event count (approx.): 277718834163
  #
  # Children      Self  Command          Shared Object             Symbol                                                  
  # ........  ........  ...............  ........................  ........................................................
  #
    99.97%     0.00%  matrix.gcc.g.O3  libc-2.30.so              [.] __GI___clone (inlined)
            |
            ---__GI___clone (inlined)
               |          
                --99.97%--start_thread
                          |          
                           --99.97%--ThreadFunction
                                     multiply1
                                     |          
                                      --0.96%--asm_sysvec_apic_timer_interrupt
                                                |          
                                                 --0.70%--subflow_syn_recv_sock
                                                           |          
                                                            --0.60%--__sysvec_apic_timer_interrupt
                                                                      |          
                                                                       --0.57%--hrtimer_interrupt

    99.97%     0.00%  matrix.gcc.g.O3  libpthread-2.30.so        [.] start_thread
            |
            ---start_thread
               |          
                --99.97%--ThreadFunction
                          |          
                           --99.97%--multiply1
                                     |          
                                      --0.96%--asm_sysvec_apic_timer_interrupt
                                                |          
                                                 --0.70%--subflow_syn_recv_sock
                                                           |          
                                                            --0.60%--__sysvec_apic_timer_interrupt
                                                                      |          
                                                                       --0.57%--hrtimer_interrupt

    99.97%     0.00%  matrix.gcc.g.O3  matrix.gcc.g.O3           [.] ThreadFunction
            |
            ---ThreadFunction
               |          
                --99.97%--multiply1
                          |          
                           --0.96%--asm_sysvec_apic_timer_interrupt
                                     |          
                                      --0.70%--subflow_syn_recv_sock
                                                |          
                                                 --0.60%--__sysvec_apic_timer_interrupt
                                                           |          
                                                            --0.57%--hrtimer_interrupt

    99.97%    98.68%  matrix.gcc.g.O3  matrix.gcc.g.O3           [.] multiply1
            |          
            |--98.68%--__GI___clone (inlined)
            |          start_thread
            |          ThreadFunction
            |          multiply1
            |          
             --1.28%--multiply1
                       |          
                        --0.96%--asm_sysvec_apic_timer_interrupt
                                  |          
                                   --0.70%--subflow_syn_recv_sock
                                             |          
                                              --0.60%--__sysvec_apic_timer_interrupt
                                                        |          
                                                         --0.57%--hrtimer_interrupt

     0.97%     0.05%  matrix.gcc.g.O3  [kernel.kallsyms]         [k] asm_sysvec_apic_timer_interrupt
            |          
             --0.91%--asm_sysvec_apic_timer_interrupt
                       |          
                        --0.70%--subflow_syn_recv_sock


-- 
2.24.1

