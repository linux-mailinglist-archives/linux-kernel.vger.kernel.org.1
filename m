Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FBB2B1522
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 05:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKME35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 23:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgKME34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 23:29:56 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202DDC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 20:29:43 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h6so6093466pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 20:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j5R1Gx6DzdWHYutq17LijZop4uXlukyTUkfaPDw8Dzo=;
        b=JfpMWDCMd9qJT8GFnOZXnl7Z34D18zR4WazFsntGlQZl4obdrtSKUjl+zznQGKW/V3
         1bMxPFUeMKBZPWkqQbz9qEHxFEzMRt8BYLIlxvmC/fYERPizA0rQCJ20R1mktmQZBZmn
         KVOB+4cBnII60IZ0yOpt0CI9tKYfcxFsxGnpQZktEyZnNLqbKVgaU94Xv8lTaX6zssep
         EBPqQqNES8gOunhuNDGzEXqbIn/sp85C65+JWkH1i0AzPFo18HwlPvvVwcyZWVLsFR+t
         guCFsDfNVsl6PtXisvKt/pFfXd3pt5u6wWrrg+Y4oYILtC746Q2CyEHj/RAqqrOgnzpe
         JeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=j5R1Gx6DzdWHYutq17LijZop4uXlukyTUkfaPDw8Dzo=;
        b=n6rI1g9Jw0CF8l8joDz9AImDo32qH/15OcVQuxBAnHY87uBEl3Zzo8Z0ICYfnYAgmD
         I7PSjsXNtCaZDoJ5/hPMB8hgD0vhs60BJF66aYuRmdDa6GCBe/kR9dsBxT3TlErwZlu3
         S6xRZobvcYF0+nzFYh5LgFtQipDolAjObhn7YwK+qwnwyJyQux1R0OAo0w1ntESMUYIM
         9B4Y5pkYz3kdDo+gmUN7UkVvG5s6+rmd0PXiyOPAB3iVrCfrBl1klv1N1qLPPLD26MF9
         tw9Dzgk8GumYkCWuPQxc4ZIAIdvi3He+eWCFVR9aeQyH0bF41Uik1gJbgtekB7SdMAwF
         j4Iw==
X-Gm-Message-State: AOAM530wvTcS0WPnvlF9emA93WHs+Hk+GOMDz3SrUBasH2mKZgqPcMMU
        K4u0oa3oUHkYA6qJ6RX3d0w=
X-Google-Smtp-Source: ABdhPJy9CPyIh5+dGeSXveEDnQb0GaNNjWenoYkm8Ns8muvTKM9mWrlPN0ONy4NPaJn/mM7e80gS8A==
X-Received: by 2002:a62:7cd3:0:b029:18b:8c56:91eb with SMTP id x202-20020a627cd30000b029018b8c5691ebmr482743pfc.23.1605241782660;
        Thu, 12 Nov 2020 20:29:42 -0800 (PST)
Received: from google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id 21sm8503407pfv.122.2020.11.12.20.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 20:29:41 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 13 Nov 2020 13:29:35 +0900
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
Subject: Re: [PATCH 03/24] perf: Add build id data in mmap2 event
Message-ID: <20201113042935.GA167797@google.com>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201109215415.400153-4-jolsa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Nov 09, 2020 at 10:53:54PM +0100, Jiri Olsa wrote:
> Adding support to carry build id data in mmap2 event.
> 
> The build id data replaces maj/min/ino/ino_generation
> fields, whichc are also used to identify map's binary,
> so it's ok to replace them with build id data:
> 
>   union {
>           struct {
>                   u32       maj;
>                   u32       min;
>                   u64       ino;
>                   u64       ino_generation;
>           };
>           struct {
>                   u8        build_id[20];
>                   u8        build_id_size;
>                   u8        __reserved_1;
>                   u16       __reserved_2;
>           };
>   };
> 
> Replaced maj/min/ino/ino_generation fields give us size
> of 24 bytes. We use 20 bytes for build id data, 1 byte
> for size and rest is unused.
> 
> There's new misc bit for mmap2 to signal there's build
> id data in it:
> 
>   #define PERF_RECORD_MISC_BUILD_ID              (1 << 14)
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
[SNIP]
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index da467e1dd49a..808473b6ce85 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -51,6 +51,7 @@
>  #include <linux/proc_ns.h>
>  #include <linux/mount.h>
>  #include <linux/min_heap.h>
> +#include <linux/buildid.h>
>  
>  #include "internal.h"
>  
> @@ -395,6 +396,7 @@ static atomic_t nr_ksymbol_events __read_mostly;
>  static atomic_t nr_bpf_events __read_mostly;
>  static atomic_t nr_cgroup_events __read_mostly;
>  static atomic_t nr_text_poke_events __read_mostly;
> +static atomic_t nr_build_id_events __read_mostly;
>  
>  static LIST_HEAD(pmus);
>  static DEFINE_MUTEX(pmus_lock);
> @@ -4672,6 +4674,8 @@ static void unaccount_event(struct perf_event *event)
>  		dec = true;
>  	if (event->attr.mmap || event->attr.mmap_data)
>  		atomic_dec(&nr_mmap_events);
> +	if (event->attr.build_id)
> +		atomic_dec(&nr_build_id_events);
>  	if (event->attr.comm)
>  		atomic_dec(&nr_comm_events);
>  	if (event->attr.namespaces)
> @@ -7942,6 +7946,8 @@ struct perf_mmap_event {
>  	u64			ino;
>  	u64			ino_generation;
>  	u32			prot, flags;
> +	u8			build_id[BUILD_ID_SIZE];
> +	u32			build_id_size;
>  
>  	struct {
>  		struct perf_event_header	header;
> @@ -7997,13 +8003,23 @@ static void perf_event_mmap_output(struct perf_event *event,
>  	mmap_event->event_id.pid = perf_event_pid(event, current);
>  	mmap_event->event_id.tid = perf_event_tid(event, current);
>  
> +	if (event->attr.mmap2 && event->attr.build_id)
> +		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_BUILD_ID;
> +
>  	perf_output_put(&handle, mmap_event->event_id);
>  
>  	if (event->attr.mmap2) {
> -		perf_output_put(&handle, mmap_event->maj);
> -		perf_output_put(&handle, mmap_event->min);
> -		perf_output_put(&handle, mmap_event->ino);
> -		perf_output_put(&handle, mmap_event->ino_generation);
> +		if (event->attr.build_id) {
> +			u8 size[4] = { (u8) mmap_event->build_id_size, 0, 0, 0 };
> +
> +			__output_copy(&handle, mmap_event->build_id, BUILD_ID_SIZE);
> +			__output_copy(&handle, size, 4);
> +		} else {
> +			perf_output_put(&handle, mmap_event->maj);
> +			perf_output_put(&handle, mmap_event->min);
> +			perf_output_put(&handle, mmap_event->ino);
> +			perf_output_put(&handle, mmap_event->ino_generation);
> +		}
>  		perf_output_put(&handle, mmap_event->prot);
>  		perf_output_put(&handle, mmap_event->flags);
>  	}
> @@ -8132,6 +8148,11 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
>  
>  	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
>  
> +	if (atomic_read(&nr_build_id_events)) {
> +		build_id_parse_size(vma, mmap_event->build_id,
> +				    &mmap_event->build_id_size);

This can fail, right?  Then we need to fallback to use dev/ino..

Thanks,
Namhyung


> +	}
> +
>  	perf_iterate_sb(perf_event_mmap_output,
>  		       mmap_event,
>  		       NULL);
> @@ -11069,6 +11090,8 @@ static void account_event(struct perf_event *event)
>  		inc = true;
>  	if (event->attr.mmap || event->attr.mmap_data)
>  		atomic_inc(&nr_mmap_events);
> +	if (event->attr.build_id)
> +		atomic_inc(&nr_build_id_events);
>  	if (event->attr.comm)
>  		atomic_inc(&nr_comm_events);
>  	if (event->attr.namespaces)
> -- 
> 2.26.2
> 
