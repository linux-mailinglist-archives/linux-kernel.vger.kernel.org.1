Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBAD2C5B19
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404194AbgKZRwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404000AbgKZRwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:52:34 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0437A20665;
        Thu, 26 Nov 2020 17:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606413153;
        bh=jO8EQT3DTMJuuTlJ6zyo5W4RmBrH54UKTVGL0Cn1JZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xq/2u4YbDGLe9XTYNPwEsX6jMVow5G1WqBSzo/RoJ9BafRnqWVlDoPmZAHvpgy0VF
         +Jm2c+OJM2OtiTnlMaEcoStb4t/BVUBsGgAhva2iw1HPeiN7xtokyS9l4f/4XDcJn4
         Mn7LZ4AajWyEjLBNTgsbglUT98rrBgWKN+kQqz+Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D13BA40E29; Thu, 26 Nov 2020 14:52:30 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:52:30 -0300
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
Subject: Re: [PATCH 18/25] perf tools: Use machine__for_each_dso in
 perf_session__cache_build_ids
Message-ID: <20201126175230.GF70905@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-19-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-19-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:19PM +0100, Jiri Olsa escreveu:
> Using machine__for_each_dso in perf_session__cache_build_ids,
> so we can reuse perf_session__cache_build_ids with different
> callback in following changes.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/build-id.c | 41 +++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 1fd58703c2d4..948a7f48d668 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -859,12 +859,16 @@ int build_id_cache__remove_s(const char *sbuild_id)
>  	return err;
>  }
>  
> -static int dso__cache_build_id(struct dso *dso, struct machine *machine)
> +static int dso__cache_build_id(struct dso *dso, struct machine *machine,
> +			       void *priv __maybe_unused)
>  {
>  	bool is_kallsyms = dso__is_kallsyms(dso);
>  	bool is_vdso = dso__is_vdso(dso);
>  	const char *name = dso->long_name;
>  
> +	if (!dso->has_build_id)
> +		return 0;
> +
>  	if (dso__is_kcore(dso)) {
>  		is_kallsyms = true;
>  		name = machine->mmap_name;
> @@ -873,43 +877,30 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine)
>  				     is_kallsyms, is_vdso);
>  }
>  
> -static int __dsos__cache_build_ids(struct list_head *head,
> -				   struct machine *machine)
> +static int
> +machines__for_each_dso(struct machines *machines, machine__dso_t fn, void *priv)
>  {
> -	struct dso *pos;
> -	int err = 0;
> -
> -	dsos__for_each_with_build_id(pos, head)
> -		if (dso__cache_build_id(pos, machine))
> -			err = -1;
> +	int ret = machine__for_each_dso(&machines->host, fn, priv);
> +	struct rb_node *nd;
>  
> -	return err;
> -}
> +	for (nd = rb_first_cached(&machines->guests); nd;
> +	     nd = rb_next(nd)) {
> +		struct machine *pos = rb_entry(nd, struct machine, rb_node);
>  
> -static int machine__cache_build_ids(struct machine *machine)
> -{
> -	return __dsos__cache_build_ids(&machine->dsos.head, machine);
> +		ret |= machine__for_each_dso(pos, fn, priv);
> +	}
> +	return ret ? -1 : 0;
>  }
>  
>  int perf_session__cache_build_ids(struct perf_session *session)
>  {
> -	struct rb_node *nd;
> -	int ret;
> -
>  	if (no_buildid_cache)
>  		return 0;
>  
>  	if (mkdir(buildid_dir, 0755) != 0 && errno != EEXIST)
>  		return -1;
>  
> -	ret = machine__cache_build_ids(&session->machines.host);
> -
> -	for (nd = rb_first_cached(&session->machines.guests); nd;
> -	     nd = rb_next(nd)) {
> -		struct machine *pos = rb_entry(nd, struct machine, rb_node);
> -		ret |= machine__cache_build_ids(pos);
> -	}
> -	return ret ? -1 : 0;
> +	return machines__for_each_dso(&session->machines, dso__cache_build_id, NULL) ?  -1 : 0;
>  }
>  
>  static bool machine__read_build_ids(struct machine *machine, bool with_hits)
> -- 
> 2.26.2
> 

-- 

- Arnaldo
