Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF992BA72C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgKTKOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgKTKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:14:21 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7ACC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:14:21 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t18so4646145plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C2VeCZ8D8lK98N1AUbap+uVyqm64B6OelNbA4oPS3qI=;
        b=WJWNINrRMPPPg3nUIzYYSYBvEHCrNbkKKB8htDYafxOshrWg4q8zPkSaO3CBAy6s9u
         Z7GpaTdd8wifqUlAKAoBXMijo/4rk+pws5leR0syUYv9Cu807/lSNMwA8/JL6f8tFQLi
         L9M61d9ud1paoyO9YGPTAm7V0GHf03wXLdmj2QLQqH4xSY1luRn3kn3rkBurqDQowjt9
         ros98SVhkAkRNRS3t+flvp19o5ymlszZ68+BXRoA57MhZ4/7S9Z76W0HYs2n1LmRELxT
         q2OqjVq809L8VLWJgKtaC5gyOqoeaJVqCS08a6dPGAsKGX2ZV2IxFmCnkk+PC2QoeSqB
         5QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C2VeCZ8D8lK98N1AUbap+uVyqm64B6OelNbA4oPS3qI=;
        b=S8yW9v6ejcRLcGuvCV5hp68azN3fPWj5opZR/STHoeAby2fLpx5SNIWX8vLpYnN+FU
         o5/1XBZFCdQpetbvFYpwuQl4IzXTds+0qthz558veqApVJxtoGCzZ8hqZk4pY5SdlyAS
         YEcJogkuv7m/B0Sol2hUg6f0/LDMjgpucp3BJxif1u0hKI0PXrtkH8NTDIqCp/WsS+7G
         BgengSqEvn7p0zAWkgwmL9g6qGZ/uawYWhu67eelurxEbv+qfaEkFyzx65KFoyx8wGuG
         qYDPi7NzZaiSVWdPn0NFBAg9wxGkf7idWbJ6GK2ZQ+prByF7GFZDqjwMahYDUrTfPJOz
         PbNA==
X-Gm-Message-State: AOAM5337SLITV4jtl1lddYCjYL8fqra2Yv3kO7mEXI7lL0CImgjLN2Dk
        M+dl7fDzSIxyLmXYCAYLbDo=
X-Google-Smtp-Source: ABdhPJwTgdjfQjvup00+hYgF72UDovjuWJFctbJHhifxn/gKu1GfTdO6T+O8Hx4DUFbA4zxpmd068A==
X-Received: by 2002:a17:902:7c01:b029:d8:ee2a:ce88 with SMTP id x1-20020a1709027c01b02900d8ee2ace88mr13706137pll.22.1605867260696;
        Fri, 20 Nov 2020 02:14:20 -0800 (PST)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id r6sm3259817pjo.0.2020.11.20.02.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:14:19 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 20 Nov 2020 19:14:14 +0900
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
Subject: Re: [PATCH v3 02/12] perf record: introduce thread specific data
 array
Message-ID: <20201120101414.GC94830@google.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <6ad03a01-a3a4-5df4-7cf5-cbc768764e75@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ad03a01-a3a4-5df4-7cf5-cbc768764e75@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:15:42PM +0300, Alexey Budankov wrote:
> 
> Introduce thread specific data object and array of such objects
> to store and manage thread local data. Implement functions to
> allocate, initialize, finalize and release thread specific data.
> 
> Thread local maps and overwrite_maps arrays keep pointers to
> mmap buffer objects to serve according to maps thread mask.
> Thread local pollfd array keeps event fds connected to mmaps
> buffers according to maps thread mask.
> 
> Thread control commands are delivered via thread local comm pipes
> and ctlfd_pos fd. External control commands (--control option)
> are delivered via evlist ctlfd_pos fd and handled by the main
> tool thread.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/lib/api/fd/array.c    |  17 ++++
>  tools/lib/api/fd/array.h    |   1 +
>  tools/perf/builtin-record.c | 191 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 206 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 5e6cb9debe37..de8bcbaea3f1 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -88,6 +88,23 @@ int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags
>  	return pos;
>  }
>  
> +int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base)
> +{
> +	struct pollfd *entry;
> +	int npos;
> +
> +	if (pos >= base->nr)
> +		return -EINVAL;
> +
> +	entry = &base->entries[pos];
> +
> +	npos = fdarray__add(fda, entry->fd, entry->events, base->priv[pos].flags);
> +	if (npos >= 0)
> +		fda->priv[npos] = base->priv[pos];
> +
> +	return npos;
> +}
> +
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
>  		    void *arg)
> diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
> index 7fcf21a33c0c..4a03da7f1fc1 100644
> --- a/tools/lib/api/fd/array.h
> +++ b/tools/lib/api/fd/array.h
> @@ -42,6 +42,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
>  void fdarray__delete(struct fdarray *fda);
>  
>  int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags);
> +int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base);
>  int fdarray__poll(struct fdarray *fda, int timeout);
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 82f009703ad7..765a90e38f69 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -56,6 +56,7 @@
>  #include <poll.h>
>  #include <pthread.h>
>  #include <unistd.h>
> +#include <sys/syscall.h>
>  #include <sched.h>
>  #include <signal.h>
>  #ifdef HAVE_EVENTFD_SUPPORT
> @@ -90,6 +91,24 @@ struct thread_mask {
>  	struct mmap_cpu_mask	affinity;
>  };
>  
> +struct thread_data {
> +	pid_t			tid;
> +	struct thread_mask	*mask;
> +	struct {
> +		int		msg[2];
> +		int		ack[2];
> +	} comm;

I think the name 'comm' is misleading as we have thread's comm
already.


> +	struct fdarray		pollfd;
> +	int			ctlfd_pos;
> +	struct mmap		**maps;
> +	struct mmap		**overwrite_maps;
> +	int			nr_mmaps;
> +	struct record		*rec;
> +	unsigned long long	samples;
> +	unsigned long		waking;
> +	u64			bytes_written;
> +};
> +
>  struct record {
>  	struct perf_tool	tool;
>  	struct record_opts	opts;
> @@ -114,6 +133,7 @@ struct record {
>  	struct mmap_cpu_mask	affinity_mask;
>  	unsigned long		output_max_size;	/* = 0: unlimited */
>  	struct thread_mask	*thread_masks;
> +	struct thread_data	*thread_data;
>  	int			nr_threads;
>  };
>  
> @@ -842,9 +862,168 @@ static int record__kcore_copy(struct machine *machine, struct perf_data *data)
>  	return kcore_copy(from_dir, kcore_dir);
>  }
>  
> +static int record__thread_data_init_comm(struct thread_data *thread_data)
> +{
> +	if (pipe(thread_data->comm.msg) || pipe(thread_data->comm.ack)) {
> +		pr_err("Failed to create thread comm pipes, error %m\n");
> +		return -ENOMEM;
> +	}
> +
> +	pr_debug("thread_data[%p]: msg=[%d,%d], ack=[%d,%d]\n", thread_data,
> +		 thread_data->comm.msg[0], thread_data->comm.msg[1],
> +		 thread_data->comm.ack[0], thread_data->comm.ack[1]);
> +
> +	return 0;
> +}
> +
> +static int record__thread_data_init_maps(struct thread_data *thread_data, struct evlist *evlist)
> +{
> +	int m, tm, nr_mmaps = evlist->core.nr_mmaps;
> +	struct mmap *mmap = evlist->mmap;
> +	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
> +	struct perf_cpu_map *cpus = evlist->core.cpus;
> +
> +	thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits, thread_data->mask->maps.nbits);
> +	if (mmap) {
> +		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
> +		if (!thread_data->maps) {
> +			pr_err("Failed to allocate maps thread data\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	if (overwrite_mmap) {
> +		thread_data->overwrite_maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
> +		if (!thread_data->overwrite_maps) {
> +			pr_err("Failed to allocate overwrite maps thread data\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	pr_debug("thread_data[%p]: nr_mmaps=%d, maps=%p, overwrite_maps=%p\n", thread_data,
> +		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
> +
> +	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
> +		if (test_bit(cpus->map[m], thread_data->mask->maps.bits)) {
> +			if (thread_data->maps) {
> +				thread_data->maps[tm] = &mmap[m];
> +				pr_debug("thread_data[%p]: maps[%d] -> mmap[%d], cpus[%d]\n",
> +					 thread_data, tm, m, cpus->map[m]);
> +			}
> +			if (thread_data->overwrite_maps) {
> +				thread_data->overwrite_maps[tm] = &overwrite_mmap[m];
> +				pr_debug("thread_data[%p]: overwrite_maps[%d] -> overwrite_mmap[%d], cpus[%d]\n",
> +					 thread_data, tm, m, cpus->map[m]);

I'm afraid this will add too much debug message for verbose=1.  Maybe
we can demote some to pr_debug2()?


> +			}
> +			tm++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int record__thread_data_init_pollfd(struct thread_data *thread_data, struct evlist *evlist)
> +{
> +	int f, tm, pos;
> +	struct mmap *map, *overwrite_map;
> +
> +	fdarray__init(&thread_data->pollfd, 64);
> +
> +	for (tm = 0; tm < thread_data->nr_mmaps; tm++) {
> +		map = thread_data->maps ? thread_data->maps[tm] : NULL;
> +		overwrite_map = thread_data->overwrite_maps ? thread_data->overwrite_maps[tm] : NULL;
> +
> +		for (f = 0; f < evlist->core.pollfd.nr; f++) {
> +			void *ptr = evlist->core.pollfd.priv[f].ptr;
> +
> +			if ((map && ptr == map) || (overwrite_map && ptr == overwrite_map)) {
> +				pos = fdarray__clone(&thread_data->pollfd, f, &evlist->core.pollfd);
> +				if (pos < 0)
> +					return pos;
> +				pr_debug("thread_data[%p]: pollfd[%d] <- event_fd=%d\n",
> +					 thread_data, pos, evlist->core.pollfd.entries[f].fd);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
> +{
> +	int t, ret;
> +	struct thread_data *thread_data;
> +
> +	thread_data = zalloc(rec->nr_threads * sizeof(*(rec->thread_data)));
> +	if (!thread_data) {
> +		pr_err("Failed to allocate thread data\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (t = 0; t < rec->nr_threads; t++) {
> +		thread_data[t].rec = rec;
> +		thread_data[t].mask = &rec->thread_masks[t];
> +		ret = record__thread_data_init_maps(&thread_data[t], evlist);
> +		if (ret)
> +			return ret;

This and other places that return in the middle will leak the
thread_data.


> +		ret = record__thread_data_init_pollfd(&thread_data[t], evlist);
> +		if (ret)
> +			return ret;
> +		if (t) {
> +			thread_data[t].tid = -1;
> +			ret = record__thread_data_init_comm(&thread_data[t]);
> +			if (ret)
> +				return ret;
> +			thread_data[t].ctlfd_pos = fdarray__add(&thread_data[t].pollfd,
> +								thread_data[t].comm.msg[0],
> +								POLLIN | POLLERR | POLLHUP,
> +								fdarray_flag__nonfilterable);
> +			if (thread_data[t].ctlfd_pos < 0)
> +				return -ENOMEM;
> +			pr_debug("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
> +				 thread_data, thread_data[t].ctlfd_pos,
> +				 thread_data[t].comm.msg[0]);
> +		} else {
> +			thread_data[t].tid = syscall(SYS_gettid);
> +			if (evlist->ctl_fd.pos == -1)
> +				continue;
> +			thread_data[t].ctlfd_pos = fdarray__clone(&thread_data[t].pollfd,
> +								  evlist->ctl_fd.pos,
> +								  &evlist->core.pollfd);
> +			if (ret < 0)
> +				return ret;

You should check ctlfd_pos instead.

> +			pr_debug("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
> +				 thread_data, thread_data[t].ctlfd_pos,
> +				 evlist->core.pollfd.entries[evlist->ctl_fd.pos].fd);
> +		}
> +	}
> +
> +	rec->thread_data = thread_data;
> +
> +	return 0;
> +}
> +
> +static int record__free_thread_data(struct record *rec)
> +{
> +	int t;
> +
> +	for (t = 0; t < rec->nr_threads; t++) {
> +		close(rec->thread_data[t].comm.msg[0]);
> +		close(rec->thread_data[t].comm.msg[1]);
> +		close(rec->thread_data[t].comm.ack[0]);
> +		close(rec->thread_data[t].comm.ack[1]);
> +		zfree(&rec->thread_data[t].maps);
> +		zfree(&rec->thread_data[t].overwrite_maps);
> +		fdarray__exit(&rec->thread_data[t].pollfd);

The rec->thread_data might not be set.

Thanks,
Namhyung


> +	}
> +
> +	zfree(&rec->thread_data);
> +
> +	return 0;
> +}
> +
>  static int record__mmap_evlist(struct record *rec,
>  			       struct evlist *evlist)
>  {
> +	int ret;
>  	struct record_opts *opts = &rec->opts;
>  	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
>  				  opts->auxtrace_sample_mode;
> @@ -875,6 +1054,14 @@ static int record__mmap_evlist(struct record *rec,
>  				return -EINVAL;
>  		}
>  	}
> +
> +	if (evlist__initialize_ctlfd(evlist, opts->ctl_fd, opts->ctl_fd_ack))
> +		return -1;
> +
> +	ret = record__alloc_thread_data(rec, evlist);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> @@ -1845,9 +2032,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		perf_evlist__start_workload(rec->evlist);
>  	}
>  
> -	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
> -		goto out_child;
> -
>  	if (opts->initial_delay) {
>  		pr_info(EVLIST_DISABLED_MSG);
>  		if (opts->initial_delay > 0) {
> @@ -1998,6 +2182,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		record__synthesize_workload(rec, true);
>  
>  out_child:
> +	record__free_thread_data(rec);
>  	evlist__finalize_ctlfd(rec->evlist);
>  	record__mmap_read_all(rec, true);
>  	record__aio_mmap_read_sync(rec);
> -- 
> 2.24.1
> 
> 
