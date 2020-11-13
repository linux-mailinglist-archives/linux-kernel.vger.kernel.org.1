Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1932B1523
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 05:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKMEcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 23:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgKMEc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 23:32:29 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D3C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 20:32:29 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i26so6095631pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 20:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DgCxaBiQW6UzX3uY7y+ChG5KYfVfI0G9jTipnpbluV8=;
        b=hK97h6VHw76VGxSsGxGNWIQ4WDe3WtzacRWO4oj0Jd+8wHB28ABTf90SVU/gUo+nPi
         9AaF8oc9Frg2/KGugrQoU2i882XV83dzd2VS3fIN+NPBf/K4Ae1rtZjUgZm9soJTn1/C
         huX6KXLwao012AJuuGaTxz06WVjr4MxXvnvcbnLN+TMqa4RnIteYIyNfrp7QnJDoeZ+Y
         8UY9Z2SRUz8sNr1m4tmvs103M9K7rMljEUsh7uF4zYcH2pFw1/pMmZKZCMyF2Q8wsTFn
         XrdS494tB8+8Ta43tY4pnvBUCYS8Mt5ERrHwaYPpr57NhFBYDsGD2l+NMqHjXMRgg3HP
         yqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DgCxaBiQW6UzX3uY7y+ChG5KYfVfI0G9jTipnpbluV8=;
        b=nsqce7NqGr7BBdKhwHqvPXnz+ct9+RerHUsqwRh49v82vA/I2m/P7IxoHdMOKf1bYO
         4i9Pdgud+t2/7t1tRQuADSNJX+MYot2JzPpKArWHws4cBAdbOWEvnoASXCyr5B4URIPB
         YFx2Zql2xNA45wDOLk8Xmkghg+bLu8QUwKOEg7SCDUEITzEL6kPaTAulgz9RCcFhT2tV
         t/5/wiFo8vt4ybzFKC263DzMJJJC1T7QxsBNlxj69WvVVLoL9L8x8SYlADD5IeEfJSTf
         oRsNktE5eQMrbLSP7YAdGDJjoh3h2vMtkORpToUuZpA92CLo27G73RHSz6eo0rlCU/sB
         qj3w==
X-Gm-Message-State: AOAM53242bvOz6p7/Smrr8rM2mSGbfwFRIjsZ1pD9Rtrt1GE+gBJ+YZ9
        3Hx4z1E0O70CEETE1RkSNbA=
X-Google-Smtp-Source: ABdhPJwQEFj4XrEl8a9CPNqO3nuVsRhOVv/cKrmETrYXv6wGpBSfrceXPBxB22Rr94Pa/8wOhfWOgQ==
X-Received: by 2002:a63:2d02:: with SMTP id t2mr610985pgt.306.1605241949028;
        Thu, 12 Nov 2020 20:32:29 -0800 (PST)
Received: from google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id q22sm7467863pgi.33.2020.11.12.20.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 20:32:28 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 13 Nov 2020 13:32:22 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 15/24] perf tools: Synthesize build id for
 kernel/modules/tasks
Message-ID: <20201113043222.GB167797@google.com>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-16-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201109215415.400153-16-jolsa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:54:06PM +0100, Jiri Olsa wrote:
> Adding build id to synthesized mmap2 events for
> everything - kernel/modules/tasks.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index a18ae502d765..a9d5d1ff2cad 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -347,6 +347,32 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
>  	}
>  }
>  
> +static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
> +					     bool is_kernel)
> +{
> +	struct build_id bid;
> +	int rc;
> +
> +	if (is_kernel)
> +		rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
> +	else
> +		rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
> +
> +	if (rc == 0) {
> +		memcpy(event->build_id, bid.data, sizeof(bid.data));
> +		event->build_id_size = (u8) bid.size;
> +	} else {
> +		if (event->filename[0] == '/') {
> +			pr_debug2("Failed to read build ID for %s\n",
> +				  event->filename);
> +		}
> +		memset(event->build_id, 0x0, sizeof(event->build_id));

Likewise, we should not set the misc bit here IMHO.

Thanks,
Namhyung


> +	}
> +	event->header.misc |= PERF_RECORD_MISC_BUILD_ID;
> +	event->__reserved_1 = 0;
> +	event->__reserved_2 = 0;
> +}
> +
>  int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  				       union perf_event *event,
>  				       pid_t pid, pid_t tgid,
> @@ -453,6 +479,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  		event->mmap2.pid = tgid;
>  		event->mmap2.tid = pid;
>  
> +		if (symbol_conf.buildid_mmap2)
> +			perf_record_mmap2__read_build_id(&event->mmap2, false);
> +
>  		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
>  			rc = -1;
>  			break;
> @@ -630,6 +659,8 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
>  
>  			memcpy(event->mmap2.filename, pos->dso->long_name,
>  			       pos->dso->long_name_len + 1);
> +
> +			perf_record_mmap2__read_build_id(&event->mmap2, false);
>  		} else {
>  			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
>  			event->mmap.header.type = PERF_RECORD_MMAP;
> @@ -1050,6 +1081,8 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  		event->mmap2.start = map->start;
>  		event->mmap2.len   = map->end - event->mmap.start;
>  		event->mmap2.pid   = machine->pid;
> +
> +		perf_record_mmap2__read_build_id(&event->mmap2, true);
>  	} else {
>  		size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
>  				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
> -- 
> 2.26.2
> 
