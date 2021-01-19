Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6D22FC3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbhASWnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392045AbhASObK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:31:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C63D5206E5;
        Tue, 19 Jan 2021 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611066628;
        bh=MrFkVYJPvkHcslkriBHdzggCygel2lpmLMTZKwFK1zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pe/oXl7V87ZzrmE8Uro/PfCcchPHBJkSDcwV6e9P1CU/s9TrjTzcdUU+shix8NBYp
         UumzwHnYY1JbayqJEr4o6IOc6s5MA8fVnnyFgvDha45DJXvmSJY9/8IASa2qVUjBfh
         ioa2fiMb+Abx9qa/0fdt+JtOzIU/fICkiIc1Ey14lchf2eR8se5gGD4cYJko1KXAIS
         C+x70FPohRFE6H9ARhrx08b7LAOmoOjcUc6N5uobHgImAV8jFMWxa5PhBSpfixgqCj
         24X0q6MmDjN0Nyd1Q8UR4pAfVbaAMx8BNOFnjCGvxWQnsFLiVlt8hsDoi/xcLT5Nyc
         sRCVLrHJKbfew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D080540CE2; Tue, 19 Jan 2021 11:30:24 -0300 (-03)
Date:   Tue, 19 Jan 2021 11:30:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCHv4 0/4] perf tools: Allow to enable/disable events via
 control pipe
Message-ID: <20210119143024.GI12699@kernel.org>
References: <20201226232038.390883-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226232038.390883-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 27, 2020 at 12:20:34AM +0100, Jiri Olsa escreveu:
> hi,
> adding support to enable/disable specific events via control
> file via following commands:
> 
>     # echo 'enable sched:sched_process_fork' > control
>     # echo 'disabled sched:sched_process_fork' > control
> 
> v4 changes:
>   - some of the patches got merged
>   - rebased to latest perf/core
>   - fixed changelogs
>   - added 'ping' command
> 
> v3 changes:
>   - use ' ' instead of '-' in syntax and add command argument
>     processing [Arnaldo]
>   - add options to evlist [Arnaldo]
>   - add man page changes
> 
> v2 changes:
>   - added acks
>   - change list to evlist [Arnaldo]
>   - add evlist-verbose command [Arnaldo]
>   - add '' to enale-/disable- error message
> 
> The code is available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/control
> 
> thanks,
> jirka

Thanks, applied.

- Arnaldo

 
> 
> ---
> Jiri Olsa (4):
>       perf tools: Allow to enable/disable events via control file
>       perf tools: Add evlist control command
>       perf tools: Add stop control command
>       perf tools: Add ping control command
> 
>  tools/perf/Documentation/perf-record.txt |  15 ++++++++++++---
>  tools/perf/builtin-record.c              |  13 +++++++------
>  tools/perf/builtin-stat.c                |   5 +++--
>  tools/perf/util/evlist.c                 | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  tools/perf/util/evlist.h                 |   6 ++++++
>  tools/perf/util/evsel_fprintf.c          |   2 ++
>  tools/perf/util/python-ext-sources       |   1 +
>  tools/perf/util/setup.py                 |   2 +-
>  8 files changed, 141 insertions(+), 15 deletions(-)
> 

-- 

- Arnaldo
