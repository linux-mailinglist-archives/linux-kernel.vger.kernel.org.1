Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262292E7337
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 20:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgL2TTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 14:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgL2TTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 14:19:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 324FC207B2;
        Tue, 29 Dec 2020 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609269512;
        bh=io2KnTEM0Yp3zOg6gSjPV9V+ZBeWN1zxB5b2aI+MLMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNItszpkl3y2T3P2JPjN4iI4OSbtzgvJqQ39btQ+QoJdCit008wjorZPMFKHVxPH9
         uEsqZplr76gCZFd5i0gLFJaJDozp/5n7iOjZ9L9q3c80I1XiDWkOGz25faG1BTAKoV
         Ayc0zxy+y/aOS2+uRgANrLgLH9aANQ08RIgEIzIwc6D+YCo79pdk9ZDuHilKIIXn8x
         n2css1TRspN4ui/OUvzjLQ5YBOHbXjc2lre/zbsVZ2Cv9IzufopPOxdRG5CZcHOE2r
         qun+8x/GCWVr6/1wB5IDbS/LooOQEd/iLyjPp4TE3kwC/h7hJBWSNXgml+D63LCGnm
         WaPzi+Y4XfNhQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EEF9D411E9; Tue, 29 Dec 2020 16:18:48 -0300 (-03)
Date:   Tue, 29 Dec 2020 16:18:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
Message-ID: <20201229191848.GL521329@kernel.org>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <20201228201159.GF521329@kernel.org>
 <6CB86649-9A1B-4585-8E1F-611F25935041@fb.com>
 <20201229151504.GI521329@kernel.org>
 <3E293E73-ECB7-48E0-8A6E-337988218299@fb.com>
 <20201229184829.GK521329@kernel.org>
 <9BDC4556-E802-4152-91E1-1A4696F62AAE@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9BDC4556-E802-4152-91E1-1A4696F62AAE@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 29, 2020 at 07:11:12PM +0000, Song Liu escreveu:
> 
> 
> > On Dec 29, 2020, at 10:48 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Tue, Dec 29, 2020 at 06:42:18PM +0000, Song Liu escreveu:
> >> 
> >> 
> >>> On Dec 29, 2020, at 7:15 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>> 
> >>> Em Mon, Dec 28, 2020 at 11:43:25PM +0000, Song Liu escreveu:
> >>>> 
> >>>> 
> >>>>> On Dec 28, 2020, at 12:11 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>>>> 
> >>>>> Em Mon, Dec 28, 2020 at 09:40:53AM -0800, Song Liu escreveu:
> >>>>>> Introduce perf-stat -b option, which counts events for BPF programs, like:
> >>>>>> 
> >>>>>> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
> >>>>>>   1.487903822            115,200      ref-cycles
> >>>>>>   1.487903822             86,012      cycles
> >>>>>>   2.489147029             80,560      ref-cycles
> >>>>>>   2.489147029             73,784      cycles
> >>>>>>   3.490341825             60,720      ref-cycles
> >>>>>>   3.490341825             37,797      cycles
> >>>>>>   4.491540887             37,120      ref-cycles
> >>>>>>   4.491540887             31,963      cycles
> >>>>>> 
> >>>>>> The example above counts cycles and ref-cycles of BPF program of id 254.
> >>>>>> This is similar to bpftool-prog-profile command, but more flexible.
> >>>>>> 
> >>>>>> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> >>>>>> programs (monitor-progs) to the target BPF program (target-prog). The
> >>>>>> monitor-progs read perf_event before and after the target-prog, and
> >>>>>> aggregate the difference in a BPF map. Then the user space reads data
> >>>>>> from these maps.
> >>>>>> 
> >>>>>> A new struct bpf_counter is introduced to provide common interface that
> >>>>>> uses BPF programs/maps to count perf events.
> >>>>> 
> >>>>> Segfaulting here:
> >>>>> 
> >>>>> [root@five ~]# bpftool prog  | grep tracepoint
> >>>>> 110: tracepoint  name syscall_unaugme  tag 57cd311f2e27366b  gpl
> >>>>> 111: tracepoint  name sys_enter_conne  tag 3555418ac9476139  gpl
> >>>>> 112: tracepoint  name sys_enter_sendt  tag bc7fcadbaf7b8145  gpl
> >>>>> 113: tracepoint  name sys_enter_open  tag 0e59c3ac2bea5280  gpl
> >>>>> 114: tracepoint  name sys_enter_opena  tag 0baf443610f59837  gpl
> >>>>> 115: tracepoint  name sys_enter_renam  tag 24664e4aca62d7fa  gpl
> >>>>> 116: tracepoint  name sys_enter_renam  tag 20093e51a8634ebb  gpl
> >>>>> 117: tracepoint  name sys_enter  tag 0bc3fc9d11754ba1  gpl
> >>>>> 118: tracepoint  name sys_exit  tag 29c7ae234d79bd5c  gpl
> >>>>> [root@five ~]#
> >>>>> [root@five ~]# gdb perf
> >>>>> GNU gdb (GDB) Fedora 10.1-2.fc33
> >>>>> Reading symbols from perf...
> >>>>> (gdb) run stat -e instructions,cycles -b 113 -I 1000
> >>>>> Starting program: /root/bin/perf stat -e instructions,cycles -b 113 -I 1000
> >>>>> [Thread debugging using libthread_db enabled]
> >>>>> Using host libthread_db library "/lib64/libthread_db.so.1".
> >>>>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> >>>>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> >>>>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> >>>>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> >>>>> 
> >>>>> Program received signal SIGSEGV, Segmentation fault.
> >>>>> 0x000000000058d55b in bpf_program_profiler__read (evsel=0xc612c0) at util/bpf_counter.c:217
> >>>>> 217			reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> >>>>> (gdb) bt
> >>>>> #0  0x000000000058d55b in bpf_program_profiler__read (evsel=0xc612c0) at util/bpf_counter.c:217
> >>>>> #1  0x0000000000000000 in ?? ()
> >>>>> (gdb)
> >>>>> 
> >>>>> [acme@five perf]$ clang -v |& head -2
> >>>>> clang version 11.0.0 (Fedora 11.0.0-2.fc33)
> >>>>> Target: x86_64-unknown-linux-gnu
> >>>>> [acme@five perf]$
> >>>>> 
> >>>>> Do you need any extra info?
> >>>> 
> >>>> Hmm... I am not able to reproduce this. I am trying to setup an environment similar
> >>>> to fc33 (clang 11, etc.). Does this segfault every time, and on all programs? 
> >>> 
> >>> I'll try it with a BPF proggie attached to a kprobes, but here is
> >>> something else I noticed:
> >>> 
> >>> [root@five perf]# export PYTHONPATH=/tmp/build/perf/python
> >>> [root@five perf]# tools/perf/python/twatch.py
> >>> Traceback (most recent call last):
> >>> File "/home/acme/git/perf/tools/perf/python/twatch.py", line 9, in <module>
> >>>   import perf
> >>> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: bpf_counter__destroy
> >>> [root@five perf]# perf test python
> >>> 19: 'import perf' in python                                         : FAILED!
> >>> [root@five perf]# perf test -v python
> >>> 19: 'import perf' in python                                         :
> >>> --- start ---
> >>> test child forked, pid 3198864
> >>> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
> >>> Traceback (most recent call last):
> >>> File "<stdin>", line 1, in <module>
> >>> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: bpf_counter__destroy
> >>> test child finished with -1
> >>> ---- end ----
> >>> 'import perf' in python: FAILED!
> >>> [root@five perf]#
> >>> 
> >>> This should be trivial, I hope, just add the new object file to
> >>> tools/perf/util/python-ext-sources, then do a 'perf test python', if it
> >>> fails, use 'perf test -v python' to see what is preventing the python
> >>> binding from loading.
> >> 
> >> I fixed the undefined bpf_counter__destroy. But this one looks trickier:
> >> 
> >> 19: 'import perf' in python                                         :
> >> --- start ---
> >> test child forked, pid 2714986
> >> python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/bin/python2' "
> >> Traceback (most recent call last):
> >>  File "<stdin>", line 1, in <module>
> >> ImportError: XXXXX /tools/perf/python/perf.so: undefined symbol: bpf_map_update_elem
> >> 
> >> Given I already have:
> > 
> > I'll check this one to get a patch that at least moves the needle here,
> > i.e. probably we can leave supporting bpf counters in the python binding
> > for a later step.
> 
> Thanks Arnaldo!
> 
> Currently, I have:
> 1. Fixed issues highlighted by Namhyung;
> 2. Merged 3/4 and 4/4;
> 3. NOT found segfault;
> 4. NOT fixed python import perf. 
> 
> I don't have good ideas with 3 and 4... Shall I send current code as v7?

For 4, please fold the patch below into the relevant patch, we don't
need bpf_counter.h included in util/evsel.h, you even added a forward
declaration for that 'struct bpf_counter_ops'.

And in general we should refrain from adding extra includes to header
files, .h-ell is not good.

Then we provide a stub for that bpf_counter__destroy() so that
util/evsel.o when linked into the perf python biding find it there,
links ok.

As we don't have a way to create such events via the perf python
binding, there will nothing to be done when destroying evsels created
via python.

- Arnaldo

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 40e3946cd7518113..8226b1fefa8cf2a3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -10,7 +10,6 @@
 #include <internal/evsel.h>
 #include <perf/evsel.h>
 #include "symbol_conf.h"
-#include "bpf_counter.h"
 #include <internal/cpumap.h>
 
 struct bpf_object;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc5ade85a33fc999..9609cc166d71a6f5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -79,6 +79,21 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 	return 0;
 }
 
+/*
+ * XXX: All these evsel destructors need some better mechanism, like a linked
+ * list of destructors registered when the relevant code indeed is used instead
+ * of having more and more calls in perf_evsel__delete(). -- acme
+ *
+ * For now, add one more:
+ *
+ * Not to drag the BPF bandwagon...
+ */
+void bpf_counter__destroy(struct evsel *evsel);
+
+void bpf_counter__destroy(struct evsel *evsel __maybe_unused)
+{
+}
+
 /*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.
