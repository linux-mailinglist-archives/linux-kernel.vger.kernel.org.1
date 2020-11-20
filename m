Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CA62BA73E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgKTKUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKTKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:20:34 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DEBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:20:34 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t21so6928160pgl.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HYgppIF2URQuUMhD3TuNcleFn0NykkWUFnmcnWt+IIc=;
        b=dHiaEf7L9b1pKmY0DFX3fFN9P9KM9GqLgmvITyqvXBRk27ZsglOsh81sJN7YBn7116
         AxqcSR9/W1vViJLvCiJ7y990fpcSyDGUmwWuFoCerizNwNQRPp9+zKHfvFZz0FYsASVB
         csXEbJHJnrXahz1+xag50iFLVvqLIrdK+puIxf+NobnpS/EQYAbcQBGqy1OstlRegZvp
         2r8hK9AP9+ZAqTj7VaiKF93t9trks8QsbGsXCIIjRk2Mc4HZCcRZ9yTXSVwEqk4S/XMl
         imwBfCKeIGBeIblqF76ci+aj3b5b9lGY/9j96YoPYT13ZhxcvlxTjRN89RTTgLb+aH1Q
         EAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HYgppIF2URQuUMhD3TuNcleFn0NykkWUFnmcnWt+IIc=;
        b=FDMy08lVgE+9njpQQKqQgrqSRM/8+kcxdV263uNnzcE77P+5v6OFRHjnPjii8IebFz
         rJQw8B1YZdrpMEXHR10g0uaaABYROySA0riYrHAPCl7vrtP2hyTmKqc28ToPak2DfefZ
         8tkzsmKvHmYGZ5qlHHMyqXfcIYzNtNCTs9JSTlQzk+qM4a2ekqw7u9xc0cHusD+yaFNU
         QMVJbInV26gavZWQYFnmt3j/VVXijC5nFtAQZWdzYOcpkqCiG+8PIdnPs1OzWyjzUBTW
         Q1HDqfy5ZJqeI6GK0ZjFNfbdveA+7WfxLhj3ieyPOrTM1CUyPSUD1Bwp1xXRDRhFvJ2d
         O7JA==
X-Gm-Message-State: AOAM531GhztFWFNWYLYItJSWTP/2dH+z3muNnpzvwe6n51to6b8UBwmu
        w5O54SE9Rux+uunFQtu7ItfwigbWcaw=
X-Google-Smtp-Source: ABdhPJw5meucwm1pEmMVqQp8D5zEfpdDKhHlbFaLiRKuXLDQLW6exJmNUtcOz8cKD7uVm+SwhaBiwQ==
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr9213982pjz.136.1605867633660;
        Fri, 20 Nov 2020 02:20:33 -0800 (PST)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id e8sm2716957pfn.175.2020.11.20.02.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:20:32 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 20 Nov 2020 19:20:21 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH v3 03/12] perf record: introduce thread local variable
Message-ID: <20201120102021.GD94830@google.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <96d7752f-2c0c-330d-a11c-0961e0315c3c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96d7752f-2c0c-330d-a11c-0961e0315c3c@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:16:19PM +0300, Alexey Budankov wrote:
> 
> Introduce thread local variable and use it for threaded trace streaming.
> Use thread affinity mask instead or record affinity mask in affinity modes.
> Introduce and use evlist__ctlfd_update() function to propogate external
> control commands to global evlist object.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 137 ++++++++++++++++++++++++------------
>  tools/perf/util/evlist.c    |  16 +++++
>  tools/perf/util/evlist.h    |   1 +
>  3 files changed, 109 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 765a90e38f69..e41e1cd90168 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
[SNIP]
> @@ -2114,20 +2165,26 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  				alarm(rec->switch_output.time);
>  		}
>  
> -		if (hits == rec->samples) {
> +		if (hits == thread->samples) {
>  			if (done || draining)
>  				break;
> -			err = evlist__poll(rec->evlist, -1);
> +			err = fdarray__poll(&thread->pollfd, -1);
>  			/*
>  			 * Propagate error, only if there's any. Ignore positive
>  			 * number of returned events and interrupt error.
>  			 */
>  			if (err > 0 || (err < 0 && errno == EINTR))
>  				err = 0;
> -			waking++;
> +			thread->waking++;
>  
> -			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
> +			if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP,
> +					    record__thread_munmap_filtered, NULL) == 0)
>  				draining = true;
> +
> +			if (thread->ctlfd_pos != -1) {

Isn't it only for the first thread?  I guess all thread should have
non-negative ctlfd_pos so this check seems meaningless, no?

Thanks,
Namhyung


> +				evlist__ctlfd_update(rec->evlist,
> +					&thread->pollfd.entries[thread->ctlfd_pos]);
> +			}
>  		}
>  
>  		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> @@ -2175,18 +2232,20 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		goto out_child;
>  	}
>  
> -	if (!quiet)
> -		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
> -
>  	if (target__none(&rec->opts.target))
>  		record__synthesize_workload(rec, true);
>  
>  out_child:
> +	record__stop_threads(rec, &waking);
> +out_free_threads:
>  	record__free_thread_data(rec);
>  	evlist__finalize_ctlfd(rec->evlist);
>  	record__mmap_read_all(rec, true);
>  	record__aio_mmap_read_sync(rec);
>  
> +	if (!quiet)
> +		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
> +
>  	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
>  		ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
>  		session->header.env.comp_ratio = ratio + 0.5;
> @@ -2995,17 +3054,6 @@ int cmd_record(int argc, const char **argv)
>  
>  	symbol__init(NULL);
>  
> -	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
> -		rec->affinity_mask.nbits = cpu__max_cpu();
> -		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
> -		if (!rec->affinity_mask.bits) {
> -			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
> -			err = -ENOMEM;
> -			goto out_opts;
> -		}
> -		pr_debug2("thread mask[%zd]: empty\n", rec->affinity_mask.nbits);
> -	}
> -
>  	err = record__auxtrace_init(rec);
>  	if (err)
>  		goto out;
> @@ -3134,7 +3182,6 @@ int cmd_record(int argc, const char **argv)
>  
>  	err = __cmd_record(&record, argc, argv);
>  out:
> -	bitmap_free(rec->affinity_mask.bits);
>  	evlist__delete(rec->evlist);
>  	symbol__exit();
>  	auxtrace_record__free(rec->itr);
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 8bdf3d2c907c..758a4896fedd 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1970,6 +1970,22 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  	return err;
>  }
>  
> +int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update)
> +{
> +	int ctlfd_pos = evlist->ctl_fd.pos;
> +	struct pollfd *entries = evlist->core.pollfd.entries;
> +
> +	if (!evlist__ctlfd_initialized(evlist))
> +		return 0;
> +
> +	if (entries[ctlfd_pos].fd != update->fd ||
> +	    entries[ctlfd_pos].events != update->events)
> +		return -1;
> +
> +	entries[ctlfd_pos].revents = update->revents;
> +	return 0;
> +}
> +
>  struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
>  {
>  	struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index e1a450322bc5..9b73d6ccf066 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -380,6 +380,7 @@ void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close);
>  int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
>  int evlist__finalize_ctlfd(struct evlist *evlist);
>  bool evlist__ctlfd_initialized(struct evlist *evlist);
> +int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update);
>  int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
>  int evlist__ctlfd_ack(struct evlist *evlist);
>  
> -- 
> 2.24.1
> 
> 
