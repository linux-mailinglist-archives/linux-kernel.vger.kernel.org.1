Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473A52D98AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407927AbgLNNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731403AbgLNNWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:22:40 -0500
Date:   Mon, 14 Dec 2020 10:22:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607952119;
        bh=B/i6SPmblhJxjLg/M1+qmbgXzT3E80LDBqGFPGf3Q7g=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmrWDkUdEQjnMhM5DM096GJzURDJzrjB3kFQeUpQK1nBtR/OeclHHYNKVnNLcTMlq
         WKi1riIfNwu+M9SE86rZHHiwB7n6PTBTVSr3QzSF78y8Tuqv7ErW1AI7UQ6pWmKOUO
         MrPwFAguUjY+MYkDivotiK0U4M56HVNWIJ3DLiytNZKtLBs+ArM+hlUltpfGxOrhU6
         CaPdXs96lUrr4iu+p/KNCTGg08bp+QzbmBF0lvIdtL0f+goWIpaPtSSPKwJvMhATgi
         G8SKA297JTEUqyNDSUB50QdzWwGGNUlSO/C3kCeg5Jhd6fJSOCu/acVFlo3HAWAkEq
         Tqq/VQ6cuEfyg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf report: Support --header-only for pipe mode
Message-ID: <20201214132211.GC238399@kernel.org>
References: <20201210061302.88213-1-namhyung@kernel.org>
 <20201213230019.GB502638@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213230019.GB502638@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 14, 2020 at 12:00:19AM +0100, Jiri Olsa escreveu:
> On Thu, Dec 10, 2020 at 03:13:01PM +0900, Namhyung Kim wrote:
> > The --header-only checks file header and prints the feature data.  But
> > as pipe mode doesn't have it in the header it prints almost nothing.
> > Change it to process first few records until it founds HEADER_FEATURE.
> > 
> > Before:
> >   $ perf record -o- true | perf report -i- --header-only
> >   # ========
> >   # captured on    : Thu Dec 10 14:34:59 2020
> >   # header version : 1
> >   # data offset    : 0
> >   # data size      : 0
> >   # feat offset    : 0
> >   # ========
> >   #
> > 
> > After:
> >   $ perf record -o- true | perf report -i- --header-only
> >   # ========
> >   # captured on    : Thu Dec 10 14:49:11 2020
> >   # header version : 1
> >   # data offset    : 0
> >   # data size      : 0
> >   # feat offset    : 0
> >   # ========
> >   #
> >   # hostname : balhae
> >   # os release : 5.7.17-1xxx
> >   # perf version : 5.10.rc6.gdb0ea13cc741
> >   # arch : x86_64
> >   # nrcpus online : 8
> >   # nrcpus avail : 8
> >   # cpudesc : Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
> >   # cpuid : GenuineIntel,6,142,12
> >   # total memory : 16158916 kB
> >   # cmdline : perf record -o- true
> >   # event : name = cycles, , id = { 81, 82, 83, 84, 85, 86, 87, 88 }, size = 120, ...
> >   # CPU_TOPOLOGY info available, use -I to display
> >   # NUMA_TOPOLOGY info available, use -I to display
> >   # pmu mappings: intel_pt = 9, intel_bts = 8, software = 1, power = 20, uprobe = 7, ...
> >   # time of first sample : 0.000000
> >   # time of last sample : 0.000000
> >   # sample duration :      0.000 ms
> >   # MEM_TOPOLOGY info available, use -I to display
> >   # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

