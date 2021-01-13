Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41102F41C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbhAMC2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhAMC2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:28:19 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25534C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:27:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u4so217286pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U065/+i85s4JwJu/tEldMSxCzMGg8gNUrqXbwKllSNY=;
        b=jluNAwtdoClM0rEr3qoU3llqih2zv1urBwcgbXv14wCR4oFEfUJZEWFWgxDXKLqbyB
         HFtgmlStaGhC/sovVwsD306MLzVd9Z5iYM3V29RyGB0aShzFzTST8ZYdPVF4AI5nsR/v
         p78rqoqbyOs3awbqfc7R4v7k+6AnMNNBahwlBgq2Bfv6kcUpPZa1mb9Hj0zq8vFnXI/S
         vuvWgS2pAdI0Iypb6URsCwJ4FABmPx6daBOVSEpfIr0Jfg8+odExQuY5OOwibicH9A/u
         fwGDKka1qqXqwST2MoocDd39bQoj0B3ytQhiKemgz5iFraN8aEoujhr9IOFCo7Kl22q8
         Quyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U065/+i85s4JwJu/tEldMSxCzMGg8gNUrqXbwKllSNY=;
        b=R8keBbOpnr9rF4Iopf1WsZyz3K7ko8D1sFJWISK5SIFLOk9U+Dh1E30FiGZ02JCKFa
         4QpuWlaPP+CViSLMNR44X+h1y4EOBMwwWlLnEKPDKhmueernz0Kcyd4DElyx405IY03L
         NcB8M6GmuespNvorUZcoByS2rBj5u184NT5FiQ9Yb0PZHU25EXF+IPUxTqIHP9/oT3x6
         BoNFSzUOZYqeDHpiUvHQA1D3k4cIRh1BNuHqGVRibkhye+y5FATE7I7ZZ5w4UbrNJhOp
         FOvOVV0wk//HNDaDgFuHHr+Ef7CJUPNBl2jdCLk4nh9Kh5f3saKrkDSBnlym25tyV/0g
         dPPA==
X-Gm-Message-State: AOAM530nb2GZOEtYujz/0AVkb9WU2GT5EGShQHL8syT6xjvTAWppM+cd
        0pESaSDqviOUtwm7UVn0SKMZ7A==
X-Google-Smtp-Source: ABdhPJyjfGxh0002CNk8xevJiW74mpuVEyTdLGzVrns0R6w0q7yYk7IThplxZf5SN5rZ0KkLUgDznw==
X-Received: by 2002:a17:90b:17c7:: with SMTP id me7mr138574pjb.205.1610504858577;
        Tue, 12 Jan 2021 18:27:38 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id b5sm384882pga.54.2021.01.12.18.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 18:27:37 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:27:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/7] perf cs-etm: Calculate per CPU metadata array size
Message-ID: <20210113022721.GG18965@leoy-ThinkPad-X240s>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-4-leo.yan@linaro.org>
 <96ec434e-4103-02ac-a05a-761a9ca8cb0d@arm.com>
 <CAJ9a7VjtUuRRYBBu63kSXKwrGdB8ZoWJz-bE1g9tMLSbkFVDGg@mail.gmail.com>
 <20210111150608.GC222747@leoy-ThinkPad-X240s>
 <CAJ9a7VjhMOq=r=W2xtjgiHhmvwk1xDzMnWF4hKPogX8PX+ZADg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VjhMOq=r=W2xtjgiHhmvwk1xDzMnWF4hKPogX8PX+ZADg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, Jan 13, 2021 at 12:00:10AM +0000, Mike Leach wrote:

[...]

> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index a2a369e2fbb6..edaec57362f0 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -2558,12 +2558,19 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >                                 err = -ENOMEM;
> >                                 goto err_free_metadata;
> >                         }
> > -                       for (k = 0; k < CS_ETM_PRIV_MAX; k++)
> > +                       for (k = 0; k < CS_ETM_PRIV_MAX; k++) {
> >                                 metadata[j][k] = ptr[i + k];
> >
> > +                               if (ptr[i + k + 1] == __perf_cs_etmv3_magic ||
> > +                                   ptr[i + k + 1] == __perf_cs_etmv4_magic) {
> > +                                       k++;
> > +                                       break;
> > +                               }
> > +                       }
> > +
> >                         /* The traceID is our handle */
> >                         idx = metadata[j][CS_ETM_ETMTRACEIDR];
> > -                       i += CS_ETM_PRIV_MAX;
> > +                       i += k;
> >                 } else if (ptr[i] == __perf_cs_etmv4_magic) {
> >                         metadata[j] = zalloc(sizeof(*metadata[j]) *
> >                                              CS_ETMV4_PRIV_MAX);
> > @@ -2571,12 +2578,19 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >                                 err = -ENOMEM;
> >                                 goto err_free_metadata;
> >                         }
> > -                       for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
> > +                       for (k = 0; k < CS_ETMV4_PRIV_MAX; k++) {
> >                                 metadata[j][k] = ptr[i + k];
> >
> > +                               if (ptr[i + k + 1] == __perf_cs_etmv3_magic ||
> > +                                   ptr[i + k + 1] == __perf_cs_etmv4_magic) {
> > +                                       k++;
> > +                                       break;
> > +                               }
> > +                       }
> > +
> >                         /* The traceID is our handle */
> >                         idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
> > -                       i += CS_ETMV4_PRIV_MAX;
> > +                       i += k;
> >                 }
> >
> >                 /* Get an RB node for this CPU */
> 
> That would be a spot fix for the read /copy case, but will not fix the
> print routine which will still bail out on older versions of the
> format. (when using perf report --dump).
> 
> The "self describing" format I have been looking at will add an
> NR_PARAMS value to the common block in the CPU metadata parameter
> list, increment the header version to '1' and update the format writer
> to use the version 1 format while having the reader understand both v0
> and v1 formats.
> 
> i..e in cs-etm.h perf I add:
> /*
>  * Update the version for new format.
>  *
>  * New version 1 format adds a param count to the per cpu metadata.
>  * This allows easy adding of new metadata parameters.
>  * Requires that new params always added after current ones.
>  * Also allows client reader to handle file versions that are different by
>  * checking the number of params in the file vs the number expected.
>  */
> #define CS_HEADER_CURRENT_VERSION 1
> 
> /* Beginning of header common to both ETMv3 and V4 */
> enum {
>     CS_ETM_MAGIC,
>     CS_ETM_CPU,
>     CS_ETM_NR_PARAMS, /* number of parameters to follow in this block */
> };
> 
> where in verison 1, NR_PARAMS indicates the total number of params
> that follow - so adding new parameters can be added to the metadata
> enums and the tool will automatically adjust, and will handle v0
> files, plus older and newer files that have differing numbers of
> parameters, as long as the parameters are only ever added to the end
> of the list.
> 
> I have been working on a patch for this today, which took a little
> longer than expected as it was a little more complex than expected
> (the printing routines in for the --dump command!).
> 
> I will post this tomorrow when tested - and if we agree it works it
> could be rolled into your set - it would make adding the PID parameter
> easier, and ensure that this new format is available for the upcoming
> developments.

Thanks for the info.  I will look at your patch and see how to fit
with it.

Thanks,
Leo
