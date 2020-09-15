Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B526A2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIOKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgIOKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600164343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1iUpStHY3x02TGj1Ffq3/OwunO57+bHgrb4tvzzSsB8=;
        b=ZSjoWw4knndKJp1iG6X4vHILAnySwsvVl7/gWYRUbTeuelqFBUlFnYfaB1sg5tmZ4tOw+6
        DRc1RjFwXxlTupnDsZ7PhO/iwaX5uUVy87kplj99tFxmJRiXk6El9BjJYKmEH7gxPvMAPb
        rwWI7dtVdfk1dMHGAmgxGg3STr/0LO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-sH5Mui7pOTee0cijc9oYEw-1; Tue, 15 Sep 2020 06:05:40 -0400
X-MC-Unique: sH5Mui7pOTee0cijc9oYEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7248A1017DC1;
        Tue, 15 Sep 2020 10:05:37 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id CA75960C0F;
        Tue, 15 Sep 2020 10:05:34 +0000 (UTC)
Date:   Tue, 15 Sep 2020 12:05:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 3/3] perf inject: Do not load map/dso when injecting
 build-id
Message-ID: <20200915100533.GC2171499@krava>
References: <20200914141859.332459-1-namhyung@kernel.org>
 <20200914141859.332459-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914141859.332459-3-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 11:18:59PM +0900, Namhyung Kim wrote:
> No need to load symbols in a DSO when injecting build-id.  I guess the
> reason was to check the DSO is a special file like anon files.  Use
> some helper functions in map.c to check them before reading build-id.
> Also pass sample event's cpumode to a new build-id event.
> 
> Original-patch-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-inject.c | 30 ++++++++++--------------------
>  tools/perf/util/map.c       | 17 +----------------
>  tools/perf/util/map.h       | 14 ++++++++++++++
>  3 files changed, 25 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a2804d906d2a..6d4e6833efed 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -436,21 +436,22 @@ static int dso__read_build_id(struct dso *dso)
>  }
>  
>  static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
> -				struct machine *machine)
> +				struct machine *machine, u8 cpumode)
>  {
> -	u16 misc = PERF_RECORD_MISC_USER;
>  	int err;
>  
> +	if (is_anon_memory(dso->long_name))
> +		return 0;
> +	if (is_no_dso_memory(dso->long_name))
> +		return 0;

should we check for vdso as well? I don't think it has build id

> +
>  	if (dso__read_build_id(dso) < 0) {
>  		pr_debug("no build_id found for %s\n", dso->long_name);
>  		return -1;
>  	}
>  
> -	if (dso->kernel)
> -		misc = PERF_RECORD_MISC_KERNEL;
> -
> -	err = perf_event__synthesize_build_id(tool, dso, misc, perf_event__repipe,
> -					      machine);
> +	err = perf_event__synthesize_build_id(tool, dso, cpumode,
> +					      perf_event__repipe, machine);
>  	if (err) {
>  		pr_err("Can't synthesize build_id event for %s\n", dso->long_name);
>  		return -1;
> @@ -478,19 +479,8 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
>  	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
>  		if (!al.map->dso->hit) {
>  			al.map->dso->hit = 1;
> -			if (map__load(al.map) >= 0) {

nice, that might do some nice speedup, did you see any?

jirka

> -				dso__inject_build_id(al.map->dso, tool, machine);
> -				/*
> -				 * If this fails, too bad, let the other side
> -				 * account this as unresolved.
> -				 */
> -			} else {
> -#ifdef HAVE_LIBELF_SUPPORT
> -				pr_warning("no symbols found in %s, maybe "
> -					   "install a debug package?\n",
> -					   al.map->dso->long_name);
> -#endif
> -			}
> +			dso__inject_build_id(al.map->dso, tool, machine,
> +					     sample->cpumode);
>  		}

SNIP

