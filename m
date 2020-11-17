Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8FB2B5F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgKQMuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQMuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:50:44 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D202222A;
        Tue, 17 Nov 2020 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605617443;
        bh=nufKKNFjFQgQkEMjmPmhWQ5WpTuzpxY2cQYNBOxXtvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N69vzxl0MfEp6K0J8nWD/oHBlrXt2aKh63pblyDpKkFy4aM2J6J3oOjS/ifj3npx7
         tzUyJXJRI43WVfUVFrNNpVHKKyH+471CyxE3OuIpaSb8RPF/Dvd4kwhfLrLfcdRoI9
         1rO9b7QpdIfk0tsDRm2jojwPk5vt3fWCSY9CwG/8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0744D40E29; Tue, 17 Nov 2020 09:50:41 -0300 (-03)
Date:   Tue, 17 Nov 2020 09:50:40 -0300
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
Subject: Re: [PATCH 23/24] perf buildid-list: Add support for mmap2's buildid
 events
Message-ID: <20201117125040.GT614220@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-24-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117110053.1303113-24-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 17, 2020 at 12:00:52PM +0100, Jiri Olsa escreveu:
> Add buildid-list support for mmap2's build id data, so we can
> display build ids for dso objects for data without the build
> id cache update.

>   $ perf buildid-list
>   1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
>   d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so
> 
> By default only dso objects with hits are shown.

Would be interesting to be able to show all the build ids that are
there. a 'perf buildid-list --all' or make this under --force?

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-buildid-list.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
> index e3ef75583514..87f5b1a4a7fa 100644
> --- a/tools/perf/builtin-buildid-list.c
> +++ b/tools/perf/builtin-buildid-list.c
> @@ -77,6 +77,9 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
>  	    perf_header__has_feat(&session->header, HEADER_AUXTRACE))
>  		with_hits = false;
>  
> +	if (!perf_header__has_feat(&session->header, HEADER_BUILD_ID))
> +		with_hits = true;
> +
>  	/*
>  	 * in pipe-mode, the only way to get the buildids is to parse
>  	 * the record stream. Buildids are stored as RECORD_HEADER_BUILD_ID
> -- 
> 2.26.2
> 

-- 

- Arnaldo
