Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4032BA678
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgKTJpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgKTJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:45:20 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF0DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:45:20 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r18so6841662pgu.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fJ48XHtIADxkSoM5ebTMm/chdjhfMyfCuvv/Kb9LWkY=;
        b=XoIlkjPozK0PTmSv4mxalP/sxPmPJW+0bOlpFvFPd6JVuAEPiXz6mjOIwC/KYfIuxf
         6G4p4k1Dm8UdBL3VIMLh3ZjFZ/Em/8E5FAwSF3ZwuuaGjDTKzrQlUfe42RpgHtjVWa2D
         swOl0b2m30m3sMOWh8+zJ7R9Amz7CMK3WTvNnN06npuZIlVW/8zXrIPQ87tz++C+rAla
         1x4eR6rh6HZ3QpPwdlnQXjTSiuYPR+emWRfJQ3bKaQAu/LaM1ALIBVBy53Bozh9LqYmw
         JfIETyVtr6nwF/jQdc9cBzeWBWKqdmEbyhu9s452XyI4O34O15G+2RUIB9nvCU7Mgv9W
         1RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fJ48XHtIADxkSoM5ebTMm/chdjhfMyfCuvv/Kb9LWkY=;
        b=TiVpr0CUTDZKN3kWXqrJAruPhLCAoTdlsDvKpGYwx88rw2JrL6Y6XQtpxy4TxCfD4b
         u2RPIAsPiU3TX/5RxTa3LQu4CapKLHAW3bcg93Yp4atcGC7/0usMRValZm6yHOrcfAkA
         nO/bvYLQzfmKwAPr2dj8ByrnprcSXjSVr/BzR/cmGG5KKNQOvGUGPcU+evFSG9b9S33t
         r5bHy8L1h3+7nEtgyVOmi+rA/NojP7blmm7JwEZkDw9SA/ES8/VyLC0LL/ZYKHTYTlkp
         ruHnaD+jCR1OVNxsD2ROTrNpZ5i7peHF6bEByvuH5Mhz6ogiV+ksg9q6375TYcFN+3ia
         gimQ==
X-Gm-Message-State: AOAM533XP+9Dzq8DkmyTgcurDUzQOgy2aZwMgQ+SXuaEktt2sudbOJmA
        ObQq88UuxL/8egcwl8Aa7rw=
X-Google-Smtp-Source: ABdhPJwDlEC+PgEdjs7qVmVW7Ir8ovvmBRzdA6WD01O1eHONGTyCVQWT/3992ufvUA84BpemuqVBsw==
X-Received: by 2002:a17:90a:d307:: with SMTP id p7mr9286828pju.196.1605865519656;
        Fri, 20 Nov 2020 01:45:19 -0800 (PST)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a25sm2972672pfg.138.2020.11.20.01.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:45:18 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 20 Nov 2020 18:45:12 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH v3 00/12] Introduce threaded trace streaming for basic
 perf record operation
Message-ID: <20201120094512.GA94830@google.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for working on this!

On Mon, Nov 16, 2020 at 03:12:47PM +0300, Alexey Budankov wrote:
> 
> Changes in v3:
> - avoided skipped redundant patch 3/15
> - applied "data file" and "data directory" terms allover the patch set
> - captured Acked-by: tags by Namhyung Kim
> - avoided braces where don't needed
> - employed thread local variable for serial trace streaming 
> - added specs for --thread option - core, socket, numa and user defined
> - added parallel loading of data directory files similar to the prototype [1]

Can you please consider splitting tracing records (FORK/MMAP/...) into
a separate file?  I think this change would put too much burden to the
perf report side.  I'm saying this repeatedly because I'm afraid that
it'd be harder to change later once we accept this approach/format..

Thanks,
Namhyung


> 
> v2: https://lore.kernel.org/lkml/1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com/
> 
> Changes in v2:
> - explicitly added credit tags to patches 6/15 and 15/15,
>   additionally to cites [1], [2]
> - updated description of 3/15 to explicitly mention the reason
>   to open data directories in read access mode (e.g. for perf report)
> - implemented fix for compilation error of 2/15
> - explicitly elaborated on found issues to be resolved for
>   threaded AUX trace capture
> 
> v1: https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/
> 
> Patch set provides parallel threaded trace streaming mode for basic
> perf record operation. Provided mode mitigates profiling data losses
> and resolves scalability issues of serial and asynchronous (--aio)
> trace streaming modes on multicore server systems. The design and
> implementation are based on the prototype [1], [2].
> 
> Parallel threaded mode executes trace streaming threads that read kernel
> data buffers and write captured data into several data files located at
> data directory. Layout of trace streaming threads and their mapping to data
> buffers to read can be configured using a value of --thread command line
> option. Specification value provides masks separated by colon so the masks
> define cpus to be monitored by one thread and thread affinity mask is
> separated by slash. <cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
> specifies parallel threads layout that consists of two threads with
> corresponding assigned cpus to be monitored. Specification value can be
> a string e.g. "cpu", "core" or "socket" meaning creation of data streaming
> thread for monitoring every cpu, whole core or socket. The option provided
> with no or empty value defaults to "cpu" layout creating data streaming
> thread for every cpu being monitored. Specification masks are filtered
> by the mask provided via -C option.
> 
> Parallel streaming mode is compatible with Zstd compression/decompression
> (--compression-level) and external control commands (--control). The mode
> is not enabled for pipe mode. The mode is not enabled for AUX area tracing,
> related and derived modes like --snapshot or --aux-sample. --switch-output-*
> and --timestamp-filename options are not enabled for parallel streaming.
> Initial intent to enable AUX area tracing faced the need to define some
> optimal way to store index data in data directory. --switch-output-* and
> --timestamp-filename use cases are not clear for data directories.
> Asynchronous(--aio) trace streaming and affinity (--affinity) modes are
> mutually exclusive to parallel streaming mode.
> 
> Basic analysis of data directories is provided in perf report mode.
> Raw dump and aggregated reports are available for data directories,
> still with no memory consumption optimizations.
> 
> Tested:
> 
> tools/perf/perf record -o prof.data --threads -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads= -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=cpu -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=core -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=socket -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=numa -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 2,5 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 3,4 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=core -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=numa -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 --compression-level=3 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads -a
> tools/perf/perf record -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30
> tools/perf/perf record --threads -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30
> 
> tools/perf/perf report -i prof.data
> tools/perf/perf report -i prof.data --call-graph=callee
> tools/perf/perf report -i prof.data --stdio --header
> tools/perf/perf report -i prof.data -D --header
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> ---
> Alexey Budankov (12):
>   perf record: introduce thread affinity and mmap masks
>   perf record: introduce thread specific data array
>   perf record: introduce thread local variable
>   perf record: stop threads in the end of trace streaming
>   perf record: start threads in the beginning of trace streaming
>   perf record: introduce data file at mmap buffer object
>   perf record: init data file at mmap buffer object
>   perf record: introduce --threads=<spec> command line option
>   perf record: document parallel data streaming mode
>   perf report: output data file name in raw trace dump
>   perf session: load data directory files for analysis
>   perf session: use reader functions to load perf data file
> 
>  tools/include/linux/bitmap.h             |   11 +
>  tools/lib/api/fd/array.c                 |   17 +
>  tools/lib/api/fd/array.h                 |    1 +
>  tools/lib/bitmap.c                       |   14 +
>  tools/perf/Documentation/perf-record.txt |   18 +
>  tools/perf/builtin-inject.c              |    3 +-
>  tools/perf/builtin-record.c              | 1019 ++++++++++++++++++++--
>  tools/perf/util/evlist.c                 |   16 +
>  tools/perf/util/evlist.h                 |    1 +
>  tools/perf/util/mmap.c                   |    6 +
>  tools/perf/util/mmap.h                   |    6 +
>  tools/perf/util/ordered-events.h         |    1 +
>  tools/perf/util/record.h                 |    2 +
>  tools/perf/util/session.c                |  484 +++++++---
>  tools/perf/util/session.h                |    5 +
>  tools/perf/util/tool.h                   |    3 +-
>  16 files changed, 1398 insertions(+), 209 deletions(-)
> 
> -- 
> 2.24.1
> 
