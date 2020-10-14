Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4577928E006
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgJNLvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJNLvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:51:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E9C20848;
        Wed, 14 Oct 2020 11:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602676307;
        bh=xJCamGJJK02G9/MMT8dJpWrWdLfTEYD3x1hrQiU8Rgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dti8o76h1n+oNfv/giH+OlDq6RIZBKJp6Tqal+htqiQ+XJ1JJEA8BnTO/Wbd72d8r
         Aayq+mycGwc++0l34jqJXk9X+ePilOPyDjkQA2UpxWiDpih2CarlcO1xpb0fcEhNZ3
         3GsPjc3cDtW7w1YiMxLctJGmuD5V7WAJW/cFmKHs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D16D4047F; Wed, 14 Oct 2020 08:51:44 -0300 (-03)
Date:   Wed, 14 Oct 2020 08:51:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 5/9] perf tools: Pass build_id object to dso__set_build_id
Message-ID: <20201014115144.GD3100363@kernel.org>
References: <20201013192441.1299447-1-jolsa@kernel.org>
 <20201013192441.1299447-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013192441.1299447-6-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 13, 2020 at 09:24:37PM +0200, Jiri Olsa escreveu:
> Passing build_id object to dso__set_build_id, so it's easier
> to initialize dos's build id object.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/dso.c            | 4 ++--
>  tools/perf/util/dso.h            | 2 +-
>  tools/perf/util/header.c         | 4 +++-
>  tools/perf/util/symbol-minimal.c | 2 +-
>  tools/perf/util/symbol.c         | 2 +-
>  5 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 2f7f01ead9a1..4415ce83150b 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1326,9 +1326,9 @@ void dso__put(struct dso *dso)
>  		dso__delete(dso);
>  }
>  
> -void dso__set_build_id(struct dso *dso, void *build_id)
> +void dso__set_build_id(struct dso *dso, struct build_id *bid)
>  {
> -	memcpy(dso->bid.data, build_id, sizeof(dso->bid.data));
> +	dso->bid = *bid;

Can't we use bid->size here?

	dso->bid.size = bid->size;
	memcpy(dso->bid.data, bid->data, bid->size));

?

Not worth it? Probably :-)

- Arnaldo

>  	dso->has_build_id = 1;
>  }
>  
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index eac004210b47..5a5678dbdaa5 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -260,7 +260,7 @@ bool dso__sorted_by_name(const struct dso *dso);
>  void dso__set_sorted_by_name(struct dso *dso);
>  void dso__sort_by_name(struct dso *dso);
>  
> -void dso__set_build_id(struct dso *dso, void *build_id);
> +void dso__set_build_id(struct dso *dso, struct build_id *bid);
>  bool dso__build_id_equal(const struct dso *dso, u8 *build_id);
>  void dso__read_running_kernel_build_id(struct dso *dso,
>  				       struct machine *machine);
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index fe220f01fc94..21243adbb9fd 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2082,8 +2082,10 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>  	dso = machine__findnew_dso(machine, filename);
>  	if (dso != NULL) {
>  		char sbuild_id[SBUILD_ID_SIZE];
> +		struct build_id bid;
>  
> -		dso__set_build_id(dso, &bev->build_id);
> +		build_id__init(&bid, bev->build_id, BUILD_ID_SIZE);
> +		dso__set_build_id(dso, &bid);
>  
>  		if (dso_space != DSO_SPACE__USER) {
>  			struct kmod_path m = { .name = NULL, };
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index dba6b9e5d64e..f9eb0bee7f15 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -349,7 +349,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
>  		dso->is_64_bit = ret;
>  
>  	if (filename__read_build_id(ss->name, &bid) > 0)
> -		dso__set_build_id(dso, bid.data);
> +		dso__set_build_id(dso, &bid);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 369cbad09f0d..976632d0baa0 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1818,7 +1818,7 @@ int dso__load(struct dso *dso, struct map *map)
>  	    is_regular_file(dso->long_name)) {
>  	    __symbol__join_symfs(name, PATH_MAX, dso->long_name);
>  		if (filename__read_build_id(name, &bid) > 0)
> -			dso__set_build_id(dso, bid.data);
> +			dso__set_build_id(dso, &bid);
>  	}
>  
>  	/*
> -- 
> 2.26.2
> 

-- 

- Arnaldo
