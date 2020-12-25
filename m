Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1182E297F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 03:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgLYC1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 21:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgLYC1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 21:27:49 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C1CC061573
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 18:27:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e2so1954747plt.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 18:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ynNSSqVlh0E3n8/fKuki1zodJJQ4Lb7cgannL+ULGhk=;
        b=HL5YfDnLtIxawpuPb3V0m678jfhGmt6Kr5/GFnUq0C61uOtIHLcaXjtTdsMdc/ablZ
         wE24od1Zj0YcHUULKRCj/7ve9qLFpUIdmRNfB1wiUctq87ru6wx3zgvuu4EnXKoirovl
         1PbXyb11L7hLkcEnhzjB/2LFEjZtI4ZsorPryIs+rz/rUVXSzYLp6ZKW2jpMc8DDvhvE
         CUfVXLR5B0MJPbYl5RjTduFoOpSTHI8oPz/86zce/vfQEd1yEFz2SCZ+ehw3IS3zZNzL
         3g8KtiJyYatQJxBHaPe3YjLDo/LZ2WU7gsX3gTqFqkpDCRtpN2pROpdctuVB1bryR9Ce
         CWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ynNSSqVlh0E3n8/fKuki1zodJJQ4Lb7cgannL+ULGhk=;
        b=iArhsNvHMw3JSUpIVmImBJ3Xrrx+VNoAQUOy1afDkOz7Qg8BNBW6f50aKj9a+IsW7d
         tr8Pas7hiRAkytlARXa4mcxEsDyHWHkcZ2kPIl3zQ1GkmlBHyJUD9C6c506SZpZkO8t3
         HH41wUUUAkVJo1tZ8ITqtRhb9vvWOcBuqm9HJiF0AwXepi6/ZecpSmcPaDfDqwL/kGC+
         kgO4aZ4H7//klWZG+7U6WLyMY1D6Kox03WjKv+AV50vls8shFRfCSm5tvLfSuD2Ha+TT
         c5M5Z3YUjWcWCX/SADTxph97ogWEcuDZDeLN8tQzin3OjaAdlrMW9WLvDkg3iv6cdnyX
         ExAg==
X-Gm-Message-State: AOAM531yS48bI+l/GdZjGIc8cvxNqH/0SOn9jxwVcZvGiOCP8lZ9QwQM
        nwmyo9MfWyRBR4rhNHSpSDwfog==
X-Google-Smtp-Source: ABdhPJyKDZMs13WVJx4IFtg4TITt8BbGv21vs65cpaz96LUxAl7lnog0CMvO62i6lahOndHpzprGjg==
X-Received: by 2002:a17:902:b206:b029:dc:1f41:962d with SMTP id t6-20020a170902b206b02900dc1f41962dmr32664137plr.28.1608863227613;
        Thu, 24 Dec 2020 18:27:07 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([38.94.108.168])
        by smtp.gmail.com with ESMTPSA id w6sm11749378pfq.208.2020.12.24.18.27.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Dec 2020 18:27:06 -0800 (PST)
Date:   Fri, 25 Dec 2020 10:27:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Will Deacon <will@kernel.org>, John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf probe: Fixup Arm64 SDT arguments
Message-ID: <20201225022700.GA22238@leoy-ThinkPad-X240s>
References: <20201223063905.25784-1-leo.yan@linaro.org>
 <20201223063905.25784-2-leo.yan@linaro.org>
 <20201224135139.GF477817@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224135139.GF477817@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 10:51:39AM -0300, Arnaldo Carvalho de Melo wrote:

> Em Wed, Dec 23, 2020 at 02:39:04PM +0800, Leo Yan escreveu:
> > Arm64 ELF section '.note.stapsdt' uses string format "-4@[sp, NUM]" if
> > the probe is to access data in stack, e.g. below is an example for
> > dumping Arm64 ELF file and shows the argument format:
> > 
> >   Arguments: -4@[sp, 12] -4@[sp, 8] -4@[sp, 4]
> > 
> > Comparing against other archs' argument format, Arm64's argument
> > introduces an extra space character in the middle of square brackets,
> > due to argv_split() uses space as splitter, the argument is wrongly
> > divided into two items.
> > 
> > To support Arm64 SDT, this patch fixes up for this case, if any item
> > contains sub string "[sp", concatenates the two continuous items.  And
> > adds the detailed explaination in comment.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/probe-file.c | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> > index 064b63a6a3f3..60878c859e60 100644
> > --- a/tools/perf/util/probe-file.c
> > +++ b/tools/perf/util/probe-file.c
> > @@ -794,6 +794,8 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
> >  	char *ret = NULL, **args;
> >  	int i, args_count, err;
> >  	unsigned long long ref_ctr_offset;
> > +	char *arg;
> > +	int arg_idx = 0;
> >  
> >  	if (strbuf_init(&buf, 32) < 0)
> >  		return NULL;
> > @@ -815,8 +817,34 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
> >  	if (note->args) {
> >  		args = argv_split(note->args, &args_count);
> >  
> > -		for (i = 0; i < args_count; ++i) {
> > -			if (synthesize_sdt_probe_arg(&buf, i, args[i]) < 0)
> > +		for (i = 0; i < args_count; ) {
> > +			/*
> > +			 * FIXUP: Arm64 ELF section '.note.stapsdt' uses string
> > +			 * format "-4@[sp, NUM]" if a probe is to access data in
> > +			 * the stack, e.g. below is an example for the SDT
> > +			 * Arguments:
> > +			 *
> > +			 *   Arguments: -4@[sp, 12] -4@[sp, 8] -4@[sp, 4]
> > +			 *
> > +			 * Since the string introduces an extra space character
> > +			 * in the middle of square brackets, the argument is
> > +			 * divided into two items.  Fixup for this case, if an
> > +			 * item contains sub string "[sp,", need to concatenate
> > +			 * the two items.
> > +			 */
> > +			if (strstr(args[i], "[sp,") && (i+1) < args_count) {
> > +				arg = strcat(args[i], args[i+1]);
> > +				i += 2;
> > +			} else {
> > +				arg = strdup(args[i]);
> > +				i += 1;
> > +			}
> > +
> > +			err = synthesize_sdt_probe_arg(&buf, arg_idx, arg);
> > +			free(arg);
> 
> So you free here unconditionally because either you used something you
> got from argv_split() that strdup'ed all the entries in the array it
> returns, or that you strdup'ed in the else branch.


> But then you may not free all the things argv_split() returned, right?

Yes.

> Also, that strcat(args[i], args[i+1]), are you sure that is safe? strcat
> expects dest to have enough space for the concatenation, I don't see
> argv_split[] adding extra bytes, just a strdup().

Correct, will change to use asprintf().

> So probably you need asprintf() where you use strcat() and then, at the
> end of the loop, you need to free what argv_split() returned, using
> argv_free(), no?
> 
> Also please check strdup() (and then asprintf) managed to allocate, else
> synthesize_sdt_probe_arg() will receive its 'desc' argument as NULL, do
> _another_ strdup on it and boom.

Will add checking for the pointer from strdup()/asprintf().

> Or am I missing something? :)
> 
> I just looked ant synthesize_sdt_probe_command() is leaking the args it
> gets from argv_split()
> 
> So this patch is needed, ack?

Below change is good for me.  In the next respin, I will add this new
patch with your author name and send out.

Thanks a lot for the review, Masami & Arnaldo!

> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 064b63a6a3f311cd..bbecb449ea944395 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -791,7 +791,7 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
>  					const char *sdtgrp)
>  {
>  	struct strbuf buf;
> -	char *ret = NULL, **args;
> +	char *ret = NULL;
>  	int i, args_count, err;
>  	unsigned long long ref_ctr_offset;
>  
> @@ -813,12 +813,19 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
>  		goto out;
>  
>  	if (note->args) {
> -		args = argv_split(note->args, &args_count);
> +		char **args = argv_split(note->args, &args_count);
> +
> +		if (args == NULL)
> +			goto error;
>  
>  		for (i = 0; i < args_count; ++i) {
> -			if (synthesize_sdt_probe_arg(&buf, i, args[i]) < 0)
> +			if (synthesize_sdt_probe_arg(&buf, i, args[i]) < 0) {
> +				argv_free(args);
>  				goto error;
> +			}
>  		}
> +
> +		argv_free(args);
>  	}
>  
>  out:
