Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58C275A40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIWOgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:36:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:62116 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIWOgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:36:42 -0400
IronPort-SDR: 64u1a8RyjwUKaHGIx8RYJN2QU4hoN4Ay5bq6gd33nX0NS9UphxEUO6Dbf268CIVhnDs1s6Ph4r
 GguDppYwx1Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="158279608"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="158279608"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 07:36:41 -0700
IronPort-SDR: FO+61Hh590GzrUe0zCAwY0ZJk9w6UCPAdtRxizdK5L4cfEylc2hy4ExB0evAN3qT+6yNv2xIKH
 DMwYWRFLwhWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="454935904"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga004.jf.intel.com with ESMTP; 23 Sep 2020 07:36:36 -0700
Subject: Re: [PATCH 7/7] perf inject: Remove stale build-id processing
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
References: <20200923080537.155264-1-namhyung@kernel.org>
 <20200923080537.155264-8-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <91de4a5d-2646-0522-92a6-6c0de69ed007@intel.com>
Date:   Wed, 23 Sep 2020 17:36:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923080537.155264-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 11:05 am, Namhyung Kim wrote:
> I think we don't need to call build_id__mark_dso_hit() in the
> perf_event__repipe_sample() as it's not used by -b option.  In case of
> the -b option is used, it uses perf_event__inject_buildid() instead.
> This can remove unnecessary overhead of finding thread/map for each
> sample event.
> 
> Also I suspect HEADER_BUILD_ID feature bit setting since we already
> generated/injected BUILD_ID event into the output stream.  So this
> header information seems redundant.  I'm not 100% sure about the
> auxtrace usage, but it looks like not related to this directly.
> 
> And we now have --buildid-all so users can get the same behavior if
> they want.

For a perf.data file, don't buildids get written to the HEADER_BUILD_ID
feature section by perf_session__write_header() if the feature flag is set
and if they are hit?

So, unless -b is used, anything you don't hit you lose i.e. a buildid in the
HEADER_BUILD_ID feature section of the input file, will not be written to
the output file.

> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-inject.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 500428aaa576..0191d72be7c4 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -277,8 +277,6 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
>  		return f(tool, event, sample, evsel, machine);
>  	}
>  
> -	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
> -

I guess that chunk would prevent losing a buildid in a perf.data file?

>  	if (inject->itrace_synth_opts.set && sample->aux_sample.size)
>  		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
>  
> @@ -767,16 +765,6 @@ static int __cmd_inject(struct perf_inject *inject)
>  		return ret;
>  
>  	if (!data_out->is_pipe) {
> -		if (inject->build_ids)
> -			perf_header__set_feat(&session->header,
> -					      HEADER_BUILD_ID);

That could be due to confusion with 'perf buildid-list' which will not show
any buildids from synthesized buildid events unless "with hits" is selected,
so then it looks like there are no buildids.

It could be an advantage to have the buildids also in the HEADER_BUILD_ID
feature section, because then then build-list can list them quickly.

> -		/*
> -		 * Keep all buildids when there is unprocessed AUX data because
> -		 * it is not known which ones the AUX trace hits.
> -		 */
> -		if (perf_header__has_feat(&session->header, HEADER_BUILD_ID) &&
> -		    inject->have_auxtrace && !inject->itrace_synth_opts.set)
> -			dsos__hit_all(session);

I expect that is definitely needed.

>  		/*
>  		 * The AUX areas have been removed and replaced with
>  		 * synthesized hardware events, so clear the feature flag and
> 

