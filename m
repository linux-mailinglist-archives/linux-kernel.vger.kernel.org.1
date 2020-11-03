Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F052A3A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 02:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKCBw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 20:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKCBw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:52:26 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D3C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 17:52:25 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 13so12820604pfy.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 17:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4EZ/IGO0b9UcdtBAPm2HQLc6Y9QXRUQENyaU1WzpV+A=;
        b=OW+KVS3yQkB7w7NPiB2P5hC7YpXgtRPme+cuXxvagO0Eh70dhepN71XKoVI1wTi7UG
         0rbyD0VcSLG6Lo56LxrTI3GaEtwLhcduepURPrhw3AuTbvrEh3P+c9MLshr4UKrNjMqV
         GWCyBT1W8scb5yAO/kCNLjd/cnTBHJibpyZtXjM5gZlt+QXlLDYUoWhJE6MkWcxxCkMi
         ZZ/s9koX221D16XyhVqH+Bvkq49Dwf3x8rYNWPPMXxjQQ4fZZVf5GMzlefD4LHif668t
         8KOa/RowmQL1h5krfyOXIs8gOA9rPeCGoh3tMQMMiqWoQw3MHwlj3r+pqVFy/ZgbNEdw
         +BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4EZ/IGO0b9UcdtBAPm2HQLc6Y9QXRUQENyaU1WzpV+A=;
        b=tET2l0Xqr8XJZvSKOQlZJ70FXG64bJ9G2Est8PNG3Bu09Cq/qLFVoqO19Buc2VuEFN
         hl0sW01XS2zKLMdggpRGrNueDR7yq/dfbQLKj+2yiQvkXcBr9HdvBbPdBYyqeNckgUw4
         zHaXjPpvg/52uXL5hNCVR9VmmhbGMlEfHZe36lPaeMWtA07cW9NnpxcqNzbRRdSDE5QB
         oYCHUkGgDhLrmTv3SwKhVM3Vm9FQ5equpJ7jzkcz+UQ+hCNa6+4Iyr8Gt4p8o+z/9y3g
         /A7EIV+H9I/cMP+4T3O6tD6Hp7Ja3GPQ/JythPqgNNq6s25xYgUSVoyIl5XimKrar2ol
         GG4A==
X-Gm-Message-State: AOAM530XmUZTPkTr08nGY7fxiiIZdfH2b+An3AGU+XAwVjnRYIZNUQ97
        tfPASTo39h1qshwQNa2qHSoiUg==
X-Google-Smtp-Source: ABdhPJzsskMlgBpUkw2CqghiylbOEcKNR2QmoEBX2ztmkK3BQ58sxqC2UjKl+c5WX21nl9C4FnBxcw==
X-Received: by 2002:a62:5251:0:b029:164:3604:578d with SMTP id g78-20020a6252510000b02901643604578dmr24302222pfb.51.1604368344339;
        Mon, 02 Nov 2020 17:52:24 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id w4sm724584pjh.47.2020.11.02.17.52.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 17:52:23 -0800 (PST)
Date:   Tue, 3 Nov 2020 09:52:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf lock: Correct field name "flags"
Message-ID: <20201103015216.GA13232@leoy-ThinkPad-X240s>
References: <20201021003948.28817-1-leo.yan@linaro.org>
 <20201102164213.GC3405508@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102164213.GC3405508@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:42:13PM +0100, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 08:39:47AM +0800, Leo Yan wrote:
> > The tracepoint "lock:lock_acquire" contains field "flags" but not
> > "flag".  Current code wrongly retrieves value from field "flag" and it
> > always gets zero for the value, thus "perf lock" doesn't report the
> > correct result.
> > 
> > This patch replaces the field name "flag" with "flags", so can read out
> > the correct flags for locking.
> > 
> > Fixes: 746f16ec6ae3 ("perf lock: Use perf_evsel__intval and perf_session__set_tracepoints_handlers")
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> btw it seems the issue was there event before that commit:
>   acquire_event.flag = (int)raw_field_value(event, "flag", data);

Thanks for pointing out this, I will change the fix tag as:
Fixes: e4cef1f65061 ("perf lock: Fix state machine to recognize lock sequence")

Leo

> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-lock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index f0a1dbacb46c..5cecc1ad78e1 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -406,7 +406,7 @@ static int report_lock_acquire_event(struct evsel *evsel,
> >  	struct lock_seq_stat *seq;
> >  	const char *name = evsel__strval(evsel, sample, "name");
> >  	u64 tmp	 = evsel__intval(evsel, sample, "lockdep_addr");
> > -	int flag = evsel__intval(evsel, sample, "flag");
> > +	int flag = evsel__intval(evsel, sample, "flags");
> >  
> >  	memcpy(&addr, &tmp, sizeof(void *));
> >  
> > -- 
> > 2.17.1
> > 
> 
