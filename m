Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884672BA6EF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgKTKBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgKTKBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:01:33 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A868EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:01:33 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so6796044pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2cAqTvGkUCt6HcCFZORuIOlPeuzOfz4/BxT3TDzVB3c=;
        b=gT3giU3DIad/ByfJQGVRL4OImXXCNnAAcryX9WeaLi7l17hZ2XcwDbvxlXZ3vgriku
         X9cu4uxmqyL5a0/gquSpzf4JB1SubCGxoT+0ZlSeeiTvpDvRLpL3UhzgUHUEaSNhPtrq
         Ud3+fz5N3sTamnrdf5Dd91NKEF53tgUwzPaTr/qsOSz0d5J5IauyW1PNE1GOONNgEZmY
         fltJx3+eYA6xw1wJ0kfLk9waDj98zszIIx+yAszoOmKhoYSKImBSxyxAhRfCknM3kltt
         JyssDlDK3DVWnPdBI4wTmPaVCVwfFdz1iwzfE+xiihdBpCBbJj9biPm1x/CUr7sD952J
         ekKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2cAqTvGkUCt6HcCFZORuIOlPeuzOfz4/BxT3TDzVB3c=;
        b=N4txCqm7axsxTjM9w1Rj/HLvjquZpMXC1BLSOvQ3jPICWUK1ay+KuYUJMCcNr7oPYS
         LZ5s7gkMhwbBHcjQCjOsldo/g3CLYAsuqg5GUMyZn/H9MVLoUKshs/jLBnp56jvz0oho
         Yw7fRlfFvyPEaaP8czdKJgqO/CKj8ADPlUpp/yXfv1Xv+y/Hw6uZwL/dka/j9Q4Sd4mj
         fxiPmiWplJuw3sCUCZ99Vqx+7hyKqR03KGcrOo4e6isOKjmJTIgJ1toSEEfqVcE58fsR
         oLxZIs9na/XOmhcET7K0blk1gYkbR4GBGfO+lGLuskliBZsFGJZ35Tmx6iYNWjquhldz
         ONdA==
X-Gm-Message-State: AOAM533z4xYA1NQHBjFSCVsJoVIuq+mN0O+/9Hz3jqSgSadjaQxuSxhT
        KGt+l2ztvqmcUguLC2TUXhct5ym6GXY=
X-Google-Smtp-Source: ABdhPJwgT9T6AgtnY9RoGphmwL8dzKhMoHyyVtTI4LfRPby7c6RqUXXidBYDuKG4zVSXtNEgHl7xSg==
X-Received: by 2002:a63:7a1c:: with SMTP id v28mr15568649pgc.104.1605866493180;
        Fri, 20 Nov 2020 02:01:33 -0800 (PST)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id f16sm2532516pgk.48.2020.11.20.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:01:32 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 20 Nov 2020 19:01:25 +0900
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
Subject: Re: [PATCH v3 01/12] perf record: introduce thread affinity and mmap
 masks
Message-ID: <20201120100125.GB94830@google.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <e92d3f86-baa5-0e62-50bd-151f33969baa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e92d3f86-baa5-0e62-50bd-151f33969baa@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:14:50PM +0300, Alexey Budankov wrote:
> 
> Introduce affinity and mmap thread masks. Thread affinity mask
> defines cpus that a thread is allowed to run on. Thread maps
> mask defines mmap data buffers the thread serves to stream
> profiling data from.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 116 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index adf311d15d3d..82f009703ad7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
[SNIP]
> +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
> +{
> +	int t, ret;
> +
> +	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
> +	if (!rec->thread_masks) {
> +		pr_err("Failed to allocate thread masks\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (t = 0; t < nr_threads; t++) {
> +		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
> +		if (ret)
> +			return ret;
> +		record__thread_mask_clear(&rec->thread_masks[t]);
> +	}
> +
> +	return 0;
> +}
> +static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +	int ret;
> +
> +	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu());
> +	if (ret)
> +		return ret;
> +
> +	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
> +
> +	rec->nr_threads = 1;
> +
> +	return 0;
> +}
> +
> +static int record__init_thread_masks(struct record *rec)
> +{
> +	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
> +
> +	return record__init_thread_default_masks(rec, cpus);
> +}
> +
> +static int record__fini_thread_masks(struct record *rec)
> +{
> +	int t;
> +
> +	for (t = 0; t < rec->nr_threads; t++)
> +		record__thread_mask_free(&rec->thread_masks[t]);

It might be failed when allocating rec->thread_masks.

Thanks
Namhyung


> +
> +	zfree(&rec->thread_masks);
> +
> +	rec->nr_threads = 0;
> +
> +	return 0;
> +}
> +
>  int cmd_record(int argc, const char **argv)
>  {
>  	int err;
> @@ -2821,6 +2930,12 @@ int cmd_record(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	err = record__init_thread_masks(rec);
> +	if (err) {
> +		pr_err("record__init_thread_masks failed, error %d\n", err);
> +		goto out;
> +	}
> +
>  	if (rec->opts.nr_cblocks > nr_cblocks_max)
>  		rec->opts.nr_cblocks = nr_cblocks_max;
>  	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
> @@ -2839,6 +2954,7 @@ int cmd_record(int argc, const char **argv)
>  	symbol__exit();
>  	auxtrace_record__free(rec->itr);
>  out_opts:
> +	record__fini_thread_masks(rec);
>  	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
>  	return err;
>  }
> -- 
> 2.24.1
> 
