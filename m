Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE22E7313
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgL2Ssz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2Ssy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:48:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F29AC206B5;
        Tue, 29 Dec 2020 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609267693;
        bh=ylN8cvaU4FVA4tQeY04h6y1VjcTky5lasu6MD9Sxr+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tk7/jS32472owj0+bJOt03jlSaBnriKuIiCFJgyIFiEZCPvVWFQ/l24iZbmjODDSY
         HY4Xh5KoP1X/9Vn9hbY3GQWvDLVprKvwAV6NHWmUV0moI69m/nQcsYpn+BEOoAkDPB
         UJbvloGM1p8LAX53nMbeJtUk7NbI7x6yQxL/p0LSzzMnnfL1/Z+nK/maog/m+R03t0
         QsywAcA3RyshdWGhrhq3bBi1FqkDL2DHJZ68M13dxNTTYCjAVi9E6oOkLSlcFGxVg7
         FpMHEvxGR/3bkhrJ2mDFsGc66FGDJmeQ/wgvCrTXaRg7cD6UNZPgElpOX48W8sZjBK
         wk5QXYPFjyQIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF5B3411E9; Tue, 29 Dec 2020 15:48:29 -0300 (-03)
Date:   Tue, 29 Dec 2020 15:48:29 -0300
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
Message-ID: <20201229184829.GK521329@kernel.org>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <20201228201159.GF521329@kernel.org>
 <6CB86649-9A1B-4585-8E1F-611F25935041@fb.com>
 <20201229151504.GI521329@kernel.org>
 <3E293E73-ECB7-48E0-8A6E-337988218299@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E293E73-ECB7-48E0-8A6E-337988218299@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 29, 2020 at 06:42:18PM +0000, Song Liu escreveu:
> 
> 
> > On Dec 29, 2020, at 7:15 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Mon, Dec 28, 2020 at 11:43:25PM +0000, Song Liu escreveu:
> >> 
> >> 
> >>> On Dec 28, 2020, at 12:11 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>> 
> >>> Em Mon, Dec 28, 2020 at 09:40:53AM -0800, Song Liu escreveu:
> >>>> Introduce perf-stat -b option, which counts events for BPF programs, like:
> >>>> 
> >>>> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
> >>>>    1.487903822            115,200      ref-cycles
> >>>>    1.487903822             86,012      cycles
> >>>>    2.489147029             80,560      ref-cycles
> >>>>    2.489147029             73,784      cycles
> >>>>    3.490341825             60,720      ref-cycles
> >>>>    3.490341825             37,797      cycles
> >>>>    4.491540887             37,120      ref-cycles
> >>>>    4.491540887             31,963      cycles
> >>>> 
> >>>> The example above counts cycles and ref-cycles of BPF program of id 254.
> >>>> This is similar to bpftool-prog-profile command, but more flexible.
> >>>> 
> >>>> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> >>>> programs (monitor-progs) to the target BPF program (target-prog). The
> >>>> monitor-progs read perf_event before and after the target-prog, and
> >>>> aggregate the difference in a BPF map. Then the user space reads data
> >>>> from these maps.
> >>>> 
> >>>> A new struct bpf_counter is introduced to provide common interface that
> >>>> uses BPF programs/maps to count perf events.
> >>> 
> >>> Segfaulting here:
> >>> 
> >>> [root@five ~]# bpftool prog  | grep tracepoint
> >>> 110: tracepoint  name syscall_unaugme  tag 57cd311f2e27366b  gpl
> >>> 111: tracepoint  name sys_enter_conne  tag 3555418ac9476139  gpl
> >>> 112: tracepoint  name sys_enter_sendt  tag bc7fcadbaf7b8145  gpl
> >>> 113: tracepoint  name sys_enter_open  tag 0e59c3ac2bea5280  gpl
> >>> 114: tracepoint  name sys_enter_opena  tag 0baf443610f59837  gpl
> >>> 115: tracepoint  name sys_enter_renam  tag 24664e4aca62d7fa  gpl
> >>> 116: tracepoint  name sys_enter_renam  tag 20093e51a8634ebb  gpl
> >>> 117: tracepoint  name sys_enter  tag 0bc3fc9d11754ba1  gpl
> >>> 118: tracepoint  name sys_exit  tag 29c7ae234d79bd5c  gpl
> >>> [root@five ~]#
> >>> [root@five ~]# gdb perf
> >>> GNU gdb (GDB) Fedora 10.1-2.fc33
> >>> Reading symbols from perf...
> >>> (gdb) run stat -e instructions,cycles -b 113 -I 1000
> >>> Starting program: /root/bin/perf stat -e instructions,cycles -b 113 -I 1000
> >>> [Thread debugging using libthread_db enabled]
> >>> Using host libthread_db library "/lib64/libthread_db.so.1".
> >>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> >>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> >>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> >>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> >>> 
> >>> Program received signal SIGSEGV, Segmentation fault.
> >>> 0x000000000058d55b in bpf_program_profiler__read (evsel=0xc612c0) at util/bpf_counter.c:217
> >>> 217			reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> >>> (gdb) bt
> >>> #0  0x000000000058d55b in bpf_program_profiler__read (evsel=0xc612c0) at util/bpf_counter.c:217
> >>> #1  0x0000000000000000 in ?? ()
> >>> (gdb)
> >>> 
> >>> [acme@five perf]$ clang -v |& head -2
> >>> clang version 11.0.0 (Fedora 11.0.0-2.fc33)
> >>> Target: x86_64-unknown-linux-gnu
> >>> [acme@five perf]$
> >>> 
> >>> Do you need any extra info?
> >> 
> >> Hmm... I am not able to reproduce this. I am trying to setup an environment similar
> >> to fc33 (clang 11, etc.). Does this segfault every time, and on all programs? 
> > 
> > I'll try it with a BPF proggie attached to a kprobes, but here is
> > something else I noticed:
> > 
> > [root@five perf]# export PYTHONPATH=/tmp/build/perf/python
> > [root@five perf]# tools/perf/python/twatch.py
> > Traceback (most recent call last):
> >  File "/home/acme/git/perf/tools/perf/python/twatch.py", line 9, in <module>
> >    import perf
> > ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: bpf_counter__destroy
> > [root@five perf]# perf test python
> > 19: 'import perf' in python                                         : FAILED!
> > [root@five perf]# perf test -v python
> > 19: 'import perf' in python                                         :
> > --- start ---
> > test child forked, pid 3198864
> > python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
> > Traceback (most recent call last):
> >  File "<stdin>", line 1, in <module>
> > ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: bpf_counter__destroy
> > test child finished with -1
> > ---- end ----
> > 'import perf' in python: FAILED!
> > [root@five perf]#
> > 
> > This should be trivial, I hope, just add the new object file to
> > tools/perf/util/python-ext-sources, then do a 'perf test python', if it
> > fails, use 'perf test -v python' to see what is preventing the python
> > binding from loading.
> 
> I fixed the undefined bpf_counter__destroy. But this one looks trickier:
> 
> 19: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 2714986
> python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/bin/python2' "
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: XXXXX /tools/perf/python/perf.so: undefined symbol: bpf_map_update_elem
> 
> Given I already have:

I'll check this one to get a patch that at least moves the needle here,
i.e. probably we can leave supporting bpf counters in the python binding
for a later step.

- Arnaldo
 
> diff --git i/tools/perf/util/python-ext-sources w/tools/perf/util/python-ext-sources
> index a9d9c142eb7c3..2cac55273eca2 100644
> --- i/tools/perf/util/python-ext-sources
> +++ w/tools/perf/util/python-ext-sources
> @@ -35,3 +35,6 @@ util/symbol_fprintf.c
>  util/units.c
>  util/affinity.c
>  util/rwsem.c
> +util/bpf_counter.c
> +../lib/bpf/bpf.c
> +../lib/bpf/libbpf.c
> 
> 
> How should I fix this? 
> 
> Thanks,
> Song
> 
> PS: I still cannot reproduce that segfault...
> 
> > 
> 

-- 

- Arnaldo
