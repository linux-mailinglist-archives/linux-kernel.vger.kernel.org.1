Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE162A282A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgKBKYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:24:49 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A3C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:24:49 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x23so6609006plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 02:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KVNk8B5WeX3J87Nf1hJEI8gQBe0Dd3Oj7OyhNsjulAw=;
        b=SBxis+i+IKvLiy3QYdRFuwFXF6KooqDltEafpJcSdFst61QVm3s9L0GyskN0geynem
         7bV9LrJfRxrK1wZcdxTL3kL652vR+aHSlCJsyVXi5G9D7xSGQn1G/weDZ3cUSObnwv74
         LzDXzaaYT6r0o1ItmpetKh3uagVWQZzNQrd5JePadKV+BqYslatdzpl8fr/6L+IuITUg
         6UMm/1ePh3s3W12nIXxPN2BjcCNMXxXST4XH7wtISIQfX5qP7/Yq+h5J/hygU4Iyk5x1
         zQgMOm9tIQ8CdHANXGTRJOzmwiMkZ2isj/k49R7rdS0tNXB7EkSaI4b/McYsGUTrQeYu
         whaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KVNk8B5WeX3J87Nf1hJEI8gQBe0Dd3Oj7OyhNsjulAw=;
        b=sUxQP3wlxItAhUWq+RffC/WWEv88Px1iL7i/NrAlJ1GUZkg5jB7+FepkaKXMuvwYbJ
         KjZk55CA382JE5EmXugrB6w1JfjiywaAwJJzxzzeoKnje0hJA776P4pvBpTUrxVXRd6B
         MqBrCzqIyqgXfVhmFVYypch4rNQAWCe4cRZ/yqHjNmYHYxiEN+Vi5a1xWNxhleAhxKY9
         wzmg91+p3MoU55MSgb2SW9ZM2jt/crU0oVgBnQ5jX+XLgKKaCjXUjk8QbETmMXgbwf65
         y0snCO0MK9MkbIH/bKNhi3u28ev+k+ckcg/5uXU4T1IkMHHA99cHlWfn2C6EsRj9BfBh
         8xbw==
X-Gm-Message-State: AOAM532oUbuuCcf6zLUeJV3u8oQpNBWLeSTqM5nMiFyfcqOUL5Z70c4w
        Od9u7GwGUqcxPZrwCRUvsy5sEA==
X-Google-Smtp-Source: ABdhPJxKxbGmd5f0Oy9nPc3Pnt2dCM7Z6ZB2NyxNqNFnlVy13Ru0GGgann2+GZV2cyl3V06JnjtUOA==
X-Received: by 2002:a17:902:e983:b029:d5:f465:55d5 with SMTP id f3-20020a170902e983b02900d5f46555d5mr20542506plb.60.1604312689019;
        Mon, 02 Nov 2020 02:24:49 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id k127sm12259743pgk.10.2020.11.02.02.24.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 02:24:48 -0800 (PST)
Date:   Mon, 2 Nov 2020 18:24:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf lock: Correct field name "flags"
Message-ID: <20201102102441.GC6633@leoy-ThinkPad-X240s>
References: <20201021003948.28817-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021003948.28817-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed, Oct 21, 2020 at 08:39:47AM +0800, Leo Yan wrote:
> The tracepoint "lock:lock_acquire" contains field "flags" but not
> "flag".  Current code wrongly retrieves value from field "flag" and it
> always gets zero for the value, thus "perf lock" doesn't report the
> correct result.
> 
> This patch replaces the field name "flag" with "flags", so can read out
> the correct flags for locking.

Could you take a look for the two fixings in this patch set (v2)?

Thanks,
Leo

> Fixes: 746f16ec6ae3 ("perf lock: Use perf_evsel__intval and perf_session__set_tracepoints_handlers")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index f0a1dbacb46c..5cecc1ad78e1 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -406,7 +406,7 @@ static int report_lock_acquire_event(struct evsel *evsel,
>  	struct lock_seq_stat *seq;
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 tmp	 = evsel__intval(evsel, sample, "lockdep_addr");
> -	int flag = evsel__intval(evsel, sample, "flag");
> +	int flag = evsel__intval(evsel, sample, "flags");
>  
>  	memcpy(&addr, &tmp, sizeof(void *));
>  
> -- 
> 2.17.1
> 
