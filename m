Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B162427726A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgIXNeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727861AbgIXNeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600954446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0qQd56OzMSLcU3rzRhhInn/z9/iX7fFc+lowTpqV1Ek=;
        b=Q0fn19MDdTJoBWRXWBz+S80D9/fF0tPz1uxGOEAugmdmrzKmKmcIrS9vk852X1aM+9pnDo
        ylZ/cqnIF3aP2KhpWS9Ed5lYOGxaNLaNRA7dMYZ3Atu1rdkqoP+uNfwF35o8G8+hAB8bwf
        uQ82nInyQuSCFnGoYQBkdeHWdPmYUS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-JZeW4TubNsa6BfUSyZMOyw-1; Thu, 24 Sep 2020 09:34:01 -0400
X-MC-Unique: JZeW4TubNsa6BfUSyZMOyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97FDF10A7AF6;
        Thu, 24 Sep 2020 13:33:53 +0000 (UTC)
Received: from krava (ovpn-115-138.ams2.redhat.com [10.36.115.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1B02B27C5A;
        Thu, 24 Sep 2020 13:33:50 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:33:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 7/7] perf inject: Remove stale build-id processing
Message-ID: <20200924133349.GC3150401@krava>
References: <20200923080537.155264-1-namhyung@kernel.org>
 <20200923080537.155264-8-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923080537.155264-8-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:05:37PM +0900, Namhyung Kim wrote:
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

I recalled using simple 'perf inject -i .. -o .. ' to get uncompressed data
from 'perf record -z' and I though this change will force inject not to store
all build ids ... but it's happening even without your change ;-)

	$ ./perf record ls
	...
	[ perf record: Woken up 1 times to write data ]
	[ perf record: Captured and wrote 0.016 MB perf.data (15 samples) ]

	$ ./perf inject -o perf.data.new -i perf.data

	$ ./perf buildid-list

	17f4e448cc746582ea1881528deb549f7fdb3fd5 [kernel.kallsyms]
	b516839521ded07bb1fbd0a0276be9820ee8908e /usr/bin/ls
	1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
	f22785ea7e42e8aa9097a567a3cc8ae214cae4b6 [vdso]
	d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so

	$ ./perf buildid-list -i perf.data.new
	f22785ea7e42e8aa9097a567a3cc8ae214cae4b6 [vdso]

jirka


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
> -		/*
> -		 * Keep all buildids when there is unprocessed AUX data because
> -		 * it is not known which ones the AUX trace hits.
> -		 */
> -		if (perf_header__has_feat(&session->header, HEADER_BUILD_ID) &&
> -		    inject->have_auxtrace && !inject->itrace_synth_opts.set)
> -			dsos__hit_all(session);
>  		/*
>  		 * The AUX areas have been removed and replaced with
>  		 * synthesized hardware events, so clear the feature flag and
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

