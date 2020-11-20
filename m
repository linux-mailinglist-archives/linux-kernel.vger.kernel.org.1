Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817382BA7BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgKTKtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgKTKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:49:52 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D39C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:49:50 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w14so7488555pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/f5PJMDdMFaa+osxf9YG+ZYzJY5dUdk2PxT//JYA7AA=;
        b=Ns962fMkJVjJJyxG+zGFRipF0hzfK1IftPaCTyy5Ca2ZoWqHpsT9TwxaN00FSUiSPZ
         4f8NYfJt04l0b1G9EKDuMojD4Dc11GouRrr/idls68d6f60RuMh1M3hwA4OLMiFAFUng
         rL53aPUFL2TUIAcBrbosPg3Jmd9bgY4SRV5qLzeTFtgaIY7hBd60U4mDgw4gMHuWvzwQ
         Hp3iCZMHWSWOo0kE7coghBiNuZD94nrYnMw1sRlR7gZb7hHsNHmsyj0Rb9nu5tK3fsJJ
         L0NgnSVWwWmg0YXy2K0jpSk2uP9PWM9Y7XoXfKCMrt4ISazEUxKvTOTgoELGr6gyzUlb
         EqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/f5PJMDdMFaa+osxf9YG+ZYzJY5dUdk2PxT//JYA7AA=;
        b=bb8gRqcvuDGkWjuRaxgrHH7uExIzYov57ckIWh08n+oTEpeRD+RCAZ7M+hINUp4evN
         piRYtU0H0Lfp8yAaP73dW/obu0wltYe4Jvf2XzgnKT0e8VW0hWOYeWACu71tuKsAlQB/
         3OtosKoMouxsPSQSAMqwU5dEQJFtsJqOb0/VzIkdtMLK1+3Fjr2r25GisuUglY+9RPKI
         j8kNtMrs3J67gSZER6h/63zHzpmw6wcw3akNOFTzedLO34FAOgJiicYwe9dKDf8aWgdn
         pvOKST8XRl2BoZzN2+7p+CTlygCRuAOTZ6UTjANWUVgfgSREDS9hiE2QwlYqVy13zYOw
         cVbg==
X-Gm-Message-State: AOAM532JX0cTKCaYQRkkd3iBa0YjLmzqOM2lO6xmhJWzpAiwUALsWxtU
        DiImjKRIuIjQrbOs8MjGAUQ1K8ZjsIE=
X-Google-Smtp-Source: ABdhPJwfENL8ctDALgnZIhJzxSuexMbsOE7RnzA5/ZeoEXhsR0Nojlo1uP1S0vs3iPA9jcDl8qMqLw==
X-Received: by 2002:a17:90a:5c83:: with SMTP id r3mr8399771pji.134.1605869390339;
        Fri, 20 Nov 2020 02:49:50 -0800 (PST)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id r8sm3282910pfq.197.2020.11.20.02.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:49:49 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 20 Nov 2020 19:49:42 +0900
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
Subject: Re: [PATCH v3 07/12] perf record: init data file at mmap buffer
 object
Message-ID: <20201120104942.GF94830@google.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <ad205903-41a6-5041-f4f3-6f57d83cbd3a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad205903-41a6-5041-f4f3-6f57d83cbd3a@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:19:41PM +0300, Alexey Budankov wrote:
> 
> Initialize data files located at mmap buffer objects so trace data
> can be written into several data file located at data directory.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 41 ++++++++++++++++++++++++++++++-------
>  tools/perf/util/record.h    |  1 +
>  2 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 779676531edf..f5e5175da6a1 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -158,6 +158,11 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
>  	"SYS", "NODE", "CPU"
>  };
>  
> +static int record__threads_enabled(struct record *rec)
> +{
> +	return rec->opts.threads_spec;
> +}
> +
>  static bool switch_output_signal(struct record *rec)
>  {
>  	return rec->switch_output.signal &&
> @@ -1060,7 +1065,7 @@ static int record__free_thread_data(struct record *rec)
>  static int record__mmap_evlist(struct record *rec,
>  			       struct evlist *evlist)
>  {
> -	int ret;
> +	int i, ret;
>  	struct record_opts *opts = &rec->opts;
>  	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
>  				  opts->auxtrace_sample_mode;
> @@ -1099,6 +1104,18 @@ static int record__mmap_evlist(struct record *rec,
>  	if (ret)
>  		return ret;
>  
> +	if (record__threads_enabled(rec)) {
> +		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
> +		if (ret)
> +			return ret;
> +		for (i = 0; i < evlist->core.nr_mmaps; i++) {
> +			if (evlist->mmap)
> +				evlist->mmap[i].file = &rec->data.dir.files[i];
> +			if (evlist->overwrite_mmap)
> +				evlist->overwrite_mmap[i].file = &rec->data.dir.files[i];
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1400,8 +1417,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
>  	/*
>  	 * Mark the round finished in case we wrote
>  	 * at least one event.
> +	 *
> +	 * No need for round events in directory mode,
> +	 * because per-cpu maps and files have data
> +	 * sorted by kernel.

But it's not just for single cpu since task can migrate so we need to
look at other cpu's data too.  Thus we use the ordered events queue
and round events help to determine when to flush the data.  Without
the round events, it'd consume huge amount of memory during report.

If we separate tracking records and process them first, we should be
able to process samples immediately without sorting them in the
ordered event queue.  This will save both cpu cycles and memory
footprint significantly IMHO.

Thanks,
Namhyung


>  	 */
> -	if (bytes_written != rec->bytes_written)
> +	if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
>  		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
>  
>  	if (overwrite)
> @@ -1514,7 +1535,9 @@ static void record__init_features(struct record *rec)
>  	if (!rec->opts.use_clockid)
>  		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
>  
> -	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
> +	if (!record__threads_enabled(rec))
> +		perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
> +
>  	if (!record__comp_enabled(rec))
>  		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
>  
> @@ -1525,15 +1548,21 @@ static void
>  record__finish_output(struct record *rec)
>  {
>  	struct perf_data *data = &rec->data;
> -	int fd = perf_data__fd(data);
> +	int i, fd = perf_data__fd(data);
>  
>  	if (data->is_pipe)
>  		return;
>  
>  	rec->session->header.data_size += rec->bytes_written;
>  	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
> +	if (record__threads_enabled(rec)) {
> +		for (i = 0; i < data->dir.nr; i++)
> +			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
> +	}
>  
>  	if (!rec->no_buildid) {
> +		/* this will be recalculated during process_buildids() */
> +		rec->samples = 0;
>  		process_buildids(rec);
>  
>  		if (rec->buildid_all)
> @@ -2438,8 +2467,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		status = err;
>  
>  	record__synthesize(rec, true);
> -	/* this will be recalculated during process_buildids() */
> -	rec->samples = 0;
>  
>  	if (!err) {
>  		if (!rec->timestamp_filename) {
> @@ -3179,7 +3206,7 @@ int cmd_record(int argc, const char **argv)
>  
>  	}
>  
> -	if (rec->opts.kcore)
> +	if (rec->opts.kcore || record__threads_enabled(rec))
>  		rec->data.is_dir = true;
>  
>  	if (rec->opts.comp_level != 0) {
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 266760ac9143..9c13a39cc58f 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -74,6 +74,7 @@ struct record_opts {
>  	int	      ctl_fd;
>  	int	      ctl_fd_ack;
>  	bool	      ctl_fd_close;
> +	int	      threads_spec;
>  };
>  
>  extern const char * const *record_usage;
> -- 
> 2.24.1
> 
