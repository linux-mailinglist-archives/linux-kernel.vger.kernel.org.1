Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7654A2FD5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391183AbhATQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404170AbhATQbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:31:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDD9322CE3;
        Wed, 20 Jan 2021 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611160235;
        bh=IPK7fzVrM9RB7Pzldl6gGznh/Xa7VmIXwbN7mUm3VAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ial5qMWU20JrKq5gWp2v9owlmIfJkiiBgAD1HLB3lr0rdFzhKx0O3Gh5FY3+mSx3X
         Ca50f4Ult6FvVIyCjBLZAJlbmhPSCdSwNRrHYVKcsY92PvviYw0+0H1s9R7wVcaktm
         I01jVKI2OrIS5+JsoGYYYBB0OgravtMkmJzTAGrAvXDZbUuIpP8bKdPcFd9PQUKxg7
         VsqCf3RIz10jVft3+5KcMwXKKHC4BF60tExCmO86SrUjBxA/Wt0MJEbWMUWMUJSJ3R
         tMiwtdRjGKK4xjnmbvxRa3/PqDI5JBhiJBloiHLoyfKYSnKbi1+lPomSiMO5zXLnUm
         zeinWSbnypl4g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD5FE40513; Wed, 20 Jan 2021 13:30:31 -0300 (-03)
Date:   Wed, 20 Jan 2021 13:30:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Kernel Team <Kernel-team@fb.com>
Subject: FIX Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF
 programs
Message-ID: <20210120163031.GU12699@kernel.org>
References: <20210118193817.GG12699@kernel.org>
 <379919CC-594F-40C5-A10E-97E048F73AE2@fb.com>
 <20210119143143.GJ12699@kernel.org>
 <20210119144249.GK12699@kernel.org>
 <20210119163123.GM12699@kernel.org>
 <417ABE57-E527-4944-BE16-35AB92D071E9@fb.com>
 <20210119223021.GO12699@kernel.org>
 <20210120123727.GR12699@kernel.org>
 <20210120130137.GS12699@kernel.org>
 <20210120135013.GT12699@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120135013.GT12699@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 20, 2021 at 10:50:13AM -0300, Arnaldo Carvalho de Melo escreveu:
> So sizeof(struct bpf_perf_event_value) == 24 and it is a per-cpu array, the
> machine has 24 cpus, why is the kernel thinking it has more and end up zeroing
> entries after the 24 cores? Some percpu map subtlety (or obvious thing ;-\) I'm
> missing?
> 
> Checking lookups into per cpu maps in sample code now...
 
(gdb) run stat -b 244 -I 1000 -e cycles
Starting program: /root/bin/perf stat -b 244 -I 1000 -e cycles
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame

Breakpoint 1, bpf_program_profiler__read (evsel=0xce02c0) at util/bpf_counter.c:217
217		if (list_empty(&evsel->bpf_counter_list))
(gdb) p num_
num_cpu              num_groups           num_leaps            num_print_iv         num_stmts            num_transitions      num_warnings_issued
num_cpu_bpf          num_ifs              num_print_interval   num_srcfiles         num_to_str           num_types
(gdb) p num_cpu
$1 = 24
(gdb) p num_cpu_bpf
$2 = 32
(gdb)

Humm, why?

But then libbpf and the sample/bpf/ code use it this way:


diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 8c977f038f497fc1..7dd3d57aba4f620c 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -207,7 +207,8 @@ static int bpf_program_profiler__enable(struct evsel *evsel)
 static int bpf_program_profiler__read(struct evsel *evsel)
 {
 	int num_cpu = evsel__nr_cpus(evsel);
-	struct bpf_perf_event_value values[num_cpu];
+	int num_cpu_bpf = libbpf_num_possible_cpus();
+	struct bpf_perf_event_value values[num_cpu > num_cpu_bpf ? num_cpu : num_cpu_bpf];
 	struct bpf_counter *counter;
 	int reading_map_fd;
 	__u32 key = 0;

-------------------------------------------------------------

[root@five ~]# cat /sys/devices/system/cpu/possible
0-31
[root@five ~]#

I bet that in your test systems evsel__nr_cpus(evsel) matches
/sys/devices/system/cpu/possible and thus you don't see the problem.

evsel__nr_cpus(evsel) uses what is in:

[acme@five perf]$ cat /sys/devices/system/cpu/online
0-23
[acme@five perf]$

So that is the reason for the problem and the fix is to use
libbpf_num_possible_cpus(), I'll bolt that into the patch that
introduced that code.

- Arnaldo
