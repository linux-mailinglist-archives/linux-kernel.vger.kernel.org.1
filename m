Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2421B539
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 14:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGJMj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 08:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgGJMj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:39:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.179.81.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03FE720772;
        Fri, 10 Jul 2020 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594384766;
        bh=Hsh5/ftN0S1Ay+gR2es2DoV3itqDiZ00kyYc3N/JFGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FS8MqZhvUrYyAo5+0HfJj+LdZwqU51qPFZsfqgCitm/zEYKiEVszKHLUrGVZZDZ4b
         UQ+W3dX9g73ISPnnpph46GksBl7JKtLiow3cOyR/TbKT0ZPhwvy+fnxnQ4wUBqFRiJ
         QJUT/mK0p8UOYco36scS96wr7btgCKk3cKY7ECiA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C60B8405FF; Fri, 10 Jul 2020 09:39:22 -0300 (-03)
Date:   Fri, 10 Jul 2020 09:39:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf kmem: pass additional arguments to record
Message-ID: <20200710123922.GE22500@kernel.org>
References: <20200708183919.4141023-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200708183919.4141023-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 08, 2020 at 11:39:19AM -0700, Ian Rogers escreveu:
> perf kmem has an input file option but current an output file option
> fails:
> ```
> $ sudo perf kmem record -o /tmp/p.data sleep 1  
>  Error: unknown switch `o'
> 
> Usage: perf kmem [<options>] {record|stat}
> 
>    -f, --force           don't complain, do it
>    -i, --input <file>    input file name
>    -l, --line <num>      show n lines
>    -s, --sort <key[,key2...]>
>                          sort by keys: ptr, callsite, bytes, hit, pingpong, frag, page, order, mig>
>    -v, --verbose         be more verbose (show symbol address, etc)
>        --alloc           show per-allocation statistics
>        --caller          show per-callsite statistics
>        --live            Show live page stat
>        --page            Analyze page allocator
>        --raw-ip          show raw ip instead of symbol
>        --slab            Analyze slab allocator
>        --time <str>      Time span of interest (start,stop)
> ```
> perf sched is similar in implementation and avoids the problem by
> passing additional arguments to perf record. This change makes perf kmem
> parse command line options consistently with perf sched, although
> neither actually list that -o is a supported option.

Thanks, tested and applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-kmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 38a5ab683ebc..a50dae2c4ae9 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -1933,7 +1933,8 @@ int cmd_kmem(int argc, const char **argv)
>  		return ret;
>  
>  	argc = parse_options_subcommand(argc, argv, kmem_options,
> -					kmem_subcommands, kmem_usage, 0);
> +					kmem_subcommands, kmem_usage,
> +					PARSE_OPT_STOP_AT_NON_OPTION);
>  
>  	if (!argc)
>  		usage_with_options(kmem_usage, kmem_options);
> -- 
> 2.27.0.383.g050319c2ae-goog
> 

-- 

- Arnaldo
