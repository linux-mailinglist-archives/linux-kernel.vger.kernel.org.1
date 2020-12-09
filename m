Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECFE2D476B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbgLIRFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731105AbgLIRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607533435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GtS6jv+E0/Fbn9rZmFe0t9VTYKoj11i3P1C0VmLoxvA=;
        b=YcPyMl1DDKN3eD33xOTaszKxiwHwTQNqxDXEV/UCr9/xCcg9iyieUWOm6lhwil7YSDa0N3
        mDZOrw0RF2xYQ6ugC7RIW8x67dMrWU28oNZv5KkN5lyA+blNTflqNCvmcwS3Grvh8ixJIq
        fQcnZTCYfaXBfALn/nbapl93RNdYGRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-nDqXvn5uNO26K0o80jD2pQ-1; Wed, 09 Dec 2020 12:03:53 -0500
X-MC-Unique: nDqXvn5uNO26K0o80jD2pQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E15C800D55;
        Wed,  9 Dec 2020 17:03:51 +0000 (UTC)
Received: from krava (unknown [10.40.195.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2A0E119C78;
        Wed,  9 Dec 2020 17:03:48 +0000 (UTC)
Date:   Wed, 9 Dec 2020 18:03:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v3 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201209170348.GD69683@krava>
References: <20201208181646.3044417-1-songliubraving@fb.com>
 <20201208181646.3044417-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208181646.3044417-3-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:16:46AM -0800, Song Liu wrote:
> Introduce perf-stat -b option, which counts events for BPF programs, like:
> 
> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>      1.487903822            115,200      ref-cycles
>      1.487903822             86,012      cycles
>      2.489147029             80,560      ref-cycles
>      2.489147029             73,784      cycles
>      3.490341825             60,720      ref-cycles
>      3.490341825             37,797      cycles
>      4.491540887             37,120      ref-cycles
>      4.491540887             31,963      cycles
> 
> The example above counts cycles and ref-cycles of BPF program of id 254.
> This is similar to bpftool-prog-profile command, but more flexible.
> 
> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> programs (monitor-progs) to the target BPF program (target-prog). The
> monitor-progs read perf_event before and after the target-prog, and
> aggregate the difference in a BPF map. Then the user space reads data
> from these maps.
> 
> A new struct bpf_counter is introduced to provide common interface that
> uses BPF programs/maps to count perf events.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>

I'm getting this at the end of the compilation:

  LINK     perf
rm /home/jolsa/linux-perf/tools/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o

I guess we can keep it or make it silent somehow

> ---
>  tools/perf/Makefile.perf                      |   2 +-
>  tools/perf/builtin-stat.c                     |  77 ++++-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf_counter.c                 | 297 ++++++++++++++++++
>  tools/perf/util/bpf_counter.h                 |  73 +++++
>  .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
>  tools/perf/util/evsel.c                       |  11 +
>  tools/perf/util/evsel.h                       |   6 +
>  tools/perf/util/stat-display.c                |   4 +-
>  tools/perf/util/target.c                      |  34 +-
>  tools/perf/util/target.h                      |  10 +
>  11 files changed, 591 insertions(+), 17 deletions(-)
>  create mode 100644 tools/perf/util/bpf_counter.c
>  create mode 100644 tools/perf/util/bpf_counter.h
>  create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c

we need man page update, would be great with some example

SNIP

> -	int status = -EINVAL, run_idx;
> +	int status = -EINVAL, run_idx, err;
>  	const char *mode;
>  	FILE *output = stderr;
>  	unsigned int interval, timeout;
>  	const char * const stat_subcommands[] = { "record", "report" };
> +	char errbuf[BUFSIZ];
>  
>  	setlocale(LC_ALL, "");
>  
> @@ -2169,6 +2213,12 @@ int cmd_stat(int argc, const char **argv)
>  	} else if (big_num_opt == 0) /* User passed --no-big-num */
>  		stat_config.big_num = false;
>  
> +	err = target__validate(&target);
> +	if (err) {
> +		target__strerror(&target, err, errbuf, BUFSIZ);
> +		pr_warning("%s\n", errbuf);
> +	}
> +

is there a reason for this to move before setup_system_wide?

I don't think it's a big deal, but just curious if that's intentional

SNIP

> +
> +int bpf_counter__enable(struct evsel *evsel)
> +{
> +	if (list_empty(&evsel->bpf_counter_list))
> +		return 0;
> +	return evsel->bpf_counter_ops->enable(evsel);
> +}
> +
> +int bpf_counter__read(struct evsel *evsel)
> +{
> +	if (list_empty(&evsel->bpf_counter_list))
> +		return -EAGAIN;
> +	return evsel->bpf_counter_ops->read(evsel);
> +}
> +
> +int bpf_counter__destroy(struct evsel *evsel)
> +{

this could return void

SNIP

> @@ -247,6 +252,7 @@ void evsel__init(struct evsel *evsel,
>  	evsel->bpf_obj	   = NULL;
>  	evsel->bpf_fd	   = -1;
>  	INIT_LIST_HEAD(&evsel->config_terms);
> +	INIT_LIST_HEAD(&evsel->bpf_counter_list);
>  	perf_evsel__object.init(evsel);
>  	evsel->sample_size = __evsel__sample_size(attr->sample_type);
>  	evsel__calc_id_pos(evsel);
> @@ -1365,6 +1371,7 @@ void evsel__exit(struct evsel *evsel)
>  {
>  	assert(list_empty(&evsel->core.node));
>  	assert(evsel->evlist == NULL);
> +	bpf_counter__destroy(evsel);
>  	evsel__free_counts(evsel);
>  	perf_evsel__free_fd(&evsel->core);
>  	perf_evsel__free_id(&evsel->core);
> @@ -1770,6 +1777,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		evsel->core.attr.sample_id_all = 0;
>  
>  	display_attr(&evsel->core.attr);
> +	if (!list_empty(&evsel->bpf_counter_list))
> +		evsel->core.attr.inherit = 0;

I think this should go to evsel__config where we set all attr bits

thanks,
jirka

