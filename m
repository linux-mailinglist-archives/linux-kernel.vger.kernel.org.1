Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA35D2E6BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgL1Wzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbgL1UM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:12:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20FA820867;
        Mon, 28 Dec 2020 20:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609186303;
        bh=IBv7ErFQgYxI77/rkxGcvyjVTjqtXQuuWTqN69n9nHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgY7blOYv09NWO/CMR0qXJvx9sBmcCRL0tlfhKuaKC3kmWG9xBopO1rtiRoyFZp/M
         cjPDsyhXdwpfGJELgdjiG/i9D/l/gTLcNsJPLs/Iwq8K/EQUWWCjwOmyexvbfe8sG2
         8JXVz4dB+dE1ZMpYmR5l21V3Uk46UQ1z7rM8LIgwI8UIqSzRARBn0zPqZKzUNeOHaR
         Lk77hoNRgNfOodQAzDcH98rynhZISllgzqwyn5h7q+y/NZr1fqUmbV6OVqWjkLCLoA
         AOeX27MKrAD9zOQnDyUK/peIDC64WusLmTmowwQ5KllZHUGEJoP6pnFfeUztgbXVHs
         qtWNi9llm9PGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B772411E9; Mon, 28 Dec 2020 17:11:59 -0300 (-03)
Date:   Mon, 28 Dec 2020 17:11:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mark.rutland@arm.com, jolsa@redhat.com,
        kernel-team@fb.com
Subject: Re: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
Message-ID: <20201228201159.GF521329@kernel.org>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228174054.907740-4-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 28, 2020 at 09:40:53AM -0800, Song Liu escreveu:
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
> 
> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> programs (monitor-progs) to the target BPF program (target-prog). The
> monitor-progs read perf_event before and after the target-prog, and
> aggregate the difference in a BPF map. Then the user space reads data
> from these maps.
> 
> A new struct bpf_counter is introduced to provide common interface that
> uses BPF programs/maps to count perf events.

Segfaulting here:

[root@five ~]# bpftool prog  | grep tracepoint
110: tracepoint  name syscall_unaugme  tag 57cd311f2e27366b  gpl
111: tracepoint  name sys_enter_conne  tag 3555418ac9476139  gpl
112: tracepoint  name sys_enter_sendt  tag bc7fcadbaf7b8145  gpl
113: tracepoint  name sys_enter_open  tag 0e59c3ac2bea5280  gpl
114: tracepoint  name sys_enter_opena  tag 0baf443610f59837  gpl
115: tracepoint  name sys_enter_renam  tag 24664e4aca62d7fa  gpl
116: tracepoint  name sys_enter_renam  tag 20093e51a8634ebb  gpl
117: tracepoint  name sys_enter  tag 0bc3fc9d11754ba1  gpl
118: tracepoint  name sys_exit  tag 29c7ae234d79bd5c  gpl
[root@five ~]#
[root@five ~]# gdb perf
GNU gdb (GDB) Fedora 10.1-2.fc33
Reading symbols from perf...
(gdb) run stat -e instructions,cycles -b 113 -I 1000
Starting program: /root/bin/perf stat -e instructions,cycles -b 113 -I 1000
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame

Program received signal SIGSEGV, Segmentation fault.
0x000000000058d55b in bpf_program_profiler__read (evsel=0xc612c0) at util/bpf_counter.c:217
217			reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
(gdb) bt
#0  0x000000000058d55b in bpf_program_profiler__read (evsel=0xc612c0) at util/bpf_counter.c:217
#1  0x0000000000000000 in ?? ()
(gdb)

[acme@five perf]$ clang -v |& head -2
clang version 11.0.0 (Fedora 11.0.0-2.fc33)
Target: x86_64-unknown-linux-gnu
[acme@five perf]$

Do you need any extra info?

Please when resubmitting, please combine patches 3/4 and 4/4, man pages
updates usually come together with the new feature.

Thanks,

- Arnaldo

Full build output:

[acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;make VF=1 O=/tmp/build/perf -C tools/perf BUILD_BPF_SKEL=1 install-bin
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j24' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep
Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                        libbfd: [ on  ]
...                libbfd-buildid: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]
...                     backtrace: [ on  ]
...                       eventfd: [ on  ]
...                fortify-source: [ on  ]
...         sync-compare-and-swap: [ on  ]
...          get_current_dir_name: [ on  ]
...                        gettid: [ on  ]
...             libelf-getphdrnum: [ on  ]
...           libelf-gelf_getnote: [ on  ]
...          libelf-getshdrstrndx: [ on  ]
...             libpython-version: [ on  ]
...                      libslang: [ on  ]
...       libslang-include-subdir: [ on  ]
...   pthread-attr-setaffinity-np: [ on  ]
...               pthread-barrier: [ on  ]
...                  reallocarray: [ on  ]
...            stackprotector-all: [ on  ]
...                       timerfd: [ on  ]
...                  sched_getcpu: [ on  ]
...                           sdt: [ on  ]
...                         setns: [ on  ]
...                   file-handle: [ on  ]

...                        bionic: [ OFF ]
...                    compile-32: [ OFF ]
...                   compile-x32: [ OFF ]
...                cplus-demangle: [ on  ]
...                          gtk2: [ OFF ]
...                  gtk2-infobar: [ OFF ]
...                         hello: [ OFF ]
...                 libbabeltrace: [ on  ]
...                libbfd-liberty: [ OFF ]
...              libbfd-liberty-z: [ OFF ]
...                    libopencsd: [ OFF ]
...                 libunwind-x86: [ OFF ]
...              libunwind-x86_64: [ OFF ]
...                 libunwind-arm: [ OFF ]
...             libunwind-aarch64: [ OFF ]
...         libunwind-debug-frame: [ OFF ]
...     libunwind-debug-frame-arm: [ OFF ]
... libunwind-debug-frame-aarch64: [ OFF ]
...                           cxx: [ OFF ]
...                          llvm: [ OFF ]
...                  llvm-version: [ OFF ]
...                         clang: [ OFF ]
...                        libbpf: [ OFF ]
...                       libpfm4: [ OFF ]
...                 libdebuginfod: [ on  ]
...               clang-bpf-co-re: [ on  ]
...                        prefix: /home/acme
...                        bindir: /home/acme/bin
...                        libdir: /home/acme/lib64
...                    sysconfdir: /home/acme/etc
...                 LIBUNWIND_DIR:
...                     LIBDW_DIR:
...                          JDIR: /usr/lib/jvm/java-11-openjdk-11.0.9.11-4.fc33.x86_64
...     DWARF post unwind library: libunwind

  GEN      /tmp/build/perf/common-cmds.h
CFLAGS= make -C ../bpf/bpftool \
	OUTPUT=/tmp/build/perf/util/bpf_skel/.tmp/ bootstrap
  CC       /tmp/build/perf/exec-cmd.o
  CC       /tmp/build/perf/help.o
  MKDIR    /tmp/build/perf/pmu-events/
  MKDIR    /tmp/build/perf/jvmti/
  MKDIR    /tmp/build/perf/fd/
  MKDIR    /tmp/build/perf/fs/
  MKDIR    /tmp/build/perf/fs/
  HOSTCC   /tmp/build/perf/pmu-events/json.o
  CC       /tmp/build/perf/parse-options.o
  CC       /tmp/build/perf/fd/array.o
  CC       /tmp/build/perf/pager.o
  CC       /tmp/build/perf/jvmti/libjvmti.o
  CC       /tmp/build/perf/fs/fs.o
  CC       /tmp/build/perf/run-command.o
  MKDIR    /tmp/build/perf/jvmti/
  CC       /tmp/build/perf/sigchain.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/tracing_path.o
  CC       /tmp/build/perf/fs/cgroup.o
  MKDIR    /tmp/build/perf/pmu-events/
  CC       /tmp/build/perf/jvmti/libstring.o
  HOSTCC   /tmp/build/perf/pmu-events/jevents.o
  CC       /tmp/build/perf/jvmti/libctype.o
  CC       /tmp/build/perf/subcmd-config.o
  CC       /tmp/build/perf/jvmti/jvmti_agent.o
  LD       /tmp/build/perf/fd/libapi-in.o
  CC       /tmp/build/perf/event-parse.o
  HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/cpu.o
  CC       /tmp/build/perf/trace-seq.o
  CC       /tmp/build/perf/core.o
  CC       /tmp/build/perf/parse-filter.o
  CC       /tmp/build/perf/debug.o
  CC       /tmp/build/perf/cpumap.o
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/threadmap.o
  LD       /tmp/build/perf/libsubcmd-in.o
  HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
  CC       /tmp/build/perf/str_error_r.o
  CC       /tmp/build/perf/evsel.o
  GEN      /tmp/build/perf/bpf_helper_defs.h
  CC       /tmp/build/perf/evlist.o
  CC       /tmp/build/perf/parse-utils.o
  CC       /tmp/build/perf/zalloc.o
  CC       /tmp/build/perf/kbuffer-parse.o
  LD       /tmp/build/perf/jvmti/jvmti-in.o
  CC       /tmp/build/perf/mmap.o
  CC       /tmp/build/perf/tep_strerror.o
  CC       /tmp/build/perf/xyarray.o
  CC       /tmp/build/perf/event-parse-api.o
  CC       /tmp/build/perf/lib.o
  LINK     /tmp/build/perf/pmu-events/jevents
  LD       /tmp/build/perf/libapi-in.o
  AR       /tmp/build/perf/libsubcmd.a
  LINK     /tmp/build/perf/libperf-jvmti.so
  LD       /tmp/build/perf/libtraceevent-in.o
  CC       /tmp/build/perf/plugin_hrtimer.o
  CC       /tmp/build/perf/plugin_kmem.o
  CC       /tmp/build/perf/plugin_mac80211.o
  CC       /tmp/build/perf/plugin_kvm.o
  CC       /tmp/build/perf/plugin_jbd2.o
  LD       /tmp/build/perf/libperf-in.o
  CC       /tmp/build/perf/plugin_sched_switch.o
  CC       /tmp/build/perf/plugin_function.o
  CC       /tmp/build/perf/plugin_scsi.o
  CC       /tmp/build/perf/plugin_xen.o
  CC       /tmp/build/perf/plugin_futex.o
  CC       /tmp/build/perf/plugin_cfg80211.o
  CC       /tmp/build/perf/plugin_tlb.o
  AR       /tmp/build/perf/libapi.a
  LD       /tmp/build/perf/plugin_hrtimer-in.o
  LINK     /tmp/build/perf/libtraceevent.a
  LD       /tmp/build/perf/plugin_kvm-in.o
  LD       /tmp/build/perf/plugin_scsi-in.o
  LD       /tmp/build/perf/plugin_kmem-in.o
  LD       /tmp/build/perf/plugin_mac80211-in.o
  LD       /tmp/build/perf/plugin_futex-in.o
  LD       /tmp/build/perf/plugin_function-in.o
  LD       /tmp/build/perf/plugin_xen-in.o
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  LD       /tmp/build/perf/plugin_tlb-in.o
  LD       /tmp/build/perf/plugin_jbd2-in.o
  LINK     /tmp/build/perf/plugin_hrtimer.so
  LINK     /tmp/build/perf/plugin_kmem.so
  AR       /tmp/build/perf/libperf.a
  LINK     /tmp/build/perf/plugin_scsi.so
  LINK     /tmp/build/perf/plugin_kvm.so
  LINK     /tmp/build/perf/plugin_mac80211.so
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugin_futex.so
  LINK     /tmp/build/perf/plugin_xen.so
  LINK     /tmp/build/perf/plugin_function.so
  LINK     /tmp/build/perf/plugin_tlb.so
  LINK     /tmp/build/perf/plugin_jbd2.so
  LINK     /tmp/build/perf/plugin_cfg80211.so
  LINK     /tmp/build/perf/plugin_sched_switch.so
  GEN      /tmp/build/perf/pmu-events/pmu-events.c
  GEN      /tmp/build/perf/libtraceevent-dynamic-list
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  PERF_VERSION = 5.11.rc1.g5eb0b370de61
  MKDIR    /tmp/build/perf/staticobjs/
  CC       /tmp/build/perf/staticobjs/libbpf_probes.o
  CC       /tmp/build/perf/staticobjs/libbpf.o
  CC       /tmp/build/perf/staticobjs/bpf.o
  CC       /tmp/build/perf/staticobjs/nlattr.o
  CC       /tmp/build/perf/staticobjs/btf.o
  CC       /tmp/build/perf/staticobjs/xsk.o
  GEN      perf-archive
  CC       /tmp/build/perf/staticobjs/hashmap.o
  GEN      perf-with-kcore
  CC       /tmp/build/perf/staticobjs/btf_dump.o
  CC       /tmp/build/perf/staticobjs/libbpf_errno.o
  CC       /tmp/build/perf/staticobjs/str_error.o
  CC       /tmp/build/perf/staticobjs/bpf_prog_linfo.o
  CC       /tmp/build/perf/staticobjs/netlink.o
  CC       /tmp/build/perf/staticobjs/ringbuf.o
  LD       /tmp/build/perf/staticobjs/libbpf-in.o
  LINK     /tmp/build/perf/libbpf.a
  CLANG    /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  DESCEND  plugins
  GEN      /tmp/build/perf/python/perf.so
  CC       /tmp/build/perf/plugins/plugin_jbd2.o
  CC       /tmp/build/perf/plugins/plugin_kmem.o
  CC       /tmp/build/perf/plugins/plugin_hrtimer.o
  CC       /tmp/build/perf/plugins/plugin_mac80211.o
  CC       /tmp/build/perf/plugins/plugin_kvm.o
  CC       /tmp/build/perf/plugins/plugin_function.o
  CC       /tmp/build/perf/plugins/plugin_xen.o
  CC       /tmp/build/perf/plugins/plugin_sched_switch.o
  CC       /tmp/build/perf/plugins/plugin_futex.o
  CC       /tmp/build/perf/plugins/plugin_scsi.o
  CC       /tmp/build/perf/plugins/plugin_tlb.o
  CC       /tmp/build/perf/plugins/plugin_cfg80211.o
  LD       /tmp/build/perf/plugins/plugin_jbd2-in.o
  LD       /tmp/build/perf/plugins/plugin_kmem-in.o
  LD       /tmp/build/perf/plugins/plugin_hrtimer-in.o
  LD       /tmp/build/perf/plugins/plugin_kvm-in.o
  LD       /tmp/build/perf/plugins/plugin_mac80211-in.o
  LD       /tmp/build/perf/plugins/plugin_function-in.o
  LD       /tmp/build/perf/plugins/plugin_xen-in.o
  LD       /tmp/build/perf/plugins/plugin_sched_switch-in.o
  LD       /tmp/build/perf/plugins/plugin_scsi-in.o
  LD       /tmp/build/perf/plugins/plugin_futex-in.o
  LD       /tmp/build/perf/plugins/plugin_cfg80211-in.o
  LD       /tmp/build/perf/plugins/plugin_tlb-in.o
  LINK     /tmp/build/perf/plugins/plugin_jbd2.so
  LINK     /tmp/build/perf/plugins/plugin_hrtimer.so
  LINK     /tmp/build/perf/plugins/plugin_kmem.so
  LINK     /tmp/build/perf/plugins/plugin_mac80211.so
  LINK     /tmp/build/perf/plugins/plugin_kvm.so
  LINK     /tmp/build/perf/plugins/plugin_sched_switch.so
  LINK     /tmp/build/perf/plugins/plugin_scsi.so
  LINK     /tmp/build/perf/plugins/plugin_xen.so
  LINK     /tmp/build/perf/plugins/plugin_function.so
  LINK     /tmp/build/perf/plugins/plugin_futex.so
  LINK     /tmp/build/perf/plugins/plugin_tlb.so
  LINK     /tmp/build/perf/plugins/plugin_cfg80211.so
  INSTALL  trace_plugins
  CC       /tmp/build/perf/pmu-events/pmu-events.o
  LD       /tmp/build/perf/pmu-events/pmu-events-in.o

Auto-detecting system features:
...                        libbfd: [ on  ]
...        disassembler-four-args: [ on  ]
...                          zlib: [ on  ]
...                        libcap: [ on  ]
...               clang-bpf-co-re: [ on  ]
...                  reallocarray: [ on  ]

  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/
  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/main.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/common.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/json_writer.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/gen.o

Auto-detecting system features:
...                        libelf: [ on  ]
...                          zlib: [ on  ]
...                           bpf: [ on  ]

  GEN      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/bpf_helper_defs.h
  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/nlattr.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/xsk.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/netlink.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/str_error.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/hashmap.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf_dump.o
  CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/ringbuf.o
  LD       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/libbpf.a
  LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/bpftool
  GEN-SKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
  CC       /tmp/build/perf/builtin-bench.o
  CC       /tmp/build/perf/builtin-annotate.o
  CC       /tmp/build/perf/builtin-diff.o
  CC       /tmp/build/perf/builtin-config.o
  CC       /tmp/build/perf/builtin-ftrace.o
  CC       /tmp/build/perf/builtin-help.o
  CC       /tmp/build/perf/builtin-evlist.o
  CC       /tmp/build/perf/builtin-sched.o
  CC       /tmp/build/perf/builtin-buildid-list.o
  CC       /tmp/build/perf/builtin-kallsyms.o
  CC       /tmp/build/perf/builtin-buildid-cache.o
  CC       /tmp/build/perf/builtin-record.o
  CC       /tmp/build/perf/builtin-report.o
  CC       /tmp/build/perf/builtin-list.o
  CC       /tmp/build/perf/builtin-stat.o
  CC       /tmp/build/perf/builtin-top.o
  CC       /tmp/build/perf/builtin-timechart.o
  CC       /tmp/build/perf/builtin-script.o
  CC       /tmp/build/perf/builtin-kmem.o
  CC       /tmp/build/perf/builtin-lock.o
  CC       /tmp/build/perf/builtin-kvm.o
  CC       /tmp/build/perf/builtin-inject.o
  CC       /tmp/build/perf/builtin-mem.o
  CC       /tmp/build/perf/builtin-version.o
  CC       /tmp/build/perf/builtin-data.o
  CC       /tmp/build/perf/builtin-trace.o
  CC       /tmp/build/perf/builtin-probe.o
  CC       /tmp/build/perf/builtin-c2c.o
  MKDIR    /tmp/build/perf/bench/
  MKDIR    /tmp/build/perf/bench/
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/arch/common.o
  MKDIR    /tmp/build/perf/ui/
  MKDIR    /tmp/build/perf/bench/
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/bench/sched-messaging.o
  CC       /tmp/build/perf/bench/sched-pipe.o
  CC       /tmp/build/perf/tests/builtin-test.o
  MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
  MKDIR    /tmp/build/perf/scripts/perl/Perf-Trace-Util/
  MKDIR    /tmp/build/perf/tests/
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/setup.o
  CC       /tmp/build/perf/tests/attr.o
  CC       /tmp/build/perf/bench/syscall.o
  CC       /tmp/build/perf/tests/parse-events.o
  CC       /tmp/build/perf/trace/beauty/clone.o
  CC       /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
  CC       /tmp/build/perf/tests/dso-data.o
  MKDIR    /tmp/build/perf/arch/x86/util/
  CC       /tmp/build/perf/ui/helpline.o
  CC       /tmp/build/perf/scripts/perl/Perf-Trace-Util/Context.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/util.o
  CC       /tmp/build/perf/arch/x86/util/header.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  CC       /tmp/build/perf/ui/hist.o
  CC       /tmp/build/perf/ui/progress.o
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  CC       /tmp/build/perf/arch/x86/tests/regs_load.o
  CC       /tmp/build/perf/bench/mem-functions.o
  CC       /tmp/build/perf/trace/beauty/fcntl.o
  CC       /tmp/build/perf/trace/beauty/flock.o
  CC       /tmp/build/perf/bench/futex-hash.o
  CC       /tmp/build/perf/trace/beauty/fsmount.o
  CC       /tmp/build/perf/perf.o
  CC       /tmp/build/perf/tests/openat-syscall.o
  MKDIR    /tmp/build/perf/ui/stdio/
  MKDIR    /tmp/build/perf/arch/x86/util/
  LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
  CC       /tmp/build/perf/arch/x86/util/pmu.o
  CC       /tmp/build/perf/trace/beauty/fspick.o
  CC       /tmp/build/perf/arch/x86/util/tsc.o
  CC       /tmp/build/perf/util/annotate.o
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
  CC       /tmp/build/perf/trace/beauty/ioctl.o
  CC       /tmp/build/perf/bench/futex-wake.o
  CC       /tmp/build/perf/arch/x86/tests/dwarf-unwind.o
  CC       /tmp/build/perf/bench/futex-wake-parallel.o
  CC       /tmp/build/perf/ui/stdio/hist.o
  CC       /tmp/build/perf/arch/x86/tests/arch-tests.o
  CC       /tmp/build/perf/trace/beauty/kcmp.o
  CC       /tmp/build/perf/arch/x86/util/perf_regs.o
  CC       /tmp/build/perf/trace/beauty/mount_flags.o
  CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
  CC       /tmp/build/perf/bench/futex-requeue.o
  CC       /tmp/build/perf/util/block-info.o
  CC       /tmp/build/perf/arch/x86/tests/rdpmc.o
  CC       /tmp/build/perf/bench/futex-lock-pi.o
  CC       /tmp/build/perf/arch/x86/tests/insn-x86.o
  CC       /tmp/build/perf/trace/beauty/move_mount.o
  CC       /tmp/build/perf/tests/mmap-basic.o
  CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
  CC       /tmp/build/perf/tests/perf-record.o
  CC       /tmp/build/perf/trace/beauty/arch_prctl.o
  CC       /tmp/build/perf/arch/x86/util/topdown.o
  CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
  CC       /tmp/build/perf/tests/evsel-tp-sched.o
  CC       /tmp/build/perf/arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC       /tmp/build/perf/bench/epoll-wait.o
  CC       /tmp/build/perf/tests/fdarray.o
  CC       /tmp/build/perf/bench/epoll-ctl.o
  CC       /tmp/build/perf/arch/x86/util/machine.o
  CC       /tmp/build/perf/trace/beauty/prctl.o
  CC       /tmp/build/perf/ui/browser.o
  CC       /tmp/build/perf/arch/x86/util/event.o
  CC       /tmp/build/perf/arch/x86/tests/bp-modify.o
  CC       /tmp/build/perf/trace/beauty/renameat.o
  CC       /tmp/build/perf/tests/pmu.o
  CC       /tmp/build/perf/tests/pmu-events.o
  CC       /tmp/build/perf/tests/hists_common.o
  CC       /tmp/build/perf/bench/synthesize.o
  CC       /tmp/build/perf/arch/x86/util/dwarf-regs.o
  CC       /tmp/build/perf/tests/hists_link.o
  CC       /tmp/build/perf/trace/beauty/sockaddr.o
  CC       /tmp/build/perf/arch/x86/util/unwind-libunwind.o
  CC       /tmp/build/perf/trace/beauty/socket.o
  CC       /tmp/build/perf/trace/beauty/statx.o
  LD       /tmp/build/perf/arch/x86/tests/perf-in.o
  CC       /tmp/build/perf/arch/x86/util/auxtrace.o
  CC       /tmp/build/perf/arch/x86/util/archinsn.o
  CC       /tmp/build/perf/bench/kallsyms-parse.o
  CC       /tmp/build/perf/bench/find-bit-bench.o
  CC       /tmp/build/perf/arch/x86/util/intel-pt.o
  CC       /tmp/build/perf/trace/beauty/sync_file_range.o
  CC       /tmp/build/perf/arch/x86/util/intel-bts.o
  MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_irq_vectors.o
  MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
  CC       /tmp/build/perf/util/block-range.o
  CC       /tmp/build/perf/ui/browsers/annotate.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/util/build-id.o
  CC       /tmp/build/perf/bench/inject-buildid.o
  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/browsers/hists.o
  CC       /tmp/build/perf/ui/browsers/map.o
  LD       /tmp/build/perf/arch/x86/util/perf-in.o
  CC       /tmp/build/perf/tests/hists_filter.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
  CC       /tmp/build/perf/ui/tui/setup.o
  CC       /tmp/build/perf/ui/tui/util.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/bench/numa.o
  CC       /tmp/build/perf/util/cacheline.o
  CC       /tmp/build/perf/ui/browsers/scripts.o
  LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
  CC       /tmp/build/perf/ui/tui/helpline.o
  CC       /tmp/build/perf/util/config.o
  CC       /tmp/build/perf/ui/tui/progress.o
  CC       /tmp/build/perf/ui/browsers/header.o
  LD       /tmp/build/perf/trace/beauty/perf-in.o
  CC       /tmp/build/perf/ui/browsers/res_sample.o
  CC       /tmp/build/perf/tests/hists_output.o
  LD       /tmp/build/perf/bench/perf-in.o
  CC       /tmp/build/perf/tests/hists_cumulate.o
  CC       /tmp/build/perf/util/copyfile.o
  LD       /tmp/build/perf/arch/x86/perf-in.o
  CC       /tmp/build/perf/util/ctype.o
  CC       /tmp/build/perf/util/db-export.o
  CC       /tmp/build/perf/util/env.o
  CC       /tmp/build/perf/util/event.o
  LD       /tmp/build/perf/arch/perf-in.o
  CC       /tmp/build/perf/util/evlist.o
  CC       /tmp/build/perf/util/sideband_evlist.o
  CC       /tmp/build/perf/util/evsel.o
  CC       /tmp/build/perf/util/evsel_fprintf.o
  CC       /tmp/build/perf/tests/python-use.o
  CC       /tmp/build/perf/util/perf_event_attr_fprintf.o
  CC       /tmp/build/perf/util/evswitch.o
  CC       /tmp/build/perf/util/find_bit.o
  CC       /tmp/build/perf/tests/bp_signal.o
  LD       /tmp/build/perf/ui/tui/perf-in.o
  CC       /tmp/build/perf/util/get_current_dir_name.o
  CC       /tmp/build/perf/tests/bp_signal_overflow.o
  CC       /tmp/build/perf/util/kallsyms.o
  CC       /tmp/build/perf/tests/bp_account.o
  CC       /tmp/build/perf/util/llvm-utils.o
  CC       /tmp/build/perf/util/levenshtein.o
  CC       /tmp/build/perf/util/mmap.o
  CC       /tmp/build/perf/tests/wp.o
  CC       /tmp/build/perf/util/memswap.o
  CC       /tmp/build/perf/util/perf_regs.o
  BISON    /tmp/build/perf/util/parse-events-bison.c
  CC       /tmp/build/perf/tests/task-exit.o
  CC       /tmp/build/perf/util/path.o
  CC       /tmp/build/perf/util/print_binary.o
  CC       /tmp/build/perf/util/rlimit.o
  CC       /tmp/build/perf/tests/sw-clock.o
  CC       /tmp/build/perf/tests/mmap-thread-lookup.o
  CC       /tmp/build/perf/util/argv_split.o
  CC       /tmp/build/perf/util/rbtree.o
  CC       /tmp/build/perf/tests/thread-maps-share.o
  CC       /tmp/build/perf/util/libstring.o
  CC       /tmp/build/perf/tests/switch-tracking.o
  CC       /tmp/build/perf/tests/keep-tracking.o
  CC       /tmp/build/perf/util/bitmap.o
  CC       /tmp/build/perf/util/hweight.o
  CC       /tmp/build/perf/util/smt.o
  CC       /tmp/build/perf/tests/code-reading.o
  CC       /tmp/build/perf/util/strbuf.o
  CC       /tmp/build/perf/util/string.o
  CC       /tmp/build/perf/tests/sample-parsing.o
  CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
  CC       /tmp/build/perf/util/strfilter.o
  CC       /tmp/build/perf/tests/kmod-path.o
  CC       /tmp/build/perf/util/strlist.o
  CC       /tmp/build/perf/util/top.o
  CC       /tmp/build/perf/tests/thread-map.o
  CC       /tmp/build/perf/util/usage.o
  CC       /tmp/build/perf/util/dso.o
  CC       /tmp/build/perf/util/dsos.o
  CC       /tmp/build/perf/util/symbol.o
  CC       /tmp/build/perf/util/symbol_fprintf.o
  CC       /tmp/build/perf/tests/llvm.o
  CC       /tmp/build/perf/util/color.o
  CC       /tmp/build/perf/util/color_config.o
  CC       /tmp/build/perf/util/metricgroup.o
  CC       /tmp/build/perf/util/header.o
  CC       /tmp/build/perf/util/callchain.o
  CC       /tmp/build/perf/util/values.o
  CC       /tmp/build/perf/tests/bpf.o
  CC       /tmp/build/perf/util/debug.o
  CC       /tmp/build/perf/util/fncache.o
  CC       /tmp/build/perf/tests/topology.o
  CC       /tmp/build/perf/util/machine.o
  CC       /tmp/build/perf/tests/cpumap.o
  CC       /tmp/build/perf/util/map.o
  CC       /tmp/build/perf/tests/mem.o
  CC       /tmp/build/perf/util/pstack.o
  CC       /tmp/build/perf/util/session.o
  CC       /tmp/build/perf/tests/stat.o
  CC       /tmp/build/perf/tests/event_update.o
  LD       /tmp/build/perf/ui/browsers/perf-in.o
  CC       /tmp/build/perf/tests/event-times.o
  CC       /tmp/build/perf/tests/expr.o
  CC       /tmp/build/perf/util/sample-raw.o
  CC       /tmp/build/perf/util/s390-sample-raw.o
  CC       /tmp/build/perf/tests/sdt.o
  CC       /tmp/build/perf/util/syscalltbl.o
  CC       /tmp/build/perf/tests/is_printable_array.o
  CC       /tmp/build/perf/util/ordered-events.o
  CC       /tmp/build/perf/tests/backward-ring-buffer.o
  CC       /tmp/build/perf/tests/bitmap.o
  CC       /tmp/build/perf/util/namespaces.o
  CC       /tmp/build/perf/tests/perf-hooks.o
  CC       /tmp/build/perf/tests/clang.o
  CC       /tmp/build/perf/util/comm.o
  CC       /tmp/build/perf/tests/unit_number__scnprintf.o
  CC       /tmp/build/perf/tests/mem2node.o
  CC       /tmp/build/perf/tests/maps.o
  CC       /tmp/build/perf/util/thread.o
  CC       /tmp/build/perf/util/thread_map.o
  CC       /tmp/build/perf/tests/time-utils-test.o
  CC       /tmp/build/perf/tests/genelf.o
  CC       /tmp/build/perf/util/trace-event-parse.o
  BISON    /tmp/build/perf/util/pmu-bison.c
  CC       /tmp/build/perf/util/trace-event-read.o
  CC       /tmp/build/perf/tests/api-io.o
  CC       /tmp/build/perf/util/trace-event-info.o
  CC       /tmp/build/perf/util/trace-event-scripting.o
  CC       /tmp/build/perf/tests/pfm.o
  CC       /tmp/build/perf/tests/demangle-java-test.o
  CC       /tmp/build/perf/util/trace-event.o
  LD       /tmp/build/perf/ui/perf-in.o
  CC       /tmp/build/perf/tests/parse-metric.o
  CC       /tmp/build/perf/tests/pe-file-parsing.o
  CC       /tmp/build/perf/tests/expand-cgroup.o
  CC       /tmp/build/perf/tests/perf-time-to-tsc.o
  CC       /tmp/build/perf/util/svghelper.o
  CC       /tmp/build/perf/util/sort.o
  CC       /tmp/build/perf/util/hist.o
  CC       /tmp/build/perf/tests/dwarf-unwind.o
  CC       /tmp/build/perf/tests/llvm-src-base.o
  CC       /tmp/build/perf/util/cpumap.o
  CC       /tmp/build/perf/util/util.o
  CC       /tmp/build/perf/util/affinity.o
  CC       /tmp/build/perf/util/cputopo.o
  CC       /tmp/build/perf/util/target.o
  CC       /tmp/build/perf/util/cgroup.o
  CC       /tmp/build/perf/tests/llvm-src-kbuild.o
  CC       /tmp/build/perf/util/rblist.o
  CC       /tmp/build/perf/tests/llvm-src-prologue.o
  CC       /tmp/build/perf/tests/llvm-src-relocation.o
  CC       /tmp/build/perf/util/intlist.o
  CC       /tmp/build/perf/util/counts.o
  CC       /tmp/build/perf/util/vdso.o
  CC       /tmp/build/perf/util/stat.o
  CC       /tmp/build/perf/util/stat-shadow.o
  CC       /tmp/build/perf/util/stat-display.o
  CC       /tmp/build/perf/util/perf_api_probe.o
  CC       /tmp/build/perf/util/record.o
  CC       /tmp/build/perf/util/srcline.o
  LD       /tmp/build/perf/tests/perf-in.o
  CC       /tmp/build/perf/util/srccode.o
  CC       /tmp/build/perf/util/synthetic-events.o
  CC       /tmp/build/perf/util/data.o
  CC       /tmp/build/perf/util/cloexec.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/util/rwsem.o
  CC       /tmp/build/perf/util/call-path.o
  CC       /tmp/build/perf/util/thread-stack.o
  CC       /tmp/build/perf/util/spark.o
  CC       /tmp/build/perf/util/topdown.o
  CC       /tmp/build/perf/util/auxtrace.o
  CC       /tmp/build/perf/util/intel-pt.o
  CC       /tmp/build/perf/util/stream.o
  CC       /tmp/build/perf/util/intel-bts.o
  MKDIR    /tmp/build/perf/util/arm-spe-decoder/
  CC       /tmp/build/perf/util/arm-spe.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  MKDIR    /tmp/build/perf/util/arm-spe-decoder/
  CC       /tmp/build/perf/util/s390-cpumsf.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  MKDIR    /tmp/build/perf/util/scripting-engines/
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  MKDIR    /tmp/build/perf/util/scripting-engines/
  CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.o
  GEN      /tmp/build/perf/util/intel-pt-decoder/inat-tables.c
  CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-decoder.o
  CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
  CC       /tmp/build/perf/util/dump-insn.o
  CC       /tmp/build/perf/util/parse-branch-options.o
  CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
  CC       /tmp/build/perf/util/parse-regs-options.o
  CC       /tmp/build/perf/util/parse-sublevel-options.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  CC       /tmp/build/perf/util/term.o
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  LD       /tmp/build/perf/util/arm-spe-decoder/perf-in.o
  CC       /tmp/build/perf/util/mem-events.o
  CC       /tmp/build/perf/util/vsprintf.o
  CC       /tmp/build/perf/util/units.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-decoder.o
  BISON    /tmp/build/perf/util/expr-bison.c
  CC       /tmp/build/perf/util/time-utils.o
  CC       /tmp/build/perf/util/branch.o
  CC       /tmp/build/perf/util/mem2node.o
  CC       /tmp/build/perf/util/clockid.o
  CC       /tmp/build/perf/util/bpf-loader.o
  CC       /tmp/build/perf/util/bpf_map.o
  CC       /tmp/build/perf/util/bpf_counter.o
  CC       /tmp/build/perf/util/bpf-prologue.o
  CC       /tmp/build/perf/util/symbol-elf.o
  CC       /tmp/build/perf/util/probe-file.o
  CC       /tmp/build/perf/util/probe-event.o
  CC       /tmp/build/perf/util/probe-finder.o
  CC       /tmp/build/perf/util/dwarf-aux.o
  CC       /tmp/build/perf/util/dwarf-regs.o
  LD       /tmp/build/perf/util/scripting-engines/perf-in.o
  CC       /tmp/build/perf/util/unwind-libunwind-local.o
  CC       /tmp/build/perf/util/unwind-libunwind.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       /tmp/build/perf/util/data-convert-bt.o
  CC       /tmp/build/perf/util/zlib.o
  CC       /tmp/build/perf/util/lzma.o
  CC       /tmp/build/perf/util/cap.o
  CC       /tmp/build/perf/util/zstd.o
  CC       /tmp/build/perf/util/demangle-java.o
  CC       /tmp/build/perf/util/demangle-rust.o
  CC       /tmp/build/perf/util/genelf.o
  CC       /tmp/build/perf/util/jitdump.o
  CC       /tmp/build/perf/util/genelf_debug.o
  CC       /tmp/build/perf/util/perf-hooks.o
  CC       /tmp/build/perf/util/bpf-event.o
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
  FLEX     /tmp/build/perf/util/parse-events-flex.c
  CC       /tmp/build/perf/util/parse-events-bison.o
  FLEX     /tmp/build/perf/util/expr-flex.c
  CC       /tmp/build/perf/util/expr-bison.o
  LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/expr-flex.o
  CC       /tmp/build/perf/util/expr.o
  LD       /tmp/build/perf/scripts/perl/Perf-Trace-Util/perf-in.o
  LD       /tmp/build/perf/scripts/perf-in.o
  LD       /tmp/build/perf/util/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf
  INSTALL  tests
  INSTALL  binaries
  INSTALL  libperf-jvmti.so
  INSTALL  libexec
  INSTALL  bpf-headers
  INSTALL  bpf-examples
  INSTALL  perf-archive
  INSTALL  perf-with-kcore
  INSTALL  strace/groups
  INSTALL  perl-scripts
  INSTALL  python-scripts
  INSTALL  perf_completion-script
  INSTALL  perf-tip
make: Leaving directory '/home/acme/git/perf/tools/perf'
[acme@five perf]$
 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/Makefile.perf                      |   2 +-
>  tools/perf/builtin-stat.c                     |  77 ++++-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf_counter.c                 | 296 ++++++++++++++++++
>  tools/perf/util/bpf_counter.h                 |  72 +++++
>  .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
>  tools/perf/util/evsel.c                       |   9 +
>  tools/perf/util/evsel.h                       |   6 +
>  tools/perf/util/stat-display.c                |   4 +-
>  tools/perf/util/stat.c                        |   2 +-
>  tools/perf/util/target.c                      |  34 +-
>  tools/perf/util/target.h                      |  10 +
>  12 files changed, 588 insertions(+), 18 deletions(-)
>  create mode 100644 tools/perf/util/bpf_counter.c
>  create mode 100644 tools/perf/util/bpf_counter.h
>  create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> 
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
> index 8cc24967bc273..09bffb3fbcdd4 100644
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
> @@ -409,12 +410,31 @@ static int read_affinity_counters(struct timespec *rs)
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
> +		err = read_bpf_map_counters();
> +		if (err == -EAGAIN)
> +			err = read_affinity_counters(rs);
> +		if (err < 0)
> +			return;
> +	}
>  
>  	evlist__for_each_entry(evsel_list, counter) {
>  		if (counter->err)
> @@ -496,11 +516,20 @@ static bool handle_interval(unsigned int interval, int *times)
>  	return false;
>  }
>  
> -static void enable_counters(void)
> +static int enable_counters(void)
>  {
> +	struct evsel *evsel;
> +	int err;
> +
> +	evlist__for_each_entry(evsel_list, evsel) {
> +		err = bpf_counter__enable(evsel);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (stat_config.initial_delay < 0) {
>  		pr_info(EVLIST_DISABLED_MSG);
> -		return;
> +		return 0;
>  	}
>  
>  	if (stat_config.initial_delay > 0) {
> @@ -518,6 +547,7 @@ static void enable_counters(void)
>  		if (stat_config.initial_delay > 0)
>  			pr_info(EVLIST_ENABLED_MSG);
>  	}
> +	return 0;
>  }
>  
>  static void disable_counters(void)
> @@ -720,7 +750,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	const bool forks = (argc > 0);
>  	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
>  	struct affinity affinity;
> -	int i, cpu;
> +	int i, cpu, err;
>  	bool second_pass = false;
>  
>  	if (forks) {
> @@ -737,6 +767,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	if (affinity__setup(&affinity) < 0)
>  		return -1;
>  
> +	evlist__for_each_entry(evsel_list, counter) {
> +		if (bpf_counter__load(counter, &target))
> +			return -1;
> +	}
> +
>  	evlist__for_each_cpu (evsel_list, i, cpu) {
>  		affinity__set(&affinity, cpu);
>  
> @@ -850,7 +885,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	}
>  
>  	if (STAT_RECORD) {
> -		int err, fd = perf_data__fd(&perf_stat.data);
> +		int fd = perf_data__fd(&perf_stat.data);
>  
>  		if (is_pipe) {
>  			err = perf_header__write_pipe(perf_data__fd(&perf_stat.data));
> @@ -876,7 +911,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
> @@ -895,7 +932,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
> @@ -1085,6 +1124,10 @@ static struct option stat_options[] = {
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
> @@ -2064,11 +2107,12 @@ int cmd_stat(int argc, const char **argv)
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
> @@ -2179,6 +2223,12 @@ int cmd_stat(int argc, const char **argv)
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
> @@ -2252,8 +2302,6 @@ int cmd_stat(int argc, const char **argv)
>  		}
>  	}
>  
> -	target__validate(&target);
> -
>  	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
>  		target.per_thread = true;
>  
> @@ -2384,9 +2432,10 @@ int cmd_stat(int argc, const char **argv)
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
> index 0000000000000..f2cb86a40c882
> --- /dev/null
> +++ b/tools/perf/util/bpf_counter.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Copyright (c) 2019 Facebook */
> +
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
> +	struct bpf_counter *counter;
> +
> +	list_for_each_entry(counter, &evsel->bpf_counter_list, list)
> +		bpf_prog_profiler_bpf__destroy(counter->skel);
> +	INIT_LIST_HEAD(&evsel->bpf_counter_list);
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
> +	counter->skel = skel;
> +	list_add(&counter->list, &evsel->bpf_counter_list);
> +	close(prog_fd);
> +	return 0;
> +err_out:
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
> +		reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> +
> +		err = bpf_map_lookup_elem(reading_map_fd, &key, values);
> +		if (err) {
> +			fprintf(stderr, "failed to read value\n");
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
> index c26ea82220bd8..7265308765d73 100644
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
> @@ -1366,6 +1372,7 @@ void evsel__exit(struct evsel *evsel)
>  {
>  	assert(list_empty(&evsel->core.node));
>  	assert(evsel->evlist == NULL);
> +	bpf_counter__destroy(evsel);
>  	evsel__free_counts(evsel);
>  	perf_evsel__free_fd(&evsel->core);
>  	perf_evsel__free_id(&evsel->core);
> @@ -1781,6 +1788,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			FD(evsel, cpu, thread) = fd;
>  
> +			bpf_counter__install_pe(evsel, cpu, fd);
> +
>  			if (unlikely(test_attr__enabled)) {
>  				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
>  						fd, group_fd, flags);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index cd1d8dd431997..40e3946cd7518 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -10,6 +10,7 @@
>  #include <internal/evsel.h>
>  #include <perf/evsel.h>
>  #include "symbol_conf.h"
> +#include "bpf_counter.h"
>  #include <internal/cpumap.h>
>  
>  struct bpf_object;
> @@ -17,6 +18,8 @@ struct cgroup;
>  struct perf_counts;
>  struct perf_stat_evsel;
>  union perf_event;
> +struct bpf_counter_ops;
> +struct target;
>  
>  typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>  
> @@ -127,6 +130,8 @@ struct evsel {
>  	 * See also evsel__has_callchain().
>  	 */
>  	__u64			synth_sample_type;
> +	struct list_head	bpf_counter_list;
> +	struct bpf_counter_ops	*bpf_counter_ops;
>  };
>  
>  struct perf_missing_features {
> @@ -424,4 +429,5 @@ static inline bool evsel__is_dummy_event(struct evsel *evsel)
>  struct perf_env *evsel__env(struct evsel *evsel);
>  
>  int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
> +
>  #endif /* __PERF_EVSEL_H */
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
