Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F992F409A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393580AbhAMAm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392075AbhAMABJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:01:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0450C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:00:22 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g10so12406wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYnj4NnyzqTvNCehtKs/v8kDWyWLhKI51guLq1aJcN4=;
        b=Z82XiMNCwjvMyzF90CrFOdLa9OmubulniKKsoLVb5YD/H0XmvgNux3qRomGBBF+m6f
         DmslgVCDJq8v6xk/akb3J4jZ8nrd0MM819t1mcIoVjV8URT9Eam8ZGCvUIK2nIxQTp/I
         05uhcuhqi4VbnFmkoVzOXUG0x0j8Vy3Dp2wjDuTzh7SonIv1KYbX8Q1+XBDs4oq+n/fS
         75mP0ZSW1ZFUmTAC7sifjdIswlnf4ofntGK3LKMyMJVINmR9r0302uB53VOyhuTV+Ymp
         LA5K+BbQA6ZQ3dHE42/bQPXDE+encNIvMAAfHsmb9GDN3LGMVPLehrOjsgmomFYANex0
         N8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYnj4NnyzqTvNCehtKs/v8kDWyWLhKI51guLq1aJcN4=;
        b=l4XaKl7WPlwYeGmzCcYQMeAk823eRgIp6K7TT+XHTJEFYr9El+dQvEHyrHGorDJdCf
         Vl0dNTzTNX1l1VEGW8n/jr3zs5cB3toiDhOuFyUi3Bc8aFdf5FzID8iBt5TyHHjJW7GK
         n41DqBJBrc+uvSCutQKYlU8dU8NO6WOIzV4QR56f9A8sveYhrrA88lP9TwPXPlPCq1Z/
         KO2YQ9v7UxyotoAT7bYl3D52kCn2iTaeK9D+vpTKyDN8wvCBs980gkRqmWVSOj9DjLuj
         Hu7HpL8vAlinVxmik3YePcvI4wLu9O2zWMMOhGZsOlUnABOwnDRxcKb8UICdRW3JZt+9
         Fygw==
X-Gm-Message-State: AOAM531vnhnK2Yktt7g3vlcaK+C7wyBwEFkL8bmaQs18bs4pPMyKxNXZ
        FiecX+jbcsIx4GrOQwUaMj4M7XNIxQL4khYicHYB0Q==
X-Google-Smtp-Source: ABdhPJyFhbmOfewRXGDUVYrH2KAfk7ljYzuMA8VOe6IjEkLqGn7TPd2cCmwq2/au0NhxWm7soPfgde2fOTHPzKU5iLw=
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr117084wmk.31.1610496021202;
 Tue, 12 Jan 2021 16:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20210109074435.626855-1-leo.yan@linaro.org> <20210109074435.626855-4-leo.yan@linaro.org>
 <96ec434e-4103-02ac-a05a-761a9ca8cb0d@arm.com> <CAJ9a7VjtUuRRYBBu63kSXKwrGdB8ZoWJz-bE1g9tMLSbkFVDGg@mail.gmail.com>
 <20210111150608.GC222747@leoy-ThinkPad-X240s>
In-Reply-To: <20210111150608.GC222747@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 13 Jan 2021 00:00:10 +0000
Message-ID: <CAJ9a7VjhMOq=r=W2xtjgiHhmvwk1xDzMnWF4hKPogX8PX+ZADg@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] perf cs-etm: Calculate per CPU metadata array size
To:     Leo Yan <leo.yan@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Mon, 11 Jan 2021 at 15:06, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mike,
>
> On Mon, Jan 11, 2021 at 12:09:12PM +0000, Mike Leach wrote:
> > Hi Leo,
> >
> > I think there is an issue here in that your modification assumes that
> > all cpus in the system are of the same ETM type. The original routine
> > allowed for differing ETM types, thus differing cpu ETM field lengths
> > between ETMv4 / ETMv3, the field size was used after the relevant
> > magic number for the cpu ETM was read.
> >
> > You have replaced two different sizes - with a single calculated size.
>
> Thanks for pointing out this.
>
> > Moving forwards we are seeing the newer FEAT_ETE protocol drivers
> > appearing on the list, which will ultimately need a new metadata
> > structure.
> >
> > We have had discussions within ARM regarding the changing of the
> > format to be more self describing - which should probably be opened
> > out to the CS mailing list.
>
> I think here have two options.  One option is I think we can use
> __perf_cs_etmv3_magic/__perf_cs_etmv4_magic as indicator for the
> starting of next metadata array; when copy the metadata, always check
> the next item in the buffer, if it's __perf_cs_etmv3_magic or
> __perf_cs_etmv4_magic, will break loop and start copying metadata
> array for next CPU.  The suggested change is pasted in below.
>
> Another option is I drop patches 03,05/07 in the series and leave the
> backward compatibility fixing for a saperate patch series with self
> describing method.  Especially, if you think the first option will
> introduce trouble for enabling self describing later, then I am happy
> to drop patches 03,05.
>
> How about you think for this?
>
> Thanks,
> Leo
>
> ---8<---
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index a2a369e2fbb6..edaec57362f0 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2558,12 +2558,19 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>                                 err = -ENOMEM;
>                                 goto err_free_metadata;
>                         }
> -                       for (k = 0; k < CS_ETM_PRIV_MAX; k++)
> +                       for (k = 0; k < CS_ETM_PRIV_MAX; k++) {
>                                 metadata[j][k] = ptr[i + k];
>
> +                               if (ptr[i + k + 1] == __perf_cs_etmv3_magic ||
> +                                   ptr[i + k + 1] == __perf_cs_etmv4_magic) {
> +                                       k++;
> +                                       break;
> +                               }
> +                       }
> +
>                         /* The traceID is our handle */
>                         idx = metadata[j][CS_ETM_ETMTRACEIDR];
> -                       i += CS_ETM_PRIV_MAX;
> +                       i += k;
>                 } else if (ptr[i] == __perf_cs_etmv4_magic) {
>                         metadata[j] = zalloc(sizeof(*metadata[j]) *
>                                              CS_ETMV4_PRIV_MAX);
> @@ -2571,12 +2578,19 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>                                 err = -ENOMEM;
>                                 goto err_free_metadata;
>                         }
> -                       for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
> +                       for (k = 0; k < CS_ETMV4_PRIV_MAX; k++) {
>                                 metadata[j][k] = ptr[i + k];
>
> +                               if (ptr[i + k + 1] == __perf_cs_etmv3_magic ||
> +                                   ptr[i + k + 1] == __perf_cs_etmv4_magic) {
> +                                       k++;
> +                                       break;
> +                               }
> +                       }
> +
>                         /* The traceID is our handle */
>                         idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
> -                       i += CS_ETMV4_PRIV_MAX;
> +                       i += k;
>                 }
>
>                 /* Get an RB node for this CPU */

That would be a spot fix for the read /copy case, but will not fix the
print routine which will still bail out on older versions of the
format. (when using perf report --dump).

The "self describing" format I have been looking at will add an
NR_PARAMS value to the common block in the CPU metadata parameter
list, increment the header version to '1' and update the format writer
to use the version 1 format while having the reader understand both v0
and v1 formats.

i..e in cs-etm.h perf I add:
/*
 * Update the version for new format.
 *
 * New version 1 format adds a param count to the per cpu metadata.
 * This allows easy adding of new metadata parameters.
 * Requires that new params always added after current ones.
 * Also allows client reader to handle file versions that are different by
 * checking the number of params in the file vs the number expected.
 */
#define CS_HEADER_CURRENT_VERSION 1

/* Beginning of header common to both ETMv3 and V4 */
enum {
    CS_ETM_MAGIC,
    CS_ETM_CPU,
    CS_ETM_NR_PARAMS, /* number of parameters to follow in this block */
};

where in verison 1, NR_PARAMS indicates the total number of params
that follow - so adding new parameters can be added to the metadata
enums and the tool will automatically adjust, and will handle v0
files, plus older and newer files that have differing numbers of
parameters, as long as the parameters are only ever added to the end
of the list.

I have been working on a patch for this today, which took a little
longer than expected as it was a little more complex than expected
(the printing routines in for the --dump command!).

I will post this tomorrow when tested - and if we agree it works it
could be rolled into your set - it would make adding the PID parameter
easier, and ensure that this new format is available for the upcoming
developments.

Regards


Mike


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
