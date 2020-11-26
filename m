Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153152C5A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404427AbgKZRaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:30:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404325AbgKZRap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:30:45 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05BD421D7E;
        Thu, 26 Nov 2020 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606411845;
        bh=eGgDmj+9VdpVGdJDh6xNed07pQF31b07D87E8UC5bs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QK/lMVqivbWHGwEFO6gzc6IIQvT+p8puagQ9fr7t9GJHwXGQOF1XLiCQU+lOy5cwY
         1PSNxSvVwktn4m2gzTzPqPbphXW120TXugU+d4754nm3KTHeMb5lPCkrPNQ23Ph8mq
         VvvjiiYpcX0aZ7mBktCPSGonT+xuPZGM9i0fcpvA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E9E3240E29; Thu, 26 Nov 2020 14:30:42 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:30:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 06/25] perf tools: Do not swap mmap2 fields in case it
 contains build id
Message-ID: <20201126173042.GF53384@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-7-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:07PM +0100, Jiri Olsa escreveu:
> If PERF_RECORD_MISC_MMAP_BUILD_ID misc bit is set,
> mmap2 event carries build id, placed in following union:
> 
>   union {
>           struct {
>                   u32       maj;
>                   u32       min;
>                   u64       ino;
>                   u64       ino_generation;
>           };
>           struct {
>                   u8        build_id[20];
>                   u8        build_id_size;
>                   u8        __reserved_1;
>                   u16       __reserved_2;
>           };
>   };

Did you forgot to update just this cset comment?

- Arnaldo
 
> In this case we can't swap above fields.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/session.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5cc722b6fe7c..cc1c11ca94fd 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -592,10 +592,13 @@ static void perf_event__mmap2_swap(union perf_event *event,
>  	event->mmap2.start = bswap_64(event->mmap2.start);
>  	event->mmap2.len   = bswap_64(event->mmap2.len);
>  	event->mmap2.pgoff = bswap_64(event->mmap2.pgoff);
> -	event->mmap2.maj   = bswap_32(event->mmap2.maj);
> -	event->mmap2.min   = bswap_32(event->mmap2.min);
> -	event->mmap2.ino   = bswap_64(event->mmap2.ino);
> -	event->mmap2.ino_generation = bswap_64(event->mmap2.ino_generation);
> +
> +	if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
> +		event->mmap2.maj   = bswap_32(event->mmap2.maj);
> +		event->mmap2.min   = bswap_32(event->mmap2.min);
> +		event->mmap2.ino   = bswap_64(event->mmap2.ino);
> +		event->mmap2.ino_generation = bswap_64(event->mmap2.ino_generation);
> +	}
>  
>  	if (sample_id_all) {
>  		void *data = &event->mmap2.filename;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
